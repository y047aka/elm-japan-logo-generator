module Main exposing (main)

import Browser
import Html exposing (Html, img, input, label, li, node, text, ul)
import Html.Attributes exposing (checked, class, name, src, type_, value)
import Html.Events.Extra exposing (onChange)
import LogoImage exposing (LogoImage, Pattern(..), Usage(..), elmJapanLogo)


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
        [ viewUsageSelector
        , viewPatternSelector
        , elmJapanLogo model
        ]


viewUsageSelector : Html Msg
viewUsageSelector =
    let
        options =
            [ { value = "icon", text = "Icon" }
            , { value = "logo", text = "Logo" }
            , { value = "connpass", text = "Connpass" }
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
                    , text option.text
                    ]
                ]
    in
    ul [] (List.map listItem options)


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
    ul [] (List.map listItem options)
