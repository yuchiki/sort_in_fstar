module Main

open FStar.All
open FStar.IO
open FStar.String

open Sort
open Insertionsort
open Myprint

val input : list int
let input = [3; 1; 4; 1; 5; 9; 2; 6; 5]

val answer : sortOf (<=) input
let answer = insertionSort (<=) input

val iter: ('a -> ML unit) -> list 'a -> ML unit
let rec iter f ls =
    match ls with
    | [] -> ()
    | x::xs -> f x; iter f xs

let main =
    input |> iter print_int_space;
    print_string "is sorted into ";
    answer |> iter print_int_space;
    print_string ".\n"
