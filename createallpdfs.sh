#! /bin/bash

# Create a temp file with one more blank page obtained from the very same file
# and make it 2 pages per side for draft printing
pdfjam --paper a4paper --scale 1.0 out/main.pdf '2' out/main.pdf '-' --outfile out/temp.pdf
pdfjam --paper a4paper --nup 2x1 --landscape out/temp.pdf --outfile out/a4-2x1-main.pdf
rm out/temp.pdf

# Create a4 main output for draft printing
pdfjam --paper a4paper out/main.pdf '-' --outfile out/a4-main.pdf

# Create an a4 main output without cover for final printing.
pdfjam --paper letterpaper out/main.pdf '-' --outfile out/nc-main.pdf
cp img/0-whole-cover.pdf out/0-whole-cover.pdf
