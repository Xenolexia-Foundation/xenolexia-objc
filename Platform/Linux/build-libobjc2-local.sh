#!/usr/bin/env bash
# Build libobjc2 into xenolexia-objc/local (no sudo). After this, set
#   export LOCAL_OBJC2_PREFIX="$(cd "$(dirname "$0")/../.." && pwd)/local"
# and build with the GNUmakefile (it adds -I and -L for this prefix).

set -e
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PREFIX="${LOCAL_OBJC2_PREFIX:-$ROOT/local}"
SRC="${1:-/tmp/libobjc2}"

echo "libobjc2 source: $SRC"
echo "Install prefix:  $PREFIX"

if [ ! -d "$SRC" ]; then
  echo "Cloning libobjc2 into $SRC ..."
  git clone --depth 1 --recurse-submodules https://github.com/gnustep/libobjc2.git "$SRC"
fi

mkdir -p "$SRC/Build"
cd "$SRC/Build"
cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DCMAKE_INSTALL_PREFIX="$PREFIX" \
  -DGNUSTEP_INSTALL_TYPE=NONE \
  -DTESTS=OFF
make -j$(nproc 2>/dev/null || echo 4)
make install

echo "Done. libobjc2 installed to $PREFIX"
echo "To build Xenolexia with this runtime, run:"
echo "  export LOCAL_OBJC2_PREFIX=\"$PREFIX\""
echo "  cd $ROOT/Platform/Linux"
echo "  . /usr/share/GNUstep/Makefiles/GNUstep.sh"
echo "  make -f GNUmakefile"
