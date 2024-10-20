module Components.Charts.Graph1 exposing (..)

import Html as H
import Html.Attributes as HA
import Chart as C
import Chart.Attributes as CA
import Chart.Item as CI
import Chart.Events as CE
import Svg as S

import Types.Row as Row

import Services.GraphDataCleaner exposing (getGraph1Data)
import Types.Date as Date



graph1 : List Row.Row -> H.Html msg
graph1 data = C.chart [ 
        CA.height 500
      , CA.width 1400 
      , CA.margin { top = 40, bottom = 40, left = 10, right = 10 }
    ] [
        C.yTicks [ ]
      , C.yLabels [ CA.pinned .max, CA.flip, CA.format (\x -> String.fromFloat x ++ " €" ) ]
      , C.yLabels [ ]
      , C.labelAt .max .max
            [ CA.alignMiddle, CA.color CA.pink, CA.fontSize 22 ]
            [ H.text "Dinero generado"]
      , C.labelAt .min .max
            [ CA.alignMiddle, CA.color CA.blue, CA.fontSize 22 ]
            [ S.text "Numero de inversiones" ]
      , C.bars [ CA.roundTop 0.25, CA.roundBottom 0.25 ] [
            C.bar .moneyEarned [  ],
            C.bar .transactionAmmount [  ]
        ] (getGraph1Data data)
      , C.binLabels .company [ CA.moveDown 50 ]
      ]

      

