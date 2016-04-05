#!/usr/bin/env runhaskell

import           Control.Applicative           ((<$>))
import           Control.Monad                 (when)
import           Data.Map                      (Map)
import qualified Data.Map                      as M
import           Data.Maybe                    (fromJust)
import           System.Environment
import           Text.ParserCombinators.Parsec

import           DBus.Notify

-- set up the data structure for song info --------------
data Conf = Conf (Map String String)

instance Show Conf where
    show m = song m ++ ": " ++
             artist m
---------------------------------------------------------

-- the parser -------------------------------------------
splitEq :: Parser (String, String)
splitEq = do
    l <- many1 (noneOf "=")
    _ <- spaces >> char '=' >> spaces
    r <- manyTill anyChar newline
    return (l,r)

toConf :: [(String, String)] -> Conf
toConf = Conf . foldr (uncurry M.insert) M.empty

conf :: Parser Conf
conf =  toConf <$> many1 splitEq
--------------------------------------------------------

-- get relevent info out of the song info --------------
song :: Conf -> String
song c = getAttrib c "title"

artist :: Conf -> String
artist c = getAttrib c "artist"

getAttrib :: Conf -> String -> String
getAttrib (Conf c) s = fromJust $ M.lookup s c

parseEvent :: String -> Conf
parseEvent s = case parse conf "failed to parse event" s of
    Left e -> error $ show e
    Right c -> c
--------------------------------------------------------


mkNote :: Conf -> Note
mkNote c = blankNote { appName = "Pianobot"
                     , summary = song c
                     , body = (Just $ Text $ artist c) }

main :: IO ()
main = do
    let file = "/home/jharder/pianosong"

    (event:_) <- getArgs
    -- TODO: get keys songPlayed and songDuration
    when (event == "songstart") $ do
        contents <- getContents -- pianobar eventcmd writes to stdout
        -- so we read the contents of stdout to get song information
        client <- connectSession -- connect to DBus to make notification
        let conf = parseEvent contents
            note = mkNote conf
        notify client note >> return ()
        writeFile file $ show conf
