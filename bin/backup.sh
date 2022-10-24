#!/bin/bash
#Author: @cristiansulighetean
#Date: 24.10.2022
# Script to prompt to back up and compress files
# from the home directory

read -p "Which directory do you want to backup to: " dir_name
read -p "Choose H,M or L compression: " file_compression

# The next lines creates the directory if it does not exist
test -d $HOME/$dir_name || mkdir -m 700 $HOME/$dir_name
backup_dir=$HOME/$dir_name

tar_l="-cvf $backup_dir/b.tar --exclude $backup_dir $HOME"
tar_m="-cvf $backup_dir/b.tar.gz --exclude $backup_dir $HOME"
tar_h="-cvf $backup_dir/b/tar.bzip2 --exclude $backup_dir $HOME"

if [ $file_compression = "L" ]; then
	tar_opt=$tar_l
elif [ $file_compression = "M" ]; then
	tar_opt=$tar_m
else
	tar_opt=$tar_h
fi

tar $tar_opt
exit 0