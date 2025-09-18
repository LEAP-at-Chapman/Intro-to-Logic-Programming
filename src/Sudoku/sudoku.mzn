include "globals.mzn";

% Parameters (to be defined in .dzn file)
int: n;  % Size of the grid (typically 9)
int: box_size;  % Size of each box (typically 3 for 9x9, 2 for 4x4)
array[1..n, 1..n] of int: initial;  % Initial clues (0 = empty cell)

% Decision variables
array[1..n, 1..n] of var 1..n: grid;

% Fix initial clues
constraint forall(i in 1..n, j in 1..n) (
    if initial[i,j] != 0 then grid[i,j] = initial[i,j] else true endif
);

% Row constraints
constraint forall(i in 1..n) (
    all_different([grid[i,j] | j in 1..n])
);

% Column constraints  
constraint forall(j in 1..n) (
    all_different([grid[i,j] | i in 1..n])
);

% Box constraints  
constraint forall(box_row in 0..(n div box_size - 1), box_col in 0..(n div box_size - 1)) (
    all_different([grid[i,j] | 
                   i in box_row*box_size+1..box_row*box_size+box_size,
                   j in box_col*box_size+1..box_col*box_size+box_size])
);

solve satisfy;

output [
    if j = 1 then "\n" else " " endif ++
    show(grid[i,j])
    | i in 1..n, j in 1..n
] ++ ["\n"];