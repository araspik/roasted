# `roasted`: A `RusteD` langauge
[![CircleCI](https://circleci.com/gh/araspik/roasted.svg?style=svg)](https://circleci.com/gh/araspik/roasted)
  
This is mostly for fun, but the inspiration is to have a
safer yet simultaneously more powerful version of the
[D Programming Language](https://dlang.org "The D Programming Language").
The basis of the improvements to make to D is from Rust,
which also has some nice types like
[compound types](https://doc.rust-lang.org/stable/book/2018-edition/ch03-02-data-types.html#compound-types)
and some nice syntax which D lacks.

### Language Specs
The language specs is currently quite unorganized. Most of
it is within the code such that a documentation generator
can pull it out well, but once a semi-stable complete AST is
created the documentation will be moved onto GitHub Pages.

### Compiler?
At the moment, only the AST is created. Once parsing is
created, a compiler executable version will be added (into
`source/` folder) which will help in showing the parsing
results. After that, once codegen is implemented (via LLVM),
the compiler will actually produce output which can be used.

## License: MIT
```
Copyright (c) 2018 ARaspiK

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```