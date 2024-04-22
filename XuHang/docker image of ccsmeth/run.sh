#!/bin/bash
echo "Do you need to call hifi reads with kinetics ? (yes/no): "
read run_step1
if [[ "$RUN_STEP1" = "true" ]]; then
  ccsmeth call_hifi --subreads /path/to/input/subreads.bam --output /path/to/output.hifi.bam
  ccsmeth align_hifi --hifireads /path/to/output.hifi.bam --ref /path/to/genome.fa --output /path/to/output.hifi.pbmm2.bam
else
  ccsmeth align_hifi --hifireads /path/to/step2_input.bam --ref /path/to/genome.fa --output /path/to/output.hifi.pbmm2.bam
fi

CUDA_VISIBLE_DEVICES=0 ccsmeth call_mods --input /path/to/output.hifi.pbmm2.bam --ref /path/to/genome.fa --model_file /ccsmeth/models/model_ccsmeth_5mCpG_call_mods_attbigru2s_b21.v3.ckpt --output /path/to/output.hifi.pbmm2.call_mods --threads 10 --threads_call 2 --model_type attbigru2s --mode align

ccsmeth call_freqb --input_bam /path/to/output.hifi.pbmm2.call_mods.modbam.bam --ref /path/to/genome.fa --output /path/to/output.hifi.pbmm2.call_mods.modbam.freq --threads 10 --sort --bed --call_mode aggregate --aggre_model /ccsmeth/models/model_ccsmeth_5mCpG_aggregate_attbigru_b11.v2p.ckpt