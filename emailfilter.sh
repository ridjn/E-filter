#!/bin/bash
BOLD='\e[1m'
 
 
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAENTA='\033[0;35m'
 
LIGHTRED='\033[0;91m'
LIGHTGREEN='\033[0;92m'
LIGHTCYAN='\033[0;96m'
 
 
BACKGREEN='\033[0;42m'
BACKBLUE='\033[0;44m'
 
 
NC='\033[0m'
 
 
header(){


printf "${LIGHTRED}██████╗ ██╗██████╗      ██╗███╗   ██╗    ███████╗    ███████╗██╗██╗  ████████╗███████╗██████╗ ${NC}\n" 
printf "${LIGHTRED}██╔══██╗██║██╔══██╗     ██║████╗  ██║    ██╔════╝    ██╔════╝██║██║  ╚══██╔══╝██╔════╝██╔══██╗${NC}\n" 
printf "${LIGHTRED}██████╔╝██║██║  ██║     ██║██╔██╗ ██║    █████╗█████╗█████╗  ██║██║     ██║   █████╗  ██████╔╝${NC}\n" 
printf "${LIGHTRED}██╔══██╗██║██║  ██║██   ██║██║╚██╗██║    ██╔══╝╚════╝██╔══╝  ██║██║     ██║   ██╔══╝  ██╔══██╗${NC}\n" 
printf "${LIGHTRED}██║  ██║██║██████╔╝╚█████╔╝██║ ╚████║    ███████╗    ██║     ██║███████╗██║   ███████╗██║  ██║${NC}\n" 
printf "${LIGHTRED}╚═╝  ╚═╝╚═╝╚═════╝  ╚════╝ ╚═╝  ╚═══╝    ╚══════╝    ╚═╝     ╚═╝╚══════╝╚═╝   ╚══════╝╚═╝  ╚═╝${NC}\n" 
                                                                                                                        
                           
}

clear
header
 
echo ""
echo "__________________________________________________________________________________"
echo ""
echo "Email Filter"
echo "Coded By : Ridjn"
echo "Date     : 11 Octobre 2019"
echo "__________________________________________________________________________________"
echo ""
 
echo "List of file on this directory : "
echo ""
 
ls
 
echo ""
echo "__________________________________________________________________________________"
 
echo ""
printf "[+] Email List : ${LIGHTCYAN}"
read emaillist
printf "${NC}"
 
printf "[+] Result will save in : ${LIGHTCYAN}"
read save
printf "${NC}"
 
printf "[+] Making directory : "
 
if [[ ! -d "$save" ]]; then
  mkdir $save
  echo -e "${GREEN}[OK]${NC}"
else
  echo -e "${RED}[ERR]${NC} | ${RED}File Already Exists${NC}"
fi
 
echo ""
 
counter=$(wc -l < $emaillist)
echo -e "${NC}[+] Total lines : [${LIGHTGREEN}$counter${NC}]"
echo "[+] Cleaning your email list , lowering the word in your list , and removing duplicates email , Please wait ..."
 

grep -Eiorh '([[:alnum:]_.-]+@[[:alnum:]_.-]+?\.[[:alpha:].]{2,6})' $emaillist | sort | uniq > temp_list && mv temp_list $emaillist

cat $emaillist | awk '{print tolower($0)}' | sort | uniq > temp_list && mv temp_list $emaillist

sort -u $emaillist | uniq > temp_list && mv temp_list $emaillist
 
counter=$(wc -l < $emaillist)
 
echo ""
echo "[+] Done ~"
echo ""
echo -e "[+] You have [${LIGHTGREEN}$counter${NC}] email"
echo ""
 
microsoft_family=( hotmail live outlook msn )
yahoo_family=( yahoo ymail btinternet bt rocketmail sky )
google_family=( gmail google googlemail )
aol_family=( aol )
 
otherpath="other_mail.txt"
cp $emaillist "$save/$otherpath"
 
thispath="microsoft_family.txt"
 
