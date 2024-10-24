module Components.Charts.Graph1 exposing (..)

import Html as H
import Html.Attributes as HA
import Chart as C
import Chart.Attributes as CA
import Chart.Item as CI
import Chart.Events as CE
import Svg as S
import Svg.Attributes as SA

import Types.GraphTypes as GT 
import Types.Msg as Msg

graph1 : List GT.Graph1Data -> GT.Hovering1Data -> H.Html Msg.Msg
graph1 data hoveringdata = H.div [HA.class "p-24 bg-white rounded-lg"] [
        C.chart [ 
            CA.height 500
        , CA.width 1400 
        , CA.margin { top = 40, bottom = 40, left = 10, right = 10 }
        , CE.onMouseMove Msg.OnHoverG1 (CE.getNearest CI.bins)
        , CE.onMouseLeave (Msg.OnHoverG1 [])
        ] [
            C.yTicks [ ]
        , C.yLabels [ CA.pinned .max, CA.flip, CA.format (\x -> String.fromFloat x ++ " €" ) ]
        , C.yLabels [ ]
        , C.labelAt .max .max
                [ CA.alignMiddle, CA.color "#FDBFA1", CA.fontSize 22 ]
                [ H.text "Nº of investments"]
        , C.labelAt .min .max
                [ CA.alignMiddle, CA.color "#EBB3FC" ,CA.fontSize 22 ]
                [ S.text "Earnings" ]
        , C.bars [ CA.roundTop 0.15, CA.roundBottom 0.15, CA.spacing 0.02 ] [
                C.bar .moneyEarned [ CA.gradient [ "#ffccf9", "#d79aff" ] ],
                C.bar .transactionAmmount [ CA.gradient [ "#ffcc7d", "#FBB1C4" ] ]
            ] data
        , C.binLabels .company [ CA.moveDown 150]

        , C.each hoveringdata <| \p item ->
                let
                    barSetData = 
                                case List.head (CI.getDatas item) of
                                        Just info -> info
                                        Nothing -> {company = "", transactionAmmount = 0, moneyEarned = 0}
                in
                [ C.tooltip item [ CA.onTop ] [] [ 
                    H.div [] [ 
                            H.span [ HA.class "font-bold"] [
                                    H.text ("Compañía: ")
                            ]
                            , H.text (barSetData.company)
                    ]
                    , H.div [] [ 
                            H.span [ HA.class "text-[#EBB3FC] font-bold"] [
                                    H.text ("Dinero ganado: ")
                            ]
                            , H.text (String.fromFloat (toFloat(round(100 * (barSetData.moneyEarned)))/100) ++ " €")
                    ]
                    , H.div [] [
                            H.span [ HA.class "text-[#FDBFA1] font-bold"] [
                                    H.text ("Transacciones realizadas: ")
                            ]
                            , H.text ((String.fromFloat barSetData.transactionAmmount))
                        ]
                    ] 
                ]
        ]
    ]

      

