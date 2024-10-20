module Components.Charts.Graph0 exposing (..)

import Html as H
import Chart as C
import Chart.Attributes as CA
import Chart.Item as CI
import Chart.Events as CE
import Svg as S

import Types.Row as Row

import Services.GraphDataCleaner exposing (getGraph0Data)
import Types.Date as Date

graph0 : List Row.Row -> H.Html msg
graph0 data = C.chart [ 
        CA.height 600
      , CA.width 1400 
      , CA.margin { top = 40, bottom = 40, left = 10, right = 10 }
    ] [

        C.yTicks [ ]
      , C.yLabels [ CA.pinned .max, CA.flip, CA.format (\x -> String.fromFloat (x / 10) ) ]
      , C.yLabels [  ]
      , C.labelAt .max .max
        [ CA.alignMiddle ]
        [ S.text "Earnings per month" ]
      , C.labelAt .min .max
        [ CA.alignMiddle ]
        [ S.text "Total money" ]

      , C.bars [ CA.roundTop 0.25, CA.roundBottom 0.25 ] [
            C.bar (\x -> 10 * x.earnings) [ CA.gradient [ "#ffccf9", "#d79aff" ] ]
        ] (getGraph0Data data)
      , C.series (\ab -> ab.x+1) [ 
          C.interpolated (\x -> x.amount) [ CA.color "#ffaccd" ] [ CA.circle ] 
        ] (getGraph0Data data)
      , C.binLabels .label [ CA.moveDown 50 ]

      ]

      

