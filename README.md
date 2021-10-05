Introduction
======
This repository contains UKB practice.

Practice 1 -- Sex-ICD10-D259
-------
**Aims**: 1. familiar with UKB data
          2. practice R and R packages

**Addressed question**: select an ICD10 disease code and find the percentage of males and females who have this disease.

**Results**: 1. use following commands to get data.
      `head -n 1 ukb34137bu.tb | awk '{for(i=0;++i<=NF;)a[i]=a[i]?a[i] FS $i:$i}END{for(i=0;i++<NF;)print a[i]}' | grep -n "f.41270" |cut -d ":" -f 1`
                 `cut -f 1,2,2926-3138 ukb34137.tab > 41270.tab`
                 
             2. use R script Sex_ICD10_D259.R to complete the practice. Please see detail in Sex_ICD10_D259.R

**Date**: 10/05/2021 
