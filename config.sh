#!/bin/bash

# SPDX-FileCopyrightText: 2013-2023 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#

########################################################################

VCPKG_DIR="C:/vcpkg"

INSTALL_DIR="E:/dk"

# Absolute path where are downloaded all tarballs to compile.
DOWNLOAD_DIR="E:/d"

# Absolute path where are compiled all tarballs
BUILDING_DIR="E:/b"

VCPKG_COMMON_OPTIONS=--disable-metrics --triplet x64-windows --x-buildtrees-root=$BUILD_DIR --x-install-root=$INSTALL_DIR --downloads-root=$DOWNLOAD_DIR --vcpkg-root=$VCPKG_DIR

#-------------------------------------------------------------------------------------------

# URL to git repository to checkout digiKam source code
# git protocol version which require a developer account with ssh keys.
DK_GITURL="git@invent.kde.org:graphics/digikam.git"
# https protocol version which give annonyous access.
#DK_GITURL="https://invent.kde.org/graphics/digikam.git"

# digiKam tarball information.
DK_URL="http://download.kde.org/stable/digikam"

# Location to build source code.
DK_BUILDTEMP=$BUILDING_DIR/dktemp

# KDE Plasma version.
# See official release here: https://download.kde.org/stable/plasma/
DK_KP_VERSION="5.27.8"

# KDE Application version.
# See official release here: https://download.kde.org/stable/release-service/
DK_KA_VERSION="23.08.1"

# KDE KF5 frameworks version.
# See official release here: https://download.kde.org/stable/frameworks/
DK_KDE_VERSION="5.110"

# Qt version to use in bundle and provided by MXE.
DK_QTVERSION="5"

# digiKam tag version from git. Official tarball do not include extra shared libraries.
# The list of tags can be listed with this url: https://invent.kde.org/graphics/digikam/-/tags
# If you want to package current implementation from git, use "master" as tag.
#DK_VERSION=v7.6.0
DK_VERSION=master
#DK_VERSION=qt5-maintenance

# Installer sub version to differentiates newer updates of the installer itself, even if the underlying application hasn’t changed.
#DK_SUBVER="-01"

# Installer will include or not digiKam debug symbols
DK_DEBUG=0

# Sign bundles with GPG. Passphrase must be hosted in ~/.gnupg/dkorg-gpg-pwd.txt
DK_SIGN=0

# Upload automatically bundle to files.kde.org (pre-release only).
DK_UPLOAD=1
DK_UPLOADURL="digikam@tinami.kde.org"
DK_UPLOADDIR="/srv/archives/files/digikam/"
