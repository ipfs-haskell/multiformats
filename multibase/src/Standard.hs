module Standard where

import Multibase
import qualified Data.ByteString as BS

data Base a = Base2 | Base16 | Other a

instance (Multibaseable a) => Multibaseable (Base a) where
  baseCode Base2 = BS.pack [50]
  baseCode Base16 = BS.pack [102]
  baseCode (Other a) = baseCode a

toBaseTypeStandard :: Maybe (BS.ByteString -> Base a) -> BS.ByteString -> Maybe (Base a)
toBaseTypeStandard mf b
  | b == BS.pack [50] = Just Base2
  | b == BS.pack [102] = Just Base16
  | otherwise = do
      f <- mf
      Just $ f b 
