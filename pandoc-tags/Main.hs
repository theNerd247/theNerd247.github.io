{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveTraversable #-}

module Main where

import Control.Monad ((<=<))
import Control.Monad.IO.Class
import Control.Monad.Reader
import Control.Monad.Writer.Lazy
import Data.List (intersperse)
import Data.Map.Merge.Strict (merge, zipWithMatched, preserveMissing)
import Data.Text (Text)
import System.FilePath.Posix
import Text.Pandoc hiding (Writer)
import Text.Pandoc.Builder
import Text.Pandoc.Walk
import qualified Data.Map as M
import qualified Data.Text as T
import qualified Data.Text.IO as T

type Tag        = Text
type Tags       = [Tag]
type TagMap     = TagMapM [FilePath]
type TagsT m    = WriterT TagMap (ReaderT PandocState m)
type TagPandoc  = (Tag, Pandoc)

newtype TagMapM a = TagMapM { unTagMapM :: M.Map Tag a }
  deriving (Show, Functor, Foldable, Traversable)

instance (Semigroup v) => Semigroup (TagMapM v) where
  (TagMapM m1) <> (TagMapM m2) = TagMapM $
    merge 
      preserveMissing 
      preserveMissing
      (zipWithMatched (const (<>)))
      m1
      m2

instance (Monoid v) => Monoid (TagMapM v) where
  mempty = TagMapM mempty

data PandocState = PandocState
  { readerOpts :: ReaderOptions
  , writerOpts :: WriterOptions
  , outDir     :: FilePath
  } deriving Show

main :: IO ()
main = undefined
  -- traverse processSourceFile 
  -- runTagsT
  -- fmap walkWithFilters
  -- traverse_ writeTagFile

writeTagFile :: TagPandoc -> IO ()
writeTagFile = undefined
  -- determine output file type
  -- generate filepath from tag
  -- write pandoc to filepath

processSourceFile :: (PandocMonad m, MonadIO m) => FilePath -> TagsT m ()
processSourceFile fp = do
  ops <- asks readerOpts 
  (liftIO $ T.readFile fp) 
    >>= readMarkdown ops 
    >>= writePandoc fp . walkWithFilters 

writePandoc :: (PandocMonad m, MonadIO m) => FilePath -> Pandoc -> TagsT m ()
writePandoc sourceFp p = do
  fp <- mkOutPath sourceFp
  ops <- asks writerOpts 
  t <- writeHtml5String ops p 
  liftIO $ T.writeFile fp t

mkOutPath :: (Monad m) => FilePath -> TagsT m FilePath
mkOutPath sourceFp = 
   (</> ((takeBaseName sourceFp) <.> "html")) <$> (asks outDir)

walkWithFilters :: Pandoc -> Pandoc
walkWithFilters = walk mdLinkToHtml

runTagsT :: (Monad m) => PandocState -> TagsT m a -> m (a, [TagPandoc])
runTagsT r = fmap (fmap buildPandocsFromTagMap) . flip runReaderT r  . runWriterT

buildPandocsFromTagMap :: TagMap -> [TagPandoc]
buildPandocsFromTagMap = 
    M.foldMapWithKey (\t fps -> pure (t, buildTagsPandoc t fps))
  . unTagMapM 

buildTagsPandoc :: Tag -> [FilePath] -> Pandoc
buildTagsPandoc tag = 
  setTitle (str tag) . doc . bulletList . fmap mkFilePathPandoc

mkFilePathPandoc :: FilePath -> Blocks
mkFilePathPandoc fp = 
  let pFp = T.pack fp
  in plain $ maybe mempty (flip (link pFp) mempty) (filePathTitle pFp)

extractAndAppendTags :: (Monad m) => FilePath -> Pandoc -> TagsT m Pandoc
extractAndAppendTags fp = do
  writer . fmap (buildTagMap fp) . appendTagLinks

buildTagMap :: FilePath -> Tags -> TagMap
buildTagMap fp = TagMapM . M.fromList . fmap (\t -> (t, [fp]))

appendTagLinks :: Pandoc -> (Pandoc, Tags)
appendTagLinks p = 
  let t  = docTags p
      np = p <> mkTagLinks t
  in (np, t)

mkTagLinks :: Tags -> Pandoc
mkTagLinks = 
    Pandoc mempty 
  . pure . Div ("tag-links", ["tag-links"], []) 
  . pure . Para 
  . intersperse (Str ", ") 
  . fmap mkTagLink

mkTagLink :: Tag -> Inline
mkTagLink tagName = 
  Link 
  ("tag-link", ["tag-link"], [])
  [Str tagName]
  ("./" <> tagName <> ".md", tagName)

docTags :: Pandoc -> Tags
docTags (Pandoc meta _) = getTags meta

getTags :: Meta -> Tags
getTags meta
  | Just (MetaList tags) <- lookupMeta "tags" meta = [str | (MetaInlines ((Str str):[])) <- tags]
  | otherwise = []

mdLinkToHtml :: Inline -> Inline
mdLinkToHtml (Link attr@(tl, _, _) ((Str _):[]) (url, mouseover))
  | (Just name) <- filePathTitle url 
  , "tag-link" <- tl
  = Link attr [(Str $ "(see " <> name <> ")")] ("./"<>name<>".html", mouseover)
mdLinkToHtml x = x

filePathTitle :: Text -> Maybe Text
filePathTitle = T.stripPrefix "./" <=< T.stripSuffix ".md"
