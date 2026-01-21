#!/usr/bin/env bash

MEDIUMORCHID='\033[38;5;207m'
GREY='\033[38;5;240m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

echo ""
echo -e "${MEDIUMORCHID}==> Git Configuration Setup${NC}"
echo ""

# Check if .gitconfig already exists
if [ -f ~/.gitconfig ]; then
  echo -e "${GREEN}✓${NC} ~/.gitconfig already exists"
else
  # Copy template to .gitconfig
  if [ -f "$DOTFILES_DIR/.gitconfig.template" ]; then
    cp "$DOTFILES_DIR/.gitconfig.template" ~/.gitconfig
    echo -e "${GREEN}✓${NC} Created ~/.gitconfig from template"
  else
    echo -e "${MEDIUMORCHID}!${NC} Warning: .gitconfig.template not found, skipping"
  fi
fi

# Check if .gitconfig.local already exists
if [ -f ~/.gitconfig.local ]; then
  echo -e "${GREEN}✓${NC} ~/.gitconfig.local already exists"
  echo ""
  echo "Current configuration:"
  git config --global user.name
  git config --global user.email
  echo ""

  while true; do
    echo -ne "${MEDIUMORCHID}Do you want to update your Git user info?${GREY} (y/N) → ${NC}"
    read -p "" yn && yn="${yn:-n}"
      case $yn in
          [Yy]* ) break;;
          [Nn]* )
            echo ""
            echo -e "${GREEN}==> Git configuration complete${NC}"
            echo ""
            # Still offer gh CLI login
            while true; do
              echo -ne "${MEDIUMORCHID}Do you want to authenticate with GitHub CLI?${GREY} (y/N) → ${NC}"
              read -p "" yn2 && yn2="${yn2:-n}"
                case $yn2 in
                    [Yy]* ) gh auth login; break;;
                    [Nn]* ) break;;
                    * ) echo "Please answer yes or no.";;
                esac
            done
            exit 0;;
          * ) echo "Please answer yes or no.";;
      esac
  done
fi

# Prompt for user name
echo ""
while true; do
  echo -ne "${MEDIUMORCHID}Your git name${GREY} → ${NC}"
  read name
    case $name in
        "" ) echo "Your name can't be empty.";;
        * ) break;;
    esac
done

# Prompt for user email
while true; do
  echo -ne "${MEDIUMORCHID}Your git email${GREY} → ${NC}"
  read email
    case $email in
        "" ) echo "Your email can't be empty.";;
        * ) break;;
    esac
done

# Create or update .gitconfig.local
cat > ~/.gitconfig.local <<EOF
[user]
    name = $name
    email = $email
EOF

echo ""
echo -e "${GREEN}✓${NC} Created ~/.gitconfig.local with your information"
echo ""
echo -e "${GREEN}==> Git configuration complete${NC}"
echo ""

# GitHub CLI authentication
while true; do
  echo -ne "${MEDIUMORCHID}Do you want to authenticate with GitHub CLI?${GREY} (Y/n) → ${NC}"
  read -p "" yn && yn="${yn:-y}"
    case $yn in
        [Yy]* ) gh auth login; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
