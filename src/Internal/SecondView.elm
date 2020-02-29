module Internal.SecondView exposing (correctSecondValue, secondView)

import Html exposing (Html, button, div, input, p, text)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onClick, onInput)


type alias FirstSecondValue =
    { firstValue : Int
    , secondValue : String
    }


type alias Args msg =
    { firstSecondValue : FirstSecondValue
    , updateSecondValue : String -> msg
    , jumpFirstPage : msg
    , confirmSecondValue : msg
    }


secondView : Args msg -> Html msg
secondView args =
    let
        { firstSecondValue, updateSecondValue, jumpFirstPage, confirmSecondValue } =
            args

        { firstValue, secondValue } =
            firstSecondValue
    in
    div []
        [ p [] [ text "2/3" ]
        , p [] [ text <| "FirstValue: " ++ String.fromInt firstValue ]
        , p [] [ text <| "0 ~ 5 -> A or B or C, 6 ~ 9 -> D or E or F" ]
        , input [ type_ "text", onInput updateSecondValue, value secondValue ] []
        , button
            [ onClick jumpFirstPage ]
            [ text "prev" ]
        , button
            (if correctSecondValue firstSecondValue then
                [ onClick confirmSecondValue ]

             else
                []
            )
            [ text "next" ]
        ]


correctSecondValue : FirstSecondValue -> Bool
correctSecondValue firstSecondValue =
    case firstSecondValue of
        { firstValue, secondValue } ->
            (firstValue <= 5 && List.member secondValue [ "A", "B", "C" ])
                || (firstValue > 5 && firstValue <= 9 && List.member secondValue [ "D", "E", "F" ])
