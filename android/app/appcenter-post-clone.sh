#!/usr/bin/env bash
#Place this script in project/android/app/cd ..# fail if any command fails
set -e
# debug log
set -x
cd ..
git clone -b stable https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH
flutter doctor
echo "Installed flutter to `pwd`/flutter"
cd ..
pwd
flutter build apk --release --flavor googlePlay
mkdir -p android/app/build/outputs/apk/
mv build/app/outputs/flutter-apk/app-googleplay-release.apk $_
flutter build appbundle --release --flavor googlePlay
mkdir -p android/app/build/outputs/bundle/
mv build/app/outputs/bundle/googleplayRelease/app-googleplay-release.aab $_