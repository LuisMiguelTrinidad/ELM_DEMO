module Services.GraphDataCleaner exposing (..)

import Types.Row as Row
import Dict as Dict
import Types.Date as Date

type alias Graph0Data = {x: Float, earnings: Float, amount: Float, label: String}
getGraph0Data : List Row.Row -> List Graph0Data
getGraph0Data data = 
    let
        monthstoBalance : Dict.Dict String {y: Float, z: Float}
        monthstoBalance = 
            List.foldl (\row acc -> 
                let
                    date = Date.toReducedDate row.modified |> Date.reducedDateToString
                in
                    case Dict.get date acc of
                        Just {y, z} -> Dict.insert date {y=row.amount + y, z=row.balance} acc
                        Nothing -> Dict.insert date {y=row.amount, z=row.balance} acc
            ) Dict.empty data
        
        monthstoBalanceList = monthstoBalance 
            |> Dict.toList 
        monthstoBalanceTypedList = List.map (\(date, {y,z}) -> ((Date.toDate date), {y=y,z=z})) monthstoBalanceList
        
    in
        monthstoBalanceTypedList 
            |> List.sortWith (\(date1, _) (date2, _) -> 
                Date.compare date1 date2) 
            |> List.indexedMap (\index (date, {y,z}) -> 
                {x = toFloat index, 
                earnings = y,
                amount = z, 
                label = (Date.getMonthName date)++ " " ++ (String.fromInt date.year)})

type alias Graph1Data = {company: String, transactionAmmount: Float, moneyEarned: Float}
getGraph1Data : List Row.Row -> List Graph1Data
getGraph1Data data = 
    let
        companiesToData : Dict.Dict String {transactionAmmount: Float, moneyEarned: Float}
        companiesToData = 
            List.foldl (\row acc -> 
                case Dict.get row.instrumentSymbol acc of
                    Just {transactionAmmount, moneyEarned} -> Dict.insert row.instrumentSymbol {transactionAmmount=transactionAmmount + 1, moneyEarned=row.amount + moneyEarned} acc
                    Nothing -> Dict.insert row.instrumentSymbol {transactionAmmount=1, moneyEarned=row.amount} acc
            ) Dict.empty data
    in
        companiesToData 
            |> Dict.toList 
            |> List.filter (\(_, {transactionAmmount, moneyEarned}) -> transactionAmmount >= 10)
            |> List.map (\(company, {transactionAmmount, moneyEarned}) -> {company=company, transactionAmmount=transactionAmmount, moneyEarned=moneyEarned})

