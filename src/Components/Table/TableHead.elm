module Components.Table.TableHead exposing (..)

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Svg as S
import Svg.Attributes as SA

import Types.Msg as Msg

tableHead : {column: Int, descending: Bool} -> H.Html Msg.Msg


tableHead filter = 
    let
        headers = [ "Balance after transaction"
            , "Earnings"
            , "Transaction type"
            , "Transaction date"
            , "Instrument Symbol"
            ]
        sortIcon descending =
            if descending then
                S.svg [ SA.class "fill-slate-500 w-7 h-7 flex", SA.viewBox "0 -960 960 960"] [ 
                    S.path[ SA.d "M480-360 280-560h400L480-360Z" ] []
                ]
            else
                S.svg [ SA.class "fill-slate-500 w-7 h-7 flex", SA.viewBox "0 -960 960 960"] [ 
                    S.path [ SA.d "m280-400 200-200 200 200H280Z" ] []
                ]
    
    in
    H.thead [ HA.class "text-xl text-gray-700 uppercase bg-gray-50" ] [ 
        H.tr [] (List.indexedMap (\index header -> 
                H.th [ HA.class "px-6 py-3 hover:cursor-pointer", HE.onClick <| Msg.SortBy index ] [ 
                    H.div [ HA.class "flex" ] [
                        H.div [ HA.class "flex"] [
                            H.text header
                        ],
                        H.div [ HA.class "flex"] [
                            if index == filter.column then
                                sortIcon filter.descending
                            else
                                S.svg [ SA.class "fill-transparent w-7 h-7 flex", SA.viewBox "0 -960 960 960"] [ 
                                    S.path [ SA.d "m280-400 200-200 200 200H280Z" ] []
                                ]
                        ]
                    ]
                ]

                ) headers)
    ]



