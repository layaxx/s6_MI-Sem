#!/bin/bash

TIMES=100

outputFile=$(date +"%Y-%m-%dT%H-%M-%S.log")
# VAL data set
node data/setup.js data/val.jsonl
echo "Running Benchmark on VAL dataset" > $outputFile
python3 benchmark.py $TIMES >> $outputFile


# TEST data set
node data/setup.js data/test.jsonl
echo "Running Benchmark on TEST dataset" >> $outputFile
python3 benchmark.py $TIMES >> $outputFile


# TRAIN data set
node data/setup.js data/train.jsonl
echo "Running Benchmark on TRAIN dataset" >> $outputFile
python3 benchmark.py $TIMES >> $outputFile