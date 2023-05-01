#!/bin/bash

# Version represent in A.B.C.D
# FA - A in function
# VA - A from input version

remove_relevant_dirs() {
    if [ $# -ge 3 ]; then
        PATH_WHERE=$2
        FA="[$3]"
        if [ $1 = "recursive" ]; then
            FB="[0-9]*"
            FC="[0-9]*"
            FD="[0-9]*"
        elif [ $1 = "only" ]; then
            FB="[-]*"
            FC="[-]*"
            FD="[-]*"
        fi
        
        if [ $# -ge 4 ]; then
            FB="[$4]"
            if [ $# -ge 5 ]; then
                FC="[$5]"
                if [ $# -eq 6 ]; then
                    FD="[$6]"
                fi
            fi
        fi
        
        REGEX_DIRNAME="^\.\/[A-Za-z]*[_]{1}"$FA"\."$FB"\.?"$FC"\.?"$FD"$"
        # echo $REGEX_DIRNAME
        cd "$PATH_WHERE" && find . -type d >> $OLDPWD/dirs.txt
        grep -E "$REGEX_DIRNAME" dirs.txt >> relevant.txt
        # rm -rf actually
        for each in $(cat relevant.txt); do
            cp -r $each "${PATH_WHERE}_Trash/$each"
        done
        rm relevant.txt dirs.txt
    fi
}

rm -rf _Trash
mkdir _Trash

if [ $# -eq 2 ]; then
    PATH_WHERE="$1"
    VERSION_STOP=$2
    
    PRE_IFS=$IFS
    IFS='.'
    read -ra arr <<< "$VERSION_STOP"
    IFS=$PRE_IFS
    
    NUM_ABCD=${#arr[*]}
    VA=${arr[0]}
    VB=-1
    VC=-1
    VD=-1
    if [ $NUM_ABCD -gt 1 ];then
        VB=${arr[1]};
        if [ $NUM_ABCD -gt 2 ];then
            VC=${arr[2]};
            if [ $NUM_ABCD -gt 3 ];then
                VD=${arr[3]};
            fi
        fi
    fi
    
    for (( A=0; A <= $VA; A++ )); do
        if [ $A -lt $VA ]; then
            remove_relevant_dirs \
            "recursive" "$PATH_WHERE" "$A"
            
        elif [ $A -le $VA ]; then
            for (( B=0; B <= $VB; B++ )); do
                if [ $B -lt $VB ]; then
                    remove_relevant_dirs \
                    "recursive" "$PATH_WHERE" "$A" "$B"

                elif [ $B -eq $VB ]; then
                    if [ $VC -ne -1 ]; then
                        remove_relevant_dirs \
                        "only" "$PATH_WHERE" "$A" "$B"
                    fi
                    for (( C=0; C <= $VC; C++ )); do
                        if [ $C -lt $VC ]; then
                            remove_relevant_dirs \
                            "recursive" "$PATH_WHERE" "$A" "$B" "$C"
                        elif [ $C -eq $VC ]; then
                            if [ $VD -ne -1 ]; then
                                remove_relevant_dirs \
                                "only" "$PATH_WHERE" "$A" "$B" "$C"
                            fi
                            for (( D=0; D <= $VD; D++ )); do
                                if [ $D -lt $VD ]; then
                                    remove_relevant_dirs \
                                    "recursive" "$PATH_WHERE" \
                                    "$A" "$B" "$C" "$D"
                                fi
                            done
                        fi
                    done
                fi
            done
        fi
    done
fi
