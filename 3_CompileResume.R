######################################################################################
## Randomizing resume features
## The Limited Reach of State Ideology in China: Experimental Evidence from China's Labor Market
## Jennifer Pan and Tongtong Zhang
## Updated: December 3, 2017

## Description: this file reads in the randomization results (.csv) of  
##              resume components, plug each realized component in a blank resume,
##              and creates the compiled resume in Word documents.
######################################################################################
rm(list=ls())

#Create today's subfolders for Word and PDF resumes
RA<-c("Buhaotian","Heluchi","Libing","Lishixian","Liuyongbo","Maosiyuan","Tanbeibei","Wangjiawen","Zhuyutong","Wangyue","Xiongwei","Zengni")
for (i in 1:length(RA)){
  dir.create(paste0("/Users/tongtongzhang/Dropbox (IPL)/Job experiment/Implementation/STEP4_Application log/Randomization_result/RA_CV/",RA[i],"/170214-16"))       #Change the date
  dir.create(paste0("/Users/tongtongzhang/Dropbox (IPL)/Job experiment/Implementation/STEP4_Application log/Randomization_result/RA_CV/",RA[i],"/170214-16/Word"))
  dir.create(paste0("/Users/tongtongzhang/Dropbox (IPL)/Job experiment/Implementation/STEP4_Application log/Randomization_result/RA_CV/",RA[i],"/170214-16/PDF"))
}

setwd("/Users/tongtongzhang/Dropbox (IPL)/Job experiment/CV/Conjoint CV")
majors<-read.csv("majors.csv",header=TRUE, stringsAsFactors = FALSE,sep=",")
internships<-read.csv("internships.csv",header=TRUE, stringsAsFactors = FALSE,sep="\t")
allegiance_treatment<-read.csv("allegiance_treatment.csv",header=TRUE, stringsAsFactors = FALSE,sep="\t")
extra2nd<-read.csv("2nd_extracurricular.csv",header=TRUE, stringsAsFactors = FALSE,sep=",")

setwd("/Users/tongtongzhang/Dropbox (IPL)/Job experiment/Implementation/STEP4_Application log/Randomization_result")
data<-read.csv("randomization_all.csv",header=TRUE, stringsAsFactors = FALSE,sep=",")                                                                         #Change the randomization result date
setwd("/Users/tongtongzhang/Dropbox (IPL)/Job experiment/Analysis/Data")
d<-read.csv("apply_analysis2.csv",header=TRUE, stringsAsFactors = FALSE,sep=",")
table(d$block,exclude=NULL)

#Subset the randomization results into 3 formats
d1<-data[data$format==1,]
d2<-data[data$format==2,]
d3<-data[data$format==3,]

d<-d1

for (i in 1:nrow(d)){
filename<-paste0(d[i,"resume_index"],"_",d[i,"submitRA"],"_",d[i,"name"],"-应聘",as.name(as.character(d[i,"position"])))
rmarkdown::render("CVformat1.Rmd",output_file = paste0("/Users/tongtongzhang/Dropbox (IPL)/Job experiment/Implementation/STEP4_Application log/Randomization_result/RA_CV/",d[i,"submitRA"],"/170214-16/Word/",filename,".docx"))
}


d<-d2

for (i in 1:nrow(d)){
  filename<-paste0(d[i,"resume_index"],"_",d[i,"submitRA"],"_",d[i,"name"]," 应聘",as.name(as.character(d[i,"position"])))
  rmarkdown::render("CVformat2.Rmd",output_file = paste0("/Users/tongtongzhang/Dropbox (IPL)/Job experiment/Implementation/STEP4_Application log/Randomization_result/RA_CV/",d[i,"submitRA"],"/170214-16/Word/",filename,".docx"))
}


d<-d3

for (i in 1:nrow(d)){
  filename<-paste0(d[i,"resume_index"],"_",d[i,"submitRA"],"_",d[i,"name"],"_应聘",as.name(as.character(d[i,"position"])))
  rmarkdown::render("CVformat3.Rmd",output_file = paste0("/Users/tongtongzhang/Dropbox (IPL)/Job experiment/Implementation/STEP4_Application log/Randomization_result/RA_CV/",d[i,"submitRA"],"/170214-16/Word/",filename,".docx"))
}



#Write out the phone number and treatments
d<-data[,c("resume_index","submitRA","phonenumber","sender_email","allegiance","cohort_rank")]
write.csv(d,file="result.csv",row.names = FALSE)
