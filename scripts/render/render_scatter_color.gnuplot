#!/usr/local/bin/gnuplot

set terminal pngcairo size 1600,480
set output "$FILE.png"

#set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#cccccc" behind 

set xdata time
set timefmt "%d/%b/%Y:%H:%M:%S"
set format x "%Y-%m-%d %H:%M:%S"
set xtics rotate by -15

#set nokey
set title "$TITLE"
#set ylabel "count" 1.0,0.0

rgb(r,g,b) = int(r)*65536 + int(g)*256 + int(b)

abc(x) = x
set cbrange [0:1]
unset colorbox
set palette defined ( 0 "#2D882D", 0.20 "#AA6439", 0.35 "#AA6439", 0.6 "#A8383B") 

plot \
