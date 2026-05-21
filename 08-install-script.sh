#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "error: This script must be run as root."
    exit 1
fi

dnf list installed | grep mysql
if [ $? -ne 0 ]; then
    dnf install mysql -y
    if [ $? -ne 0 ]; then
        echo "error: Failed to install MySQL."
        exit 1
    else
        echo "MySQL installed successfully."
    fi
else
    echo "MySQL is already installed."
fi

dnf list installed | grep git

if [ $? -ne 0 ]; then
    dnf install git -y
    if [ $? -ne 0 ]; then
        echo "error: Failed to install Git."
        exit 1
    else
        echo "Git installed successfully."
    fi
else
    echo "Git is already installed."
fi   