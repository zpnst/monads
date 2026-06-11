newtype RealWorld = RealWorld

newtype IO a = RealWorld -> (a, RealWorld)

{-

IO a -> (a -> IO b) -> IO b

is

RealWorld -> (a, RealWorld) -> (a -> RealWorld -> (b, RealWorld)) -> RealWorld -> (b, RealWorld)

so if we uncurry function with this type (a -> RealWorld -> (b, RealWorld)), we will recieve
    ((a, RealWorld) -> (b, RealWorld)) and the imput of this function will be the output of the
    first RealWorld Transformer, so we can compose them! and return lambda that waits for the first
    initial state of the RealWorld!

-}

>>= :: IO a -> (a -> IO b) -> IO b
rwt >>= foo = uncurry foo . rwt

>> :: IO a -> IO b -> IO b
rwt1 >> rwt2 = rwt1 >>= \_ -> rwt2

return :: a -> IO a
return x = \w -> (a, w)

{-

Монада IO которая опустив #State директивы выглядит как 
newtype IO a = RealWorld -> (RealWorld, a) нужна для:  
  
1) Чтобы компилятор не оптимизировал вызовы функций в 
    констаны так как Haskell чистый язык обладающий ссылочной 
    прозрачностью и там так МОЖНО и НУЖНО  
  
2) Чтобы гарантировать порядок 
    выполнения операций через bind >>= через протаскивание RealWorld  

-}