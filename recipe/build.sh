#!/usr/bin/env bash

set -ex

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" != "1" ]]; then
  "${PYTHON}" -m pip install . -v --no-deps
else
  cat >> pkgconfig.ini <<EOF
[binaries]
pkgconfig = '$BUILD_PREFIX/bin/pkg-config'
EOF
  meson setup _build ${MESON_ARGS} --cross-file pkgconfig.ini
  meson compile -C _build
  meson install -C _build --no-rebuild
fi
