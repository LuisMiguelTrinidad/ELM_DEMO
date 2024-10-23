module Types.GraphTypes exposing (..)

import Chart.Item as CI

type alias Graph0Data = {x: Float, earnings: Float, amount: Float, label: String}

type alias Hovering0Data = {
    bars: List (CI.One Graph0Data CI.Bar ),
    dots: List (CI.One Graph0Data CI.Dot )
    }

type alias Graph1Data = {company: String, transactionAmmount: Float, moneyEarned: Float}

type alias Hovering1Data = List (CI.Many Graph1Data CI.Any)