#!/usr/local/bin/gnuplot

set terminal png size "3800,900"
set output "$FILE.png"

set xdata time
set timefmt "%d/%b/%Y:%H:%M"
set format x "%Y-%m-%d %H:%M"
set xtics rotate by -15

#set nokey
set title "$TITLE"
#set ylabel "count" 1.0,0.0

plot \