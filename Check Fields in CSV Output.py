#Python 2.7.8 (default, Jun 30 2014, 16:08:48) [MSC v.1500 64 bit (AMD64)] on win32
#Type "copyright", "credits" or "license()" for more information.

import arcpy
import os
import sys

#Check if 'Type' is in shapefile '_type.shp' for each city
#names = ["bpldet", "fbpldtus", "mbpldtus"]
names = ["fbp", "mbp"]

for name in ["Albany", "Allegheny", "Atlanta", "Baltimore", "Boston", "Brooklyn", "Buffalo", "Charleston",
 "Chicago", "Cincinnati", "Cleveland", "Columbus", "Denver", "Detroit", "Hartford",
 "Indianapolis", "JerseyCity", "KansasCity", "Louisville", "Memphis",
 "Minneapolis", "Mobile", "Nashville","NewHaven", "NewOrleans", "Newark", "NYC_Bronx", "NYC_Manhattan",
 "Oakland", "Omaha", "Philadelphia", "Pittsburgh","Providence", "Richmond", "Rochester", "San Francisco",
 "St_Louis", "St_Paul", "Washington", "Milwaukee"]:
    print "Working On: " + name
    infile="Z:\Projects\\Preparing 1880 Files\\" + name + "\Match Address\\" + name + "_BenResult.csv"
    #Create List of Existing Field Names
    fieldList = arcpy.ListFields(infile)
    fieldName = [f.name for f in fieldList]

    for field in names:
        if field in fieldName:
            print "Already exists"
        else:
            print "Does Not Exist"
