#!/bin/sh

_BASE_DIR_=$PWD
. $_BASE_DIR_/cfg.sh

if [ ! -d "$_ARC_DIR_" ]; then
	mkdir -p $_ARC_DIR_
fi

GNUFTP=https://ftpmirror.gnu.org
cd $_ARC_DIR_

GCC_URL=$GNUFTP/gcc/gcc-11.2.0/gcc-11.2.0.tar.xz
if [ "$#" -gt 0 ]; then
	case "$1" in
		gcc12)
			GCC_URL=$GNUFTP/gcc/gcc-12.2.0/gcc-12.2.0.tar.xz
			shift
		;;
		gcc13)
			GCC_URL=$GNUFTP/gcc/gcc-13.2.0/gcc-13.2.0.tar.xz
			shift
		;;
	esac
fi
wget $GCC_URL

wget $GNUFTP/binutils/binutils-2.37.tar.xz
wget $GNUFTP/mpfr/mpfr-4.1.0.tar.xz
wget $GNUFTP/gmp/gmp-6.2.1.tar.xz
wget $GNUFTP/mpc/mpc-1.2.1.tar.gz

#wget https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.18.tar.bz2
wget https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.24.tar.bz2
wget https://gcc.gnu.org/pub/gcc/infrastructure/cloog-0.18.1.tar.gz

cd $_BASE_DIR_

