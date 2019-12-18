module User exposing (..)

type alias User = {
    uid: Int,
    name: String,
    points: Int
    }

initialUsers =
    [
        {uid=1, name="Tjasa", points = 120},
        {uid=2, name="Nejc", points = 17}
    ]