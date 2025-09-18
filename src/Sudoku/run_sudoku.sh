#!/bin/bash
# Run Sudoku with Gecode solver (from MiniZinc IDE)
# Usage: ./run_sudoku.sh [data_file]
# Default: sudoku_easy.dzn

DATA_FILE=${1:-sudoku_easy.dzn}
"/Applications/MiniZincIDE.app/Contents/Resources/minizinc" --solver org.gecode.gecode sudoku.mzn "$DATA_FILE"
