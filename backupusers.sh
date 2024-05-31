#!/bin/bash
if ! dpkg-query -l | grep -q cifs-utils; then
	apt-get install cifs-utils
fi

mkdir /mnt/windows-fileshare 2>/dev/null
mount -t cifs -o user=backupuser //bakewell/ubuntu-backups /mnt/windows-fileshare

for directory in /home/*
do
	tar -cvzf $directory.tgz $directory
        gpg --output $directory.tgz.enc  --symmetric --cipher-algo AES256 \
       	--pinentry-mode loopback --passphrase @2jdnps  $directory.tgz
done

now=$(date '+%d-%m-%Y')

mkdir /mnt/windows-fileshare/$now
cp /home/*.enc /mnt/windows-fileshare/$now
rm /home/*.enc
rm /home/*.tgz

umount /mnt/windows-fileshare
