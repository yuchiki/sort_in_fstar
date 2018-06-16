module MyPrint

open FStar.All
open FStar.IO

val print_int : int -> ML unit
let print_int i = print_string (string_of_int i)

val print_space : unit -> ML unit
let print_space _ = print_string " "

val print_int_space : int -> ML unit
let print_int_space i = print_int i; print_space ()
