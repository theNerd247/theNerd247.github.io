{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveTraversable #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import Control.Arrow
import Polysemy
import Tags
import Data.Foldable
import Control.Monad
import qualified Data.Map as M
import qualified Data.Text as T

data Zettel tm m a where
  WritePandoc     :: Name -> Pandoc -> Zettel tm m ()
  ReadPandoc      :: FilePath -> Zettel tm m Pandoc
  BuildTagMap     :: [Tag] -> FilePath -> Zettel tm m tm

type TagFps = (Tag, [FilePath])

makeSem ''Zettel

buildTagFiles :: (tm ~ w TagFps, Member (Zettel tm) r,  Foldable t, Monoid tm, Foldable w) => t FilePath -> Sem r () 
buildTagFiles = 
  foldMapM processMarkdownFile 
  >>= traverse_ (uncurry processTagFile)

foldMapM :: (Monad m, Monoid w, Foldable t) => (a -> m w) -> t a -> m w
foldMapM f = foldM (\acc x -> (acc <>) <$> (f x)) mempty

processTagFile :: Member (Zettel tm) r => Tag -> [FilePath] -> Sem r () 
processTagFile tag = writePandoc tag . customFilters . buildTagsPandoc tag

processMarkdownFile :: Member (Zettel tm) r => FilePath -> Sem r tm
processMarkdownFile fp = do
  doc <- readPandoc fp 
  let 
    tags    = getTags doc
    newDoc  = customFilters $ appendTags tags doc
  writePandoc fp newDoc 
  buildTagMap tags fp 

customFilters :: Pandoc -> Pandoc
customFilters = undefined
