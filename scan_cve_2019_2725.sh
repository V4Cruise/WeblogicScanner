#!/bin/bash
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
#Code by bacth0san >.<
while getopts "t:" OPTION; do
        case "${OPTION}" in
         t) target="${OPTARG}";;
        esac
done
if [[ "$target" > "0" ]]; then 
	echo "Checking for Weblogic CVE-2019-2725 in $target ..."
	curl https://$target:7001/_async/AsyncResponseService -k -s -m2 | grep "http://www.bea.com/async/AsyncResponseService"
	RESULT=$?
	if [ $RESULT -eq 0 ]; then
	echo -e "${RED} >>>> POSSIBLY VULNERABLE TO CVE-2019-2725: https://$target <<<<"${NC}
	echo "$i" >> vulns.txt
	else
	echo -e "${GREEN} Cleared: https://$target"${NC}
	fi
	
	curl http://$target:7001/_async/AsyncResponseService -s -m2 | grep "http://www.bea.com/async/AsyncResponseService"
	RESULT=$?
	if [ $RESULT -eq 0 ]; then
	echo -e "${RED} >>>> POSSIBLY VULNERABLE TO CVE-2019-2725: http://$target <<<<<"${NC}
	echo "$i" >> vulns.txt
	else
	echo -e "${GREEN} Cleared: http://$target"${NC}
	fi
	
else
	echo -e "${RED}USAGE: bash scan_cve_2019_2725.sh -t IP${NC}"
fi

