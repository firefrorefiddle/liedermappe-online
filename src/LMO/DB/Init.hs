{-# LANGUAGE OverloadedStrings #-}

module LMO.DB.Init where

import Data.Text (Text, append)
import Database.SQLite3
import Control.Monad (mapM_)

import LMO.DB.Tables

initDB :: Text -> IO Database
initDB fp = do
  db <- open fp
  mapM_ (ensureTable db) allTables
  return db

ensureTable :: Database -> Table -> IO ()
ensureTable db table = do
  stmt <- prepare db $
          "SELECT 1 FROM sqlite_master " `append`
          " WHERE name = ? " `append`
          " AND type='table'"
  bind stmt [SQLText $ tableName table]
  res <- step stmt
  finalize stmt
  case res of
   Row -> return ()
   Done -> exec db (tableCreate table)
