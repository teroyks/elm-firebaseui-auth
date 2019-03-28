module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Json.Decode as D exposing (Decoder)
import Result



---- MODEL ----


type alias Flags =
    { timestamp : Int
    , userData : String
    }


type alias UserData =
    { uid : String
    , displayName : String
    , email : String
    , authToken : String
    }


type alias Model =
    { timestamp : Int
    , isLoggedIn : Bool
    , user : Maybe UserData
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        user =
            case D.decodeString decoder flags.userData of
                Ok data ->
                    Just data

                Err _ ->
                    Nothing
    in
    ( { timestamp = flags.timestamp
      , isLoggedIn =
            case user of
                Nothing ->
                    False

                _ ->
                    True
      , user = user
      }
    , Cmd.none
    )


decoder : D.Decoder UserData
decoder =
    D.map4 UserData
        (D.field "uid" D.string)
        (D.field "displayName" D.string)
        (D.field "email" D.string)
        (D.field "authToken" D.string)



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , div [] [ text ("Timestamp: " ++ String.fromInt model.timestamp) ]
        ]



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
