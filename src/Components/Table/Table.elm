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
        H.div [ HA.class "bg-gray-400 bg-opacity-20 backdrop-blur p-4 mx-8 rounded-3xl"] [
            H.div [HA.class "overflow-x-auto rounded-lg"] [
                H.table [ HA.class "text-left text-gray-500 w-full rounded-lg"] [ 
                    tableHead filter
                    ,tableBody sortedData
                ]
            ]
            , tableNav index (List.length data)

            ]
    
