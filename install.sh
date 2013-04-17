#!/bin/bash
for l in $(cat .gitmodules | grep -v '^\[' | tr -d "\t" | tr -d " " | cut -d = -f 2); 
do 
    if [ ${l:0:3} == 'bun' ]  
    then 
        path=$l; 
    elif [ ${l:0:3} == 'git' ]
    then git submodule add ${l} ${path} 
    fi
done
