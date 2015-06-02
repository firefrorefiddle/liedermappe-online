module LMO.Common.Song where

import Data.Text (Text)
import Data.Digest.Pure.MD5 (MD5Digest)

import LMO.Common.User

data SongNumbering = Numbered | ChorusOnly | Unnumbered
                   deriving (Read, Show, Eq)

data VerseType = NormalVerse | Bridge | Chorus
                   deriving (Read, Show, Eq)
                            
data Verse = Verse
             { verseType :: VerseType
             , verseLyrics :: Text
             } deriving (Read, Show, Eq)             

data Song = Song
            { songId                :: Maybe Int
            , songTitle             :: Text
            , songRevision          :: Maybe MD5Digest
            , songUser              :: Maybe User
            , songAuthorLyrics      :: Maybe Text
            , songAuthorMusic       :: Maybe Text
            , songAuthorTranslation :: Maybe Text
            , songCopyright         :: Maybe Text
            , songScriptureRef      :: Maybe Text
            , songKey               :: Maybe Text
            , songNumbering         :: SongNumbering
            , songVerses            :: [Verse]
            } deriving (Show, Eq)

