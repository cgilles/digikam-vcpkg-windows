#!/bin/bash

# Script to build extra libraries using VCPKG.
#
# SPDX-FileCopyrightText: 2015-2023 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# SPDX-License-Identifier: BSD-3-Clause
#

# Halt and catch errors
set -eE
trap 'PREVIOUS_COMMAND=$THIS_COMMAND; THIS_COMMAND=$BASH_COMMAND' DEBUG
trap 'echo "FAILED COMMAND: $PREVIOUS_COMMAND"' ERR

#################################################################################################
# Manage script traces to log file

mkdir -p ./logs
exec > >(tee ./logs/build-extralibs.full.log) 2>&1

#################################################################################################

echo "02-build-extralibs.sh : build extra libraries."
echo "----------------------------------------------"

#################################################################################################
# Pre-processing checks

. ./common.sh
. ./config.sh
StartScript
ChecksCPUCores
RegisterRemoteServers

ORIG_WD="`pwd`"

export PATH=$PATH:/c/bison:/c/icoutils/bin:$INSTALL_DIR/$VCPKG_TRIPLET/tools/gperf:$INSTALL_DIR/$VCPKG_TRIPLET/tools/python3:$INSTALL_DIR/$VCPKG_TRIPLET/bin
echo "PATH=$PATH"

#################################################################################################

if [ ! -d $BUILDING_DIR/dk_cmake ] ; then
    mkdir -p $BUILDING_DIR/dk_cmake
fi

cd $BUILDING_DIR/dk_cmake

rm -rf $BUILDING_DIR/dk_cmake/* || true

cmake $ORIG_WD/3rdparty \
                           -DCMAKE_TOOLCHAIN_FILE=$VCPKG_DIR/scripts/buildsystems/vcpkg.cmake \
                           -DVCPKG_TARGET_TRIPLET=$VCPKG_TRIPLET \
                           -DCMAKE_BUILD_TYPE=RelWithDebInfo \
                           -DCMAKE_COLOR_MAKEFILE=ON \
                           -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/$VCPKG_TRIPLET \
                           -DINSTALL_ROOT=$INSTALL_DIR/$VCPKG_TRIPLET \
                           -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
                           -DEXTERNALS_DOWNLOAD_DIR=$DOWNLOAD_DIR \
                           -DKA_VERSION=$DK_KA_VERSION \
                           -DKP_VERSION=$DK_KP_VERSION \
                           -DKDE_VERSION=$DK_KDE_VERSION

# NOTE: The order to compile each component here is very important.

# core KDE frameworks dependencies
cmake --build . --parallel --config RelWithDebInfo --target ext_extra-cmake-modules
cmake --build . --parallel --config RelWithDebInfo --target ext_kconfig
cmake --build . --parallel --config RelWithDebInfo --target ext_breeze-icons
cmake --build . --parallel --config RelWithDebInfo --target ext_kcoreaddons
cmake --build . --parallel --config RelWithDebInfo --target ext_kwindowsystem
cmake --build . --parallel --config RelWithDebInfo --target ext_solid
cmake --build . --parallel --config RelWithDebInfo --target ext_threadweaver
cmake --build . --parallel --config RelWithDebInfo --target ext_karchive
cmake --build . --parallel --config RelWithDebInfo --target ext_kdbusaddons
cmake --build . --parallel --config RelWithDebInfo --target ext_ki18n
cmake --build . --parallel --config RelWithDebInfo --target ext_kcrash
cmake --build . --parallel --config RelWithDebInfo --target ext_kcodecs
#cmake --build . --parallel --config RelWithDebInfo --target ext_kauth              Linux only
cmake --build . --parallel --config RelWithDebInfo --target ext_kguiaddons
cmake --build . --parallel --config RelWithDebInfo --target ext_kwidgetsaddons
cmake --build . --parallel --config RelWithDebInfo --target ext_kitemviews
cmake --build . --parallel --config RelWithDebInfo --target ext_kcompletion

if [[ $DK_QTVERSION == 6 ]] ; then

    cmake --build . --parallel --config RelWithDebInfo --target ext_kcolorscheme

fi

cmake --build . --parallel --config RelWithDebInfo --target ext_kconfigwidgets
cmake --build . --parallel --config RelWithDebInfo --target ext_kiconthemes
cmake --build . --parallel --config RelWithDebInfo --target ext_kservice
#cmake --build . --parallel --config RelWithDebInfo --target ext_kglobalaccel       Linux only
cmake --build . --parallel --config RelWithDebInfo --target ext_kxmlgui
cmake --build . --parallel --config RelWithDebInfo --target ext_kbookmarks
cmake --build . --parallel --config RelWithDebInfo --target ext_kimageformats

# Extra support for digiKam

# Desktop integration support
cmake --build . --parallel --config RelWithDebInfo --target ext_knotifications
cmake --build . --parallel --config RelWithDebInfo --target ext_kjobwidgets
cmake --build . --parallel --config RelWithDebInfo --target ext_kio
cmake --build . --parallel --config RelWithDebInfo --target ext_knotifyconfig

# libksane support
cmake --build . --parallel --config RelWithDebInfo --target ext_sonnet
cmake --build . --parallel --config RelWithDebInfo --target ext_ktextwidgets

#if [[ $DK_QTVERSION == 6 ]] ; then

#    cmake --build . --parallel --config RelWithDebInfo --target ext_qca            Linux only
#    cmake --build . --parallel --config RelWithDebInfo --target ext_kwallet        Linux only
#    cmake --build . --parallel --config RelWithDebInfo --target ext_ksanecore      Linux only

#fi

#cmake --build . --parallel --config RelWithDebInfo --target ext_libksane           Linux only

# Geolocation support
cmake --build . --parallel --config RelWithDebInfo --target ext_marble

# Calendar support
cmake --build . --parallel --config RelWithDebInfo --target ext_kcalendarcore

# Platform Input Context Qt plugin
#cmake --build . --parallel --config RelWithDebInfo --target ext_fcitx-qt           Linux only

# Breeze style support
#cmake --build . --parallel --config RelWithDebInfo --target ext_breeze             Linux only

#################################################################################################

if [[ $DK_QTVERSION == 6 ]] ; then

    KF6_GITREV_LST=$ORIG_WD/data/kf6_manifest.txt

    echo "List git sub-module revisions in $KF6_GITREV_LST"

    if [ -f $KF6_GITREV_LST ] ; then
        rm -f $KF6_GITREV_LST
    fi

    currentDate=`date +"%Y-%m-%d"`
    echo "+KF6 Snapshot $currentDate" > $KF6_GITREV_LST

    # --- List git revisions for all sub-modules

    DIRS=$(find $BUILDING_DIR/ext_kf6/ -name "ext_*-prefix")

    for ITEM in $DIRS ; do

        COMPONENT=(echo $ITEM | cut -d'_' -f 1 | cut -d'-' -f 2)
        SUBDIR=$BUILDING_DIR/dk_cmake/ext_kf6/$ITEM/src/$COMPONENT
        cd $SUBDIR
        echo "$(basename "$SUBDIR"):$(git rev-parse HEAD)" >> $KF6_GITREV_LST
        cd $ORIG_WD

    done

    cat $KF6_GITREV_LST

fi

TerminateScript
