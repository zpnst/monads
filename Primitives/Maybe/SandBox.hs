import Prelude hiding (Maybe(..), maybe)

type Secret = String
type Password = String

data Maybe a = Nothing | Just a deriving (Show)

checkPassword :: Password -> Maybe Secret
checkPassword p
    | p == "1234" = Just "...your secret data..."
    | otherwise = Nothing

printSecret :: Maybe Secret -> IO ()
printSecret Nothing = putStrLn "Incorrect password!"
printSecret (Just secret) = putStrLn $ "Your secret: " ++ secret

main :: IO ()
main = do
    putStrLn "Enter password to get a secret: "
    password <- getLine
    (printSecret . checkPassword) password