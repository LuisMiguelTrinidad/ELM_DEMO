module Components.UploadButton exposing (..)

import Html exposing (Html)
import Html.Attributes 
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes exposing (..)


uploadButton : msg -> Html msg
uploadButton fileRequested =
  Html.div [ class "flex items-center justify-center w-full" ]
    [ Html.label
      [ Html.Attributes.for "dropzone-file"
      , class """flex flex-col items-center justify-center w-full h-64 border-2 border-gray-300 border-dashed rounded-lg 
            cursor-pointer bg-gray-50 dark:hover:bg-gray-800 dark:bg-gray-700 hover:bg-gray-100 
            dark:border-gray-600 dark:hover:border-gray-500"""
      ]
      [ Html.div [ class "flex flex-col items-center justify-center pt-5 pb-6" ]
        [ svg
          [ class "w-8 h-8 mb-4 text-gray-500 dark:text-gray-400"
          , Html.Attributes.attribute "aria-hidden" "true"
          , Svg.Attributes.fill "none"
          , Svg.Attributes.viewBox "0 0 24 24"
          ]
          [ Svg.path
            [ Svg.Attributes.stroke "currentColor"
            , Svg.Attributes.strokeLinecap "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M13 13h3a3 3 0 0 0 0-6h-.025A5.56 5.56 0 0 0 16 6.5 5.5 5.5 0 0 0 5.207 5.021C5.137 5.017 5.071 5 5 5a4 4 0 0 0 0 8h2.167M10 15V6m0 0L8 8m2-2 2 2"
            ] []
          ]
        , Html.p [ class "mb-2 text-sm text-gray-500 dark:text-gray-400" ]
          [ Html.span [ class "font-semibold" ] [ Html.text "Click to upload" ]
          , Html.text " or drag and drop"
          ]
        , Html.p [ class "text-xs text-gray-500 dark:text-gray-400" ]
          [ Html.text "SVG, PNG, JPG or GIF (MAX. 800x400px)" ]
        ]
      , Html.input [ id "dropzone-file", type_ "file", class "hidden", onClick fileRequested ] []
      ]
    ]
