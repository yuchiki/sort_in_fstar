module Sort

open TotalOrder

val sorted : #a:eqtype -> totalOrder #a -> list a -> Tot bool
let rec sorted #a leq l =
    match l with
    | [] -> true
    | [_] -> true
    | x::y::xs -> leq x y  && sorted leq (y::xs)

val deleteOne : #a:eqtype -> a -> list a -> Tot (list a)
let rec deleteOne #a x ls =
    match ls with
    | [] -> []
    | y :: ys -> if x = y then ys else y :: deleteOne #a x ys

val isPermutation : #a:eqtype -> list a -> list a -> Tot bool
let rec isPermutation #a l1 l2 =
    match (l1, l2) with
    | ([], []) -> true
    | ([], _) -> false
    | (x::xs, _) -> isPermutation xs (deleteOne x l2)

val contains : #a:eqtype -> a -> list a -> Tot bool
let rec contains #a x ls =
    match ls with
    | [] -> false
    | y::ys -> x = y || contains #a x ys

type sortedList (#a:eqtype) (leq:totalOrder #a) = ls:list a{sorted leq ls}

type sortOf (#a:eqtype) (leq:totalOrder #a) (l:list a)
    = ret:sortedList leq{isPermutation l ret}
