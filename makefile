include makefile.include

FST=main.fst

.phony: all ocaml FSharp check clean

.phony: execute
execute: OCaml/Hoge.ml
	$(OCAMLOPT) OCaml/Hoge.ml -o this_must_be_executable
	./this_must_be_executable

OCaml/main.ml: $(FST)
	fstar.exe $^ --codegen OCaml --odir OCaml

.phony: check
check: $(FST)
	fstar.exe $^

FSharp: $(FST)
	fstar.exe $^ --codegen $@ --odir $@

clean:
	- rm -rf OCaml FSharp