echo "[+] Catch microsoft family : "
echo "[+] I have list : "
for (( i = 0; i < ${#microsoft_family[@]}; i++ )); do
  echo "      [-] @${microsoft_family[$i]}.*"
done
echo ""
 
for (( i = 0; i < ${#microsoft_family[@]}; i++ )); do
  emailtogrep="@${microsoft_family[$i]}."
  printf "      [+] Catch $emailtogrep* : "
  cat $emaillist | grep "$emailtogrep" | sort | uniq >> "$save/$thispath"
  cat "$save/$otherpath" | grep -v "$emailtogrep" | sort | uniq > "$save/tmp_other" && mv "$save/tmp_other" "$save/$otherpath"
  counter=$(cat "$save/$thispath" | grep -c "$emailtogrep")
  if [[ $counter != 0 ]]; then
    printf "${GREEN}[OK]${NC} | ${BLUE}$counter${NC} catched\n"
  else
    printf "${RED}[NO]${NC} | There is no ${BLUE}${emailtogrep}*${NC} email\n"
  fi
done
 
counter=$(wc -l < "$save/$thispath")
echo ""
echo -e "[+] Finally you have [${LIGHTGREEN}$counter${NC}] Microsoft Family"
echo ""
 
thispath="yahoo_family.txt"
 
echo "[+] Catch yahoo family : "
echo "[+] I have list : "
for (( i = 0; i < ${#yahoo_family[@]}; i++ )); do
  echo "      [-] @${yahoo_family[$i]}.*"
done
echo ""
 
 
for (( i = 0; i < ${#yahoo_family[@]}; i++ )); do
  emailtogrep="@${yahoo_family[$i]}."
  printf "      [+] Catch $emailtogrep* : "
  cat $emaillist | grep "$emailtogrep" | sort | uniq >> "$save/$thispath"
  cat "$save/$otherpath" | grep -v "$emailtogrep" | sort | uniq > "$save/tmp_other" && mv "$save/tmp_other" "$save/$otherpath"
  counter=$(cat "$save/$thispath" | grep -c "$emailtogrep")
  if [[ $counter != 0 ]]; then
    printf "${GREEN}[OK]${NC} | ${BLUE}$counter${NC} catched\n"
  else
    printf "${RED}[NO]${NC} | There is no ${BLUE}${emailtogrep}*${NC} email\n"
  fi
done
 
 
counter=$(wc -l < "$save/$thispath")
echo ""
echo -e "[+] Finally you have [${LIGHTGREEN}$counter${NC}] Yahoo Family"
echo ""
 
thispath="google_family.txt"
 
 
echo "[+] Catch google family : "
echo "[+] I have list : "
for (( i = 0; i < ${#google_family[@]}; i++ )); do
  echo "      [-] @${google_family[$i]}.*"
done
echo ""
 
 
for (( i = 0; i < ${#google_family[@]}; i++ )); do
  emailtogrep="@${google_family[$i]}."
  printf "      [+] Catch $emailtogrep* : "
  cat $emaillist | grep "$emailtogrep" | sort | uniq >> "$save/$thispath"
  cat "$save/$otherpath" | grep -v "$emailtogrep" | sort | uniq > "$save/tmp_other" && mv "$save/tmp_other" "$save/$otherpath"
  counter=$(cat "$save/$thispath" | grep -c "$emailtogrep")
  if [[ $counter != 0 ]]; then
    printf "${GREEN}[OK]${NC} | ${BLUE}$counter${NC} catched\n"
  else
    printf "${RED}[NO]${NC} | There is no ${BLUE}${emailtogrep}*${NC} email\n"
  fi
done
 
 
counter=$(wc -l < "$save/$thispath")
echo ""
echo -e "[+] Finally you have [${LIGHTGREEN}$counter${NC}] Google Family"
echo ""
 
thispath="aol_family.txt"
 
# ---
 
echo "[+] Catch aol family : "
echo "[+] I have list : "
for (( i = 0; i < ${#aol_family[@]}; i++ )); do
  echo "      [-] @${aol_family[$i]}.*"
done
echo ""
 
for (( i = 0; i < ${#aol_family[@]}; i++ )); do
  emailtogrep="@${aol_family[$i]}."
  printf "      [+] Catch $emailtogrep* : "
  cat $emaillist | grep "$emailtogrep" | sort | uniq >> "$save/$thispath"
  cat "$save/$otherpath" | grep -v "$emailtogrep" | sort | uniq > "$save/tmp_other" && mv "$save/tmp_other" "$save/$otherpath"
  counter=$(cat "$save/$thispath" | grep -c "$emailtogrep")
  if [[ $counter != 0 ]]; then
    printf "${GREEN}[OK]${NC} | ${BLUE}$counter${NC} catched\n"
  else
    printf "${RED}[NO]${NC} | There is no ${BLUE}${emailtogrep}*${NC} email\n"
  fi
done
 
counter=$(wc -l < "$save/$thispath")
echo ""
echo -e "[+] Finally you have [${LIGHTGREEN}$counter${NC}] Aol Family"
echo ""
 
echo "[+] Other Mail"
 
counter=$(wc -l < "$save/$otherpath")
echo ""
echo -e "[+] Finally you have [${LIGHTGREEN}$counter${NC}] Other Mail"
echo ""
echo "[+] Done -"
echo ""