import Prelude hiding (Either(..), either, (>>=), (>>), return)

data Either a b = Left a | Right b deriving (Show)

class Monadi m where 
    (>>=)  :: m a -> (a -> m b) -> m b
    (>>)   :: m a -> m b -> m b
    return :: a -> m a
    -- f >> s = f >>= (\_ -> s)

instance Monadi (Either e) where 
    -- >>= :: Either e a -> (a -> Either e b) -> Either e b
    Left err >>= _ = Left err
    Right v >>= f = f v

    -- >> :: Either e a -> Either e b -> Either e b
    Left err >> _ = Left err
    Right _ >> s = s

    -- return :: a -> Either e a
    return = Right

-- ghci> Right 10 >>= \x -> Left "some error" >>= \y -> Right (y + 5)
-- Left "some error"
-- ghci> Right 10 >>= \x -> Right (x + 42) >>= \y -> Right (y + 5)
-- Right 57
-- ghci> 

either :: (a -> c) -> (b -> c) -> Either a b -> c
either _ o (Right val) = o val
either e _ (Left err) =  e err

-- ghci> either (\err -> "ошибка" ++ show err) (\ok -> "ok: " ++ show ok) (Right 5)
-- "ok: 5"
-- ghci> either (\err -> "error: " ++ show err) (\ok -> "ok: " ++ show ok) (Left 42)
-- "error: 42"
-- ghci> 