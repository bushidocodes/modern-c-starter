# Modern C Starter Project

A Make-based C project template targeting **C23**, with VSCode integration, unit tests via [Unity](https://github.com/ThrowTheSwitch/Unity), and CI via GitHub Actions.

## Requirements

- GCC 14+ or Clang 18+ (for C23 support)
- GNU Make 4.0+
- clang-format 14+ (for `make format` / `make format-check`)

## Make Targets

| Target | Description |
|--------|-------------|
| `make` or `make build` | Compile the project with incremental builds |
| `make run` | Build and run the program |
| `make test` | Build and run the unit tests |
| `make asan` | Run tests with Address Sanitizer and UB Sanitizer |
| `make format` | Auto-format source files with clang-format |
| `make format-check` | Verify formatting without modifying files (used in CI) |
| `make clean` | Remove all build artifacts |

## VSCode

- Recommends the [clangd](https://marketplace.visualstudio.com/items?itemName=llvm-vs-code-extensions.vscode-clangd) and [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) extensions
- `Ctrl+Shift+B` runs `make build` by default
- GDB (Linux) and LLDB (macOS) debugger configurations included
- IntelliSense configured for Linux, macOS, and Windows with the C23 standard

## CI

GitHub Actions runs on every push and pull request:

- Builds the project
- Runs the test suite
- Checks code formatting with clang-format
- Runs tests with Address Sanitizer and Undefined Behavior Sanitizer
