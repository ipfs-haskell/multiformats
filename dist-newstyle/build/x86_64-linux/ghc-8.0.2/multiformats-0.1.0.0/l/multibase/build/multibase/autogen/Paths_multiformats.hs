{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_multiformats (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/adithya/.cabal/bin"
libdir     = "/home/adithya/.cabal/lib/x86_64-linux-ghc-8.0.2/multiformats-0.1.0.0-inplace-multibase"
dynlibdir  = "/home/adithya/.cabal/lib/x86_64-linux-ghc-8.0.2"
datadir    = "/home/adithya/.cabal/share/x86_64-linux-ghc-8.0.2/multiformats-0.1.0.0"
libexecdir = "/home/adithya/.cabal/libexec/x86_64-linux-ghc-8.0.2/multiformats-0.1.0.0"
sysconfdir = "/home/adithya/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "multiformats_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "multiformats_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "multiformats_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "multiformats_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "multiformats_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "multiformats_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
