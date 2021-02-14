#!/usr/bin/env bash

MEDIUMORCHID='\033[38;5;207m'
GREY='\033[38;5;240m'
NC='\033[0m' # No Color

while true; do
  echo -ne "– ${MEDIUMORCHID}Your git name${GREY} → ${NC}"
  read name
    case $name in
        "" ) echo "Your name can't be empty.";;
        * ) git config --global user.name "$name"; break;;
    esac
done

while true; do
  echo -ne "– ${MEDIUMORCHID}Your git email${GREY} → ${NC}"
  read email
    case $email in
        "" ) echo "Your email can't be empty.";;
        * ) git config --global user.email "$email"; break;;
    esac
done

# gh cli login
gh auth login
