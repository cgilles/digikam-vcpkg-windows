#!/bin/bash

mkdir build.vcpkg
cd build.vcpkg

cmake .. -DCMAKE_TOOLCHAIN_FILE=/c/vcpkg/scripts/buildsystems/vcpkg.cmake \
                           -DVCPKG_TARGET_TRIPLET=x64-windows \
                           -DCMAKE_BUILD_TYPE=RelWithDebInfo \
                           -DCMAKE_COLOR_MAKEFILE=ON \
                           -DCMAKE_INSTALL_PREFIX=/e/dk/x64-windows \
                           -DINSTALL_ROOT=/e/dk/x64-windows \
                           -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
