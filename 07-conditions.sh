#!/bin/bash

number=$1
if [ $number -gt 10 ]; then
    echo "The number is greater than 10."
else
    echo "The number is less than or equal to 10."
fi
