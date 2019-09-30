######################################################################################
## Randomizing resume features
## The Limited Reach of State Ideology in China: Experimental Evidence from China's Labor Market
## Jennifer Pan and Tongtong Zhang
## Updated: December 3, 2017

## Description: these R codes randomize 18 features/components in a resume and save 
##              the randomization results into a csv file
######################################################################################
rm(list=ls())
#Prepare a pool for each resume feature
names<-c("赵宁","赵洋","钱瑞","钱华", "孙乐","孙晓","李想","李林","周聪","周楠", "吴远","吴尚","郑清","郑文","王星","王洋","冯晨","冯笑","陈西","陈平")
names_eng<-c("Ning Zhao","Yang Zhao","Rui Qian","Hua Qian", "Le Sun","Xiao Sun","Xiang Li","Lin Li","Cong Zhou","Nan Zhou", 
             "Yuan Wu","Shang Wu","Qing Zheng","Wen Zheng","Xing Wang","Yang Wang","Chen Feng","Xiao Feng","Xi Chen","Ping Chen")
gender<-c("男", "女")
gender_eng<-c("Male","Female")

university_pool<-c("北京航空航天大学","首都师范大学","南开大学","天津大学","上海大学","上海师范大学","江南大学","南京理工大学","扬州大学","南京工业大学",
              "浙江大学","浙江师范大学","宁波大学","武汉大学","华中师范大学","湖南师范大学","四川大学","西南大学","厦门大学","福州大学","福建师范大学",
              "南昌大学","合肥工业大学","广西大学")
university_pool_eng<-c("Beijing University of Aeronautics and Astronautics","Capital Normal University","Nankai University","Tianjin University","Shanghai University",
                   "Shanghai Normal University","Jiangnan University","Nanjing University of Science and Technology","Yangzhou University","Nanjing Tech University",
                   "Zhejiang University","Zhejiang Normal University","Ningbo University","Wuhan University","Central China Normal University","Hunan Normal University",
                   "Sichuan University","Southwest University","Xiamen University","Fuzhou University","Fujian Normal University",
                   "Nanchang University","Hefei University of Technology","Guangxi University")

rank<-c("45%","5%")
allegiance_levels<-c("socialism","comic","western")

certificates<-c("校运动会跳远前10名","校运动会跳高比赛第五名","秋季校运动会铅球前10名",
                "春季校运动会200米第五名","校运动会400米跑前10名","校运动会800米比赛第五名")
certificates_eng<-c("Top 10 finisher in long jump at university sports meeting","5th place in high jump at university sports meeting","Top 10 finisher in shot put at university autumn sports meeting",
                "5th place in 200m at university spring sports meeting","Top 10 finisher in 400m at university sports meeting","5th place in 800m at university sports meeting")

computer_skills<-c("Python","C++","JavaScript","Linux","PHP","SQL")
ccp_member<-c("中共党员","群众")
ccp_member_eng<-c("CCP member","None")
hobbies<-c("羽毛球","游泳","音乐","旅游","自行车","轮滑")
hobbies_eng<-c("Badminton","Swimming","Music","Travel","Biking","Roller skating")


setwd("/Users/tongtongzhang/Dropbox (IPL)/Job experiment/Implementation/STEP4_Application log")
d<-read.csv("application_170214-16.csv",header=TRUE, stringsAsFactors = FALSE,sep="\t") #Read in the jobs to apply for

d<-d[!apply(d=="" | is.na(d),1,all),] #remove rows and columns with NAs or empty cells in all of it
d<-d[,!apply(d=="" | is.na(d),2,all)]

###Randomization within job, and indepdently across jobs
#####Create empty columns to store randomization results
d$name<-NA
d$name_eng<-NA
d$gender<-NA
d$gender_eng<-NA
d$phonenumber<-NA
d$sender_email<-NA

d$university<-NA
d$university_eng<-NA
d$major<-NA
d$cohort_rank<-NA

d$intern1<-NA
d$intern2<-NA
d$allegiance<-NA
d$gradation<-NA

