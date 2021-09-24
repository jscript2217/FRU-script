#!/bin/bash

for((;;))
do
    # IP입력
    echo -n -e "-------------------------------\nInsert BMC IP Address : "
    read IP
    if [ ${IP,,} = 'exit' ]; then
        break
    # IP 주소 판별
    elif [[  $IP =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
        break
    else
        echo "'$IP' is not ip address. please try again."
    fi
done

# Username & Password 입력
echo -n "Insert Username : "
read username

echo -n "Insert Password : "
stty -echo
read password
stty echo
echo -e \n
echo '-------------------------------'

ipmitool -H $IP -U $username -P $password fru
if [ $? != 0 ]; then # 서버 연결 접속안될때 나가기
exit
fi
# FRU ID 0 정보 가져오기
fru0=$(ipmitool -H $IP -U $username -P $password fru print 0)
CT0=$(echo "$fru0" | awk -F ':' '{if ($1~"Chassis Type") { print $2 }}' | tr -d ,'\12')
CPN0=$(echo "$fru0" | awk -F ':' '{if ($1~"Chassis Part Number") { print $2 }}' | tr -d ' ','\12')
CS0=$(echo "$fru0" | awk -F ':' '{if ($1~"Chassis Serial") { print $2 }}' | tr -d ' ','\12')
BMD0=$(echo "$fru0" | awk -F ':' '{if ($1~"Board Mfg Date") { print $2 }}' | tr -d '\12')
BM0=$(echo "$fru0" | awk -F ':' '{if ($1~"Board Mfg") { print $2 }}' | tr -d '\12')
BP0=$(echo "$fru0" | awk -F ':' '{if ($1~"Board Product") { print $2 }}' | tr -d ' ','\12')
BS0=$(echo "$fru0" | awk -F ':' '{if ($1~"Board Serial") { print $2 }}' | tr -d ' ','\12')
BPN0=$(echo "$fru0" | awk -F ':' '{if ($1~"Board Part Number") { print $2 }}' | tr -d ' ','\12')
BE0=$(echo "$fru0" | awk -F ':' '{if ($1~"Board Extra") { print $2 }}' | tr -d ' ','\12')
PM0=$(echo "$fru0" | awk -F ':' '{if ($1~"Product Manufacturer") { print $2 }}' | tr -d ' ','\12')
PN0=$(echo "$fru0" | awk -F ':' '{if ($1~"Product Name") { print $2 }}' | tr -d ' ','\12')
PPN0=$(echo "$fru0" | awk -F ':' '{if ($1~"Product Part Number") { print $2 }}' | tr -d ' ','\12')
PV0=$(echo "$fru0" | awk -F ':' '{if ($1~"Product Version") { print $2 }}' | tr -d ' ','\12')
PS0=$(echo "$fru0" | awk -F ':' '{if ($1~"Product Serial") { print $2 }}' | tr -d ' ','\12')
PAT0=$(echo "$fru0" | awk -F ':' '{if ($1~"Product Asset Tag") { print $2 }}' | tr -d ' ','\12')
# FRU ID 1 정보 가져오기
fru1=$(ipmitool -H $IP -U $username -P $password fru print 1)
CT1=$(echo "$fru1" | awk -F ':' '{if ($1~"Chassis Type") { print $2 }}' | tr -d ,'\12')
CPN1=$(echo "$fru1" | awk -F ':' '{if ($1~"Chassis Part Number") { print $2 }}' | tr -d ' ','\12')
CS1=$(echo "$fru1" | awk -F ':' '{if ($1~"Chassis Serial") { print $2 }}' | tr -d ' ','\12')
BMD1=$(echo "$fru1" | awk -F ':' '{if ($1~"Board Mfg Date") { print $2 }}' | tr -d '\12')
BM1=$(echo "$fru1" | awk -F ':' '{if ($1~"Board Mfg") { print $2 }}' | tr -d '\12')
BP1=$(echo "$fru1" | awk -F ':' '{if ($1~"Board Product") { print $2 }}' | tr -d ' ','\12')
BS1=$(echo "$fru1" | awk -F ':' '{if ($1~"Board Serial") { print $2 }}' | tr -d ' ','\12')
BPN1=$(echo "$fru1" | awk -F ':' '{if ($1~"Board Part Number") { print $2 }}' | tr -d ' ','\12')
BE1=$(echo "$fru1" | awk -F ':' '{if ($1~"Board Extra") { print $2 }}' | tr -d ' ','\12')
PM1=$(echo "$fru1" | awk -F ':' '{if ($1~"Product Manufacturer") { print $2 }}' | tr -d ' ','\12')
PN1=$(echo "$fru1" | awk -F ':' '{if ($1~"Product Name") { print $2 }}' | tr -d ' ','\12')
PPN1=$(echo "$fru1" | awk -F ':' '{if ($1~"Product Part Number") { print $2 }}' | tr -d ' ','\12')
PV1=$(echo "$fru1" | awk -F ':' '{if ($1~"Product Version") { print $2 }}' | tr -d ' ','\12')
PS1=$(echo "$fru1" | awk -F ':' '{if ($1~"Product Serial") { print $2 }}' | tr -d ' ','\12')
PAT1=$(echo "$fru1" | awk -F ':' '{if ($1~"Product Asset Tag") { print $2 }}' | tr -d ' ','\12')

# Chassis Part Number
ipmitool -H $IP -U $username -P $password fru edit 0 field c 0 "LKG000000000000$(echo $PN1 | awk -F '-' '{print $2}')" >>/dev/null 2>&1
# Chassis Serial 
ipmitool -H $IP -U $username -P $password fru edit 0 field c 1 "$PS" >>/dev/null 2>&1
# Board Mfg
ipmitool -H $IP -U $username -P $password fru edit 0 field b 0 "LTechKorea, Inc." >>/dev/null 2>&1
# Board Product
ipmitool -H $IP -U $username -P $password fru edit 0 field b 1 "B-LKG-$BP1" >>/dev/null 2>&1
# Board Part Number
ipmitool -H $IP -U $username -P $password fru edit 0 field b 3 "B000000000000$(echo $PN1 | awk -F '-' '{print $2}')" >>/dev/null 2>&1
# Board Extra
ipmitool -H $IP -U $username -P $password fru edit 0 field b 5 " " >>/dev/null 2>&1
# Product Manufacturer
ipmitool -H $IP -U $username -P $password fru edit 0 field p 0 "LTechKorea, Inc." >>/dev/null 2>&1
# Product Name
case $(echo $PN1 | awk -F '-' '{print $2}') in
    3C0)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG-2212-C" >>/dev/null 2>&1
        ;;
    3C1)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG-2212-C" >>/dev/null 2>&1
        ;;
    3C2)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG-2212-G" >>/dev/null 2>&1
        ;;
    G30)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG-2224-G" >>/dev/null 2>&1
        ;;
    340)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG-1204-C" >>/dev/null 2>&1
        ;;
    N20)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG-1210-C" >>/dev/null 2>&1
        ;;       
esac
# Product Part Number
ipmitool -H $IP -U $username -P $password fru edit 0 field p 2 "LKG000000000000$(echo $PN1 | awk -F '-' '{print $2}')" >>/dev/null 2>&1
# Product Asset Tag
ipmitool -H $IP -U $username -P $password fru edit 0 field p 5 " " >>/dev/null 2>&1

# FRU ID 1, Board Mfg
ipmitool -H $IP -U $username -P $password fru edit 1 field p 5 "LTechKorea, Inc." >>/dev/null 2>&1
# FRU ID 1, Board Serial
ipmitool -H $IP -U $username -P $password fru edit 1 field p 5 "$BS0" >>/dev/null 2>&1
# FRU ID 1, Product Serial
ipmitool -H $IP -U $username -P $password fru edit 1 field p 5 "$PS0" >>/dev/null 2>&1

echo '-------------------------------'
# 확인 출력
ipmitool -H $IP -U $username -P $password fru 