import Prelude hiding (Maybe(..), maybe, (>>=), (>>), return)

data Maybe a = Nothing | Just a deriving (Show)

class Monadi m where
    (>>=)  :: m a -> (a -> m b) -> m b
    (>>)   :: m a -> m b -> m b
    return :: a -> m a
    -- f >> s = f >>= (\_ -> s)

instance Monadi Maybe where 
    -- >>= :: Maybe a -> (a -> Maybe b) -> Maybe b
    Just v   >>= f = f v
    Nothing  >>= _ = Nothing 

    -- >> :: Maybe a -> Maybe b -> Maybe b
    Just _ >>  v  = v
    Nothing >> _  = Nothing

    -- return :: a -> Maybe
    return = Just

-- ghci> Just 15 >>= (\x -> Just (x + 15)) >>= (\y -> Just (y + 12))
-- Just 42
-- ghci> Just 15 >>= (\x -> Just (x + 15) >>= (\y -> Just (y + 12)))
-- Just 42
-- ghci> 

maybe :: b -> (a -> b) -> Maybe a -> b
maybe d f (Just v) = f v
maybe d _ Nothing  = d

-- ghci> maybe "some error" (\x -> "ura " ++ show x) (Just 5)
-- "ura 5"
-- ghci> maybe "some error" (\x -> "ura " ++ show x) (Nothing)
-- "some error"
-- ghci> 