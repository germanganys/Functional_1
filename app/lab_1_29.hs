import Set
main = putStrLn $ show $ size $ fromList [x^y | x <- [2..100], y <- [2..100]]
