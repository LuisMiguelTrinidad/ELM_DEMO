module Maintest exposing (Model, Msg, main)

import Browser
import Html exposing (Html, input)
import Html.Attributes as Attrs exposing (class, placeholder, type_)
import Html.Events exposing (onClick, onInput)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Transaction =
    { id : Int, balance : Float, amount : Float, transactionType : String, date : String, name : String }


type alias Model =
    { entries : List Entry, filter : Filter }


init : Model
init =
    { entries =
        [ Entry 0 "Astronomia Razonable" "El primero de la fila" 2001
        , Entry 1 "Como un burro amarrado a la puerta del baile" "El último de la fila" 2001
        , Entry 2 "Insurreción" "El último de la fila" 2201
        ]
    , filter = Filter "" "" 0 0
    }


type Msg
    = Add Entry
    | Remove Int
    | UpdateSongFilter String
    | UpdateArtistFilter String
    | UpdateStartYearFilter String
    | UpdateEndYearFilter String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add newEntry ->
            { model | entries = model.entries ++ [ newEntry ] }

        Remove id ->
            { model | entries = List.filter (\x -> x.id /= id) model.entries }

        UpdateSongFilter newFilter ->
            let
                allFilters =
                    model.filter

                newFilters =
                    { allFilters | songFilter = newFilter }
            in
            { model | filter = newFilters }

        UpdateArtistFilter newFilter ->
            let
                allFilters =
                    model.filter

                newFilters =
                    { allFilters | artistFilter = newFilter }
            in
            { model | filter = newFilters }

        UpdateStartYearFilter newFilter ->
            let
                allFilters =
                    model.filter

                newFilters =
                    { allFilters | startYearFilter = Maybe.withDefault 0 <| String.toInt newFilter }
            in
            { model | filter = newFilters }

        UpdateEndYearFilter newFilter ->
            let
                allFilters =
                    model.filter

                newFilters =
                    { allFilters | endYearFilter = Maybe.withDefault 0 <| String.toInt newFilter }
            in
            { model | filter = newFilters }

tableMiddleRow : Entry -> Html Msg
tableMiddleRow x =
    Html.tbody []
        [ Html.tr []
            [ Html.th [ class "p-4 text-left" ] [ Html.text x.song ]
            , Html.th [ class "p-4 text-left" ] [ Html.text x.artist ]
            , Html.th [ class "p-4 text-left" ] [ Html.text <| String.fromInt <| x.year ]
            ]
        ]

view : Model -> Html Msg
view model =
    Html.div [ class "h-screen flex-col items-center justify-center" ]
        [ Html.div [ class "flex-row" ]
            [ Html.input
                [ type_ "text"
                , class "bg-red-200 rounded-2xl p-2 m-2 text-black placeholder-slate-500"
                , placeholder "Song name"
                , onInput UpdateSongFilter
                ]
                []
            , Html.input
                [ type_ "text"
                , class " bg-red-200 rounded-2xl p-2 m-2 text-black placeholder-slate-500"
                , placeholder "Artist Name"
                , onInput UpdateArtistFilter
                ]
                []
            , Html.input
                [ type_ "number"
                , class " bg-red-200 rounded-2xl p-2 m-2 text-black placeholder-slate-500"
                , placeholder "Produced after"
                , onInput UpdateStartYearFilter
                ]
                []
            , Html.input
                [ type_ "number"
                , class " bg-red-200 rounded-2xl p-2 m-2 text-black placeholder-slate-500"
                , placeholder "Produced before"
                , onInput UpdateEndYearFilter
                ]
                []
            ]
        , Html.table [ class "table-auto border-collapse" ]
            (Html.thead []
                [ Html.tr []
                    [ Html.th [ class "p-4 bg-slate-700 border text-white text-left rounded-tl-2xl" ] [ Html.text "Songs" ]
                    , Html.th [ class "p-4 bg-slate-700 border text-white text-left" ] [ Html.text "Artist" ]
                    , Html.th [ class "p-4 bg-slate-700 border text-white text-left rounded-tr-2xl" ] [ Html.text "Year" ]
                    ]
                ]
                :: (List.filter (\x -> String.contains model.filter.songFilter x.song) model.entries
                        |> List.filter (\x -> String.contains model.filter.artistFilter x.artist)
                        |> List.filter (\x -> model.filter.startYearFilter <= x.year || model.filter.startYearFilter == 0)
                        |> List.filter (\x -> model.filter.endYearFilter >= x.year || model.filter.endYearFilter == 0)
                        |> List.map (\x -> tableMiddleRow x)
                   )
            )
        ]
