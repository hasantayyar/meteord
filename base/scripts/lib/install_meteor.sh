set -e
echo '>> INSTALL METEOR'

echo '> Installing bsdtar as alternative to tar'
apt-get install -y --no-install-recommends bsdtar
export tar='bsdtar'

echo '> Getting meteor install script'
touch install_meteor.sh
echo '' > install_meteor.sh
curl -sL https://install.meteor.com| sed s/--progress-bar/-sL/g  > install_meteor.sh

echo '> Modify meteor install script (tar -> bsdtar)'
echo 'alias tar=bsdtar' | cat - install_meteor.sh > temp && mv temp install_meteor.sh
echo 'tar --version' | cat - install_meteor.sh > temp && mv temp install_meteor.sh

echo '> Run install script'
/bin/sh install_meteor.sh

echo '> Remove install script'
rm install_meteor.sh
