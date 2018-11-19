module RaazMultiHash where

import MultiHash 
import Raaz.Hash.Blake2
import Raaz.Hash.Sha224
import Raaz.Hash.Sha256
import Raaz.Hash.Sha384
import Raaz.Hash.Sha512

instance MultiHash BLAKE2b where
  hashCode = HashFuncType "B207"
  digestLength = DigestLength 64 

instance MultiHash SHA256 where
  hashCode = HashFuncType "13"
  digestLength = DigestLength 32 

instance MultiHash SHA224 where
  hashCode = HashFuncType "17"
  digestLength = DigestLength 28 

instance MultiHash SHA384 where
  hashCode = HashFuncType "15"
  digestLength = DigestLength 48 

instance MultiHash SHA512 where
  hashCode = HashFuncType "12"
  digestLength = DigestLength 64 
