module Main exposing (main)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)


main : Html msg
main =
    div [ class "h-full w-full" ]
        [ Html.node "style"
            []
            [ text "{{css}}"
            ]
        , div [ class "w-full h-full text-lg bg-green-400 dark:bg-red-800 text-black" ]
            [ text "waffles----"
            ]
        ]
