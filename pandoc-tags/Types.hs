{-# LANGUAGE GADTs #-}
{-# LANGUAGE TemplateHaskell #-}

module Types where

import Polysemy
import Text.Pandoc
import Text.Pandoc.Builder
import qualified Data.Map as M

data Zettel m a where
  WritePandoc :: BaseName -> Pandoc -> Zettel m ()
  ReadPandoc  :: FilePath -> Zettel m Pandoc
  AddTags     :: [Tag] -> BaseName -> Zettel m ()
  GetTagInfos :: Zettel m [TagInfo]
  MakeLink    :: BaseName -> LinkName -> Zettel m Inlines

type LinkName = String
type BaseName = FilePath

type Tag = String

data TagInfo = TagInfo
  { tag         :: Tag
  , taggedFiles :: [FilePath]
  } deriving (Show)

makeSem ''Zettel