d$extra2<-NA
d$certificate1<-NA
d$certificate1_eng<-NA
d$certificate2<-NA
d$certificate2_eng<-NA
d$computer<-NA
d$ccp<-NA
d$ccp_eng<-NA
d$hobby1<-NA
d$hobby1_eng<-NA
d$hobby2<-NA
d$hobby2_eng<-NA

d$format<-NA


####### Let the loop start !!! ##########
job_number<-length(unique(d$job)) #total number of jobs on the day

set.seed(17021416) #the date of the job is seed number, e.g. 161121,1612056,16122327,161230170103,1701069,17011011,170113-17,170120-23,1701260207, 17020809,17021013,17021416
for (i in 1:job_number){
  name_index <- sample(1:20,3,FALSE)
  d[d$job==i, "name"]<- names[name_index] #sample without replacement 3 names for the 3CVs submitted to job i
  d[d$job==i, "name_eng"]<- names_eng[name_index]
  
  gender_index <- sample(1:2,3,TRUE)
  d[d$job==i, "gender"]<- gender[gender_index] #sample with replacement for gender 3 times
  d[d$job==i, "gender_eng"]<- gender_eng[gender_index]
  
  university_index <- sample(1:24,3,FALSE)
  d[d$job==i, "university"]<- university_pool[university_index] #sample with replacement for gender 3 times
  d[d$job==i, "university_eng"]<- university_pool_eng[university_index]
  
  block<-unique(d[d$job==i, "block"]) #extract the block of majors
  major_number <-ifelse(block=="econ", 6, ifelse(block=="cs"| block=="ee",1, ifelse(block=="hs",2,4))) #determine the number of majors in that block
  d[d$job==i, "major"]<-sample(1:major_number,3,TRUE) #sample majors with replacement for each resume
  d[d$job==i, "cohort_rank"]<-sample(rank,3,TRUE) #sample cohort rank with replacement
  
  internship_within_job<-sample(1:6,6,FALSE)  #randomly assign 6 internships across 3 CVs to the same job - complete randomization
  d[d$job==i, "intern1"]<-internship_within_job[1:3]
  d[d$job==i, "intern2"]<-internship_within_job[4:6]
  
  d[d$job==i, "allegiance"]<-sample(allegiance_levels,3,FALSE) #complete randomization of allegiance levels across the 3 CVs to the same job
  d[d$job==i, "gradation"]<-sample(1:4,3,TRUE) #simple randomization of gradation
  
  d[d$job==i, "extra2"]<-sample(1:6,3,FALSE) #complete randomization of 2nd extracurricular across the 3 CVs to the same job
  
  certificates_index <- sample(1:6,6,FALSE)
  d[d$job==i, "certificate1"]<- certificates[certificates_index[1:3]] #sample without replacement for certificates
  d[d$job==i, "certificate1_eng"]<- certificates_eng[certificates_index[1:3]]
  d[d$job==i, "certificate2"]<- certificates[certificates_index[4:6]] 
  d[d$job==i, "certificate2_eng"]<- certificates_eng[certificates_index[4:6]]

  d[d$job==i, "computer"]<-sample(computer_skills,3,TRUE) #simple randomization of computer skills across 3 CVs;
  
  ccp_index <- sample(1:2,3,TRUE) #simple randomization of ccp membership across 3 CVs;
  d[d$job==i, "ccp"]<- ccp_member[ccp_index] #sample with replacement for gender 3 times
  d[d$job==i, "ccp_eng"]<- ccp_member_eng[ccp_index]
  
  hobby_index <- sample(1:6,2,FALSE) #simple randomization of hobbies across 3 CVs
  d[d$job==i & d$resume==1, c("hobby1","hobby2")]<- hobbies[hobby_index] 
  d[d$job==i & d$resume==1, c("hobby1_eng","hobby2_eng")]<- hobbies_eng[hobby_index]

  hobby_index <- sample(1:6,2,FALSE) #simple randomization of hobbies across 3 CVs
  d[d$job==i & d$resume==2, c("hobby1","hobby2")]<- hobbies[hobby_index] 
  d[d$job==i & d$resume==2, c("hobby1_eng","hobby2_eng")]<- hobbies_eng[hobby_index]
  
  hobby_index <- sample(1:6,2,FALSE) #simple randomization of hobbies across 3 CVs
  d[d$job==i & d$resume==3, c("hobby1","hobby2")]<- hobbies[hobby_index] 
  d[d$job==i & d$resume==3, c("hobby1_eng","hobby2_eng")]<- hobbies_eng[hobby_index]
  
  d[d$job==i, "format"]<-sample(1:3,3,FALSE) #complete randomization of formats across 3 CVs
}

