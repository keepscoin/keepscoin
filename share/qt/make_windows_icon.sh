#!/bin/bash
# create multiresolution windows icon
#mainnet
ICON_SRC=../../src/qt/res/icons/kpcoin.png
ICON_DST=../../src/qt/res/icons/kpcoin.ico
convert ${ICON_SRC} -resize 16x16 kpcoin-16.png
convert ${ICON_SRC} -resize 32x32 kpcoin-32.png
convert ${ICON_SRC} -resize 48x48 kpcoin-48.png
convert kpcoin-16.png kpcoin-32.png kpcoin-48.png ${ICON_DST}
#testnet
ICON_SRC=../../src/qt/res/icons/kpcoin_testnet.png
ICON_DST=../../src/qt/res/icons/kpcoin_testnet.ico
convert ${ICON_SRC} -resize 16x16 kpcoin-16.png
convert ${ICON_SRC} -resize 32x32 kpcoin-32.png
convert ${ICON_SRC} -resize 48x48 kpcoin-48.png
convert kpcoin-16.png kpcoin-32.png kpcoin-48.png ${ICON_DST}
rm kpcoin-16.png kpcoin-32.png kpcoin-48.png
