#!/bin/sh
if [ $# -eq 0 ]; then
  DIR=`pwd`
elif [ $# -eq 1 ]; then
  DIR=$1
else
  echo "Usage: $0 [DIR]"
  exit 0
fi

if [ ! -d ${DIR} ] ; then
  mkdir -p ${DIR}
fi

wget -N -P ${DIR} http://openlab.ring.gr.jp/skk/dic/SKK-JISYO.L.gz
wget -N -P ${DIR} http://openlab.ring.gr.jp/skk/dic/SKK-JISYO.jinmei.gz
wget -N -P ${DIR} http://openlab.ring.gr.jp/skk/dic/SKK-JISYO.geo.gz
wget -N -P ${DIR} http://openlab.ring.gr.jp/skk/dic/SKK-JISYO.propernoun.gz
wget -N -P ${DIR} http://openlab.ring.gr.jp/skk/dic/SKK-JISYO.station.gz

echo "extracting..."
gunzip < ${DIR}/SKK-JISYO.L.gz > ${DIR}/SKK-JISYO.L
gunzip < ${DIR}/SKK-JISYO.jinmei.gz > ${DIR}/SKK-JISYO.jinmei
gunzip < ${DIR}/SKK-JISYO.geo.gz > ${DIR}/SKK-JISYO.geo
gunzip < ${DIR}/SKK-JISYO.propernoun.gz > ${DIR}/SKK-JISYO.propernoun
gunzip < ${DIR}/SKK-JISYO.station.gz > ${DIR}/SKK-JISYO.station
echo "done."

echo "merging..."
skkdic-expr ${DIR}/SKK-JISYO.L \
 + ${DIR}/SKK-JISYO.jinmei + ${DIR}/SKK-JISYO.geo \
 + ${DIR}/SKK-JISYO.propernoun + ${DIR}/SKK-JISYO.station \
 | skkdic-sort > ${DIR}/SKK-JISYO.merged
echo "done."

