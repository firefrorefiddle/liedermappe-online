module LMO.Common.Error (warn, Error, ErrorT) where

import Debug.Trace
import Control.Monad.Error

warn = trace

