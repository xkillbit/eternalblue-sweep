#!/bin/sh
for each in $(cat internal-targets.list);
	do /root/toolz/masscan/bin/masscan --rate 1000 -e eth1 -p445 -oG outfile --range $each;
	done;

cat outfile |cut -d ' ' -f2 | grep -vi m | grep -vi p >> listening-smb-hosts.txt;
echo ">>cat listening-smb-hosts.txt"
cat listening-smb-hosts.txt

nmap --script smb-vuln-ms17-010 -oA vuln2eternal-hosts -iL listening-smb-hosts.txt
echo "Number of hosts likely vulnerable to eternalblue: "
cat vuln2eternal-hosts | grep -i vulnerable | wc -l
cat vuln2eternal-hosts
