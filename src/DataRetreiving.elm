module DataRetreiving exposing (..)

import Browser
import File exposing (File)
import File.Select as Select
import Html exposing (Html)
import Task
import Csv.Decode as Decode exposing (Decoder)

import Services.CsvDecoder exposing (parseCsv)
import Types.Row exposing (Row)

import Components.UploadButton
import Types.Row as Row

type alias Transaction = {id: Int, balance: Float, amount: Float, transactionType: String, date: String, name: String}

decoder : Decoder ( Int, Int, Int )
decoder =
    Decode.map3 (\r g b -> ( r, g, b ))
        (Decode.column 0 Decode.int)
        (Decode.column 1 Decode.int)
        (Decode.column 2 Decode.int)

-- MAIN
main : Program () Model Msg
main = Browser.element
    { 
      init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

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
      Components.UploadButton.uploadButton CsvRequested
    _ ->
      Html.p [ ] [ Html.text <| String.join "\n" (List.map (\x -> Row.toString x) model.csv) ]

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none