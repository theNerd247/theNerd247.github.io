{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveTraversable #-}

module Main where

import Control.Arrow ((***))
import Control.Monad ((<=<))
import Control.Monad.IO.Class
import Control.Monad.Reader
import Control.Monad.Writer.Lazy
import Data.Foldable (traverse_)
import Data.List (intersperse)
import Data.Encoding (decodeString, encodeString)
import Data.Encoding.UTF8 (UTF8(..))
import Data.Map.Merge.Strict (merge, zipWithMatched, preserveMissing)
import Data.Text (Text)
import System.Environment
import System.FilePath.Posix
import Text.Pandoc hiding (Writer, readMarkdown)
import Text.Pandoc.Builder
import Text.Pandoc.Readers.Markdown
import Text.Pandoc.Walk
import qualified Data.List as L
import qualified Data.Map as M
import qualified Data.Text as T
import qualified Data.Text.IO as T

type Tag        = String
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
main = runIO d >>= either (putStrLn . show) return
  where
    d = liftIO getArgs
      >>= execTagsT initPandocState . traverse processSourceFile
      >>= execTagsT initPandocState . traverse_ processTagFile 
      >>  return ()

initPandocState :: PandocState
initPandocState = PandocState
  { readerOpts = def { readerStandalone = True, readerExtensions = pandocExtensions }
  , writerOpts = def { writerSectionDivs = True }
  , outDir     = "./html"
  }

processTagFile :: (PandocMonad m, MonadIO m) => TagPandoc -> TagsT m ()
processTagFile = uncurry writePandoc . (id *** walkWithFilters)

processSourceFile :: (PandocMonad m, MonadIO m) => FilePath -> TagsT m ()
processSourceFile fp = do
  ops <- asks readerOpts 
  (liftIO $ readFileUTF8 fp) 
    >>= readMarkdown ops 
    >>= extractAndAppendTags fp . walkWithFilters 
    >>= writePandoc fp 

readFileUTF8 :: FilePath -> IO Text
readFileUTF8 = fmap (T.pack . decodeString UTF8) . readFile 

writePandoc :: (PandocMonad m, MonadIO m) => FilePath -> Pandoc -> TagsT m ()
writePandoc sourceFp p = do
  fp <- mkOutPath sourceFp
  ops <- asks writerOpts 
  t <- writeHtml5String ops p 
  liftIO $ writeFileUTF8 fp t

writeFileUTF8 :: FilePath -> Text -> IO ()
writeFileUTF8 fp = writeFile fp . encodeString UTF8 . T.unpack

mkOutPath :: (Monad m) => FilePath -> TagsT m FilePath
mkOutPath sourceFp = 
   (</> ((takeBaseName sourceFp) <.> "html")) <$> (asks outDir)

walkWithFilters :: Pandoc -> Pandoc
walkWithFilters = walk mdLinkToHtml

execTagsT :: (Monad m) => PandocState -> TagsT m a -> m [TagPandoc]
execTagsT r = fmap snd . runTagsT r

runTagsT :: (Monad m) => PandocState -> TagsT m a -> m (a, [TagPandoc])
runTagsT r = 
  fmap (fmap buildPandocsFromTagMap) 
  . flip runReaderT r 
  . runWriterT

buildPandocsFromTagMap :: TagMap -> [TagPandoc]
buildPandocsFromTagMap = 
    M.foldMapWithKey (\t fps -> pure (t, buildTagsPandoc t fps))
  . unTagMapM 

buildTagsPandoc :: Tag -> [FilePath] -> Pandoc
buildTagsPandoc tag = 
  setTitle (str tag) . doc . bulletList . fmap mkFilePathPandoc

mkFilePathPandoc :: FilePath -> Blocks
mkFilePathPandoc fp = plain $ link fp (takeBaseName fp) mempty

extractAndAppendTags :: (Monad m) => FilePath -> Pandoc -> TagsT m Pandoc
extractAndAppendTags fp = writer . fmap (buildTagMap fp) . appendTagLinks 

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
  | tl /= "tag-link" 
  = let name = takeBaseName url 
    in Link attr [(Str $ "(see " <> name <> ")")] ("./"<>name<>".html", mouseover)
mdLinkToHtml x = x
