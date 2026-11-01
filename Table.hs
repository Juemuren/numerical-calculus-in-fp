module Table (renderTable) where

import Data.List (intercalate, transpose)

renderTable :: [String] -> [[String]] -> String
renderTable headers rows = unlines $
  [border, renderRow headers, border] ++ map renderRow rows ++ [border]
  where
    widths = map (maximum . map length) (transpose (headers : rows))
    border = "+" ++ intercalate "+" (map (\w -> replicate (w + 2) '-') widths) ++ "+"
    renderRow cells = "| " ++ intercalate " | " (zipWith pad widths cells) ++ " |"
    pad width cell = replicate (width - length cell) ' ' ++ cell
