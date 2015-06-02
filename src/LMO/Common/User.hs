{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module LMO.Common.User where

import Data.Text
import Data.String

newtype User = User Text deriving (Read, Show, Eq, IsString)
