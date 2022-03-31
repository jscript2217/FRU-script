#!/bin/bash

# This code was inspired by the open source C code of the APT progress bar
# http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/trusty/apt/trusty/view/head:/apt-pkg/install-progress.cc#L233

#
# Usage:
# Source this script
# setup_scroll_area
# draw_progress_bar 10
# draw_progress_bar 90
# destroy_scroll_area
# 프로세스바 https://answer-id.com/ko/74489640 참고
CODE_SAVE_CURSOR="\033[s"
CODE_RESTORE_CURSOR="\033[u"
CODE_CURSOR_IN_SCROLL_AREA="\033[1A"
COLOR_FG="\e[30m"
COLOR_BG="\e[42m"
RESTORE_FG="\e[39m"
RESTORE_BG="\e[49m"

function setup_scroll_area() {
    lines=$(tput lines)
    let lines=$lines-1
    # Scroll down a bit to avoid visual glitch when the screen area shrinks by one row
    echo -en "\n"

    # Save cursor
    echo -en "$CODE_SAVE_CURSOR"
    # Set scroll region (this will place the cursor in the top left)
    echo -en "\033[0;${lines}r"

    # Restore cursor but ensure its inside the scrolling area
    echo -en "$CODE_RESTORE_CURSOR"
    echo -en "$CODE_CURSOR_IN_SCROLL_AREA"

    # Start empty progress bar
    draw_progress_bar 0
}

function destroy_scroll_area() {
    lines=$(tput lines)
    # Save cursor
    echo -en "$CODE_SAVE_CURSOR"
    # Set scroll region (this will place the cursor in the top left)
    echo -en "\033[0;${lines}r"

    # Restore cursor but ensure its inside the scrolling area
    echo -en "$CODE_RESTORE_CURSOR"
    echo -en "$CODE_CURSOR_IN_SCROLL_AREA"

    # We are done so clear the scroll bar
    clear_progress_bar

    # Scroll down a bit to avoid visual glitch when the screen area grows by one row
    echo -en "\n\n"
}

function draw_progress_bar() {
    percentage=$1
    lines=$(tput lines)
    let lines=$lines
    # Save cursor
    echo -en "$CODE_SAVE_CURSOR"

    # Move cursor position to last row
    echo -en "\033[${lines};0f"

    # Clear progress bar
    tput el

    # Draw progress bar
    print_bar_text $percentage

    # Restore cursor position
    echo -en "$CODE_RESTORE_CURSOR"
}

function clear_progress_bar() {
    lines=$(tput lines)
    let lines=$lines
    # Save cursor
    echo -en "$CODE_SAVE_CURSOR"

    # Move cursor position to last row
    echo -en "\033[${lines};0f"

    # clear progress bar
    tput el

    # Restore cursor position
    echo -en "$CODE_RESTORE_CURSOR"
}

function print_bar_text() {
    local percentage=$1

    # Prepare progress bar
    let remainder=100-$percentage
    progress_bar=$(echo -ne "$percentage%" "["; echo -en "${COLOR_FG}${COLOR_BG}"; printf_new "#" $percentage; echo -en "${RESTORE_FG}${RESTORE_BG}"; printf_new "." $remainder; echo -ne "]");

    # Print progress bar
    if [ $1 -gt 99 ]
    then
        echo -ne "${progress_bar}"
    else
        echo -ne "${progress_bar}"
    fi
}

printf_new() {
    str=$1
    num=$2
    v=$(printf "%-${num}s" "$str")
    echo -ne "${v// /$str}"
}

# ------------------------------------------------------------------------------------------
NowDate=`date`
log_file="Change_history_log.txt"
version=" LTechKorea FRU Editor v1.0.2 (2022. 03. 30.)"

echo -n '

