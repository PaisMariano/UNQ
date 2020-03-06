module OutputErrorMonad where

import Monadas

data EstructuraDeMariano a = Throw String | Ok (a, String)
     deriving Show
    
instance Monad EstructuraDeMariano where
  return x = Ok (x, "")
  m >>= k  = case m of
               Throw s -> Throw s
               Ok (res, msg)    ->
                    case k res of 
                        Throw s -> Throw s 
                        Ok (res', msg') -> Ok (res', msg ++ msg')
  fail msg = Throw msg
    
instance ErrorMonad EstructuraDeMariano where
  throw msg = Throw msg

instance PrintMonad EstructuraDeMariano where
  printf msg = Ok ((), msg ++ "\n")
