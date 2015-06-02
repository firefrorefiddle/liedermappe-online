{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}
module LMO.TypeSet.LaTeX where

import Data.Text (Text, concat, lines, append, pack, unpack)
import Data.String (IsString)
import Prelude hiding (concat, lines)

import LMO.Common.Song
import SongMaker.Convert

newtype Prelude = Prelude Text deriving (Read, Show, Eq, IsString)
newtype SongHeader = SongHeader Text deriving (Read, Show, Eq, IsString)
newtype SongFooter = SongFooter Text deriving (Read, Show, Eq, IsString)

-- TODO: use rest of information
makeHeader :: Song -> SongHeader
makeHeader song = SongHeader $ "\\beginsong{ " `append` songTitle song `append` "}"

-- TODO: intersong material
makeFooter :: Song -> SongFooter
makeFooter _ = SongFooter $ "\\endsong"

latexVerses :: SongHeader -> SongFooter -> [Verse] -> Text
latexVerses (SongHeader header) (SongFooter footer) verses =
  concat $ [header] ++ concatMap latexVerse verses ++ [footer]

-- TODO: verseType
latexVerse :: Verse -> [Text]
latexVerse = (++[""]) . map pack . convertLines . map unpack . lines . verseLyrics

