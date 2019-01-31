#!/usr/bin/env perl
$pdf_mode = 3;
$latex = 'uplatex -kanji=utf8 -synctex=1 %O %S';
$bibtex = 'upbibtex %O %B';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'upmendex %O -o %D %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$max_repeat = 5;
$pvc_view_file_via_temporary = 0;
$pdf_previewer= 'evince';
