#!/bin/bash

if [ $1 ]
    then
        nasm -f elf64 -o $1.o $1.asm
        #ld $1.o -o $1 (linking via 'ld' is trash for C library lol)
        gcc -m64 -no-pie -o $1 $1.o
        rm $1.o
        ./$1
    else
        echo "Please provide input filename"
fi