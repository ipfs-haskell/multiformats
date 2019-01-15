{-# LANGUAGE FlexibleInstances #-}

module Multihash where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Builder as BB
import qualified Data.ByteString.Lazy as BL
import Data.Monoid ((<>))

data Multihash = Multihash AlgorithmCode Length Digest

type AlgorithmCode = Int 
type Length = Int
type Digest = BS.ByteString

class (Eq a, Show a) =>
      Multihashable a
  where
  algorithmCode :: a -> AlgorithmCode 
  digest :: a -> Digest

hashBuilder :: (Multihashable a) => a -> BB.Builder
hashBuilder a = theCodeB <> theLengthB <> theDigestB
  where
  theCodeB = BB.word8 . fromIntegral $ algorithmCode a
  theDigest = digest a
  theLengthB = BB.word8 . fromIntegral $ BS.length theDigest
  theDigestB = BB.byteString theDigest

encode :: (Multihashable a) => a -> BL.ByteString
encode = BB.toLazyByteString . hashBuilder

decode :: BL.ByteString -> Multihash 
decode b = Multihash theAlgorithmCode theLength theDigest
  where
  bStrict = BL.toStrict b
  theAlgorithmCode = fromIntegral $ BS.head bStrict 
  theLength = fromIntegral $ BS.head $ BS.tail bStrict
  theDigest = BS.tail $ BS.tail bStrict
