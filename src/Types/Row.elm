module Types.Row exposing (Row, toString)

import Types.Date exposing (Date)
import Types.Date as Date
type alias Row =
    { id : Int
    , balance : Float
    , amount : Float
    , currency : String
    , investmentType : String
    , status : String
    , modified : Date
    , tradeId : String
    , instrumentSymbol : String
    , instrumentName : String
    , commission : String
    , accountType : String
    }

toString: Row -> String
toString r =
    "{" ++ String.fromInt r.id ++ ", " ++ String.fromFloat r.balance ++ ", " ++ String.fromFloat r.amount ++ ", " ++ 
    r.currency ++ ", " ++ r.investmentType ++ ", " ++ r.status ++ ", " ++ Date.toString r.modified ++ ", " ++ r.tradeId ++ ", " ++ 
    r.instrumentSymbol ++ ", " ++ r.instrumentName ++ ", " ++ r.commission ++ ", " ++ r.accountType ++ "}"