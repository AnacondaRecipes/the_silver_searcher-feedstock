#!/usr/bin/env bash

if [[ $(uname) == MINGW* ]]; then
  if [[ ${ARCH} == 32 ]]; then
    HOST_BUILD="--host=i686-w64-mingw32 --build=i686-w64-mingw32"
  else
    HOST_BUILD="--host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32"
  fi
  PREFIX="${PREFIX}"/Library/mingw-w64
  export PKG_CONFIG_PATH="${PREFIX}"/lib/pkgconfig
else
  export HOST_BUILD="--host=${HOST}"
fi

CPPFLAGS="$CPPFLAGS -I$PREFIX/include"
LDFLAGS="$LDFLAGS -L$PREFIX/lib"

./autogen.sh
./configure --prefix="${PREFIX}" ${HOST_BUILD}
make -j${CPU_COUNT} ${VERBOSE_AT}
make install
