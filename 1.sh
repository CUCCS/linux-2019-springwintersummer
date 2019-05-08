#!/bin/bash
function usage(){
echo "There is some help information~~~~"
echo "-q    [path][quality] Compress JEPG images"
echo "-h    ask for help"
echo "-c    [path]['xx%'x'xx%'] Compression resolution of images in jpeg/png/svg format while maintaning the original aspect ratio"
echo "-w    [path][wartermark] Batch add custom text wartermark to the picture"
echo "-r    [path][add-name][--prefix|--sufix] Batch rename(uniformly add filename prefix or suffix without affecting the original file extension)"
echo "-e    [path] Convert png/svg images uniformly to jpg format images"
}
function add_name()
{
	path=$2
	add_fix=$3
	pre_su=$4
	if [ -d $path ]
	then
		files=$(find ${path} -type f)
		for i in ${files}
		do
			
			if [ $pre_su = "--sufix" ]
			then
				old_name=$i
                                filename=${i%.*}
                                extension='.'${i##*.}
				new_name=${filename}${add_fix}${extension}
				cp $old_name $new_name
			elif [ ${pre_su} = "--prefix" ]
			then

                                old_name=$i
                                filename=${i%.*}
                                extension='.'${i##*.}
                                new_name=${add_fix}${filename}${extension}
				cp $old_name $new_name

			fi
		done
	else
		echo "There no such directory"
        fi
}

function exchange()
{
        path=$2
        if [ -d $path ]
	then
		files=$(find $path -regex '.*\.svg\|.*\.png')
                for i in ${files}
		do
			old_name=$i
			add_name='ex'
			filename=${i%.*}
                        extension='.'${i##*.}
                        new_name=${filename}${add_name}${extension}
                        convert ${old_name} ${new_name}
		done
	else
		echo "There no such directory"
        fi
}

function embed_watermark()
{
	path=$2
	warter=$3
	if [ -d $path ];then
		echo "There is directory"
		files=$(find ${path} -regex '.*\.jpg\|.*\.svg\|.*\.png')
		if [ ! -n ${files} ]
		then
			echo "There no pictures"
		else
			echo "These picture will be quality compress:"
                        echo "$(identify $files)"
                        echo "After embed water:"
                        for i in ${files}
                        do
                               old_name=$i
                               filename=${i%.*}
                               extension='.'${i##*.}
                               add_name="war"
                               new_name=${filename}${add_name}${extension}
                               convert ${old_name} -fill -pointsize -draw "text 10,20 ${water}" ${new_name} 
                        done
	        fi
        fi

}
function resolution()
{
       path=$2
       rates=$3
       if [ -d $path ];then
	       echo "There is directory"
               files=$(find ${path} -regex '.*\.jpg\|.*\.svg\|.*\.png')
               if [ ${files} = "" ]
               then
                       echo "There no jEPG pictures"
               else
                       echo "These picture will be quality compress:"
                       echo "$(identify $files)"
                       echo "After quality compress:"
                       for i in ${files}
                       do
                               old_name=$i
                               filename=${i%.*}
                               extension='.'${i##*.}
                               add_name="res"
                               new_name=${filename}${add_name}${extension}
	                       convert -resize "${rates}" "${old_name}" "${new_name}"		       
                       done
               fi

       else
               echo "No such directory"
       fi

}
function compress()
{
	path=$2
	quality=$3
	if [ -d $path ];then
		echo "There is directory"
		files=$(find ${path} -regex '.*jpg')
		if [ ${files} = "" ]
		then
			echo "There no jEPG pictures"
		else
			echo "These picture will be quality compress:"
			echo "$(identify $files)"
			echo "After quality compress:"
			for i in ${files}
			do
				old_name=$i
				filename=${i%.*}
				extension='.'${i##*.}
				add_name="qua"
				new_name=${filename}${add_name}${extension}
				convert ${old_name} -quality ${quality} ${new_name}
			done
		fi

	else
		echo "No such directory"
	fi
	
}
while [ -n "$1" ];do
	case "$1" in 
		-h)
			usage
			exit
			;;
		-q)
			compress
			exit
			;;
		-c)
			resolution
			exit
			;;
		-w)
			embed_watermark
			exit
			;;
		-r)
			add_name
			exit
			;;
		-e)
			exchange
			exit
			;;
	esac
	shift
done
