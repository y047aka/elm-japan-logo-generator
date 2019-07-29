module LogoImage exposing (LogoImage, Pattern(..), Usage(..), elmJapanLogo)

import Html exposing (text)
import Svg exposing (Svg, g, polygon, rect, svg, text_)
import Svg.Attributes exposing (fill, fontFamily, fontSize, fontWeight, height, points, stroke, strokeWidth, transform, version, viewBox, width, x, y)



-- TYPE


type alias LogoImage =
    { usage : Usage
    , pattern : Pattern
    }


type Usage
    = Icon
    | Logo
    | Connpass


type Pattern
    = Elm
    | Custom String String


type alias Colors =
    { blue : String
    , green : String
    , navy : String
    , orange : String
    }


elmJapanLogo : LogoImage -> Svg msg
elmJapanLogo logoImage =
    let
        w =
            case logoImage.usage of
                Icon ->
                    500

                Logo ->
                    500 * 1.4727 |> round

                Connpass ->
                    500 * 2.444 |> round

        h =
            case logoImage.usage of
                Icon ->
                    500

                Logo ->
                    500

                Connpass ->
                    500

        transformSetting =
            case logoImage.usage of
                Icon ->
                    "scale(0.70) translate(75 130)"

                Logo ->
                    "scale(0.45) translate(80 330)"

                Connpass ->
                    "translate(440 210) scale(0.6)"

        backgroundColor =
            case logoImage.pattern of
                Elm ->
                    "#FFF"

                Custom bgColor fillColor ->
                    bgColor

        strokeColor =
            case logoImage.pattern of
                Elm ->
                    "#FFF"

                Custom strColor fillColor ->
                    strColor

        colors =
            case logoImage.pattern of
                Elm ->
                    { blue = "#60B5CC"
                    , green = "#7FD13B"
                    , navy = "#5A6378"
                    , orange = "#F0AD00"
                    }

                Custom bgColor fillColor ->
                    Colors fillColor fillColor fillColor fillColor
    in
    svg
        [ version "1.1"
        , width (String.fromInt w)
        , height (String.fromInt h)
        , viewBox ("0 0 " ++ String.fromInt w ++ " " ++ String.fromInt h)
        ]
        [ rect
            [ fill backgroundColor, x "0", y "0", width (String.fromInt w), height (String.fromInt h) ]
            []
        , g
            [ strokeWidth "12.5"
            , stroke strokeColor
            , transform transformSetting
            ]
            [ polygon
                [ fill colors.blue, points "200,0 200,200 0,200", transform "translate(262 100)" ]
                []
            , polygon
                [ fill colors.navy, points "0,0 200,200 0,200", transform "translate(120 300) rotate(-45)" ]
                []
            , polygon
                [ fill colors.green, points "0,0 100,0 200,100 100,100", transform "translate(120 299) rotate(-45)" ]
                []
            , polygon
                [ fill colors.orange, points "0,0 100,0 0,100", transform "translate(120 300) rotate(45)" ]
                []
            , polygon
                [ fill colors.blue, points "0,0 200,0 100,100", transform "translate(149 270) rotate(135)" ]
                []
            , rect
                [ fill colors.green, x "0", y "0", width "100", height "100", transform "translate(495 5) rotate(45)" ]
                []
            , polygon
                [ fill colors.orange, points "0,0, 100,0 0,100", transform "translate(395 300)" ]
                []
            ]
        , case logoImage.usage of
            Icon ->
                text ""

            Logo ->
                g [ fontFamily "source sans pro", fontWeight "600", fill colors.blue ]
                    [ text_ [ x "325", y "195", fontSize "54" ] [ text "Elm Japan 2019" ]
                    , text_ [ x "320", y "300", fontSize "115" ] [ text "Meetup" ]
                    , text_ [ x "327", y "340", fontSize "35" ] [ text "in Summer" ]
                    ]

            Connpass ->
                g [ fontFamily "source sans pro", fontWeight "600", fill colors.blue ]
                    [ text_ [ x "445", y "60", fontSize "49" ] [ text "Elm Japan 2019" ]
                    , text_ [ x "440", y "160", fontSize "105" ] [ text "Meetup" ]

                    -- , text_ [ x "440", y "160", fontSize "103" ] [ text "Moku*2" ]
                    -- , text_ [ x "442", y "160", fontSize "85" ] [ text "HandsOn" ]
                    , text_ [ x "447", y "195", fontSize "30" ] [ text "in Summer" ]

                    -- , text_ [ x "447", y "195", fontSize "30" ] [ text "in Kobe" ]
                    ]
        ]
