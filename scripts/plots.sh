#/bin/bash

plot() {
	local title=`echo $1 | sed 's/_/-/g'`
	local output=$2

	echo plotting $output

	local path="result/"$3
	local filesize=` wc -l $path | awk '{print $1}'` 
	
	if [ $filesize -gt 0 ] ; then
		sed -e 's/$TITLE/'"$title"'/g' scripts/render/render_date.gnuplot  | sed -e 's/$FILE/'"$output"'/g' > result/execute_render.sh
		for i in ${@:3} ; do 
			local f=`echo "$i" | awk -F ":" '{print $1}'`
			local t=`echo "$i" | awk -F ":" '{print $2}'`
			if [ -z "$t" ]; then
				t="line"
			fi
			echo "'"$f"' using 1:2 with $t title '"$(echo $f | sed 's/.log//' | sed 's/.tmp//' | sed 's/_/-/g')"', \\" >> result/execute_render.sh; 
		done

		cd result
		chmod +x execute_render.sh
		./execute_render.sh 2> /dev/null
		rm execute_render.sh
		cd ..
	else
		echo "  |->  empty file, ignoring it..."
	fi
}

plotScatter() {
	local title=`echo $1 | sed 's/_/-/g'`
	local output=$2

	echo plotting $output

	local path="result/"$3
	local filesize=` wc -l $path | awk '{print $1}'` 
	local max=`cat $path | awk '{print $2}' | sort -nr | head -n 1`

	if [ $filesize -gt 0 ] ; then
		sed -e 's/$TITLE/'"$title"'/g' scripts/render/render_scatter.gnuplot | sed -e 's/$MAX_NUMBER/'"$max"'/g' | sed -e 's/$FILE/'"$output"'/g' > result/execute_render.sh
		for i in ${@:3} ; do echo "'"$i"' using 1:2 with dots title '"$(echo $i | sed 's/.log//' | sed 's/.tmp//' | sed 's/_/-/g')"', \\" >> result/execute_render.sh; done

		cd result
		chmod +x execute_render.sh
		./execute_render.sh 2> /dev/null
		rm execute_render.sh
		cd ..
	else
		echo "  |->  empty file, ignoring it..."
	fi
}

plotScatterCircle() {
	local title=`echo $1 | sed 's/_/-/g'`
	local output=$2

	echo plotting $output

	local path="result/"$3
	local filesize=` wc -l $path | awk '{print $1}'` 
	local max=`cat $path | awk '{print $2}' | sort -nr | head -n 1`

	if [ $filesize -gt 0 ] ; then
		sed -e 's/$TITLE/'"$title"'/g' scripts/render/render_scatter_circle.gnuplot | sed -e 's/$MAX_NUMBER/'"$max"'/g' | sed -e 's/$FILE/'"$output"'/g' > result/execute_render.sh
		for i in ${@:3} ; do echo "'"$i"' using 1:2 with circles lc rgb \"blue\" title '"$(echo $i | sed 's/.log//' | sed 's/.tmp//' | sed 's/_/-/g')"', \\" >> result/execute_render.sh; done
	
		cd result
		chmod +x execute_render.sh
		./execute_render.sh 2> /dev/null
		rm execute_render.sh
		cd ..
	else
		echo "  |->  empty file, ignoring it..."
	fi
}

plotScatterCircleColor() {
	local title=`echo $1 | sed 's/_/-/g'`
	local output=$2

	echo plotting $output

	local path="result/"$3
	local filesize=` wc -l $path | awk '{print $1}'` 
	local max=`cat $path | awk '{print $2}' | sort -nr | head -n 1`

	if [ $filesize -gt 0 ] ; then
		sed -e 's/$TITLE/'"$title"'/g' scripts/render/render_scatter_circle_color.gnuplot | sed -e 's/$MAX_NUMBER/'"$max"'/g' | sed -e 's/$FILE/'"$output"'/g' > result/execute_render.sh
		for i in ${@:3} ; do echo "'"$i"' using 1:2:3 with circles palette title '"$(echo $i | sed 's/.log//' | sed 's/.tmp//' | sed 's/_/-/g')"', \\" >> result/execute_render.sh; done
	
		cd result
		chmod +x execute_render.sh
		./execute_render.sh 2> /dev/null
		rm execute_render.sh
		cd ..
	else
		echo "  |->  empty file, ignoring it..."
	fi
}

plotScatterColor() {
	local title=`echo $1 | sed 's/_/-/g'`
	local output=$2

	echo plotting $output

	local path="result/"$3
	local filesize=` wc -l $path | awk '{print $1}'` 
	local max=`cat $path | awk '{print $2}' | sort -nr | head -n 1`

	if [ $filesize -gt 0 ] ; then
		sed -e 's/$TITLE/'"$title"'/g' scripts/render/render_scatter_color.gnuplot | sed -e 's/$MAX_NUMBER/'"$max"'/g' | sed -e 's/$FILE/'"$output"'/g' > result/execute_render.sh

		echo "'"$3"' using 1:2:3 with dots palette title '"$(echo $3 | sed 's/.log//' | sed 's/.tmp//' | sed 's/_/-/g')"', \\" >> result/execute_render.sh
		for i in ${@:4} ; do echo "'"$i"' using 1:2 with points pt 2 ps 1 lc rgb '#EE413075' title '"$(echo $i | sed 's/.log//' | sed 's/.tmp//')" ', \\" >> result/execute_render.sh; done

		cd result
		chmod +x execute_render.sh
		./execute_render.sh 2> /dev/null
		rm execute_render.sh
		cd ..
	else
		echo "  |->  empty file, ignoring it..."
	fi
}