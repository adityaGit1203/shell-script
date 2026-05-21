#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "error: This script must be run as root."
    exit 1
fi

dnf install mysqll -y
