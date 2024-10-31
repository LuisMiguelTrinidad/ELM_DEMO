module Components.Table.TableRow exposing (..)
import Types.Row exposing (Row)
import Html as H 
import Html.Attributes as HAttr 

import Types.Date as Date

tableRow: Row -> H.Html msg
tableRow r = 
    let
        color =
            if r.amount > 0 then
                "text-green-400"
            else if r.amount == 0 then
                "text-yellow-400"
            else
                "text-red-400"
    in
    H.tr[ HAttr.class "bg-white border-b hover:bg-gray-100 text-lg" ] [ 
        H.td[ HAttr.class "px-6 py-4"] [ 
            H.text <| String.fromFloat r.balance 
        ]
        , H.td [ HAttr.class <| "px-6 py-4 font-bold " ++ color] [ 
            H.text <| String.fromFloat r.amount 
        ]
        , H.td [ HAttr.class "px-6 py-4 "] [ 
            H.text r.investmentType 
        ]
        , H.td[ HAttr.class "px-6 py-4" ] [ 
            H.text <| Date.toString r.modified 
        ]
        , H.td [ HAttr.class "px-6 py-4"] [ 
            H.text r.instrumentSymbol 
        ]
    ]
            