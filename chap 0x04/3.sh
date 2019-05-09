#!/bin/bash
function usage()
{
	echo "usage:bash web.sh"
	echo "OPTIONS:"
	echo "-a  Count the total number of visits to the source host TOP 100 and the corresponding times"
	echo "-b  Count the total number of visits to the TOP 100 IP of the source host and corresponding occurrences respectivaly"
	echo "-c  Count most frequency accessed top 100 URL"
	echo "-d  Count the frequency and percentage of different response status codes"
	echo "-e  The top 10 URL corresponding to different 4xx status codes and the total number of corresponding occurrences"
	echo "-f  Given URL output top 100 access source host"
	echo "-h  Help information"
}
function certainhost()
{
	cat web_log.tsv|awk -F '\t' '{if ($5=="'$url'")sum[$1]++} END {for(i in sum){print sum[i]      ,i}}'|sort -n -r -k 1|head -n 100 > certainhost.txt
	echo "Success!! It saves in certainhost.txt"
}
function get_4xxcode()
{
	cat web_log.tsv|awk -F '\t' ' { if ($6~/^403/) {sum[$6":"$1]++}} END {for(i in sum){print sum[i]      ,i}}'|sort -n -r -k 1|head -n 10 > get_403code.txt
	echo "The data in get_403code.txt"
	cat web_log.tsv|awk -F '\t' ' { if ($6~/^404/) {sum[$6":"$1]++}} END {for(i in sum){print sum[i]      ,i}}'|sort -n -r -k 1|head -n 10 > get_404code.txt
	echo "The data in get_404code.txt"
}
function response()
{
	more +2 web_log.tsv|awk -F '\t' '{sum[$6]++} END {for (i in sum){print sum[i]                                               ,i}}'|sort -n -r -k 2 
       	more +2 web_log.tsv|awk -F '\t' '{sum[$6]++} END {for (i in sum){print sum[i]      ,i}}'|awk '{arr[$2]=$1;sums+=$1} END {for (k in arr) print arr[k]/sums*100                                                    ,k}'|sort -n -r -k 2

}

function frequent_url()
{
        cat web_log.tsv|awk -F '\t' '{sum[$5]++} END {for(i in sum){print sum[i]                      ,i }}'|sort -n -r -k 1|head -n 100 > frequenturl.txt
        echo "Success!! It saves in frequenturl.txt"


}
function top_ip()
{
	cat web_log.tsv|awk -F '\t' '{sum[$1]++} END {for(i in sum){print sum[i]      ,i}}'|awk '{if ($2~/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]/){print}}'|sort -n -r -k 1|head -n 100 > topip.txt
        echo "Success!! It saves in topip.txt"
}
function top_host()
{
	cat web_log.tsv|awk -F '\t' '{sum[$1]++} END {for(i in sum){print sum[i]      ,i}}'|sort -n -r -k 1|head -n 100 > tophost.txt
        echo "Success!! It saves in tophost.txt"
}
while [ -n $1 ];do
	case $1 in
		-a)
			top_host
			exit
			;;
		-b)
			top_ip
			exit
			;;
		-c)
			frequent_url
			exit
			;;
		-d)
			response
			exit
			;;
		-e)
			get_4xxcode
			exit
			;;
		-f) url=$2;
			certainhost
			exit
			;;
		-h)
			usage
			exit
			;;
	esac
done


