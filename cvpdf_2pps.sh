#! /bin/bash

gs -o out/temp.pdf -sDEVICE=pdfwrite -sPAPERSIZE=a4 -c showpage -f out/main.pdf

pdfnup --nup 2x1 --paper a4paper --trim "0.5cm 0cm 0.5cm 0cm" --clip true --outfile out/2x1-a4-main.pdf out/temp.pdf
