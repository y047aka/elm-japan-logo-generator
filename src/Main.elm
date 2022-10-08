module Main exposing (main)

import Browser
import Html exposing (Html, footer, h1, header, img, input, label, li, nav, node, p, section, text, ul)
import Html.Attributes exposing (checked, class, name, src, type_, value)
import Html.Events exposing (onInput)
import Html.Events.Extra exposing (onChange)
import LogoImage exposing (Event(..), Pattern(..), Preference, Usage(..), svgBanner, svgIcon, svgLogo)


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
    { event : Event
    , subtitle : String
    , usage : Usage
    , pattern : Pattern
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { event = Meetup
      , subtitle = "in Summer"
      , usage = Logo
      , pattern = Original
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = EventChanged String
    | EventInInput String
    | PatternChanged String
    | UsageChanged String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EventChanged value ->
            case value of
                "handsOn" ->
                    ( { model | event = HandsOn }, Cmd.none )

                "meetup" ->
                    ( { model | event = Meetup }, Cmd.none )

                "moku*2" ->
                    ( { model | event = MokuMoku }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        EventInInput value ->
            ( { model | subtitle = value }, Cmd.none )

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
                "original" ->
                    ( { model | pattern = Original }, Cmd.none )

                "new" ->
                    ( { model | pattern = Custom "rgb(18, 147, 216)" "#FFF" }, Cmd.none )

                "prime" ->
                    ( { model | pattern = Custom "hsl(345, 100%, 37%)" "#FFF" }, Cmd.none )

                "option" ->
                    ( { model | pattern = Custom "#FFF" "hsl(345, 100%, 37%)" }, Cmd.none )

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
            [ viewPreview model
            , section [ class "update-msgs" ]
                [ nav []
                    [ h1 [] [ text "Event" ]
                    , viewEventSelector model
                    ]
                , nav []
                    [ h1 [] [ text "Subtitle" ]
                    , viewSubtitleForm model
                    ]
                , nav []
                    [ h1 [] [ text "Theme" ]
                    , viewPatternSelector
                    ]
                , nav []
                    [ h1 [] [ text "Size" ]
                    , viewUsageSelector model
                    ]
                ]
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


viewEventSelector : Model -> Html Msg
viewEventSelector model =
    let
        options =
            [ { value = "handsOn", text = "HandsOn" }
            , { value = "meetup", text = "Meetup" }
            , { value = "moku*2", text = "Moku*2" }
            ]

        listItem option =
            li []
                [ label []
                    [ input
                        [ type_ "radio"
                        , name "eventSetting"
                        , value option.value
                        , onChange EventChanged
                        ]
                        []
                    , text option.text
                    ]
                ]
    in
    ul [ class "event-selector" ] (List.map listItem options)


viewSubtitleForm : Model -> Html Msg
viewSubtitleForm model =
    ul [ class "in-form" ]
        [ li []
            [ label []
                [ input
                    [ type_ "text"
                    , value model.subtitle
                    , onInput EventInInput
                    ]
                    []
                ]
            ]
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
            [ { value = "new", text = "New" }
            , { value = "original", text = "Original" }
            , { value = "prime", text = "Prime" }
            , { value = "option", text = "Option" }
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
        [ p [ class "copyright" ] [ text "© 2022 y047aka" ]
        ]
