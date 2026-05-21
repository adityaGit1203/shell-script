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

dnf list installed | grep mysql &>>$LOG_FILE_NAME

if [ $? -ne 0 ]; then
    dnf install mysql -y &>>$LOG_FILE_NAME
    VALIDATE $? "installing MySQL"
else
    echo -e "MySQL is already $Y installed $N"
fi

dnf list installed | grep git &>>$LOG_FILE_NAME

if [ $? -ne 0 ]; then
    dnf install git -y &>>$LOG_FILE_NAME
    VALIDATE $? "installing Git"
else
    echo -e "Git is already $Y installed $N"
fi 