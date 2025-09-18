# Sudoku Solvers

This directory contains multiple implementations of Sudoku solvers to illustrate the advantages of constraint programming with specialized solvers as compared to pure logic programming.

See [Constraint Programming and MiniZinc](minizinc-prolog-comparison.md) for a detailed comparison.

## Files

### MiniZinc Implementation (Constraint Programming)
- `sudoku.mzn` - Sudoku model 
- `sudoku_easy.dzn` - Easy 9x9 puzzle (only 2 empty cells)
- `sudoku_hard.dzn` - Hard 9x9 puzzle   
- `sudoku_4x4.dzn` - Small 4x4 puzzle for quick testing

### Prolog Implementation (Logic Programming)
- `sudoku.pl` - Pure Prolog solver with multiple puzzle sizes
- `sudoku4x4.pl` - Specialized 4x4 solver

### Scripts
- `run_sudoku.sh` - Run MiniZinc with Gecode solver
- `run_sudoku_coinbc.sh` - Run MiniZinc with COIN-BC solver

## Usage

### MiniZinc with Gecode (fastest, most standard)
```bash
./run_sudoku.sh                    # Easy 9x9 puzzle
./run_sudoku.sh sudoku_hard.dzn    # Hard 9x9 puzzle
./run_sudoku.sh sudoku_4x4.dzn     # Quick 4x4 puzzle
```

### MiniZinc with COIN-BC
```bash
./run_sudoku_coinbc.sh sudoku_easy.dzn
```

### Prolog
```bash
swipl -f sudoku.pl -g "test_9x9_easy, halt"
swipl -f sudoku.pl -g "test_4x4, halt"
```

