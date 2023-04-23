module Main exposing (main)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html exposing (div, i, span, text)
import Html.Attributes exposing (class)
import Icons
import Url exposing (Url)


type alias Flags =
    { title : String
    , description : String
    }


type alias Model =
    { title : String
    , description : String
    }


type Msg
    = OnUrlChange Url
    | OnUrlRequest UrlRequest


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags _ _ =
    ( { title = flags.title
      , description = flags.description
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Rust Elm"
    , body =
        -- [ Html.node "style"
        --     []
        --     [ text "{{css}}"
        --     ]
        [ div [ class "m-12 w-full flex items-center justify-center h-full text-lg bg-slate-800 dark:bg-red-800 text-black" ]
            [ div [ class "flex" ]
                [ i [ class "w-52 p-10 md:p-4" ]
                    [ Icons.elmLogo
                    ]
                , text "fdsa"
                , div [ class "flex items-center" ]
                    [ div [ class "text-blue-200 sm:text-slate-700 flex flex-col" ]
                        [ span [ class "text-2xl font-bold" ] [ text model.title ]
                        , span
                            [ class "text-slate-400"
                            ]
                            [ text model.description ]
                        ]
                    ]
                ]
            ]
        ]
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        , onUrlChange = OnUrlChange
        , onUrlRequest = OnUrlRequest
        }
