#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE_NAME="$LOGS_FOLDER/$(date +%Y-%m-%d-%H-%M-%S).log"


VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2....$R FAILURE $N"    
        exit 1
    else
         echo -e "$2....$G SUCCESS $N"
    fi
}

echo "script execution started" &>>$LOG_FILE_NAME

if [ $USERID -ne 0 ] 
then
    echo "error: This script must be run as root."
    exit 1
fi

for package in $@
do
    dnf list installed | grep $package &>>$LOG_FILE_NAME

    if [ $? -ne 0 ]; then
        dnf install $package -y &>>$LOG_FILE_NAME
        VALIDATE $? "installing $package"
    else
        echo -e "$package is already $Y installed $N"
    fi
done
