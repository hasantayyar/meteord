set -e
set -x

COPIED_APP_PATH=/copied-app
mkdir -p ~/tmp/bundle-dir
BUNDLE_DIR=~/tmp/bundle-dir

# sometimes, directly copied folder cause some wierd issues of MacOs file system
# this fixes that
echo "=> Copying the app"
cp -R /app $COPIED_APP_PATH
cd $COPIED_APP_PATH

echo "=> Executing NPM install --production"
meteor npm install --production 

echo "=> Executing NPM rebuild"
meteor npm rebuild 

echo "=> Executing Meteor Build..."
meteor build \
  --allow-superuser \
  --directory $BUNDLE_DIR \
  --server=http://localhost:3000 --server-only

echo "=> Printing Meteor Node information..."
echo "  => platform"
meteor node -p process.platform
echo "  => arch"
meteor node -p process.arch
echo "  => versions"
meteor node -p process.versions

echo "=> Printing System Node information..."
echo "  => platform"
node -p process.platform
echo "  => arch"
node -p process.arch
echo "  => versions"
node -p process.versions

echo "=> Executing NPM install & rebuild within Bundle"
cd $BUNDLE_DIR/bundle/programs/server/
npm i --production

echo "=> Moving bundle"
mv $BUNDLE_DIR/bundle /built_app

echo "=> Cleaning up"
# cleanup
echo " => COPIED_APP_PATH"
rm -rf $COPIED_APP_PATH
echo " => BUNDLE_DIR"
rm -rf $BUNDLE_DIR
echo " => .meteor"
rm -rf ~/.meteor
rm /usr/local/bin/meteor
