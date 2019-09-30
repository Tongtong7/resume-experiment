# resume-experiment
Codes that scrape info from job posts and codes that generate resume automatically

Explanation of each file:

1_ScrapeJob.py: Python codes that scrape specific information (e.g. industry, ownership sector) from online job posts in a large Chinese job-hunting website.

2_RandomizeResume.R: R codes that randomize 18 features (e.g. gender, internship experience) in each resume and save the randomization results in a csv file

3_CompileResume.R: R codes that read in the output of "2_RandomizeResume.R" and compile all randomly generated components into a resume (in Word document format)

CVformat1.Rmd: first blank resume template, used in "3_CompileResume.R" 

CVformat2.Rmd: second blank resume template, used in "3_CompileResume.R" 

CVformat3.Rmd: third blank resume template, used in "3_CompileResume.R" 