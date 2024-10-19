module GraficoPrueba exposing (..)

import Browser
import Chart as C
import Chart.Attributes as CA
import Html as H exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    {}


init : Model
init =
    {}


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html Msg
view model =
    H.div [ class "w-96" ]
        [ C.chart
            [ CA.height 300
            , CA.width 300
            ]
            [ C.xLabels []
            , C.yLabels [ CA.withGrid ]
            , C.bars []
                [ C.bar .z []
                , C.bar .y []
                ]
                [ { x = 1, y = 1, z = 3 }
                , { x = 2, y = 2, z = 1 }
                , { x = 3, y = 2, z = 4 }
                ]
            ]
        ]


main =
    Browser.sandbox { init = init, update = update, view = view }
