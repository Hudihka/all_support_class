#!/bin/bash

brew install bazel;

XCODE_VERSION=$(/usr/bin/xcodebuild -version);
echo "$XCODE_VERSION"

BAZEL_VERSION=$(bazel --version);
echo "$BAZEL_VERSION"

USER_NAME=$(id -un);
echo "$USER_NAME";

BAZEL_PATH=$(which bazel);
echo "$BAZEL_PATH";

rm -rf $HOME/telegram-configuration;
rm -rf $HOME/telegram-bazel-cache;
sudo rm -rf /private/var/tmp/_bazel_$USER_NAME;
rm -rf ./build-input

mkdir -p $HOME/telegram-configuration;
mkdir -p $HOME/telegram-bazel-cache;

cp -R build-system/example-configuration/* $HOME/telegram-configuration/;

python3 build-system/Make/Make.py --verbose \
    --cacheDir="$HOME/telegram-bazel-cache" \
    --bazel="$BAZEL_PATH" \
    --overrideBazelVersion \
    --overrideXcodeVersion \
    generateProject \
    --disableProvisioningProfiles \
    --configurationPath "build-system/appstore-configuration.json" \
    --codesigningInformationPath "build-system/fake-codesigning"
    # --disableExtensions \
    # --disableProvisioningProfiles
