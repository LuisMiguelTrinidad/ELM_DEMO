module Components.Charts.Graph0 exposing (..)

import Html as H
import Html.Attributes as HA
import Chart as C
import Chart.Attributes as CA
import Chart.Item as CI
import Chart.Events as CE
import Svg as S

import Types.Msg as Msg
import Types.GraphTypes as GT




graph0 : List GT.Graph0Data -> GT.Hovering0Data -> H.Html Msg.Msg
graph0 data hoveringdata = H.div [HA.class "p-24 bg-white rounded-lg"] [
    C.chart [ 
            CA.height 500
            , CA.width 1400 
            , CA.margin { top = 40, bottom = 40, left = 10, right = 10 }
            , CE.onMouseLeave (Msg.OnHoverG0 [] [])
            , CE.on "mousemove" <|
                CE.map2 Msg.OnHoverG0
                    (CE.getNearestX CI.bars)
                    (CE.getNearestX CI.dots)
        ] [
            C.yTicks [ ]
        , C.yLabels [ CA.pinned .max, CA.flip, CA.format (\x -> String.fromFloat (x/4) ++ " €") ]
        , C.yLabels [ CA.format (\x -> String.fromFloat (10000 + x) ++ " €" ) ]
        , C.labelAt .max (\x -> x.max + 200)
                [ CA.alignMiddle, CA.color "#ffccf9", CA.fontSize 22 ]
                [ H.text "Earnings per month"]
        , C.labelAt .min (\x -> x.max + 200)
                [ CA.alignMiddle, CA.color "#ffcc7d", CA.fontSize 22 ]
                [ S.text "Total money" ]
        , C.bars [ CA.roundTop 0.15, CA.roundBottom 0.1] [
                C.bar (\x ->  x.earnings*4) [ CA.gradient [ "#ffccf9", "#d79aff" ] ]
            ] data
        , C.series (\ab -> ab.x + 1) [ 
                C.interpolated (\x -> x.amount - 10000) [ CA.color "#ffcc7d", CA.monotone, CA.opacity 0.2, CA.gradient [ "#ffcc7d", "#f79aff" ] ] [ CA.circle ] 
            ] data
        , C.binLabels .label [ CA.moveDown 50 ]
        , C.each (List.map2 (\bar dot -> (bar, dot)) hoveringdata.bars hoveringdata.dots) <| \_ (bar, dot) -> [ 
                C.tooltip dot [ CA.onTop ] [] [ 
                    H.div [ ] [ 
                        H.span [ HA.class "text-[#d79aff] font-bold"] [
                                H.text ("Generated this month: ")
                        ]
                        , H.text (String.fromFloat (toFloat(round(100 * (CI.getY bar)))/400) ++ " €") 
                        , H.br [] []
                        , H.span [ HA.class "text-[#ffcc7d] font-bold"] [
                                H.text ("Accumulated money: ")
                        ]
                        , H.text (String.fromFloat (10000 + CI.getY dot) ++ " €")
                    ]

                ]
            ]
        ]
    ]
      

