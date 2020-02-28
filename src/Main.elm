module Main exposing (main)

import Browser
import Html exposing (Html, div, p, text)
import Internal.FirstView exposing (firstView)
import Internal.SecondView exposing (secondView)
import Internal.ThirdView exposing (thirdView)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL


type Page
    = First
    | Second
    | Third
    | Final


type alias FormValue =
    { first : String
    , second : String
    , third : String
    }


type alias DecodeValue =
    { first : Int
    , second :
        String
    , third : String
    }


type alias Model =
    { page : Page
    , formValue : FormValue
    , decodeValue : DecodeValue
    }


initFormValue : FormValue
initFormValue =
    { first = "", second = "", third = "" }


initDecodeValue : DecodeValue
initDecodeValue =
    { first = 0, second = "", third = "" }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { page = First
      , formValue = initFormValue
      , decodeValue = initDecodeValue
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = PageChange Page
    | UpdateFirstValue String
    | UpdateSecondValue String
    | UpdateThirdValue String
    | ConfirmFirstValue Int
    | ConfirmSecondValue
    | ConfirmThirdValue


updateFormValue : Model -> (FormValue -> FormValue) -> FormValue
updateFormValue model f =
    let
        formValue =
            model.formValue
    in
    f formValue


updateDecodeValue : Model -> (DecodeValue -> DecodeValue) -> DecodeValue
updateDecodeValue model f =
    let
        decodeValue =
            model.decodeValue
    in
    f decodeValue


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        formValue =
            model.formValue
    in
    case msg of
        PageChange page ->
            ( { model | page = page }, Cmd.none )

        UpdateFirstValue firstValue ->
            ( { model
                | formValue =
                    updateFormValue model
                        (\oldFormValue ->
                            { oldFormValue | first = firstValue }
                        )
              }
            , Cmd.none
            )

        UpdateSecondValue secondValue ->
            ( { model
                | formValue =
                    updateFormValue model
                        (\oldFormValue ->
                            { oldFormValue | second = secondValue }
                        )
              }
            , Cmd.none
            )

        UpdateThirdValue thirdValue ->
            ( { model
                | formValue =
                    updateFormValue model
                        (\oldFormValue ->
                            { oldFormValue | third = thirdValue }
                        )
              }
            , Cmd.none
            )

        ConfirmFirstValue firstValue ->
            ( { model
                | decodeValue =
                    updateDecodeValue model
                        (\oldDecodevalue ->
                            { oldDecodevalue | first = firstValue }
                        )
                , page = Second
              }
            , Cmd.none
            )

        ConfirmSecondValue ->
            ( { model
                | decodeValue =
                    updateDecodeValue model
                        (\oldDecodevalue ->
                            { oldDecodevalue | second = formValue.second }
                        )
                , page = Third
              }
            , Cmd.none
            )

        ConfirmThirdValue ->
            ( { model
                | decodeValue =
                    updateDecodeValue model
                        (\oldDecodevalue ->
                            { oldDecodevalue | third = formValue.third }
                        )
                , page = Final
              }
            , Cmd.none
            )



-- VIEW


view : Model -> Html Msg
view model =
    case model.page of
        First ->
            firstView
                { firstValue = model.formValue.first
                , updateFirstValue = UpdateFirstValue
                , confirmFirstValue = ConfirmFirstValue
                }

        Second ->
            let
                firstSecondValue =
                    { firstValue = model.decodeValue.first
                    , secondValue = model.formValue.second
                    }
            in
            secondView
                { firstSecondValue = firstSecondValue
                , updateSecondValue = UpdateSecondValue
                , jumpFirstPage = PageChange First
                , confirmSecondValue = ConfirmSecondValue
                }

        Third ->
            thirdView
                { thirdValue = model.formValue.third
                , updateThirdValue = UpdateThirdValue
                , jumpSecondPage = PageChange Second
                , confirmThirdValue = ConfirmThirdValue
                }

        Final ->
            let
                { first, second, third } =
                    model.decodeValue
            in
            div []
                [ p [] [ text "Final" ]
                , p [] [ text <| String.fromInt first ]
                , p [] [ text second ]
                , p [] [ text third ]
                ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
