module Components.Table.TableNav exposing (..)

import Html as H 
import Html.Attributes as HA

import Components.Table.TableNavLi exposing (tableNavLi)

import Types.Msg as Msg

tableNav: Int -> Int -> H.Html Msg.Msg
tableNav index total = 
    H.nav [ HA.class "flex items-center flex-column flex-wrap md:flex-row justify-between pt-4 bg-red w-full" ] [
        H.span [ HA.class "text-sm font-normal text-gray-500  mb-4 md:mb-0 block w-full md:inline md:w-auto "] [
            H.text "Showing "
           ,H.span [ HA.class "font-semibold text-gray-900"] [
                H.text <| String.fromInt (index*10+1) ++ " - " ++ String.fromInt ((index+1)*10)
            ]
           ,H.text " of "
           ,H.span [ HA.class "font-semibold text-gray-900"] [
                H.text <| String.fromInt (total)
            ]
        ]
       ,H.ul [ HA.class "inline-flex -space-x-px rtl:space-x-reverse text-sm h-8"] (
            tableNavLi index total
        )
    ]