██╗  ████████╗███████╗ ██████╗██╗  ██╗██╗  ██╗ ██████╗ ██████╗ ███████╗ █████╗        ██╗███╗   ██╗ ██████╗       
██║  ╚══██╔══╝██╔════╝██╔════╝██║  ██║██║ ██╔╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗       ██║████╗  ██║██╔════╝       
██║     ██║   █████╗  ██║     ███████║█████╔╝ ██║   ██║██████╔╝█████╗  ███████║       ██║██╔██╗ ██║██║            
██║     ██║   ██╔══╝  ██║     ██╔══██║██╔═██╗ ██║   ██║██╔══██╗██╔══╝  ██╔══██║       ██║██║╚██╗██║██║            
███████╗██║   ███████╗╚██████╗██║  ██║██║  ██╗╚██████╔╝██║  ██║███████╗██║  ██║▄█╗    ██║██║ ╚████║╚██████╗       
╚══════╝╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝    ╚═╝╚═╝  ╚═══╝ ╚═════╝       
                                                                                                                  
███████╗██████╗ ██╗   ██╗    ███████╗██████╗ ██╗████████╗ ██████╗ ██████╗     ██╗   ██╗ ██╗    ██████╗    ██████╗ 
██╔════╝██╔══██╗██║   ██║    ██╔════╝██╔══██╗██║╚══██╔══╝██╔═══██╗██╔══██╗    ██║   ██║███║   ██╔═████╗   ╚════██╗
█████╗  ██████╔╝██║   ██║    █████╗  ██║  ██║██║   ██║   ██║   ██║██████╔╝    ██║   ██║╚██║   ██║██╔██║    █████╔╝
██╔══╝  ██╔══██╗██║   ██║    ██╔══╝  ██║  ██║██║   ██║   ██║   ██║██╔══██╗    ╚██╗ ██╔╝ ██║   ████╔╝██║   ██╔═══╝ 
██║     ██║  ██║╚██████╔╝    ███████╗██████╔╝██║   ██║   ╚██████╔╝██║  ██║     ╚████╔╝  ██║██╗╚██████╔╝██╗███████╗
╚═╝     ╚═╝  ╚═╝ ╚═════╝     ╚══════╝╚═════╝ ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝      ╚═══╝   ╚═╝╚═╝ ╚═════╝ ╚═╝╚══════╝
                                                                                                                   
'
# http://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=LTechKorea%2C%20Inc%0AFRU%20Editor%20v1.0.2
echo "$version"


for((;;))
do
    # IP입력
    echo -n -e "--------------------------------------------\nInsert BMC IP Address : "
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
# 시리얼 넘버 수동입력
echo -n -e "Do you want to manually enter the serial?(y/n) : "
read result
for((;;))
do
    if [ $result = "y" ]; then
        echo -n -e "Insert Board Serial number : "
        read BS
        echo -n -e "Insert Product Serial number : "
        read PS 
        echo -n -e "Are you sure?(y/n) : "
        read anser
        if [ $anser = "y" ]; then
            break
        fi
    fi
    if [ $result = "n" ]; then
        break
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
echo '--------------------------------------------'
# 서버 연결 접속안될때 오류 내용 표시 후 나가기
output=`ipmitool -H $IP -U $username -P $password fru` >>/dev/null 2>&1
if [ $? != 0 ]; then
    echo "$output"
    exit
fi
echo "================Before FRU Information================"
ipmitool -H $IP -U $username -P $password fru
setup_scroll_area

# 변경 전 로그 저장
echo "-------------$NowDate-------------" >> $log_file
echo "$version" >> $log_file
echo -e "\nConnection information.\n IP : $IP\n UserName : $username\n Password : $password\n" >> $log_file
echo "================Before FRU Information================" >> $log_file
ipmitool -H $IP -U $username -P $password fru >> $log_file

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
draw_progress_bar 10
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
draw_progress_bar 20

# Chassis Part Number
ipmitool -H $IP -U $username -P $password fru edit 0 field c 0 "LKG000000000000$(echo $PN1 | awk -F '-' '{print $2}')" >>/dev/null 2>&1 
if [ $result = "y" ]; then
    # FRU ID 0, Chassis Serial
    ipmitool -H $IP -U $username -P $password fru edit 0 field c 1 "$PS" >>/dev/null 2>&1
    # FRU ID 0, Board Serial
    ipmitool -H $IP -U $username -P $password fru edit 0 field b 2 "$BS" >>/dev/null 2>&1
    # FRU ID 0, Product Serial
    ipmitool -H $IP -U $username -P $password fru edit 0 field p 4 "$PS" >>/dev/null 2>&1
