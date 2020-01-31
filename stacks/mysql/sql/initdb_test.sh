#!/bin/sh

echo "CREATE DATABASE IF NOT EXISTS \`daishibank_test\` ;" | "${mysql[@]}"
echo "GRANT ALL ON \`daishibank_test\`.* TO 'daishibank'@'%' ;" | "${mysql[@]}"
echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"