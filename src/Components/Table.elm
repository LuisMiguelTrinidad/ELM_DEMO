module Components.Table exposing (investmentTable)

import Html exposing (Html)
import Html.Attributes exposing (..)

import Types.Row exposing (Row)
import Components.TableRow exposing (tableRow)



investmentTable : List Row -> Html msg
investmentTable data = 
    Html.table [ class "w-full text-sm text-left rtl:text-right text-gray-500 "] [ 
        Html.thead [ class "text-xs text-gray-700 uppercase bg-gray-50 " ] [ 
            Html.tr [] [ 
                Html.th [ scope "col", class "px-6 py-3"] [ 
                    Html.text "Balance after transaction" 
                ]
                , Html.th [ scope "col" , class "px-6 py-3" ] [ 
                    Html.text "Earnings " 
                ]
                , Html.th [ scope "col", class "px-6 py-3" ] [ 
                    Html.text "Transaction date " 
                ]
                , Html.th[ scope "col" , class "px-6 py-3" ] [ 
                    Html.text "Instrument Symbol " 
                ]
            ]
        ],
        Html.tbody [] (List.map (\x -> tableRow x) data)
    ]