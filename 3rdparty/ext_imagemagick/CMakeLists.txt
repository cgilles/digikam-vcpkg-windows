# Script to build imagemagick for digiKam bundle.
#
# Copyright (c) 2015-2023 by Gilles Caulier  <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

set(PREFIX_ext_imagemagick "${EXTPREFIX}")

set(Magick_Conf --prefix=${PREFIX_ext_imagemagick}
                --without-freetype                     # TrueType font rendering library.
                --without-fontconfig                   # Disable configuring and customizing font access.
                --without-pango                        # Disable Layout and rendering of internationalized text.
                --without-raqm                         # Disable Complex Textlayout Library.
                --without-gvc                          # Disable rich set of graph drawing tools.
                --without-raw                          # Disable RAW codec.
                --without-lqr                          # Disable Liquid Rescale.
                --without-openjp2                      # Disable JPEG2000 codec.
                --without-heic                         # Disable HEIF codec.
                --without-jxl                          # Disable JPEG-XL codec.
                --without-threads                      # Disable internal threads.
                --without-perl                         # Disable Perl scripts.
                --without-lcms                         # Disable Colors Management.
                --disable-docs                         # Disable documentations.
                --disable-hdri                         # Disable HDRI support.
                --disable-static                       # Disable static libraries.
                --enable-shared                        # Compile shared libraries.
                --with-x=no                            # Disable X11 support.
                --with-magick-plus-plus                # Enable C++ API.
                --with-flif                            # Enable JLIF codec.
                --with-jbig                            # Enable Big JPEG codec.
                --with-webp                            # Enable WebP codec.
                --with-djvu                            # Enable DJVu codec.
                --with-rsvg                            # Enable SVG codec.
                --with-xml                             # Enable XML support.
                --with-fpx                             # Enable FlashPix Codec.
                --with-openexr                         # Enable OpenEXR codec.
                --with-quantum-depth=16                # Use 1§Bits quantum for color components.
                --without-utilities                    # Disable CLI tools.
)

if(MINGW)

    set(Magick_Conf ${Magick_Conf}
                    --host=${MXE_BUILD_TARGETS}
                    --build=x86_64-pc-linux-gnu
    )

    set(Magick_Patch ${PATCH_COMMAND} -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/magick-plusplus-mxe.patch)

    set(Magick_Depends ext_jbig)

endif()

set(Jbig_Conf -DBUILD_PROGRAMS=OFF
              -DEXIV2_TOOLS=OFF
)

JoinListAsString("${Jbig_Conf}" " " BASH_OPTIONS)

ExternalProject_Add(ext_jbig

    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

    GIT_REPOSITORY https://github.com/zdenop/jbigkit.git

    CONFIGURE_COMMAND cp -f ${CMAKE_CURRENT_SOURCE_DIR}/../../../../bootstrap.mxe <SOURCE_DIR>/. &&
                      <SOURCE_DIR>/bootstrap.mxe ${MXE_BUILDROOT} RelWithDebInfo ${BASH_OPTIONS}

    BUILD_COMMAND cd <SOURCE_DIR>/build.mxe && $(MAKE) -j

    INSTALL_COMMAND cd <SOURCE_DIR>/build.mxe && $(MAKE) install/fast

    BUILD_IN_SOURCE 1

    UPDATE_COMMAND ""
    ALWAYS 0
)

ExternalProject_Add(ext_imagemagick

    DEPENDS ${Magick_Depends}

    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

    GIT_REPOSITORY https://github.com/ImageMagick/ImageMagick.git
    GIT_TAG 7.1.1-20

    PATCH_COMMAND ${Magick_Patch}

    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${Magick_Conf}

    UPDATE_COMMAND ""
    ALWAYS 0
)
