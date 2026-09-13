module Integrate
  ( integrate
  , integralFromLower
  , integralToUpper
  , integralIndefinite
  , integralDefinite
  ) where


integrate :: Double -> Double -> (Double -> Double) -> Double
integrate a b f =
  let n  = 10000 :: Int
      dx = (b - a) / fromIntegral n
  in sum
       [ f (a + (fromIntegral i + 0.5) * dx) * dx
       | i <- [0 .. n - 1]
       ]


-- ∫ₐˣ f(t) dt
integralFromLower
  :: Double
  -> (Double -> Double)
  -> Double
  -> Double
integralFromLower a f x =
  integrate a x f


-- ∫ₓᵇ f(t) dt
integralToUpper
  :: Double
  -> (Double -> Double)
  -> Double
  -> Double
integralToUpper b f x =
  integrate x b f


-- ∫₀ˣ f(t) dt + C
integralIndefinite
  :: (Double -> Double)
  -> Double
  -> Double
  -> Double
integralIndefinite f c x =
  integrate 0 x f + c


-- ∫ₐᵇ f(x) dx
integralDefinite
  :: Double
  -> Double
  -> (Double -> Double)
  -> Double
integralDefinite = integrate