#Python 2.7.8 (default, Jun 30 2014, 16:08:48) [MSC v.1500 64 bit (AMD64)] on win32
#Type "copyright", "credits" or "license()" for more information.

import arcpy
import os
import sys

#Finished "Albany", "Allegheny", "Atlanta", "Baltimore", "Boston", "Brooklyn", "Buffalo", "Charleston",
# "Chicago", "Cincinnati", "Cleveland", "Columbus", "Denver", "Detroit", "Hartford",
# "Indianapolis", "JerseyCity", "KansasCity", "Louisville", "Memphis",
# "Minneapolis", "Mobile", "Nashville","NewHaven", "NewOrleans", "Newark", "NYC_Bronx", "NYC_Manhattan",
# "Oakland", "Omaha", "Philadelphia", "Pittsburgh","Providence", "Richmond", "Rochester", "San Francisco",
# "St_Louis", "St_Paul", "Washington"

#Needs Work - Chicago (SG, EX)

#Check if 'Type' is in shapefile '_type.shp' for each city
for name in ["Allegheny", "Atlanta", "Baltimore","Buffalo", "Boston", "Brooklyn", "Charleston", "Cincinnati" ]:
    print "Working On: " + name

    SG= "Z:\Users\\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + \\"_point_seggr.shp"
    expression_segid="!segid!"
    arcpy.AddField_management(SG, "seg_id", "TEXT", "", "", "","", "", "")
    arcpy.CalculateField_management(SG, "seg_id", expression, "PYTHON_9.3")

for name in ["Chicago", "Cleveland", "Columbus", "Denver", "Detroit", "Hartford",
             "Indianapolis", "JerseyCity", "KansasCity", "Louisville", "Memphis",
             "Minneapolis", "Nashville", "NewHaven", "NewOrleans", "Newark",
             "NYC_Bronx", "NYC_Manhattan", "Oakland", "Rochester", "St_Paul"]:
    print "Working On: " + name

    SG= "Z:\Users\\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + \\"_join150_Points.shp"
    Ex= "Z:\Users\\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + \\"_join225_Points.shp"
    expression_segid="!segid!"
    arcpy.AddField_management(SG, "seg_id", "TEXT", "", "", "","", "", "")
    arcpy.CalculateField_management(SG, "seg_id", expression, "PYTHON_9.3")
    arcpy.AddField_management(Ex, "seg_id", "TEXT", "", "", "","", "", "")
    arcpy.CalculateField_management(Ex, "seg_id", expression, "PYTHON_9.3")

for name in ["Milwaukee", "Mobile", "Omaha", "Philadelphia", "St_louis", "Washington"]:
    print "Working On: " + name

    SG= "Z:\Users\\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + \\"_Points.shp"
    Ex= "Z:\Users\\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + \\"_join225_Points.shp"
    expression_segid="!segid!"

    arcpy.AddField_management(SG, "seg_id", "TEXT", "", "", "","", "", "")
    arcpy.CalculateField_management(SG, "seg_id", expression, "PYTHON_9.3")

for name in ["Pittsburgh", "Providence", "Richmond"]:
    print "Working On: " + name

    SG= "Z:\Users\\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + \\"_Segment_Points.shp"
    Ex= "Z:\Users\\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + \\"_join225_Points.shp"
    expression_segid="!segid!"

    arcpy.AddField_management(SG, "seg_id", "TEXT", "", "", "","", "", "")
    arcpy.CalculateField_management(SG, "seg_id", expression, "PYTHON_9.3")

for name in ["San Francisco"]:
    print "Working On: " + name

    SG= "Z:\Users\\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + \\"_Points.shp"
    expression_segid="!segid!"
    arcpy.AddField_management(SG, "seg_id", "TEXT", "", "", "","", "", "")
    arcpy.CalculateField_management(SG, "seg_id", expression, "PYTHON_9.3")
