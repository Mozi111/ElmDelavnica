module User exposing (..)

type alias User = {
    uid: Int,
    name: String,
    points: Int
    }

remove : User -> List User -> List User
remove user users = 
    case users of
        [] -> []
        (usr::rest) -> if usr.uid == user.uid then
                        remove user rest else
                        usr :: (remove user rest)

initialUsers =
    [
        {uid=1, name="Tjasa", points = 120},
        {uid=3, name="Marko", points = 12},
        {uid=4, name="Martin", points = -10},
        {uid=5, name="Kontejner", points = 19},
        {uid=2, name="Nejc", points = 17}
    ]

