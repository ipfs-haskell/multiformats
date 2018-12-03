module Main
  ( main
  ) where

import Data.ByteString.Char8 as BS
import RaazMultiHash

main :: IO ()
main = do
  print y1
  print y2
  print y3
  print y4

x = sha256 $ BS.pack "Adithya"

Just y1 = multiHash x $ DigestLength 2

Just y2 = multiHash x $ DigestLength 3

Just y3 = multiHash x $ DigestLength 10

Just y4 = multiHash x $ DigestLength 18
