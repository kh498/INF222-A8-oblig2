module Main where

import           Control.Monad      (when)
import           Data.Either
import           Eval
import           Parser
import           Pretty
import           Syntax
import           System.Environment (getArgs)

main = do
  args <- getArgs
  let verbose = "-v" `elem` args
  let debug = "-d" `elem` args
  let cleanedArgs = filter (\e -> e `notElem` ["-v", "-d"]) args
  let fname =
        if null cleanedArgs
          then error "no filename"
          else head cleanedArgs
  input <- readFile fname
  case parse program fname input of
    Right v -> do
      when verbose $ putStrLn $ pPrint v
      exec v debug >> return ()
    Left e -> print e
