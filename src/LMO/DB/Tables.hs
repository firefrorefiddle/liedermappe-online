{-# LANGUAGE OverloadedStrings #-}

module LMO.DB.Tables where

import Data.Text (Text, append)

data Table = Table
             { tableName    :: Text
             , tableCreate  :: Text }
           deriving (Read, Show, Eq)

table :: Text -> Text -> Table
table = Table

allTables :: [Table]
allTables =
  [ table "song" ("CREATE TABLE song"        `append`
                  " (id            INTEGER PRIMARY KEY" `append`
                  ", name          TEXT "    `append`
                  ", author_lyrics TEXT "    `append`
                  ", author_music  TEXT "    `append`
                  ", author_trans  TEXT "    `append`
                  ", scripture_ref TEXT "    `append`
                  ", key           TEXT "    `append`
                  ", numbering     INTEGER " `append`
                  ")")
  , table "verse" ("CREATE TABLE verse " `append`
                   " (song   INTEGER "   `append`
                   ", ord    INTEGER "   `append`
                   ", flags  INTEGER "   `append`
                   ", lyrics TEXT "      `append`
                   ", PRIMARY KEY (song, ord) " `append`
                   ")")
  ]
                 
