module Components.UploadButton exposing (..)

import Html as H 
import Html.Attributes as HA
import Html.Events exposing (onClick)
import Svg as S 
import Svg.Attributes as SA 


uploadButton : msg -> H.Html msg
uploadButton fileRequested =   
    H.div [ HA.class "flex items-center justify-center h-dvh w-dvw"] [
        H.div [ HA.class "flex w-1/3" ] [ 
            H.label [ HA.for "dropzone-file", HA.class """flex flex-col items-center justify-center w-full h-64 border-2 
                border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100 """ ] [ 
                H.div [ HA.class "flex flex-col items-center justify-center pt-5 pb-6" ] [ 
                    S.svg [ SA.class "w-24 h-24 text-gray-500 "
                        , HA.attribute "aria-hidden" "true"
                        , SA.fill "none"
                        , SA.viewBox "0 0 24 24"] [ 
                            S.path [ 
                                SA.stroke "currentColor"
                                , SA.strokeLinecap "round"
                                , SA.strokeLinejoin "round"
                                , SA.strokeWidth "1"
                                , SA.d "M13 13h3a3 3 0 0 0 0-6h-.025A5.56 5.56 0 0 0 16 6.5 5.5 5.5 0 0 0 5.207 5.021C5.137 5.017 5.071 5 5 5a4 4 0 0 0 0 8h2.167M10 15V6m0 0L8 8m2-2 2 2"
                            ] []
                        ]
                        , H.p [ HA.class "mb-2 text-sm text-gray-500 " ] [ 
                            H.span [ HA.class "font-semibold" ] [ 
                                H.text "Click to upload" 
                            ]
                        , H.text " or drag and drop"
                    ]
                    , H.p [ HA.class "text-xs text-gray-500 " ] [ 
                        H.text "CSV only" 
                    ]
                ]
                , H.input [ HA.id "dropzone-file", HA.type_ "file", HA.class "hidden", onClick fileRequested ] []
            ]
        ]
    ]