####### Assign the right email and phone number !!! ##########
d$phonenumber<-NA
d$sender_email<-NA

table(d$sector)
#Government
#Public institutions
#SOE
#Private
#Foreign

d$sector[d$sector=="Public insitutions"]<-"Public institutions"

#1 western 45 Private
d[d$allegiance=="western" & d$cohort_rank=="45%" & d$sector=="Private", "phonenumber"]<-"15010275593"
d[d$allegiance=="western" & d$cohort_rank=="45%" & d$sector=="Private", "sender_email"]<-"email_shixian1@163.com"
#2 western 45 Gov't
d[d$allegiance=="western" & d$cohort_rank=="45%" & (d$sector=="Government" | d$sector=="Public institutions"), "phonenumber"]<-"15101102781"
d[d$allegiance=="western" & d$cohort_rank=="45%" & (d$sector=="Government" | d$sector=="Public institutions"), "sender_email"]<-"email_yongbo2@163.com"
#3 western 45 SOE
d[d$allegiance=="western" & d$cohort_rank=="45%" & d$sector=="SOE", "phonenumber"]<-"15010262083"
d[d$allegiance=="western" & d$cohort_rank=="45%" & d$sector=="SOE", "sender_email"]<-"email_yongbo2@163.com"
#4 western 45 Foreign
d[d$allegiance=="western" & d$cohort_rank=="45%" & d$sector=="Foreign", "phonenumber"]<-"18201655905"
d[d$allegiance=="western" & d$cohort_rank=="45%" & d$sector=="Foreign", "sender_email"]<-"email_yongbo2@163.com"

#5 western 5 Private
d[d$allegiance=="western" & d$cohort_rank=="5%" & d$sector=="Private", "phonenumber"]<-"15001293772"
d[d$allegiance=="western" & d$cohort_rank=="5%" & d$sector=="Private", "sender_email"]<-"email_xuewei3@163.com"
#6 western 5 Gov't
d[d$allegiance=="western" & d$cohort_rank=="5%" & (d$sector=="Government" | d$sector=="Public institutions"), "phonenumber"]<-"18310116907"
d[d$allegiance=="western" & d$cohort_rank=="5%" & (d$sector=="Government" | d$sector=="Public institutions"), "sender_email"]<-"email_libing4@163.com"
#7 western 5 SOE
d[d$allegiance=="western" & d$cohort_rank=="5%" & d$sector=="SOE", "phonenumber"]<-"15801052680"
d[d$allegiance=="western" & d$cohort_rank=="5%" & d$sector=="SOE", "sender_email"]<-"email_libing4@163.com"
#8 western 5 Foreign
d[d$allegiance=="western" & d$cohort_rank=="5%" & d$sector=="Foreign", "phonenumber"]<-"15116936895"
d[d$allegiance=="western" & d$cohort_rank=="5%" & d$sector=="Foreign", "sender_email"]<-"email_libing4@163.com"

#9 comic 45 Private
d[d$allegiance=="comic" & d$cohort_rank=="45%" & d$sector=="Private", "phonenumber"]<-"18201577391"
d[d$allegiance=="comic" & d$cohort_rank=="45%" & d$sector=="Private", "sender_email"]<-"luchi5_youxiang@163.com"
#10 comic 45 Gov't
d[d$allegiance=="comic" & d$cohort_rank=="45%" & (d$sector=="Government" | d$sector=="Public institutions"), "phonenumber"]<-"18201692091"
d[d$allegiance=="comic" & d$cohort_rank=="45%" & (d$sector=="Government" | d$sector=="Public institutions"), "sender_email"]<-"haotian6_youxiang@163.com"
#11 comic 45 SOE
d[d$allegiance=="comic" & d$cohort_rank=="45%" & d$sector=="SOE", "phonenumber"]<-"15010713267"
d[d$allegiance=="comic" & d$cohort_rank=="45%" & d$sector=="SOE", "sender_email"]<-"haotian6_youxiang@163.com"
#12 comic 45 Foreign
d[d$allegiance=="comic" & d$cohort_rank=="45%" & d$sector=="Foreign", "phonenumber"]<-"15910848622"
d[d$allegiance=="comic" & d$cohort_rank=="45%" & d$sector=="Foreign", "sender_email"]<-"haotian6_youxiang@163.com"

