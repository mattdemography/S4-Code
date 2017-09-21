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

for name in ["Hartford", "Nashville","Oakland", "Omaha"]:
    print "Working On: " + name + ".shp"
    Table="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_dup_name.shp"
    expression="!FETYPE!"
    arcpy.AddField_management(Table, "TYPE", "TEXT", field_length=50)
    arcpy.CalculateField_management(Table, "TYPE", expression, "PYTHON_9.3")
