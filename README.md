# Haskell-Rust foreign function interface demo

This project shows how to use Rust from Haskell and Haskell from Rust.

Last updated on **Tuesday, September 11, 2018**

## Build and Run

Make sure the following executables are in your `PATH`:
- `rustc`
- `ghc`
- `cargo` - used to show ffi linking using Cargo
- `cabal` - used to show ffi linking a Haskell cabal project


Then, build and run the project:

    $ make
    $ make run



## Resources
- [[https://brson.github.io/2013/03/10/embedding-rust-in-ruby][Embedding Rust in Ruby]]
- [[https://github.com/brson/rubyrustdemo][rubyrustdemo]]
- [[http://doc.rust-lang.org/guide-ffi.html][Rust FFI Guide]]
- [[http://benchmarksgame.alioth.debian.org/u64q/compare.php?lang=ghc&lang2=rust][Benchmarks]]
- [[https://pcwalton.github.io/blog/2013/04/18/performance-of-sequential-rust-programs][More Benchmarks]]
- [[https://github.com/servo/servo][Servo]]
- [[https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/ffi-chap.html][GHC Manual - Chapter 10. Foreign function interface (FFI)]]
