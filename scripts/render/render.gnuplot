#!/usr/local/bin/gnuplot

set terminal png size "1600,900"
set output "$FILE.png"

set xdata time
set timefmt "%H:%M"
set format x "%H:%M"

#set nokey
set title "$TITLE"
#set ylabel "count" 1.0,0.0

plot \