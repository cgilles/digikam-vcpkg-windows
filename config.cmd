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

REM --- Qt build Settings ---------------

set ORIG_WD=%CD%

set VCPKG_DIR=C:/vcpkg/

REM Windows minimum target version to use for backward compatibility.
REM Possible values:
REM    10  => Windows 10
REM    6.3 => Windows 8.1
REM    6.2 => Windows 8.0
REM    6.1 => Windows 7
REM    6.0 => Windows Vista
REM    5.1 => Windows XP

set WIN_TARGET=6.1
