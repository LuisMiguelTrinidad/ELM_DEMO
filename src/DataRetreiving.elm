module DataRetreiving exposing (..)

import Browser
import File exposing (File)
import File.Select as Select
import Html exposing (Html, p)
import Html.Attributes 
import Html.Events exposing (onClick)
import Task
import Csv.Decode as Decode exposing (Decoder)
import Services.CsvDecoder exposing (parseCsv, Row)
import Svg exposing (..)
import Svg.Attributes exposing (..)

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
      Html.div [ class "flex items-center justify-center w-full" ] [ 
        Html.label [ 
          Html.Attributes.for "dropzone-file"
          , class """flex flex-col items-center justify-center w-full h-64 border-2 border-gray-300 border-dashed rounded-lg 
                   cursor-pointer bg-gray-50 dark:hover:bg-gray-800 dark:bg-gray-700 hover:bg-gray-100 
                 dark:border-gray-600 dark:hover:border-gray-500"""
        ] [ 
          Html.div [ class "flex flex-col items-center justify-center pt-5 pb-6"] [ 
            svg [ 
              class "w-8 h-8 mb-4 text-gray-500 dark:text-gray-400"
            , Html.Attributes.attribute "aria-hidden" "true"
            , Svg.Attributes.fill "none"
            , Svg.Attributes.viewBox "0 0 24 24"
            ] [ 
              Svg.path [ 
                Svg.Attributes.stroke "currentColor"
              , Svg.Attributes.strokeLinecap "round"
              , Svg.Attributes.strokeLinejoin "round"
              , Svg.Attributes.strokeWidth "2"
              , Svg.Attributes.d "M13 13h3a3 3 0 0 0 0-6h-.025A5.56 5.56 0 0 0 16 6.5 5.5 5.5 0 0 0 5.207 5.021C5.137 5.017 5.071 5 5 5a4 4 0 0 0 0 8h2.167M10 15V6m0 0L8 8m2-2 2 2"
              ] []
            ]
            , Html.p [ class "mb-2 text-sm text-gray-500 dark:text-gray-400" ] [ 
                Html.span[ class "font-semibold" ] [ 
                  Html.text "Click to upload" 
                ]
                , Html.text " or drag and drop" 
            ]
            , Html.p [ class "text-xs text-gray-500 dark:text-gray-400" ] [ 
                Html.text "SVG, PNG, JPG or GIF (MAX. 800x400px)" 
            ]
          ]
        , Html.input [ id "dropzone-file", type_ "file", class "hidden", onClick CsvRequested ] []
        ]
      ]
    
    _ ->
      p [ ] [ Html.text <| String.join "\n" (List.map (\x -> Debug.toString x) model.csv) ]

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none