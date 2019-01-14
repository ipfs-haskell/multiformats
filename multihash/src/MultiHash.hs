{-# LANGUAGE FlexibleInstances #-}

module MultiHash where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Builder as BB
import qualified Data.ByteString.Lazy as BL
import Data.Monoid ((<>))

data MultiHash = MultiHash AlgorithmCode Length Digest

type AlgorithmCode = Int 
type Length = Int
type Digest = BS.ByteString

class (Eq a, Show a) =>
      MultiHashable a
  where
  algorithmCode :: a -> AlgorithmCode 
  digest :: a -> Digest

hashBuilder :: (MultiHashable a) => a -> BB.Builder
hashBuilder a = theCodeB <> theLengthB <> theDigestB
  where
  theCodeB = BB.word8 . fromIntegral $ algorithmCode a
  theDigest = digest a
  theLengthB = BB.word8 . fromIntegral $ BS.length theDigest
  theDigestB = BB.byteString theDigest

encode :: (MultiHashable a) => a -> BL.ByteString
encode = BB.toLazyByteString . hashBuilder

decode :: BL.ByteString -> MultiHash 
decode b = MultiHash theAlgorithmCode theLength theDigest
  where
  bStrict = BL.toStrict b
  theAlgorithmCode = fromIntegral $ BS.head bStrict 
  theLength = fromIntegral $ BS.head $ BS.tail bStrict
  theDigest = BS.tail $ BS.tail bStrict
