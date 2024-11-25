#!/usr/bin/env bash

set -ex

cat > ${SRC_DIR}/pkgconfig.ini <<EOF
[binaries]
pkgconfig = '$BUILD_PREFIX/bin/pkg-config'
EOF

build_args=(
  "-Csetup-args=--warnlevel=0"
  "-Csetup-args=--cross-file=${SRC_DIR}/pkgconfig.ini"
  "-Csetup-args=-Dpython_version=${PREFIX}/bin/python3"
)
if [ -f ${BUILD_PREFIX}/meson_cross_file.txt ]; then
  build_args=("${build_args[@]}" "-Csetup-args=--cross-file=${BUILD_PREFIX}/meson_cross_file.txt")
fi

${PYTHON} -m build \
    "${build_args[@]}" \
    --outdir . \
    --no-isolation \
    --wheel \
    python/

${PYTHON} -m pip install *.whl --no-deps -vv
