module Form exposing (correctSecondValueSuite, textToADigitNumberSuite)

import Expect
import Internal.FirstView exposing (textToADigitNumber)
import Internal.SecondView exposing (correctSecondValue)
import Test exposing (Test, describe, test)


textToADigitNumberSuite : Test
textToADigitNumberSuite =
    describe "textToADigitNumberSuite"
        [ describe "正常系: 1桁の数字"
            [ describe "文字列の0は"
                [ test "数字の0となる" <|
                    \_ ->
                        "0"
                            |> textToADigitNumber
                            |> Expect.equal (Just 0)
                ]
            , describe "文字列の9は"
                [ test "数字の9となる" <|
                    \_ ->
                        "9"
                            |> textToADigitNumber
                            |> Expect.equal (Just 9)
                ]
            ]
        , describe "異常系: 2桁以上の数字"
            [ describe "文字列の10は"
                [ test "Nothingになる" <|
                    \_ ->
                        "10"
                            |> textToADigitNumber
                            |> Expect.equal Nothing
                ]
            , describe "文字列の100は"
                [ test "Nothingになる" <|
                    \_ ->
                        "100"
                            |> textToADigitNumber
                            |> Expect.equal Nothing
                ]
            ]
        , describe "異常系: 数字以外の文字列"
            [ describe "アルファベットのaは"
                [ test "Nothingになる" <|
                    \_ ->
                        "a"
                            |> textToADigitNumber
                            |> Expect.equal Nothing
                ]
            , describe "記号の!は"
                [ test "Nothingになる" <|
                    \_ ->
                        "!"
                            |> textToADigitNumber
                            |> Expect.equal Nothing
                ]
            ]
        ]


correctSecondValueSuite : Test
correctSecondValueSuite =
    let
        helper arg =
            describe
                ("firstValue = "
                    ++ String.fromInt arg.firstValue
                    ++ ", secondValue = "
                    ++ arg.secondValue
                )
                [ test
                    (if arg.expected then
                        "正しい"

                     else
                        "誤り"
                    )
                  <|
                    \_ ->
                        { firstValue = arg.firstValue, secondValue = arg.secondValue }
                            |> correctSecondValue
                            |> Expect.equal arg.expected
                ]
    in
    describe "correctSecondValueSuite"
        [ describe "正常系: 0, 5に対してA,B,Cの組み合わせは正しい"
            [ helper { firstValue = 0, secondValue = "A", expected = True }
            , helper { firstValue = 0, secondValue = "B", expected = True }
            , helper { firstValue = 0, secondValue = "C", expected = True }
            , helper { firstValue = 5, secondValue = "A", expected = True }
            , helper { firstValue = 5, secondValue = "B", expected = True }
            , helper { firstValue = 5, secondValue = "C", expected = True }
            ]
        , describe "正常系: 6, 9に対してD, E, Fの組み合わせは正しい"
            [ helper { firstValue = 6, secondValue = "D", expected = True }
            , helper { firstValue = 6, secondValue = "E", expected = True }
            , helper { firstValue = 6, secondValue = "F", expected = True }
            , helper { firstValue = 9, secondValue = "D", expected = True }
            , helper { firstValue = 9, secondValue = "E", expected = True }
            , helper { firstValue = 9, secondValue = "F", expected = True }
            ]
        , describe "異常系: 0, 5に対してD, E, Fの組み合わせは誤り"
            [ helper { firstValue = 0, secondValue = "D", expected = False }
            , helper { firstValue = 0, secondValue = "E", expected = False }
            , helper { firstValue = 0, secondValue = "F", expected = False }
            , helper { firstValue = 5, secondValue = "D", expected = False }
            , helper { firstValue = 5, secondValue = "E", expected = False }
            , helper { firstValue = 5, secondValue = "F", expected = False }
            ]
        , describe "異常系: 6, 9に対してA, B, Cの組み合わせは誤り"
            [ helper { firstValue = 6, secondValue = "A", expected = False }
            , helper { firstValue = 6, secondValue = "B", expected = False }
            , helper { firstValue = 6, secondValue = "C", expected = False }
            , helper { firstValue = 9, secondValue = "A", expected = False }
            , helper { firstValue = 9, secondValue = "B", expected = False }
            , helper { firstValue = 9, secondValue = "C", expected = False }
            ]
        , describe "異常系: それ以外"
            [ helper { firstValue = 0, secondValue = "ABC", expected = False }
            , helper { firstValue = 9, secondValue = "ABC", expected = False }
            , helper { firstValue = -10000, secondValue = "ABC", expected = False }
            , helper { firstValue = 10000, secondValue = "ABC", expected = False }
            ]
        ]
