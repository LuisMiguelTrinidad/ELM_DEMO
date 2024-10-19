module Components.Table.Tablebody exposing (..)

import Html as H exposing (Html)

import Components.Table.TableRow exposing (tableRow)

import Types.Row as Row
import Types.Msg as Msg

tableBody : List Row.Row -> Html Msg.Msg
tableBody data = H.tbody [] <| List.map (\x -> tableRow x) data