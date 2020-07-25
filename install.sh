#! /bin/bash

ROOT_UID=0
DEST_DIR=

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/plank/themes/"
else
  DEST_DIR="$HOME/.local/share/plank/themes/"
fi

show_question() {
  echo -e "\033[1;34m$@\033[0m"
}

show_error() {
  echo -e "\033[1;31m$@\033[0m"
}

show_about() {
  echo -e "\033[1;31m$@\033[0m"
}

end() {
  echo -e "Exiting..."
  exit 0
}

continue() {
  show_question "Do you want to continue? (y)es, (n)o : \n"
  read INPUT
  case $INPUT in
    [Yy]* ) ;;
    [Nn]* ) end;;
    * ) show_error "Sorry, try again."; continue;;
  esac
}

install() {
  # Show destination directory
  echo -e "\e[1mPlank-Theme\e[0m will be installed in: \e[92m'$DEST_DIR'\e[0m"
  if [ "$UID" -eq "$ROOT_UID" ]; then
    echo -e "It will be available to all users."
  else
    echo -e "If you want to make them available to all users, run this script as \e[31mroot\e[0m."
  fi
  continue
  echo -e "Installing ..."

  # Copying files
  cp -ur themes/* $DEST_DIR
  echo -e "Installation complete!"
}


main() {
  show_question "What you want to do: (i)nstall, (c)ancel : \n"
  read INPUT
  case $INPUT in
    [Ii]*) 
        install;;
    [Cc]*) 
        end;;
    *) show_error "\nSorry, try again."; main;;
  esac
}

main
