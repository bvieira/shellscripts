#!/usr/local/bin/gnuplot

set terminal png truecolor nocrop enhanced size 3800,900 
set output "$FILE.png"

set xdata time
set timefmt "%d/%b/%Y:%H:%M:%S"
set format x "%Y-%m-%d %H:%M:%S"
set xtics rotate by -15
set xtics 300
set mxtics 150

#set nokey
set title "$TITLE"
set style fill transparent solid 0.35 noborder
set style circle radius 0.02

plot \