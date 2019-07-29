module Main exposing (main)

import Browser
import Html exposing (Html, footer, h1, header, img, input, label, li, node, p, section, text, ul)
import Html.Attributes exposing (checked, class, name, src, type_, value)
import Html.Events.Extra exposing (onChange)
import LogoImage exposing (LogoImage, Pattern(..), Usage(..), svgBanner, svgIcon, svgLogo)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { usage : Usage
    , pattern : Pattern
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { usage = Icon
      , pattern = Custom "hsl(345, 100%, 37%)" "#FFF"
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp
    | PatternChanged String
    | UsageChanged String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UsageChanged value ->
            case value of
                "icon" ->
                    ( { model | usage = Icon }, Cmd.none )

                "logo" ->
                    ( { model | usage = Logo }, Cmd.none )

                "connpass" ->
                    ( { model | usage = Connpass }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        PatternChanged value ->
            case value of
                "elm" ->
                    ( { model | pattern = Elm }, Cmd.none )

                "prime" ->
                    ( { model | pattern = Custom "hsl(345, 100%, 37%)" "#FFF" }, Cmd.none )

                "option" ->
                    ( { model | pattern = Custom "#FFF" "hsl(345, 100%, 37%)" }, Cmd.none )

                "summer" ->
                    ( { model | pattern = Custom "#60B5CC" "#FFF" }, Cmd.none )

                _ ->
                    ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    node "body"
        []
        [ siteHeader
        , node "main"
            []
            [ viewUsageSelector model
            , viewPatternSelector
            , viewPreview model
            ]
        , siteFooter
        ]


siteHeader : Html Msg
siteHeader =
    header [ class "site-header" ]
        [ h1 [] [ text "Elm Japan Logo Generator" ]
        ]


viewPreview : Model -> Html Msg
viewPreview model =
    section [ class "preview" ]
        [ case model.usage of
            Icon ->
                svgIcon model

            Logo ->
                svgLogo model

            Connpass ->
                svgBanner model
        ]


viewUsageSelector : Model -> Html Msg
viewUsageSelector model =
    let
        options =
            [ { value = "icon", svg = svgIcon model }
            , { value = "logo", svg = svgLogo model }
            , { value = "connpass", svg = svgBanner model }
            ]

        listItem option =
            li []
                [ label []
                    [ input
                        [ type_ "radio"
                        , name "usageSetting"
                        , value option.value
                        , onChange UsageChanged
                        ]
                        []
                    , option.svg
                    ]
                ]
    in
    ul [ class "usage-selector" ] (List.map listItem options)


viewPatternSelector : Html Msg
viewPatternSelector =
    let
        options =
            [ { value = "prime", text = "Prime" }
            , { value = "option", text = "Option" }
            , { value = "summer", text = "Summer" }
            , { value = "elm", text = "Elm" }
            ]

        listItem option =
            li []
                [ label [ class option.value ]
                    [ input
                        [ type_ "radio"
                        , name "colorSetting"
                        , value option.value
                        , onChange PatternChanged
                        ]
                        []
                    , text option.text
                    ]
                ]
    in
    ul [ class "pattern-selector" ] (List.map listItem options)


siteFooter : Html Msg
siteFooter =
    footer [ class "site-footer" ]
        [ p [ class "copyright" ] [ text "© 2019 y047aka" ]
        ]
