import Prelude hiding (Either(..), Maybe(..), either, maybe)

type Login = String
type Secret = String
type Password = String

type Error = String

data Maybe a = Nothing | Just a deriving (Show)
data Either a b = Left a | Right b deriving (Show)

checkLogin :: Password -> Bool
checkLogin p
    | p == "floppa" = True
    | otherwise = False

checkPassword :: Password -> Maybe Secret
checkPassword p
    | p == "1234" = Just "...your secret data..."
    | otherwise = Nothing

authN :: Login -> Password -> Either Error Secret
authN l p
    | not (checkLogin l) = Left "Incorrect login!"
    | otherwise = case checkPassword p of
            Just secret -> Right secret
            Nothing -> Left "Incorrect password!"
          
printResult :: Either Error Secret -> IO ()
printResult (Left err) = putStrLn $ "Error: " ++ err
printResult (Right secret) = putStrLn $ "Your secret: " ++ secret

main :: IO ()
main = do
    putStrLn "Enter login to get a secret: "
    login <- getLine
    putStrLn "Enter password to get a secret: "
    password <- getLine
    printResult $ authN login password