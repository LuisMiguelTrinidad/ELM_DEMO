module Components.UploadButton exposing (..)

import Html as H exposing (Html)
import Html.Attributes as HAttr
import Html.Events exposing (onClick)
import Svg as S  exposing (..)
import Svg.Attributes as SAttr exposing (..)


uploadButton : msg -> Html msg
uploadButton fileRequested =   
    H.div [ HAttr.class "flex items-center justify-center h-dvh w-dvw"] [
        H.div [ HAttr.class "flex w-1/3 " ] [ 
            H.label [ HAttr.for "dropzone-file", HAttr.class """flex flex-col items-center justify-center w-full h-64 border-2 
                border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100 """ ] [ 
                H.div [ HAttr.class "flex flex-col items-center justify-center pt-5 pb-6" ] [ 
                    svg [ SAttr.class "w-24 h-24 text-gray-500 "
                        , HAttr.attribute "aria-hidden" "true"
                        , SAttr.fill "none"
                        , SAttr.viewBox "0 0 24 24"] [ 
                            S.path [ 
                                SAttr.stroke "currentColor"
                                , SAttr.strokeLinecap "round"
                                , SAttr.strokeLinejoin "round"
                                , SAttr.strokeWidth "1"
                                , SAttr.d "M13 13h3a3 3 0 0 0 0-6h-.025A5.56 5.56 0 0 0 16 6.5 5.5 5.5 0 0 0 5.207 5.021C5.137 5.017 5.071 5 5 5a4 4 0 0 0 0 8h2.167M10 15V6m0 0L8 8m2-2 2 2"
                            ] []
                    ]
                    , H.p [ HAttr.class "mb-2 text-sm text-gray-500 " ] [ 
                        H.span [ class "font-semibold" ] [ 
                            H.text "Click to upload" 
                        ]
                        , H.text " or drag and drop"
                    ]
                    , H.p [ HAttr.class "text-xs text-gray-500 " ] [ 
                        H.text "CSV only" 
                    ]
                ]
                , H.input [ id "dropzone-file", type_ "file", class "hidden", onClick fileRequested ] []
            ]
        ]
    ]
