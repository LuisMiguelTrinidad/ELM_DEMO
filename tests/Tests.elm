module Tests exposing (all)

import Expect
import Test exposing (Test, describe, test)


all : Test
all =
    describe "A Sample Test Suite"
        [ test "Addition" <|
            \_ ->
                Expect.equal 12 (8 + 4)
        , test "String.left" <|
            \_ ->
                Expect.equal "abc" (String.left 3 "abcdefg")
        ]
