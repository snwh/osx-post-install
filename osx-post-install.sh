#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Authors:
#   Sam Hewitt <hewittsamuel@gmail.com>
#
# Description:
#   A post-installation bash script for OS X
#
# Legal Preamble:
#
# This script is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; version 3.
#
# This script is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>

# tab width
tabs 4
clear

#----- FUNCTIONS -----#

dir="$(dirname "$0")"

. $dir/functions/config
. $dir/functions/dock
. $dir/functions/finder
. $dir/functions/install
. $dir/functions/misc
. $dir/functions/screenshots
. $dir/functions/terminal

#----- COLOURED MESSAGE FUNCTIONS -----#

show_info() {
echo -e "\033[1;33m$@\033[0m" 
}

show_success() {
echo -e "\033[1;32m$@\033[0m"
}

show_question() {
echo -e "\033[1;34m$@\033[0m"
}

show_error() {
echo -e "\033[1;31m$@\033[m" 1>&2
}

bold() {
echo -e "\033[1m$@\033[0m"
}

#----- MAIN FUNCTIONS -----#

# Main
function main {
bold '#----------------------------------#'
bold '#     OS X Post-Install Script     #'
bold '#----------------------------------#'
echo ''
show_question 'What would you like to do? '
echo ''
echo '1. Install command-line applications & utilities?'
echo '2. Configure application & system settings?'
echo 'q. Quit?'
echo ''
show_question 'Enter your choice :' && read REPLY
case $REPLY in
    1) echo "" && install;; # Install Third-Party Applications
    2) echo "" && config;; # Configure system
    [Qq]* ) echo '' && quit;; # Quit
    * ) clear && show_error '\aNot an option, try again.' && main;;
esac
}

# Quit
function quit {
read -p "Are you sure you want to quit? (Y)es, (N)o " REPLY
case $REPLY in
    [Yy]* ) exit 99;;
    [Nn]* ) clear && main;;
    * ) clear && show_error 'Sorry, try again.' && quit;;
esac
}

#----- RUN MAIN FUNCTION -----#
main

#END OF SCRIPT