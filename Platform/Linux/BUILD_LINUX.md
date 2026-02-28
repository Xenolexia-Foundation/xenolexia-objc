# Building Xenolexia ObjC on Linux (GNUStep)

## Prerequisites

- **GNUStep** (make, base, gui) – you have this.
- **SmallStep** – built and installed into `xenolexia-objc/include` and `xenolexia-objc/lib` (run `./scripts/install-smallstep.sh` from xenolexia-objc root; requires SmallStep source, e.g. `../SmallStep`).
- **libobjc2** (Objective-C 2.0 runtime with blocks) – required because the app uses Objective-C blocks and the system GNUStep headers expect `objc/blocks_runtime.h` when compiling with clang `-fblocks`.

## Option A: Install libobjc2 system-wide (recommended if you have sudo)

```bash
sudo apt install -y cmake clang
cd /tmp
git clone --depth 1 --recurse-submodules https://github.com/gnustep/libobjc2.git
cd libobjc2 && mkdir Build && cd Build
cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DCMAKE_INSTALL_PREFIX=/usr/local \
  -DTESTS=OFF
make -j$(nproc)
sudo make install
```

Then build Xenolexia:

```bash
cd /path/to/xenolexia-objc/Platform/Linux
. /usr/share/GNUstep/Makefiles/GNUstep.sh
make -f GNUmakefile clean
make -f GNUmakefile
```

The executable will be in `Xenolexia.app/`.

## Option B: Build libobjc2 to a local prefix (no sudo)

Install cmake and clang if needed (`apt install cmake clang`), then from **xenolexia-objc** root:

```bash
./Platform/Linux/build-libobjc2-local.sh
```

This installs libobjc2 into `xenolexia-objc/local`. The GNUmakefile automatically uses `local/include` and `local/lib` when present. Then build:

```bash
cd Platform/Linux
. /usr/share/GNUstep/Makefiles/GNUstep.sh
make -f GNUmakefile clean
make -f GNUmakefile
```

## Quick build (once libobjc2 and SmallStep are ready)

```bash
cd xenolexia-objc/Platform/Linux
. /usr/share/GNUstep/Makefiles/GNUstep.sh
make -f GNUmakefile
```

Run the app:

```bash
./Xenolexia.app/Xenolexia
```
