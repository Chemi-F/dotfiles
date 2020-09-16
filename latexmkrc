#!/usr/bin/env perl

# LaTeX commands
$latex = 'uplatex -kanji=utf8 -synctex=1 %O %S';
$pdflatex = 'lualatex -synctex=1 %O %S';

# bibTeX commands
$bibtex = 'upbibtex %O %B';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$makeindex = 'upmendex %O -o %D %S';

# Device driver
$dvipdf = 'dvipdfmx %O -o %D %S';

# Typeset mode
# 0: do not generate a pdf
# 1: using $pdflatex
# 2: using $ps2pdf
# 3: using $dvipdf
$pdf_mode = 1;

# Others
$pvc_view_file_via_temporary = 0;
$max_repeat = 5;
$pdf_previewer= 'zathura';
