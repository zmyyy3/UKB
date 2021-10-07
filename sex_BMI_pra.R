#This is an R script that can analyzie BMI of female and male in 
#UK Biobank and generate a box plot. 

#load package
library(ggplot2)

#read data
df <- read.table("ukb34137.tab", header = T, sep = "\t")
df_37330 <- read.table("ukb37330.tab", header = T, sep = "\t")

#extract interested data，we were interested in sex and BMI in this case.
df_sex <- df[,grepl("f.eid|f.31.0",colnames(df))]
df_bmi <- df_37330[,grepl("f.eid|f.21001.0",colnames(df_37330))]

#merge dataframes of sex and BMI.
df_sex_bmi <- merge(df_sex,df_bmi)

#edit column names in order to easy understand
colnames(df_sex_bmi) <- c("ID","Sex","BMI")

#Sex was described as integers 0 or 1, so it will be recognized as numberic 
#and cannot get the correct box plot. 
df_sex_bmi[,2] <- gsub("1","Male",df_sex_bmi[,2])
df_sex_bmi[,2] <- gsub("0","Female",df_sex_bmi[,2])

#generate box plot.
ggplot(df_sex_bmi, aes(Sex, BMI)) + 
  stat_boxplot(geom = "errorbar", width=0.15,aes(color=Sex)) + 
  geom_boxplot(aes(colour=Sex),width=0.5) + 
  labs(title="BMI of female and male in UK Biobank") + 
  geom_signif(comparisons = list(c("Female","Male")),
              map_signif_level = T, test=t.test, step_increase = 0.0)+
  theme(plot.title = element_text(hjust = 0.5)) 

                                   