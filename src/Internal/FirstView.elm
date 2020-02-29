module Internal.FirstView exposing (firstView, textToADigitNumber)

import Html exposing (Html, button, div, input, p, text)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onClick, onInput)


type alias Args msg =
    { firstValue : String
    , updateFirstValue : String -> msg
    , confirmFirstValue : Int -> msg
    }


firstView : Args msg -> Html msg
firstView args =
    let
        { firstValue, updateFirstValue, confirmFirstValue } =
            args
    in
    div []
        [ p [] [ text "1/3" ]
        , p [] [ text "1桁の数字を入れてね" ]
        , input [ type_ "text", onInput updateFirstValue, value firstValue ] []
        , button
            (case textToADigitNumber firstValue of
                Just num ->
                    [ onClick <| confirmFirstValue num ]

                Nothing ->
                    []
            )
            [ text "next" ]
        ]


textToADigitNumber : String -> Maybe Int
textToADigitNumber text =
    case ( String.length text, String.toInt text ) of
        ( 1, Just num ) ->
            Just num

        _ ->
            Nothing
