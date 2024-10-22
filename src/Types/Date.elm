module Types.Date exposing (..)

type alias Date = {
    year: Int
    , month: Int
    , day: Int
    , hour: Int
    , minute: Int
    , second: Int
    }

toString: Date -> String
toString date =
    let
        pad n =
            if n < 10 then
                "0" ++ String.fromInt(n)
            else
                String.fromInt(n)
    in
    String.fromInt(date.year) ++ "-" ++ pad(date.month) ++ "-" ++ pad(date.day) ++ " " ++ pad(date.hour) ++ ":" ++ pad(date.minute) ++ ":" ++ pad(date.second)

toDate: String -> Date
toDate str =
    let
        parts = String.split " " str
        date = String.split "-" (List.head parts |> Maybe.withDefault "")
        time = String.split ":" (List.drop 1 parts |> List.head |> Maybe.withDefault "")
    in
    {
        year = List.head date |> Maybe.withDefault "0" |> String.toInt |> Maybe.withDefault 0
        , month = List.head (List.drop 1 date) |> Maybe.withDefault "0" |>String.toInt |> Maybe.withDefault 0
        , day = List.head (List.drop 2 date) |> Maybe.withDefault "0" |> String.toInt |> Maybe.withDefault 0
        , hour = List.head time |> Maybe.withDefault "0" |> String.toInt |> Maybe.withDefault 0
        , minute = List.head (List.drop 1 time) |> Maybe.withDefault "0" |> String.toInt |> Maybe.withDefault 0
        , second = List.head (List.drop 2 time) |> Maybe.withDefault "0" |> String.toInt |> Maybe.withDefault 0
    }

compare: Date -> Date -> Order
compare date1 date2 =
    case Basics.compare date1.year date2.year of
        EQ ->
            case Basics.compare date1.month date2.month of
                EQ ->
                    case Basics.compare date1.day date2.day of
                        EQ ->
                            case Basics.compare date1.hour date2.hour of
                                EQ ->
                                    case Basics.compare date1.minute date2.minute of
                                        EQ ->
                                            Basics.compare date1.second date2.second
                                        other ->
                                            other
                                other ->
                                    other
                        other ->
                            other
                other ->
                    other
        other ->
            other

getMonthName : Date -> String
getMonthName date =
    case date.month of
        1 -> "Jan"
        2 -> "Feb"
        3 -> "Mar"
        4 -> "Apr"
        5 -> "May"
        6 -> "Jun"
        7 -> "Jul"
        8 -> "Aug"
        9 -> "Sep"
        10 -> "Oct"
        11 -> "Nov"
        12 -> "Dec"
        _ -> "Invalid month"

type alias ReducedDate = {
    year: Int,
    month: Int
    }

toReducedDate: Date -> ReducedDate
toReducedDate date = ReducedDate date.year date.month

reducedDateToString: ReducedDate -> String
reducedDateToString reducedDate = fromReducedDate reducedDate |> toString
-- Inverse methods
fromReducedDate: ReducedDate -> Date
fromReducedDate reducedDate =
    { year = reducedDate.year
    , month = reducedDate.month
    , day = 1
    , hour = 0
    , minute = 0
    , second = 0
    }

fromReducedDateString: String -> ReducedDate
fromReducedDateString str =
    let
        parts = String.split "-" str
    in
    { year = List.head parts |> Maybe.withDefault "0" |> String.toInt |> Maybe.withDefault 0 |> (\y -> modBy y 100)
    , month = List.head (List.drop 1 parts) |> Maybe.withDefault "0" |> String.toInt |> Maybe.withDefault 0
    }

compareReducedDate: ReducedDate -> ReducedDate -> Order
compareReducedDate reducedDate1 reducedDate2 =
    case Basics.compare reducedDate1.year reducedDate2.year of
        EQ ->
            Basics.compare reducedDate1.month reducedDate2.month
        other ->
            other