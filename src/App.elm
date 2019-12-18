port module App exposing(..)

import Html
import Html.Events as He
import Browser exposing (element)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Button as Button
import User exposing (..)

type alias Model = {
    value: Int,
    numberOfClicks: Int,
    users: List User
    }

type Msg = Initialize | Increment | Decrement | DeleteUser User --| EditUserMsg User EditUser

type Page = LoginPage | GroupPage | MainPage
type EditUser = Delete | IncPoints | DecPoints

intialModel : () -> (Model, Cmd Msg)
intialModel () = ({value=0, numberOfClicks=0, users=initialUsers}, Cmd.none)

view model =
    Grid.container [] ([
        Html.h1 [] [Html.text "Nejc je na delavnici s Tjaso!\n In kako je ustvarjalen! Nejc namreč."], --"Hello world"
        Html.h2 [] [Html.text ((String.fromInt model.value) ++ " je najino najljubse stevilo")],
        Html.h2 [] [Html.text ((String.fromInt model.numberOfClicks) ++ "-krat sva si premislila")],
        Button.button [Button.success, Button.block, Button.attrs [He.onClick Increment] ] [Html.text "Nejc"],
        Button.button [Button.success, Button.block, Button.attrs [He.onClick Decrement] ] [Html.text "Tjasa"],
        Button.button [Button.success, Button.block, Button.attrs [He.onClick Initialize] ] [Html.text "Nazaj na zacetek"],
        Grid.row [] [
            Grid.col [] [Html.text "Uid"],
            Grid.col [] [Html.text "Ime"],
            Grid.col [] [Html.text "Tocke"],
            Grid.col [] []
        ]
    ] ++ (
        List.map (\user -> Grid.row [] [
            Grid.col [] [Html.text (String.fromInt user.uid)],
            Grid.col [] [Html.text user.name],
            Grid.col [] [Html.text (String.fromInt user.points)],
            Grid.col [] [Button.button [Button.onClick (DeleteUser user)] [Html.text "Delete"]]
        ]) (List.reverse (List.sortBy .points model.users)) 
    ))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Increment -> ({model | value = model.value + 1, numberOfClicks = model.numberOfClicks + 1}, Cmd.none)
        Decrement -> ({model | value = model.value - 1, numberOfClicks = model.numberOfClicks + 1}, Cmd.none)
        Initialize -> intialModel ()
        DeleteUser user -> ({model | users = remove user model.users}, sendAlert user.name)
        --_ -> (model, Cmd.none)

main = 
    element
        {
            init = intialModel,
            update = update,
            view = view,
            subscriptions = \_ -> Sub.none
        }

port sendAlert : String -> Cmd msg