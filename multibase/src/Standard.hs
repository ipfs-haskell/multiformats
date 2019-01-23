module Standard where

import Multibase
import qualified Data.ByteString as BS

data Base a = Base2 | Base16 | Other a

instance (Multibaseable a) => Multibaseable (Base a) where
  baseCode Base2 = BS.pack [50]
  baseCode Base16 = BS.pack [102]
  baseCode (Other a) = baseCode a

