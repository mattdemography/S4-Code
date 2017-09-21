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

for name in ["New Haven"]:
    print "Working On: " + name + ".shp"
    Table="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_join225.shp"
    expression=("!name!" + '" "' + "!type!" + '" "' + "!prefix!")
    arcpy.DeleteField_management(Table, "NEWADDRESS")
    arcpy.AddField_management(Table, "NEWADDRESS", "TEXT", 100)
    arcpy.CalculateField_management(Table, "NEWADDRESS", expression, "PYTHON_9.3")
  
