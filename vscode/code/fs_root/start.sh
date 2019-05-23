#!/usr/bin/env bash
set -e

function handle_signal() {
	signal=$1
	kill -$signal -1    # -1   - kill all processes your can kill
	exit 0
}

if [ -f FIRST_START ]; then
	GROUP="$GROUP"
	USER="$USER"

	echo "Creating group with gid $GID"
	groupadd $GROUP --gid $GID
	echo "Creating user with uid $UID"
	adduser $USER --uid $UID --ingroup $GROUP --no-create-home --disabled-password --gecos ""

	# for file in $(find /home/temp/); do
	# 	if [ $file != "/home/temp/" ]; then
	# 		mv $file /home/$USER/.
	# 	fi
	# done
	# rmdir /home/temp

	echo "fixing ownership of home-dir from root to actual user \"$USER\""
	chown $USER:$GROUP /home/$USER
	# usermod --home /home/$USER $USER

	rm /FIRST_START
fi

trap "echo SIGHUP not handled; exit 1"   SIGHUP
trap "echo SIGINT not handled; exit 2"   SIGINT
trap "echo SIGQUIT not handled; exit 3"  SIGQUIT
trap "echo SIGKILL not handled; exit 9"  SIGKILL

# trap "echo SIGTERM not handled; exit 15" SIGTERM
trap "handle_signal SIGTERM" SIGTERM

trap "echo SIGCHLD not handled; exit 17" SIGCHLD
trap "echo SIGSTOP not handled; exit 19" SIGSTOP

DIR_WORK="/project"

cd $DIR_WORK
sudo -u $USER code $DIR_WORK --user-data-dir /user_data_dir &
PID=$!

while true; do
	sleep 1
done
