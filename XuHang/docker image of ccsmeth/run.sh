#!/bin/bash  
  
# 询问用户是否需要call hifi reads with kinetics  
echo "Do you need to call hifi reads with kinetics ? (yes/no): "  
read run_step1  
  
# 根据用户输入判断是否需要执行step1. call hifi reads with kinetics if needed  
if [[ "$run_step1" == "yes" ]]; then  
    # 如果需要，则调用ccsmeth的call_hifi命令，并指定输入和输出路径  
    ccsmeth call_hifi --subreads /path/to/input/subreads.bam --output /path/to/output.hifi.bam  
  
    # 使用上一步生成的hifi reads进行比对step2.align hifi reads  
    ccsmeth align_hifi --hifireads /path/to/output.hifi.bam --ref /path/to/genome.fa --output /path/to/output.hifi.pbmm2.bam  
else  
    # 如果不需要，则直接进行比对step2.align hifi reads  
    ccsmeth align_hifi --hifireads /path/to/step2_input.bam --ref /path/to/genome.fa --output /path/to/output.hifi.pbmm2.bam  
fi  
  
# 无论是否执行了第一步，都执行step3.call modifications    
CUDA_VISIBLE_DEVICES=0 ccsmeth call_mods --input /path/to/output.hifi.pbmm2.bam --ref /path/to/genome.fa --model_file /ccsmeth/models/model_ccsmeth_5mCpG_call_mods_attbigru2s_b21.v3.ckpt --output /path/to/output.hifi.pbmm2.call_mods --threads 10 --threads_call 2 --model_type attbigru2s --mode align  
  
# step4. call modification frequency  
ccsmeth call_freqb --input_bam /path/to/output.hifi.pbmm2.call_mods.modbam.bam --ref /path/to/genome.fa --output /path/to/output.hifi.pbmm2.call_mods.modbam.freq --threads 10 --sort --bed --call_mode aggregate --aggre_model /ccsmeth/models/model_ccsmeth_5mCpG_aggregate_attbigru_b11.v2p.ckpt