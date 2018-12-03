{-# LANGUAGE FlexibleInstances #-}


module MultiHash
  ( HashFuncType(..)
  , DigestLength(..)
  , DigestValue(..)
  , multiHash
  , MultiHash(..)
  ) where

import Control.Monad.Fail as MF
import qualified Str
import Data.Char (intToDigit)
import Data.Hex

newtype HashFuncType =
  HashFuncType Str.Str

newtype DigestLength =
  DigestLength Int

newtype DigestValue =
  DigestValue Str.Str

newtype MultiHashFormat =
  MultiHashFormat (HashFuncType, DigestLength, DigestValue)

class (Eq a, Show a) =>
      MultiHash a
  where
  hashCode :: a -> HashFuncType
  digestLength :: a -> DigestLength

multiHash ::
     (MultiHash t, MonadFail m) => t -> DigestLength -> m MultiHashFormat
multiHash h l = do
  let DigestLength i = l
  let DigestLength j = digestLength h
  if i <= j
    then return $ MultiHashFormat (hashCode h, l, DigestValue . Str.pack . show $ h)
    else MF.fail "i > j"

-- How to handle this error?
oneByteIntToHex i
  | i < 16 = ['0', intToDigit i]
  | otherwise = [intToDigit $ quot i 16, intToDigit $ rem i 16]

instance Show MultiHashFormat where
  show (MultiHashFormat (HashFuncType f, DigestLength l, DigestValue v)) =
    show $ Str.append f $ Str.append hexaL $ Str.takeByte l v
    where
      hexaL = Str.pack $ oneByteIntToHex l
