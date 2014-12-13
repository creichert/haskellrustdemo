# Compiles:
#
#   1) Dynamically linked C executable with embedded Rust library.
#
#   2) Dynamically linked Haskell executable with embedded Rust library
#        Dynamically linked at the C level against Rust library.
#        Embedded in this case simply meanse we are interacting
#        with Rust at the API level and not shelling out commands.
#
#   3) Statically linked Haskell executable with embedded Rust library
#        Statically linked at the C level and against Rust library.
#
#   4) Basic Cabal build (dynamically linked).
#
#  *Makefile currently rebuilds even if the targets are up-to-date (intended)*


CARGO	= cargo
CC	= gcc
GHC	= ghc
ECHO	= echo
CABAL	= cabal


build: cffi hsffi
	@$(ECHO) "Executables built"
	@$(ECHO) "\nTry 'make run'"


run: cffi hsffi
	@$(ECHO) "\n\nexecuting C executable:"
	@$(ECHO) "======================="
	@./rust-c
	@$(ECHO) "\n\nexecuting dynamically linked executable:"
	@$(ECHO) "========================================"
	@LD_LIBRARY_PATH=`pwd` ldd ./Rust | grep rslib
	@LD_LIBRARY_PATH=`pwd` ./Rust
	@$(ECHO) "\n\nexecuting statically linked executable:"
	@$(ECHO) "======================================="
	@./Rust-static
	@$(ECHO) "\n\nexecuting cabal run:"
	@$(ECHO) "===================="
	@if hash $(CABAL) 2>/dev/null; then  LD_LIBRARY_PATH=`pwd` $(CABAL) run; fi


hsffi: cargo
	@$(ECHO) "Building using GHC command line"
	@$(GHC) --make Rust.hs -L. -lrslib -lpthread -o Rust
	@$(GHC) --make Rust.hs -fPIC -optl-static -optl-pthread -L. -lrslib -o Rust-static
	@$(ECHO) "Building using Cabal"
	@if hash $(CABAL) 2>/dev/null; then $(CABAL) build; fi


cffi: cargo
	@$(CC) -c test.c
	@$(CC) -o rust-c test.o librslib.a -ldl -lpthread -lc -lm


cargo:
	@[ -x ${RUSTC} ] || ($(ECHO) "ERROR: rust compiler (rustc) not found" && exit 1)
	@$(CARGO) build -v
	@ln -fs target/*.so librslib.so
	@ln -fs target/*.a  librslib.a


clean:
	@$(CARGO) clean
	@rm -f Rust_stub.h
	@rm -f Cargo.lock
	@rm -rf *~ *.hi *.o *.so target/ G* *.a
	@rm -f Rust rust-c Rust-static
	@if hash $(CABAL) 2>/dev/null; then $(CABAL) clean; fi
