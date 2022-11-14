-- This is a Haskell program that displays all numbers below a number
-- provided by the user that are either prime or even


-- The first functions in the list are pure (For given input values  we always
-- get exactly the same outputs) so they are easy to test and verify their correctness

-- *******************************************************
-- Function to find if a number is even
isEven :: Int -> Bool
isEven num = num `mod` 2 == 0

-- *******************************************************
-- Function to find if a number is prime
isPrime :: Int -> Bool
isPrime num 
          | num < 4 = num > 1
          | num `mod` 2 == 0 = False
          | otherwise = null [y | y <- [3,5..s], num `mod` y == 0 ]
    where s = floor (sqrt (fromIntegral num))   

-- Note: We use fromIntegral to convert num because num is an Int
-- and sqrt expects a Float


-- ********************************************************************
-- The main function is impure because it uses I/O functions which are
-- not guaranteed to return the same value consistently for given input

main :: IO ()
main = do
        putStrLn "Please enter a number"
--  getLine returns a String so we can use the read function from Prelude (Haskell's default libray)
--  to convert from a String to an Int (or basicall convert any types)
        numberText <- getLine

        let number = read numberText :: Int
        putStrLn "The numbers below your number than are prime or even are: \n"

--  We always assign a value to a variable using either let or where,
--  that value will never change, if a value is being assigned to the
--  result of a non pure function (like I/O) we should use <- instead.	
        let qualifyingNumbers = [x | x <-[1..number - 1], isPrime x || isEven x ]
        
        let nums = map show qualifyingNumbers
        
        mapM putStrLn nums
        
        putStrLn ""
            
    
	
	
	
	
	