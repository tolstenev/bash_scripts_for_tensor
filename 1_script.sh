#!/bin/sh

rm *.tmp
rm first.txt third.txt

IP_REGEX_IPV4="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"

#clear

if [[ -n $1 ]]; then
  for item in $(cat $1); do
    host -t A $item > host.tmp
    grep -E "not found" host.tmp >> not_resolved.tmp
    if [[ $? -ne 1 ]]; then
      echo $item >> first.txt
    fi

    grep -E $IP_REGEX_IPV4 host.tmp > ip_with_not_found.tmp
    grep -E -v "not found" ip_with_not_found.tmp > clean.tmp
    awk '{printf "%s\n", $1}' clean.tmp >> names.tmp
    awk '{printf "%s\n", $4}' clean.tmp >> ip.tmp
  done

  str_num=0
  for ipaddr in $(cat ip.tmp); do
    str_num=$((str_num+1))

    ping $ipaddr -c 1 -W 1 > ping.tmp
    grep -E ", 0.0% packet loss" ping.tmp > ping_good.tmp
    if [[ $? -eq 0 ]]; then
      name=$(head -n$str_num names.tmp | tail -n1)
      echo $name', '$ipaddr >> third.txt
    fi

  done
fi
