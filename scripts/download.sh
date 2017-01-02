#/bin/bash

formatLog() {
	local hostname=$1
	local formatlog=$2
	local logname=$3
	local logpath=$4
	local gzpath=$5

    local result=""

    for dhour in $(seq $hourstart $hourend);do
	    if [[ ${#dhour} -lt 2 ]]; then
	      dhour="0"$dhour
	    fi
	    local timelog=$dt"_"$dhour
	    local currhour=`date +"%H"`
        for fname in $logname;do
	    	if [ "$dt" == "$currentdt" ] && [ "$dhour" == "$currhour" ]; then
	    		result=$result" $logpath/$fname.log"
	    	fi
	    	local r=`echo " "$formatlog | sed "s|#FILE#|$fname|g" | sed "s|#HOSTNAME#|$hostname|g" | sed "s|#DATE#|$dt|g" | sed "s|#CURRLOG#|$currlog|g" | sed "s|#VOL#|$gzpath|g" | sed "s|#VAR#|$logpath|g" | sed "s|#TIMELOG#|$timelog|g"`
	    	result=$result$r
	    done

	done

    echo $result
}

download() {
	local hostname=$1
	local simplehostname=`echo $hostname | awk '{print substr($0, 0, index($0,".")-1)}'`
	local dst=$2
	local logpath=$3
	local gzpath=$4
	local logformat=$5
	local filesname=$6

    local log=`formatLog $simplehostname "$logformat" "$filesname" $logpath "$gzpath$poolnumber" $timelog`

    echo "Downloading log on "$simplehostname
	mkdir -p $dst
	#sshpass -f /tmp/pwd 
	tput bel
	say -v Bubbles "bubbles"
#	scp $hostname:"$log" $hostname/
	../scripts/sshpass-scp.exp $user $password $hostname "$log" "$dst/"

	cd $dst
	gunzip *gz
	cd ..
}

downloadExec() {
	local hostname=$1
	local simplehostname=`echo $hostname | awk '{print substr($0, 0, index($0,".")-1)}'`
	local dst=$2
	local execcmd="$3 | gzip"

    echo "Filter log and download on "$simplehostname

	echo "ssh $user@$hostname \"$execcmd\"" > ../scripts/expect-execute.sh
	chmod +x ../scripts/expect-execute.sh
	../scripts/sshpass-execute.exp $password > log.compressed
	rm ../scripts/expect-execute.sh

	local line=`grep -a -n "$user@" log.compressed | tail -n1 | awk -F ":" '{print $1}'`
	echo "---->"$line
	sed -i".exec.trim.tmp" '1,'"$line"'d' log.compressed
	rm $dst.exec.trim.tmp
}

trim() {
	local srcdir=$1

	trimstart=true
	if [[ $hstart =~ .*":00"$ ]]; then
		trimstart=false
	fi

	trimend=true
	if [[ $hend =~ .*":59"$ ]]; then
		trimend=false
	fi

	cd $srcdir

	local currhour=`date +"%H"`
	if [ $trimstart = true ]; then
		echo "trimming start time "$dt" "$hstart

		if [ "$dt" == "$currentdt" ] && [ "$hourstart" == "$currhour" ]; then
			find . -name "*.log*" | grep -v $dt | grep -f ../downloadedfiles.tmp > files.trim.list
		else
			find . -name "*.log*" | grep $dt"_"$hourstart | grep -f ../downloadedfiles.tmp > files.trim.list
		fi

		local tmphour=`echo $hstart | cut -c 1-4`
		while read filename; do
			echo "trimming "$filename
			line=`grep -n "$dt $tmphour" $filename | head -n1 | awk -F ":" '{print $1}'`
			sed -i".trim.tmp" '1,'"$line"'d' $filename
		done <files.trim.list
		rm files.trim.list
		rm *.trim.tmp
	fi

	if [ $trimend = true ]; then
		echo "trimming end time "$dt" "$hend
		if [ "$dt" == "$currentdt" ] && [ "$hourend" == "$currhour" ]; then
			find . -name "*.log*" | grep -v $dt | grep -f ../downloadedfiles.tmp > files.trim.list
		else
			find . -name "*.log*" | grep $dt"_"$hourend | grep -f ../downloadedfiles.tmp > files.trim.list
		fi

		local tmphour=`echo $hend | cut -c 1-4`
		while read filename; do
			echo "trimming "$filename
			line=`grep -n "$dt $tmphour" $filename | tail -n1 | awk -F ":" '{print $1}'`
			size=`wc -l $filename | awk '{print $1}'`
			sed -i".trim.tmp" ''"$line"','"$size"'d' $filename
		done <files.trim.list
		rm files.trim.list
		rm *.trim.tmp
	fi
	cd ..
}

simpleTrim() {
	local srcfile=$1
	local type=$2
	local token=$3

	echo "trimming $srcfile type $type"

	if [ "$type" == "top" ]; then
		line=`grep -n "$token" $srcfile | head -n1 | awk -F ":" '{print $1}'`
		if (( $line > 1 )); then
			sed -i".trim.tmp" '1,'"$line"'d' $srcfile
		fi
	fi

	if [ "$type" == "bottom" ]; then
		line=`grep -n "$token" $srcfile | tail -n1 | awk -F ":" '{print $1}'`
		size=`wc -l $srcfile | awk '{print $1}'`
		if (( $line < size )); then
			sed -i".trim.tmp" ''"$line"','"$size"'d' $srcfile
		fi
	fi
	rm *.trim.tmp
}

downloadLogs() {
	local pool=$1
	local logpath=$2
	local gzpath=$3
	local logformat=$4
	local filesname=$5

	for fname in $filesname;do
		echo "$fname" >> downloadedfiles.tmp;
	done
	
	echo "Downloading logs for "$dt
	for i in $pool;do
		local dst=`echo $i | awk '{print substr($0, 0, index($0,".")-1)}'`
		download $i $dst $logpath $gzpath "$logformat" "$filesname"
	 	trim "$dst"
	done

	rm downloadedfiles.tmp
}