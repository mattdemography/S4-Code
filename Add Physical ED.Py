#Python 2.7.8 (default, Jun 30 2014, 16:08:48) [MSC v.1500 64 bit (AMD64)] on win32
#Type "copyright", "credits" or "license()" for more information.

import arcpy
import os
import sys

#FINISHED "Albany", "Allegheny", "Atlanta", "Baltimore", "Boston", "Brooklyn", "Buffalo", "Charleston",
# "Chicago", "Cincinnati", "Cleveland", "Columbus", "Denver", "Detroit", "Hartford",
# "Indianapolis", "JerseyCity", "KansasCity", "Louisville", "Memphis", "Milwaukee",
# "Minneapolis", "Mobile", "Nashville","New Haven", "New Orleans", "Newark", "Oakland", "Omaha",
# "Philadelphia", "Pittsburgh","Providence", "Richmond", "Rochester", "San Francisco", "Washington", "Indianapolis"

# overwrite output
#arcpy.env.overwriteOutput=False

for name in []:
    print "Working On: " + name + ".shp"
    target_features = "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_geocode_offst.shp"
    join_features = "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_edt.shp"
    out_name="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + name + "_newed_points.shp"
    arcpy.SpatialJoin_analysis(target_features, join_features, out_name, "JOIN_ONE_TO_MANY", "KEEP_ALL", "#", "INTERSECT")

####
#Do Manhattan and Bronx separate because of their text ' - '.  St. Louis and St. Paul because of text '.'
    #"NYC-Bronx", "NYC-Manhattan", "St. Louis", "St. Paul",

for name in ["NYC-Bronx"]:
    print "Working On: " + name + ".shp"
    target_features = "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "NYC_Bronx_geocode_offst.shp"
    join_features = "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "NYC_Bronx_edt.shp"
    out_name="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "NYC_Bronx_newed_points.shp"
    arcpy.SpatialJoin_analysis(target_features, join_features, out_name, "JOIN_ONE_TO_MANY", "KEEP_ALL", "#", "INTERSECT")

for name in ["NYC-Manhattan"]:
    print "Working On: " + name + ".shp"
    target_features = "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "NYC_Manhattan_geocode_offst.shp"
    join_features = "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "NYC_Manhattan_edt.shp"
    out_name="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "NYC_Manhattan_newed_points.shp"
    arcpy.SpatialJoin_analysis(target_features, join_features, out_name, "JOIN_ONE_TO_MANY", "KEEP_ALL", "#", "INTERSECT")

for name in ["St. Louis"]:
    print "Working On: " + name + ".shp"
    target_features = "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "St_Louis_geocode_offst.shp"
    join_features = "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "St_Louis_edt.shp"
    out_name="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "St_Louis_newed_points.shp"
    arcpy.SpatialJoin_analysis(target_features, join_features, out_name, "JOIN_ONE_TO_MANY", "KEEP_ALL", "#", "INTERSECT")

for name in ["St. Paul"]:
    print "Working On: " + name + ".shp"
    target_features = "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "St_Paul_geocode_offst.shp"
    join_features = "Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "St_Paul_edt.shp"
    out_name="Z:\Users\_Exchange\\1880 Stuff\AllCities\\" + name + "\\" + "St_Paul_newed_points.shp"
    arcpy.SpatialJoin_analysis(target_features, join_features, out_name, "JOIN_ONE_TO_MANY", "KEEP_ALL", "#", "INTERSECT")
