# -*- coding: cp1252 -*-

import os
import re
import difflib

os.chdir("X:\\S4\\Projects\\1940Census\\SanAntonio\\Textfile")


# Original Data: 
text = open('SanAntonio.txt','r')
lines=text.readlines()
print lines[0:5]
text.close()

# Outputted files: 
EDs = open('SanAntonio_ED_lines.txt', 'wt')
Tracts = open('SanAntonio_Tract_lines.txt', 'wt')
Blocks = open('SanAntonio_Block_lines.txt', 'wt')
Other = open('SanAntonio_excluded.txt', 'wt')


# Change thes inputs for each city: 
cityname = "San Antonio"
edprefix = "259-"

# Make changes based on ED prefix around line 54


## Add addional non-street name words in any ED:
constants = cityname + " city - That part of Area in"
constants = constants.rstrip()
constantwords = constants.split()

# Run through ED lines of the original Text
# Correct Spelling
# Print out just ED lines
EDtext = ""
Blocktext = ""
i = 0
for line in lines:
     EDline = ""
     Blockline = ""
     line = line.strip(' \t')
     # Create id number at the beginning of the line
     id = "(*"+str(i)+"*): "
     line = id + line
     line = re.sub("—", "-", line)
     line = re.sub("\^", "-", line)
     line = re.sub(" j ", " ", line)
     line = re.sub(" ! ", " ", line)
     line = re.sub(" | ", " ", line)
     # Edit these lines to capture potential misspellings of the ED prefix (63 for Albany)
     line = re.sub(".(9-\d+)", r'2\1', line)
     line = re.sub("2.(-\d+)", r'259\1', line)
     line = re.sub("(259-\d+) ([A-Z])\s", r'\1\2 ', line)     
     line = re.sub("(\(\*\d+\*\): ).*(259-\d+)", r'\1\2', line)  
     line = re.sub("pert", "part", line)     
     line = re.sub("(\d)-part", r'\1 - part', line)
     # for everyline, look for an ED number and either the city name, "city", "Tract", or "Ward"
     # Keep that ED number until it hits a new one
     if edprefix in line and ("Tract" in line or "city" in line or "Ward" in line or cityname in line):
          # Make a list of words in each line
          line=line.rstrip()
          line_spl = line.split()
          for word in line_spl:
               #print "word: " + word
               match = ""
               best = ""
               ratio1 = .55
               highratio = 0
               # Compare each word to the words in the ED Street List
               # Keep the best fitting match, if the ratio is higher than ratio1
               # otherwise keep the original word
               for streetword in constantwords:
                    s = difflib.SequenceMatcher(None, word, streetword)
                    ratio2 = s.ratio()
                    if ratio2 > ratio1:
                         match = streetword
                         ratio1 = ratio2
                    if ratio2 > highratio: 
                         best = streetword
                         highratio = ratio2
               if match == "":
                    match = word
               if re.search("\d", word) != None :
                    if highratio == 1.0: 
                         match = match   
                    else: 
                         match = word             
               #print "match: " + match 
               EDline = EDline + match + " "
          EDline = EDline + "\n"
     else:
          Blockline = line
              
     # Re-write the whole text with the new words
     EDtext = EDtext + EDline
     # Re-write the whole text with the new words
     Blocktext = Blocktext + Blockline
     i += 1
     
### Output the final set of new lines to a text file
EDtext = EDtext.split("\n")
for line in EDtext:
     line = line + "\n"
     EDs.write(line)
EDs.close()


#0 - separate id and text
#1 - get number - text formatted correctly
#2 - move that sequence to the beginning of the line once
#3 - find that sequence later on and make it a new line
#    What is the character number cut off for being a newline
#4 - move show separately to a new line if near the end
#5 - remove all show separately lines
#6 - put id and text back together

