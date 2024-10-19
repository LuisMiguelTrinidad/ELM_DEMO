module Main exposing (..)

import Browser
import File exposing (File)
import File.Select as Select
import Html exposing (Html)
import Task

import Services.CsvDecoder exposing (parseCsv)
import Types.Row exposing (Row)

import Components.UploadButton exposing (uploadButton)
import Components.Table exposing (investmentTable)

import Types.Row as Row

-- MAIN
main : Program () Model Msg
main = Browser.element { init = init, view = view, update = update, subscriptions = subscriptions}

-- MODEL
type alias Model = {csv: List Row} 

init : () -> (Model, Cmd Msg)
init _ = (Model [], Cmd.none)

-- UPDATE
type Msg = 
    CsvRequested
  | CsvSelected File
  | CsvLoaded String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    CsvRequested ->
      ( model
      , Select.file ["text/csv"] CsvSelected
      )

    CsvSelected file ->
      ( model
      , Task.perform CsvLoaded (File.toString file)
      )

    CsvLoaded content ->
      ( { model | csv = parseCsv content }
      , Cmd.none
      )

-- VIEW
view : Model -> Html Msg
view model =
  case model.csv of
    [] ->
      uploadButton CsvRequested
    _ ->
      investmentTable model.csv

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none