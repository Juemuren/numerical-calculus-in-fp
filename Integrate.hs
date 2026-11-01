module Integrate
  ( integrate
  , integrateWithSteps
  , integralFromLower
  , integralToUpper
  , integralIndefinite
  , integralDefinite
  ) where

import qualified Data.List as List

integrate :: Double -> Double -> (Double -> Double) -> Double
integrate = integrateWithSteps 10000

-- | Composite Midpoint Method
integrateWithSteps :: Int -> Double -> Double -> (Double -> Double) -> Double
integrateWithSteps n a b f
  | n <= 0 = error "n must be positive"
  | a == b = 0
  | otherwise =
    let dx = (b - a) / fromIntegral n
    in sum
      [ f (a + (fromIntegral i + 0.5) * dx) * dx
      | i <- [0 .. n - 1]
      ]

integralFromLower :: Double -> (Double -> Double) -> Double -> Double
integralFromLower a f x = integrate a x f

integralToUpper :: Double -> (Double -> Double) -> Double -> Double
integralToUpper b f x = integrate x b f

integralIndefinite :: (Double -> Double) -> Double -> Double -> Double
integralIndefinite f c x = integrate 0 x f + c

integralDefinite :: Double -> Double -> (Double -> Double) -> Double
integralDefinite = integrate
