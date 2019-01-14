-- Use signatures available in backpack and paramatrize over monad
module MultiBase where

import qualified Data.ByteString as BS
import Data.Word (Word8)

data MutiBaseFormat = MultiBaseFormat Base Value
type Base = Word8
type Value = BS.ByteString

class MultiBaseable a where
  prefix :: a -> Word8

encode = BS.cons 

decode b = MultiBaseFormat w r
        where
          w = BS.head b
          r = BS.tail b

