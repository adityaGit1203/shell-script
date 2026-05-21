#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

    if [ $1 -ne 0 ]; then
        echo -e "$2....$R FAILURE"    
        exit 1
    else
        echo -e "$2....$G SUCCESS"
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
    echo -e "MySQL is already $Y installed."
fi

dnf list installed | grep git

if [ $? -ne 0 ]; then
    dnf install git -y
    VALIDATE $? "installing Git"
else
    echo -e "Git is already $Y installed."
fi 