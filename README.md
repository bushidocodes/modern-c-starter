# Modern C Starter Project

This repo is a reference implementation of a Make-based C project wrapped with VSCode interop

All functionality is placed in the Makefile to play nice with other editors

## In Make

- `make build` builds the project
- `make run` builds and executes the project
- `make test` build and executes the unit tests
- `make format` runs clang-format to format the source files
- `make memcheck` checks for memory leaks overruns
- `make clean` cleans up the build/\* files

## In VSCode

- Suggests installation of the C/C++ extension
- Configured to run `make build` as default build command (ctrl+shift+b)
- Integrated GDB into the VSCode debugger for interactive debugging.
- IntelliSense works as expected
