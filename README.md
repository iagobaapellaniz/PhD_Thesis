# Ph. D. Thesis in Quantum Metrology by Iagoba Apellaniz

This thesis was developed on the last year of the PhD. studies.
The aim of this repository is to collect every steps on the development of it.

The public also would be able to download the source code to develop their own thesis.

## Structure and some features

The project can be compiled with `latexmk`, which must be installed in the computer, as
```shell
$ latexmk -bibtex -pdf -shell-escape -jobname=./out/main ./main.tex
```

A more fine tune would be obtained with
```shell
$ jobname=main
$ tempfolder=tmp/
$ outputfolder=out/
$ latexmk -bibtex -pdf -shell-escape -jobname=./$tempfolder$jobname ./main.tex
$ cp ./$tempfolder$jobname.pdf ./$outputfolder$jobname.pdf
$ cp ./$tempfolder$jobname.pdf ./$outputfolder$jobname.pdf
```
This way all the auxiliary files remain in `tmp/` folder and only the main outputs are copied to `out/` folder, overwriting any file if that's the case.

##  Root folder `/`

This is the main folder for the TEX code of the thesis.

As a convection here we use `main.tex`, which is the target file for `latexmk`.
The main TEX files start with `NN-` to reflect the order in which they are imported or they appear in the text.
Two special cases are the appendix and the bibliography files which are `appendix.tex` and `biblio.bib`, respectively.

The bibliography file is written as a BIB file (Find in internet for BibTex for more information).

Another important file in the root folder is the hidden file `.createallpdfs.sh`, which creates several copies of the final PDF for different purposes.

## Images folder `img/`

Here are the main images used by the LaTeX code.

The source code to generate the images are located in `plot_src/`, `svg_src/`, `blend_src/`, and so on. Each of them containing the source for creating the different images.

Inside `svg_src/` there is a special folder: `sa_tex/`. This folder contains a script `generate.sh` that works with `latexmk` to build a stand alone equation to import it to the different SVG images. Run that script, to create the `equation_tmp.tex` file you can edit later for producing the equations.
Run the script from the project folder as
```shell
$ ./img/svg_src/sa_tex/generate.sh
```

## Styling snipets `snp/`

Here one can find the styling files used as code chunks or as styling files.

## Output folder `out/`

The main PDF is found here as well as some other interesting files generated with
```shell
$ ./createallpdfs.sh
```
