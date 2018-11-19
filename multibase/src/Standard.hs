module Standard where

import MultiBase

newtype Base2 =
  Base2 String

newtype Base10 =
  Base10 String

newtype Base16 =
  Base16 String

instance MultiBase Base2 where
  basePrefix (Base2 _) = "0"
  prefixed b@(Base2 str) = basePrefix b ++ str

instance Show Base2 where
  show = prefixed

instance MultiBase Base10 where
  basePrefix (Base10 _) = "9"
  prefixed b@(Base10 str) = basePrefix b ++ str

instance Show Base10 where
  show = prefixed

instance MultiBase Base16 where
  basePrefix (Base16 _) = "f"
  prefixed b@(Base16 str) = basePrefix b ++ str

instance Show Base16 where
  show = prefixed
