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

git clone https://github.com/Microsoft/vcpkg.git %VCPKG_DIR%

%VCPKG_DIR%\bootstrap-vcpkg.bat

cd %VCPKG_DIR%

REM For elapsed time mesurement

call %ORIG_WD%/common.cmd :TerminateScript
