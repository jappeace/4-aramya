module Main where

import Foreign.C.String
import Control.Monad(forever)

foreign import javascript "((arr,offset) => document.body.innerHTML = h$decodeUtf8z(arr,offset))"
  createDocument :: CString -> IO ()

foreign import javascript "((arr,offset) => document.getElementById('out').innerHTML = h$decodeUtf8z(arr,offset))"
  setInnerHtml :: CString -> IO ()

foreign import javascript "(() => h$encodeUtf8(document.getElementById('uwu').value))"
  getBoxValue :: IO CString

circle :: String
circle = "<input type=text id='uwu'/><div id='out'></div>"

main :: IO ()
main = do
  withCString circle createDocument
  forever $ do
    out <- peekCString =<< getBoxValue
    withCString out setInnerHtml
