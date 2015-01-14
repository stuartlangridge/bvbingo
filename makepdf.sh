#!/bin/bash

# get number from 

case $1 in
    ''|*[!0-9]*) echo Please supply number of pages; exit 1 ;;
    *) ;;
esac

rm bpage-text-*.pdf bpage-combined.pdf bpage-combined.ps bingo.pdf

for f in $(seq -w 1 $1); do
    # convert to pdf
    wkhtmltopdf -O landscape -s Letter -T 0 -R 0 -L 0 -B 0 bingo.html bpage-text-$f.pdf
done

# combine all pdfs into one big pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=bpage-combined.pdf bpage-text-*.pdf

# convert text to paths so anyone without the font can print it
# can't use inkscape here because it only handles single-path pdfs
gs -o bpage-combined.ps -dNOCACHE -sDEVICE=ps2write bpage-combined.pdf
gs -o bingo.pdf -sDEVICE=pdfwrite bpage-combined.ps

# tidy up
rm bpage-text-*.pdf bpage-combined.pdf bpage-combined.ps