#13 comic 5 Private
d[d$allegiance=="comic" & d$cohort_rank=="5%" & d$sector=="Private", "phonenumber"]<-"15010153267"
d[d$allegiance=="comic" & d$cohort_rank=="5%" & d$sector=="Private", "sender_email"]<-"beibei7_youxiang@163.com"
#14 comic 5 Gov't
d[d$allegiance=="comic" & d$cohort_rank=="5%" & (d$sector=="Government" | d$sector=="Public institutions"), "phonenumber"]<-"15011153872"
d[d$allegiance=="comic" & d$cohort_rank=="5%" & (d$sector=="Government" | d$sector=="Public institutions"), "sender_email"]<-"zengni8_youxiang@163.com"
#15 comic 5 SOE
d[d$allegiance=="comic" & d$cohort_rank=="5%" & d$sector=="SOE", "phonenumber"]<-"18201656603"
d[d$allegiance=="comic" & d$cohort_rank=="5%" & d$sector=="SOE", "sender_email"]<-"zengni8_youxiang@163.com"
#16 comic 5 Foreign
d[d$allegiance=="comic" & d$cohort_rank=="5%" & d$sector=="Foreign", "phonenumber"]<-"15010301775"
d[d$allegiance=="comic" & d$cohort_rank=="5%" & d$sector=="Foreign", "sender_email"]<-"zengni8_youxiang@163.com"

#17 socialism 45 Private
d[d$allegiance=="socialism" & d$cohort_rank=="45%" & d$sector=="Private", "phonenumber"]<-"15210890872"
d[d$allegiance=="socialism" & d$cohort_rank=="45%" & d$sector=="Private", "sender_email"]<-"siyuandeemail@163.com"
#18 socialism 45 Gov't
d[d$allegiance=="socialism" & d$cohort_rank=="45%" & (d$sector=="Government" | d$sector=="Public institutions"), "phonenumber"]<-"15010168753"
d[d$allegiance=="socialism" & d$cohort_rank=="45%" & (d$sector=="Government" | d$sector=="Public institutions"), "sender_email"]<-"jiawendeemail@163.com"
#19 socialism 45 SOE
d[d$allegiance=="socialism" & d$cohort_rank=="45%" & d$sector=="SOE", "phonenumber"]<-"15010713897"
d[d$allegiance=="socialism" & d$cohort_rank=="45%" & d$sector=="SOE", "sender_email"]<-"jiawendeemail@163.com"
#20 socialism 45 Foreign
d[d$allegiance=="socialism" & d$cohort_rank=="45%" & d$sector=="Foreign", "phonenumber"]<-"18301497896"
d[d$allegiance=="socialism" & d$cohort_rank=="45%" & d$sector=="Foreign", "sender_email"]<-"jiawendeemail@163.com"

