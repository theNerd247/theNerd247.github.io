{-# LANGUAGE FlexibleContexts #-}

module FileIO 
( readFile
, writeFile
) where

import Control.Monad
import Control.Monad.IO.Class
import Data.Bifunctor
import Data.Text (Text)
import Polysemy
import Polysemy.Error
import Prelude hiding (readFile, writeFile)
import qualified Data.Text as T
import qualified Path.Text.UTF8 as P

readFile :: (MonadIO m, Members '[Embed m, Error String] r) => FilePath -> Sem r Text
readFile = withFp P.readFile 

writeFile :: (MonadIO m, Members '[Embed m, Error String] r) => FilePath -> Text -> Sem r ()
writeFile fp t = withFp (flip P.writeFile t) fp

-- withFp :: (MonadIO m, Members '[Embed m, Error String] r) => (Path Rel File -> IO a) -> FilePath -> Sem r a
withFp f =
    fromEither
  . first show
  . P.parseRelFile
  >=> embed
  . liftIO
  . f


