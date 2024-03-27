#!/bin/bash

WHITE='\033[0;47m'
BOLD_WHITE='\033[1;47m'
BLACK='\033[0;30m'
BOLD_BLACK='\033[1;30m'
BLUE='\033[0;34m'
BOLD_BLUE='\033[1;34m'
RED='\033[0;31m'
BOLD_RED='\033[1;31m'
GREEN='\033[0;32m'
BOLD_GREEN='\33[1;32m'
YELLOW='\033[0;33m'
BOLD_YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
BOLD_PURPLE='\033[1;35m'
NC='\033[0m' # No Color

### effects
#  echo -e "\033[0;33mSample text"
#  echo -e "\033[1;37mBold text"
#  echo -e "\033[2;33mLow intensity text"
#  echo -e "\033[4;33mUnderline text"
#  echo -e "\033[5;33mBlinking text"
#  echo -e "\033[8;33mInvisible text"
#  echo -e "\033[9;33mStrikethrough text${NC}"

#echo -e "${BLUE}blue ${RED}red${NC} ${YELLOW}yellow "
printf "${BLUE}blue ${RED}red ${GREEN}green ${WHITE}white ${BLACK}black ${YELLOW}yellow ${PURPLE}purple ${NC}\n"
printf "${BOLD_BLUE}bold_blue ${BOLD_RED}bold_red ${BOLD_GREEN}bold_green ${BOLD_WHITE}bold_white ${NC} ${BOLD_BLACK}bold_black ${BOLD_YELLOW}bold_yellow ${BOLD_PURPLE}bold_purple ${NC}\n"
