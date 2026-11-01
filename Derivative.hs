module Derivative
  ( derivative
  , derivativeWithStep
  ) where

derivative :: (Double -> Double) -> (Double -> Double)
derivative = derivativeWithStep 1e-6

-- | Central Difference Method
derivativeWithStep :: Double -> (Double -> Double) -> Double -> Double
derivativeWithStep h f x
  | h == 0 = error "h must be nonzero"
  | otherwise =
    (f (x + h) - f (x - h)) / (2 * h)
