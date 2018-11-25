{-# LANGUAGE FlexibleInstances #-}

module MultiHash
  ( HashFuncType(..)
  , DigestLength(..)
  , DigestValue(..)
  , multiHash
  , MultiHash(..)
  ) where

import Control.Monad.Fail as MF
import Data.ByteString.Char8 as BS
import Data.Hex
import Data.Char (intToDigit)

newtype HashFuncType =
  HashFuncType BS.ByteString

newtype DigestLength =
  DigestLength Int

newtype DigestValue =
  DigestValue BS.ByteString

newtype MultiHashFormat =
  MultiHashFormat (HashFuncType, DigestLength, DigestValue)

class (Eq a, Show a) =>
      MultiHash a
  where
  hashCode :: a -> HashFuncType
  digestLength :: a -> DigestLength
  digest :: a -> DigestValue

multiHash ::
     (MultiHash t, MonadFail m) => t -> m DigestLength -> m MultiHashFormat
multiHash h ml = do
  l <- ml
  let DigestLength i = l
  let DigestLength j = digestLength h
  if i <= j
    then return $ MultiHashFormat (hashCode h, l, digest h)
    else MF.fail "i > j"

-- How to handle this error?
oneByteIntToHex i
	| i < 16 = ['0', intToDigit i]
	| otherwise = [intToDigit $ quot i 16, intToDigit $ rem i 16]

instance Show MultiHashFormat where
  show (MultiHashFormat (HashFuncType f, DigestLength l, DigestValue v)) =
    show $ BS.append f $ BS.append hexaL $ BS.take (2 * l) v
    where
      hexaL = BS.pack $ oneByteIntToHex l
