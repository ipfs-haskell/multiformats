{-# LANGUAGE FlexibleInstances #-}

module RaazMultihash where

import Data.ByteString.Char8 as BS
import Multihash
import Raaz.Hash.Blake2
import Raaz.Hash.Sha224
import Raaz.Hash.Sha256
import Raaz.Hash.Sha384
import Raaz.Hash.Sha512

instance Multihashable BLAKE2b where
  algorithmCode _ = 0x40
  digest = (BS.pack).show

instance Multihashable SHA256 where
  algorithmCode _ = 0x12
  digest = (BS.pack).show

instance Multihashable SHA224 where
  algorithmCode _ = 0x17
  digest = (BS.pack).show

instance Multihashable SHA384 where
  algorithmCode _ = 0x15
  digest = (BS.pack).show

instance Multihashable SHA512 where
  algorithmCode _ = 0x13
  digest = (BS.pack).show
