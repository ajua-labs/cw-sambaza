#! /bin/bash


METRICS_SERVER="metrics.msurvey.co"
METRICS_PORT=2003
METRICS_TIME=$(date +%s)
METRICS_NAME="VPN_STATUS.FOR_HOST"
LOG_FILE="/home/ubuntu/scripts/vpn.log"


declare -A VPN_NAMES

# While decalring ports, have them space separated
declare -A VPN_PORTS

# Holds vpn name set in ipsec file
declare -A VPN_IPSEC_NAME


VPN_NAMES["SAFARICOM_LNM"]=10.22.1.26
VPN_PORTS["SAFARICOM_LNM"]="22"
VPN_IPSEC_NAMES["SAFARICOM_LNM"]="net-to-net"


# Log VPN Restart
function log_vpn_raise() {

  echo -e "$(date  +'%F %T')\t${1}" >> ${LOG_FILE}   
}

# Quick hack to self healing
function raise_vpn() {
  
  log_vpn_raise "Stopping VPN ${1}" &
  sudo ipsec auto --down ${1}
  sudo ipsec auto --up ${1}
  log_vpn_raise "Started VPN ${1}" &
}

for i in ${!VPN_NAMES[@]}
do

  for j in ${VPN_PORTS[$i]}
  do
    SUCCESS=1
  
    nc -zv -w 5 ${VPN_NAMES[$i]} ${j} &>/dev/null
    
   if [ $? -gt 0 ]
   then
      SUCCESS=0
      raise_vpn ${VPN_IPSEC_NAMES[$i]} &
   fi
 
    echo "${METRICS_NAME}.${i}.ON_PORT.${j} ${SUCCESS} ${METRICS_TIME}" | nc ${METRICS_SERVER} ${METRICS_PORT}
    
  done

done 


