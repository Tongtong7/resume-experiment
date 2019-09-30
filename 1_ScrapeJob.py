# -*- coding: utf-8 -*-
#import urllib.request
#import urllib.error
#import urllib.parse
#from urllib.request import urlopen
import urllib2
#import socket
#from socket import timeout
#import http.client
from bs4 import BeautifulSoup as BS
import sys
from _codecs import *
import codecs
import os
import csv
import re
import pandas
#import operator
#from selenium import webdriver
#from selenium.common.exceptions import TimeoutException

####### Scrape the industry, size, and sector of each employer from their job post URL ########
### STEP1: Extract all URLs to scrape from the input CSV 
data = pandas.read_csv('scrape.csv',sep='\t') # read the cvs file into python
sites = data.URL.tolist() # convert the column "URL" into a list in python


#STEP 2: for each URL in "sites", scrape the industry, size, and sector info and write them together with the URL into a new csv file 
with codecs.open("scrape.csv", "a", "utf-8-sig") as f: #open the csv and append new info at the end of all current columns (no overwrite)
    line = "industry, size, sector\n" 
    f.write(line)
    # Scraping Process Begin Below 
    for i in range(len(sites)): 
        url = sites[i]  #the URL to scrape
        page = urllib2.urlopen(url).read() #open the URL, read it through (page source)
        soup = BeautifulSoup(page, "html.parser") #parse the html file
        detail = soup.find_all("ul", class_= "company_detail clearfix")  #extract the section with industry, size, and sector info from page source
        info = re.findall('</strong><span>(.*)</span>',str(detail[0])) #extract industry, size, and sector info; need to turn "detail" (a list) into a string first
        if info != []: #if everything goes well, info should be a list of three, industry, size, sector
        	industry = info[0]
        	size = info[1]
        	sector = info[2]
        else:  #if cannot locate the industry, size or sector info - maybe the link is invalid now
            industry = "NA"
            size = "NA"
            sector = "NA"
        line = "%s,%s,%s\n" % (industry, size, sector)
        f.write(line)


	

 