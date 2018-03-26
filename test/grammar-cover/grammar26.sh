#!/bin/bash
# Remake Python 2.6 grammar statistics
VERS=2.6
me=${BASH_SOURCE[0]}
workdir=$(dirname $me)
cd $workdir
workdir=$(pwd)
tmpdir=$workdir/../../tmp/grammar-cover
[[ -d  $tmpdir ]] || mkdir -p $tmpdir
cd $workdir/../..
source ./admin-tools/setup-master.sh
GRAMMAR_TXT=$tmpdir/grammar-${VERS}.txt
pyenv local ${VERS}.9
cd ./test
if [[ -r $GRAMMAR_TXT ]]; then
    GRAMMAR_SAVE_TXT=${tmpdir}/grammar-${VERS}-save.txt
    cp $GRAMMAR_TXT $GRAMMAR_SAVE_TXT
fi
make grammar-coverage-${VERS} && \
    spark-parser-coverage --path ${tmpdir}/spark-grammar-${VERS}.cover > $GRAMMAR_TXT
