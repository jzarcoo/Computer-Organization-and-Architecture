module Leibniz where

leibniz :: Int -> Double
leibniz m = 4 * sum [((-1) ** fromIntegral i) / (2 * fromIntegral i + 1) | i <- [0..(m-1)]]

main :: IO ()
main = do
    putStr "Pon el valor de m: "
    input <- getLine
    let m = read input :: Int
    let pi = leibniz m
    print pi