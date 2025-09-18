sudoku_4x4(Grid) :-
    Grid = [[A1,A2,A3,A4],
            [B1,B2,B3,B4],
            [C1,C2,C3,C4], 
            [D1,D2,D3,D4]],
    
    % CORRECTED: Valid puzzle clues
    A1=1, A3=3,
    B2=4, B4=2,
    C1=2, C3=4,
    D2=3, D4=1,
    
    % Domain 1-4
    all_vars_1_to_4(Grid),
    
    % All constraints
    all_different([A1,A2,A3,A4]),
    all_different([B1,B2,B3,B4]),
    all_different([C1,C2,C3,C4]),
    all_different([D1,D2,D3,D4]),
    
    all_different([A1,B1,C1,D1]),
    all_different([A2,B2,C2,D2]),
    all_different([A3,B3,C3,D3]),
    all_different([A4,B4,C4,D4]),
    
    all_different([A1,A2,B1,B2]),  % Top-left 2x2
    all_different([A3,A4,B3,B4]),  % Top-right 2x2
    all_different([C1,C2,D1,D2]),  % Bottom-left 2x2
    all_different([C3,C4,D3,D4]).  % Bottom-right 2x2

all_different([]).
all_different([H|T]) :-
    not_member(H, T),
    all_different(T).

not_member(_, []).
not_member(X, [H|T]) :-
    X \= H,
    not_member(X, T).

all_vars_1_to_4([]).
all_vars_1_to_4([Row|Rows]) :-
    all_row_1_to_4(Row),
    all_vars_1_to_4(Rows).

all_row_1_to_4([]).
all_row_1_to_4([Cell|Cells]) :-
    member(Cell, [1,2,3,4]),
    all_row_1_to_4(Cells).

test_4x4 :-
    get_time(Start),
    sudoku_4x4(Grid),
    get_time(End),
    Time is (End - Start) * 1000,
    format('Prolog from-scratch time: ~2f ms~n', [Time]),
    print_grid(Grid).

print_grid([]).
print_grid([Row|Rows]) :-
    format('~w~n', [Row]),
    print_grid(Rows).