#21 socialism 5 Private
d[d$allegiance=="socialism" & d$cohort_rank=="5%" & d$sector=="Private", "phonenumber"]<-"15010076791"
d[d$allegiance=="socialism" & d$cohort_rank=="5%" & d$sector=="Private", "sender_email"]<-"wangyuedeemail@163.com"
#22 socialism 5 Gov't
d[d$allegiance=="socialism" & d$cohort_rank=="5%" & (d$sector=="Government" | d$sector=="Public institutions"), "phonenumber"]<-"15011153807"
d[d$allegiance=="socialism" & d$cohort_rank=="5%" & (d$sector=="Government" | d$sector=="Public institutions"), "sender_email"]<-"xiongweideemail@163.com"
#23 socialism 5 SOE
d[d$allegiance=="socialism" & d$cohort_rank=="5%" & d$sector=="SOE", "phonenumber"]<-"15001373671"
d[d$allegiance=="socialism" & d$cohort_rank=="5%" & d$sector=="SOE", "sender_email"]<-"xiongweideemail@163.com"
#24 socialism 5 Foreign
d[d$allegiance=="socialism" & d$cohort_rank=="5%" & d$sector=="Foreign", "phonenumber"]<-"18310097157"
d[d$allegiance=="socialism" & d$cohort_rank=="5%" & d$sector=="Foreign", "sender_email"]<-"xiongweideemail@163.com"


#################Double Check Complete Randomization########################
name_length<-NA
name_eng_length<-NA
university_length<-NA
university_eng_length<-NA
intern_length<-NA
extra2_length<-NA
format_length<-NA
allegiance_length<-NA
phonenumber_length<-NA
email_length<-NA
certificate_length<-NA
certificate_eng_length<-NA

for (i in 1:job_number){
  name_length[i] <-length(unique(d[d$job==i, "name"]))
  name_eng_length[i] <-length(unique(d[d$job==i, "name_eng"]))
  university_length[i] <-length(unique(d[d$job==i, "university"]))
  university_eng_length[i] <-length(unique(d[d$job==i, "university_eng"]))
  intern_length[i] <-length(unique(c(d[d$job==i, "intern1"],d[d$job==i, "intern2"])))
  extra2_length[i] <-length(unique(d[d$job==i, "extra2"]))
  format_length[i]<-length(unique(d[d$job==i, "format"]))
  allegiance_length[i]<-length(unique(d[d$job==i, "allegiance"]))
  phonenumber_length[i]<-length(unique(d[d$job==i, "phonenumber"]))
  email_length[i]<-length(unique(d[d$job==i, "sender_email"]))
  certificate_length[i] <-length(unique(c(d[d$job==i, "certificate1"],d[d$job==i, "certificate2"])))
  certificate_eng_length[i] <-length(unique(c(d[d$job==i, "certificate1_eng"],d[d$job==i, "certificate2_eng"])))
}

table(name_length)
table(name_eng_length)
table(university_length)
table(university_eng_length)
table(intern_length) #6
table(extra2_length)
table(format_length)
table(allegiance_length)
table(phonenumber_length)
table(email_length)
table(certificate_eng_length)#6
table(certificate_length)#6

sum(is.na(d$phonenumber))
sum(is.na(d$sender_email))

############### Add in Submission RA ###################
d$submitRA<-NA

d$submitRA[d$sender_email=="email_shixian1@163.com"]<-"Lishixian"
d$submitRA[d$sender_email=="email_yongbo2@163.com"]<-"Liuyongbo"
d$submitRA[d$sender_email=="email_xuewei3@163.com"]<-"Zhuyutong"
d$submitRA[d$sender_email=="email_libing4@163.com"]<-"Libing"

d$submitRA[d$sender_email=="luchi5_youxiang@163.com"]<-"Heluchi"
d$submitRA[d$sender_email=="haotian6_youxiang@163.com"]<-"Buhaotian"
d$submitRA[d$sender_email=="beibei7_youxiang@163.com"]<-"Tanbeibei"
d$submitRA[d$sender_email=="zengni8_youxiang@163.com"]<-"Zengni"

d$submitRA[d$sender_email=="siyuandeemail@163.com"]<-"Maosiyuan"
d$submitRA[d$sender_email=="jiawendeemail@163.com"]<-"Wangjiawen"
d$submitRA[d$sender_email=="wangyuedeemail@163.com"]<-"Wangyue"
d$submitRA[d$sender_email=="xiongweideemail@163.com"]<-"Xiongwei"


#Write out the phone number and treatments
d1<-d[,c("resume_index","submitRA","phonenumber","sender_email","allegiance","cohort_rank")]
write.csv(d1,file="result.csv",row.names = FALSE)


write.csv(d, file = "randomization0214-16.csv",row.names=FALSE) #the total randomization result
