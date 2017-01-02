#!/usr/local/bin/gnuplot

set terminal png size 1600,480
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
0 with filledcurves y1=1000 lt 1 lc rgb "#DAFFE1", \