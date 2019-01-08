{-# LANGUAGE FlexibleInstances #-}

module MultiHash where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Builder as BB
import qualified Data.ByteString.Lazy as BL
import Data.Monoid ((<>))

data MultiHash = MultiHash 
  { algorithmCode :: AlgorithmCode
  , length :: Length
  , digest :: Digest
  }

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
  theAlgorithmCode = fromIntegral $ take 1 b 
  theLength = fromIntegral $ take 1 $ drop 1 b
  theDigest = drop 2 b
