#!/bin/bash
#


# script should be accessed as root/sudo user
#
if [[ "${UID}" -ne 0 ]]
then
	echo "run with sudo or toot permissions"
	exit 1
fi

# should provide atleast one argument as username otherwise guide him
#
if [[ "${#}" -lt 1 ]]
then
	echo " usage: ${0} USERNAME [comment]...."
	echo " create user with USERNAME and comment field "
	exit 1
fi

#store 1st argument as user name

username="${1}"

# In case more then one arguments stre it AS account comment
#
shift
comment="${@}"

# create a password

password=$(date +%s%N)
echo $password
# create user
#
useradd -c "$comment" -m $username

#check user successfully created or not
#
if [[ $? -ne 0 ]]
then
	echo " Account could not be created"
	exit 1
fi

#set password for user 
#set password for user 
echo "${username}:${password}" | chpasswd

#echo $password | passwd --stdin $username

# check if password is successfully set or not
#
if [[ $? -ne 0 ]]
then
	echo " password is not set"
	exit 1
fi

#Force password change on first login

passwd -e $username

#display the username, password, and host on which it is created


echo "USERNAME: $username"
echo "PASSWORD: $password"

echo $(hostname)

