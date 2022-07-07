#!/bin/bash
set -e -x

WITH_TENSORFLOW="false"

# Location of the dependencies in essentia-builds docker images
# ...is already set in the docker images
#PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
#PKG_CONFIG_PATH=/io/packaging/debian_3rdparty/lib/pkgconfig

mkdir /build
mkdir -p /io/releases

cd /build

# Check out a particular commit for building dependencies
curl -SLO https://github.com/MTG/essentia/archive/$ESSENTIA_3RDPARTY_VERSION.zip
unzip $ESSENTIA_3RDPARTY_VERSION.zip
cd essentia-*/

if [[ "$WITH_TENSORFLOW" == "true" ]]; then
    $(which python) waf configure --no-msse --with-static-examples --with-gaia --with-tensorflow --build-static --static-dependencies --pkg-config-path="${PKG_CONFIG_PATH}"
else
    $(which python) waf configure --no-msse --with-static-examples --with-gaia --build-static --static-dependencies --pkg-config-path="${PKG_CONFIG_PATH}"
fi

$(which python) waf
$(which python) waf install

cp /usr/local/bin/essentia_streaming_extractor* /io/releases
cp -r /io/essentia/analysis-models /io/releases

cd -
