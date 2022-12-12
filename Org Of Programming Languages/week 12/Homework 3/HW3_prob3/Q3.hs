import System.Random
import System.Random.Stateful

--TODO List
-- Shuffle

type Card = (Int,String)
type Deck = [Card]

startingDeck::Deck
startingDeck = [(a,"Spades") | a <-[1..13]] ++ [(a,"Clubs") | a <-[1..13]] ++ [(a,"Hearts") | a <-[1..13]] ++ [(a,"Diamonds") | a <-[1..13]]

removeCard::Deck -> Card -> Deck
removeCard deck toRemove = delete toRemove deck

shuffle::Deck -> Deck -> Deck
shuffle shuffledDeck deck = deck

resetDeck::Deck
resetDeck =  shuffle startingDeck

dealCard::Deck -> Int -> Card
dealCard deck selectedCard = deck !! selectedCard


gameLoop:: Deck -> IO ()
gameLoop deck = do
                 putStrLn "Select from options below"
                 putStrLn "1 Reset the deck."
                 putStrLn "2 Shuffle the deck."
                 putStrLn "3 Deal a random card."
                 putStrLn "4 Play guessing game."
                 putStrLn "5 Quit."

                 userInput <- getLine

                 let userInt = read userInput :: Int

                 if(userInt == 1) then do
                     let newDeck = shuffle startingDeck
                     
                     putStrLn "Deck has been rest and shuffled"

                     gameLoop newDeck
                 else if (userInput == 2) then do
                     let newDeck = shuffle deck
                     
                     putStrLn "Deck has been shuffled"

                     gameLoop newDeck
                 else if (userInput == 3) then do
                     let min = 0
                     let max = length deck
                     
                     randNum <- uniformRM (min, max) globalStdGen :: IO Int
                     
                     let card = dealCard deck randNum

                     let newDeck = removeCard deck card
                     
                     let cardStr = (show (fst card)) ++ ":" ++ (show (snd card))
                     
                     putStrLn "The removed card is:" ++ cardStr

                     gameLoop newDeck
                     
                 else if (userInput == 4) then do
                     
                     putStrLn "Enter a number between 1 and 13"
                     userInput1 <- getLine
                     putStrLn "Enter the card suit | (Spades, Clubs, Hearts, Diamonds)"
                     userInput2 <- getLine

                     let userInt = read userInput1 :: Int

                     let card = (userInt,userInput2)
                     
                     randNum <- uniformRM (min, max) globalStdGen :: IO Int
                     
                     let deltCard = dealCard deck randNum

                     let newDeck = removeCard deck deltCard
                     
                     let cardStr = "Entered card " ++ (show (fst card)) ++ ":" ++ (show (snd card)) ++ " delt card" ++ (show (fst deltCard)) ++ ":" ++ (show (snd deltCard))
                     
                     if(card == deltCard) then do
                         putStrLn "You got it correct!!!"
                         putStrLn cardStr
                     else
                         putStrLn "You got it all wrong :("
                         gameLoop newDeck
                         
                 else if (userInput == 5) then do
                     putStrLn "Thanks for playing, have a nice day!"
                 else
                     do
                         putStrLn "Invalid selection, please try again"
                         gameLoop deck
                
                where
                    min = 0
                    max = length deck


main::IO ()
main = do
    
    gameLoop (shuffle startingDeck)


