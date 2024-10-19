module Services.CsvDecoder exposing (parseCsv)

import Csv.Decode as Decode exposing (Decoder)
import Types.Row exposing (Row)


decoder : Decoder Row
decoder =
    Decode.into Row
        |> Decode.pipeline (Decode.field "Id" Decode.int)
        |> Decode.pipeline (Decode.field "Balance" Decode.float)
        |> Decode.pipeline (Decode.field "Amount" Decode.float)
        |> Decode.pipeline (Decode.field "Currency" Decode.string)
        |> Decode.pipeline (Decode.field "Type" Decode.string)
        |> Decode.pipeline (Decode.field "Status" Decode.string)
        |> Decode.pipeline (Decode.field "Modified" Decode.string)
        |> Decode.pipeline (Decode.field "Trade Id" Decode.string)
        |> Decode.pipeline (Decode.field "Instrument Symbol" Decode.string)
        |> Decode.pipeline (Decode.field "Instrument Name" Decode.string)
        |> Decode.pipeline (Decode.field "Commission" Decode.string)
        |> Decode.pipeline (Decode.field "Account type" Decode.string)


parseCsv : String -> List Row
parseCsv csv =
    let
        parser : String -> Result Decode.Error (List Row)
        parser data =
            Decode.decodeCsv Decode.FieldNamesFromFirstRow decoder <| String.trim <| String.replace "\"" "" data
    in
    case parser csv of
        Err _ ->
            []
        Ok rows ->
            rows
