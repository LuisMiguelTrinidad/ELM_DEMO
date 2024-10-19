module Components.TableRow exposing (..)
import Types.Row exposing (Row)
import Html exposing (Html)
import Html.Attributes exposing (..)

tableRow: Row -> Html msg
tableRow r = Html.tr
                [ class "bg-white border-b hover:bg-gray-50"
                ]
                [ Html.th
                    [ scope "row"
                    , class "px-6 py-4 font-medium text-gray-900 whitespace-nowrap"
                    ]
                    [ Html.text <| String.fromFloat r.balance ]
                , Html.td
                    [ class "px-6 py-4"
                    ]
                    [ Html.text <| String.fromFloat r.amount ]
                , Html.td
                    [ class "px-6 py-4"
                    ]
                    [ Html.text r.modified ]
                , Html.td
                    [ class "px-6 py-4"
                    ]
                    [ Html.text r.instrumentSymbol ]
                ]
            