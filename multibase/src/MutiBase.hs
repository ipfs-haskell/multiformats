-- Use signatures available in backpack and paramatrize over monad
module MultiBase
  ( multibase
  ) where

class MultiBase a where
  basePrefix :: a -> String
  prefixed :: a -> String
