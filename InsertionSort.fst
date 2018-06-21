module InsertionSort

open TotalOrder
open Sort

val smaller : #a:eqtype -> leq:totalOrder #a -> a -> a -> a
let smaller #a leq x y = if leq x y then x else y

val min : #a:eqtype -> leq:totalOrder #a -> l:list a{Cons? l} -> Tot a
let rec min #a leq l =
    match l with
    | [x] -> x
    | x::xs -> smaller leq x (min leq xs)

val head_is_min : #a:eqtype -> leq:totalOrder #a -> l:sortedList leq{Cons? l} ->
    Lemma (Cons?.hd l = min leq l)
let rec head_is_min #a leq l =
    match l with
    | [x] -> ()
    | x::xs -> head_is_min leq xs


val insert : #a:eqtype -> leq:totalOrder #a -> x:a -> l:sortedList leq -> ret:sortedList leq{
    Cons? ret /\
    (Nil? l ==> min leq ret = x) /\
    (Cons? l ==> min leq ret = x || min leq ret = min leq l)
}
let rec insert #a leq x l =
    match l with
    | [] -> [x]
    | y :: ys ->
        if leq x y
            then x :: l
            else
                let zs : sortedList leq = insert leq x ys in
                if Nil? ys
                    then assert (min leq zs = x)
                    else head_is_min leq l;
                y :: zs



val insert_is_inverse_of_deleteOne : #a:eqtype -> leq:totalOrder #a -> x:a -> xs:sortedList leq ->
    Lemma (deleteOne x (insert leq x xs) = xs)
    [SMTPat (insert leq x xs)]
let rec insert_is_inverse_of_deleteOne #a leq x xs =
    match xs with
    | [] -> ()
    | y::ys -> if x = y then () else insert_is_inverse_of_deleteOne leq x ys


val insertionSort : #a:eqtype -> leq:totalOrder #a -> l:list a -> sortOf leq l
let rec insertionSort #a leq ls =
    match ls with
    | [] -> []
    | x::xs -> insert leq x (insertionSort leq xs)
