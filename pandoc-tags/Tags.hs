{-# LANGUAGE DeriveTraversable #-}

module Tags where

-- import Data.Map.Merge.Strict (merge, zipWithMatched, preserveMissing)

import Data.List (intersperse)
import Polysemy
import Text.Pandoc
import Text.Pandoc.Builder
import Types

-- import qualified Data.Map as M

-- newtype TagMapM a = TagMapM { unTagMapM :: M.Map Tag a }
--   deriving (Show, Functor, Foldable, Traversable)
-- 
-- instance (Semigroup v) => Semigroup (TagMapM v) where
--   (TagMapM m1) <> (TagMapM m2) = TagMapM $
--     merge 
--       preserveMissing 
--       preserveMissing
--       (zipWithMatched (const (<>)))
--       m1
--       m2
-- 
-- instance (Monoid v) => Monoid (TagMapM v) where
--   mempty = TagMapM mempty
-- 
-- type TagMap = TagMapM [FilePath]

appendTags :: Member (Zettel tm) r => Tags -> Pandoc -> Sem r Pandoc
appendTags t p = (p<>) <$> mkTagLinks t

mkTagLinks :: Member (Zettel tm) r => Tags -> Sem r Pandoc
mkTagLinks = 
    doc
  . div ("tag-links", ["tag-links"], []) 
  . pure . Para 
  . intersperse (str ", ") 
  <$> traverse makeLink

makeLink :: Member (Zettel tm) r => Tag -> Sem r Inline
makeLink = fmap mkLink <*> makeOutPath

getTags :: Pandoc -> Tags
getTags (Pandoc meta _)
  | Just (MetaList tags) <- lookupMeta "tags" meta = [str | (MetaInlines ((Str str):[])) <- tags]
  | otherwise = []

buildTagsPandoc :: Member (Zettel tm) r => Tag -> [FilePath] -> Sem r Pandoc
buildTagsPandoc tag = 
  setTitle (str tag) . doc . bulletList <$> traverse makeOutPath

mkLink :: FilePath -> Tag -> Inlines
mkLink tagName target = link tagName target mempty

-- buildTagMap :: FilePath -> Tags -> TagMap
-- buildTagMap fp = TagMapM . M.fromList . fmap (\t -> (t, [fp]))

