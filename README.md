# Лабораторная работа №1

## Вариант 2,29

Выполнил: Ганыс Герман Витальевич Р34112
Преподаватель: Пенской Александр Владимирович

## Цель работы:
  Освоить базовые приемы и абстракции функционального программирования: функции, поток управления и поток данных, сопоставление с образцом, рекурсия, свертка, отображение, работа с функциями как с данными, списки.

## Задача 2:
   ### Условие:
    Каждый следующий элемент ряда Фибоначчи получается при сложении двух предыдущих. Начиная с 1 и 2, первые 10 элементов будут:
    1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

    Найдите сумму всех четных элементов ряда Фибоначчи, которые не превышают четыре миллиона.
```haskell
fibonacci = 1 : 2 : (zipWith (+) fibonacci (tail fibonacci))

main =
    putStrLn $
        show $
            sum $
                filter (\x -> x `mod` 2 == 0) $
                    takeWhile (< 4000000) $
                        fibonacci
```
### Ответ: 4613732

### Вариант с использование map
```haskell
fibonaci = map fst (iterate f (0,1)) where f (x,y) = (y,x+y)
main =
    putStrLn $ show $ sum $ filter (\x -> x `mod` 2 == 0) $ takeWhile (< 4000000) $ fibonacci
```

### Вариант с использованием рекурсии
```haskell
fib_sum_even_helper start1 start2 acc border = 
    if start2 < border then
        if (start1 + start2) `mod` 2 == 0 then 
            fib_sum_even_helper start2 (start1 + start2) (acc + start1 + start2) border
        else
            fib_sum_even_helper start2 (start1 + start2) acc border
    else acc
```

### Вариант с использованием хвостовой рекурсии
```haskell
choice_helper a b | (a + b) `mod` 2 == 0 = a + b
                  | otherwise = 0

fib_sum_even_helper start1 start2 acc border = 
    if start2 < border then
        fib_sum_even_helper start2 (start1 + start2) (acc + (choice_helper start1 start2)) border
    else 
        acc

fib_sum_even max = fib_sum_even_helper 0 1 0 max
main = putStrLn $ show $ fib_sum_even 4000000
```

### Реализация на любимом языке
```python
def compute():
	ans = 0
	x = 1
	y = 2
	while x <= 4000000:
		if x % 2 == 0:
			ans += x
		x, y = y, x + y
	return ans


if __name__ == "__main__":
	print(compute())
```

## Задача 29:
### Условие:
Рассмотрим все целочисленные комбинации ab для 2 ≤ a ≤ 5 и 2 ≤ b ≤ 5:

22=4, 23=8, 24=16, 25=32

32=9, 33=27, 34=81, 35=243

42=16, 43=64, 44=256, 45=1024

52=25, 53=125, 54=625, 55=3125

Если их расположить в порядке возрастания, исключив повторения, мы получим следующую последовательность из 15 различных членов:
4, 8, 9, 16, 25, 27, 32, 64, 81, 125, 243, 256, 625, 1024, 3125

Сколько различных членов имеет последовательность ab для 2 ≤ a ≤ 100 и 2 ≤ b ≤ 100?
```haskell
import Data.Set

main = putStrLn $ show $ size $ fromList [x ^ y | x <- [2 .. 100], y <- [2 .. 100]]
```
### Ответ: 9183

Здесь я заиспользовал Set для оптимизации вычисления повторяющихся элементов.

### Реализация с использованием монады:
```haskell
import Control.Monad
main = length . group . sort $ liftM2 (^) [2..100] [2..100]
```

### Реализация с помощью хвостовой рекурсии
```haskell
import Data.List (nub)

lst_helper l1 l2 result = 
    if null l1 then result
    else lst_helper (tail l1) l2 (result ++ [(head l1) ^ y | y <- l2])

lst l1 l2 = lst_helper l1 l2 []

main = putStrLn $ show $ length $ nub $ lst [2..100] [2..100]
```

### Реализация на любимом языке
```python
if __name__ == "__main__":
    seen = set(a**b for a in range(2, 101) for b in range(2, 101))
	print(len(seen))
```

## Вывод:
В ходе написания лабораторной работы мне очень понравилось взаимодействовать с Haskell. До этого я касался функционального программирования вскользь используя лямбды и замыкания в python и для меня это можно сказать было новым опытом.