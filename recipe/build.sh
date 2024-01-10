#!/bin/sh

curl -L https://github.com/openturns/otsvm/commit/cb542a4fc.patch | patch -p1
mkdir build && cd build

cmake \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DPython_FIND_STRATEGY=LOCATION \
  -DPython_ROOT_DIR=${PREFIX} \
  ..

make install -j${CPU_COUNT}
DYLD_FALLBACK_LIBRARY_PATH=${PREFIX}/lib ctest -R pyinstallcheck --output-on-failure -j${CPU_COUNT}

