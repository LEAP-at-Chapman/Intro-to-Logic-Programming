/* family.pl Family tree */

parent(arthur,george).
parent(harriet,george).
parent(george,richard).
parent(george,amelia).
parent(george,susan).
parent(matilda,richard).
parent(matilda,amelia).
parent(victoria,susan).
parent(richard,sophie).
parent(richard,joseph).
parent(ellen,sophie).
parent(ellen,joseph).
parent(susan,charles).
parent(walter,charles).

male(arthur).
male(george).
male(richard).
male(joseph).
male(walter).
male(charles).

female(harriet).
female(matilda).
female(victoria).
female(amelia).
female(susan).
female(ellen).
female(sophie).


%%% Defined realtionships %%%

mother(X,Y):- parent(X,Y), female(X).

grandparent(X,Y) :- parent(X,Z), parent(Z,Y).

% FOR ALL X, Y, Z, (gp(X,Y) IF parent(X,Z) AND parent(Z,Y))
% FOR ALL X, Y, (gp(X,Y) IF THERE EXISTS Z, parent(X,Z) AND parent(Z,Y))

sibling(X,Y) :- parent(Z,X), parent(Z,Y), X\=Y.

/*

Add some more of your own, and test them out!!

*/

% CORRECT ancestor implementation (base case first)
ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(Z,Y), ancestor(X,Z).

% INCORRECT implementations for comparison (see exercises)
ancestor2(X,Y) :- parent(Z,Y), ancestor2(X,Z).  % Recursive case first
ancestor2(X,Y) :- parent(X,Y).

ancestor3(X,Y) :- parent(X,Y).
ancestor3(X,Y) :- ancestor3(X,Z), parent(Z,Y).  % Different variable order

ancestor4(X,Y) :- ancestor4(X,Z), parent(Z,Y).  % This causes infinite loop!
ancestor4(X,Y) :- parent(X,Y).

/*

EXERCISE: Try all four ancestor implementations and explain the differences.
Use trace to see how Prolog searches for solutions.

?- ancestor(X, richard).
?- ancestor2(X, richard).  
?- ancestor3(X, richard).
?- ancestor4(X, richard).  % This will cause problems!

*/

%%%%%%%%%%%
%%% End %%%
%%%%%%%%%%%
