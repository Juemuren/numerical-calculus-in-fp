module Derivative
  ( derivative
  , derivativeWithStep
  ) where

derivative :: (Double -> Double) -> (Double -> Double)
derivative = derivativeWithStep 1e-6

derivativeWithStep :: Double -> (Double -> Double) -> Double -> Double
derivativeWithStep h f x = (f (x + h) - f (x - h)) / (2 * h)
