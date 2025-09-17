# Eight Queens Problem

The Eight Queens problem is the hello-world of logic programming.

**The Challenge**: Place 8 queens on a chessboard so that no queen attacks another.

**What you'll learn**:
- How Prolog automatically finds solutions through backtracking
- How constraints work together to eliminate impossible choices
- How recursion naturally models complex problems
- The difference between procedural and declarative programming

In [eight-queens.pl](src/eight-queens.pl) you will find the following code

```prolog
solution(Queens) :- 
    length(Queens, 8),
    queens(Queens).

queens([]).
queens([queen(Row, Col) | Others]) :- 
    queens(Others),
    length(Others, OthersLength),
    Row is OthersLength + 1,
    member(Col, [1,2,3,4,5,6,7,8]),
    noattack(queen(Row, Col), Others).

noattack(_, []).
noattack(queen(Row, Col), [queen(Row1, Col1) | Others]) :-
    Col =\= Col1,                    
    Col1-Col =\= Row1-Row,           
    Col1-Col =\= Row-Row1,
    noattack(queen(Row, Col), Others).
```

Run this program as follows.
```bash
cd src
swipl -f eight-queens.pl
```
Then in the Prolog prompt:
```prolog
?- solution(S).
```

Enter `.` and then `solution(S).` again. (You can use the up-arrow to repeat a command.). Enter`;` and explain what happens. What is the difference between `.` and `;`?

Use Ctrl-d to exit Prolog.

Study the source file and try to explain how the execution may work. 

CHALLENGE-WARNING: This is difficult and requires to get a number of guesses correct or to read up on Prolog background. But don't worry, once you get stuck continue below.

Restart Prolog with `swipl -f eight-queens.pl`.

Enter `trace.` and skim over [Debugging with trace](trace.pdf). Enter `solution(X).` again. Use the `return` key to look into the execution of a predicate and use `s` to skip directly to the end of the execution of a predicate. Before you enter `s` make a guess of what result you expect. (Learning happens when you update your mental model due to an unexpected answer.) Enter `a` to abort the execution. That is useful when you got lost in the execution and want to start over again.

Be prepared to explain in the next lecture what you learned.

