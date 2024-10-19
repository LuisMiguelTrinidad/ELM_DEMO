module Types.Msg exposing (..)

import File exposing (File)

type Msg = 
    CsvRequested
  | CsvSelected File
  | CsvLoaded String
  | SortBy Int
  | ChangeIndex Int