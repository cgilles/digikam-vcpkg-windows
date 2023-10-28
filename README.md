Scripts to install compiled digiKam dependencies with MSVC under Windows
========================================================================

Authors : Gilles Caulier <caulier dot gilles at gmail dot com>

* Requirements:
---------------

    - VirtualBox 7.x + guest extension pack             https://www.virtualbox.org/wiki/Downloads
        + Storage: VDI static size of 150 Gb
        + Memory : 12 Gb
        + CPU    : 10

    - Windows 10 22H2 or later                          https://www.microsoft.com/en-us/software-download/windows10
    - Git 2.42 or later                                 https://git-scm.com/download/win
    - Visual Studio 2019                                https://learn.microsoft.com/en-us/visualstudio/releases/2019/history
        + Desktop development with C++
            + C++ core desktop features
            + MSVC v142 - VS2019 C++ x64/x86
            + Windows 10 SDK >= 10.0.20348.0 or         (avaialble in Individual Components section)
              Windows 11 SDK >= 10.0.22621.0
            + Just in time debugger                     (optional)
            + C++ Cmake tools for windows
            + C++ ATL for latest v142 build tools
            + C++/CLI support for v142

    - NSIS 3.x                                          https://nsis-dev.github.io/

* Build:
--------

    To start Qt compilation use these scripts in a git-bash console:

    1) ./01-windows-install-vcpkg.bat

    NOTE: due to long path problems while compiling under Windows and MSVC, VCPKG working directories must adjusted as shortest as possible:
        VCPKG_DIR=C:/vcpkg/
        INSTALL_DIR=C:/dk/
        DOWNLOAD_DIR=C:/d/
        BUILD_DIR=C:/b/

        See the config.cmd for details. dDirectories will be created automatically.

    2) ./02-windows-install-qt6.bat

    3) ./03-windows-installkf6.bat

