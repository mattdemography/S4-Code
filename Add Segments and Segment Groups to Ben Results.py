#Python 2.7.8 (default, Jun 30 2014, 16:08:48) [MSC v.1500 64 bit (AMD64)] on win32
#Type "copyright", "credits" or "license()" for more information.

import arcpy
import os
import sys

#Set Workspace

#FINISHED "Albany"

# overwrite output
arcpy.env.overwriteOutput=True

for name in ["Allegheny", "Atlanta", "Baltimore", "Boston", "Brooklyn", "Buffalo", "Charleston",
"Chicago", "Cincinnati", "Cleveland", "Columbus", "Denver", "Detroit", "Hartford",
"Indianapolis", "JerseyCity", "KansasCity", "Louisville", "Memphis", "Milwaukee",
"Minneapolis", "Mobile", "Nashville","NewHaven", "NewOrleans", "Newark", "NYC_Bronx", "NYC_Manhattan",
"Oakland", "Omaha", "Philadelphia", "Pittsburgh","Providence", "Richmond", "Rochester", "San Francisco",
"St_Louis", "St_Paul", "Washington", "Indianapolis"]:
    print "Working On: " + name + ".shp"
    target_features = "Z:\Projects\Preparing 1880 Files\Ben Results\\" + name + "\\" + name + "_OnStreet_Geocode_4_24_17.shp"
    join_features = "Z:\Projects\Preparing 1880 Files\\" + name + "\Street Grid Without Ranges\\" + name + "_StreetGrid.shp"
    out_name= "Z:\Projects\Preparing 1880 Files\\" + name + "\Match Address\\" + name + "_OnStreet_BenResult.shp"
    off_name= "Z:\Projects\Preparing 1880 Files\Ben Results\\" + name + "\\" + name + "_OffStreet_Geocode_4_24_17.shp"
    copied_name= "Z:\Projects\Preparing 1880 Files\\" + name + "\Off Street\\" + name + "_OffStreet_BenResult.shp"
    arcpy.SpatialJoin_analysis(target_features, join_features, out_name, "JOIN_ONE_TO_MANY", "KEEP_ALL", "#", "INTERSECT")

    #Copy Ben Results to Previous Folder
    arcpy.CopyFeatures_management(off_name, copied_name)

