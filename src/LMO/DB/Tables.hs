{-# LANGUAGE OverloadedStrings #-}

module LMO.DB.Tables where

import Data.Text (Text, concat)
import Prelude hiding (concat)

data Table = Table
             { tableName    :: Text
             , tableCreate  :: Text }
           deriving (Read, Show, Eq)

table :: Text -> Text -> Table
table = Table

allTables :: [Table]
allTables =
  [ table "user" (concat [ "CREATE TABLE user"
                         , " (uid TEXT PRIMARY KEY"
                         , ", password TEXT NOT NULL)"
                         ])
  , table "song" (concat ["CREATE TABLE song"
                         , " (id            INTEGER PRIMARY KEY"
                         , ", revision      TEXT NOT NULL"
                         , ", user          TEXT "
                         , ", title         TEXT NOT NULL"
                         , ", author_lyrics TEXT "
                         , ", author_music  TEXT "
                         , ", author_trans  TEXT "
                         , ", copyright     TEXT "
                         , ", scripture_ref TEXT "
                         , ", key           TEXT "
                         , ", numbering     INTEGER "
                         , ", UNIQUE (id, revision)"
                         , ")"
                         ])
  , table "verse" (concat ["CREATE TABLE verse "
                          , " (song   INTEGER "
                          , ", ord    INTEGER "
                          , ", flags  INTEGER "
                          , ", lyrics TEXT "
                          , ", PRIMARY KEY (song, ord) "
                          , ")"
                          ])
  ]
                 
