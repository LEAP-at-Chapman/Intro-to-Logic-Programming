# Logic Programming

Logic programming is one of the three fundamental paradigms of programming, next to imperative programming and functional programming. Imperative program is based on the assignment operator as the fundamental operation. Functional programming has no assignments and has the application of a function to an argument as the fundamental operation. A logic program is a set of rules and the fundamental computation step is rule application. In practice, most modern languages are a combination of these three paradigms.

Here we collect just enough material to explain the basic ideas of Prolog, the paradigmatic logic programming language.

A logic program is a database that may contain not only facts (tables), but also rules of reasoning.

To run a logic program, the user asks a query, similar to queries in ordinary databases.

The query-answering algorithm can be understood as search for a proof that the query is true. Indeed, an answer (or solution) to the query is given by data that makes the query true (satsifes the query). 

We recommend that you [download and install](https://www.swi-prolog.org/download/stable) Prolog. On MacOS, after moving SWI-Prolog to the Applications folder, you may have to run `echo 'export PATH="/Applications/SWI-Prolog.app/Contents/MacOS:$PATH"' >> ~/.zshrc` to add `swipl` to your path. Then, running `swipl` in your terminal should start the Prolog interpreter.

You can follow the slides by running [the example programs](src). 

Slides:

- [Introduction to Logic Programming](slides/LP1-introduction-to-logic-programming.pdf) explains the basics. To follow the question-answering algorithm step-by-step learn [How to Trace an Execution](trace.pdf). 
- From [Function Symbols and Lists](slides/LP2-function-symbols-and-lists.pdf) we only need the first slide, the rest is optional.
- To explain the query-answering algorithm we need to understand unification and resolution. This is best done by creating a *problem specific language*, see [Definitions](slides/LP3-definitions.pdf) and Slides 1-3  of [Unification](slides/LP4-unification.pdf). The unification algorithm itself you find on Slides 4-5, followed by some examples.
- To convince you that the *problem specific language* we created occupies the sweet spot between problem and implementation, compare Slides 4-5 above with Slides 2-3 of an [Implementation of Unification in Haskell](slides/LP4b-unification.pdf). The point here is that up to small syntactic details, the Haskell code matches the pseudo code almost exactly (and, of course, the Haskell code runs). To drive it home, after creating the right *problem specific language* it is possible to write a complete Prolog interpreter in just a few lines of code.
- Finally, we learn how [resolution](slides/LP5-resolution.pdf) works and how to draw so-called SLD-trees. The algorithm is described on slides 1-5, followed by a number of examples.
    
To test your understanding of unification and resolution answer the questions of the [Worksheet](worksheet.pdf).
