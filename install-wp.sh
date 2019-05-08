#!/usr/bin/env bash
function bot {
  echo -e "${blue}${bold}(｡◕‿◕｡)${normal}  $1"
}



# ============================================
# = Ask some questions to make the fun going =
# ============================================
echo "Which kind of WordPress ? classic or multisite"
read type
if [ $type = "multisite" ]
then
echo "Would you prefer it on subdomain ? yes/no"
read subdomain
fi
echo "Now, I need database informations:"
echo "Host:"
read dbhost
echo "Database name:"
read dbname
echo "Database Username:"
read dbusername
echo "Database Password:"
read dbpassword
echo "Database Prefix:"
read dbprefix
echo "Which language? leave empty for English. Example for french: fr_FR"
read lang
echo "What is the future URL of your website?"
read url
echo "please enter the admin email:"
read email
echo "please enter the admin username:"
read wpusername
echo "please enter the admin password:"
read wppassword
echo "any path or something need to run wp-cli? example: lando"
read wppath
echo "delete this script when installation finished ? yes/no"
read delete

#  =======================
#  = The show must go on =
#  =======================

if [ -z "$lang" ]
then
$wppath wp core download
else
$wppath wp core download --locale=$lang
fi

$wppath wp core config --dbhost="$dbhost" --dbname="$dbname" --dbuser="$dbusername" --dbprefix="$dbprefix" --dbpass="$dbpassword"

if [ $type = "classic" ]
then
$wppath wp core install --url="$url" --title="Website" --admin_user="$wpusername" --admin_password="$wppassword" --admin_email="$email"
fi

if [ $type = "multisite" ] && [ $subdomain = "yes" ]
then
$wppath wp core multisite-install --url="$url" --title="Multisite" --admin_user="$wpusername" --admin_password="$wppassword" --admin_email="$email" --subdomains
fi
if [ $type = "multisite" ] && [ $subdomain = "no" ]
then
$wppath wp core multisite-install --url="$url" --title="Multisite" --admin_user="$wpusername" --admin_password="$wppassword" --admin_email="$email"
fi

$wppath wp option update timezone_string Europe/Paris

$wppath wp rewrite structure --hard '/%postname%'
$wppath wp rewrite flush --hard

bot "Ready to democratize publishing!"

if [ $delete = "yes" ]
then
  rm install-wp.sh
fi
