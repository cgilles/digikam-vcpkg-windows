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

%VCPKG_DIR%/vcpkg --disable-metrics install qtbase
%VCPKG_DIR%/vcpkg --disable-metrics install qtimageformats
%VCPKG_DIR%/vcpkg --disable-metrics install qtmultimedia
%VCPKG_DIR%/vcpkg --disable-metrics install qtnetworkauth
%VCPKG_DIR%/vcpkg --disable-metrics install qtscxml
%VCPKG_DIR%/vcpkg --disable-metrics install qtsvg
%VCPKG_DIR%/vcpkg --disable-metrics install qttranslations
%VCPKG_DIR%/vcpkg --disable-metrics install qttools
%VCPKG_DIR%/vcpkg --disable-metrics install qtwebengine

REM For elapsed time mesurement

call %ORIG_WD%/common.cmd :TerminateScript
