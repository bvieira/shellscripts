#!/usr/local/bin/gnuplot

set terminal png size "3800,900"
set output "$FILE.png"

#set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#cccccc" behind 

set xdata time
set timefmt "%d/%b/%Y:%H:%M:%S"
set format x "%Y-%m-%d %H:%M:%S"
set xtics rotate by -15

#set nokey
set title "$TITLE"
#set ylabel "count" 1.0,0.0

plot \