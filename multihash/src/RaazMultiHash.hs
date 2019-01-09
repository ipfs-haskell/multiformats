{-# LANGUAGE FlexibleInstances #-}

module RaazMultiHash where

import Data.ByteString.Char8 as BS
import MultiHash
import Raaz.Hash.Blake2
import Raaz.Hash.Sha224
import Raaz.Hash.Sha256
import Raaz.Hash.Sha384
import Raaz.Hash.Sha512

instance MultiHashable BLAKE2b where
  algorithmCode _ = 0x40
  digest = pack.show

instance MultiHashable SHA256 where
  algorithmCode _ = 0x12
  digest = pack.show

instance MultiHashable SHA224 where
  algorithmCode _ = 0x17
  digest = pack.show

instance MultiHashable SHA384 where
  algorithmCode _ = 0x15
  digest = pack.show

instance MultiHashable SHA512 where
  algorithmCode _ = 0x13
  digest = pack.show
