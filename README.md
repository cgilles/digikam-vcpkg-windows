Scripts to install compiled Qt Framework with MSVC under Windows
================================================================

Authors : Gilles Caulier <caulier dot gilles at gmail dot com>

* Requirements:
---------------

- VirtualBox 7.x + guest-host extension pack        https://www.virtualbox.org/wiki/Downloads
- Windows 10 22H2 or later                          https://www.microsoft.com/en-us/software-download/windows10
- git 2.42 or later                                 https://git-scm.com/download/win
- Visual Studio 2019                                https://learn.microsoft.com/en-us/visualstudio/releases/2019/history

* Build:
--------

To start Qt compilation use these scripts:

    1) ./01-windows-install-vcpkg.bat

    2) ./02-windows-install-qt6.bat

    3) ./03-windows-installkf6.bat

NOTE: due to long paths problem while compiling under Windows and MSVC, VCPKG must be installed in a shortest dir as C:/vcpkg
