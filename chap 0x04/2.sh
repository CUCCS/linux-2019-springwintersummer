#!/bin/bash
function usage()
{
echo "usage:bash worldcup.sh"
echo "OPTIONS:"
echo "-r  count the number and percentage of plyers in different age ranges"
echo "-op count the number and percentage of plyers in different positions"
echo "-n  Find the player with the longest name and the plyer with the shortest name"
echo "-a  Find the player with the oldest age and the youngest age"
echo "-h/-help Get help information"
}
function get_age()
{
	age=$(awk -F '\t' '{print $6}' worldcupplayerinfo.tsv )
	oldest=20
	youngest=30
	count=1
	for i in $age
	do
		if [ "$i" != "Age" ]
		then
			if [ "$i" -gt "${oldest}" ]
			then
				let count+=1
				oldest=$i
			elif [ "$i" -lt "${youngest}" ]
			then
				let count+=1
				youngest=$i
			fi
		fi
	done
	oldest_name=$(awk -F '\t' '{if (($6)=='$oldest'){print $9}}' worldcupplayerinfo.tsv )
        youngest_name=$(awk -F '\t' '{if (($6)=='$youngest'){print $9}}' worldcupplayerinfo.tsv)
	echo "Oldest Players:"
	echo "$oldest_name"
	echo "Their age:$oldest"
	echo "Youngest Players:"
	echo "$youngest_name"
	echo "Their age:$youngest"
}
function get_name()
{
	name_length=$(awk -F '\t' '{print length($9)}' worldcupplayerinfo.tsv)
	longest=0
	shortest=5
	for i in ${name_length}
	do
			if [ $i -gt $longest ]
			then
				longest=$i
			elif [ $i -lt $shortest ]
			then
				shortest=$i
			fi
	done
	longest_name=$(awk -F '\t' '{if (length($9)=='$longest'){print $9}}' worldcupplayerinfo.tsv)
	shortest_name=$(awk -F '\t' '{if (length($9)=='$shortest'){print $9}}' worldcupplayerinfo.tsv)
	echo "Longest name:"
	echo "$longest_name"
	echo "Shortest name:"
	echo "$shortest_name"
}
function age_range()
{
	age=$(awk -F '\t' '{print $6}' worldcupplayerinfo.tsv )
	sum_players=0
	under_20=0
	over_30=0
	between20and30=0
	for i in ${age}
	do
		if [ ${i} != "Age" ]
		then
			let sum_players+=1
			if [ "$i" -lt 20 ]
			then
				let under_20+=1
			elif [ "$i" -gt 30 ]
			then
				let over_30+=1
			elif [ "$i" -ge 20 ]
			then
				let between20and30+=1
			elif [ "$i" -le 30 ]
			then
				let between20and30+=1

			fi
		fi
	done
	echo "The players are $sum_players"
	per1=$[$under_20*100/$sum_players]
	per2=$[$over_30*100/$sum_players]
	per3=$[$between20and30*100/$sum_players]
	printf "Under 20:\nNumbers:%-10d Percent:%-.2f%%\n" "$under_20" "$per1"
	printf "Over 30:\numbers:%-10d Percent:%-.2f%%\n" "$over_30" "$per2"
	printf "Between 20 and 30:\nNumbers:%-10d Percent:%-.2f%%\n" "$between20and30" "$per3"

}
function opsition_range()
{
	all_position=$(awk -F '\t' '{print $5}' worldcupplayerinfo.tsv)
	Goalie=0
	Defender=0
	Midfielder=0
	Forward=0
	for i in ${all_position}
	do
		if [ $i != "Position" ]
		then
			let sum_players+=1
			if [ $i == "Goalie" ]
			then
				let Goalie+=1
			elif [ $i == "Defender" ]
			then
				let Defender+=1
			elif [ $i == "Midfielder" ]
			then
				let Midfielder+=1
			elif [ $i == "Forward" ]
			then
				let Forward+=1

			fi
			
		fi
	done
	per1=$[$Goalie*100/$sum_players]
	per2=$[$Defender*100/$sum_players]
	per3=$[$Midfielder*100/$sum_players]
	per4=$[$Forward*100/$sum_players]
	printf "Goalie:%-10d  Percent:%-.2f%%\n" "$Goalie" "$per1"
	printf "Defender:%-10d Percent:%-.2f%%\n" "$Defender" "$per2"
	printf "Midfielder:%-10d Percent:%-.2f%%\n" "$Midfielder" "$per3"
	printf "Forward:%-10d Percent:%.2f%%\n" "$Forward" "$per4"
}
while [ -n $1 ]
do
       case $1 in
	       -h)
		       usage
		       exit
		       ;;
	       -r)
		       age_range
		       exit
		       ;;
	       -op)
	               opsition_range
	               exit
	               ;;
	       -a)
	               get_age
	               exit
	               ;;
	       -n)
	               get_name
	               exit
	               ;;	       
       esac
done 
