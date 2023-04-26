#!/bin/sh

rm ip.txt
rm ip_with_not_found.txt
rm ip_clean.txt

IP_REGEX_IPV4="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"

clear

if [[ -n $1 ]]; then
  for item in $(cat $1);do
    host -t A $item > ip.txt
    grep -E $IP_REGEX_IPV4 ip.txt > ip_with_not_found.txt
    grep -E -v "not found" ip_with_not_found.txt > ip_clean.txt
    awk '{printf "%s\t%s\n", $1, $4}' ip_clean.txt
#    host -t AAAA $item

  done

fi

