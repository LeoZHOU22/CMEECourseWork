#!/bin/sh
#Author:Yutao ZHOU leo.zhou@imperial.ac.uk
#Script:boilerplate.sh
#Desc:simple boilerplate for shell scrpts
#Arguments:none 
#Date: Oct 2023
pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex
evince $1.pdf &

## Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg