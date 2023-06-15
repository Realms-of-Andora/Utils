#!/bin/bash

SERVER_PATH="/srv/vs"
DEV_SERVER_PATH="/srv/dev-vs"

NEWEST_BACKUP=$(ls -t "$SERVER_PATH/Backups" | head -1)

echo "The latest backup avaliable from production is: $NEWEST_BACKUP"
echo "Applying this backup to dev will delete the current save in dev."
read -p "Is this the backup you wish to apply to dev? (y/N)" SHOULD_CONTINUE
if [[ $SHOULD_CONTINUE = "y" ]] || [[ $SHOULD_CONTINUE = "Y" ]]
then
	rm -fv "$DEV_SERVER_PATH/Saves/"*
	cp -v "$SERVER_PATH/Backups/$NEWEST_BACKUP" "$DEV_SERVER_PATH/Saves/realms of andora.vcdbs"
	rm -rfv "$DEV_SERVER_PATH/Mods/"*
	cp -rv "$SERVER_PATH/Mods/"* "$DEV_SERVER_PATH/Mods/"
fi
