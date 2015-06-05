{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}
module LMO.Typeset.LaTeX where

import Data.Text (Text, concat, lines, append, pack, unpack)
import Data.String (IsString)
import Prelude hiding (concat, lines)
import Control.Applicative

import SongMaker (Song)
import qualified SongMaker as SM

newtype Prelude = Prelude Text deriving (Read, Show, Eq, IsString)

latexSong :: Song -> Text
latexSong = pack . SM.convertSong

typesetSong :: Prelude -> Song -> Text
typesetSong (Prelude p) s =
  concat [ p
         , "\\begin{songs}"
         , latexSong s
         , "\\end{songs}"
         ]

