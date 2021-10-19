
#Practice 1 -- Sex-ICD10-D259
-------
#Aims: 
#1. familiar with UKB data;
#2. practice R and R packages.

#Addressed question: 
#select an ICD10 disease code and find the percentage of males and females who have this disease.

#Results: 
#use following commands to get data;

     # `head -n 1 ukb34137bu.tb | awk '{for(i=0;++i<=NF;)a[i]=a[i]?a[i] FS $i:$i}END{for(i=0;i++<NF;)print a[i]}' | grep -n "f.41270" |cut -d ":" -f 1`
      
     # `cut -f 1,2,2926-3138 ukb34137.tab > 41270.tab`
      
#use R script Sex_ICD10_D259.R to complete the practice. 


#This is an R script

#Loading packages
library(dplyr)
library(tidyverse)
library(ggplot2)

#Reading data
pra <- read.table("41270.tab",header=TRUE, sep="\t")

#Functoin "manyColsToDummy" created by Michael Francis
manyColsToDummy("D259",pra,"res_pra")

mer_pra <- data.frame(pra[,1:2],res_pra)
write.table(mer_pra,"ICD10_sex_D259_ubk_practice.txt",sep='\t',row.names = FALSE)

#Generating a bar plot
ggplot( mer_pra, aes( x = factor( D259 ),fill=factor(f.31.0.0,levels = c("0", "1"),labels = c("Female","Male"))))+theme(legend.title=element_blank())+geom_bar(position="dodge")+labs(x="Disease-D259",y="Number of people",title = "CD10_sex_D259_ubk_practice")

D259_0 <- length(which(mer_pra$D259==0))
D259_1 <- length(which(mer_pra$D259==1))
mal <- length(which(mer_pra$f.31.0.0==1))
fem <- length(which(mer_pra$f.31.0.0==0))
mal_0 <- nrow(mer_pra[which((mer_pra$f.31.0.0==1) & (mer_pra$D259==0)),])
mal_1 <- nrow(mer_pra[which((mer_pra$f.31.0.0==1) & (mer_pra$D259==1)),])
fem_0 <- nrow(mer_pra[which((mer_pra$f.31.0.0==0) & (mer_pra$D259==0)),])
fem_1 <- nrow(mer_pra[which((mer_pra$f.31.0.0==0) & (mer_pra$D259==1)),])

#Generating pie plots
D259_m <- data.frame(D259_n = c("D259_0","D259_1"), D259 = c(D259_0,D259_1))
label_value <- paste('(', round(D259_m$D259/sum(D259_m$D259) * 100, 1), '%)', sep = '')
label <- paste(D259_m$D259_n, label_value, sep = '')
ggplot(data = D259_m, mapping = aes(x = 'Content', y = D259, fill = D259_n)) + geom_bar(stat = 'identity', position = 'stack')+coord_polar(theta = 'y')+ labs(x = '', y = '', title = '')+theme(axis.text = element_blank())+ scale_fill_discrete(labels = label)

num_peo_m <- data.frame(num_peo_n = c("fem","mal"), num_peo = c(fem,mal))
label_value <- paste('(', round(num_peo_m$num_peo/sum(num_peo_m$num_peo) * 100, 1), '%)', sep = '')
label <- paste(num_peo_m$num_peo_n, label_value, sep = '')
ggplot(data = num_peo_m, mapping = aes(x = 'Content', y = num_peo, fill = num_peo_n)) + geom_bar(stat = 'identity', position = 'stack')+coord_polar(theta = 'y')+ labs(x = '', y = '', title = '')+theme(axis.text = element_blank())+ scale_fill_discrete(labels = label)

pie_m <- data.frame(pie_legend = c("fem_0","mal_0","fem_1","mal_1"), pop = c(fem_0,mal_0,fem_1,mal_1))
label_value <- paste('(', round(pie_m$pop/sum(pie_m$pop) * 100, 1), '%)', sep = '')
label <- paste(pie_m$pie_legend, label_value, sep = '')
ggplot(data = pie_m, mapping = aes(x = 'Content', y = pop, fill = pie_legend)) + geom_bar(stat = 'identity', position = 'stack')+coord_polar(theta = 'y')+ labs(x = '', y = '', title = '')+theme(axis.text = element_blank())+ scale_fill_discrete(labels = label)
