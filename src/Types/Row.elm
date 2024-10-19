module Types.Row exposing (Row, toString)

type alias Row =
    { id : Int
    , balance : Float
    , amount : Float
    , currency : String
    , investmentType : String
    , status : String
    , modified : String
    , tradeId : String
    , instrumentSymbol : String
    , instrumentName : String
    , commission : String
    , accountType : String
    }

toString: Row -> String
toString r =
    "{" ++ String.fromInt r.id ++ ", " ++ String.fromFloat r.balance ++ ", " ++ String.fromFloat r.amount ++ ", " ++ 
    r.currency ++ ", " ++ r.investmentType ++ ", " ++ r.status ++ ", " ++ r.modified ++ ", " ++ r.tradeId ++ ", " ++ 
    r.instrumentSymbol ++ ", " ++ r.instrumentName ++ ", " ++ r.commission ++ ", " ++ r.accountType ++ "}"