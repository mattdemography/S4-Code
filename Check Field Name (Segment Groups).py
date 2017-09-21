#Python 2.7.8 (default, Jun 30 2014, 16:08:48) [MSC v.1500 64 bit (AMD64)] on win32
#Type "copyright", "credits" or "license()" for more information.

import arcpy
import os
import sys

#Finished
# 

#Check if 'Type' is in shapefile '_type.shp' for each city
to_add = ["hexid225", "HEXID225", "hex225", "HEX225"]


for name in [ "Albany", "Allegheny", "Atlanta", "Baltimore", "Boston", "Brooklyn", "Buffalo", "Charleston",
"Chicago", "Cincinnati", "Cleveland", "Columbus", "Denver", "Detroit", "Hartford",
"Indianapolis", "JerseyCity", "KansasCity", "Louisville", "Memphis", "Milwaukee",
"Minneapolis", "Mobile", "Nashville","New Haven", "New Orleans", "Newark", "Oakland", "Omaha",
"Philadelphia", "Pittsburgh","Providence", "Richmond", "Rochester", "San Francisco","Washington", "San Francisco"]:
    print "Working On: " + name
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_join225.shp"
    #Create List of Existing Field Names
    fieldList = arcpy.ListFields(inshape)
    fieldName = [f.name for f in fieldList]

    for field in to_add:
        if field in fieldName:
            print "Already exists"
        else:
            print "Does Not Exist"

for name in ["NYC-Bronx"]:
    print "Working On: " + name
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\NYC_Bronx_join225.shp"
    #Create List of Existing Field Names
    fieldList = arcpy.ListFields(inshape)
    fieldName = [f.name for f in fieldList]

    for field in to_add:
        if field in fieldName:
            print "Already exists"
        else:
            print "Does Not Exist"

for name in ["NYC-Manhattan"]:
    print "Working On: " + name
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\NYC_Manhattan_join225.shp"
    #Create List of Existing Field Names
    fieldList = arcpy.ListFields(inshape)
    fieldName = [f.name for f in fieldList]

    for field in to_add:
        if field in fieldName:
            print "Already exists"
        else:
            print "Does Not Exist"

for name in ["St. Louis"]:
    print "Working On: " + name
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\St_Louis_join225.shp"
    #Create List of Existing Field Names
    fieldList = arcpy.ListFields(inshape)
    fieldName = [f.name for f in fieldList]

    for field in to_add:
        if field in fieldName:
            print "Already exists"
        else:
            print "Does Not Exist"
