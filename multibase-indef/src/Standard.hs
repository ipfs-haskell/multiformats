module Standard where

import MultiBase
import qualified Str

newtype Base2 =
  Base2 Str.Str

newtype Base10 =
  Base10 Str.Str

newtype Base16 =
  Base16 Str.Str

instance MultiBase Base2 where
  basePrefix (Base2 _) = Str.pack "0"
  prefixed b@(Base2 str) = Str.append (basePrefix b) str

instance Show Base2 where
  show = prefixed

instance MultiBase Base10 where
  basePrefix (Base10 _) = Str.pack "9"
  prefixed b@(Base10 str) = Str.append (basePrefix b) str

instance Show Base10 where
  show = prefixed

instance MultiBase Base16 where
  basePrefix (Base16 _) = Str.pack "f"
  prefixed b@(Base16 str) = Str.append (basePrefix b) str

instance Show Base16 where
  show = prefixed
