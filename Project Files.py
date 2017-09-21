#Python 2.7.8 (default, Jun 30 2014, 16:08:48) [MSC v.1500 64 bit (AMD64)] on win32
#Type "copyright", "credits" or "license()" for more information.

import arcpy
import os
import sys

#Finished "Albany", "Allegheny", "Atlanta", "Baltimore", "Boston", "Brooklyn", "Buffalo", "Charleston",
# "Chicago", "Cincinnati", "Cleveland", "Columbus", "Denver", "Detroit", "Hartford",
# "Indianapolis", "JerseyCity", "KansasCity", "Louisville", "Memphis", "Milwaukee",
# "Minneapolis", "Mobile", "Nashville","New Haven", "New Orleans", "Newark", "Oakland", "Omaha",
# "Philadelphia", "Pittsburgh","Providence", "Richmond", "Rochester", "San Francisco","Washington", 
#Set Workspace

for name in ["Pittsburgh"]:
    print "Working On: " + name + ".shp"
    in_data="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_dup.shp"
    out_data="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_dup_project_new.shp"
    #out_coordinate=arcpy.SpatialReference('USA_Contiguous_Albers_Equal_Area_Conic')
    out_coordinate=arcpy.SpatialReference(102003)
    arcpy.Project_management(in_data, out_data, out_coordinate)
    
    
  
