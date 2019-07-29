module LogoImage exposing (LogoImage, Pattern(..), Usage(..), svgBanner, svgIcon, svgLogo)

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
    = Original
    | Custom String String


type alias Colors =
    { blue : String
    , green : String
    , navy : String
    , orange : String
    }


japanArchipelago : LogoImage -> Svg msg
japanArchipelago preference =
    let
        transformSetting =
            case preference.usage of
                Connpass ->
                    -- "translate(440 210) scale(0.6)"
                    ""

                _ ->
                    ""

        strokeColor =
            case preference.pattern of
                Original ->
                    "#FFF"

                Custom strColor fillColor ->
                    strColor

        colors =
            case preference.pattern of
                Original ->
                    { blue = "#60B5CC"
                    , green = "#7FD13B"
                    , navy = "#5A6378"
                    , orange = "#F0AD00"
                    }

                Custom bgColor fillColor ->
                    Colors fillColor fillColor fillColor fillColor
    in
    g
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


svgIcon : LogoImage -> Svg msg
svgIcon preference =
    let
        w =
            "500"

        h =
            "500"

        backgroundColor =
            case preference.pattern of
                Original ->
                    "#FFF"

                Custom bgColor fillColor ->
                    bgColor
    in
    svg
        [ version "1.1"
        , width w
        , height h
        , viewBox ("0 0 " ++ w ++ " " ++ h)
        ]
        [ rect
            [ fill backgroundColor, x "0", y "0", width w, height h ]
            []
        , g
            [ transform "scale(0.70) translate(75 130)" ]
            [ japanArchipelago preference ]
        ]


svgLogo : LogoImage -> Svg msg
svgLogo preference =
    let
        w =
            500 * 1.4727 |> round |> String.fromInt

        h =
            "500"

        backgroundColor =
            case preference.pattern of
                Original ->
                    "#FFF"

                Custom bgColor fillColor ->
                    bgColor

        colors =
            case preference.pattern of
                Original ->
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
        , width w
        , height h
        , viewBox ("0 0 " ++ w ++ " " ++ h)
        ]
        [ rect
            [ fill backgroundColor, x "0", y "0", width w, height h ]
            []
        , g
            [ transform "scale(0.45) translate(80 330)" ]
            [ japanArchipelago preference ]
        , g
            [ fontFamily "source sans pro", fontWeight "600", fill colors.blue ]
            [ text_ [ x "325", y "195", fontSize "54" ] [ text "Elm Japan 2019" ]
            , text_ [ x "320", y "300", fontSize "115" ] [ text "Meetup" ]
            , text_ [ x "327", y "340", fontSize "35" ] [ text "in Summer" ]
            ]
        ]


svgBanner : LogoImage -> Svg msg
svgBanner preference =
    let
        w =
            500 * 2.444 |> round |> String.fromInt

        h =
            "500"

        backgroundColor =
            case preference.pattern of
                Original ->
                    "#FFF"

                Custom bgColor fillColor ->
                    bgColor

        colors =
            case preference.pattern of
                Original ->
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
        , width w
        , height h
        , viewBox ("0 0 " ++ w ++ " " ++ h)
        ]
        [ rect
            [ fill backgroundColor, x "0", y "0", width w, height h ]
            []
        , g
            [ transform "translate(440 210) scale(0.6)" ]
            [ japanArchipelago preference ]
        , g
            [ fontFamily "source sans pro", fontWeight "600", fill colors.blue ]
            [ text_ [ x "445", y "60", fontSize "49" ] [ text "Elm Japan 2019" ]
            , text_ [ x "440", y "160", fontSize "105" ] [ text "Meetup" ]

            -- , text_ [ x "440", y "160", fontSize "103" ] [ text "Moku*2" ]
            -- , text_ [ x "442", y "160", fontSize "85" ] [ text "HandsOn" ]
            , text_ [ x "447", y "195", fontSize "30" ] [ text "in Summer" ]

            -- , text_ [ x "447", y "195", fontSize "30" ] [ text "in Kobe" ]
            ]
        ]
