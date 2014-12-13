{-# LANGUAGE ForeignFunctionInterface #-}

module Main where


import Control.Concurrent (MVar, takeMVar, newMVar)
import Foreign
import Foreign.C


type Callback = CInt -> IO ()


-- | rs_function function from Rust library
foreign import ccall "rs_function"
  rs_function :: Int -> IO ()


-- | Register a callback within the rust library via rs_register
foreign import ccall "rs_register"
  rs_register :: FunPtr Callback -> IO ()


-- | Create a callback wrapper to be called by the Rust library
foreign import ccall "wrapper"
  makeCallback :: Callback -> IO (FunPtr Callback)



callback :: MVar CInt -> CInt -> IO ()
callback mi i =   print (msg i)
              >>  takeMVar mi
              >>= print . statemsg
  where
    msg      = (++) "Haskell-callback invoked with value: " . show
    statemsg = (++) "    Haskell-callback carrying state: " . show



main :: IO ()
main = do

    rs_function 0

    st <- newMVar 42
    rs_register =<< makeCallback (callback st)

    rs_function 1

    putStrLn "Haskell main done"
