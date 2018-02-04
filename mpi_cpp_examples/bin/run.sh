#!/bin/sh
read -p "Define the number of processors: " np 

mpirun -np $((np)) hello
