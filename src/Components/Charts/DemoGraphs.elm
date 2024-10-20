module Components.Charts.DemoGraphs exposing (..)

import Browser

import Html as H
import Html.Attributes as HA
import Chart as C
import Chart.Attributes as CA
import Chart.Item as CI
import Chart.Events as CE

import Svg.Attributes exposing (z)
import Html exposing (label)

--Main 

main = Browser.sandbox { init = init, update = update, view = view }

--Model
type alias Model = { hovering: List (CI.One Data CI.Bar) }

type alias Data = {
    x: Float
    , y: Float
    , z: Float
    , error: Float
    , label: String
    }

--Init

init : Model
init = { hovering = [] }

--Update

type Msg = OnHover (List (CI.One Data CI.Bar))

update : Msg -> Model -> Model
update msg model = 
    case msg of
        OnHover hovering -> 
            { model | hovering = hovering }

view : Model -> H.Html Msg
view data = 
    C.chart [ 
          CA.height 400
        , CA.width 1200
        , CA.padding { top = 10, bottom = 5, left = 10, right = 10 }
        , CE.onMouseMove OnHover (CE.getNearest CI.bars)
    ] [ 
        C.yAxis []
      , C.yTicks []
      , C.yLabels []
      , C.xAxis []
      , C.bars [] [
            C.bar .y [ ]
        ] [
            { x = 1, y = 2, z = 3, error = 0.5, label = "A" }
            , { x = 2, y = 3, z = 4, error = 0.5, label = "B" }
            , { x = 3, y = 4, z = 5, error = 0.5, label = "C" }
            , { x = 4, y = 5, z = 6, error = 0.5, label = "D" }
            , { x = 5, y = 6, z = 7, error = 0.5, label = "E" }
        ]
      , C.binLabels .label [ CA.moveDown 50 ]
      , C.each data.hovering <| \plane bar ->
            [ C.tooltip bar [ CA.onTop ] [] [] ]
    ]
