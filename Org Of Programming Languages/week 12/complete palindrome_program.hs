-- We need to import this module as we will be using some functions from it
-- Data.Char contains many useful character manipulation functions like ord and chr
import Data.Char

-- Implementation of a function to determine if a string is a palindrome
-- The function ignores letter case and punctuation symbols

-- Function to determine if a string is a palindrome
isPalindrome :: String -> Bool

isPalindrome s = (reverseStr s' == s')
      where s' = normalize s

-- Function to reverse a string
reverseStr::String->String
reverseStr s | s == [] = []
reverseStr s = reverseStr stail ++ [shead]
          where stail = tail s
                shead = head s

-- Function to normalize a string, remove punctuation and convert the string
-- to lower case
normalize::String->String
normalize s = makeLowerCase(rempunct s)

-- We can also define the normalize function as: normalize = makeLowerCase . rempunct
-- That means normalize is the composite of those two functions, normalize(x) = makeLowercase (rempunct(X))

-- Function to remove punctuation
rempunct::String->String
rempunct s = [c | c <- s, c `elem` ['a'..'z'] || c `elem` ['A'..'Z'] || c `elem` ['0'..'9']]

-- Alternatively we could do (isPunctuation is a function in Data.Char)
-- rempunct s = [c | c <- s, (isPunctuation c) == False]

-- Function to convert character to lower case
convertLower::Char -> Char
convertLower c = chr(ord c + (ord 'a' - ord 'A'))

-- Alternative way to do it (toLower is a function in Data.Char)
-- convertLower c = toLower c

-- Function to convert string to lowercase
makeLowerCase::String->String
makeLowerCase s = [ if (c `elem` ['A'..'Z'] ) then convertLower c else c | c <- s ]

-- Alternative way
-- makeLowerCase s = [ toLower c | c <- s, isAlpha c ]

-- ****************************************************************************
-- These section contains all the non pure functions and all I/O related code.


-- This function gets a collection of words entered by the user with
-- each word in a different line and stores them inside a list
getWords :: [String] -> IO [String]
getWords wordList = do
		            newWord <- getLine
                    if newWord /= "Stop" 
                    then do
                         newWords  <- getWords (wordList ++ [newWord])
                         return newWords
                    else
                         return wordList

-- Main function									  
main :: IO ()
main = do
       putStrLn "Please enter a set of word (one per line), type stop in a full line to end"
       words <- getWords []
       putStrLn "Please choose one of the following options:"
       putStrLn "1) Filter all Palindromes"
       putStrLn "2) Remove all Palindromes"
       putStrLn "3) Quit"

       choiceText <- getLine
       let choice = read choiceText :: Int
       let filteredWords =
                           if choice == 1
                           then
                                [s | s <- words, isPalindrome s]
                           else if choice == 2
                           then
                                [s | s <- words, isPalindrome s == False]
                           else
                                ["0"]
	
       let wordsPlusNewLines = [ x ++ "\n" | x <- filteredWords]
       putStrLn (concat wordsPlusNewLines)
	
       if filteredWords /= ["0"]
       then 
		      main
       else
		      putStrLn ("Have a nice day!!!")