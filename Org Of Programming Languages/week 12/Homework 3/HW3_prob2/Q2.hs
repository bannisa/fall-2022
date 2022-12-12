isDecendingOrder::Int -> [Int] -> Bool
isDecendingOrder lHead elements 
                                | length elements == 0 = True
                                | length elements == 1 = lHead >= curHead
                                | otherwise = lHead >= curHead && isDecendingOrder curHead tElements
                                where curHead = head elements
                                      tElements = tail elements

isAcendingOrder::Int -> [Int] -> Bool
isAcendingOrder lHead elements
                                | length elements == 0 = True
                                | length elements == 1 = lHead <= curHead
                                | otherwise = lHead <= curHead && isAcendingOrder curHead tElements
                                where curHead = head elements
                                      tElements = tail elements


getUserInputs::[Int] -> String -> String -> IO [Int]
getUserInputs userInputs message exit = do
                                        putStrLn message
                                        
                                        userInput <- getLine
                                        
                                        if userInput /= exit then do
                                            
                                            let userInt = read userInput :: Int
                                            
                                            inputs <- getUserInputs (userInputs ++ [userInt]) "" exit
                                            
                                            return inputs
                                        else
                                            return userInputs


getMinElem::Int -> [Int] -> Int
getMinElem minElem elements 
                            | length elements == 0 = minElem
                            | length elements == 1 = if minElem > curMin then curMin else minElem
                            | otherwise = if minElem > curMin then getMinElem curMin rElements else getMinElem minElem rElements
                            where rElements = tail elements
                                  curMin = head elements

getElemIndex:: Int -> Int -> [Int] -> Int
getElemIndex curIndex toSearchFor elements 
                                            | length elements == 0 = -1
                                            | curElem == toSearchFor = curIndex
                                            | otherwise = getElemIndex nextIndex toSearchFor rElements
                                            where rElements = tail elements
                                                  nextIndex = curIndex + 1
                                                  curElem = head elements
removeElem::Int -> Int -> [Int] -> [Int]
removeElem indexToRemove curIndex elements 
                                            | indexToRemove == curIndex = rElements
                                            | otherwise = [headElem] ++ removeElem indexToRemove nextIndex rElements
                                            where headElem = head elements
                                                  nextIndex = curIndex + 1
                                                  rElements = tail elements

main::IO ()
main = do
        let exit = "exit"
        let message = "Enter a list of integers or " ++ exit ++ " to stop"
        
        userList <- getUserInputs [] message exit
        
        putStrLn "Select a option"
        putStrLn "1) Check if entered list is sorted in acending order"
        putStrLn "2) Check if entered list is sorted in decending order"
        
        userInput <- getLine
        
        let userSelection = read userInput :: Int
        
        let result = if userSelection == 1 then isAcendingOrder (head userList) (tail userList)
                     else isDecendingOrder (head userList) (tail userList)
        
        if result && userSelection == 1 then putStrLn "The list is sorted in acending order"
        
        else if result && userSelection == 2 then putStrLn "The list is sorted in decending order"
        
        else if result /= True && userSelection == 1 then putStrLn "The list is not sorted in acending order"
        
        else putStrLn "The entered list is not sorted in decending order"
        
        putStrLn ""