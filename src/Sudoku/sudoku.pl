% ============= GENERIC PREDICATES =============

all_different([]).
all_different([H|T]) :-
    not_member(H, T),
    all_different(T).

not_member(_, []).
not_member(X, [H|T]) :-
    X \= H,
    not_member(X, T).

all_vars_in_range([], _).
all_vars_in_range([Row|Rows], N) :-
    all_row_in_range(Row, N),
    all_vars_in_range(Rows, N).

all_row_in_range([], _).
all_row_in_range([Cell|Cells], N) :-
    between(1, N, Cell),              
    all_row_in_range(Cells, N).

box_constraints(Grid, BoxSize) :-
    length(Grid, N),
    BoxesPerSide is N // BoxSize,
    MaxIndex is BoxesPerSide - 1,
    forall(between(0, MaxIndex, BoxRow),
           forall(between(0, MaxIndex, BoxCol),
                  box_constraint(Grid, BoxRow, BoxCol, BoxSize))).

box_constraint(Grid, BoxRow, BoxCol, BoxSize) :-
    StartRow is BoxRow * BoxSize + 1,
    EndRow is StartRow + BoxSize - 1,
    StartCol is BoxCol * BoxSize + 1, 
    EndCol is StartCol + BoxSize - 1,
    extract_box(Grid, StartRow, EndRow, StartCol, EndCol, BoxCells),
    all_different(BoxCells).

extract_box(Grid, StartRow, EndRow, StartCol, EndCol, BoxCells) :-
    findall(Cell,
            (between(StartRow, EndRow, I),
             between(StartCol, EndCol, J),
             nth1(I, Grid, Row),
             nth1(J, Row, Cell)),
            BoxCells).

print_grid([]).
print_grid([Row|Rows]) :-
    format('~w~n', [Row]),
    print_grid(Rows).

% ============= 4x4 SUDOKU =============

set_clues_4x4(Grid) :-
    Grid = [[A1,A2,A3,A4],
            [B1,B2,B3,B4],
            [C1,C2,C3,C4], 
            [D1,D2,D3,D4]],
    A1=1, A3=3,
    B2=4, B4=2,
    C1=2, C3=4,
    D2=3, D4=1.

% ============= 9x9 SUDOKU =============  

set_clues_9x9_hard(Grid) :-
    Grid = [[A1,A2,A3,A4,A5,A6,A7,A8,A9],
            [B1,B2,B3,B4,B5,B6,B7,B8,B9], 
            [C1,C2,C3,C4,C5,C6,C7,C8,C9],
            [D1,D2,D3,D4,D5,D6,D7,D8,D9],
            [E1,E2,E3,E4,E5,E6,E7,E8,E9],
            [F1,F2,F3,F4,F5,F6,F7,F8,F9],
            [G1,G2,G3,G4,G5,G6,G7,G8,G9],
            [H1,H2,H3,H4,H5,H6,H7,H8,H9],
            [I1,I2,I3,I4,I5,I6,I7,I8,I9]],
    A1=5, A2=3, A5=7,
    B1=6, B4=1, B5=9, B6=5,
    C2=9, C3=8, C8=6,
    D1=8, D5=6, D9=3,
    E1=4, E4=8, E6=3, E9=1,
    F1=7, F5=2, F9=6,
    G2=6, G7=2, G8=8,
    H4=4, H5=1, H6=9, H9=5,
    I5=8, I8=7, I9=9.

% Set 9x9 clues (EASY - many more clues)
set_clues_9x9_easy(Grid) :-
    Grid = [[A1,A2,A3,A4,A5,A6,A7,A8,A9],
            [B1,B2,B3,B4,B5,B6,B7,B8,B9], 
            [C1,C2,C3,C4,C5,C6,C7,C8,C9],
            [D1,D2,D3,D4,D5,D6,D7,D8,D9],
            [E1,E2,E3,E4,E5,E6,E7,E8,E9],
            [F1,F2,F3,F4,F5,F6,F7,F8,F9],
            [G1,G2,G3,G4,G5,G6,G7,G8,G9],
            [H1,H2,H3,H4,H5,H6,H7,H8,H9],
            [I1,I2,I3,I4,I5,I6,I7,I8,I9]],
    % Easy puzzle - almost complete solution (only a few blanks)
    A1=5, A2=3, A3=4, A4=6, A5=7, A6=8, A7=9, A8=1,        % Missing A9
    B1=6, B2=7, B3=2, B4=1, B5=9, B6=5, B7=3, B8=4, B9=8,
    C1=1, C2=9, C3=8, C4=3, C5=4, C6=2, C7=5, C8=6, C9=7,
    D1=8, D2=5, D3=9, D4=7, D5=6, D6=1, D7=4, D8=2, D9=3,
    E1=4, E2=2, E3=6, E4=8, E5=5, E6=3, E7=7, E8=9, E9=1,
    F1=7, F2=1, F3=3, F4=9, F5=2, F6=4, F7=8, F8=5, F9=6,
    G1=9, G2=6, G3=1, G4=5, G5=3, G6=7, G7=2, G8=8, G9=4,
    H1=2, H2=8, H3=7, H4=4, H5=1, H6=9, H7=6, H8=3, H9=5,
    I1=3, I2=4, I3=5, I4=2, I5=8, I6=6, I7=1, I8=7.        % Missing A9


% ============= GENERIC SUDOKU SOLVER =============

sudoku_generic(Grid, N, BoxSize) :-
    % Create NxN grid
    length(Grid, N),
    forall(member(Row, Grid), length(Row, N)),
    
    % Domain constraints: each cell is 1..N
    all_vars_in_range(Grid, N),
    
    % Row constraints: each row has all different values
    maplist(all_different, Grid),
    
    % Column constraints: each column has all different values
    transpose(Grid, Columns),
    maplist(all_different, Columns),
    
    % Box constraints: each BoxSize x BoxSize box has all different values
    box_constraints(Grid, BoxSize).


% Helper: transpose matrix
transpose([], []).
transpose([F|Fs], Ts) :-
    transpose(F, [F|Fs], Ts).

transpose([], _, []).
transpose([_|Rs], Ms, [Ts|Tss]) :-
    lists_firsts_rests(Ms, Ts, Ms1),
    transpose(Rs, Ms1, Tss).

lists_firsts_rests([], [], []).
lists_firsts_rests([[F|Os]|Rest], [F|Fs], [Os|Oss]) :-
    lists_firsts_rests(Rest, Fs, Oss).

% ============= TESTING =============
test_4x4 :-
    get_time(Start),
    set_clues_4x4(Grid),
    sudoku_generic(Grid, 4, 2),
    get_time(End),
    Time is (End - Start) * 1000,
    format('4x4 Prolog from-scratch time: ~2f ms~n', [Time]),
    print_grid(Grid).

test_9x9_hard :-
    get_time(Start),
    set_clues_9x9_hard(Grid),
    sudoku_generic(Grid, 9, 3),
    get_time(End),
    Time is (End - Start) * 1000,
    format('9x9 Prolog HARD time: ~2f ms~n', [Time]),
    print_grid(Grid).

test_9x9_easy :-
    get_time(Start),
    set_clues_9x9_easy(Grid),
    sudoku_generic(Grid, 9, 3),
    get_time(End),
    Time is (End - Start) * 1000,
    format('9x9 Prolog EASY time: ~2f ms~n', [Time]),
    print_grid(Grid).

