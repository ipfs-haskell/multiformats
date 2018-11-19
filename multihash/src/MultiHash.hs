-- Use signatures available in backpack and paramatrize over monad
module MultiHash
  ( HashFuncType(..)
  , DigestLength(..)
  , DigestValue(..)
  , multiHash
  ) where

import Data.Hex

newtype HashFuncType =
  HashFuncType String

newtype DigestLength =
  DigestLength Int

newtype DigestValue =
  DigestValue String

newtype MultiHashFormat =
  MultiHashFormat (HashFuncType, DigestLength, DigestValue)

class (Eq a, Show a) =>
      MultiHash a
  where
  hashCode :: a -> HashFuncType
  digestLength :: a -> DigestLength

multiHash :: (MultiHash t) => t -> Maybe DigestLength -> Maybe MultiHashFormat
multiHash h Nothing =
  Just $ MultiHashFormat (hashCode h, digestLength h, DigestValue $ show h)
multiHash h (Just l)
  | i <= j = Just $ MultiHashFormat (hashCode h, l, DigestValue $ show h)
  | otherwise = Nothing
  where
    DigestLength i = l
    DigestLength j = digestLength h

instance Show MultiHashFormat where
  show (MultiHashFormat (HashFuncType f, DigestLength l, DigestValue v)) =
    f ++ hexaL ++ take l v
    where
      hexaL = hex $ show l
