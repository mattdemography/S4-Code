import urllib
import os
import re

# change the path
os.chdir("Z:\\S4\\Projects\\1940Census\\SanAntonio\\Textfile")


#reading the source text from the webpage
#change the URL
url = r"http://stevemorse.org/census/1940cities/satx.htm"

url_handle = urllib.urlopen(url)
sourcetext = url_handle.readlines()
url_handle.close()

# editing the sourcetext
# change the text file name 
ed_street_Flint = open('ed_street_SanAntonio.txt', 'wt')

columns = "ED" + "," + "stname" + "\n"
col_line = ""

#change the parsing strings if necessary
start_num = "value=" 
end_num = ">"
end_name = "</option>"

for line in sourcetext:
    if start_num in line and end_name in line:
        if "Select Street" in line:
            col_line = ""
        else:
            streetname = line [line.find(end_num)+1:line.find(end_name)]
            streetnum_str = line [line.find(start_num) + 7 : line.find(end_num)-1]
            i = 0
            while i < len(streetnum_str.split(",")):
                streetnum = streetnum_str.split(",")[i]
                col_line = streetnum + "," + streetname
                i = i + 1
                columns = columns + col_line + "\n"
                print col_line

# revise the file name                
ed_street_Flint.write(columns)
ed_street_Flint.close()




