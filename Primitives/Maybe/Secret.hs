import Prelude hiding (Maybe(..), maybe, (>>=), (>>), return)

type Secret = String

data Maybe a = Nothing | Just a deriving (Show)

checkPassword :: String -> Maybe Secret
checkPassword p
    | p == "1234" = Just "SECRET"
    | otherwise = Nothing

printSecret :: Maybe Secret -> IO ()
printSecret Nothing = putStrLn "Incorret password!"
printSecret (Just secret) = putStrLn $ "Your secret: " ++ secret

main :: IO ()
main = do
    putStrLn "Enter password to get a secret: "
    some <- getLine
    (printSecret . checkPassword) some