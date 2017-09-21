#Python 2.7.8 (default, Jun 30 2014, 16:08:48) [MSC v.1500 64 bit (AMD64)] on win32
#Type "copyright", "credits" or "license()" for more information.

import arcpy
import os
import sys

#Finished "Albany", "Allegheny", "Atlanta", "Baltimore", "Boston", "Brooklyn", "Buffalo", "Charleston", "Chicago",
# "Cincinnati", "Cleveland", "Columbus", "Denver", "Detroit", "Hartford",
# "Indianapolis", "JerseyCity", "KansasCity", "Louisville", "Memphis", "Milwaukee",
# "Minneapolis", "Mobile", "Nashville", "New Orleans", "Newark", "Oakland", "Omaha",
# "Philadelphia", "Pittsburgh","Providence", "Richmond", "Rochester", "San Francisco","Washington"

#Check if 'Type' is in shapefile '_type.shp' for each city
to_add = ["seg_id", "Seg_ID", "SEG_ID", "SEGID", "segid"]

for name in ["Chicago", "Cleveland", "Columbus", "Denver", "Detroit", "Hartford",
             "Indianapolis", "JerseyCity", "KansasCity", "Louisville", "Memphis",
             "Minneapolis", "Nashville", "NewHaven", "NewOrleans", "Newark",
             "NYC_Bronx", "NYC_Manhattan", "Oakland", "Rochester", "St_Paul"]:
    print "Working On: " + name
    inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_join150_Points.shp"
    #inshape="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_join225_Points.shp"
    #Create List of Existing Field Names
    fieldList = arcpy.ListFields(inshape)
    fieldName = [f.name for f in fieldList]

    for field in to_add:
        if field in fieldName:
            print "Already exists"
        else:
            print "Does Not Exist"
