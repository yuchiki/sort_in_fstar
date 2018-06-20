include makefile.include

EXE=main

.phony: execute check clean

SRC=Myprint Totalorder Sort Insertionsort Main
FST_SRC=$(addsuffix .fst, $(SRC))
OCAML_SRC_BASE=$(addprefix OCaml/, $(SRC))
OCAML_CMX=$(addsuffix .cmx, $(OCAML_SRC_BASE))

execute: OCaml/$(EXE)
	OCaml/$(EXE)

OCaml/$(EXE): $(OCAML_CMX)
	$(OCAMLOPT) -I ./OCaml -o OCaml/$(EXE) $^

OCaml/%.cmx: OCaml/%.ml
	$(OCAMLOPT) -I ./OCaml -c $<

OCaml/%.ml: $(FST_SRC)
	fstar.exe $^ --codegen OCaml --odir OCaml

check: $(FST_SRC)
	fstar.exe $^

clean:
	- rm -rf OCaml
