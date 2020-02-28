module Internal.ThirdView exposing (thirdView)

import Html exposing (Html, button, div, input, p, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


type alias Args msg =
    { thirdValue : String
    , updateThirdValue : String -> msg
    , jumpSecondPage : msg
    , confirmThirdValue : msg
    }


thirdView : Args msg -> Html msg
thirdView args =
    let
        { thirdValue, updateThirdValue, jumpSecondPage, confirmThirdValue } =
            args
    in
    div []
        [ p [] [ text "3/3" ]
        , p [] [ text <| "1文字以上、5文字以下の自由な文字" ]
        , input [ onInput updateThirdValue, value thirdValue ] []
        , button [ onClick jumpSecondPage ] [ text "prev" ]
        , button
            (if correctThirdValue thirdValue then
                [ onClick confirmThirdValue ]

             else
                []
            )
            [ text "end" ]
        ]


correctThirdValue : String -> Bool
correctThirdValue thirdValue =
    let
        thirdLength =
            String.length thirdValue
    in
    thirdLength > 0 && thirdLength <= 5
