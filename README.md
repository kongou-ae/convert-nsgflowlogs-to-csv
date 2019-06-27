# convert-nsgflowlogs-to-csv

The script to convert NSG flow logs to csv.

## Usage

```
.\convert-nsgflowlogs-to-csv.ps1 -urlWithSasToken <URL with SAS token of NSG flow logs>
```

## Result

This script genarates a csv file in $HOME\flowlogs-yyyyMMdd-hhmmss.csv

```
utcDate,localDate,srcIP,srcPort,dstIP,dstPort,protocol,direction,action
06/27/2019 13:59:59,06/27/2019 22:59:59,10.0.6.5,39646,20.38.105.36,443,TCP,Outbound,Deny
06/27/2019 13:59:58,06/27/2019 22:59:58,168.63.129.16,52389,10.0.6.5,443,TCP,Inbound,Deny
06/27/2019 14:01:09,06/27/2019 23:01:09,10.0.6.5,39926,20.38.105.36,443,TCP,Outbound,Deny
06/27/2019 14:00:58,06/27/2019 23:00:58,168.63.129.16,53143,10.0.6.5,443,TCP,Inbound,Deny
06/27/2019 14:02:03,06/27/2019 23:02:03,10.0.6.5,40218,20.38.105.36,443,TCP,Outbound,Deny
06/27/2019 14:01:58,06/27/2019 23:01:58,168.63.129.16,53886,10.0.6.5,443,TCP,Inbound,Deny
```
