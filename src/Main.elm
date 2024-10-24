module Main exposing (..)

import Browser
import File
import File.Select
import Html as H
import Html.Attributes as HA
import Chart.Item as CI

import Task

import Services.CsvDecoder exposing (parseCsv)
import Services.GraphDataCleaner as GDC

import Components.UploadButton exposing (uploadButton)
import Components.Table.Table exposing (investmentTable)
import Components.Charts.Graph0 exposing (graph0)
import Components.Charts.Graph1 exposing (graph1)

import Types.Row as Row
import Types.Date as Date
import Types.Msg as Msg
import Types.GraphTypes as GT


-- MAIN

main : Program () Model Msg.Msg
main = Browser.element { init = init, view = view, update = update, subscriptions = subscriptions}

-- MODEL
type alias Model = {
    csv: List Row.Row
    , filter: {column: Int, descending: Bool}
    , index: Int
    , graph0HoveringDatabars: List (CI.One GT.Graph0Data CI.Bar)
    , graph0HoveringDatadots: List (CI.One GT.Graph0Data CI.Dot)
    , graph1HoveringData: GT.Hovering1Data
    } 

init : () -> (Model, Cmd Msg.Msg)
init _ = (Model [] {column=3, descending=False} 0 [] [] [], Cmd.none)

-- UPDATE
update : Msg.Msg -> Model -> (Model, Cmd Msg.Msg)
update msg model =
    case msg of
        Msg.CsvRequested -> (model, File.Select.file ["text/csv"] Msg.CsvSelected)

        Msg.CsvSelected file -> (model, Task.perform Msg.CsvLoaded (File.toString file))

        Msg.CsvLoaded content ->({ model | csv = parseCsv content }, Cmd.none)

        Msg.OnHoverG0 bars dots -> 
            ({ model | graph0HoveringDatabars = bars, graph0HoveringDatadots=dots }, Cmd.none)
        Msg.OnHoverG1 hovering -> 
            ({ model | graph1HoveringData = hovering }, Cmd.none)

        Msg.SortBy number ->
            let
                sortByColumn column =
                    case column of
                        0 -> List.sortBy (\x -> x.balance)
                        1 -> List.sortBy (\x -> x.amount)
                        2 -> List.sortBy (\x -> x.investmentType)
                        3 -> List.sortWith (\x y -> Date.compare x.modified y.modified)
                        4 -> List.sortBy (\x -> x.instrumentSymbol)
                        _ -> identity
                sortedData =
                    if number /= model.filter.column then
                        sortByColumn number model.csv
                    else
                        List.reverse model.csv

            in
            if model.filter.column == number then
                ({ model | csv = sortedData, filter = {column=number, descending=not model.filter.descending} }, Cmd.none)
            else
                ({ model | csv = sortedData, filter = {column=number, descending=False} }, Cmd.none)

        Msg.ChangeIndex number ->
            ({ model | index = number }, Cmd.none)

-- VIEW
view : Model -> H.Html Msg.Msg
view model =
    case model.csv of
        [] ->
            uploadButton Msg.CsvRequested
        _ ->
            H.div [ HA.class "items-center justify-center bg-svgImage pt-8"] [
                H.div [ HA.class "items-center justify-center"] [
                    investmentTable model.csv model.index model.filter,
                    H.div [ HA.class "p-8 space-y-8" ] [
                        H.div [ HA.class "w-full justify-center p-4 tracking-tighter bg-gray-400 bg-opacity-20 backdrop-blur  rounded-3xl"] [
                            graph0 (
                                GDC.getGraph0Data (List.sortWith (\x y -> Date.compare x.modified y.modified)  model.csv)
                                ) (GT.Hovering0Data model.graph0HoveringDatabars model.graph0HoveringDatadots)
                        ],
                        H.div [ HA.class "w-full justify-center p-4 tracking-tighter bg-gray-400 bg-opacity-20 backdrop-blur rounded-3xl"] [
                            graph1 (
                                GDC.getGraph1Data model.csv
                                ) (model.graph1HoveringData)
                        ]
                    ]

                ]
            ]


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg.Msg
subscriptions _ = Sub.none