Blocktext = Blocktext.split("\n")
Blocklines = ""
for line1 in Blocktext:
     id = re.sub("(\(\*\d+\*\): )(.*)", r'\1', line1)
     line = re.sub("(\(\*\d+\*\): )(.*)", r'\2', line1)
     line = re.sub("\)", "",line)
     line = re.sub("\(", "",line)        
     line = re.sub("—", "-",line)
     line = re.sub("\t", " ", line)
     line = re.sub(" A..\." , " Ave.", line)
     line = re.sub(" A.\." , " Ave.", line)     
     line = re.sub(" _ ", " - ", line)
     line = re.sub(" » ", " - ", line)
     line = re.sub(" » ", " - ", line)     
     line = re.sub(" 8. ", " S. ", line)
     line = re.sub(" [HB]. ", " E. ", line)     
     line = re.sub(" [VY]. ", " W. ", line)
     line = re.sub(" [^0-9A-Za-z][VY7]. ", " W. ", line)
     line = re.sub(" [^0-9A-Za-z]{1,2}7. ", " W. ", line)     
     line = re.sub(" [V7f][V7f]. ", " W. ", line) 
     line = re.sub(" 7/. ", " W. ", line)
     line = re.sub("-7/. ", "-W. ", line)
     line = re.sub("(\d+)-([a-zA-Z])", r'\1 - \2',line)   
     line = re.sub(" \^( - [NESW]\. )", r' 7\1', line)
     line = re.sub(" [HK]( - [NESW]\. )", r' 4\1', line)
     line = re.sub("^[HK]( - [NESW]\. )", r' 4\1', line)      
     line = re.sub(" extended", " ", line)
     line = re.sub("[HBS]l[ou][oc]k", "Block", line)
     line = re.sub("^(.{1,15})Block", "Block",line)     
     line = re.sub("U( - [a-zA-Z])", r'11\1',line)
     line = re.sub("^.{1,20} (\d+) ([EWSN]\. .*)", r'\1 - \2',line)      
     line = re.sub(">", ",", line)
     line = re.sub("(\d+ - [a-zA-Z].*) (\d+ - [a-zA-Z].*)", r'\1\n'+id+r'\2',line)
     line = re.sub("^(.{1,20}) (\d+ - [a-zA-Z])", r'\2',line)
     line = re.sub("^([^1-9]{1,2})(\d+ - [a-zA-Z])", r'\2',line)
     line = re.sub("(.*)( excluding.*)",r'\1\n\2', line)
     line = re.sub("([ -][Ss][hn]ow\s)"," Show ", line)     
     line = re.sub("(.*)( Show.*)",r'\1\n\2', line)
     line = re.sub("(.*)( \d+ - [A-Za-z].*)",r'\1\n\2', line)     
     line1 = id + line + "\n"
     Blocklines = Blocklines + line1

Blocklines = Blocklines.split("\n")
i = 0
j = 1
while j < len(Blocklines):
     line1 = Blocklines[i]
     print line1
     id = re.sub("(\(\*\d+\*\): )(.*)", r'\1', line1)
     line = re.sub("(\(\*\d+\*\): )(.*)", r'\2', line1)
     id = id.rstrip()
     line = line.rstrip()
     line = line.lower()
     s1 = difflib.SequenceMatcher(None, line[0:15], "show separately")
     s2 = difflib.SequenceMatcher(None, line[0:10], "excluding")
     s3 = difflib.SequenceMatcher(None, line[0:5], "show")     
     line1 = line1 + "\n"
     line3 = ""
     if s1.ratio() > .7 or s2.ratio() > .7 or s3.ratio() > .7:
          line3 = line1
          line1 = ""
          j = i + 1
          line2 = Blocklines[j]
          while re.match("^\d", line2) == None and re.match("^Block", line2) and j < (len(Blocklines)-1):
               line3 = line3 + line2
               j += 1
               line2 = Blocklines[j]
     if "Block" in line1[25:]:
          line1 = ""
     if "Show" in line1[10:]:
          line3 = line1
          line1 = ""
     if "Apartment" in line1:
          line3 = line1          
          line1 = ""
     if "Hotel" in line1:
          line3 = line1
          line1 = ""          
     if "Hospital" in line1:
          line3 = line1
          line1 = ""
     if "Enumeration" in line1:
          line1 = ""
     if "Description" in line1:
          line1 = ""
     if "District" in line1:
          line1 = ""           
     if "Census" in line1:
          line1 = ""
     Blocks.write(line1)
     if line3 != "":
          Other.write(line3)
     i = j
     j += 1 
     
Blocks.close()



