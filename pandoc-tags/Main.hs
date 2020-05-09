{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Main where

import Control.Monad ((<=<))
import Control.Monad.Writer.Lazy
import Data.List (intersperse)
import Data.Text (Text)
import Text.Pandoc
import Text.Pandoc.Builder
import Text.Pandoc.Walk
import qualified Data.Map as M
import qualified Data.Text as T

type Tag      = Text
type Tags     = [Tag]
type TagMap   = M.Map Tag [FilePath]

type TagsM = WriterT TagMap IO

main :: IO ()
main = undefined

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
buildTagMap fp = M.fromList . fmap (\t -> (t, [fp]))

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
  . (:[]) . Div ("tag-links", ["tag-links"], []) 
  . (:[]) . Para 
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
