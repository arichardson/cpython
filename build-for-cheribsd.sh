#!/bin/sh -e
CHERI_ROOT="${HOME}/cheri"
CHERISDK="${CHERI_ROOT}/output/sdk256/bin"
CHERIBSD_SYSROOT="${CHERI_ROOT}/output/sdk256/sysroot"
INSTALL_DIR=${CHERI_ROOT}/output/rootfs256

export PATH=${CHERISDK}:${CHERILDDIR}:$PATH
export CC=${CHERISDK}/clang
export CXX=${CHERISDK}/clang++
COMMON_FLAGS="-pipe --sysroot=${CHERIBSD_SYSROOT} -B${CHERISDK} -target cheri-unknown-freebsd -mabi=sandbox -msoft-float -mxgot -O0 -G0 -static -integrated-as"
COMPILE_FLAGS="${COMMON_FLAGS} -Werror=implicit-function-declaration -Werror=format -Werror=undefined-internal -Werror=incompatible-pointer-types"

./configure OPT="" MACHDEP=freebsd "CFLAGS=${COMPILE_FLAGS}" "CXXFLAGS=${COMPILE_FLAGS}" "CPPFLAGS=${COMMON_FLAGS}" "LDFLAGS=${COMMON_FLAGS} -fuse-ld=lld -pthread -Wl,-melf64btsmip_cheri_fbsd" --host=cheri-unknown-freebsd --target=cheri-unknown-freebsd --build=x86_64-unknown-freebsd --disable-shared  --disable-ipv6 ac_cv_prog_AR=ar
gmake -j8
#gmake install DESTDIR=${INSTALL_DIR}

