#!/bin/bash

USERID=$(id -u)

VALIDATE() {

    if [ $1 -ne 0 ]; then
        echo "$2....FAILURE"
        exit 1
    else
        echo "$2....SUCCESS"
    fi

}
if [ $USERID -ne 0 ]; then
    echo "error: This script must be run as root."
    exit 1
fi

dnf list installed | grep mysql

if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? "installing MySQL"
else
    echo "MySQL is already installed."
fi

dnf list installed | grep git

if [ $? -ne 0 ]; then
    dnf install git -y
    VALIDATE $? "installing Git"
else
    echo "Git is already installed."

fi   