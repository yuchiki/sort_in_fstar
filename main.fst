module Main

open FStar.All
open FStar.IO
open FStar.String

open Sort
open InsertionSort
open MyPrint

(*
type sortOf (#a:eqtype) (leq:totalOrder #a) (l:list a) =
    ret:sortedList leq{isPermutation l ret}

val insertionSort :
    a:eqtype -> leq:totalOrder #a -> l:list a ->
    ret:sortOf leq l
*)

val cmp : int -> int -> bool
let cmp l r = l <= r

val input : list int
let input = [3; 1; 4; 1; 5; 9; 2; 6; 5]

val answer : sortOf cmp input
let answer = insertionSort cmp input

val iter : ('a -> ML unit) -> list 'a -> ML unit
let rec iter f ls =
    match ls with
    | [] -> ()
    | x::xs -> f x; iter f xs

let main args = answer |> iter print_int_space
