{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Text
import Happstack.Server

import LMO.DB.Init

main = do
       initDB "liedermappe.db"
       simpleHTTP nullConf $ ok ("Hi" :: Text)
