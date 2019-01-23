module Multibase where

import qualified Data.ByteString as BS

data MultibaseFormat a = MultibaseFormat a Value
type Value = BS.ByteString

createMultibaseFormat :: (Multibaseable a) => a -> Value -> MultibaseFormat a
createMultibaseFormat a v = MultibaseFormat a v

class Multibaseable a where
  baseCode :: a -> BS.ByteString

encode (MultibaseFormat a v) = BS.append (baseCode a) v

decode e = MultibaseFormat (BS.head e) (BS.tail e)
