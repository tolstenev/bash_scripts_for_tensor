#!/bin/bash

FROM_DIR="/usr/local/bin/"
TO_DIR="/srv/data/"

top -b -n 1 >> top.tmp
grep -E "saby-*" top.tmp >> saby.tmp

cat saby.tmp | awk '{print $1}' >> pids.tmp
cat saby.tmp | awk '{print $12}' >> names.tmp

str_num=0

for pid in $(cat pids.tmp); do
    str_num=$((str_num+1))
    name=$(head -n$str_num names.tmp | tail -n1)

    kill $pid

    if ! [ -d $TO_DIR ]; then
      mkdir $TO_DIR
    fi
    touch $TO_DIR$name
    mv $FROM_DIR$name $TO_DIR$name

    sed -i "s/WorkingDirectory=\/opt\/misc/WorkingDirectory=\/srv\/data/" /etc/systemd/system/$name.service
    sed -i "s/ExecStart=\/opt\/misc/ExecStart=\/srv\/data/" /etc/systemd/system/$name.service
    systemctl daemon-reload
    systemctl start $name
done

rm top.tmp saby.tmp pids.tmp names.tmp
