module LMO.Import.SongMaker where

import SongMaker.Read.Header

import LMO.Common.Error
import LMO.Common.Song

import Control.Monad.Identity
import Control.Monad.Error
import Control.Applicative

import Data.Text (Text, pack, unpack)
import Data.List
import Data.Char

readSongMaker :: Text -> ErrorT String Identity Song
readSongMaker t =
  let s = unpack t
      header = readHeader s
      rest = skipHeader s
      rawVerses = filter ((nall isSpace) . concat) .
                  groupBy (\x y -> all  isSpace x && all  isSpace y ||
                                   nall isSpace x && nall isSpace y) $ rest                  
  in do
    title <- case lookup "title" header of
                 Just title -> return $ pack title
                 Nothing    -> throwError "song has no title on songmaker import"
    return $ 
      Song { songTitle             = title 
           , songId = Nothing
           , songRevision = Nothing
           , songUser = Nothing
           , songAuthorLyrics      = pack <$> lookup "lyricsBy" header
           , songAuthorMusic       = pack <$> lookup "musicBy" header
           , songAuthorTranslation = pack <$> lookup "translationBy" header
           , songCopyright         = pack <$> lookup "copyright" header
           , songScriptureRef      = pack <$> lookup "reference" header
           , songKey               = pack <$> lookup "key" header
           , songNumbering = case lookup "numbering" header of
                              Nothing -> Numbered
                              Just "numbered" -> Numbered
                              Just "chorus" -> ChorusOnly
                              Just "unnumbered" -> Unnumbered
                              Just other -> warn ("ignoring unknown numbering " ++ other) $
                                            Numbered
           , songVerses = map mkVerse rawVerses }
  where nall p = not . all p
        mkVerse v = undefined
