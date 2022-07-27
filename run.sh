#!/bin/bash
LOGDIR=/lustre/cbm/users/$USER/scripts_AnalysisTreeQA/log
mkdir -p $LOGDIR
mkdir -p $LOGDIR/out
mkdir -p $LOGDIR/error

sbatch  --job-name=AnalysisTreeQA \
        -t 08:00:00 \
        --partition main \
        --output=$LOGDIR/out/%j.out.log \
        --error=$LOGDIR/error/%j.err.log \
        -a 1-400 \
        -- $PWD/batch_run.sh
