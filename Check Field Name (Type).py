#Python 2.7.8 (default, Jun 30 2014, 16:08:48) [MSC v.1500 64 bit (AMD64)] on win32
#Type "copyright", "credits" or "license()" for more information.

import arcpy
import os
import sys

#Check if 'Type' is in shapefile '_type.shp' for each city
#"street_new", "STREET_NEW", "Streetnew",

to_add = [ "full_name", "FULL_NAME", "Full_name", "Full_Name"]

#"Albany", "Baltimore", "Buffalo", "Cincinnati", "Detroit", "Hartford", "New Haven", "Newark"

for name in ["Albany", "Baltimore", "Buffalo", "Cincinnati", "Detroit", "Hartford", "New Haven", "Newark"]:
    print "Working On: " + name
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_type.shp"
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
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\NYC_Manhattan_type.shp"
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
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\NYC_Bronx_type.shp"
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
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\St_Louis_type.shp"
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
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\St_Paul_type.shp"
    #Create List of Existing Field Names
    fieldList = arcpy.ListFields(inshape)
    fieldName = [f.name for f in fieldList]

    for field in to_add:
        if field in fieldName:
            print "Already exists"
        else:
            print "Does Not Exist"
