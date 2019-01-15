module Multibase where

import qualified Data.ByteString as BS
import Data.Word8 (Word8)

data MutiBaseFormat = MultibaseFormat BaseCode Value
type BaseCode = Word8
type Value = BS.ByteString

encode = BS.cons 

decode b = MultibaseFormat w r
        where
          w = BS.head b
          r = BS.tail b