else
    ipmitool -H $IP -U $username -P $password fru edit 0 field c 1 "$PS0" >>/dev/null 2>&1
fi 
# Board Mfg
ipmitool -H $IP -U $username -P $password fru edit 0 field b 0 "LTechKorea, Inc." >>/dev/null 2>&1
# Board Product
ipmitool -H $IP -U $username -P $password fru edit 0 field b 1 "B-LKG-$BP1" >>/dev/null 2>&1
draw_progress_bar 40
# Board Part Number
ipmitool -H $IP -U $username -P $password fru edit 0 field b 3 "B000000000000$(echo $PN1 | awk -F '-' '{print $2}')" >>/dev/null 2>&1
# Board Extra
ipmitool -H $IP -U $username -P $password fru edit 0 field b 5 " " >>/dev/null 2>&1
# Product Manufacturer
ipmitool -H $IP -U $username -P $password fru edit 0 field p 0 "LTechKorea, Inc." >>/dev/null 2>&1
draw_progress_bar 60

# Product Name
case $(echo $PN1 | cut -c -8) in # $(echo $PN1 | awk -F '-' '{print $2}')
    R281-3C0)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG-2212-C" >>/dev/null 2>&1
        ;;
    R281-3C1)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG-2212-C" >>/dev/null 2>&1
        ;;
    R281-3C2)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG-2212-C" >>/dev/null 2>&1
        ;;
    R281-G30)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG-2224-C" >>/dev/null 2>&1
        ;;
    R181-340)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG-1204-C" >>/dev/null 2>&1
        ;;
    R181-N20)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG-1210-C" >>/dev/null 2>&1
        ;;
    R282-3C1)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG2312" >>/dev/null 2>&1
        ;;
    R182-NA0)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG1310" >>/dev/null 2>&1
        ;;
    R282-Z90)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG2312E" >>/dev/null 2>&1
        ;;
    R182-Z91)
        ipmitool -H $IP -U $username -P $password fru edit 0 field p 1 "LKG1310E" >>/dev/null 2>&1
        ;;
esac
draw_progress_bar 80
# Product Part Number
ipmitool -H $IP -U $username -P $password fru edit 0 field p 2 "LKG000000000000$(echo $PN1 | awk -F '-' '{print $2}')" >>/dev/null 2>&1
# Product Asset Tag
ipmitool -H $IP -U $username -P $password fru edit 0 field p 5 " " >>/dev/null 2>&1
# FRU ID 1, Board Mfg
ipmitool -H $IP -U $username -P $password fru edit 1 field b 0 "LTechKorea, Inc." >>/dev/null 2>&1
draw_progress_bar 90
if [ $result = "y" ]; then
    # FRU ID 1, Chassis Serial
    ipmitool -H $IP -U $username -P $password fru edit 1 field c 1 "$PS" >>/dev/null 2>&1
    # FRU ID 1, Board Serial
    ipmitool -H $IP -U $username -P $password fru edit 1 field b 2 "$BS" >>/dev/null 2>&1
    # FRU ID 1, Product Serial
    ipmitool -H $IP -U $username -P $password fru edit 1 field p 4 "$PS" >>/dev/null 2>&1
else
    # FRU ID 1, Board Serial
    ipmitool -H $IP -U $username -P $password fru edit 1 field b 2 "$BS0" >>/dev/null 2>&1
    # FRU ID 1, Product Serial
    ipmitool -H $IP -U $username -P $password fru edit 1 field p 4 "$PS0" >>/dev/null 2>&1
fi
destroy_scroll_area
# 확인 출력 및 로그 저장
echo "================After FRU Information================"
echo "================After FRU Information================">> $log_file
ipmitool -H $IP -U $username -P $password fru
ipmitool -H $IP -U $username -P $password fru >> $log_file
echo "Complete."
echo "Save the log. [`pwd`/$log_file]"