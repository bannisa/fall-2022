isOdd:: Int -> Bool
isOdd n = n `mod` 2 /= 0

isPerfectSquare::Int -> Bool
isPerfectSquare n
                    | n < 4 = False
                    | otherwise = ((floor (sqrt (fromIntegral n))) ^ 2) == n
                   
main:: IO()
main = do

        putStrLn "Enter a whole number"
       
        userInput <- getLine
       
        let userInt = read userInput :: Int      
       
        let oddOrPerfectStrs = [ if isOdd x && isPerfectSquare x then (show x) ++ " is odd and perfect" else if isOdd x then (show x) ++ " is odd" else (show x) ++ " perfect square"
                                                                | x <- [0..userInt-1], isOdd x || isPerfectSquare x]
        putStrLn ""
       
        mapM putStrLn oddOrPerfectStrs
       
        putStrLn "exiting"