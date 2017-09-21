#Python 2.7.8 (default, Jun 30 2014, 16:08:48) [MSC v.1500 64 bit (AMD64)] on win32
#Type "copyright", "credits" or "license()" for more information.

import arcpy
import os
import sys

#Check if 'Type' is in shapefile '_type.shp' for each city
to_add = ["L_F_ADD", "L_f_add", "L_f_range", "L_F_RANGE"]

for name in ["Albany", "Allegheny", "Atlanta", "Baltimore", "Boston", "Brooklyn", "Buffalo", "Charleston", "Chicago",
            "Cincinnati", "Cleveland", "Columbus", "Denver", "Detroit", "Hartford",
            "Indianapolis", "JerseyCity", "KansasCity", "Louisville", "Memphis", "Milwaukee",
            "Minneapolis", "Mobile", "Nashville", "New Haven", "New Orleans", "Newark", "Oakland", "Omaha",
            "Philadelphia", "Pittsburgh","Providence", "Richmond", "Rochester", "San Francisco","Washington"]:
    print "Working On: " + name
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_dup.shp"
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
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\NYC_Bronx_dup.shp"
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
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\NYC_Manhattan_dup.shp"
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
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\St_Louis_dup.shp"
    #Create List of Existing Field Names
    fieldList = arcpy.ListFields(inshape)
    fieldName = [f.name for f in fieldList]

    for field in to_add:
        if field in fieldName:
            print "Already exists"
        else:
            print "Does Not Exist"

for name in ["St. Paul"]:
    print "Working On: " + name
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\St_Paul_dup.shp"
    #Create List of Existing Field Names
    fieldList = arcpy.ListFields(inshape)
    fieldName = [f.name for f in fieldList]

    for field in to_add:
        if field in fieldName:
            print "Already exists"
        else:
            print "Does Not Exist"
