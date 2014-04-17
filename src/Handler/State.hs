module Handler.State where

import Import

import Data.Acid
import Data.Acid.Remote

import Control.Monad.State
import Control.Monad.Reader
import Control.Applicative
import System.Environment
import System.IO
import System.Exit
import Network
import Data.SafeCopy.SafeCopy

import Data.Typeable

import qualified Data.Map as Map

------------------------------------------------------
-- The Haskell structure that we want to encapsulate

type Key = String
type Value = String

data KeyValue = KeyValue !(Map.Map Key Value)
    deriving (Typeable)

$(deriveSafeCopy 0 'base ''KeyValue)

getState :: Key -> Query KeyValue (Maybe Value)
getState key
    = do KeyValue m <- ask
         return (Map.lookup key m)