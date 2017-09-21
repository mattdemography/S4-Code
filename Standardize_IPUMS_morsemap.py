# -*- coding: cp1252 -*-
import os
import re
import difflib

# Change directory to the new city folder:  
os.chdir('Z:\\S4\\Projects\\1940Census\\SanAntonio\\SanAntonio_working\\StataFiles_Other\\1930\\files for standardization')

#Logic:
# Match Street Names only
# Assign the direction and suffix based on the full street "phrases" in the ed
# But do this second part in Stata

# Original Data (created by "prep_text_files.do"): 
census = open('st_from_morsemap_street3.txt','r')
city = open('st_from_morsemap_wholecity.txt','r')
full = open('st_from_mosemap_fullname.txt','r')
ipums = open('st_from_ipums.txt','r')

# Outputted files: 
pairs2 = open('Standardized_IPUMS.txt', 'wt')

ilines = ipums.readlines()
ilines = ilines[1:]
print ilines[0:5]
edlines = census.readlines()
edlines = edlines[1:]
print edlines[0:5]
citylines = city.readlines()
citylines = citylines[1:]
print citylines[0:5]
fulllines = full.readlines()
fulllines = fulllines[1:]
print fulllines[0:5]

########################
########################

# Three step process:
# 1 - Match name within Ed
# 2 - Match name within city - replace ED match if excellent fit (>0.9)
# 3 - Match full phrase within name possibilities - take best fit with very low bar
# 4 - If no clear match, just take last one on the list? Longest length?

# Set up Pairs output, and empty lists
pair = "original;street3;match;highratio;bestEd;edratio;bestCity;cityratio;standardized;ed;withined;pratio\n"
pairs2.write(pair)

# Run through lines of the original Text
for iline in ilines:
    ed = re.sub(r'"(.*)";"(.*)";"(.*)"',r'\1', iline)
    ed = ed.strip()
    street = re.sub(r'"(.*)";"(.*)";"(.*)"',r'\2', iline)
    street = street.strip()
    original = re.sub(r'"(.*)";"(.*)";"(.*)"\n',r'\3', iline)     
    match = ""
    edratio1 = .58
    bestED = ""      
    edratio = 0
    highratio = 0
    withined = "1"
    # Compare each word to the words in the ED Street List
    # Keep the best fitting match, if the ratio is higher than ratio1
    # otherwise keep the original word
    for edline in edlines:
        ced = re.sub(r'"(.*)";"(.*)"',r'\1', edline)
        ced = ced.strip()
        edline = re.sub(r'"(.*)";"(.*)"',r'\2', edline)
        edline = edline.strip()
        if ed == ced:
            s = difflib.SequenceMatcher(None, street, edline)
            edratio2 = s.ratio()
            if edratio2 >= edratio: 
                bestED = edline
                edratio = edratio2
            if edratio2 >= edratio1:
                match = edline                     
                edratio1 = edratio2
        highratio = edratio
    # Compare each word to all street names in the city
    # if the match is excellent, keep that word
    # otherwise keep the ED match or the original word
    bestCity = ""  
    cityratio1 = .9
    cityratio = 0
    for cityline in citylines:
        cityline = re.sub(r'"',r'', cityline)
        cityline = re.sub(r'\n',r'', cityline)
        cityline = cityline.strip()
        s = difflib.SequenceMatcher(None, street, cityline)
        cityratio2 = s.ratio()
        if cityratio2 >= cityratio:
            bestCity = cityline
            cityratio = cityratio2
        if cityratio2 >= cityratio1 and cityratio2 > edratio:
            match = cityline
            highratio = cityratio
            withined = "0"
    # Compare full phrase to phrases in the ed with the same match name
    # pick the best fitting phrase
    pratio = 0
    standardized = ""
    for fullline in fulllines:
        ped = re.sub(r'"(.*)";"(.*)";"(.*)"',r'\1', fullline)
        ped = ped.strip()
        name = re.sub(r'"(.*)";"(.*)";"(.*)"',r'\2', fullline)
        name = name.strip()
        phrase = re.sub(r'"(.*)";"(.*)";"(.*)"\n',r'\3', fullline)
        if match == name and (ed == ped or withined == "0"):
            s = difflib.SequenceMatcher(None, original, phrase)
            pratio2 = s.ratio()
            if pratio2 > pratio: 
                standardized = phrase
                pratio = pratio2
    print "Original: " + original
    print "Standardized: " + standardized
    # Save the output:
    pair = original + ";" + street + ";" + match + ";" + str(highratio) + ";" + bestED + ";" + str(edratio) + ";" + bestCity + ";" + str(cityratio) + ";" + standardized + ";" + ed + ";" + withined + ";" + str(pratio) +"\n"
    pairs2.write(pair)   

pairs2.close()
census.close()
ipums.close()
city.close()
full.close()


