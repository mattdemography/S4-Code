#Python 2.7.8 (default, Jun 30 2014, 16:08:48) [MSC v.1500 64 bit (AMD64)] on win32
#Type "copyright", "credits" or "license()" for more information.

import arcpy
import os
import sys

# Replace a layer/table view name with a path to a dataset (which can be a layer file) or create the layer/table view within the script
# The following inputs are layers or table views: "StLouis_1930_stgrid_Split", "StLouis_1930_stgrid_Split"
arcpy.SpatialJoin_analysis(target_features="StLouis_1930_stgrid_Split", join_features="StLouis_1930_stgrid_Split", out_feature_class="S:/Projects/1940Census/StLouis/GIS_edited/St Louis_1930_stgrid_edit_spatjoin2.shp", join_operation="JOIN_ONE_TO_MANY", join_type="KEEP_ALL", field_mapping="""FULLNAME "FULLNAME" true true false 80 Text 0 0 ,First,#,StLouis_1930_stgrid_Split,FULLNAME,-1,-1;FULLNAME_1 "FULLNAME_1" true true false 80 Text 0 0 ,First,#,StLouis_1930_stgrid_Split,FULLNAME,-1,-1""", match_option="INTERSECT", search_radius="", distance_field_name="")

