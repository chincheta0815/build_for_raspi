--- ./travis/build_wheels.sh	2022-06-28 15:10:53.000000000 +0200
+++ ./travis/build_wheels.sh	2022-06-28 15:21:09.000000000 +0200
@@ -25,12 +25,16 @@
 
 cd /io
 
+if [[ $(uname -m) == "aarch64" ]]; then
+    NO_MSSE="--no-msse"
+fi
+
 if [[ $WITH_TENSORFLOW ]]; then
     PROJECT_NAME='essentia-tensorflow'
-    "${PYBIN}/python" waf configure --with-gaia --with-tensorflow --build-static --static-dependencies --pkg-config-path="${PKG_CONFIG_PATH}"
+    "${PYBIN}/python" waf configure --with-gaia --with-tensorflow --build-static --static-dependencies ${NO_MSSE} --pkg-config-path="${PKG_CONFIG_PATH}"
 else
     PROJECT_NAME='essentia'
-    "${PYBIN}/python" waf configure --with-gaia --build-static --static-dependencies --pkg-config-path="${PKG_CONFIG_PATH}"
+    "${PYBIN}/python" waf configure --with-gaia --build-static --static-dependencies ${NO_MSSE} --pkg-config-path="${PKG_CONFIG_PATH}"
 fi
 
 "${PYBIN}/python" waf
