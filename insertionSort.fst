module InsertionSort

open TotalOrder
open Sort

(* definition of insertion_sort *)
val min : #a:eqtype -> leq:totalOrder #a -> l:list a{Cons? l} -> Tot a
let rec min #a leq l =
    match l with
    | [x] -> x
    | x::xs ->
        let m = min leq xs in
        if leq x m then x else m

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
            then x :: y :: ys
            else
                let zs : sortedList leq = insert leq x ys in
                if Nil? ys
                    then assert (min leq zs = x)
                    else head_is_min leq (y::ys);
                y :: zs

val insert_is_inverse_of_deleteOne : #a:eqtype -> leq:totalOrder #a -> x:a -> xs:sortedList leq ->
    Lemma (deleteOne x (insert leq x xs) = xs)
let rec insert_is_inverse_of_deleteOne #a leq x xs =
    match xs with
    | [] -> ()
    | y::ys -> if x = y then () else insert_is_inverse_of_deleteOne leq x ys

val insertionSort :
    #a:eqtype ->
    leq:totalOrder #a ->
    l:list a ->
    ret: sortOf leq l
let rec insertionSort #a leq ls =
    match ls with
    | [] -> []
    | x::xs ->
        let ih = insertionSort leq xs in
        assert (sorted leq ih);
        insert_is_inverse_of_deleteOne leq x ih;
        insert leq x ih
