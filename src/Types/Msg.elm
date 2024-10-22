module Types.Msg exposing (..)

import File exposing (File)

import Chart.Item as CI

import Types.GraphTypes as GT


type Msg = 
    CsvRequested
    | CsvSelected File
    | CsvLoaded String
    | SortBy Int
    | ChangeIndex Int
    | OnHoverG0 (List (CI.One GT.Graph0Data CI.Bar)) (List (CI.One GT.Graph0Data CI.Dot))
    | OnHoverG1 (List (CI.One GT.Graph1Data CI.Bar))