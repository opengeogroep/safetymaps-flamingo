#!/bin/sh
rm -rf css locales libs
cp -R ../safetymaps-viewer/public/js/safetymaps/modules/creator/assets ../safetymaps-flamingo/
cp -R ../safetymaps-viewer/public/css ../safetymaps-flamingo/
cp -R ../safetymaps-viewer/public/locales ../safetymaps-flamingo/
cp -R ../safetymaps-viewer/public/js/libs ../safetymaps-flamingo/

