import Prelude hiding (Monad(..), (>>=), (>>), return, map, concat)

infixr 5 :!
infixr 5 +!

data List a = Nil | a :! (List a)

(+!) :: List a -> List a -> List a
Nil     +! ys = ys
(x:!xs) +! ys = x :! xs +! ys

list :: a -> List a
list x = x :! Nil

map :: (a -> b) -> List a -> List b
map _ Nil   = Nil
map f (x:!xs) = f x :! map f xs

concat :: List (List a) -> List a
concat Nil       = Nil
concat (xs:!xxs) = xs +! concat xxs 
 
-- ghci> list (list 1) +! list (1 :! 2 :! 3 :! 4 :! list 5)
-- ![![1]!, ![1, 2, 3, 4, 5]!]!
-- ghci> concat $ list (list 1) +! list (1 :! 2 :! 3 :! 4 :! list 5)
-- ![1, 1, 2, 3, 4, 5]!
-- ghci> 

instance (Show a) => Show (List a) where 
    show xxs = "![" ++ list xxs ++ "]!"
        where list Nil = ""
              list (x:!Nil) = show x
              list (x:!xs)  = show x ++ ", " ++ list xs 

class Monad m where 
    (>>=)  :: m a -> (a -> m b) -> m b
    (>>)   :: m a -> m b -> m b
    return :: a -> m a
    -- x >> y = x >>= \_ -> y 

instance Monad List where
    -- (>>=)  :: ![a]! -> (a -> ![b]!) -> ![b]!
    xs >>= f = concat $ map f xs 

    -- (>>)   :: ![a]! -> ![b]! -> ![b]!
    xs >> ys = xs >>= \_ -> ys

    -- return :: a -> ![a]!
    return = list

-- ghci> [1, 2] >>= \dice1 -> [10, 20] >>= \dice2 -> [dice1 + dice2]
-- [11,21,12,22]
-- ghci>

-- ghci> (1 :! list 2) >>= \dice1 -> (10 :! list 20) >>= \dice2 -> list (dice1 + dice2)
-- ![11, 21, 12, 22]!
-- ghci> 