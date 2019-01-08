{-# LANGUAGE FlexibleInstances #-}



module MultiHash
  ( HashFuncType(..)
  , DigestLength(..)
  , DigestValue(..)
  , multiHash
  , MultiHash(..)
  ) where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Builder as BB
import qualified Data.ByteString.Lazy as BL

type AlgorithmCode = Int 
type Length = Int
type Digest = BS.ByteString

class (Eq a, Show a) =>
      MultiHash a
  where
  algorithmCode :: a -> AlgorithmCode 
  digest :: a -> Digest

hashBuilder :: (MultiHash a) => a -> BB.Builder
hashBuilder a = theCodeB <> theLengthB <> theDigestB
  where
  theCodeB = BB.word8 . fromIntegral $ algorithmCode a
  theDigest = digest a
  theLengthB = BB.word8 . fromIntegral $ BS.length theDigest
  theDigestB = BB.byteString theDigest

hash :: (MultiHash a) => a -> BL.ByteString
hash = toLazyByteString . hashBuilder
