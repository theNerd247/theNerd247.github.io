{-# LANGUAGE DeriveTraversable #-}

module Tags where

import Data.List (intersperse)
import Data.Map.Merge.Strict (merge, zipWithMatched, preserveMissing)
import Data.Traversable
import Polysemy
import Text.Pandoc
import Text.Pandoc.Builder
import Types
import qualified Data.Map as M

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

type TagMap = TagMapM [FilePath]

buildTagMap :: [Tag] -> FilePath -> TagMap
buildTagMap ts fp = TagMapM . M.fromList . fmap (\t -> (t, [fp])) $ ts

fromTagMap :: TagMap -> [TagInfo]
fromTagMap = fmap (uncurry TagInfo) . M.toList . unTagMapM

appendTags :: Member Zettel r => [Tag] -> Pandoc -> Sem r Pandoc
appendTags t p = (p<>) <$> mkTagLinks t

mkTagLinks :: Member Zettel r => [Tag] -> Sem r Pandoc
mkTagLinks = 
  fmap
    ( doc
    . para
    . mconcat
    . intersperse (str ", ") 
    )
  . traverse makeTagLink 
  

makeTagLink :: Member Zettel r => Tag -> Sem r Inlines
makeTagLink t = makeLink t t

getTags :: Pandoc -> [Tag]
getTags (Pandoc meta _)
  | Just (MetaList tags) <- lookupMeta "tags" meta = [str | (MetaInlines ((Str str):[])) <- tags]
  | otherwise = []

buildTagsPandoc :: Member Zettel r => Tag -> [FilePath] -> Sem r Pandoc
buildTagsPandoc tag =
  fmap 
    ( setTitle (str tag) 
    . doc 
    . bulletList 
    . fmap plain
    )
  . traverse (makeLink tag)
