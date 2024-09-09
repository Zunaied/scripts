#!/bin/bash
 
<<readme
this is a backup script with 5 day rotation.

readme

function display_usage {
	echo ".backup.sh <path to your source file> <path to your backup file>"

}

if [ $# -eq 0 ]; then 
	display_usage

fi

source_dir=$1
backup_dir=$2
timestamp=$(date '+%y-%m-%d-%H-%M-%S')
function create_backup {
	zip -r "${backup_dir}/backup_${timestamp}.zip" "$source_dir">>/dev/null
 	if [ $? -eq 0 ]; then
		echo "backup success for ${timestamp}"
	fi
}

function performing_rotation {
	
	backups=($(ls -t "${backup_dir}/backup"*.zip))
	 
        if [ "${#backups[@]}" -gt 5 ]; then
		echo "performing rotation"
		backups_to_rmv=("${backups[@]:5}")
		for backup in "${backups_to_rmv[@]}";
		do
			rm -rf $backup

		done
	fi
	}

create_backup
performing_rotation
