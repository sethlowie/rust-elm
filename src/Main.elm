module Main exposing (main)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html exposing (div, i, li, p, span, text, ul)
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
        [ div [ class "w-full flex items-center justify-center h-screen text-lg bg-slate-800 dark:bg-red-800 text-black" ]
            [ div [ class "flex" ]
                [ i [ class "w-52 p-10 md:p-4" ]
                    [ Icons.elmLogo
                    ]
                , div [ class "flex items-center" ]
                    [ div [ class "-mt-8 md:-mt-6 text-blue-200 flex flex-col" ]
                        [ span [ class "text-2xl font-bold" ] [ text model.title ]
                        , span
                            [ class "text-slate-400"
                            ]
                            [ text model.description ]
                        ]
                    ]
                ]
            ]
        , div [ class "h-screen flex p-10 flex-col text-left items-center justify-center space-y-2" ]
            [ div
                [ class "text-3xl w-full"
                ]
                [ text "Why choose Elm?"
                ]
            , p []
                [ text "Elm is an extraordinary choice for building web applications, thanks to its unique set of features. You'll experience benefits such as 'no runtime errors', 'small asset sizes', and 'outstanding performance' that make your web app stand out from the competition. Elm is designed to scale efficiently, providing you with a robust foundation for your project."
                ]
            ]
        , div [ class " text-slate-50 w-full flex items-center p-10 justify-center text-lg bg-slate-800 dark:bg-red-800 flex-col space-y-2" ]
            [ div [ class "text-slate-50 text-3xl w-full" ]
                [ text "Efficient bundling with a single JavaScript file"
                ]
            , p []
                [ text "Modern JavaScript development often suffers from bloated bundle sizes that hinder performance and SEO. Elm solves this problem by compiling your code into a single, incredibly efficient JavaScript file. Your web app will load faster, providing a superior user experience that leaves a lasting impression."
                ]
            , p []
                [ text "Your Elm application will maintain its performance even as it grows. With a 50k lines of code application resulting in just over 100kb of compiled, minified, and gzipped JavaScript, you can develop with confidence knowing that your app will continue to perform well."
                ]
            , p [ class "text-sm border-l-2 self-start pl-2 text-slate-400 border-slate-400" ]
                [ text "Note: Although Elm doesn't offer built-in code splitting, you can still achieve it by manipulating the generated JavaScript code. Stay tuned for our in-depth guide on code splitting in Elm." ]
            , div [ class "text-2xl pt-4 w-full" ]
                [ text "Simplify cache management for a seamless experience" ]
            , p []
                [ text "Effective caching is essential for web applications, but it can be a challenging task to manage. Elm's single-file approach simplifies cache management, allowing your app to deliver content faster while minimizing cache-related issues." ]
            , p []
                [ text "With only a few JavaScript files to manage, including the primary Elm app and third-party JavaScript files, you'll find it easier to maintain and optimize caching. We'll also be sharing a detailed guide on caching Elm applications to help you further enhance your app's performance." ]
            ]
        , div [ class "h-screen flex p-10 flex-col text-left items-center justify-center space-y-2" ]
            [ div [ class "text-slate-800 mt-12 text-2xl w-full" ]
                [ text "Experience the Power of TailwindCSS"
                ]
            , p []
                [ text "TailwindCSS is a highly customizable, utility-first CSS framework that streamlines your web app's design process, ensuring a consistent and modern look."
                ]
            , div [ class "text-slate-800 text-2xl w-full" ]
                [ text "Effortless Styling with Utility Classes"
                ]
            , p []
                [ text "TailwindCSS utilizes utility classes, enabling you to create beautiful designs with minimal custom CSS. These classes are designed to be composable, so you can quickly build complex layouts by combining them. This approach promotes consistency across your project, making it easier to maintain and expand your app's design."
                ]
            , div [ class "text-slate-800 text-2xl w-full" ]
                [ text "Responsive Design Made Simple"
                ]
            , p []
                [ text "TailwindCSS comes with built-in support for responsive design, making it easy to create web apps that look great on any device. The framework provides intuitive, mobile-first breakpoints that adapt your design to various screen sizes. You can effortlessly ensure that your web app provides an outstanding user experience, no matter the device." ]
            , div [ class "text-2xl pt-4 w-full" ]
                [ text "Customizable to Your Brand" ]
            , p []
                [ text "TailwindCSS is fully customizable, giving you the flexibility to adapt the framework to match your brand's identity. You can easily configure colors, typography, spacing, and more to create a unique look that reflects your brand's style. TailwindCSS's configuration system ensures that your customizations remain consistent and manageable throughout your project." ]
            , div [ class "text-2xl pt-4 w-full" ]
                [ text "Optimized for Performance" ]
            , p []
                [ text "TailwindCSS is built with performance in mind. By leveraging its built-in PurgeCSS support, you can automatically remove unused CSS during the production build, resulting in lean and optimized stylesheets. Your web app will load faster, delivering a smooth and responsive experience to your users." ]
            , p []
                [ text "Incorporate TailwindCSS into your Rust Elm web app and experience a seamless, efficient design process that results in a stunning and high-performing user interface." ]
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
