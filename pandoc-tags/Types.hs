{-# LANGUAGE GADTs #-}
{-# LANGUAGE TemplateHaskell #-}

-- {-# LANGUAGE ScopedTypeVariables #-}
-- {-# LANGUAGE FlexibleContexts #-}
-- {-# LANGUAGE DataKinds #-}

module Types where

import Polysemy
import Text.Pandoc
import qualified Data.Map as M

--  data Zettel tm m a where
--    WritePandoc :: FilePath -> Pandoc -> Zettel tm m ()
--    ReadPandoc  :: FilePath -> Zettel tm m Pandoc
--    BuildTagMap :: [Tag] -> FilePath -> Zettel tm m tm
--    MakeOutPath :: Basename -> Zettel tm m FilePath
--  
--  type Basename = String
--  
--  type Tag = String
--  type Tags = [Tag]

-- makeSem ''Zettel

data Console m a where
  WriteLine :: String -> Console m ()
  ReadLine  :: Console m String

makeSem ''Console
