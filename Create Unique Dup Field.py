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

for name in []:
    print "Working On: " + name + ".shp"
    Dup="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_dup.shp"
    arcpy.Copy_management(Dup, "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_dup_name.shp")
    Table="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_dup_name.shp"
    expression="!FID! + 1"
    arcpy.AddField_management(Table, "dup_id", "LONG", 4, "", "","", "", "")
    arcpy.CalculateField_management(Table, "dup_id", expression, "PYTHON_9.3")
   
####
#Do Manhattan and Bronx separate because of their text ' - '.  St. Louis and St. Paul because of text '.'
    #"NYC-Bronx", "NYC-Manhattan", "St. Louis", "St. Paul",

for name in ["NYC-Bronx"]:
    print "Working On: " + name + ".shp"
    Dup="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "NYC_Bronx_dup.shp"
    arcpy.Copy_management(Dup, "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "NYC_Bronx_dup_name.shp")
    Table="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "NYC_Bronx_dup_name.shp"
    expression="!FID! + 1"
    arcpy.AddField_management(Table, "dup_id", "LONG", 4, "", "","", "", "")
    arcpy.CalculateField_management(Table, "dup_id", expression, "PYTHON_9.3")
   
for name in ["NYC-Manhattan"]:
    print "Working On: " + name + ".shp"
    Dup="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "NYC_Manhattan_dup.shp"
    arcpy.Copy_management(Dup, "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "NYC_Manhattan_dup_name.shp")
    Table="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "NYC_Manhattan_dup_name.shp"
    expression="!FID! + 1"
    arcpy.AddField_management(Table, "dup_id", "LONG", 4, "", "","", "", "")
    arcpy.CalculateField_management(Table, "dup_id", expression, "PYTHON_9.3")
    
for name in ["St. Louis"]:
    print "Working On: " + name + ".shp"
    Dup="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "St_Louis_dup.shp"
    arcpy.Copy_management(Dup, "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "St_Louis_dup_name.shp")
    Table="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "St_Louis_dup_name.shp"
    expression="!FID! + 1"
    arcpy.AddField_management(Table, "dup_id", "LONG", 4, "", "","", "", "")
    arcpy.CalculateField_management(Table, "dup_id", expression, "PYTHON_9.3")

for name in ["St. Paul"]:
    print "Working On: " + name + ".shp"
    Dup="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "St_Paul_dup.shp"
    arcpy.Copy_management(Dup, "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "St_Paul_dup_name.shp")
    Table="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "St_Paul_dup_name.shp"
    expression="!FID! + 1"
    arcpy.AddField_management(Table, "dup_id", "LONG", 4, "", "","", "", "")
    arcpy.CalculateField_management(Table, "dup_id", expression, "PYTHON_9.3")


    
