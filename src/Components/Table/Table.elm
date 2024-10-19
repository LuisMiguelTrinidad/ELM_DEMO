module Components.Table.Table exposing (investmentTable)

import Html as H exposing (Html)
import Html.Attributes as HA

import Components.Table.TableNav exposing (tableNav)
import Components.Table.TableHead exposing (tableHead)
import Components.Table.Tablebody exposing (tableBody)

import Types.Row exposing (Row)
import Types.Msg as Msg

investmentTable : List Row -> Int -> {column: Int, descending: Bool} ->Html Msg.Msg
investmentTable data index filter = 
    let
        sortedData = List.drop (10*index) data |> List.take 10
    in
    H.div [ HA.class "flex items-center justify-center"] [
        H.div [ HA.class "items-center justify-center py-28 w-4/5"] [
                H.table [ HA.class " text-left rtl:text-right text-gray-500 w-full "] [ 
                    tableHead filter
                    ,tableBody sortedData
                ]
                , tableNav index (List.length data)
            ]
    ]
    
