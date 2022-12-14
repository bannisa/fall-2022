
parseLine::String -> String -> [String]
parseLine line bulitStr
                        | length line == 0 = [bulitStr]
                        | otherwise = if curChar == ' ' then [bulitStr] ++ parseLine lineRemander newLine else parseLine lineRemander (bulitStr ++ [curChar])
                        where
                            curChar = head line
                            lineRemander = tail line
                            newLine = ""              

getLines::[String] -> IO [String]
getLines lines = do
                    enteredLine <- getLine
                    
                    if(enteredLine == "end") then do
                        return lines
                    else 
                        do
                            let newLines = lines ++ (parseLine enteredLine "")
                        
                            getLines newLines

replaceAllStr::[[String]] -> String -> String -> [[String]]
replaceAllStr strings toReplace replacement = [[if str == toReplace then replacement else str | str <- strList] | strList <- strings]

replaceFstStr:: [[String]] -> String -> String -> Int -> [[String]]
replaceFstStr strList toReplace replacement numReplaced
                                                        | length strList == 0 = [[replacement]]
                                                        | length strList == 1 && numReplaced == 0 = [newStrList]
                                                        | length strList == 1 && numReplaced == 1 = [curStrList]
                                                        | numReplaced == 0 = if replaced == 1 then [newStrList] ++ strRemaning else [curStrList] ++ replaceFstStr strRemaning toReplace replacement 0
                                                        | otherwise = strRemaning
                                                        where
                                                            curStrList = head strList
                                                            strRemaning = tail strList
                                                            intStrtuple = attemptStrReplacment curStrList toReplace replacement numReplaced
                                                            newStrList = fst intStrtuple
                                                            replaced = snd intStrtuple
                                                            
attemptStrReplacment::[String] -> String -> String -> Int -> ([String],Int)
attemptStrReplacment strings toReplace replacement numReplaced
                                                                | length strings == 1 && numReplaced < 1 = if curStr == toReplace then ([replacement],1) else ([curStr],0)
                                                                | length strings == 1 && numReplaced > 0 = ([curStr],0)
                                                                | numReplaced < 1 = if curStr == toReplace then (([replacement] ++ remaningStrs), 1) else (([curStr] ++ fst (attemptStrReplacment remaningStrs toReplace replacement numReplaced)), snd (attemptStrReplacment remaningStrs toReplace replacement numReplaced)) 
                                                                | otherwise = (remaningStrs, 0)
                                                                where
                                                                    curStr = head strings
                                                                    remaningStrs = tail strings
                                                                    
main::IO ()
main = do
        lines <- getLines []
        
        putStrLn (show lines)