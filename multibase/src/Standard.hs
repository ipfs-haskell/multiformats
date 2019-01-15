module Standard where

import Multibase
import qualified ByteString as BS
import qualified Data.Word as W8
data Base = Base2 | Base16

fromBaseCode :: Base -> W8.Word8
fromBaseCode Base2 = W8._2
fromBaseCode Base16 = W8._F

toBaseCode :: W8.Word8 -> Base
toBaseCode W8._2 = Base2
toBaseCode W8._F = Base16
