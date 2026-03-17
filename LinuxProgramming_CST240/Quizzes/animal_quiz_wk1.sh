#!/bin/bash

echo "Enter an animal name:"
read animal_name

echo ${animal_name:-$(ls -a)}


