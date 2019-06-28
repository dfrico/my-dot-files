#!/bin/bash
output="/etc/sudo_lecture"

if [ $# -gt 0 ]; then
    output="$@"
fi

echo -e "\e[1m     \e[32m\"Bee\" careful    \e[34m__" > $output
echo -e "       \e[32mwith sudo!    \e[34m// \\" >> $output
echo -e "                     \\\\\\\\_/ \e[33m//" >> $output
echo -e "   \e[35m''-.._.-''-.._.. \e[33m-(||)(')" >> $output
echo -e "                     '''\e[0m" >> $output
