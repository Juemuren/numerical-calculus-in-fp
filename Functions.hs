-- | Functions with different shapes and numerical behaviour.
module Functions
  ( cubic
  , gaussian
  , sinc
  , logistic
  , dampedSine
  , runge
  , oscillatory
  ) where

cubic :: Double -> Double
cubic x = x * x * x - x

gaussian :: Double -> Double
gaussian x = exp (-(x * x))

-- A Taylor expansion avoids division by zero and loss of precision nearby.
sinc :: Double -> Double
sinc x
  | abs x < 1e-4 = 1 - x * x / 6 + x * x * x * x / 120
  | otherwise = sin x / x

-- | A sigmoid evaluated without overflowing exp for large negative inputs.
logistic :: Double -> Double
logistic x
  | x >= 0 = 1 / (1 + exp (-x))
  | otherwise = let e = exp x in e / (1 + e)

dampedSine :: Double -> Double
dampedSine x = gaussian x * sin (5 * x)

runge :: Double -> Double
runge x = 1 / (1 + 25 * x * x)

-- | A continuous function whose derivative at zero exists but is not
-- continuous there. Fixed-step methods struggle near the origin.
oscillatory :: Double -> Double
oscillatory x
  | x == 0 = 0
  | otherwise = x * x * sin (1 / x)
