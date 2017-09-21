# -*- coding: cp1252 -*-
import os
import re
import difflib

# Change directory to the new city folder:  
os.chdir('Z:\\S4\\Projects\\1940Census\\SanAntonio\\Textfile')

# Original Data (created with prep_text_files.do): 
morse = open('st_from_morse_1940.txt','r')
census = open('st_from_map_2012.txt','r')

# Outputted files: 
pairs2 = open('Standard_St_List.txt', 'wt')

mlines = morse.readlines()
mlines = mlines[1:]
print mlines[0:5]
clines = census.readlines()
clines = clines[1:]
print clines[0:5]

########################
########################
         
# Match Each Morse Street Phrase with the closest Census Street Phrase:
#   only match within tracts
#   split line by ; - first item is the tract # and the second is the street

# Set up Pairs output, and empty lists
pair = "word;match;best;highratio\n"
pairs2.write(pair)

# Run through lines of the original Text
for mline in mlines:
         mline = mline.rstrip()
#         tract = re.sub(r'(^\d*);"(.*)"',r'\1', mline)
         mline = re.sub(r'"(.*)"',r'\1', mline)
         print "Street: " + mline       
         match = ""
         best = ""
         ratio1 = .8
         highratio = 0
         # Compare each word to the words in the ED Street List
         # Keep the best fitting match, if the ratio is higher than ratio1
         # otherwise keep the original word
         for cline in clines:
                  cline = cline.rstrip()
#                  ctract = re.sub(r'(^\d+);"(.*)"',r'\1', cline)
                  cline = re.sub(r'"(.*)"',r'\1', cline)
#                  if tract == ctract:
                  s = difflib.SequenceMatcher(None, mline, cline)
                  ratio2 = s.ratio()
                  if ratio2 > ratio1:
                        match = cline
                        ratio1 = ratio2
                  if ratio2 > highratio: 
                        best = cline
                        highratio = ratio2
         print "Match: " + match
         # Save the original word, the final match, best match, and the highest ratio
         pair = mline + "; " + match + "; " + best + "; " + str(highratio) + "; " + "\n"
         pairs2.write(pair)   

pairs2.close()
morse.close()
census.close()


