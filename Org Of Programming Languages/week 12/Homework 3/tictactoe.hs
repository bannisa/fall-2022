-- A simple tic-tac-toe game written in Haskell

-- This line imports our 2D array library
import Array2D

-- Define a type board which basically is a collections of strings
type Board = [[Char]]
-- Define a type move consisting of two positions (row & col)
type Move = (Int,Int)

-- Create a 2D array of characters to represent the board-- Create a 2D array of characters to represent the board
emptyBoard :: Board
emptyBoard = createArray2D 3 3 ' '

-- Main function
main :: IO ()
main = do
       putStrLn "Welcome to the amazing game of TicTacToe"
       putStrLn "Enter a row and column separated by a space"
       putStrLn "to make a move, in the range (0-2)"
       putStrLn "Type 'exit' any time to quit"
       displayBoard emptyBoard
       gameLoop 'X' emptyBoard

-- The core of the program is the game loop function that keeps letting players
-- make a move until the game is over (somebody wins or its a draw).         
gameLoop :: Char->Board-> IO ()
gameLoop playerSymbol board = 
                      do
                      if playerSymbol == 'X' then
                         putStrLn "Player 1 please make a move"
                      else
                         putStrLn "Player 2 please make a move"
                      moveStr <- getLine
                      if moveStr == "exit" then
                         do
                         putStrLn "Have a nice day!"
                         return ()
                      else
                         do
                         let move = parseMove moveStr
                         let validMove = isMoveValid move board
                         if validMove == False then
                            do
                            putStrLn "Invalid Move, please try again!"
                            gameLoop playerSymbol board
                         else
                            do
                            let result = performMove playerSymbol move board
                            let updatedBoard = fst result
                            let gameStatus = snd result
                            displayBoard updatedBoard
                            
                            if gameStatus == 0 then
                               do
                               if playerSymbol == 'X' then
                                  putStrLn "Player 1 you won!!!"
                               else
                                  putStrLn "Player 2 you won!!!"
                            else if gameStatus == 1 then
                                  putStrLn "Game is a Draw!"
                            else
                                 do
                                 if playerSymbol == 'X' then
                                  gameLoop 'O' updatedBoard     
                                 else
                                  gameLoop 'X' updatedBoard     
                                                             
-- parse a move from a command string that is assumed to be formatted properly as "r c"
-- (two characters separated by a space) where r is a character representing the row and c is the column                            
parseMove :: String->Move
parseMove str = (row, col)
              where 
                 row = read [hstr] :: Int
                 col = read [lstr] :: Int
                 hstr = head str
                 lstr = last str
                 
-- alternate version
-- parseMove :: String->Move
-- parseMove command = (row,col)
--                  where row = read [getElement command 0] :: Int
--                        col = read [getElement command 2] :: Int

isMoveValid :: Move->Board->Bool
isMoveValid move board
                  | row < 0 || row >= nRows || col < 0 || col >= nCols = False
                  | getElement2D board row col /= ' ' = False
                  | otherwise = True                  
                  
                  where 
                      row = fst move
                      col = snd move
                      nRows = getNumRows board
                      nCols = getNumCols board                      


-- perform a player move, returns an ordered pair consisting on the updated board and an integer indicating the new game status (0 game was won, 1 draw, 2 no winner yet)                 
performMove :: Char->Move->Board->(Board,Int)
performMove playerSymbol move board = (updatedBoard, gameStatus)
                                    where 
                                       updatedBoard = setElement2D board row col playerSymbol
                                       gameStatus = checkWinner updatedBoard
                                       row = fst move
                                       col = snd move

-- Check if there is a game winner, returns the game status (0 game was won, 1 draw, 2 no winner yet)  
-- Notice that I made the checkDraw function inline even though in class I made it independent, the problem
-- is it was calling checkWinner which created an infinite recursion that was hanging the program.                                      
checkWinner::Board->Int
checkWinner board 
                  | checkWinnerHorz board || checkWinnerVert board || checkWinnerDiag board = 0 --Somebody won
                  | checkDraw board = 1 --Draw
                  | otherwise = 2 --Nobody won so far
                  where
                       checkDraw::Board->Bool
                       checkDraw board = null availableSlots
                       availableSlots = [(row,col) | row<-[0..2], col<-[0..2], getElement2D board row col == ' ' ]  

checkWinnerHorz::Board->Bool
checkWinnerHorz board = length [ row | row<-board, allElemsAreValidEqual row] >= 1                                       
                            
checkWinnerVert::Board->Bool
checkWinnerVert board = length [   colIndex  | colIndex<-[0..2] , allElemsAreValidEqual (getCol board colIndex) ] >= 1

-- alternate versions
-- checkWinnerHorz :: Board->Bool
-- checkWinnerHorz board = allElemsAreValidEqual (getRow board 0) || allElemsAreValidEqual (getRow board 1) || allElemsAreValidEqual (getRow board 2)

-- checkWinnerVert :: Board->Bool
-- checkWinnerVert board = allElemsAreValidEqual (getCol board 0) || allElemsAreValidEqual (getCol board 1) || allElemsAreValidEqual (getCol board 2)
                         

checkWinnerDiag::Board->Bool
checkWinnerDiag board = allElemsAreValidEqual (getDiagonal board 1) || allElemsAreValidEqual (getDiagonal board 2)   

-- determine if given symbol is a valid player symbol  
isValidSymbol:: Char->Bool
isValidSymbol symbol = elem symbol ['X','x','O','o']
       
             
-- Display the board to the screen        
displayBoard :: Board->IO ()
displayBoard board = putStrLn (convertBoardToStr board)

-- Get a string representation of the board 
convertBoardToStr::Board->String
convertBoardToStr board = separator ++ row1 ++ separator ++ row2 ++ separator ++ row3
                        where
                              separator = "--------------------\n"
                              row1 = formatRow (getRow board 0)
                              row2 = formatRow (getRow board 1)
                              row3 = formatRow (getRow board 2)
                              
formatRow::[Char]->String 
formatRow row = concat ["|" ++ [symbol] | symbol<-row ] ++ "|\n"                             

-- Find if all elements in a row, col or diagonal constitute a win (they are a valid symbol and equal)                              
allElemsAreValidEqual::[Char]->Bool
allElemsAreValidEqual list = areAllElemsEqual list && isValidSymbol firstElement
                           where
                                firstElement = head list    
       