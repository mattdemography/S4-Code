#Python 2.7.8 (default, Jun 30 2014, 16:08:48) [MSC v.1500 64 bit (AMD64)] on win32
#Type "copyright", "credits" or "license()" for more information.

import arcpy
import os
import sys

# FINISHED "Albany", "Allegheny", "Atlanta", "Baltimore", "Boston", "Brooklyn", "Buffalo", "Charleston",
# "Chicago", "Cincinnati", "Cleveland", "Columbus", "Denver", "Detroit", "Hartford",
# "Indianapolis", "JerseyCity", "KansasCity", "Louisville", "Memphis",
# "Minneapolis", "Mobile", "Nashville","NewHaven", "NewOrleans", "Newark", "NYC_Bronx", "NYC_Manhattan",
# "Oakland", "Omaha", "Philadelphia", "Pittsburgh","Providence", "Richmond", "Rochester", "San Francisco",
# "St_Louis", "St_Paul", "Washington", 

# NEEDS WORKD  "Milwaukee"

# overwrite output
arcpy.env.overwriteOutput=True

for name in ["Milwaukee"]:
    print "Working On: " + name + ".shp"
    target_features = "Z:\Projects\\Preparing 1880 Files\\" + name + "\Street Grid Without Ranges\\" + name + "_StreetGrid.shp"
    join_features = "Z:\Projects\\Preparing 1880 Files\\" + name + "\Street Grid Without Ranges\\" + name + "_StreetGrid.shp"    
    SegGr_grid = "Z:\Projects\\Preparing 1880 Files\\" + name + "\Segment Groups\\" + name + "_SegGr.shp"           # This is Segment Group File
    SegGr_grid_c = "Z:\Projects\\Preparing 1880 Files\\" + name + "\Segment Groups\\"  + name + "_SegGr_c.shp"
    ExtSegGr_grid = "Z:\Projects\\Preparing 1880 Files\\" + name + "\Segment Groups\\"  + name + "_ExtSegGr.shp"     # This is Extented Segment Group File
    expression_Seg_ID="!FID!"
    expression_SegGr="!JOIN_FID!"
    expression_Join_1="!JOIN_FID! + 1"
    expression_Target_1="!TARGET_FID! + 1"
    expression_ExtSegGr="\"{}{}\".format(!TARGET_FID!, !JOIN_FID!)"
    expression_Out_Join_2="\"{}{}\".format(!JOIN_FID!, !SegGrID_1!)"
    expression_Final="!SegGrID_1!"
    Out_Join= "Z:\Projects\\Preparing 1880 Files\\" + name + "\Segment Groups\\"  + name + "_Join.shp"
    Out_Join_2= "Z:\Projects\\Preparing 1880 Files\\" + name + "\Segment Groups\\"  + name + "_Join_2.shp"
    Out_Join_2_c= "Z:\Projects\\Preparing 1880 Files\\" + name + "\Segment Groups\\"  + name + "_Join_2_c.shp"
    Out_Join_2_Layer= "Z:\Projects\\Preparing 1880 Files\\" + name + "\Segment Groups\\" + name + "_Out_Join_2.lyr"
    
    #Create a list of fields so that they are maintained throughout the join and creating new shapefile procedure
    arcpy.env.qualifiedFieldNames = False
    fieldinfo= arcpy.FieldInfo()
    fieldmappings = arcpy.FieldMappings()

    #### STEP 1 #### - Overlapping Segment Groups
    #Join the segment shapefile to itself by 'intersect'
    arcpy.SpatialJoin_analysis(target_features, join_features, Out_Join, "JOIN_ONE_TO_MANY", "KEEP_ALL", fieldmappings, "INTERSECT")
    #Add 1 to Join FID and Target FID in the Out_Join to match with segment id in StreetGrid File
    arcpy.CalculateField_management(Out_Join, "TARGET_FID", expression_Target_1, "PYTHON_9.3")
    arcpy.CalculateField_management(Out_Join, "JOIN_FID", expression_Join_1, "PYTHON_9.3")
    #Add Field Name called "UniqID" to result in Step 1
    arcpy.AddField_management(Out_Join, "UniqID", "TEXT", "", "", "","", "", "")
    arcpy.CalculateField_management(Out_Join, "UniqID", expression_ExtSegGr, "PYTHON_9.3")
    #Disolve by JOIN_FID
    arcpy.Dissolve_management(Out_Join, SegGr_grid, "JOIN_FID")
    #Grab fields from newly created segment group file
    fields= arcpy.ListFields(SegGr_grid)
    #Add Field Name "SegGrID=JOIN_FID"
    arcpy.AddField_management(SegGr_grid, "SegGrID", "LONG", "", "", "","", "", "")
    arcpy.CalculateField_management(SegGr_grid, "SegGrID", expression_SegGr, "PYTHON_9.3")

    print "Finished:" + name + "SegGr_grid.shp"

    #### STEP 2 #### - Overlapping Extended Segment Groups
    #Create New Shapefile to Join to Itself
    arcpy.CopyFeatures_management(SegGr_grid, SegGr_grid_c)
    #Join SegGr shapefile to itself by 'intersect'
    arcpy.SpatialJoin_analysis(SegGr_grid, SegGr_grid_c, Out_Join_2, "JOIN_ONE_TO_MANY", "KEEP_ALL", "#", "INTERSECT")
    #Add Field Name called "UniqID"
    arcpy.AddField_management(Out_Join_2, "UniqID", "TEXT", "", "", "","", "", "")
    arcpy.CalculateField_management(Out_Join_2, "UniqID", expression_Out_Join_2, "PYTHON_9.3")
   
    print "Starting SegGr to SegGr Join Procedure"
    
    ### Join SegGr shapefile to Out_Join_2 by 'UniqID' - Keep Only Mattching Records ###
    #Make Feature Layer to use for Join procedure
    arcpy.MakeFeatureLayer_management(Out_Join_2, Out_Join_2_Layer, "", "", fieldinfo)
    #Join table to layer
    arcpy.AddJoin_management(Out_Join_2_Layer, "UniqID", Out_Join, "UniqID", "KEEP_COMMON")
    #Create new shapefile to be used in Dissolve Procedure
    arcpy.CopyFeatures_management(Out_Join_2_Layer, Out_Join_2_c)

    print "Starting Dissolve Procedure"
    
    #Dissolve Join Result
    arcpy.Dissolve_management(Out_Join_2_c, ExtSegGr_grid, "SegGrID_1")
    #Add Field Name "ExtSegGrID = SegGrID_1"
    arcpy.AddField_management(ExtSegGr_grid, "ExtSegGrID", "LONG", "", "", "","", "", "")
    arcpy.CalculateField_management(ExtSegGr_grid, "ExtSegGrID", expression_Final, "PYTHON_9.3")

    #Delete Unecessary Files
    #arcpy.Delete_management(Out_Join)
    arcpy.Delete_management(Out_Join_2_c)
    arcpy.Delete_management(SegGr_grid_c)
    arcpy.Delete_management(Out_Join_2_Layer)
    #arcpy.Delete_management(Out_Join_2)  
    
    print "Finished: " + name + "ExSegGr.shp"

