{-# LANGUAGE FlexibleInstances #-}

module RaazMultiHash
	(
		module MultiHash
	, 	module Raaz.Hash.Blake2
,module Raaz.Hash.Sha224
,module Raaz.Hash.Sha256
,module Raaz.Hash.Sha384
,module Raaz.Hash.Sha512) where

import MultiHash 
import Raaz.Hash.Blake2
import Raaz.Hash.Sha224
import Raaz.Hash.Sha256
import Raaz.Hash.Sha384
import Raaz.Hash.Sha512
import Data.ByteString.Char8 as BS

instance MultiHash BLAKE2b where
  hashCode _ = HashFuncType $ BS.pack "B207"
  digestLength _ = DigestLength 64
  digest x = DigestValue . BS.pack . show $ x

instance MultiHash SHA256 where
  hashCode _ = HashFuncType $ BS.pack "13"
  digestLength _ = DigestLength 32
  digest x = DigestValue . BS.pack . show $ x

instance MultiHash SHA224 where
  hashCode _ = HashFuncType $ BS.pack "17"
  digestLength _ = DigestLength 28 
  digest x = DigestValue . BS.pack . show $ x

instance MultiHash SHA384 where
  hashCode _ = HashFuncType $ BS.pack "15"
  digestLength _ = DigestLength 48 
  digest x = DigestValue . BS.pack . show $ x

instance MultiHash SHA512 where
  hashCode _ = HashFuncType $ BS.pack "12"
  digestLength _ = DigestLength 64 
  digest x = DigestValue . BS.pack . show $ x
