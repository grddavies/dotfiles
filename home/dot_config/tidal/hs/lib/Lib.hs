-- Infinite list of Fibonacci numbers
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
