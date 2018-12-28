#!/usr/bin/env bash


function bot {
  echo -e "${blue}${bold}(｡◕‿◕｡)${normal}  $1"
}

#  ==============================
#  = The show is about to begin =
#  ==============================

# Welcome !
bot "${blue}${bold}Bonjour ! Je suis le bot!${normal}"
echo -e "         Je vais installer WordPress pour vous! bon café!  ${cyan}$2${normal}"

bot "Je télécharge WordPress pour $i: ${cyan}$1${normal}"
wp core download --locale=fr_FR

bot "Je crée le fichier de config WordPress de $i: ${cyan}$1${normal}"
wp core config --dbname="oceanwp50" --dbuser="oceanwp50" --dbprefix="oceanwp50_" --dbpass="4qhMe49ZDndd"

#bot "Je paramètre Wordpress :"
#wp core install --url="https://oceanwp50.eglises.xyz" --title="Mutualisation OceanWP 5.0" --admin_user="sebastienserre" --admin_password="1303Sarah$" --admin_email="sebastien.serre@5p2p.fr"

bot "et un multisite, c'est parti!"
wp core multisite-install --url="https://oceanwp50.eglises.xyz" --title="Mutualisation OceanWP 5.0" --admin_user="sebastienserre" --admin_password="1303Sarah$" --admin_email="sebastien.serre@5p2p.fr" --subdomains

bot "J'install le thème sir!"
wp theme install oceanwp --activate

bot "J'install les extensions de base sir!"
wp plugin install wp-seopress really-simple-ssl sf-adminbar-tools wordpress-mu-domain-mapping --activate


bot "je vous passe sur le bon fuseau horaire"
wp option update timezone_string Europe/Paris

bot "je vous crée le .htaccess"
touch .htaccess
echo "
## Created automatically by WP-CLI
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]

# add a trailing slash to /wp-admin
RewriteRule ^wp-admin$ wp-admin/ [R=301,L]

RewriteCond %{REQUEST_FILENAME} -f [OR]
RewriteCond %{REQUEST_FILENAME} -d
RewriteRule ^ - [L]
RewriteRule ^(wp-(content|admin|includes).*) $1 [L]
RewriteRule ^(.*\.php)$ $1 [L]
RewriteRule . index.php [L]" >> .htaccess

wp rewrite flush
wp rewrite structure --hard '/%postname%'

#rm wp.sh
cd ../

bot "La fameuse installation en 5 minutes !"

bot "Amusez-vous bien avec WordPress!"
