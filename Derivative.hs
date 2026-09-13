module Derivative
  ( derivative
  ) where

derivative :: (Double -> Double) -> (Double -> Double)
derivative f = \x ->
  let h = 1e-6
  in (f (x + h) - f (x - h)) / (2 * h)