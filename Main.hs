module Main (main) where

import Data.List (find, intercalate)
import Derivative (derivative)
import Functions
import Integrate (integralFromLower, integrate)
import System.Environment (getArgs)
import System.Exit (die)
import Table (renderTable)
import Text.Printf (printf)

data Example = Example
  { exampleName :: String
  , exampleFunction :: Double -> Double
  , lowerBound :: Double
  , upperBound :: Double
  }

examples :: [Example]
examples =
  [ Example "cubic" cubic (-2) 2
  , Example "gaussian" gaussian (-3) 3
  , Example "sinc" sinc (-10) 10
  , Example "logistic" logistic (-6) 6
  , Example "dampedSine" dampedSine (-3) 3
  , Example "runge" runge (-1) 1
  , Example "oscillatory" oscillatory (-0.1) 0.1
  ]

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> mapM_ showExample examples
    ["--help"] -> putStrLn usage
    ["--list"] -> mapM_ (putStrLn . exampleName) examples
    [name] -> case find ((== name) . exampleName) examples of
      Just example -> showExample example
      Nothing -> die (printf "Unknown function: %s\n%s" name usage)
    _ -> die usage

usage :: String
usage = intercalate "\n"
  [ "Usage: runghc Main.hs [--help | --list | FUNCTION]"
  , "Without arguments, run every example. Use --list for function names."
  ]

showExample :: Example -> IO ()
showExample example = do
  printf "\n%s on [%.2f, %.2f]\n" (exampleName example) a b
  putStr $ renderTable
    ["x", "f(x)", "f'(x)", "integral(a,x)"]
    (map sampleRow samplePoints)
  printf "Integral over interval: %.10f\n" (integrate a b f)
  where
    f = exampleFunction example
    a = lowerBound example
    b = upperBound example
    samplePoints = [a + (b - a) * fromIntegral i / 4 | i <- [0 .. 4 :: Int]]
    sampleRow :: Double -> [String]
    sampleRow x = printf "%.4f" x : map (printf "%.8f")
      [f x, derivative f x, integralFromLower a f x]
