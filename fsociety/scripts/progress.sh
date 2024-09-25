#!/bin/bash
# This is the script that checks game progress
# It is binified using shc to hide its content in the container

function check_files() {
	local filesInfected
	filesInfected=0
    if grep -q 'f''society' ~/.bashrc 2>>/dev/null; then
		filesInfected="$(( filesInfected + 1 ))"
	fi
	if grep -q 'f''society' /etc/init.d/f""society 2>>/dev/null; then
		filesInfected="$(( filesInfected + 1 ))"
	fi
	if ls -la /root 2>>/dev/null | grep -q .bashrc; then
		filesInfected="$(( filesInfected + 1 ))"
	fi
	return "$filesInfected"
}

function remaining() {
    check_files
	echo "$?"
}

function status() {
    check_files
	echo "$(( 3 - $? ))"
}

function max() {
    local max
	max="?"
    check_files
    if [ "$(( 3 - $? ))" -ge 2 ]; then
	  max="3"
	fi
    echo "$max"
}

# Argument parsing
case "$1" in
    remaining)
        remaining
        ;;
    status)
        status
        ;;
    max)
        max 
        ;;
    *)
        echo "Usage: progress {remaining|status|max}"
        ;;
esac
