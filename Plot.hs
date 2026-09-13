module Plot
  ( plotFunction
  ) where

import Graphics.Gnuplot.Simple

plotFunction
  :: FilePath
  -> Double
  -> Double
  -> (Double -> Double)
  -> IO ()
plotFunction path xmin xmax f =
  plotFunc
    [ PNG path
    , Key Nothing
    , XLabel "x"
    , YLabel "y"
    ]
    (linearScale 1000 (xmin, xmax))
    f