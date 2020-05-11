{-# LANGUAGE FlexibleContexts #-}

module FileIO 
( writeFileUTF8
, readFileUTF8
) where

import Data.Text (Text)
import Path
import Path.Text.UTF8
import Control.Monad.Catch
import Control.Monad.Error.Class
import Prelude hiding (writeFile, readFile)
import qualified Data.Text as T

type FPath = Path Rel File

writeFileUTF8 :: FilePath -> Text -> IO ()
writeFileUTF8 fp = writeFile fp . T.unpack

readFileUTF8 :: FilePath -> IO Text
readFileUTF8 = readFile 

parseFilePath :: (MonadError PathException m) => FilePath -> m FPath
parseFilePath = either throwError return . parseRelFile
