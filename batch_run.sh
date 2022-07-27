#!/bin/bash

echo
echo "Bash script started"
date

source /lustre/cbm/users/lubynets/soft/root-6/install_6.20_cpp17_debian10/bin/thisroot.sh
source /lustre/cbm/users/lubynets/soft/root-6/install_6.20_cpp17_debian10/bin/thisroot.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lustre/cbm/users/khan/cbmsoft/AnalysisTreeQA/install/lib/
export AnalysisTree_DIR=/lustre/cbm/users/khan/cbmsoft/AnalysisTree/lib/cmake/AnalysisTree/


INDEX=${SLURM_ARRAY_TASK_ID}

PROJECT_DIR=/lustre/cbm/users/$USER
for num in 1 2
do
if [ $num -eq 1 ]
then
GENERATOR=dcm
fi
if [ $num -eq 2 ]
then
GENERATOR=urqmd
fi




SETUP=apr20_fr_18.2.1_fs_jun19p1/$GENERATOR/auau/12agev/mbias/sis100_electron_target_25_mkm


EXE_DIR=$PROJECT_DIR/cbmsoft/AnalysisTreeQA/install/bin
OUTPUT_DIR=${PROJECT_DIR}/scripts_AnalysisTreeQA/outputs/$SETUP
WORK_DIR=$PROJECT_DIR/workdir_ana
FILELIST_DIR=$PROJECT_DIR/filelists/$GENERATOR

mkdir -p $WORK_DIR/$INDEX
mkdir -p $OUTPUT_DIR

cd $WORK_DIR/$INDEX

cp $EXE_DIR/lambda_qa ./

./lambda_qa $FILELIST_DIR/filelist_${GENERATOR}_$INDEX.txt >& log_${INDEX}.txt

rm lambda_qa
mv lambda_qa.root lambda_qa.$INDEX.root

cd ..
mv $INDEX $OUTPUT_DIR
done
echo
echo "Bash script finished successfully"
date

