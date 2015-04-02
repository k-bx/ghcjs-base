{-# LANGUAGE ForeignFunctionInterface, JavaScriptFFI #-}

module JavaScript.Web.Worker ( Worker
                             , create
                             , postMessage
                             , terminate
                             ) where

import GHCJS.Prim
import Data.JSString

newtype Worker = Worker (JSRef ())

create :: JSString -> IO Worker
create script = js_create script
{-# INLINE create #-}

postMessage :: JSRef () -> Worker -> IO ()
postMessage msg w = js_postMessage msg w
{-# INLINE postMessage #-}

terminate :: Worker -> IO ()
terminate w = js_terminate w
{-# INLINE terminate #-}

-- -----------------------------------------------------------------------------

foreign import javascript unsafe 
  "new Worker($1)" js_create :: JSString -> IO Worker
foreign import javascript unsafe
  "$2.postMessage($1)" js_postMessage  :: JSRef () -> Worker -> IO ()
foreign import javascript unsafe
  "$1.terminate()" js_terminate :: Worker -> IO ()
