{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveTraversable #-}

module Main where

import Control.Monad ((<=<))
import Control.Monad.Writer.Lazy
import Data.List (intersperse)
import Data.Text (Text)
import Text.Pandoc
import Text.Pandoc.Builder
import Text.Pandoc.Walk
import Data.Map.Merge.Strict (merge, zipWithMatched, preserveMissing)
import qualified Data.Map as M
import qualified Data.Text as T

type Tag    = Text
type Tags   = [Tag]
type TagMap = TagMapM [FilePath]
type TagsM  = WriterT TagMap IO

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

main :: IO ()
main = undefined

runTagsM :: TagsM a -> IO (a, [Pandoc])
runTagsM = fmap (fmap buildPandocsFromTagMap) . runWriterT

buildPandocsFromTagMap :: TagMap -> [Pandoc]
buildPandocsFromTagMap = 
  M.foldMapWithKey (fmap pure . buildTagsPandoc)
  . unTagMapM 

buildTagsPandoc :: Tag -> [FilePath] -> Pandoc
buildTagsPandoc tag = 
  setTitle (str tag) . doc . bulletList . fmap mkFilePathPandoc

mkFilePathPandoc :: FilePath -> Blocks
mkFilePathPandoc fp = 
  let pFp = T.pack fp
  in plain $ maybe mempty (flip (link pFp) mempty) (filePathTitle pFp)

transformMarkdown :: ReaderOptions -> FilePath -> TagsM Pandoc
transformMarkdown ops fp = do
  (tags, newDoc) <- customPandocFilter <$> loadFileToPandoc ops fp
  tell $ buildTagMap fp tags
  return newDoc

loadFileToPandoc :: ReaderOptions -> FilePath -> TagsM Pandoc
loadFileToPandoc = undefined

buildTagMap :: FilePath -> Tags -> TagMap
buildTagMap fp = TagMapM . M.fromList . fmap (\t -> (t, [fp]))

customPandocFilter :: Pandoc -> (Tags, Pandoc)
customPandocFilter = fmap (walk changeMarkdownLink) . appendTagLinks

appendTagLinks :: Pandoc -> (Tags, Pandoc)
appendTagLinks p = 
  let t  = docTags p
      np = p <> mkTagLinks t
  in (t, np)

mkTagLinks :: Tags -> Pandoc
mkTagLinks = 
    Pandoc mempty 
  . pure . Div ("tag-links", ["tag-links"], []) 
  . pure . Para 
  . intersperse (Str ", ") 
  . fmap mkLink

mkLink :: Tag -> Inline
mkLink tagName = 
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

changeMarkdownLink :: Inline -> Inline
changeMarkdownLink (Link attr@(tl, _, _) ((Str _):[]) (url, mouseover))
  | (Just name) <- filePathTitle url 
  , "tag-link" <- tl
  = Link attr [(Str $ "(see " <> name <> ")")] ("./"<>name<>".html", mouseover)
changeMarkdownLink x = x

filePathTitle :: Text -> Maybe Text
filePathTitle = T.stripPrefix "./" <=< T.stripSuffix ".md"
