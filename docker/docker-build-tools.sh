set -eux

uname -a

mkdir /build
cd /build

curl -SLO https://github.com/MTG/essentia-builds/build_scripts/build_tools.sh

./build_tools.sh && rm -r ./build_tools.sh

curl -SLO https://github.com/chincheta0815/essentia/archive/$ESSENTIA_3RDPARTY_VERSION.zip
unzip $ESSENTIA_3RDPARTY_VERSION.zip
cd essentia-*/

for idx in 1 2 3; do
    file=$(ls /essentia/patches/0${idx}_*.patch)
    patch -p0 < $file
done

#if [[ ${WITH_TENSORFLOW} ]] ; then
#    with_tensorflow=--with-tensorflow
#fi

with_tensorflow=

# Install dependencies to /usr/local; force --static flag to pickup private libraries for Qt
PKGCONFIG="/usr/bin/pkg-config --static" ./packaging/build_3rdparty_static_debian.sh --with-gaia ${with_tensorflow} 

cd /
rm -rf /build

