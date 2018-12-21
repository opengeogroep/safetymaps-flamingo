#!/bin/sh
rm -rf css locales libs module shared
cp -R ../safetymaps-viewer/public/js/safetymaps/modules/creator/assets ../safetymaps-flamingo/
cp -R ../safetymaps-viewer/public/css ../safetymaps-flamingo/
cp -R ../safetymaps-viewer/public/locales ../safetymaps-flamingo/
cp -R ../safetymaps-viewer/public/js/libs ../safetymaps-flamingo/
cp -R ../safetymaps-viewer/public/js/safetymaps/modules/creator/ ../safetymaps-flamingo/
cp -R ../safetymaps-viewer/public/js/safetymaps/shared ../safetymaps-flamingo/
mv creator module

VERSION=`git describe --tags`
DATE=`git log -1 --pretty=%ad --date=local`
COMMIT=`git log -1 --pretty=%ad --date=short`

rm -r config
touch config
echo "VERSION: $VERSION" >> config
echo "DATE: $DATE" >> config
echo "COMMIT: $COMMIT" >> config

zip -r -l -q safetymaps-flamingo-`date '+%Y-%m-%d_%H%M%S'`.zip *
