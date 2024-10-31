module Components.Table.TableNavLi exposing (tableNavLi)

import Html as H 
import Html.Attributes as HA
import Html.Events as HE

import Types.Msg as Msg

tableNavLi: Int -> Int -> List (H.Html Msg.Msg)
tableNavLi index total =
    let
        navIndexes = 
            if index<=1 then
                List.range 0 4
            else if (total//10) - index <= 1 then
                List.range ((total//10)-4) (total//10)
            else
                List.range (index-2) (index+2)
    in
    (
        if index /= 0 then
            [ 
                H.li [ HA.class "flex items-center px-3 hover:bg-gray-100 hover:text-gray-700 rounded-s-lg hover:cursor-pointer"
              , HE.onClick (Msg.ChangeIndex (index - 1))] [
                    H.text "Previous"
                ]
            ]
        else
            []
    ) 
    ++
    (
        List.map (\i -> 
            H.li [ HA.class "flex items-center px-3 hover:bg-gray-100 hover:text-gray-700 rounded-lg hover:cursor-pointer"
                , HE.onClick (Msg.ChangeIndex i)] [
                    H.text (String.fromInt i)
                ]
        ) 
        navIndexes
    ) 
    ++
    (
        if index /= ((total + 1) // 10) then
            [ 
                H.li [ HA.class "flex items-center px-3 hover:bg-gray-100 hover:text-gray-700 rounded-e-lg hover:cursor-pointer"
              , HE.onClick (Msg.ChangeIndex (index + 1))] [
                    H.text "Next"
                ]
            ]
        else
            []
    )
