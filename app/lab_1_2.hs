fibonacci = 1 : 2 : (zipWith (+) fibonacci (tail fibonacci))

main =
    putStrLn $
        show $
            sum $
                filter (\x -> x `mod` 2 == 0) $
                    takeWhile (< 4000000) $
                        fibonacci
