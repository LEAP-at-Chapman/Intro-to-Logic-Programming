#!/bin/bash
# Run Sudoku with COIN-BC solver (from Homebrew MiniZinc)
# Usage: ./run_sudoku_coinbc.sh [data_file]
# Default: sudoku_easy.dzn

DATA_FILE=${1:-sudoku_easy.dzn}
minizinc --solver org.minizinc.mip.coin-bc sudoku.mzn "$DATA_FILE"
