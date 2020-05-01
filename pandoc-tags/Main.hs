{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad ((<=<))
import Data.Text (Text)
import Text.Pandoc.Builder
import Text.Pandoc.JSON
import Text.Pandoc.Walk
import qualified Data.Map as M
import qualified Data.Text as T

type Tag = Text
type Tags = [Tag]
type TagLink = Inline
type TagLinks = Block

main :: IO ()
main = toJSONFilter filterAndPrintTags

filterAndPrintTags :: Pandoc -> IO Pandoc
filterAndPrintTags doc@(Pandoc meta _) = do
  return $ walk changeMarkdownLink newDoc
  where
    (tags, newDoc) = appendTags doc

appendTags :: Pandoc -> (Tags, Pandoc)
appendTags pandoc = (tags, addTagLinks tagLinks pandoc)
  where 
    tagLinks = Div ("tag-links", ["tag-links"], []) $  Para . (:[]) . mkLink <$> tags
    tags = docTags pandoc

addTagLinks :: TagLinks -> Pandoc -> Pandoc
addTagLinks links (Pandoc meta doc) = Pandoc meta $ doc ++ [links]

mkLink :: Tag -> TagLink
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
changeMarkdownLink x@(Link attr ((Str _):[]) (url, mouseover))
  | (Just name) <- T.stripPrefix "./" <=< T.stripSuffix ".md" $ url 
  = Link attr [(Str $ "(see " <> name <> ")")] ("./"<>name<>".html", mouseover)
changeMarkdownLink x = x
