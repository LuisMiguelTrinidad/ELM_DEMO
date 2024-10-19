module Main exposing (..)

import Browser
import File
import File.Select
import Html exposing (Html)
import Task

import Services.CsvDecoder exposing (parseCsv)

import Components.UploadButton exposing (uploadButton)
import Components.Table.Table exposing (investmentTable)

import Types.Row as Row
import Types.Date as Date
import Types.Msg as Msg

-- MAIN
main : Program () Model Msg.Msg
main = Browser.element { init = init, view = view, update = update, subscriptions = subscriptions}

-- MODEL
type alias Model = {
  csv: List Row.Row
  , filter: {column: Int, descending: Bool}
  , index: Int} 

init : () -> (Model, Cmd Msg.Msg)
init _ = (Model [] {column=3, descending=False} 0, Cmd.none)

-- UPDATE
update : Msg.Msg -> Model -> (Model, Cmd Msg.Msg)
update msg model =
  case msg of
    Msg.CsvRequested ->
      (model, File.Select.file ["text/csv"] Msg.CsvSelected)

    Msg.CsvSelected file ->
      (model, Task.perform Msg.CsvLoaded (File.toString file))

    Msg.CsvLoaded content ->
      ({ model | csv = parseCsv content }, Cmd.none)

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
            if model.filter.descending then
              List.reverse model.csv
            else
              model.csv
      in
      if model.filter.column == number then
        ({ model | csv = sortedData, filter = {column=number, descending=not model.filter.descending} }, Cmd.none)
      else
        ({ model | csv = sortedData, filter = {column=number, descending=False} }, Cmd.none)

    Msg.ChangeIndex number ->
        ({ model | index = number }, Cmd.none)

-- VIEW
view : Model -> Html Msg.Msg
view model =
  case model.csv of
    [] ->
      uploadButton Msg.CsvRequested
    _ ->
      investmentTable model.csv model.index model.filter

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg.Msg
subscriptions _ = Sub.none