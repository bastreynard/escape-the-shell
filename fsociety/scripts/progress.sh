#!/bin/bash
# This is the script used to check the game progress
# It is binified using shc to hide its content in the container

#####################################################################
### Step 1: Player must remove infected files
#####################################################################
function num_infected_files() {
	local filesInfected
	filesInfected=0
    if grep -q 'fsociety' ~/.bashrc 2>>/dev/null; then
		filesInfected="$(( filesInfected + 1 ))"
	fi
	if grep -q 'fsociety' /etc/init.d/fsociety 2>>/dev/null; then
		filesInfected="$(( filesInfected + 1 ))"
	fi
	if ls -la /root 2>>/dev/null | grep -q .bashrc; then
		filesInfected="$(( filesInfected + 1 ))"
	fi
	return "$filesInfected"
}

function remaining() {
    num_infected_files
	echo "$?"
}

function status() {
    num_infected_files
	echo "$(( 3 - $? ))"
}

function max() {
    local max
	max="?"
    num_infected_files
    if [ "$(( 3 - $? ))" -ge 2 ]; then
	  max="3"
	fi
    echo "$max"
}

#####################################################################
### Step 2: A mysterious file appeared in ~/.
#####################################################################
function step2_init() {
    # Make sure the ascii fsociety was not removed by player
    if [[ ! -f "/usr/f.ascii" ]]; then
        cp /usr/motd.bck /usr/f.ascii
    fi
    # The player might try to remove it so we might as well recopy it every time...
    cp /usr/.2.txt /home/elliot/.ecorp-encrypted.txt
    # Show message only once
    if [[ ! -f "/usr/share/status.2" ]]; then
    timeout 5s cmatrix
    echo -e "System is clean. Congratulations, friend.\\r\\n"
    echo -e "It unlocked something, I see a new encrypted file that might hold sensitive informations about E-Corp.\\r\\n"
    echo -e "I wonder if we can find the key to decipher it, somewhere in the system...\\r\\n"
    fi
    sudo touch /usr/share/status.2
}

#####################################################################
### Global helpers
#####################################################################
function get_step() {
    # Check if player has gotten rid of all infected files
    num_infected_files
    if [ "$?" != 0 ]; then
	  echo 2
      return 0
	fi
    # Check if step 2 is complete
    if [[ -f "/usr/share/complete.2" ]]; then
      echo 3
      return 0
    fi
    echo 0
}

function i_escaped_the_shell() {
    sudo touch /usr/share/complete.2
}

#####################################################################
### Arguments for progress tracking to be used by the system
#####################################################################
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
    step2_init)
        step2_init 
        ;;
    get_step)
        get_step
        ;;
    i_escaped_the_shell)
        i_escaped_the_shell
        ;;
    *)
        echo "Usage: progress {remaining|status|max|get_step}"
        ;;
esac
