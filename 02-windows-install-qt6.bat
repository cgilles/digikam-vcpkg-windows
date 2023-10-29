@ECHO OFF

REM ################################################################################
REM #
REM # Script to configure project based on CMake for Windows.
REM #
REM # Copyright (c) 2013-2023, Gilles Caulier, <caulier dot gilles at gmail dot com>
REM #
REM # Redistribution and use is allowed according to the terms of the BSD license.
REM # For details see the accompanying COPYING-CMAKE-SCRIPTS file.
REM #
REM ################################################################################

REM load configuration
call config.cmd

REM For elapsed time mesurement
call %ORIG_WD%/common.cmd :StartScript

%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install openssl
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install pthreads
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install gettext
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install icu
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install libpng
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install tiff
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install libmysql
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install libjpeg-turbo
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install jasper
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install libde265
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install libjxl
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install aom
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install avif
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install libheif
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install freeglut
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install brotli
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install zlib
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install bzip2
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install qt

%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install opencv
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install boost
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install lcms
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install eigen3
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install expat
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install libxml2
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install libxslt
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install exiv2
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install libical
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install fftw3
%VCPKG_DIR%/vcpkg %VCPKG_COMMON_OPTIONS% install openexr

REM For elapsed time mesurement

call %ORIG_WD%/common.cmd :TerminateScript
