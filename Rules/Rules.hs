
--
-- 3 Monadic Rules
--

--------------------- [ 1. return x >>= f x == f x ] ----------------------------------

incre :: Int -> Int
incre x = x + 1

increM :: Int -> Maybe Int
increM x = Just $ x + 1

-- ghci> (return 5 :: Maybe Int) >>= increM
-- Just 6
-- ghci> (return 5 :: Maybe Int) >>= \x -> Just $ incre x
-- Just 6
-- ghci> Just $ incre 5
-- Just 6
-- ghci> 

-- ghci> return 5 >>= (\val -> Just (val + 10))
-- Just 15
-- ghci> (\val -> Just (val + 10)) 5

---------------------[ 2. m >>= return == m ]------------------------------------------

-- ghci> Just 42 >>= return 
-- Just 42
-- ghci> 

---------------------[ 3. Associativity ]-----------------------------------------------

-- (m >>= f) >>= g == m >>= (\x -> f x >>= g)

increMN :: Int -> Maybe Int
increMN x = Just $ x + 1 + 1

-- ghci> ((return 5 :: Maybe Int) >>= increM) >>= increMN
-- Just 8
-- ghci> (return 5 :: Maybe Int) >>= (\x -> increM x >>= increMN)
-- Just 8
-- ghci> 