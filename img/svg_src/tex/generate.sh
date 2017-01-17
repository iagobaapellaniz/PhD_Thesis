#! /usr/bin/bash

# Run this script to generate the equations into PDF format

# PDF or project name, change this
jobname=equation_tmp
# String for the equation. Change it as you want

# Patch to solve relative path problems
path2this=./img/svg_src/tex

# Check for file equation_tmp.tex. This is where one has to edit the standalone
# equations to avoid the git modified complains
file=$path2this/equation_tmp.tex
if [ ! -e "$file" ] ; then
    echo "% Edit this file as if you would be inside the equation environment of LaTeX" >> $file
    echo "%" >> $file
    echo "E=mc^2 \; \text{Amazing! You just generated your first standalone equation!}" >> $file
    echo "%" >> $file
    echo "% Your PDF equation_tmp.pdf is ready for exporting!" >> $file
fi

# Substitute relative to path2this/relative in file for the input.tex
latexmk -pdf -shell-escape -jobname=$path2this/$jobname $path2this/main.tex
latexmk -pdf -shell-escape -c -jobname=$path2this/$jobname $path2this/main.tex

exit
