-- Use signatures available in backpack and paramatrize over monad
module MultiBase where
import qualified Str

class MultiBase a where
  basePrefix :: a -> Str.Str
  prefixed :: a -> Str.Str
