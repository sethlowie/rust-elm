module Main exposing (main)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html exposing (div, text)
import Html.Attributes exposing (class)
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
        [ Html.node "style"
            []
            [ text "{{css}}"
            ]
        , div [ class "w-full h-full text-lg bg-green-400 dark:bg-red-800 text-black" ]
            [ div [ class "text-black" ]
                [ text model.title
                ]
            , div [ class "text-black" ]
                [ text model.description
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
