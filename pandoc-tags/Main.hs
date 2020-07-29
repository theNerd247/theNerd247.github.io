{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveTraversable #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import Control.Arrow hiding (first)
import Control.Monad
import Control.Monad.IO.Class
import Data.Bifunctor (first)
import Data.Foldable
import Polysemy
import Polysemy.Error
import Polysemy.State
import System.Environment (getArgs)
import Tags
import Text.Pandoc
import Text.Pandoc.Builder
import Text.Pandoc.Readers
import Text.Pandoc.Writers
import Types
import qualified Data.Map as M
import qualified Data.Text as T
import qualified FileIO as F

main :: IO ()
main = 
  runM
  . handleErrors
  . runError
  . evalState mempty
  . (getSourceFiles >>= buildTagFiles)

handleErrors :: (MonadIO m, Member (Embed m) r) => Sem (Error String ': r) () -> Sem r ()
handleErrors = runError >=> either (embed . liftIO . putStrLn) return

getSourceFiles :: (MonadIO m, Member (Embed m) r) => Sem r [FilePath]
getSourceFiles = embed . liftIO $ getArgs

runZettel :: (MonadIO m, Members '[Error String, Embed m, State TagMap] r) => Sem (Zettel ': r) a -> Sem r a
runZettel = interpret $ \case
  WritePandoc b p -> runPandoc (writeHtml5String wOpts p) >>= F.writeFile (b <> ".html")
  ReadPandoc f    -> F.readFile f >>= runPandoc . readMarkdown rOpts
  AddTags ts b    -> put $ buildTagMap ts b
  GetTagInfos     -> gets fromTagMap
  MakeLink b n    -> return $ link b n mempty

rOpts :: ReaderOptions 
rOpts = def { readerStandalone = True, readerExtensions = pandocExtensions } 

wOpts :: WriterOptions
wOpts = def { writerSectionDivs = True }

runPandoc :: Member (Error String) r => PandocPure a -> Sem r a
runPandoc = fromEither . first show . runPure 

buildTagFiles :: (Members '[Zettel, Input [FilePath]] r) => Sem r () 
buildTagFiles = 
      input
  >>= processMarkdownFile 
  >>= const getTagInfos
  >>= traverse_ processTagFile

foldMapM :: (Monad m, Monoid w, Foldable t) => (a -> m w) -> t a -> m w
foldMapM f = foldM (\acc x -> (acc <>) <$> (f x)) mempty

processTagFile :: Member (Zettel) r => TagInfo -> Sem r () 
processTagFile TagInfo{..} = 
  buildTagsPandoc tag taggedFiles
  >>= writePandoc tag . customFilters

processMarkdownFile :: Member (Zettel) r => FilePath -> Sem r ()
processMarkdownFile fp = do
  doc <- readPandoc fp 
  let tags = getTags doc
  appendTags tags doc >>= writePandoc fp . customFilters 
  addTags tags fp 

customFilters :: Pandoc -> Pandoc
customFilters = id
