#!/usr/bin/bash
#By: Suman Kumar ~BHUTUU
#Date: 22-01-2022
#Project: program to arrange data in tree form!
CWD=$(pwd)
OS=$(uname -o)
#<<<===========REQUIREMENTS============>>>#
if [ "$OS" == *'Android'* ]; then
  INS() {
    apt install $1 -y
  }
else
  INS() {
    sudo apt install $1 -y
  }
fi
connection() {
  ping -c 1 google.com >/dev/null 2>&1
  if [ "$?" != '0' ]; then
    printf "CHECK YOUR INTERNET CONNECTION..!\n"; exit 1
  fi
}
if ! hash tree >/dev/null 2>&1; then
  connection || continue
  INS tree 2>/dev/null | printf "FETCHING METADATA....\n"
fi
if ! hash tree >/dev/null 2>&1; then
  printf "Sorry but your system is not eligible to use this program.... :(\n"
  exit 1
fi
if [ -d ~/.treeBHUTUU ]; then
  while true; do
    printf "Recent data found! what you want to do? [remove/show]: "; read choice
    if [ "$choice" == 'remove' ]; then
      rm -rf ~/.treeBHUTUU > /dev/null 2>&1
      mkdir ~/.treeBHUTUU 2>/dev/null
      break
    elif [ "$choice" == 'show' ]; then
      cd ~/.treeBHUTUU 2>/dev/null
      printf "Your tree data:\n\n\n" 
      tree -d *
      printf "\033[1A"
      for i in $(seq 10); do
        printf "     "
      done
      echo
      exit 0
      break
    else
      printf "invalid option!\n"
    fi
  done
fi
#<<<=====READ AND WRITE MASTER COMMAND=====>>>#
RCLR(){
  least=31
  last=37
  RANGE=$(($last - $least + 1))
  OUT=$RANDOM
  let "OUT %= $RANGE"
  OUT=$(($OUT+$least))
  SC="\033[1;${OUT}m"
  R0="\033[0;00m"
}
WRT() {
  RCLR
  if [ "$2" == 'n' ]; then
    printf "${SC}${1}${R0}\n"
  elif [ "$2" == 'r' ]; then
    printf "${SC}${1}${R0}"; read "$3"
  elif [ -z "$2" ]; then
    printf "${SC}${1}${R0}"
  else
    printf "${SC}syntax error at ${1} ${2} ${3} ...${R0}\n"
  fi
}
numCheck() {
  expr ${1} + 1 >/dev/null 2>&1
}
mkSubBranch() {
  while true; do
    WRT "Enter number of subBranches you want here: " r subNum
    numCheck $subNum
    if [ $? == '0' ]; then
      break
    fi
  done
  for l in $(seq $subNum); do
    WRT "Enter name for branch ${l}: " r subBranchName
    mkdir $subBranchName 2>/dev/null
  done
}
mkBranch() {
  while true; do
    WRT "Enter number of branches you want here: " r num
    numCheck $num
    if [ $? == '0' ]; then
      break
    fi
  done
  for i in $(seq $num); do
    WRT "Enter name for branch ${i}: " r branchName
    mkdir $branchName 2>/dev/null
  done
}
#<<<===========PROGRAM============>>>#
WRT "Enter name of ROOT node: " r ROOTnode
mkdir -p ~/.treeBHUTUU/$ROOTnode 2>/dev/null
cd ~/.treeBHUTUU/$ROOTnode 2>/dev/null
mkBranch
while true; do
  WRT "list of branches:" n
  for m in $(ls); do
    WRT "$m "
  done
  while true; do
    WRT "\nEnter Branch in which you want to make subBranch: " r bName
    if [ -d "$bName" ]; then
      cd $bName 2>/dev/null
      mkSubBranch
      break
    elif [[ "$bName" == 'exit' || "$bName" == 'quit' || "$bName" == 'finish' || "$bName" == 'done' ]]; then
      cd ~/.treeBHUTUU 2>/dev/null
      WRT "Your tree data:\n\n" n
      tree -d $ROOTnode
      WRT "\033[1A"
      for i in $(seq 10); do
        WRT "     "
      done
      WRT "" n
      exit 0; break; break
    elif [ "$bName" == 'back' ]; then
      LWD=$(pwd)
      if [ "$LWD" == ~/.treeBHUTUU/$ROOTnode ]; then
        WRT "you are already at root level!" n
      else
        cd ..
        break
      fi
    else
      WRT "invalid branch name! if you want to go back rum : back" n
    fi
  done
done
