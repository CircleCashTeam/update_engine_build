# Update Engine Build
Build delta_generator with cmake and link statically.

## Prepare
### Debian
```sh
sudo apt install clang llvm lld libc++-dev cmake ninja-build
```
### Archlinux
```sh
sudo pacman -S clang llvm lld libc++ cmake ninja
```

## Build
### Host
```
./build_host.sh
```
### NDK
```
# If you not specific ARCH, it will build all(x86_64,i686,aarch64,armv7a) arch
# The executable binary output will be out/$arch/delta_generator
```
#### Build
```sh
ANDROID_NDK_HOME=/path/to/ndk ARCH=x86_64 ./build_android.sh
```
### Args
- `PREFER_STATIC_LINKING`    
    `ON`: This will try to build delta_generator statically
- `HAVE_GLIBC`|`HAVE_BIONIC`|`HAVE_MUSL`    
    `1`: Specific one of them with your libc type