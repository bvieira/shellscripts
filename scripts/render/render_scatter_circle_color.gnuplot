#!/usr/local/bin/gnuplot

set terminal png transparent truecolor nocrop enhanced size 1600,480 
set output "$FILE.png"

set xdata time
set timefmt "%d/%b/%Y:%H:%M:%S"
set format x "%Y-%m-%d %H:%M:%S"
set xtics rotate by -15

#set nokey
set title "$TITLE"
set style fill transparent solid 0.2 noborder
set style circle radius 0.05
set palette model RGB defined (0 "#11AD34", 0.4 "#E69F17", 0.6 "#E69F17", 0.9 "#E62B17", 1.2 "#999999")

plot \