*http://interactive.ancestry.com/6224/4660954_00102
*2/23
*Using reference file:
*Creating empty variables
gen stname_flag = ""
gen checked_st=""
gen checked_hn=""

*create dummy variables
gen inst = 0
replace inst=1 if institution!=""
gen nonstreet = 0

*create extra variables to work with
gen st= street_precleanedhn
gen st_edit=street_precleanedhn
gen ed_edit=ed
gen hn_edit=hn
gen block_edit=block
gen institution_edit=institution

*Start cleaning
*Apartments on S Laredo St
browse if clean_priority==1 & street_raw=="SOUTH LAREDO STREET"
replace hn_flag=hn_raw if clean_priority==1 & street_raw=="SOUTH LAREDO STREET"
replace hn_edit=212 if clean_priority==1 & street_raw=="SOUTH LAREDO STREET" & image_id=="4547939_00527"
replace hn_edit=216 if clean_priority==1 & street_raw=="SOUTH LAREDO STREET" & image_id!="4547939_00527"
replace checked_st="c" if clean_priority==1 & street_raw=="SOUTH LAREDO STREET"
replace checked_hn="c, multi-unit" if clean_priority==1 & street_raw=="SOUTH LAREDO STREET"

*Cellovos missing from SM, similar to Cevallos
browse if clean_priority==1 & street_raw=="W CELLOVOS"
replace checked_st="c, ancestry match, SM missing" if clean_priority==1 & street_raw=="W CELLOVOS"
replace stname_flag="Cevallos St" if clean_priority==1 & street_raw=="W CELLOVOS"
replace checked_hn="c" if clean_priority==1 & street_raw=="W CELLOVOS"

*St Francis St in Ancestry but St Francis Ave in SM
browse if clean_priority==1 & street_raw=="ST FRANCIS STREET"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==1 & street_raw=="ST FRANCIS STREET"
replace stname_flag="St Francis Ave" if clean_priority==1 & street_raw=="ST FRANCIS STREET"
replace checked_hn="c" if clean_priority==1 & street_raw=="ST FRANCIS STREET"

*Changed Forrest to Forrest Ave
browse if clean_priority==1 & street_raw=="FORREST"
replace st_edit="Forrest Ave" if clean_priority==1 & street_raw=="FORREST"
replace checked_st="c" if clean_priority==1 & street_raw=="FORREST"
replace checked_hn="c" if clean_priority==1 & street_raw=="FORREST"
*Manually changed hn_edit from 122 to 118 

*Changed Cass to Cass Ave
browse if clean_priority==1 & street_raw=="CASS"
replace hn_edit=305 if clean_priority==1 & street_raw=="CASS" & hn==205
replace st_edit="Cass Ave" if clean_priority==1 & street_raw=="CASS"
replace checked_st="c" if clean_priority==1 & street_raw=="CASS"
replace checked_hn="c" if clean_priority==1 & street_raw=="CASS"

*W Baylor in Ancestry, but Baylor St in SM
browse if clean_priority==1 & street_raw=="W BAYLOR"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==1 & street_raw=="W BAYLOR"
replace stname_flag="Baylor St" if clean_priority==1 & street_raw=="W BAYLOR"
replace checked_hn="c" if clean_priority==1 & street_raw=="W BAYLOR"

*Walton Ave in Ancestry, but Walton St in SM
browse if clean_priority==1 & street_raw=="WALTON AVENUE"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==1 & street_raw=="WALTON AVENUE"
replace stname_flag="Walton St" if clean_priority==1 & street_raw=="WALTON AVENUE"
replace hn_flag=hn_raw if clean_priority==1 & street_raw=="WALTON AVENUE" & hn_raw=="F2"
replace hn_edit=307 if clean_priority==1 & street_raw=="WALTON AVENUE" & hn_raw=="F2"
*manually typed in hn_edit = 250
replace checked_hn="c" if clean_priority==1 & street_raw=="WALTON AVENUE"

*San Fernando in Ancestry, but San Fernando St in SM
browse if clean_priority==1 & street_raw=="SAN FERNANDO"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==1 & street_raw=="SAN FERNANDO"
replace stname_flag="San Fernando St" if clean_priority==1 & street_raw=="SAN FERNANDO"
replace hn_edit=125 if clean_priority==1 & street_raw=="SAN FERNANDO" & hn==25
replace stname_flag="S Pecos St" if clean_priority==1 & street_raw=="SAN FERNANDO" & hn==704
replace st_edit="S Pecos" if clean_priority==1 & street_raw=="SAN FERNANDO" & hn==704
*Manually changed hn_edit to 1
replace hn_flag="1 rear" if clean_priority==1 & street_raw=="SAN FERNANDO" & hn_edit==1
replace hn_flag="2 rear" if clean_priority==1 & street_raw=="SAN FERNANDO" & hn_edit==2
*Manually changed hn_edit to 29
replace checked_hn="c" if clean_priority==1 & street_raw=="SAN FERNANDO"

*Corrall in Ancestry but missing in SM
browse if clean_priority==1 & street_raw=="CORRALL"
replace checked_st="c, ancestry match, SM missing" if clean_priority==1 & street_raw=="CORRALL"
replace st_edit="S Frio St" if clean_priority==1 & street_raw=="CORRALL" & image_id=="4547940_00418" & line_num<96
replace checked_st="c" if clean_priority==1 & street_raw=="CORRALL" & st_edit=="S Frio St"
replace checked_hn="c" if clean_priority==1 & street_raw=="CORRALL"

*Looks like Comal St. SM has S Comal St in same ED
browse if clean_priority==1 & street_raw=="CORNAL ST"
replace hn_edit=901 if clean_priority==1 & street_raw=="CORNAL ST" & hn==801
replace st_edit="Comal St" if clean_priority==1 & street_raw=="CORNAL ST"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==1 & street_raw=="CORNAL ST"
replace stname_flag="S Comal St" if clean_priority==1 & street_raw=="CORNAL ST"
replace checked_hn="c" if clean_priority==1 & street_raw=="CORNAL ST"

*San Diego in Ancestry, but missing in SM
browse if clean_priority==1 & street_raw=="SAN DIEGO"
replace checked_st="c, ancestry match, SM missing" if clean_priority==1 & street_raw=="SAN DIEGO"
replace hn_edit=405 if clean_priority==1 & street_raw=="SAN DIEGO" & hn==105
replace checked_hn="c" if clean_priority==1 & street_raw=="SAN DIEGO"

*Chihauhau on Ancestry; SM has similar Chihuahua St
browse if clean_priority==1 & street_raw=="CHIHAUHAU"
replace hn_edit=1212 if clean_priority==1 & street_raw=="CHIHAUHAU"  & hn==1217
replace st_edit="San Carlos" if clean_priority==1 & street_raw=="CHIHAUHAU"  & hn==203
replace checked_st="c" if clean_priority==1 & street_raw=="CHIHAUHAU"  & hn==203
replace stname_flag="Chihuahua St" if clean_priority==1 & street_raw=="CHIHAUHAU"  & checked_st==""
replace checked_st="c, ancestry match, SM missing" if clean_priority==1 & street_raw=="CHIHAUHAU"  & checked_st==""
replace checked_hn="c" if clean_priority==1 & street_raw=="CHIHAUHAU" 

*W Houston St matches Ancestry, but not in same ED in SM
browse if clean_priority==1 & street_raw=="WEST HOUSTON STREET"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==1 & street_raw=="WEST HOUSTON STREET"
replace checked_hn="c" if clean_priority==1 & street_raw=="WEST HOUSTON STREET"

*Alley in Ancestry.  Not sure if it's _____ Alley.
browse if clean_priority==1 & street_raw=="ALLEY"
replace hn_edit=1 if clean_priority==1 & street_raw=="ALLEY" & hn==1401
replace hn_edit=1 if clean_priority==1 & street_raw=="ALLEY" & hn==516
replace hn_edit=1 if clean_priority==1 & street_raw=="ALLEY" & hn==1901
replace hn_edit=1 if clean_priority==1 & street_raw=="ALLEY" & hn==411
replace checked_st="c, ancestry match, SM missing" if clean_priority==1 & street_raw=="ALLEY"
replace checked_hn="c" if clean_priority==1 & street_raw=="ALLEY"

*2/27
*Arbor St in Ancestry but Arbor Pl in SM
browse if clean_priority==1 & street_raw=="ARBOR ST."
replace checked_st="c, ancestry match, SM diff type" if clean_priority==1 & street_raw=="ARBOR ST."
replace stname_flag="Arbor Pl" if clean_priority==1 & street_raw=="ARBOR ST."
replace checked_hn="c" if clean_priority==1 & street_raw=="ARBOR ST."

*Looks like W Salinas St, which matches SM
browse if clean_priority==1 & street_raw=="W. SABINAS ST."
replace st_edit="W Salinas St" if clean_priority==1 & street_raw=="W. SABINAS ST."
replace checked_st="c" if clean_priority==1 & street_raw=="W. SABINAS ST."
replace hn_flag="1909 rear" if clean_priority==1 & street_raw=="W. SABINAS ST." & hn==1909 & line_num>10
replace hn_flag="2105 rear" if clean_priority==1 & street_raw=="W. SABINAS ST." & hn==2105 & line_num>20
replace checked_hn="c" if clean_priority==1 & street_raw=="W. SABINAS ST."

*Daily in Ancestry; SM has similar Daly St
browse if clean_priority==1 & street_raw=="DAILY"
replace checked_st="c, ancestry match, SM missing" if clean_priority==1 & street_raw=="DAILY"
replace stname_flag="Daly St" if clean_priority==1 & street_raw=="DAILY"
*Manually changed some hn_edit from 235 to 233
replace checked_hn="c" if clean_priority==1 & street_raw=="DAILY"

*W Martin on Ancestry, missing in SM
browse if clean_priority==1 & street_raw=="W. MARTIN"
replace checked_st="c, ancestry match, SM missing" if clean_priority==1 & street_raw=="W. MARTIN"
replace checked_hn="c, ambiguous" if clean_priority==1 & street_raw=="W. MARTIN" & hn==311
replace checked_hn="c" if clean_priority==1 & street_raw=="W. MARTIN" & checked_hn==""

*W Salinas in Ancestry; SM has W Salinas St
browse if clean_priority==1 & street_raw=="W. SABINAS"
replace st_edit="W Sabinas St" if clean_priority==1 & street_raw=="W. SABINAS"
replace checked_st="c" if clean_priority==1 & street_raw=="W. SABINAS"
replace checked_hn="c, ambiguous" if clean_priority==1 & street_raw=="W. SABINAS" & hn==610
replace checked_hn="c" if clean_priority==1 & street_raw=="W. SABINAS" & checked_hn==""

*Looks like W Woodlawn Ave, which matches SM but in diff ED
browse if clean_priority==1 & street_raw=="WEST WOODTOWN AVENUE"
replace institution_edit="Protestant Orphans Home (Changed from Protestant Home for Destitute Children)" if clean_priority==1 & street_raw=="WEST WOODTOWN AVENUE"
replace st_edit="W Woodlawn Ave" if clean_priority==1 & street_raw=="WEST WOODTOWN AVENUE"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==1 & street_raw=="WEST WOODTOWN AVENUE"
replace checked_hn="c" if clean_priority==1 & street_raw=="WEST WOODTOWN AVENUE"

*Waverly in Ancestry; SM has Waverly Pl
browse if clean_priority==1 & street_raw=="WAVERLY"
replace hn_edit=1207 if clean_priority==1 & street_raw=="WAVERLY" & image_id=="4548183_00411" & line_num<7
replace hn_edit=1247 if clean_priority==1 & street_raw=="WAVERLY" & image_id=="4548183_00411" & line_num>6 & line_num<10
replace hn_edit=1251 if clean_priority==1 & street_raw=="WAVERLY" & image_id=="4548183_00411" & line_num>9
*Manually edited all other house numbers
replace checked_st="c, ancestry match, SM diff type" if clean_priority==1 & street_raw=="WAVERLY"
replace stname_flag="Waverly Ave" if clean_priority==1 & street_raw=="WAVERLY"
replace checked_hn="c" if clean_priority==1 & street_raw=="WAVERLY"

*Set of orphanages. Concepcion Road is in diff EDs in SM, which has the orphanage name as st name
browse if clean_priority==1 & street_raw=="CONCEPCION ROAD"
replace institution_edit="St. Joseph's Orphanage for Girls" if clean_priority==1 & street_raw=="CONCEPCION ROAD" & institution_edit=="St. Joseph Orphanage for grils"
replace institution_edit="St. Joseph's Orphanage for Girls" if clean_priority==1 & street_raw=="CONCEPCION ROAD" & institution_edit=="St. Joseph Orphanage for Grils"
replace institution_edit="St. Peter's Orphanage for Boys" if clean_priority==1 & street_raw=="CONCEPCION ROAD" & institution_edit=="St Peters Orphanage for Boye"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==1 & street_raw=="CONCEPCION ROAD"
replace checked_hn="c, ambiguous" if clean_priority==1 & street_raw=="CONCEPCION ROAD"

*E Quincy in Ancestry; SM has a Quincy St
browse if clean_priority==1 & street_raw=="E QUINCY"
replace checked_hn="c, ambiguous" if clean_priority==1 & street_raw=="E QUINCY" & hn==226
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==1 & street_raw=="E QUINCY"
replace stname_flag="Quincy St" if clean_priority==1 & street_raw=="E QUINCY"
replace checked_st="c, ambiguous" if clean_priority==1 & street_raw=="E QUINCY" & hn==211
replace checked_hn="c, ambiguous" if clean_priority==1 & street_raw=="E QUINCY" & hn==211
replace checked_hn="c" if clean_priority==1 & street_raw=="E QUINCY" & checked_hn==""

*E Myrtle in Ancestry, SM has Myrtle St
browse if clean_priority==1 & street_raw=="E MYRTLE"
replace checked_hn="c, ambiguous" if clean_priority==1 & street_raw=="E MYRTLE" & line_num==59 & image_id=="4548183_00784"
*Manually changed hn_edits to 408 and 614
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==1 & street_raw=="E MYRTLE"
replace stname_flag="Myrtle St" if clean_priority==1 & street_raw=="E MYRTLE"
replace checked_hn="c" if clean_priority==1 & street_raw=="E MYRTLE"

*2/28
*E Laurel in Ancestry, SM has Laurel St in same ED
browse if clean_priority==1 & street_raw=="E LAUREL"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==1 & street_raw=="E LAUREL"
replace stname_flag="Laurel St" if clean_priority==1 & street_raw=="E LAUREL"
replace checked_hn="c" if clean_priority==1 & street_raw=="E LAUREL"

*W Myrtle on Ancestry, SM has Myrtle St
browse if clean_priority==1 & street_raw=="WEST MYRTLE"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==1 & street_raw=="WEST MYRTLE"
replace stname_flag="Myrtle St" if clean_priority==1 & street_raw=="WEST MYRTLE"
replace checked_hn="c" if clean_priority==1 & street_raw=="WEST MYRTLE"

*West Kings Highway on Ancestry, SM has similar King's Hy St
browse if clean_priority==1 &  street_raw=="WEST KINGS HIGHWAY"
replace hn_edit=221 if clean_priority==1 &  street_raw=="WEST KINGS HIGHWAY" & hn_raw=="F.2"
replace hn_flag=hn_raw if clean_priority==1 &  street_raw=="WEST KINGS HIGHWAY" & hn_raw=="F.2"
replace checked_st="c, ancestry match, SM missing" if clean_priority==1 &  street_raw=="WEST KINGS HIGHWAY" 
replace stname_flag="King's Hy St" if clean_priority==1 &  street_raw=="WEST KINGS HIGHWAY"
replace checked_hn="c" if clean_priority==1 &  street_raw=="WEST KINGS HIGHWAY"

*Gramercy Ave on Ancestry, but W Gramercy Pl on SM
browse if clean_priority==1 & street_raw=="GRAMERCY AVE"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==1 & street_raw=="GRAMERCY AVE"
replace stname_flag="W Gramercy Pl" if clean_priority==1 & street_raw=="GRAMERCY AVE"
replace checked_hn="c" if clean_priority==1 & street_raw=="GRAMERCY AVE"

*W Kings Highway on Ancestry; SM has similar King's Hy St
browse if clean_priority==1 & street_raw=="W.KINGS HIGHWAY"
replace checked_st="c, ancestry match, SM missing" if clean_priority==1 & street_raw=="W.KINGS HIGHWAY"
replace stname_flag="King's Hy St" if clean_priority==1 & street_raw=="W.KINGS HIGHWAY"
replace checked_hn="c" if clean_priority==1 & street_raw=="W.KINGS HIGHWAY"

*Lullwood Street in Ancestry, SM has W Lullwood Ave
browse if clean_priority==1 & street_raw=="LULLWOOD STREET"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==1 & street_raw=="LULLWOOD STREET"
replace stname_flag="W Lullwood Ave" if clean_priority==1 & street_raw=="LULLWOOD STREET"
replace checked_hn="c" if clean_priority==1 & street_raw=="LULLWOOD STREET"

*E Dewey in Ancestry, but SM has Dewey Pl.  Some hns have extra numbers
browse if clean_priority==1 & street_raw=="E DEWEY"
replace hn_edit=311 if clean_priority==1 & street_raw=="E DEWEY" & hn==314
*Manually edited hn_flag and hn_edit for hn= 512 and 526
replace checked_st="c, ancestry match, SM diff type" if clean_priority==1 & street_raw=="E DEWEY"
replace stname_flag="Dewey Pl" if clean_priority==1 & street_raw=="E DEWEY"
replace checked_hn="c" if clean_priority==1 & street_raw=="E DEWEY"

*Mccullough Ave is in diff EDs in SM, which has inst names as st names
browse if clean_priority==1 & street_raw=="MCCULLOUGH AVENUE"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==1 & street_raw=="MCCULLOUGH AVENUE"
replace hn_edit=1902 if clean_priority==1 & street_raw=="MCCULLOUGH AVENUE" & image_id!="4548184_00762"
replace checked_hn="c" if clean_priority==1 & street_raw=="MCCULLOUGH AVENUE"

*Navarro St on Ancestry; matches SM. Apartments
browse if clean_priority==1 & image_id=="4548184_00772"
replace st_edit="Navarro St" if clean_priority==1 & image_id=="4548184_00772"
replace checked_st="c" if clean_priority==1 & image_id=="4548184_00772"
replace checked_hn="c, multi-unit" if clean_priority==1 & image_id=="4548184_00772"

browse if clean_priority==1 & image_id=="4548184_00773"
replace st_edit="Navarro St" if clean_priority==1 & image_id=="4548184_00773"
replace checked_st="c" if clean_priority==1 & image_id=="4548184_00773"
replace checked_hn="c, multi-unit" if clean_priority==1 & image_id=="4548184_00773"

*YMCA on 301 Martin.  SM has Martin St in same ED
browse if clean_priority==1 & institution=="Yaung Meus Christian Assn."
replace hn_edit=301 if clean_priority==1 & institution=="Yaung Meus Christian Assn."
replace st_edit="Martin" if clean_priority==1 & institution=="Yaung Meus Christian Assn."
replace checked_st="c, ancestry match, SM diff type" if clean_priority==1 & institution=="Yaung Meus Christian Assn."
replace stname_flag="Martin St" if clean_priority==1 & institution=="Yaung Meus Christian Assn."
replace institution_edit="YMCA" if clean_priority==1 & institution=="Yaung Meus Christian Assn."
replace checked_hn="c" if clean_priority==1 & institution=="Yaung Meus Christian Assn."

*Fort Sam Houston.  Doesn't have an address.
browse if clean_priority==1 & institution=="Fort Sam Houston"
replace st_edit="Fort Sam Houston" if clean_priority==1 & institution=="Fort Sam Houston"
replace checked_st="c" if clean_priority==1 & institution=="Fort Sam Houston"
replace checked_hn="c" if clean_priority==1 & institution=="Fort Sam Houston"

*Rogers in Ancestry, Rogers Ave in SM
browse if clean_priority==1 & street_raw=="ROGERS"
*Manually changed hn_flag to 1812 1/2
replace checked_st="c, ancestry match, SM diff type" if clean_priority==1 & street_raw=="ROGERS"
replace stname_flag="Rogers Ave" if clean_priority==1 & street_raw=="ROGERS"
replace checked_hn="c" if clean_priority==1 & street_raw=="ROGERS"

*Montana St in diff ED; SM has institution name as street name
browse if clean_priority==1 & street_raw=="MONTANA STREET"
replace checked_st="c, ancestry match, SM diff ed" if clean_priority==1 & street_raw=="MONTANA STREET"
replace checked_hn="c" if clean_priority==1 & street_raw=="MONTANA STREET"

*Adams in Ancestry, Adams St in SM
browse if clean_priority==1 & street_raw=="ADAMS"
*Manually changed hn_edit to 131
replace checked_st="c, ancestry match, SM diff type" if clean_priority==1 & street_raw=="ADAMS"
replace stname_flag="Adams St" if clean_priority==1 & street_raw=="ADAMS"
replace checked_hn="c" if clean_priority==1 & street_raw=="ADAMS"

*Clean priority 1 done

*Looks like Shiners Aly on Ancestry, which matches SM
browse if clean_priority==2 & street_raw=="SHIVERS ALLEY"
replace hn_flag=hn_raw if clean_priority==2 & street_raw=="SHIVERS ALLEY"
*Manually edited hn_edit
replace st_edit="Shiners Aly" if clean_priority==2 & street_raw=="SHIVERS ALLEY"
replace checked_st="c" if clean_priority==2 & street_raw=="SHIVERS ALLEY"
replace checked_hn="c" if clean_priority==2 & street_raw=="SHIVERS ALLEY"

*Paloma Aly in Ancestry; SM has La Paloma St
browse if clean_priority==2 & street_raw=="PALOMA ALLY"
replace hn_edit=109 if clean_priority==2 & street_raw=="PALOMA ALLY" & hn==412
replace hn_flag="109 REAR" if clean_priority==2 & street_raw=="PALOMA ALLY" & hn==412
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="PALOMA ALLY"
replace stname_flag="La Paloma St" if clean_priority==2 & street_raw=="PALOMA ALLY"
replace checked_hn="c" if clean_priority==2 & street_raw=="PALOMA ALLY"

browse if clean_priority==2 & street_raw=="PALOMA ALLEY"
replace hn_edit=109 if clean_priority==2 & street_raw=="PALOMA ALLEY" & hn==412
replace hn_flag="109 REAR" if clean_priority==2 & street_raw=="PALOMA ALLEY" & hn==412
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="PALOMA ALLEY"
replace stname_flag="La Paloma St" if clean_priority==2 & street_raw=="PALOMA ALLEY"
replace checked_hn="c" if clean_priority==2 & street_raw=="PALOMA ALLEY"

*Ancestry has W Arsenal, SM has Arsenal St
browse if clean_priority==2 & street_raw=="WEST ARSENAL"
replace hn_edit=218 if clean_priority==2 & street_raw=="WEST ARSENAL" & hn==213
*Manually edited hn_flag to 218 rear
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="WEST ARSENAL"
replace stname_flag="Arsenal St" if clean_priority==2 & street_raw=="WEST ARSENAL"
replace checked_hn="c" if clean_priority==2 & street_raw=="WEST ARSENAL"

*3/l
*Running assigned code
drop st 
gen st= overall_match
replace st=street_precleanedhn if overall_match==""
replace st=st_edit if checked_st!=""
drop st_edit
gen st_edit=st

*Ancestry has E Cellavos St, while SM has similar Cevallos St
browse if clean_priority==2 & street_raw=="E CELLAVES ST"
replace st_edit="E Cellavos St" if clean_priority==2 & street_raw=="E CELLAVES ST"
replace checked_st="c, ancestry match, SM missing" if clean_priority==2 & street_raw=="E CELLAVES ST"
replace stname_flag="Cevallos St" if clean_priority==2 & street_raw=="E CELLAVES ST"
replace hn_edit=315 if clean_priority==2 & street_raw=="E CELLAVES ST" & hn==427
replace hn_flag="315 REAR" if clean_priority==2 & street_raw=="E CELLAVES ST" & hn==427
replace hn_edit=241 if clean_priority==2 & street_raw=="E CELLAVES ST" & hn_raw=="C 21"
replace hn_flag="2" if clean_priority==2 & street_raw=="E CELLAVES ST" & hn_raw=="C 21"
replace hn_flag="2" if clean_priority==2 & street_raw=="E CELLAVES ST" & hn==2
replace hn_edit=237 if clean_priority==2 & street_raw=="E CELLAVES ST" & hn==2
replace hn_flag="F1" if clean_priority==2 & street_raw=="E CELLAVES ST" & hn_raw=="F1"
replace hn_edit=219 if clean_priority==2 & street_raw=="E CELLAVES ST" & hn_raw=="F1"
replace checked_hn="c" if clean_priority==2 & street_raw=="E CELLAVES ST"

*Fest in Ancestry; SM has Fest St
browse if clean_priority==2 & street_raw=="FEST"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="FEST"
replace stname_flag="Fest St" if clean_priority==2 & street_raw=="FEST"
replace st_edit="Burbank" if clean_priority==2 & street_raw=="FEST" & line_num>46
replace stname_flag="Burbank St" if clean_priority==2 & street_raw=="FEST" & line_num>46
replace st_edit="Fest" if clean_priority==2 & street_raw=="FEST" & image_id!="4547939_00795"
replace stname_flag="Fest St" if clean_priority==2 & street_raw=="FEST" & image_id!="4547939_00795"
replace hn_edit=104 if clean_priority==2 & street_raw=="FEST" & st_edit=="Burbank"
replace checked_hn="c" if clean_priority==2 & street_raw=="FEST"

*E Baylor in Ancestry; SM has Baylor St
browse if clean_priority==2 & street_raw=="E BAYLOR"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="E BAYLOR"
replace stname_flag="Baylor St" if clean_priority==2 & street_raw=="E BAYLOR"
replace checked_hn="c" if clean_priority==2 & street_raw=="E BAYLOR"

*Ancestry has Ray St, but SM has Ray Ave
browse if clean_priority==2 & street_raw=="RAY STREET"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="RAY STREET"
replace stname_flag="Ray Ave" if clean_priority==2 & street_raw=="RAY STREET"
replace hn_edit=244 if clean_priority==2 & street_raw=="RAY STREET" & hn==246
replace checked_hn="c" if clean_priority==2 & street_raw=="RAY STREET"

*E Dittmar Ave in Ancestry, SM has Dittmar St
browse if clean_priority==2 & street_raw=="EAST DITTMAS AVE"
replace st_edit="E Dittmar Ave" if clean_priority==2 & street_raw=="EAST DITTMAS AVE"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="EAST DITTMAS AVE"
replace stname_flag="Dittmar St" if clean_priority==2 & street_raw=="EAST DITTMAS AVE"
replace checked_hn="c" if clean_priority==2 & street_raw=="EAST DITTMAS AVE"

*Thelka St on Ancestry; SM has Thelka Ave
browse if clean_priority==2 & street_raw=="THELKA STREET"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="THELKA STREET"
replace stname_flag="Thelka Ave" if clean_priority==2 & street_raw=="THELKA STREET"
*Manually edited hn_flag for 154 rear
replace checked_hn="c" if clean_priority==2 & street_raw=="THELKA STREET"

*Can't find street name
browse if clean_priority==2 & institution=="Mission Home and Training School"
replace checked_st="c, ambiguous" if clean_priority==2 & institution=="Mission Home and Training School"
replace checked_hn="c" if clean_priority==2 & institution=="Mission Home and Training School"

*Seems to be an alley off of S Laredo St. Not found in SM
browse if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L"
replace st_edit="La Gloria Aly" if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L"
replace stname_flag="Off 713 1/2 S. Laredo" if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L"
replace checked_st="c, ancestry match, SM missing" if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L"
replace hn_edit=1 if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L" & hn==108
replace hn_edit=708 if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L" & line_num==99
replace st_edit="S Pecos" if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L" & line_num==99
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L" & line_num==99
replace stname_flag="S Pecos St" if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L" & line_num==99
replace hn_edit=1 if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L" & line_num==100
replace st_edit="S Laredo" if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L" & line_num==100
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L" & line_num==100
replace stname_flag="S Laredo St" if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L" & line_num==100
replace hn_flag="1 rear" if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L" & line_num==100
replace checked_hn="c" if clean_priority==2 & street_raw=="LA GLORIA ALLEY OFF 713 1/2 S. L"

*Seems to be a street off of S Frio St. Missing in SM
browse if clean_priority==2 & street_raw=="CORRALL REAR OF SO FRIO ST"
replace st_edit="Corrall" if clean_priority==2 & street_raw=="CORRALL REAR OF SO FRIO ST"
replace stname_flag="Rear of S Frio St" if clean_priority==2 & street_raw=="CORRALL REAR OF SO FRIO ST"
replace checked_st="c, ancestry match, SM missing" if clean_priority==2 & street_raw=="CORRALL REAR OF SO FRIO ST"
replace hn_edit=103 if clean_priority==2 & street_raw=="CORRALL REAR OF SO FRIO ST" & hn==100
replace checked_hn="c" if clean_priority==2 & street_raw=="CORRALL REAR OF SO FRIO ST"

*Ancestry and SM match
browse if clean_priority==2 & street_raw=="DURANGO STREET"
replace checked_st="c" if clean_priority==2 & street_raw=="DURANGO STREET"
replace checked_hn="c" if clean_priority==2 & street_raw=="DURANGO STREET"

*S San Sabas in Ancestry; SM has S San Saba St in diff ED
browse if clean_priority==2 & street_raw=="SO SAN SABAS"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==2 & street_raw=="SO SAN SABAS"
replace stname_flag="S San Saba St" if clean_priority==2 & street_raw=="SO SAN SABAS"
replace checked_hn="c" if clean_priority==2 & street_raw=="SO SAN SABAS"

*San Fernando in Ancestry; SM has San Fernando St
browse if clean_priority==2 & street_raw=="SAN FERNANDO"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="SAN FERNANDO"
replace stname_flag="San Fernando St" if clean_priority==2 & street_raw=="SAN FERNANDO"
*Manually edited hn_flag to 1305 1/2
replace checked_hn="c" if clean_priority==2 & street_raw=="SAN FERNANDO"

*3/6
*Fite Alley in Ancestry but Fite St in SM
browse if clean_priority==2 & street_raw=="FITE ALLEY"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="FITE ALLEY"
replace stname_flag="Fite St" if clean_priority==2 & street_raw=="FITE ALLEY"
replace hn_edit=319 if clean_priority==2 & street_raw=="FITE ALLEY" & hn==3193
replace checked_hn="c" if clean_priority==2 & street_raw=="FITE ALLEY"

*S Richter St in Ancestry; SM has Richter St in diff ED
browse if clean_priority==2 & street_raw=="SO. RICHTER ST."
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==2 & street_raw=="SO. RICHTER ST."
replace stname_flag="Richter St" if clean_priority==2 & street_raw=="SO. RICHTER ST."
replace checked_hn="c" if clean_priority==2 & street_raw=="SO. RICHTER ST."

browse if clean_priority==2 & street_raw=="S. RICHTER"
*Manually edited hn_flag for 817 rear
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==2 & street_raw=="S. RICHTER"
replace stname_flag="Richter St" if clean_priority==2 & street_raw=="S. RICHTER"
replace checked_hn="c" if clean_priority==2 & street_raw=="S. RICHTER"

*S Rosillo in Ancestry, SM has Rosillos St
browse if clean_priority==2 & street_raw=="SO ROSILLO"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="SO ROSILLO"
replace stname_flag="Rosillos St" if clean_priority==2 & street_raw=="SO ROSILLO"
replace checked_hn="c" if clean_priority==2 & street_raw=="SO ROSILLO"

*Salinas St in Ancestry; SM has W Salinas St
browse if clean_priority==2 & street_raw=="SABINAS STREET"
*Manually edited hn_flag for 723 rear
replace checked_hn="c" if clean_priority==2 & street_raw=="SABINAS STREET"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="SABINAS STREET"
replace stname_flag="W Salinas St" if clean_priority==2 & street_raw=="SABINAS STREET"
replace st_edit="Salinas St" if clean_priority==2 & street_raw=="SABINAS STREET"

*N Concho (Divers Alley) on Ancestry, SM has N Concho St
browse if clean_priority==2 & street_raw=="DIVERS ALLEY  NO. CONCHO"
replace st_edit="N Concho (Divers Alley)" if clean_priority==2 & street_raw=="DIVERS ALLEY  NO. CONCHO"
replace stname_flag="N Concho St" if clean_priority==2 & street_raw=="DIVERS ALLEY  NO. CONCHO"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="DIVERS ALLEY  NO. CONCHO"
*Manually edited hn_flag for 310 REAR, line 11, 21
replace checked_hn="c" if clean_priority==2 & street_raw=="DIVERS ALLEY  NO. CONCHO"

*Salinas in Ancestry; W Salinas St in SM
browse if clean_priority==2 & street_raw=="SABINAS"
replace hn_edit=319 if clean_priority==2 & street_raw=="SABINAS" & st_edit=="Concho"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="SABINAS"
replace stname_flag="N Concho St" if clean_priority==2 & street_raw=="SABINAS" & st_edit=="Concho"
replace st_edit="Salinas" if clean_priority==2 & street_raw=="SABINAS" & st_edit=="Sabinas"
replace stname_flag="W Salinas St" if clean_priority==2 & street_raw=="SABINAS" & stname_flag==""
replace hn_edit=3121 if clean_priority==2 & street_raw=="SABINAS" & hn==312
replace checked_hn="c" if clean_priority==2 & street_raw=="SABINAS"

*Hospital. SM has hospital name as only st in ED
browse if clean_priority==2 & street_raw=="MORALES STREET"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==2 & street_raw=="MORALES STREET"
replace checked_hn="c" if clean_priority==2 & street_raw=="MORALES STREET"

*Can't tell if Rawling or Rawlins. Latter is in SM, but with diff ED
browse if clean_priority==2 & street_raw=="RAWLING ST"
replace st_edit="Medina St" if clean_priority==2 & street_raw=="RAWLING ST" & hn==807
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="RAWLING ST" & hn==807
replace stname_flag="N Medina St" if clean_priority==2 & street_raw=="RAWLING ST" & hn==807
replace checked_st="c, ambiguous" if clean_priority==2 & street_raw=="RAWLING ST" & checked_st==""
replace stname_flag="Rawlins St" if clean_priority==2 & street_raw=="RAWLING ST" & stname_flag==""
replace checked_hn="c" if clean_priority==2 & street_raw=="RAWLING ST"

*Martin on Ancestry. SM has Martin St in diff ED
browse if clean_priority==2 & street_raw=="MARTIN"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==2 & street_raw=="MARTIN"
replace stname_flag="Martin St" if clean_priority==2 & street_raw=="MARTIN"
replace hn_flag=hn_raw if clean_priority==2 & street_raw=="MARTIN" & line_num>71
replace hn_edit=1315 if clean_priority==2 & street_raw=="MARTIN" & hn_flag!=""
replace checked_hn="c" if clean_priority==2 & street_raw=="MARTIN"

*W Salinas St in Ancestry and SM
browse if clean_priority==2 & street_raw=="W SABINAS STREET"
replace hn_edit=1604 if clean_priority==2 & street_raw=="W SABINAS STREET" & hn==1624
replace st_edit="W Salinas St" if clean_priority==2 & street_raw=="W SABINAS STREET"
replace checked_st="c" if clean_priority==2 & street_raw=="W SABINAS STREET"
replace checked_hn="c" if clean_priority==2 & street_raw=="W SABINAS STREET"

*W Travis St in Ancestry. In ED 51, SM has Travis St. W Travis St is in diff ED in SM
browse if clean_priority==2 & street_raw=="N. TRAVIS STREET"
replace st_edit="W Travis St" if clean_priority==2 & street_raw=="N. TRAVIS STREET"
replace checked_st="c, ancestr match, SM diff ED" if clean_priority==2 & street_raw=="N. TRAVIS STREET"
replace stname_flag="Travis St" if clean_priority==2 & street_raw=="N. TRAVIS STREET"
replace checked_hn="c" if clean_priority==2 & street_raw=="N. TRAVIS STREET"

*Alto Aly in Ancestry, but missing in SM (Alto St in diff ED)
browse if clean_priority==2 & street_raw=="ALTO ALLEY"
replace checked_st="c, ancestry match, SM missing" if clean_priority==2 & street_raw=="ALTO ALLEY"
replace checked_hn="c" if clean_priority==2 & street_raw=="ALTO ALLEY"

*W Travis St in Ancestry. In ED 53, SM has Travis ST. W Travis ST is in diff ED in SM
browse if clean_priority==2 & street_raw=="WEST TRAVIS"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==2 & street_raw=="WEST TRAVIS"
replace stname_flag="Travis St" if clean_priority==2 & street_raw=="WEST TRAVIS"
replace checked_hn="c" if clean_priority==2 & street_raw=="WEST TRAVIS"

*3/7
*Camada in Ancestry. SM has Camada St in ED 53
browse if clean_priority==2 & street_raw=="CAMADA"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==2 & street_raw=="CAMADA"
replace stname_flag="Camada St" if clean_priority==2 & street_raw=="CAMADA"
replace hn_edit=746 if clean_priority==2 & street_raw=="CAMADA" & hn==1843
replace checked_hn="c" if clean_priority==2 & street_raw=="CAMADA"

*W Martin in Ancestry; SM has Martin St in diff ED
browse if clean_priority==2 & street_raw=="W MARTIN"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==2 & street_raw=="W MARTIN"
replace stname_flag="Martin St" if clean_priority==2 & street_raw=="W MARTIN"
replace checked_hn="c" if clean_priority==2 & street_raw=="W MARTIN"

*Two separate streets. Comal St (on corner of W Poplar St) and Rivas St
browse if clean_priority==2 & street_raw=="RIVER COR CAMAL COR OF W POPLOR"
replace st_edit="Comal St" if clean_priority==2 & street_raw=="RIVER COR CAMAL COR OF W POPLOR" & line_num<74
replace stname_flag="Corner of W Poplar St" if clean_priority==2 & street_raw=="RIVER COR CAMAL COR OF W POPLOR" & line_num<74
replace st_edit="" if clean_priority==2 & street_raw=="RIVER COR CAMAL COR OF W POPLOR" & image_id=="4548183_00008"
replace stname_flag="" if clean_priority==2 & street_raw=="RIVER COR CAMAL COR OF W POPLOR" & image_id=="4548183_00008"
replace st_edit="Rivas St" if clean_priority==2 & street_raw=="RIVER COR CAMAL COR OF W POPLOR" & st_edit!="Comal St"
replace checked_st="c" if clean_priority==2 & street_raw=="RIVER COR CAMAL COR OF W POPLOR"
replace hn_flag="219 rear" if clean_priority==2 & street_raw=="RIVER COR CAMAL COR OF W POPLOR" & hn==219
replace checked_hn="c" if clean_priority==2 & street_raw=="RIVER COR CAMAL COR OF W POPLOR"

*Looks like Rivas St which matches SM
browse if clean_priority==2 & street_raw=="RIVER STREET"
*Manually edited hn_flag for 322 rear
replace st_edit="Rivas St" if clean_priority==2 & street_raw=="RIVER STREET"
replace checked_st="c" if clean_priority==2 & street_raw=="RIVER STREET"
replace checked_hn="c" if clean_priority==2 & street_raw=="RIVER STREET"

*San Marcos St in Ancestry, but SM has N San Marcos St
browse if clean_priority==2 & street_raw=="SAN MARCUS STREET"
replace st_edit="San Marcos St" if clean_priority==2 & street_raw=="SAN MARCUS STREET"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="SAN MARCUS STREET"
replace stname_flag="N San Marcos St" if clean_priority==2 & street_raw=="SAN MARCUS STREET"
replace checked_st="c" if clean_priority==2 & street_raw=="SAN MARCUS STREET"
replace checked_hn="c" if clean_priority==2 & street_raw=="SAN MARCUS STREET"

*Briscoe Alley in Ancestry, but missing from SM
browse if clean_priority==2 & street_raw=="BRISCOE ALLEY"
replace hn_flag="909 rear" if clean_priority==2 & street_raw=="BRISCOE ALLEY" & hn_edit==909
replace hn_flag="574 rear" if clean_priority==2 & street_raw=="BRISCOE ALLEY" & hn_edit==574
replace checked_st="c, ancestry match, SM missing" if clean_priority==2 & street_raw=="BRISCOE ALLEY"
replace checked_hn="c" if clean_priority==2 & street_raw=="BRISCOE ALLEY"

*N Drive in Ancestry, North Drive in SM
browse if clean_priority==2 & street_raw=="N. DRIVE"
replace checked_st="c" if clean_priority==2 & street_raw=="N. DRIVE"
replace checked_hn="c" if clean_priority==2 & street_raw=="N. DRIVE"

*Ancestry has W Kings Hwy; SM has Kings Hy St
browse if clean_priority==2 & street_raw=="WEST KINGS HIGHWAY"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="WEST KINGS HIGHWAY"
replace stname_flag="King's Hy St" if clean_priority==2 & street_raw=="WEST KINGS HIGHWAY"
*Manually edited hn_edit for image_id 4548183_00352
replace hn_edit=1801 if clean_priority==2 & street_raw=="WEST KINGS HIGHWAY" & image_id=="4548183_00354" & line_num<57
replace hn_edit=1805 if clean_priority==2 & street_raw=="WEST KINGS HIGHWAY" & image_id=="4548183_00354" & line_num<66 & line_num>56
replace hn_edit=1809 if clean_priority==2 & street_raw=="WEST KINGS HIGHWAY" & image_id=="4548183_00354" & line_num<71 & line_num>65
replace hn_edit=1823 if clean_priority==2 & street_raw=="WEST KINGS HIGHWAY" & image_id=="4548183_00354" & line_num<76 & line_num>70
replace hn_edit=1827 if clean_priority==2 & street_raw=="WEST KINGS HIGHWAY" & image_id=="4548183_00354" & line_num>75
*Manually edited hn_edit for 1814
replace checked_hn="c" if clean_priority==2 & street_raw=="WEST KINGS HIGHWAY"

*W Cincinnati Ave on Ancestry; SM has just Cincinnati Ave
browse if clean_priority==2 & street_raw=="W. CINCINNATI AVE"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="W. CINCINNATI AVE"
replace stname_flag="Cincinnati Ave" if clean_priority==2 & street_raw=="W. CINCINNATI AVE"
*Manually entered hn_edit values
replace checked_hn="c" if clean_priority==2 & street_raw=="W. CINCINNATI AVE"

*Two streets: Crockett St and Camaron St(has jail). Both match SM
browse if clean_priority==2 & street_raw=="CROCKETT STREET."
replace st_edit="Camaron St" if clean_priority==2 & street_raw=="CROCKETT STREET." & image_id!="4548183_00545"
replace hn_edit=120 if clean_priority==2 & street_raw=="CROCKETT STREET." & image_id!="4548183_00545"
replace checked_st="c" if clean_priority==2 & street_raw=="CROCKETT STREET."
replace checked_hn="c" if clean_priority==2 & street_raw=="CROCKETT STREET."

*Should be Camaron St.  Seems to be some sort of alley nearby
browse if clean_priority==2 & street_raw=="CAMERON S"
replace st_edit="Camaron St" if clean_priority==2 & street_raw=="CAMERON S"
replace stname_flag="Alley" if clean_priority==2 & street_raw=="CAMERON S" & line_num<20
replace checked_st="c" if clean_priority==2 & street_raw=="CAMERON S"
replace checked_hn="c" if clean_priority==2 & street_raw=="CAMERON S"

*W Elmira Ave in Ancestry, W Elmira St in SM
browse if clean_priority==2 & street_raw=="WEST ELMIRA AVE"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="WEST ELMIRA AVE"
replace stname_flag="W Elmira St" if clean_priority==2 & street_raw=="WEST ELMIRA AVE"
replace checked_hn="c" if clean_priority==2 & street_raw=="WEST ELMIRA AVE"

*Ancestry has E Quincy; SM has Quincy St
browse if clean_priority==2 & street_raw=="E. QUINCY"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="E. QUINCY"
replace stname_flag="Quincy St" if clean_priority==2 & street_raw=="E. QUINCY"
replace checked_hn="c" if clean_priority==2 & street_raw=="E. QUINCY"

*N St Marys in Ancestry; N St Marys St in SM
browse if clean_priority==2 & street_raw=="N. ST MARYS"
replace hn_edit=919 if clean_priority==2 & street_raw=="N. ST MARYS" & hn==424
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="N. ST MARYS"
replace stname_flag="N St Marys St" if clean_priority==2 & street_raw=="N. ST MARYS"
replace checked_hn="c" if clean_priority==2 & street_raw=="N. ST MARYS"

*E Locust in Ancestry, Locust St in SM
browse if clean_priority==2 & street_raw=="E LOCUST"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="E LOCUST"
replace stname_flag="Locust St" if clean_priority==2 & street_raw=="E LOCUST"
replace checked_hn="c" if clean_priority==2 & street_raw=="E LOCUST"

*Ancestry has E Maple, SM has Maple St. Also there is an inst on Main Ave, Ogden, E Poplar
browse if clean_priority==2 & street_raw=="E MAPLE"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="E MAPLE"
replace stname_flag="Maple St" if clean_priority==2 & street_raw=="E MAPLE"
replace st_edit="Main Ave" if clean_priority==2 & street_raw=="E MAPLE" & inst==1
replace checked_st="c" if clean_priority==2 & street_raw=="E MAPLE" & inst==1
replace stname_flag="Ogden E Poplar" if clean_priority==2 & street_raw=="E MAPLE" & inst==1
replace institution_edit="Kenney Sanatarium" if clean_priority==2 & street_raw=="E MAPLE" & inst==1
replace hn_edit=1200 if clean_priority==2 & street_raw=="E MAPLE" & inst==1
replace checked_hn="c" if clean_priority==2 & street_raw=="E MAPLE"

*E Laurel on Ancestry; SM has Laurel St
browse if clean_priority==2 & street_raw=="E. LAUREL"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="E. LAUREL"
replace stname_flag="Laurel St" if clean_priority==2 & street_raw=="E. LAUREL"
replace hn_edit=301 if clean_priority==2 & street_raw=="E. LAUREL" & hn==306
replace checked_hn="c" if clean_priority==2 & street_raw=="E. LAUREL"

*3/8
*Labelled 'supplementary sheet'. Seems to be many different streets
browse if clean_priority==2 & image_id=="4548184_00084"
replace hn_edit=815 if clean_priority==2 & image_id=="4548184_00084" & hn==835
replace checked_st="c, ambiguous" if clean_priority==2 & image_id=="4548184_00084"
replace checked_hn="c" if clean_priority==2 & image_id=="4548184_00084"

browse if clean_priority==2 & image_id=="4548184_00083"
replace hn_edit=123 if clean_priority==2 & image_id=="4548184_00083" & line_num>42 & line_num<48
replace hn_edit=815 if clean_priority==2 & image_id=="4548184_00083" & line_num>47
replace checked_st="c, ambiguous" if clean_priority==2 & image_id=="4548184_00083"
replace checked_hn="c" if clean_priority==2 & image_id=="4548184_00083"

*Looks like W Agarita Ave in Ancestry; SM has Agarita Ave
browse if clean_priority==2 & street_raw=="WAGANTA AVE"
replace st_edit="W Agarita Ave" if clean_priority==2 & street_raw=="WAGANTA AVE"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="WAGANTA AVE"
replace stname_flag="Agarita Ave" if clean_priority==2 & street_raw=="WAGANTA AVE"
replace checked_hn="c" if clean_priority==2 & street_raw=="WAGANTA AVE"

browse if clean_priority==2 & street_raw=="WAGANTA"
replace st_edit="W Agarita Ave" if clean_priority==2 & street_raw=="WAGANTA"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="WAGANTA"
replace stname_flag="Agarita Ave" if clean_priority==2 & street_raw=="WAGANTA"
replace checked_hn="c" if clean_priority==2 & street_raw=="WAGANTA"

*Ancestry has Norwood Ct, SM has E Norwood Ct
browse if clean_priority==2 & street_raw=="NORWOOD COURT"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="NORWOOD COURT"
replace stname_flag="E Norwood Ct" if clean_priority==2 & street_raw=="NORWOOD COURT"
*Manually edited hn_edit values with F2 flag
replace checked_hn="c" if clean_priority==2 & street_raw=="NORWOOD COURT"

*W Kings Hwy in Ancestry; SM has Kings Hy St
browse if clean_priority==2 & street_raw=="W.KINGS HIGHWAY"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="W.KINGS HIGHWAY"
replace stname_flag="Kings Hy St" if clean_priority==2 & street_raw=="W.KINGS HIGHWAY"
replace checked_hn="c" if clean_priority==2 & street_raw=="W.KINGS HIGHWAY"

*Cannot tell for sure what street it is. Could be W Magnolia Ave
browse if clean_priority==2 & image_id=="4548184_00414"
replace stname_flag="W Magnolia Ave" if clean_priority==2 & image_id=="4548184_00414"
replace checked_st="c, ambiguous" if clean_priority==2 & image_id=="4548184_00414"
replace checked_hn="c" if clean_priority==2 & image_id=="4548184_00414"

browse if clean_priority==2 & image_id=="4548184_00416"
*Manually changed hn_edit for 1015
replace stname_flag="W Magnolia Ave" if clean_priority==2 & image_id=="4548184_00416"
replace checked_st="c, ambiguous" if clean_priority==2 & image_id=="4548184_00416"
replace checked_hn="c" if clean_priority==2 & image_id=="4548184_00416"

*Ancestry has W Agarita Ave; SM has Agarita Ave
browse if clean_priority==2 & street_raw=="W.AGARITA"
replace st_edit="W Agarita Ave" if clean_priority==2 & street_raw=="W.AGARITA"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="W.AGARITA"
replace stname_flag="Agarita Ave" if clean_priority==2 & street_raw=="W.AGARITA"
replace checked_hn="c" if clean_priority==2 & street_raw=="W.AGARITA"

*Ancestry has W Lynwood; SM has Lynwood Ave
browse if clean_priority==2 & street_raw=="W.LYNWOOD"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="W.LYNWOOD"
replace stname_flag="Lynwood Ave" if clean_priority==2 & street_raw=="W.LYNWOOD"
replace hn_edit=1506 if clean_priority==2 & street_raw=="W.LYNWOOD" & hn==1505
replace checked_hn="c" if clean_priority==2 & street_raw=="W.LYNWOOD"

*Fulton in Ancestry, SM has Fulton Ave
browse if clean_priority==2 & street_raw=="FULTON"
replace hn_edit=1342 if clean_priority==2 & street_raw=="FULTON" & hn==1312
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="FULTON"
replace stname_flag="Fulton Ave" if clean_priority==2 & street_raw=="FULTON"
replace checked_hn="c" if clean_priority==2 & street_raw=="FULTON"

*E Dewey in Ancestry; Dewey Pl in SM
browse if clean_priority==2 & street_raw=="E.DEWEY"
*Manually entered hn_flag values
replace hn_edit=420 if clean_priority==2 & street_raw=="E.DEWEY" & hn==101
replace hn_edit=320 if clean_priority==2 & street_raw=="E.DEWEY" & hn==4
replace checked_hn="c, multi-unit" if clean_priority==2 & street_raw=="E.DEWEY" & hn_flag!=""
replace checked_hn="c" if clean_priority==2 & street_raw=="E.DEWEY" & hn_flag==""
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="E.DEWEY"
replace stname_flag="Dewey Pl" if clean_priority==2 & street_raw=="E.DEWEY"

*Holland Ave in Ancestry matches SM.  Says Unnamed Street as well.
browse if clean_priority==2 & street_raw=="UNNAMED STREET HOLLAND AVE"
replace st_edit="Holland Ave" if clean_priority==2 & street_raw=="UNNAMED STREET HOLLAND AVE"
replace stname_flag="Unnamed Street" if clean_priority==2 & street_raw=="UNNAMED STREET HOLLAND AVE"
replace checked_st="c" if clean_priority==2 & street_raw=="UNNAMED STREET HOLLAND AVE"
replace checked_hn="c" if clean_priority==2 & street_raw=="UNNAMED STREET HOLLAND AVE"

*Three institutions
browse if clean_priority==2 & street_raw=="MCCOLLOUGH AVENUE"
replace st_edit="Blanco Road" if clean_priority==2 & street_raw=="MCCOLLOUGH AVENUE" & institution!="St. Anthony's Apostolic School"
*Manually deleted hn_edit values
replace institution_edit="De Mazenod Scholasticate" if clean_priority==2 & street_raw=="MCCOLLOUGH AVENUE" & institution=="De Mazenod Scolastieate"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==2 & street_raw=="MCCOLLOUGH AVENUE"
replace stname_flag="Blanco St" if clean_priority==2 & street_raw=="MCCOLLOUGH AVENUE" & institution!="St. Anthony's Apostolic School"
replace checked_hn="c, ambiguous" if clean_priority==2 & street_raw=="MCCOLLOUGH AVENUE" & institution!="St. Anthony's Apostolic School"
replace checked_hn="c" if clean_priority==2 & street_raw=="MCCOLLOUGH AVENUE" & checked_hn==""

*3/9
*St Anthony's Hotel on corner of Travis and Navarro
browse if clean_priority==2 & street_raw=="COMER TRAVIS NAVARRO"
replace inst=1 if clean_priority==2 & street_raw=="COMER TRAVIS NAVARRO"
replace institution_edit="St Anthony Hotel" if clean_priority==2 & street_raw=="COMER TRAVIS NAVARRO"
replace st_edit="Travis" if clean_priority==2 & street_raw=="COMER TRAVIS NAVARRO"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="COMER TRAVIS NAVARRO"
replace stname_flag="Corner Travis St & Navarro St" if clean_priority==2 & street_raw=="COMER TRAVIS NAVARRO"
*Manually removed hn_edit values
replace checked_hn="c, ambiguous" if clean_priority==2 & street_raw=="COMER TRAVIS NAVARRO"

*N Marys St and E Pecan St.  Both have institutions
browse if clean_priority==2 & street_raw=="NORTH ST MARYS"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="NORTH ST MARYS"
replace stname_flag="N St Marys St" if clean_priority==2 & street_raw=="NORTH ST MARYS"
replace inst=1 if clean_priority==2 & street_raw=="NORTH ST MARYS" & image_id=="4548184_00783"
replace institution_edit="Blue Bonnet Hotel" if clean_priority==2 & street_raw=="NORTH ST MARYS" & image_id=="4548184_00783"
replace inst=1 if clean_priority==2 & street_raw=="NORTH ST MARYS" & image_id=="4548184_00790"
replace institution_edit="Hotel" if clean_priority==2 & street_raw=="NORTH ST MARYS" & image_id=="4548184_00790"
replace hn_edit=511 if clean_priority==2 & street_raw=="NORTH ST MARYS" & image_id=="4548184_00790"
replace checked_hn="c, ambiguous" if clean_priority==2 & street_raw=="NORTH ST MARYS" & image_id=="4548184_00783"
replace checked_hn="c, ambiguous" if clean_priority==2 & street_raw=="NORTH ST MARYS" & image_id=="4548184_00790"
replace institution_edit="The Elks Club" if clean_priority==2 & street_raw=="NORTH ST MARYS" & image_id=="4548184_00785"
replace st_edit="E Pecan St" if clean_priority==2 & street_raw=="NORTH ST MARYS" & checked_hn==""
replace checked_st="c" if clean_priority==2 & street_raw=="NORTH ST MARYS" & checked_hn==""
replace hn_edit=225 if clean_priority==2 & street_raw=="NORTH ST MARYS" & checked_hn==""
replace checked_hn="c" if clean_priority==2 & street_raw=="NORTH ST MARYS" & checked_hn==""

*Multiple institutions on diff streets
browse if clean_priority==2 & street_raw=="EA TRAVIS"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00791"
replace stname_flag="Travis St" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00791"
replace inst=1 if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00791"
replace institution_edit="Rio Vista Apartments" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00791"
replace st_edit="E Travis" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00791"
replace st_edit="College" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00792"
replace stname_flag="Corner of College St and N St Marys St" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00792"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00792"
replace st_edit="College" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00794"
replace stname_flag="College St and Jefferson" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00794"
replace hn_edit=218 if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00794"
replace checked_hn="c" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00794"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00794"
replace st_edit="Houston St" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00795"
replace stname_flag="E Houston St" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00795"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00795"
replace hn_edit=224 if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00795"
replace hn_flag="224 1/2" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00795"
replace inst=1 if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00795"
replace institution_edit="Jefferson Hotel" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00795"
replace checked_hn="c" if clean_priority==2 & street_raw=="EA TRAVIS" & image_id=="4548184_00795"
replace checked_hn="c, ambiguous" if clean_priority==2 & street_raw=="EA TRAVIS" & checked_hn==""

*Looks like Bowie St, which matches SM
browse if clean_priority==2 & street_raw=="BOME STREET"
replace hn_flag="416 rear" if clean_priority==2 & street_raw=="BOME STREET" & hn==416 & line_num>16
replace hn_flag="426 rear" if clean_priority==2 & street_raw=="BOME STREET" & hn==426
replace st_edit="Bowie St" if clean_priority==2 & street_raw=="BOME STREET"
replace checked_st="c" if clean_priority==2 & street_raw=="BOME STREET"
replace checked_hn="c" if clean_priority==2 & street_raw=="BOME STREET"

*Broad Way in Ancestry; SM has Broadway St
browse if clean_priority==2 & street_raw=="BROAD WAY"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="BROAD WAY"
replace stname_flag="Broadway St" if clean_priority==2 & street_raw=="BROAD WAY"
replace checked_hn="c" if clean_priority==2 & street_raw=="BROAD WAY"

*Ave B in Ancestry which matches map
browse if clean_priority==2 & street_raw=="AV.B."
replace st_edit="Ave B" if clean_priority==2 & street_raw=="AV.B."
replace checked_st="c" if clean_priority==2 & street_raw=="AV.B."
replace checked_hn="c" if clean_priority==2 & street_raw=="AV.B."

*Looks like Swiss St in Ancestry; SM has N Swiss St
browse if clean_priority==2 & street_raw=="SEVIER STREET."
replace st_edit="Swiss St" if clean_priority==2 & street_raw=="SEVIER STREET."
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="SEVIER STREET."
replace stname_flag="N Swiss St" if clean_priority==2 & street_raw=="SEVIER STREET."
replace checked_hn="c" if clean_priority==2 & street_raw=="SEVIER STREET."

*Institution on Broadway St. SM has inst name as only st in ED
browse if clean_priority==2 & street_raw=="BRACKENRIDGE STREET"
replace st_edit="Broadway St" if clean_priority==2 & street_raw=="BRACKENRIDGE STREET"
replace checked_st="c, ancestry match, SM dif ED" if clean_priority==2 & street_raw=="BRACKENRIDGE STREET"
replace checked_hn="c, ambiguous" if clean_priority==2 & street_raw=="BRACKENRIDGE STREET"

*Fort Sam Houston
browse if clean_priority==2 & street_raw=="NOT NEED"
replace st_edit="Fort Sam Houston" if clean_priority==2 & street_raw=="NOT NEED"
replace checked_st="c" if clean_priority==2 & street_raw=="NOT NEED"
replace checked_hn="c" if clean_priority==2 & street_raw=="NOT NEED"

*Palmetto St in Ancestry, N Palmetto Ave in SM
browse if clean_priority==2 & street_raw=="PALMETTO STREET"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="PALMETTO STREET"
replace stname_flag="N Palmetto Ave" if clean_priority==2 & street_raw=="PALMETTO STREET"
replace checked_hn="c" if clean_priority==2 & street_raw=="PALMETTO STREET" 

*Hayes St in Ancestry; Hays St in SM
browse if clean_priority==2 & street_raw=="HAYES ST."
replace checked_st="c, ancestry match, SM missing" if clean_priority==2 & street_raw=="HAYES ST."
replace stname_flag="Hays St" if clean_priority==2 & street_raw=="HAYES ST."
replace checked_hn="c" if clean_priority==2 & street_raw=="HAYES ST."

*Center in Ancestry vs Centre in SM
browse if clean_priority==2 & street_raw=="N CENTER STREET"
replace checked_st="c" if clean_priority==2 & street_raw=="N CENTER STREET"
replace checked_hn="c" if clean_priority==2 & street_raw=="N CENTER STREET"

*Looks like N Center St
browse if clean_priority==2 & street_raw=="CENTEN STREET"
replace hn_edit=1520 if clean_priority==2 & street_raw=="CENTEN STREET" & hn==520
replace hn_flag="1520 rear" if clean_priority==2 & street_raw=="CENTEN STREET" & hn==520
replace st_edit="N Center St" if clean_priority==2 & street_raw=="CENTEN STREET"
replace checked_st="c" if clean_priority==2 & street_raw=="CENTEN STREET"
replace checked_hn="c" if clean_priority==2 & street_raw=="CENTEN STREET"

*S Presa on Ancestry; SM has Presa St
browse if clean_priority==2 & street_raw=="SOUTH PRESA"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="SOUTH PRESA"
replace stname_flag="Presa St" if clean_priority==2 & street_raw=="SOUTH PRESA"
replace hn_edit=1716 if clean_priority==2 & street_raw=="SOUTH PRESA" & hn==1116
replace hn_flag="3603 rear" if clean_priority==2 & street_raw=="SOUTH PRESA" & hn==3603
replace hn_edit=3821 if clean_priority==2 & street_raw=="SOUTH PRESA" & hn==3826
replace checked_hn="c" if clean_priority==2 & street_raw=="SOUTH PRESA"

*Can't find E Lotus St in SM
browse if clean_priority==2 & street_raw=="EAST LOTUS STREET"
replace checked_st="c, ancestry match, SM missing" if clean_priority==2 & street_raw=="EAST LOTUS STREET"
replace checked_hn="c" if clean_priority==2 & street_raw=="EAST LOTUS STREET"

*3/13
*Looks like Mohawk in Ancestry. SM has Mohawk St
browse if clean_priority==2 & street_raw=="MOHAORK"
replace st_edit="Mohawk" if clean_priority==2 & street_raw=="MOHAORK"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="MOHAORK"
replace stname_flag="Mohawk St" if clean_priority==2 & street_raw=="MOHAORK"
replace checked_hn="c" if clean_priority==2 & street_raw=="MOHAORK"

*Can't read street name
browse if clean_priority==2 & image_id=="4548186_00530"
replace checked_st="c, ambiguous" if clean_priority==2 & image_id=="4548186_00530"
replace checked_hn="c" if clean_priority==2 & image_id=="4548186_00530"
replace st_edit="Ferguson" if clean_priority==2 & image_id=="4548186_00530" & line_num==99
replace hn_edit=324 if clean_priority==2 & image_id=="4548186_00530" & line_num==99
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & image_id=="4548186_00530" & line_num==99
replace stname_flag="Ferguson Ave" if clean_priority==2 & image_id=="4548186_00530" & line_num==99

*Institution on 2006 Nebraska. SM has Nebraska St
browse if clean_priority==2 & image_id=="4548186_00531"
replace st_edit="Nebraska" if clean_priority==2 & image_id=="4548186_00531"
replace hn_edit=2006 if clean_priority==2 & image_id=="4548186_00531"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & image_id=="4548186_00531"
replace stname_flag="Nebraska St" if clean_priority==2 & image_id=="4548186_00531"
replace checked_hn="c" if clean_priority==2 & image_id=="4548186_00531"

*Nelson St on Ancestry, Nelson Ave on SM
browse if clean_priority==2 & street_raw=="NELSON ST."
replace hn_flag="apt 2" if clean_priority==2 & street_raw=="NELSON ST." & line_num>87
replace hn_flag="apt 3" if clean_priority==2 & street_raw=="NELSON ST." & line_num>94
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="NELSON ST."
replace stname_flag="Nelson Ave" if clean_priority==2 & street_raw=="NELSON ST."
replace checked_hn="c" if clean_priority==2 & street_raw=="NELSON ST."

*Clark Ave in Ancestry, Clarke St in SM
browse if clean_priority==2 & street_raw=="CLARK AVE"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="CLARK AVE"
replace stname_flag="Clarke St" if clean_priority==2 & street_raw=="CLARK AVE"
replace checked_hn="c" if clean_priority==2 & street_raw=="CLARK AVE"

*Looks like Peck on Ancestry. SM has Peck Ave
browse if clean_priority==2 & street_raw=="PICK" & hn==309
replace st_edit="Peck" if clean_priority==2 & street_raw=="PICK"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="PICK"
replace stname_flag="Peck Ave" if clean_priority==2 & street_raw=="PICK"
replace checked_hn="c" if clean_priority==2 & street_raw=="PICK"

*S Presa in Ancestry, SM has Presa St
browse if clean_priority==2 & street_raw=="S PRESA"
replace hn_edit=209 if clean_priority==2 & street_raw=="S PRESA" & hn==309
replace hn_edit=215 if clean_priority==2 & street_raw=="S PRESA" & hn==116 & line_num>28
replace hn_edit=207 if clean_priority==2 & street_raw=="S PRESA" & hn==116 & line_num>43
replace hn_edit=116 if clean_priority==2 & street_raw=="S PRESA" & hn==116 & line_num<38
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==2 & street_raw=="S PRESA"
replace stname_flag="Presa St" if clean_priority==2 & street_raw=="S PRESA"
replace checked_hn="c" if clean_priority==2 & street_raw=="S PRESA"

*Ancestry has Haynes Ave but SM has Haynes St
browse if clean_priority==2 & street_raw=="HAYNES AVENUE"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="HAYNES AVENUE"
replace stname_flag="Haynes St" if clean_priority==2 & street_raw=="HAYNES AVENUE"
replace checked_hn="c" if clean_priority==2 & street_raw=="HAYNES AVENUE"

*Eads St in Ancestry; Eads Ave in SM
browse if clean_priority==2 & street_raw=="EADS STREET"
replace hn_edit=127 if clean_priority==2 & street_raw=="EADS STREET" & hn==727
*Manually changed hn_edit from 137 to 125 for lines 29 and 30
replace checked_st="c, ancestry match, SM diff type" if clean_priority==2 & street_raw=="EADS STREET"
replace stname_flag="Eads Ave" if clean_priority==2 & street_raw=="EADS STREET"
replace checked_hn="c" if clean_priority==2 & street_raw=="EADS STREET"

*Supplemental Sheet. Might be on Eads St/Ave
browse if clean_priority==2 & image_id=="4548187_00463"
replace hn_flag="414 rear" if clean_priority==2 & image_id=="4548187_00463"
replace st_edit="Eads St" if clean_priority==2 & image_id=="4548187_00463"
replace checked_st="c, ambiguous" if clean_priority==2 & image_id=="4548187_00463"
replace stname_flag="Eads Ave" if clean_priority==2 & image_id=="4548187_00463"
replace checked_hn="c" if clean_priority==2 & image_id=="4548187_00463"
replace institution_edit="" if clean_priority==2 & image_id=="4548187_00463"
replace inst=0 if clean_priority==2 & image_id=="4548187_00463"

*Can't find address of institution
browse if clean_priority==2 & institution=="Saint John's Seminary"
replace checked_st="c, ambiguous" if clean_priority==2 & institution=="Saint John's Seminary"
replace checked_hn="c, ambiguous" if clean_priority==2 & institution=="Saint John's Seminary"

*Clean Priority 2 Finished

*S Presa St in Ancestry; Presa St in SM in diff ED
browse if clean_priority==3 & street_raw=="S. PRESA STREET"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_raw=="S. PRESA STREET"
replace stname_flag="Presa St" if clean_priority==3 & street_raw=="S. PRESA STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="S. PRESA STREET"

*Ancestry has E Main Plaza, SM has Main Pz St
browse if clean_priority==3 & street_raw=="EAST MAIN PLAZA"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="EAST MAIN PLAZA"
replace stname_flag="Main Pz St" if clean_priority==3 & street_raw=="EAST MAIN PLAZA"
replace checked_hn="c" if clean_priority==3 & street_raw=="EAST MAIN PLAZA"

*W Commerce St on Ancestry matches SM
browse if clean_priority==3 & street_raw=="WEST COMMERCE STREET"
replace hn_edit=722 if clean_priority==3 & street_raw=="WEST COMMERCE STREET" & hn==720 & line_num>21
replace hn_edit=1410 if clean_priority==3 & street_raw=="WEST COMMERCE STREET" & hn==14108
replace hn_flag="1410 1/2" if clean_priority==3 & street_raw=="WEST COMMERCE STREET" & hn==14108
replace checked_st="c" if clean_priority==3 & street_raw=="WEST COMMERCE STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="WEST COMMERCE STREET"

*Looks like Shiners Aly, which matches SM
browse if clean_priority==3 & street_raw=="SHIVER ALLY"
replace hn_flag=hn_raw if clean_priority==3 & street_raw=="SHIVER ALLY"
*Manually changed hn_flag from 3B to 8B
*Manually entered hn_edit values
replace st_edit="Shiners Aly" if clean_priority==3 & street_raw=="SHIVER ALLY"
replace checked_st="c" if clean_priority==3 & street_raw=="SHIVER ALLY"
replace checked_hn="c" if clean_priority==3 & street_raw=="SHIVER ALLY"

*3/15
*E Richie St in Ancestry; SM has similar Rische St
browse if clean_priority==3 & street_raw=="E RICHIE ST"
replace hn_edit=201 if clean_priority==3 & street_raw=="E RICHIE ST" & hn_raw=="F2"
replace hn_edit=224 if clean_priority==3 & street_raw=="E RICHIE ST" & hn==228
replace st_edit="E Richie St" if clean_priority==3 & street_raw=="E RICHIE ST"
replace checked_st="c, ancestry match, SM missing" if clean_priority==3 & street_raw=="E RICHIE ST"
replace stname_flag="Rische St" if clean_priority==3 & street_raw=="E RICHIE ST"
replace checked_hn="c" if clean_priority==3 & street_raw=="E RICHIE ST"

browse if clean_priority==3 & street_raw=="E. RICHIE ST"
replace checked_st="c, ancestry match, SM missing" if clean_priority==3 & street_raw=="E. RICHIE ST"
replace stname_flag="Rische St" if clean_priority==3 & street_raw=="E. RICHIE ST"
replace checked_hn="c" if clean_priority==3 & street_raw=="E. RICHIE ST"

*Ancestry just says "unnamed"
browse if clean_priority==3 & street_raw=="UNAMED"
replace st_edit="" if clean_priority==3 & street_raw=="UNAMED"
replace stname_flag="Unnamed" if clean_priority==3 & street_raw=="UNAMED"
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="UNAMED"
replace checked_hn="c" if clean_priority==3 & street_raw=="UNAMED"

*Probably W Cellovos in Ancestry. SM has similar Cevallos St
browse if clean_priority==3 & image_id=="4547939_00664"
replace st_edit="W Cellovos" if clean_priority==3 & image_id=="4547939_00664"
replace checked_st="c, ancestry match, SM missing" if clean_priority==3 & image_id=="4547939_00664"
replace stname_flag="Cevallos St" if clean_priority==3 & image_id=="4547939_00664"
replace checked_hn="c" if clean_priority==3 & image_id=="4547939_00664"

*Cass on Ancestry; Cass Ave on SM
browse if clean_priority==3 & street_raw=="CASS"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="CASS"
replace stname_flag="Cass Ave" if clean_priority==3 & street_raw=="CASS"
replace checked_hn="c" if clean_priority==3 & street_raw=="CASS"

*Glass in Ancestry; Glass Ave in SM
browse if clean_priority==3 & street_raw=="GLOSS"
replace st_edit="Glass" if clean_priority==3 & street_raw=="GLOSS"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="GLOSS"
replace stname_flag="Glass Ave" if clean_priority==3 & street_raw=="GLOSS"
replace checked_hn="c" if clean_priority==3 & street_raw=="GLOSS"

*E Baylor in Ancestry; Baylor St in SM
browse if clean_priority==3 & street_raw=="E. BAYLOR"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="E. BAYLOR"
replace stname_flag="Baylor St" if clean_priority==3 & street_raw=="E. BAYLOR"
replace checked_hn="c" if clean_priority==3 & street_raw=="E. BAYLOR"

*W Baylor in Ancestry; Baylor St in SM
browse if clean_priority==3 & street_raw=="W. BAYLOR"
replace hn_edit=908 if clean_priority==3 & street_raw=="W. BAYLOR" & hn==408
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="W. BAYLOR"
replace stname_flag="Baylor St" if clean_priority==3 & street_raw=="W. BAYLOR"
replace checked_hn="c" if clean_priority==3 & street_raw=="W. BAYLOR"

*San Franciscan St in Ancestry; SM has simlar Franciscan Ave
browse if clean_priority==3 & street_raw=="SAN FRANCISCAN STREET"
replace checked_st="c, ancestry match, SM missing" if clean_priority==3 & street_raw=="SAN FRANCISCAN STREET"
replace stname_flag="Franciscan Ave" if clean_priority==3 & street_raw=="SAN FRANCISCAN STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="SAN FRANCISCAN STREET"

*Looks like Golondrina St in Ancestry; SM has Golondrina Ave
browse if clean_priority==3 & street_raw=="GOTON DRINE STREET"
replace st_edit="Golondrina St" if clean_priority==3 & street_raw=="GOTON DRINE STREET"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="GOTON DRINE STREET"
replace stname_flag="Golondrina Ave" if clean_priority==3 & street_raw=="GOTON DRINE STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="GOTON DRINE STREET"

*Chico Aly in Ancestry but missing in SM
browse if clean_priority==3 & street_raw=="CHICO ALLEY"
replace checked_st="c, ancestry match, SM missing" if clean_priority==3 & street_raw=="CHICO ALLEY"
replace checked_hn="c" if clean_priority==3 & street_raw=="CHICO ALLEY"

*Sims St in Ancestry; Sims Ave in SM
browse if clean_priority==3 & street_raw=="SIMS ST"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="SIMS ST"
replace stname_flag="Sims Ave" if clean_priority==3 & street_raw=="SIMS ST"
replace checked_hn="c" if clean_priority==3 & street_raw=="SIMS ST"

*Looks like Dourau in Ancestry; SM has Dourau St
browse if clean_priority==3 & street_raw=="DOURAN"
replace st_edit="Dourau" if clean_priority==3 & street_raw=="DOURAN"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="DOURAN"
replace stname_flag="Dourau St" if clean_priority==3 & street_raw=="DOURAN"
replace checked_hn="c" if clean_priority==3 & street_raw=="DOURAN"

*S Flores in Ancestry; S Flores St in SM
browse if clean_priority==3 & street_raw=="SOUTH FLORES"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="SOUTH FLORES"
replace stname_flag="S Flores St" if clean_priority==3 & street_raw=="SOUTH FLORES"
replace checked_hn="c" if clean_priority==3 & street_raw=="SOUTH FLORES"

*Walton Ave in Ancestry; Walton St in SM
browse if clean_priority==3 & street_raw=="WALTON AVE"
replace hn_edit=119 if clean_priority==3 & street_raw=="WALTON AVE" & hn==117
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="WALTON AVE"
replace stname_flag="Walton St" if clean_priority==3 & street_raw=="WALTON AVE"
replace checked_hn="c" if clean_priority==3 & street_raw=="WALTON AVE"

*Frio City Road in Ancestry; SM has it in diff ED
browse if clean_priority==3 & street_raw=="FRIO CITY ROAD"
*Manually removed hn_edit values
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_raw=="FRIO CITY ROAD"
replace checked_hn="c, ambiguous" if clean_priority==3 & street_raw=="FRIO CITY ROAD"

*Looks like W Commerce in Ancestry. SM has W Commerce St
browse if clean_priority==3 & street_raw=="N. COMMERE"
replace st_edit="W Commerce" if clean_priority==3 & street_raw=="N. COMMERE"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="N. COMMERE"
replace stname_flag="W Commerce St" if clean_priority==3 & street_raw=="N. COMMERE"
replace checked_hn="c" if clean_priority==3 & street_raw=="N. COMMERE"

*Hard to read but looks like Concho in Ancestry. SM has S Concho St
browse if clean_priority==3 & street_raw=="CONAL"
replace hn_edit=218 if clean_priority==3 & street_raw=="CONAL" & line_num==4
replace st_edit="Concho" if clean_priority==3 & street_raw=="CONAL"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="CONAL"
replace stname_flag="S Concho St" if clean_priority==3 & street_raw=="CONAL"
replace checked_hn="c" if clean_priority==3 & street_raw=="CONAL"

*3/16
*Nueva in Ancestry. Can't tell if E or W, which are both in diff EDs
browse if clean_priority==3 & street_raw=="NUEVA"
replace checked_hn="c" if clean_priority==3 & street_raw=="NUEVA"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="NUEVA"
replace stname_flag="E/W Nueva St" if clean_priority==3 & street_raw=="NUEVA"

*Sta Rosa in Ancestry; SM has Santa Rosa Ave
browse if clean_priority==3 & street_raw=="STA ROSA"
replace st_edit="Santa Rosa" if clean_priority==3 & street_raw=="STA ROSA"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="STA ROSA"
replace stname_flag="Santa Rosa Ave" if clean_priority==3 & street_raw=="STA ROSA"
replace checked_hn="c" if clean_priority==3 & street_raw=="STA ROSA"

*Looks like Matamoras in Ancestry; SM has Matamoras St
browse if clean_priority==3 & street_raw=="MATSONOLOS"
replace hn_edit=105 if clean_priority==3 & street_raw=="MATSONOLOS" & line_num<16
replace st_edit="Matamoras" if clean_priority==3 & street_raw=="MATSONOLOS"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="MATSONOLOS"
replace stname_flag="Matamoras St" if clean_priority==3 & street_raw=="MATSONOLOS"
replace checked_hn="c" if clean_priority==3 & street_raw=="MATSONOLOS"

*South San Saba in Ancestry is probably a mistake; SM has a similar S San Saba St
browse if clean_priority==3 & street_raw=="SOUTH SOUTH SABA"
replace st_edit="S San Saba" if clean_priority==3 & street_raw=="SOUTH SOUTH SABA"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="SOUTH SOUTH SABA"
replace stname_flag="S San Saba St" if clean_priority==3 & street_raw=="SOUTH SOUTH SABA"
replace checked_hn="c, ambiguous" if clean_priority==3 & street_raw=="SOUTH SOUTH SABA" & hn==426
replace checked_hn="c" if clean_priority==3 & street_raw=="SOUTH SOUTH SABA" & checked_hn==""

*Corner of S San Saba St and Durango St.  Matches SM 
browse if clean_priority==3 & street_raw=="CORNER SOUTH SAN SABA AND DURANG"
replace st_edit="S San Saba St" if clean_priority==3 & street_raw=="CORNER SOUTH SAN SABA AND DURANG"
replace checked_st="c" if clean_priority==3 & street_raw=="CORNER SOUTH SAN SABA AND DURANG"
replace stname_flag="Corner of S San Saba St and Durango St" if clean_priority==3 & street_raw=="CORNER SOUTH SAN SABA AND DURANG"
*Manually removed hn_edit values
replace checked_hn="c, ambiguous" if clean_priority==3 & street_raw=="CORNER SOUTH SAN SABA AND DURANG"

*Looks like San Fernando in Ancestry; SM has San Fernando St
browse if clean_priority==3 & street_raw=="SAN FRANCISCO"
replace st_edit="San Fernando" if clean_priority==3 & street_raw=="SAN FRANCISCO"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="SAN FRANCISCO"
replace checked_hn="c" if clean_priority==3 & street_raw=="SAN FRANCISCO"
replace stname_flag="San Fernando St" if clean_priority==3 & street_raw=="SAN FRANCISCO"

browse if clean_priority==3 & street_raw=="S. FERNANDO"
replace hn_flag="117 rear" if clean_priority==3 & street_raw=="S. FERNANDO" & line_num>97
replace st_edit="San Fernando" if clean_priority==3 & street_raw=="S. FERNANDO"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="S. FERNANDO"
replace stname_flag="San Fernando St" if clean_priority==3 & street_raw=="S. FERNANDO"
replace checked_hn="c" if clean_priority==3 & street_raw=="S. FERNANDO"

*S Pecos in Ancestry; SM has S Pecos St
browse if clean_priority==3 & image_id=="4547940_00378"
replace st_edit="S Pecos" if clean_priority==3 & image_id=="4547940_00378"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & image_id=="4547940_00378"
replace stname_flag="S Pecos St" if clean_priority==3 & image_id=="4547940_00378"
replace checked_hn="c" if clean_priority==3 & image_id=="4547940_00378"

*Ancestry has Buena Vista St and S Pecos St, which both match SM
browse if clean_priority==3 & street_raw=="PEROS ST"
replace st_edit="Buena Vista St" if clean_priority==3 & street_raw=="PEROS ST" & hn>300
replace st_edit="S Pecos St" if clean_priority==3 & street_raw=="PEROS ST" & hn<300
replace checked_st="c" if clean_priority==3 & street_raw=="PEROS ST"
replace checked_hn="c" if clean_priority==3 & street_raw=="PEROS ST"

*Ancestry and SM match
browse if clean_priority==3 & street_raw=="MATAMORAS STREET"
replace checked_st="c" if clean_priority==3 & street_raw=="MATAMORAS STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="MATAMORAS STREET"

*S Frio St in Ancestry; matches SM
browse if clean_priority==3 & image_id=="4547940_00512"
replace hn_edit=810 if clean_priority==3 & image_id=="4547940_00512" & hn==1
replace hn_edit=810 if clean_priority==3 & image_id=="4547940_00512" & hn==2
replace st_edit="S Frio St" if clean_priority==3 & image_id=="4547940_00512"
replace checked_st="c" if clean_priority==3 & image_id=="4547940_00512"
replace checked_hn="c" if clean_priority==3 & image_id=="4547940_00512"

*S Leona St in Ancestry and SM
browse if clean_priority==3 & street_raw=="SO LEONA STREET"
replace hn_flag="APT 4 814 rear" if clean_priority==3 & street_raw=="SO LEONA STREET" & image_id=="4547940_00519" & line_num<93
replace hn_flag="APT 3 814 rear" if clean_priority==3 & street_raw=="SO LEONA STREET" & image_id=="4547940_00519" & hn_flag==""
replace hn_edit=814 if clean_priority==3 & street_raw=="SO LEONA STREET" & image_id=="4547940_00519" 
replace hn_edit=804 if clean_priority==3 & street_raw=="SO LEONA STREET" & image_id=="4547940_00520" 
replace hn_flag=hn_raw if clean_priority==3 & street_raw=="SO LEONA STREET" & hn_flag==""
replace hn_edit=1024 if clean_priority==3 & street_raw=="SO LEONA STREET" & image_id=="4547940_00557"
replace checked_hn="c" if clean_priority==3 & street_raw=="SO LEONA STREET"
replace checked_st="c" if clean_priority==3 & street_raw=="SO LEONA STREET"

*S Laredo St in Ancestry and SM
browse if clean_priority==3 & street_raw=="SO LAREDO STREET"
replace hn_flag="Apt 1" if clean_priority==3 & street_raw=="SO LAREDO STREET" & line_num>96
replace hn_flag="Apt 1" if clean_priority==3 & street_raw=="SO LAREDO STREET" & line_num<4
replace hn_flag="Apt 13" if clean_priority==3 & street_raw=="SO LAREDO STREET" & line_num>21 & line_num<27
replace hn_flag="Apt 14" if clean_priority==3 & street_raw=="SO LAREDO STREET" & line_num>26 & line_num<30
replace hn_flag="Apt 24" if clean_priority==3 & street_raw=="SO LAREDO STREET" & line_num>36 & line_num<40
replace hn_flag="Apt 7" if clean_priority==3 & street_raw=="SO LAREDO STREET" & hn_flag==""
replace hn_edit=819 if clean_priority==3 & street_raw=="SO LAREDO STREET"
*Manually changed last hn_edit value to 907
replace checked_st="c" if clean_priority==3 & street_raw=="SO LAREDO STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="SO LAREDO STREET"

*Commerce St in Ancestry; SM has W Commerce St
browse if clean_priority==3 & street_raw=="COMMEROE STREET"
replace hn_edit=1820 if clean_priority==3 & street_raw=="COMMEROE STREET" & hn==1320
replace st_edit="Commerce St" if clean_priority==3 & street_raw=="COMMEROE STREET"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="COMMEROE STREET"
replace stname_flag="W Commerce St" if clean_priority==3 & street_raw=="COMMEROE STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="COMMEROE STREET"

*San Fernando St in Ancestry and SM
browse if clean_priority==3 & street_raw=="SAN FERNANDO"
replace hn_flag="1105 rear" if clean_priority==3 & street_raw=="SAN FERNANDO" & image_id=="4547940_00719"
replace hn_edit=1108 if clean_priority==3 & street_raw=="SAN FERNANDO" & hn==108
replace hn_edit=1106 if clean_priority==3 & street_raw=="SAN FERNANDO" & hn==110
replace st_edit="San Fernando St" if clean_priority==3 & street_raw=="SAN FERNANDO"
replace checked_st="c" if clean_priority==3 & street_raw=="SAN FERNANDO"
replace checked_hn="c" if clean_priority==3 & street_raw=="SAN FERNANDO"

*S Pinto St in Ancestry; SM has Pinto St
browse if clean_priority==3 & street_raw=="S. PINTO"
replace hn_edit=315 if clean_priority==3 & street_raw=="S. PINTO" & hn==313
replace st_edit="S Pinto St" if clean_priority==3 & street_raw=="S. PINTO"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="S. PINTO"
replace checked_hn="c" if clean_priority==3 & street_raw=="S. PINTO"
replace stname_flag="Pinto St" if clean_priority==3 & street_raw=="S. PINTO"

*S Smith St in Ancestry and SM
browse if clean_priority==3 & street_raw=="SO SMITH ST"
replace hn_edit=811 if clean_priority==3 & street_raw=="SO SMITH ST"
replace hn_flag="811 1/2 rear" if clean_priority==3 & street_raw=="SO SMITH ST"
replace checked_st="c" if clean_priority==3 & street_raw=="SO SMITH ST"
replace checked_hn="c" if clean_priority==3 & street_raw=="SO SMITH ST"

*Dunn St in Ancestry; Dunn Aly in SM
browse if clean_priority==3 & street_precleanedhn=="Dunn St"
replace hn_edit=209 if clean_priority==3 & street_precleanedhn=="Dunn St" & image_id=="4547940_00846" & line_num<4
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Dunn St"
replace stname_flag="Dunn Aly" if clean_priority==3 & street_precleanedhn=="Dunn St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Dunn St"

*Hard to read st name. Could be Nueces St
browse if clean_priority==3 & street_raw=="ST MURCES ST"
replace hn_edit=816 if clean_priority==3 & street_raw=="ST MURCES ST" & hn==813
replace hn_flag="816 1/2" if clean_priority==3 & street_raw=="ST MURCES ST" & hn==813
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="ST MURCES ST"
replace stname_flag="Nueces St" if clean_priority==3 & street_raw=="ST MURCES ST"
replace checked_hn="c" if clean_priority==3 & street_raw=="ST MURCES ST"

*Looks like Montezuma St in Ancestry; SM has Montezuma Aly
browse if clean_priority==3 & street_raw=="MONTAZUMA STREET"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="MONTAZUMA STREET"
replace stname_flag="Montezuma Aly" if clean_priority==3 & street_raw=="MONTAZUMA STREET"
replace st_edit="Montezuma St" if clean_priority==3 & street_raw=="MONTAZUMA STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="MONTAZUMA STREET"

*Can't tell what street it is. Could be San Carlos but not enough evidence
browse if clean_priority==3 & image_id=="4547940_00983"
replace checked_st="c, ambiguous" if clean_priority==3 & image_id=="4547940_00983"
replace checked_hn="c" if clean_priority==3 & image_id=="4547940_00983"

*Orleans in Ancestry; SM has Orleans St
browse if clean_priority==3 & street_raw=="ORELANS"
replace st_edit="Orleans" if clean_priority==3 & street_raw=="ORELANS"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="ORELANS"
replace stname_flag="Orleans St" if clean_priority==3 & street_raw=="ORELANS"
replace checked_hn="c" if clean_priority==3 & street_raw=="ORELANS"

*3/20
*W El Paso in Ancestry but Sm has El Paso St
browse if clean_priority==3 & street_raw=="W. EL PASO"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="W. EL PASO"
replace stname_flag="El Paso St" if clean_priority==3 & street_raw=="W. EL PASO"
replace checked_hn="c" if clean_priority==3 & street_raw=="W. EL PASO"

*S Nueces in Ancestry; SM has Nueces St
browse if clean_priority==3 & street_raw=="S. NUECES"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="S. NUECES"
replace stname_flag="Nueces St" if clean_priority==3 & street_raw=="S. NUECES"
replace checked_hn="c" if clean_priority==3 & street_raw=="S. NUECES"

*Durango St and S Trinity on Ancestry; SM has Durango St and S Trinity St
browse if clean_priority==3 & image_id=="4548182_00195"
replace st_edit="Durango St" if clean_priority==3 & image_id=="4548182_00195" & hn>1000
replace st_edit="S Trinity" if clean_priority==3 & image_id=="4548182_00195" & hn<1000
replace checked_st="c" if clean_priority==3 & image_id=="4548182_00195" & hn>1000
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & image_id=="4548182_00195" & hn<1000
replace stname_flag="S Trinity St" if clean_priority==3 & image_id=="4548182_00195" & hn<1000
replace checked_hn="c" if clean_priority==3 & image_id=="4548182_00195"

*Says "not numbered" on Ancestry, but stname matches Ancestry and SM
browse if clean_priority==3 & street_raw=="DEL VALLE ALLEY-NOT NUMBERED"
replace st_edit="Del Valle Aly" if clean_priority==3 & street_raw=="DEL VALLE ALLEY-NOT NUMBERED"
replace stname_flag="Not numbered" if clean_priority==3 & street_raw=="DEL VALLE ALLEY-NOT NUMBERED"
replace checked_st="c" if clean_priority==3 & street_raw=="DEL VALLE ALLEY-NOT NUMBERED"
replace checked_hn="c" if clean_priority==3 & street_raw=="DEL VALLE ALLEY-NOT NUMBERED"

browse if clean_priority==3 & street_raw=="DEL VALLE ALLEY NOT NUMBERED"
replace hn_edit=217 if clean_priority==3 & street_raw=="DEL VALLE ALLEY NOT NUMBERED" & hn==218 & line_num>46
replace st_edit="Del Valle Aly" if clean_priority==3 & street_raw=="DEL VALLE ALLEY NOT NUMBERED"
replace stname_flag="Not Numbered" if clean_priority==3 & street_raw=="DEL VALLE ALLEY NOT NUMBERED"
replace checked_st="c" if clean_priority==3 & street_raw=="DEL VALLE ALLEY NOT NUMBERED"
replace checked_hn="c" if clean_priority==3 & street_raw=="DEL VALLE ALLEY NOT NUMBERED"

*Actually two different streets, possibly three
browse if clean_priority==3 & street_raw=="SOUTH ROSILLO"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="SOUTH ROSILLO" & image_id=="4548182_00296"
replace stname_flag="Rosillos St" if clean_priority==3 & street_raw=="SOUTH ROSILLO" & image_id=="4548182_00296"
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="SOUTH ROSILLO" & image_id=="4548182_00297"
replace stname_flag="S Hamilton Ave" if clean_priority==3 & street_raw=="SOUTH ROSILLO" & image_id=="4548182_00297" 
replace hn_edit=701 if clean_priority==3 & street_raw=="SOUTH ROSILLO" & checked_st==""
replace st_edit="S Zarzamora" if clean_priority==3 & street_raw=="SOUTH ROSILLO" & image_id=="4548182_00298"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="SOUTH ROSILLO" & image_id=="4548182_00298"
replace stname_flag="S Zarzamora St" if clean_priority==3 & street_raw=="SOUTH ROSILLO" & image_id=="4548182_00298"
replace checked_hn="c" if clean_priority==3 & street_raw=="SOUTH ROSILLO"

*W 19h St in Ancestry; SM has SW 19th St
browse if clean_priority==3 & street_raw=="W. 19TH ST"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="W. 19TH ST"
replace stname_flag="SW 19th St" if clean_priority==3 & street_raw=="W. 19TH ST"
replace checked_hn="c" if clean_priority==3 & street_raw=="W. 19TH ST"

*SM has Linwood Blvd in a completely diff ED
browse if clean_priority==3 & street_raw=="LINWOOD ST."
replace checked_st="c, ancestry match, SM missing" if clean_priority==3 & street_raw=="LINWOOD ST."
replace checked_hn="c" if clean_priority==3 & street_raw=="LINWOOD ST."

*Colima St in Ancestry; matches SM
browse if clean_priority==3 & street_raw=="COLIMA STREET NOCESES ALL IN ONE"
replace st_edit="Colima St" if clean_priority==3 & street_raw=="COLIMA STREET NOCESES ALL IN ONE"
replace checked_st="c" if clean_priority==3 & street_raw=="COLIMA STREET NOCESES ALL IN ONE"
replace stname_flag="House all in one block, numbered badly" if clean_priority==3 & street_raw=="COLIMA STREET NOCESES ALL IN ONE"
replace checked_hn="c" if clean_priority==3 & street_raw=="COLIMA STREET NOCESES ALL IN ONE"

*Loma Vista St in Ancestry but SM has it as an Aly. Some houses have no number
browse if clean_priority==3 & street_raw=="LOMA VISTA STREET"
replace hn_flag="No #" if clean_priority==3 & street_raw=="LOMA VISTA STREET" & line_num>80
replace hn_flag="No #" if clean_priority==3 & street_raw=="LOMA VISTA STREET" & line_num<25
replace checked_hn="c, ambiguous" if clean_priority==3 & street_raw=="LOMA VISTA STREET" & hn_flag!=""
replace checked_hn="c" if clean_priority==3 & street_raw=="LOMA VISTA STREET" & hn_flag==""
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="LOMA VISTA STREET"
replace stname_flag="Loma Vista Aly" if clean_priority==3 & street_raw=="LOMA VISTA STREET"

*W Martin in Ancestry. SM has Martin St in diff ED
browse if clean_priority==3 & street_raw=="W. MARTIN"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_raw=="W. MARTIN"
replace stname_flag="Martin St" if clean_priority==3 & street_raw=="W. MARTIN"
replace checked_hn="c" if clean_priority==3 & street_raw=="W. MARTIN"

browse if clean_priority==3 & street_raw=="WEST MARTIN"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_raw=="WEST MARTIN"
replace stname_flag="Martin St" if clean_priority==3 & street_raw=="WEST MARTIN"
replace checked_hn="c" if clean_priority==3 & street_raw=="WEST MARTIN"

*Seems like N Pecos in Ancestry; SM has N Pecos St
browse if clean_priority==3 & image_id=="4548182_00545"
replace st_edit="N Pecos" if clean_priority==3 & image_id=="4548182_00545"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & image_id=="4548182_00545"
replace stname_flag="N Pecos St" if clean_priority==3 & image_id=="4548182_00545"
replace checked_hn="c" if clean_priority==3 & image_id=="4548182_00545"

*W Salinas in Ancestry; SM has W Salinas St
browse if clean_priority==3 & street_raw=="WEST SABINAS"
replace st_edit="W Salinas" if clean_priority==3 & street_raw=="WEST SABINAS"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="WEST SABINAS"
replace stname_flag="W Salinas St" if clean_priority==3 & street_raw=="WEST SABINAS"
*Manually edited last hn_edit values
replace st_edit="N Leona" if clean_priority==3 & street_raw=="WEST SABINAS" & hn_edit==308
replace stname_flag="N Leona St" if clean_priority==3 & street_raw=="WEST SABINAS" & hn_edit==308
replace checked_hn="c" if clean_priority==3 & street_raw=="WEST SABINAS"

*3/21
*Ancestry matches SM
browse if clean_priority==3 & street_raw=="N. LEONA STREET"
replace hn_flag=hn_raw if clean_priority==3 & street_raw=="N. LEONA STREET" & hn_flag==""
replace hn_edit=511 if clean_priority==3 & street_raw=="N. LEONA STREET"
replace checked_st="c" if clean_priority==3 & street_raw=="N. LEONA STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="N. LEONA STREET"

*Looks like W Salinas St, which matches SM
browse if clean_priority==3 & street_raw=="W. SABINAS STREET"
replace hn_edit=909 if clean_priority==3 & street_raw=="W. SABINAS STREET" & hn==904
replace hn_flag="rear" if clean_priority==3 & street_raw=="W. SABINAS STREET" & hn==904 & line_num>71
*Manually added "rear" to hn_flag for hn==915
replace st_edit="W Salinas St" if clean_priority==3 & street_raw=="W. SABINAS STREET"
replace checked_st="c" if clean_priority==3 & street_raw=="W. SABINAS STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="W. SABINAS STREET"

*Looks like Salinas St in Ancestry; SM has W Salinas St
browse if clean_priority==3 & street_precleanedhn=="Sabinas St"
replace hn_flag="Rear" if clean_priority==3 & street_precleanedhn=="Sabinas St" & hn==914 & line_num>17
replace hn_flag="Rear" if clean_priority==3 & street_precleanedhn=="Sabinas St" & hn==910 & line_num>30
replace hn_edit=1707 if clean_priority==3 & street_precleanedhn=="Sabinas St" & hn==407
replace hn_flag="1707 Rear" if clean_priority==3 & street_precleanedhn=="Sabinas St" & hn==407
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="Sabinas St"
replace stname_flag="W Salinas St" if clean_priority==3 & street_precleanedhn=="Sabinas St"
replace st_edit="Salinas St" if clean_priority==3 & street_precleanedhn=="Sabinas St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Sabinas St"
replace st_edit="N San Marcos St" if clean_priority==3 & street_precleanedhn=="Sabinas St" & hn==319
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="Sabinas St" & hn==319
replace stname_flag="" if clean_priority==3 & street_precleanedhn=="Sabinas St" & hn==319

*Looks like San Marcos in Ancestry; SM has N San Marcos St
browse if clean_priority==3 & street_raw=="SAN MARCAO"
replace st_edit="San Marcos" if clean_priority==3 & street_raw=="SAN MARCAO"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="SAN MARCAO"
replace stname_flag="N San Marcos St" if clean_priority==3 & street_raw=="SAN MARCAO"
replace checked_hn="c" if clean_priority==3 & street_raw=="SAN MARCAO"

*Looks like Colorado in Ancestry; SM has N Colorado St
browse if clean_priority==3 & street_raw=="COLOREDO"
replace st_edit="Colorado" if clean_priority==3 & street_raw=="COLOREDO"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="COLOREDO"
replace stname_flag="N Colorado St" if clean_priority==3 & street_raw=="COLOREDO"
replace checked_hn="c" if clean_priority==3 & street_raw=="COLOREDO"

*Lake View St in Ancestry; SM has Lakeview Ave
browse if clean_priority==3 & street_raw=="LAKE VIEW STREET"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="LAKE VIEW STREET"
replace stname_flag="Lakeview Ave" if clean_priority==3 & street_raw=="LAKE VIEW STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="LAKE VIEW STREET"

*Looks like W Salinas St on Ancestry; matches SM
browse if clean_priority==3 & street_raw=="W SABINAS ST"
replace hn_edit=1519 if clean_priority==3 & street_raw=="W SABINAS ST" & hn==1515 & line_num<47
replace st_edit="W Salinas St" if clean_priority==3 & street_raw=="W SABINAS ST"
replace checked_st="c" if clean_priority==3 & street_raw=="W SABINAS ST"
replace checked_hn="c" if clean_priority==3 & street_raw=="W SABINAS ST"

*Peche Aly in Ancestry but SM has Peche St
browse if clean_priority==3 & street_raw=="PECHE ALLEY"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="PECHE ALLEY"
replace stname_flag="Peche St" if clean_priority==3 & street_raw=="PECHE ALLEY"
replace checked_hn="c" if clean_priority==3 & street_raw=="PECHE ALLEY"

*Camada Aly in Ancestry; SM has Camada St in neighboring ED
browse if clean_priority==3 & street_raw=="CAMADA ALLEY"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_raw=="CAMADA ALLEY"
replace stname_flag="Camada St" if clean_priority==3 & street_raw=="CAMADA ALLEY"
replace checked_hn="c" if clean_priority==3 & street_raw=="CAMADA ALLEY"

*Jesus St in ANcestry but SM has Jesus Aly
browse if clean_priority==3 & street_raw=="JESUS ST."
replace hn_edit=114 if clean_priority==3 & street_raw=="JESUS ST." & hn==116
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="JESUS ST."
replace stname_flag="Jesus Aly" if clean_priority==3 & street_raw=="JESUS ST."
replace checked_hn="c" if clean_priority==3 & street_raw=="JESUS ST."

*W Travis in Ancestry; Travis St in SM
browse if clean_priority==3 & street_raw=="W. TRAVIS"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="W. TRAVIS"
replace stname_flag="Travis St" if clean_priority==3 & street_raw=="W. TRAVIS"
replace checked_hn="c" if clean_priority==3 & street_raw=="W. TRAVIS"

*Looks like Lois on Ancestry; SM has Lois St
browse if clean_priority==3 & street_raw=="LOUIS"
replace st_edit="Lois" if clean_priority==3 & street_raw=="LOUIS"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="LOUIS"
replace stname_flag="Lois St" if clean_priority==3 & street_raw=="LOUIS"
replace checked_hn="c" if clean_priority==3 & street_raw=="LOUIS"

*Bailey in Ancestry, not in same ED in SM
browse if clean_priority==3 & street_raw=="BAILEY"
replace hn_flag="No number" if clean_priority==3 & street_raw=="BAILEY" & hn==115 & line_num>42
replace checked_st="c, ancestry match, SM missing" if clean_priority==3 & street_raw=="BAILEY"
replace checked_hn="c" if clean_priority==3 & street_raw=="BAILEY"

*Flann Aly in Ancestry; SM has Flann St
browse if clean_priority==3 & street_raw=="FLANN ALLEY"
replace hn_flag="No number" if clean_priority==3 & street_raw=="FLANN ALLEY" & hn==118 & line_num>14
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="FLANN ALLEY"
replace stname_flag="Flann St" if clean_priority==3 & street_raw=="FLANN ALLEY"
replace checked_hn="c" if clean_priority==3 & street_raw=="FLANN ALLEY"

*Looks like W Houston St in Ancestry; matches SM
browse if clean_priority==3 & image_id=="4548182_00999"
replace st_edit="W Houston St" if clean_priority==3 & image_id=="4548182_00999"
replace checked_st="c" if clean_priority==3 & image_id=="4548182_00999"
replace checked_hn="c" if clean_priority==3 & image_id=="4548182_00999"
replace st_edit="" if clean_priority==3 & image_id=="4548182_00999" & hn<220
replace checked_st="c, ambiguous" if clean_priority==3 & image_id=="4548182_00999" & hn<220

*N Spring in Ancestry; SM has Spring St
browse if clean_priority==3 & street_raw=="N SPRING"
replace hn_edit=819 if clean_priority==3 & street_raw=="N SPRING" & hn==814
replace st_edit="Leal" if clean_priority==3 & street_raw=="N SPRING" & hn==1706
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="N SPRING"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="N SPRING" & st_edit=="Leal"
replace stname_flag="Spring St" if clean_priority==3 & street_raw=="N SPRING"
replace stname_flag="Leal St" if clean_priority==3 & street_raw=="N SPRING" & st_edit=="Leal"
replace checked_hn="c" if clean_priority==3 & street_raw=="N SPRING"

*Martin St in ED 54 and 86 in Ancestry, but only 86 in SM
browse if clean_priority==3 & street_raw=="MARTIN"
replace st_edit="N St Mary's" if clean_priority==3 & street_raw=="MARTIN" & hn==120 & line_num>37
replace stname_flag="Martin St" if clean_priority==3 & street_raw=="MARTIN" & st_edit=="Martin"
replace stname_flag="N St Mary's St" if clean_priority==3 & street_raw=="MARTIN" & stname_flag==""
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_raw=="MARTIN" & ed==54
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="MARTIN" & checked_st==""
replace checked_hn="c" if clean_priority==3 & street_raw=="MARTIN" & st_edit=="Martin"
replace checked_hn="c, ambiguous" if clean_priority==3 & street_raw=="MARTIN" & checked_hn==""

*Looks like W Salinas in Ancestry; W Salinas St in SM
browse if clean_priority==3 & street_raw=="W SABINAS"
replace st_edit="W Salinas" if clean_priority==3 & street_raw=="W SABINAS"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="W SABINAS"
replace stname_flag="W Salinas St" if clean_priority==3 & street_raw=="W SABINAS"
replace checked_hn="c" if clean_priority==3 & street_raw=="W SABINAS"

*Arbor St in Ancestry; Arbor Pl in SM
browse if clean_priority==3 & street_raw=="ARBOR STREET"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="ARBOR STREET"
replace stname_flag="Arbor Pl" if clean_priority==3 & street_raw=="ARBOR STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="ARBOR STREET"

*Corner of N Laredo St and W Poplar St. Both match SM
browse if clean_priority==3 & street_raw=="NORTH LAREDS STREET AND C?? W. P"
replace st_edit="N Laredo St" if clean_priority==3 & street_raw=="NORTH LAREDS STREET AND C?? W. P"
replace stname_flag="Corner of N Laredo St and W Poplar St" if clean_priority==3 & street_raw=="NORTH LAREDS STREET AND C?? W. P"
replace checked_st="c" if clean_priority==3 & street_raw=="NORTH LAREDS STREET AND C?? W. P"
replace checked_hn="c" if clean_priority==3 & street_raw=="NORTH LAREDS STREET AND C?? W. P"

*3/22
*Corner of N Brazos St and Rivas St. Both found in SM
browse if clean_priority==3 & street_raw=="CORNER OF N PORPER AND RIVER STR"
replace st_edit="N Brazos St" if clean_priority==3 & street_raw=="CORNER OF N PORPER AND RIVER STR"
replace stname_flag="Corner of N Brazos St and Rivas St" if clean_priority==3 & street_raw=="CORNER OF N PORPER AND RIVER STR"
replace checked_st="c" if clean_priority==3 & street_raw=="CORNER OF N PORPER AND RIVER STR"
replace checked_hn="c" if clean_priority==3 & street_raw=="CORNER OF N PORPER AND RIVER STR"

*Corner of Rivas St. Found in SM
browse if clean_priority==3 & street_raw=="CORNER OF RIVER STREET"
replace st_edit="Rivas St" if clean_priority==3 & street_raw=="CORNER OF RIVER STREET"
replace stname_flag="Corner of Rivas St" if clean_priority==3 & street_raw=="CORNER OF RIVER STREET"
replace checked_st="c" if clean_priority==3 & street_raw=="CORNER OF RIVER STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="CORNER OF RIVER STREET"

*Delgado St and corner of N San Marcos St. Matches SM
browse if clean_priority==3 & street_raw=="DELGADO AND CORNER OF SON MORCUR"
replace st_edit="Delgado St" if clean_priority==3 & street_raw=="DELGADO AND CORNER OF SON MORCUR"
replace stname_flag="Delgado St and Corner of N San Marcos St" if clean_priority==3 & street_raw=="DELGADO AND CORNER OF SON MORCUR"
replace checked_st="c" if clean_priority==3 & street_raw=="DELGADO AND CORNER OF SON MORCUR"
replace checked_hn="c" if clean_priority==3 & street_raw=="DELGADO AND CORNER OF SON MORCUR"

*Can't tell when Colorado St stops and Colorado Aly begins
browse if clean_priority==3 & street_raw=="COLORADO ALLEY CALWADO STREET"
replace st_edit="Colorado St" if clean_priority==3 & street_raw=="COLORADO ALLEY CALWADO STREET"
replace stname_flag="Colorado Aly or N Colorado St" if clean_priority==3 & street_raw=="COLORADO ALLEY CALWADO STREET"
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="COLORADO ALLEY CALWADO STREET"
replace hn_edit=1017 if clean_priority==3 & street_raw=="COLORADO ALLEY CALWADO STREET" & hn_flag!=""
replace checked_hn="c, ambiguous" if clean_priority==3 & street_raw=="COLORADO ALLEY CALWADO STREET"

*Looks like Ruiz St, which matches SM
browse if clean_priority==3 & street_raw=="REEY STREET"
replace st_edit="Ruiz St" if clean_priority==3 & street_raw=="REEY STREET"
replace checked_st="c" if clean_priority==3 & street_raw=="REEY STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="REEY STREET"

*N Salado St in Ancestry; matches SM
browse if clean_priority==3 & street_raw=="N SOLODA"
replace st_edit="N Salado St" if clean_priority==3 & street_raw=="N SOLODA"
replace checked_st="c" if clean_priority==3 & street_raw=="N SOLODA"
replace checked_hn="c" if clean_priority==3 & street_raw=="N SOLODA"

*Most likely is Ruiz St, but says Ruiz St Aly in Ancestry
browse if clean_priority==3 & street_raw=="RUIZ STREET ALLEY"
replace st_edit="Ruiz St" if clean_priority==3 & street_raw=="RUIZ STREET ALLEY"
replace stname_flag="Ruiz Aly" if clean_priority==3 & street_raw=="RUIZ STREET ALLEY"
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="RUIZ STREET ALLEY"
replace checked_hn="c" if clean_priority==3 & street_raw=="RUIZ STREET ALLEY"

*Laurel St in Ancestry; SM has W Laurel St
browse if clean_priority==3 & street_raw=="LAUREL"
*Manually added hn_edit values
replace st_edit="Laurel St" if clean_priority==3 & street_raw=="LAUREL"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="LAUREL"
replace stname_flag="W Laurel St" if clean_priority==3 & street_raw=="LAUREL"
replace checked_hn="c" if clean_priority==3 & street_raw=="LAUREL"

*Agarita Ave in SM, but in diff ED
browse if clean_priority==3 & street_raw=="AGARITA AVE."
*Manually added hn_edit values
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_raw=="AGARITA AVE."
replace checked_hn="c" if clean_priority==3 & street_raw=="AGARITA AVE."

*North Drive in Ancestry; matches SM
browse if clean_priority==3 & street_raw=="NORTH DRIVE"
*Manually added hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="NORTH DRIVE"
replace checked_hn="c" if clean_priority==3 & street_raw=="NORTH DRIVE"

*Furr Drive in Ancestry; matches SM
browse if clean_priority==3 & street_raw=="FURR DRIVE"
*Manually added hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="FURR DRIVE"
replace checked_hn="c" if clean_priority==3 & street_raw=="FURR DRIVE"

*W French Pl in Ancestry; matches SM
browse if clean_priority==3 & street_raw=="W. FRENCH PLACE"
*Manually added hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="W. FRENCH PLACE"
replace checked_hn="c" if clean_priority==3 & street_raw=="W. FRENCH PLACE"
replace checked_hn="c, ambiguous" if clean_priority==3 & street_raw=="W. FRENCH PLACE" & hn_flag!=""

*Josephine Tobin Drive in SM
browse if clean_priority==3 & street_raw=="JOSEPHINE TOBIN"
*Manually edited hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="JOSEPHINE TOBIN"
replace stname_flag="Josephine Tobin Drive" if clean_priority==3 & street_raw=="JOSEPHINE TOBIN"
replace checked_hn="c" if clean_priority==3 & street_raw=="JOSEPHINE TOBIN"

*3/23
*Waverly in Ancestry; SM has Waverly Ave
browse if clean_priority==3 & image_id=="4548183_00419"
replace st_edit="Waverly" if clean_priority==3 & image_id=="4548183_00419"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & image_id=="4548183_00419"
replace stname_flag="Waverly Ave" if clean_priority==3 & image_id=="4548183_00419"
*Manually added hn_edit values
replace checked_hn="c" if clean_priority==3 & image_id=="4548183_00419"

*Kentucky in Ancestry; Kentucky Ave in SM
browse if clean_priority==3 & street_raw=="KENTUCKY"
*Manually edited hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="KENTUCKY"
replace checked_hn="c" if clean_priority==3 & street_raw=="KENTUCKY"

*W Ashby Pl in Ancestry; matches SM
browse if clean_priority==3 & street_raw=="W. ASHBY PLACE"
*Manually added hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="W. ASHBY PLACE"
replace checked_hn="c" if clean_priority==3 & street_raw=="W. ASHBY PLACE"

*W Cincinnati Ave in Ancestry, but SM has Cincinnati Ave
browse if clean_priority==3 & street_raw=="W. CINCINNATI AVE."
*Manually added hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="W. CINCINNATI AVE."
replace checked_hn="c" if clean_priority==3 & street_raw=="W. CINCINNATI AVE."

*W Texas Ave in Ancestry; SM has Texas Ave
browse if clean_priority==3 & street_raw=="W. TEXAS AVE"
*Manually added hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="W. TEXAS AVE"
replace checked_hn="c" if clean_priority==3 & street_raw=="W. TEXAS AVE"

*N Hamilon in Ancestry; N Hamilton Ave in SM
browse if clean_priority==3 & street_raw=="N. HAMILTON"
*Manually added hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="N. HAMILTON"
replace checked_hn="c" if clean_priority==3 & street_raw=="N. HAMILTON"

*Culebra in Ancestry; Culebra Ave in SM
browse if clean_priority==3 & street_raw=="CULEBRA"
*Manually added hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="CULEBRA"
replace checked_hn="c" if clean_priority==3 & street_raw=="CULEBRA"

*W Laurel in Ancestry; SM has W Laurel St
browse if clean_priority==3 & street_raw=="W LAUREL"
*Manually added hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="W LAUREL"
replace checked_hn="c" if clean_priority==3 & street_raw=="W LAUREL"

*W Neff in Ancestry; SM has Neff Ave
browse if clean_priority==3 & street_raw=="W - NEFF"
*Manually added hn_edit values
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="W - NEFF"
replace stname_flag="Neff Ave" if clean_priority==3 & street_raw=="W - NEFF"
replace checked_hn="c" if clean_priority==3 & street_raw=="W - NEFF"

*Looks like Goodrich in Ancestry; SM has Goodrich St
browse if clean_priority==3 & street_raw=="GOODBRICK"
replace st_edit="Goodrich" if clean_priority==3 & street_raw=="GOODBRICK"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="GOODBRICK"
replace stname_flag="Goodrich St" if clean_priority==3 & street_raw=="GOODBRICK"
replace checked_hn="c" if clean_priority==3 & street_raw=="GOODBRICK"

*Pecan St in Ancestry, W Pecan St in SM
browse if clean_priority==3 & street_raw=="PECAN STREET."
replace checked_st="c" if clean_priority==3 & street_raw=="PECAN STREET."
replace checked_hn="c" if clean_priority==3 & street_raw=="PECAN STREET."

*Augusta St in Ancestry and SM
browse if clean_priority==3 & street_raw=="AUGUSTA ST"
replace checked_st="c" if clean_priority==3 & street_raw=="AUGUSTA ST"
replace checked_hn="c" if clean_priority==3 & street_raw=="AUGUSTA ST"

*Alley in Ancestry
browse if clean_priority==3 & street_raw=="ALLEY"
*Manually edited hn_edit and flag values
replace checked_st="c, ancestry match, SM missing" if clean_priority==3 & street_raw=="ALLEY"
replace checked_hn="c" if clean_priority==3 & street_raw=="ALLEY"

*W Martin St in Ancestry; Martin St in SM
browse if clean_priority==3 & street_raw=="W MARTIN ST."
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="W MARTIN ST."
replace stname_flag="Martin St" if clean_priority==3 & street_raw=="W MARTIN ST."
replace checked_hn="c" if clean_priority==3 & street_raw=="W MARTIN ST."

*Alley in Ancestry
browse if clean_priority==3 & street_raw=="ALLEY."
replace checked_st="c, ancestry match, SM missing" if clean_priority==3 & street_raw=="ALLEY."
replace checked_hn="c" if clean_priority==3 & street_raw=="ALLEY."

*Kingsbury St in Ancesry; matches SM
browse if clean_priority==3 & street_raw=="STREET"
replace st_edit="Kingsbury St" if clean_priority==3 & street_raw=="STREET"
replace checked_st="c" if clean_priority==3 & street_raw=="STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="STREET"

*W Maple in Ancestry; SM has Maple St in neighboring ED
browse if clean_priority==3 & street_raw=="W. MAPLE"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_raw=="W. MAPLE"
replace stname_flag="Maple St" if clean_priority==3 & street_raw=="W. MAPLE"
replace checked_hn="c" if clean_priority==3 & street_raw=="W. MAPLE"

*W Quincy in Ancestry; SM has Quincy St
browse if clean_priority==3 & street_raw=="W. QUINCY"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="W. QUINCY"
replace stname_flag="Quincy St" if clean_priority==3 & street_raw=="W. QUINCY"
replace checked_hn="c" if clean_priority==3 & street_raw=="W. QUINCY"

*E Quincy in Ancestry; SM has Quincy St
browse if clean_priority==3 & street_raw=="EAST QUINCY"
replace st_edit="Lexington Ave" if clean_priority==3 & street_raw=="EAST QUINCY" & hn==518
replace checked_st="c" if clean_priority==3 & street_raw=="EAST QUINCY" & hn==518
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="EAST QUINCY" & hn!=518
replace stname_flag="Quincy St" if clean_priority==3 & street_raw=="EAST QUINCY" & hn!=518
replace checked_hn="c" if clean_priority==3 & street_raw=="EAST QUINCY"

*St Marys St in Ancestry; N St Marys St in SM
browse if clean_priority==3 & street_raw=="ST. MARYS STREET"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="ST. MARYS STREET"
replace stname_flag="N St. Marys St" if clean_priority==3 & street_raw=="ST. MARYS STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="ST. MARYS STREET"

*Looks like Jones Ave in Ancestry; matches SM
browse if clean_priority==3 & street_raw=="ERIES AVE"
replace st_edit="Jones Ave" if clean_priority==3 & street_raw=="ERIES AVE"
replace checked_st="c" if clean_priority==3 & street_raw=="ERIES AVE"
replace checked_hn="c" if clean_priority==3 & street_raw=="ERIES AVE"

*E Myrtle in Ancestry; SM has Myrtle St
browse if clean_priority==3 & street_raw=="EAST MYRTLE"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="EAST MYRTLE"
replace stname_flag="Myrtle St" if clean_priority==3 & street_raw=="EAST MYRTLE"
replace checked_hn="c" if clean_priority==3 & street_raw=="EAST MYRTLE"

*E Laurel in Ancestry; SM has Laurel St
browse if clean_priority==3 & street_precleanedhn=="E Laurel"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="E Laurel"
replace stname_flag="Laurel St" if clean_priority==3 & street_precleanedhn=="E Laurel"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="E Laurel"

*Warren St in Ancestry; matches SM
browse if clean_priority==3 & street_raw=="WARREN"
replace hn_edit=301 if clean_priority==3 & street_raw=="WARREN" & line_num<7
replace hn_edit=3012 if clean_priority==3 & street_raw=="WARREN" & line_num>7
*Manually edited hn_flag values
replace hn_flag=hn_raw if clean_priority==3 & street_raw=="WARREN" & line_num>17
replace checked_st="c" if clean_priority==3 & street_raw=="WARREN"
replace checked_hn="c" if clean_priority==3 & street_raw=="WARREN"

*4/3
*W Myrtle in Ancestry; SM has Myrtle St
browse if clean_priority==3 & street_raw=="W. MYRTLE"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="W. MYRTLE"
replace stname_flag="Myrtle St" if clean_priority==3 & street_raw=="W. MYRTLE"
replace checked_hn="c" if clean_priority==3 & street_raw=="W. MYRTLE"

*E Dewey Pl in Ancestry; SM has Dewey Pl
browse if clean_priority==3 & street_raw=="E DEWEY"
replace st_edit="E Dewey Pl" if clean_priority==3 & street_raw=="E DEWEY"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="E DEWEY"
replace stname_flag="Dewey Pl" if clean_priority==3 & street_raw=="E DEWEY"
replace checked_hn="c" if clean_priority==3 & street_raw=="E DEWEY"

*E Locust St in Ancestry; SM has Locust St
browse if clean_priority==3 & street_raw=="E LOUIST STREET"
replace st_edit="E Locust St" if clean_priority==3 & street_raw=="E LOUIST STREET"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="E LOUIST STREET"
replace stname_flag="Locust St" if clean_priority==3 & street_raw=="E LOUIST STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="E LOUIST STREET"

*Sandoval in Ancestry; SM has Sandoval St in diff ED
browse if clean_priority==3 & street_raw=="SANDOVAL"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_raw=="SANDOVAL"
replace stname_flag="Sandoval St" if clean_priority==3 & street_raw=="SANDOVAL"
replace checked_hn="c" if clean_priority==3 & street_raw=="SANDOVAL"

*W Agarita Ave in Ancestry; SM has Agarita Ave
browse if clean_priority==3 & street_raw=="WAGANTH AVE"
replace st_edit="W Agarita Ave" if clean_priority==3 & street_raw=="WAGANTH AVE"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="WAGANTH AVE"
replace stname_flag="Agarita Ave" if clean_priority==3 & street_raw=="WAGANTH AVE"
replace checked_hn="c" if clean_priority==3 & street_raw=="WAGANTH AVE"

browse if clean_priority==3 & street_raw=="W.AGANTA AVE"
replace st_edit="W Agarita Ave" if clean_priority==3 & street_raw=="W.AGANTA AVE"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="W.AGANTA AVE"
replace stname_flag="Agarita Ave" if clean_priority==3 & street_raw=="W.AGANTA AVE"
replace checked_hn="c" if clean_priority==3 & street_raw=="W.AGANTA AVE"

*E Agarita Ave in Ancestry; SM has Agarita Ave
browse if clean_priority==3 & street_raw=="E AGANTA"
replace st_edit="E Agarita Ave" if clean_priority==3 & street_raw=="E AGANTA"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="E AGANTA"
replace stname_flag="Agarita Ave" if clean_priority==3 & street_raw=="E AGANTA"
replace checked_hn="c" if clean_priority==3 & street_raw=="E AGANTA"

*W Agarita Ave in Ancestry; SM has Agarita Ave
browse if clean_priority==3 & street_raw=="W.AGANTA"
replace st_edit="W Agarita Ave" if clean_priority==3 & street_raw=="W.AGANTA"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="W.AGANTA"
replace stname_flag="Agarita Ave" if clean_priority==3 & street_raw=="W.AGANTA"
replace checked_hn="c" if clean_priority==3 & street_raw=="W.AGANTA"

*Lullwood Ave in Ancestry; SM has E and W Lullwood Ave
browse if clean_priority==3 & street_raw=="LULLWOOD"
replace st_edit="Lullwood Ave" if clean_priority==3 & street_raw=="LULLWOOD"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="LULLWOOD"
replace stname_flag="E/W Lullwood Ave" if clean_priority==3 & street_raw=="LULLWOOD"
replace checked_hn="c" if clean_priority==3 & street_raw=="LULLWOOD"

*Gramercy Pl in Ancestry; SM has E and W Gramercy Pl
browse if clean_priority==3 & street_raw=="GRAMERCY AVE."
replace st_edit="Gramercy Pl" if clean_priority==3 & street_raw=="GRAMERCY AVE."
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="GRAMERCY AVE."
replace stname_flag="E/W Gramercy Pl" if clean_priority==3 & street_raw=="GRAMERCY AVE."
replace checked_hn="c" if clean_priority==3 & street_raw=="GRAMERCY AVE."

*West Kings Highway in Ancestry; SM has King's Hy St
browse if clean_priority==3 & street_raw=="WEST KINGS HIGHWAW"
replace st_edit="W Kings Hwy" if clean_priority==3 & street_raw=="WEST KINGS HIGHWAW"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="WEST KINGS HIGHWAW"
replace stname_flag="King's Hy St" if clean_priority==3 & street_raw=="WEST KINGS HIGHWAW"
replace checked_hn="c" if clean_priority==3 & street_raw=="WEST KINGS HIGHWAW"

*Gramercy Pl and West Kings Highway in Ancestry; SM has diff dir
browse if clean_priority==3 & street_raw=="MAS MISMFORMED OF NUMBER IN 606"
replace st_edit="Gramercy Pl" if clean_priority==3 & street_raw=="MAS MISMFORMED OF NUMBER IN 606" & line_num<29
replace st_edit="W Kings Hwy" if clean_priority==3 & street_raw=="MAS MISMFORMED OF NUMBER IN 606" & line_num>28
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="MAS MISMFORMED OF NUMBER IN 606"
replace stname_flag="E/W Gramercy Pl" if clean_priority==3 & street_raw=="MAS MISMFORMED OF NUMBER IN 606" & line_num<29
replace stname_flag="King's Hy St" if clean_priority==3 & street_raw=="MAS MISMFORMED OF NUMBER IN 606" & line_num>28
replace checked_hn="c" if clean_priority==3 & street_raw=="MAS MISMFORMED OF NUMBER IN 606"

*Summit Ave in Ancestry; SM has both E and W Summit Ave
browse if clean_priority==3 & street_raw=="SUMMIT"
replace st_edit="Summit Ave" if clean_priority==3 & street_raw=="SUMMIT"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="SUMMIT"
replace stname_flag="E/W Summit Ave" if clean_priority==3 & street_raw=="SUMMIT"
replace checked_hn="c" if clean_priority==3 & street_raw=="SUMMIT"

*W Kings Hwy in Ancestry; SM has King's Hy St
browse if clean_priority==3 & street_raw=="W.KINGS HIGHWAY."
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="W.KINGS HIGHWAY."
replace stname_flag="King's Hy St" if clean_priority==3 & street_raw=="W.KINGS HIGHWAY."
replace checked_hn="c" if clean_priority==3 & street_raw=="W.KINGS HIGHWAY."

browse if clean_priority==3 & street_raw=="W.KINGS HGHWAY"
replace st_edit="W Kings Hwy" if clean_priority==3 & street_raw=="W.KINGS HGHWAY"
replace hn_flag="902 rear" if clean_priority==3 & street_raw=="W.KINGS HGHWAY" & line_num>81
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="W.KINGS HGHWAY"
replace stname_flag="King's Hy St" if clean_priority==3 & street_raw=="W.KINGS HGHWAY"
replace checked_hn="c" if clean_priority==3 & street_raw=="W.KINGS HGHWAY"

*W Elsmere Ave in Ancestry; SM has Elsmere Pl
browse if clean_priority==3 & street_precleanedhn=="W Elsmere Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="W Elsmere Ave"
replace stname_flag="Elsmere Pl" if clean_priority==3 & street_precleanedhn=="W Elsmere Ave"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="W Elsmere Ave"

*Ridgewood St in Ancestry; SM has W Ridgewood Ct
browse if clean_priority==3 & street_raw=="RIDGEWOOD STREET"
replace hn_flag="619 rear" if clean_priority==3 & street_raw=="RIDGEWOOD STREET" & line_num==34
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="RIDGEWOOD STREET"
replace stname_flag="W Ridgewood Ct" if clean_priority==3 & street_raw=="RIDGEWOOD STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="RIDGEWOOD STREET"

*Hollywood St in Ancestry; SM has Hollywood Ave
browse if clean_priority==3 & street_precleanedhn=="Hallywood St"
replace st_edit="Hollywood St" if clean_priority==3 & street_precleanedhn=="Hallywood St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Hallywood St"
replace stname_flag="Hollywood Ave" if clean_priority==3 & street_precleanedhn=="Hallywood St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Hallywood St"

*Rosewood Ave in Ancestry; SM has W Rosewood Ave
browse if clean_priority==3 & street_raw=="??WOOD"
replace st_edit="Rosewood Ave" if clean_priority==3 & street_raw=="??WOOD"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="??WOOD"
replace stname_flag="W Rosewood Ave" if clean_priority==3 & street_raw=="??WOOD"
replace checked_hn="c" if clean_priority==3 & street_raw=="??WOOD"

*4/4
*Ancestry matches SM
browse if clean_priority==3 & street_raw=="FREDERICKSBURG ROAD"
replace checked_st="c" if clean_priority==3 & street_raw=="FREDERICKSBURG ROAD"
replace checked_hn="c" if clean_priority==3 & street_raw=="FREDERICKSBURG ROAD"

*W Lynwood in Ancestry; SM has Lynwood Ave
browse if clean_priority==3 & image_id=="4548184_00532"
replace st_edit="W Lynwood" if clean_priority==3 & image_id=="4548184_00532"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & image_id=="4548184_00532"
replace stname_flag="Lynwood Ave" if clean_priority==3 & image_id=="4548184_00532"
replace checked_hn="c" if clean_priority==3 & image_id=="4548184_00532"

*Fulton in Ancestry; Fulton Ave in SM
browse if clean_priority==3 & street_precleanedhn=="W Fulton"
replace st_edit="Fulton" if clean_priority==3 & street_precleanedhn=="W Fulton"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="W Fulton"
replace stname_flag="Fulton Ave" if clean_priority==3 & street_precleanedhn=="W Fulton"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="W Fulton"

*W Kings Hwy in Ancestry; SM has King's Hy St
browse if clean_priority==3 & street_precleanedhn=="W Kings Hwy" & checked_st==""
replace stname_flag="King's Hy St" if clean_priority==3 & street_precleanedhn=="W Kings Hwy" & checked_st==""
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="W Kings Hwy" & checked_st==""
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="W Kings Hwy" & checked_st==""

*W Agarita in Ancestry; SM has Agarita Ave
browse if clean_priority==3 & street_precleanedhn=="W Agarita"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="W Agarita"
replace stname_flag="Agarita Ave" if clean_priority==3 & street_precleanedhn=="W Agarita"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="W Agarita"

*W Mulberry St in Ancestry; SM has W Mulberry Ave
browse if clean_priority==3 & image_id=="4548184_00571"
replace hn_edit=1317 if clean_priority==3 & image_id=="4548184_00571" & hn==1844
replace st_edit="W Mulberry St" if clean_priority==3 & image_id=="4548184_00571"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & image_id=="4548184_00571"
replace stname_flag="W Mulberry Ave" if clean_priority==3 & image_id=="4548184_00571"
replace checked_hn="c" if clean_priority==3 & image_id=="4548184_00571"

*Looks like Ostrom Drive in Ancestry; matches SM
browse if clean_priority==3 & street_raw=="OSTEEN DUN"
replace st_edit="Ostrom Drive" if clean_priority==3 & street_raw=="OSTEEN DUN"
replace checked_st="c" if clean_priority==3 & street_raw=="OSTEEN DUN"
replace checked_hn="c" if clean_priority==3 & street_raw=="OSTEEN DUN"

*Looks like Ewald in Ancestry; SM has Ewald St
browse if clean_priority==3 & street_raw=="EMALD"
replace st_edit="Mistletoe" if clean_priority==3 & street_raw=="EMALD" & hn==727
replace st_edit="Ewald" if clean_priority==3 & street_raw=="EMALD" & hn!=727
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="EMALD"
replace stname_flag="Ewald St" if clean_priority==3 & street_raw=="EMALD" & hn!=727
replace stname_flag="E/W Mistletoe Ave" if clean_priority==3 & street_raw=="EMALD" & hn==727
replace checked_hn="c" if clean_priority==3 & street_raw=="EMALD"

*Valdez Aly in Ancestry; matches map
browse if clean_priority==3 & street_precleanedhn=="Valdez Aly"
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="Valdez Aly"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Valdez Aly"

*E Russell Pl (alley) in Ancestry; matches SM
browse if clean_priority==3 & street_precleanedhn=="Russell Place Aly"
replace hn_edit=240 if clean_priority==3 & street_precleanedhn=="Russell Place Aly" & hn==340
replace st_edit="E Russell Pl" if clean_priority==3 & street_precleanedhn=="Russell Place Aly"
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="Russell Place Aly"
replace stname_flag="(alley)" if clean_priority==3 & street_precleanedhn=="Russell Place Aly"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Russell Place Aly"

*Looks like E Courtland in Ancestry, SM has Courtland Pl
browse if clean_priority==3 & street_precleanedhn=="E Court Ct"
replace hn_edit=305 if clean_priority==3 & street_precleanedhn=="E Court Ct" & hn==311 & line_num>81
replace hn_flag="Apt 1" if clean_priority==3 & street_precleanedhn=="E Court Ct" & hn==303 & line_num>90
replace hn_flag="Apt 4" if clean_priority==3 & street_precleanedhn=="E Court Ct" & hn==313
replace hn_flag="Apt 3" if clean_priority==3 & street_precleanedhn=="E Court Ct" & hn==304
replace st_edit="E Courtland" if clean_priority==3 & street_precleanedhn=="E Court Ct"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="E Court Ct"
replace stname_flag="Courtland Pl" if clean_priority==3 & street_precleanedhn=="E Court Ct"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="E Court Ct"

*E Locust in Ancestry; SM has Locust St
browse if clean_priority==3 & street_precleanedhn=="E Locust"
*Manually edited hn_flag values
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="E Locust"
replace stname_flag="Locust St" if clean_priority==3 & street_precleanedhn=="E Locust"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="E Locust"

*E Dewey in Ancestry; SM has Dewey Pl
browse if clean_priority==3 & street_precleanedhn=="E Dewey" & checked_hn==""
*Manually edited hn_flag values
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="E Dewey" & checked_hn==""
replace stname_flag="Dewey Pl" if clean_priority==3 & street_precleanedhn=="E Dewey" & checked_hn==""
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="E Dewey" & checked_hn==""

*Park Drive in Ancestry matches SM
browse if clean_priority==3 & street_raw=="UNNAMED STREET PARK DRIVE"
replace st_edit="Park Drive" if clean_priority==3 & street_raw=="UNNAMED STREET PARK DRIVE"
replace checked_st="c" if clean_priority==3 & street_raw=="UNNAMED STREET PARK DRIVE"
replace checked_hn="c" if clean_priority==3 & street_raw=="UNNAMED STREET PARK DRIVE"

*No address. In Brackenridge Park near Jones Ave
browse if clean_priority==3 & street_raw=="NEAR JONES AVE.BRACKENRIDGE PARK"
replace st_edit="Brackenridge Park" if clean_priority==3 & street_raw=="NEAR JONES AVE.BRACKENRIDGE PARK"
replace stname_flag="Near Jones Ave" if clean_priority==3 & street_raw=="NEAR JONES AVE.BRACKENRIDGE PARK"
*Manually removed hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="NEAR JONES AVE.BRACKENRIDGE PARK"
replace checked_hn="c" if clean_priority==3 & street_raw=="NEAR JONES AVE.BRACKENRIDGE PARK"

*Mulberry St in Ancestry; SM has E/W Mulberry Ave
browse if clean_priority==3 & street_raw=="MALBERRY ST."
replace hn_flag=hn_raw if clean_priority==3 & street_raw=="MALBERRY ST." & line_num>83
replace hn_edit=507 if clean_priority==3 & street_raw=="MALBERRY ST." & line_num>81
replace st_edit="Mulberry St" if clean_priority==3 & street_raw=="MALBERRY ST."
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="MALBERRY ST."
replace stname_flag="E/W Mulberry Ave" if clean_priority==3 & street_raw=="MALBERRY ST."
replace checked_hn="c" if clean_priority==3 & street_raw=="MALBERRY ST."

*E Martin in Ancestry; SM has Martin St
browse if clean_priority==3 & street_raw=="EA MARTIN"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="EA MARTIN"
replace stname_flag="Martin St" if clean_priority==3 & street_raw=="EA MARTIN"
replace checked_hn="c" if clean_priority==3 & street_raw=="EA MARTIN"
replace inst=1 if clean_priority==3 & street_raw=="EA MARTIN" & hn==231
replace institution_edit="Texas Hotel" if clean_priority==3 & street_raw=="EA MARTIN" & hn==231

browse if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00776"
replace st_edit="E Martin" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00776"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00776"
replace stname_flag="Martin St" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00776"
replace checked_hn="c" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00776"

browse if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00777"
replace st_edit="Jefferson" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00777" 
replace st_edit="Pecan" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00777" & line_num==65
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00777"
replace stname_flag="Jefferson St" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00777"
replace stname_flag="E Pecan St" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00777" & line_num==65
*Manually deleted hn_edit values
replace checked_st="c" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00777" 
replace checked_hn="c, ambiguous" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00777" 

*Jefferson Hotel on Jefferson; SM has Jefferson St
browse if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00778" 
replace st_edit="Jefferson" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00778" 
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00778" 
replace checked_hn="c" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00778" 
replace stname_flag="Jefferson St" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00778" 
replace inst=1 if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00778" 
replace institution_edit="Jefferson Hotel" if clean_priority==3 & street_raw=="EA MARION" & image_id=="4548184_00778" 

*Hotel on Travers and Navarro
browse if clean_priority==3 & street_raw=="TRAVIS AND NAVARRO"
replace st_edit="Navarro St" if clean_priority==3 & street_raw=="TRAVIS AND NAVARRO"
replace stname_flag="Travis St and Navarro St" if clean_priority==3 & street_raw=="TRAVIS AND NAVARRO"
replace inst=1 if clean_priority==3 & street_raw=="TRAVIS AND NAVARRO"
replace institution_edit="St Anthony Hotel" if clean_priority==3 & street_raw=="TRAVIS AND NAVARRO"
replace checked_st="c" if clean_priority==3 & street_raw=="TRAVIS AND NAVARRO"
*removed hn_edit values
replace checked_hn="c, ambiguous" if clean_priority==3 & street_raw=="TRAVIS AND NAVARRO"

*Hotels
browse if clean_priority==3 & street_raw=="GOTEL HOUSTON"
replace st_edit="E Houston St" if clean_priority==3 & street_raw=="GOTEL HOUSTON" & line_num==67
replace checked_st="c" if clean_priority==3 & street_raw=="GOTEL HOUSTON" & line_num==67
replace checked_hn="c" if clean_priority==3 & street_raw=="GOTEL HOUSTON" & line_num==67
replace institution_edit="Hotel Houston" if clean_priority==3 & street_raw=="GOTEL HOUSTON" & line_num==67
replace inst=1 if clean_priority==3 & street_raw=="GOTEL HOUSTON" & line_num==67
replace st_edit="E Travis St" if clean_priority==3 & street_raw=="GOTEL HOUSTON" & line_num!=67
replace hn_edit=207 if clean_priority==3 & street_raw=="GOTEL HOUSTON" & line_num!=67
replace checked_st="c" if clean_priority==3 & street_raw=="GOTEL HOUSTON" & line_num!=67
replace checked_hn="c" if clean_priority==3 & street_raw=="GOTEL HOUSTON" & line_num!=67
replace inst=1 if clean_priority==3 & street_raw=="GOTEL HOUSTON" & line_num!=67
replace institution_edit="Lanier Hotel" if clean_priority==3 & street_raw=="GOTEL HOUSTON" & line_num!=67

*Hamilton Hotel on 125 Losoya St
browse if clean_priority==3 & street_precleanedhn=="Saint Mary'S"
replace st_edit="St Marys" if clean_priority==3 & street_precleanedhn=="Saint Mary'S"
replace stname_flag="N St Marys St" if clean_priority==3 & street_precleanedhn=="Saint Mary'S" & line_num>60
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="Saint Mary'S" & line_num>60
replace hn_edit=125 if clean_priority==3 & street_precleanedhn=="Saint Mary'S" & line_num<60
replace st_edit="Losoya St" if clean_priority==3 & street_precleanedhn=="Saint Mary'S" & line_num<60
replace inst=1 if clean_priority==3 & street_precleanedhn=="Saint Mary'S" & line_num<60
replace institution_edit="Hamilton Hotel" if clean_priority==3 & street_precleanedhn=="Saint Mary'S" & line_num<60
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="Saint Mary'S" & line_num<60
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Saint Mary'S"

*Ancestry has Houston, Bowie, and Crockett. SM has E Houston St, Bowie St, and Crockett St
browse if clean_priority==3 & street_raw=="CROCKEL BAWIE HOUSTON"
replace hn_flag="357 1/2" if clean_priority==3 & street_raw=="CROCKEL BAWIE HOUSTON" & hn==357
replace st_edit="Houston" if clean_priority==3 & street_raw=="CROCKEL BAWIE HOUSTON" & line_num==1
replace st_edit="Bowie" if clean_priority==3 & street_raw=="CROCKEL BAWIE HOUSTON" & line_num==2
replace st_edit="Crockett" if clean_priority==3 & street_raw=="CROCKEL BAWIE HOUSTON" & line_num>4
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="CROCKEL BAWIE HOUSTON"
replace stname_flag="E Houston St" if clean_priority==3 & street_raw=="CROCKEL BAWIE HOUSTON" & line_num==1
replace stname_flag="Bowie St" if clean_priority==3 & street_raw=="CROCKEL BAWIE HOUSTON" & line_num==2
replace stname_flag="Crockett St" if clean_priority==3 & street_raw=="CROCKEL BAWIE HOUSTON" & line_num>4
replace checked_hn="c" if clean_priority==3 & street_raw=="CROCKEL BAWIE HOUSTON"

*4/5
*E Crockett in Ancestry, Crockett St in SM
browse if clean_priority==3 & street_raw=="E.CROCKEL"
replace st_edit="E Crockett" if clean_priority==3 & street_raw=="E.CROCKEL"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="E.CROCKEL"
replace stname_flag="Crockett St" if clean_priority==3 & street_raw=="E.CROCKEL"
replace checked_hn="c" if clean_priority==3 & street_raw=="E.CROCKEL"

*Burnet St and Chestnut St in Ancestry; match SM
browse if clean_priority==3 & image_id=="4548184_00828"
replace hn_flag="220 rear" if clean_priority==3 & image_id=="4548184_00828" & hn==220 & line_num>17
replace hn_flag="228 rear" if clean_priority==3 & image_id=="4548184_00828" & hn==228 & line_num>29
replace st_edit="Burnet St" if clean_priority==3 & image_id=="4548184_00828" & line_num<35
replace st_edit="Chestnut St" if clean_priority==3 & image_id=="4548184_00828" & line_num>34
replace checked_st="c" if clean_priority==3 & image_id=="4548184_00828"
replace checked_hn="c" if clean_priority==3 & image_id=="4548184_00828"

*Booker St in Ancestry; SM has Booker Aly
browse if clean_priority==3 & street_precleanedhn=="Booker St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Booker St"
replace stname_flag="Booker Aly" if clean_priority==3 & street_precleanedhn=="Booker St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Booker St"

*7th St, Austin St, and E Ave in Ancestry; all match SM
browse if clean_priority==3 & image_id=="4548184_00946"
replace st_edit="7th St" if clean_priority==3 & image_id=="4548184_00946" & line_num<61
replace st_edit="Austin St" if clean_priority==3 & image_id=="4548184_00946" & hn==201
replace st_edit="E Ave" if clean_priority==3 & image_id=="4548184_00946" & line_num>65
replace checked_st="c" if clean_priority==3 & image_id=="4548184_00946"
replace checked_hn="c" if clean_priority==3 & image_id=="4548184_00946"

*Thirteenth St in Ancestry; SM has 13th St
browse if clean_priority==3 & street_raw=="THERTEENTH ST."
replace checked_hn="c, ambiguous" if clean_priority==3 & street_raw=="THERTEENTH ST." & hn>2000
replace st_edit="13th St" if clean_priority==3 & street_raw=="THERTEENTH ST."
replace checked_st="c" if clean_priority==3 & street_raw=="THERTEENTH ST."
replace checked_hn="c" if clean_priority==3 & street_raw=="THERTEENTH ST." & checked_hn==""

*N Center St in Ancestry; N Centre St in SM
browse if clean_priority==3 & street_precleanedhn=="N Center St"
replace stname_flag="N Centre St" if clean_priority==3 & street_precleanedhn=="N Center St"
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="N Center St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="N Center St"

*Alley between Dawson and Brown Sts. Can't read Alley name
browse if clean_priority==3 & street_raw=="RUV ALLEY BETON BROM AND DAWSON"
replace st_edit="Ruv Aly between Brown St and Dawson St" if clean_priority==3 & street_raw=="RUV ALLEY BETON BROM AND DAWSON"
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="RUV ALLEY BETON BROM AND DAWSON"
replace checked_hn="c" if clean_priority==3 & street_raw=="RUV ALLEY BETON BROM AND DAWSON"

*Looks like Swiss St in Ancestry; SM has N Swiss St
browse if clean_priority==3 & street_precleanedhn=="Sevier St"
replace st_edit="Swiss St" if clean_priority==3 & street_precleanedhn=="Sevier St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="Sevier St"
replace stname_flag="N Swiss St" if clean_priority==3 & street_precleanedhn=="Sevier St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Sevier St"

*Center St in Ancestry; SM has N Centre St
browse if clean_priority==3 & street_precleanedhn=="Center"
replace st_edit="N Center St" if clean_priority==3 & street_precleanedhn=="Center"
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="Center"
replace stname_flag="" if clean_priority==3 & street_precleanedhn=="Center"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Center"

browse if clean_priority==3 & street_precleanedhn=="Center St"
replace st_edit="N Center St" if clean_priority==3 & street_precleanedhn=="Center St"
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="Center St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Center St"

*Looks like Hays St in Ancestry; matches SM
browse if clean_priority==3 & street_raw=="HAMP STREET"
replace st_edit="Hays St" if clean_priority==3 & street_raw=="HAMP STREET"
replace checked_st="c" if clean_priority==3 & street_raw=="HAMP STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="HAMP STREET"

*Could be Milam St, which matches SM
browse if clean_priority==3 & street_raw=="MITARE ST"
replace st_edit="Milam St" if clean_priority==3 & street_raw=="MITARE ST"
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="MITARE ST"
replace checked_hn="c" if clean_priority==3 & street_raw=="MITARE ST"

*Casa Blanca St; matches map
browse if clean_priority==3 & street_raw=="CASSA BLUNTA"
replace st_edit="Casa Blanca St" if clean_priority==3 & street_raw=="CASSA BLUNTA"
replace checked_st="c" if clean_priority==3 & street_raw=="CASSA BLUNTA"
replace checked_hn="c" if clean_priority==3 & street_raw=="CASSA BLUNTA"

*Looks like Sharer St in Ancestry; matches SM
browse if clean_priority==3 & street_precleanedhn=="Shores St"
replace st_edit="Sharer St" if clean_priority==3 & street_precleanedhn=="Shores St"
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="Shores St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Shores St"

*Looks like Crosby St in Ancestry; matches SM
browse if clean_priority==3 & image_id=="4548185_00171"
replace st_edit="Crosby St" if clean_priority==3 & image_id=="4548185_00171"
replace checked_st="c" if clean_priority==3 & image_id=="4548185_00171"
replace checked_hn="c" if clean_priority==3 & image_id=="4548185_00171"

browse if clean_priority==3 & image_id=="4548185_00172"
replace st_edit="Crosby St" if clean_priority==3 & image_id=="4548185_00172"
replace checked_st="c" if clean_priority==3 & image_id=="4548185_00172"
replace checked_hn="c" if clean_priority==3 & image_id=="4548185_00172"

*Carson St in Ancestry; SM was W Carson St
browse if clean_priority==3 & street_raw=="CAISON STREET"
replace st_edit="Carson St" if clean_priority==3 & street_raw=="CAISON STREET"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="CAISON STREET"
replace stname_flag="W Carson St" if clean_priority==3 & street_raw=="CAISON STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="CAISON STREET"

*4/6
*Looks like New Braunfels Ave in Ancestry; SM has N New Braunfels Ave
browse if clean_priority==3 & street_raw=="NEW BRAMPELS AVE."
replace st_edit="New Braunfels Ave" if clean_priority==3 & street_raw=="NEW BRAMPELS AVE."
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="NEW BRAMPELS AVE."
replace stname_flag="N New Braunfels Ave" if clean_priority==3 & street_raw=="NEW BRAMPELS AVE."
replace checked_hn="c" if clean_priority==3 & street_raw=="NEW BRAMPELS AVE."

*E Hildebrand Ave in Ancestry and SM; but SM has it in diff ED
browse if clean_priority==3 & street_precleanedhn=="E Hilderband Ave"
replace st_edit="E Hildebrand Ave" if clean_priority==3 & street_precleanedhn=="E Hilderband Ave"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_precleanedhn=="E Hilderband Ave"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="E Hilderband Ave"

browse if clean_priority==3 & street_precleanedhn=="Hilderband Ave"
replace hn_flag="Apt 1" if clean_priority==3 & street_precleanedhn=="Hilderband Ave" & hn==146 & line_num<31
replace hn_flag="Apt 3" if clean_priority==3 & street_precleanedhn=="Hilderband Ave" & hn==146 & line_num>33
replace hn_flag="Apt 2" if clean_priority==3 & street_precleanedhn=="Hilderband Ave" & hn==146 & hn_flag==""
replace st_edit="E Hildebrand Ave" if clean_priority==3 & street_precleanedhn=="Hilderband Ave"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_precleanedhn=="Hilderband Ave"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Hilderband Ave"

*Carnahan Ave in Ancestry; Carnahan St in SM
browse if clean_priority==3 & street_raw=="CARNAHAN AVE"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="CARNAHAN AVE"
replace stname_flag="Carnahan St" if clean_priority==3 & street_raw=="CARNAHAN AVE"
replace checked_hn="c" if clean_priority==3 & street_raw=="CARNAHAN AVE"

*Looks like Natalen Ave in Ancestry; SM has Natalen St
browse if clean_priority==3 & street_raw=="MATALEN AVE."
replace st_edit="Natalen Ave" if clean_priority==3 & street_raw=="MATALEN AVE."
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="MATALEN AVE."
replace stname_flag="Natalen St" if clean_priority==3 & street_raw=="MATALEN AVE."
replace checked_hn="c" if clean_priority==3 & street_raw=="MATALEN AVE."

*Looks like Army Blvd and Post Ave, which match SM
browse if clean_priority==3 & street_raw=="AOMY BERBUDED"
replace st_edit="Army Blvd" if clean_priority==3 & street_raw=="AOMY BERBUDED" & hn!=222
replace st_edit="Post Ave" if clean_priority==3 & street_raw=="AOMY BERBUDED" & hn==222
replace checked_st="c" if clean_priority==3 & street_raw=="AOMY BERBUDED"
replace checked_hn="c" if clean_priority==3 & street_raw=="AOMY BERBUDED"

*Rullman St in Ancestry; Rullmann Ave in SM
browse if clean_priority==3 & street_precleanedhn=="Rullman St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Rullman St"
replace stname_flag="Rullmann Ave" if clean_priority==3 & street_precleanedhn=="Rullman St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Rullman St"

*Looks like it could be Jim St, which matches SM
browse if clean_priority==3 & street_raw=="JEON STREET"
replace st_edit="Jim St" if clean_priority==3 & street_raw=="JEON STREET"
replace checked_st="c" if clean_priority==3 & street_raw=="JEON STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="JEON STREET"
replace inst=0 if clean_priority==3 & street_raw=="JEON STREET"
replace institution_edit="" if clean_priority==3 & street_raw=="JEON STREET"

*Grayson in Ancestry; SM has Grayson St
browse if clean_priority==3 & street_precleanedhn=="Grayson"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Grayson"
replace stname_flag="Grayson St" if clean_priority==3 & street_precleanedhn=="Grayson"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Grayson"

*Rogers in Ancestry; SM has Rogers Ave
browse if clean_priority==3 & street_precleanedhn=="Rogers"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Rogers"
replace stname_flag="Rogers Ave" if clean_priority==3 & street_precleanedhn=="Rogers"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Rogers"

*Looks like Mason St in Ancestry, which matches SM
browse if clean_priority==3 & street_raw=="MOSON STREET"
replace st_edit="Mason St" if clean_priority==3 & street_raw=="MOSON STREET"
replace checked_st="c" if clean_priority==3 & street_raw=="MOSON STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="MOSON STREET"

*Palmetto St in Ancestry; N Palmetto Ave in SM
browse if clean_priority==3 & street_precleanedhn=="Palmetto St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Palmetto St"
replace stname_flag="N Palmetto Ave" if clean_priority==3 & street_precleanedhn=="Palmetto St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Palmetto St"

*Looks like N Olive St in Ancestry, which matches SM
browse if clean_priority==3 & street_raw=="M. OLIVE ST"
replace st_edit="N Olive St" if clean_priority==3 & street_raw=="M. OLIVE ST"
replace checked_st="c" if clean_priority==3 & street_raw=="M. OLIVE ST"
replace checked_hn="c" if clean_priority==3 & street_raw=="M. OLIVE ST"

*Hard to read but could be N Pine St which matches SM
browse if clean_priority==3 & street_raw=="AS PINE"
replace st_edit="N Pine St" if clean_priority==3 & street_raw=="AS PINE"
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="AS PINE"
replace checked_hn="c" if clean_priority==3 & street_raw=="AS PINE"

*Looks like Hays St in Ancestry, which matches SM
browse if clean_priority==3 & street_raw=="HORP ST"
replace st_edit="Hays St" if clean_priority==3 & street_raw=="HORP ST"
replace checked_st="c" if clean_priority==3 & street_raw=="HORP ST"
replace checked_hn="c" if clean_priority==3 & street_raw=="HORP ST"

*Can't read street name
browse if clean_priority==3 & street_raw=="E. ARCHET."
replace hn_edit=1454 if clean_priority==3 & street_raw=="E. ARCHET." & line_num<3
replace hn_edit=1446 if clean_priority==3 & street_raw=="E. ARCHET." & line_num>9 & line_num<13
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="E. ARCHET."
replace checked_hn="c" if clean_priority==3 & street_raw=="E. ARCHET."

*Victoria in Ancestry; SM has Victoria St
browse if clean_priority==3 & street_raw=="VICTORIO"
replace st_edit="Victoria" if clean_priority==3 & street_raw=="VICTORIO"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="VICTORIO"
replace checked_hn="c" if clean_priority==3 & street_raw=="VICTORIO"
replace stname_flag="Victoria St" if clean_priority==3 & street_raw=="VICTORIO"

*Ancestry has both Water St and S Alamo St, but SM only has S Alamo St in correct ED
browse if clean_priority==3 & street_raw=="WATER STREET OR SO. ALAMS"
replace hn_flag="706 1/2" if clean_priority==3 & street_raw=="WATER STREET OR SO. ALAMS" & hn==106
replace hn_edit=706 if clean_priority==3 & street_raw=="WATER STREET OR SO. ALAMS" & hn==106
replace st_edit="S Alamo St" if clean_priority==3 & street_raw=="WATER STREET OR SO. ALAMS"
replace stname_flag="Water St" if clean_priority==3 & street_raw=="WATER STREET OR SO. ALAMS"
replace checked_st="c" if clean_priority==3 & street_raw=="WATER STREET OR SO. ALAMS"
replace checked_hn="c" if clean_priority==3 & street_raw=="WATER STREET OR SO. ALAMS"

*Fern St in Ancestry; Fern Ct in SM
browse if clean_priority==3 & street_raw=="FERR STREET"
replace st_edit="Fern St" if clean_priority==3 & street_raw=="FERR STREET"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="FERR STREET"
replace stname_flag="Fern Ct" if clean_priority==3 & street_raw=="FERR STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="FERR STREET"

browse if clean_priority==3 & street_raw=="FERN STREET"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_raw=="FERN STREET"
replace stname_flag="Fern Ct" if clean_priority==3 & street_raw=="FERN STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="FERN STREET"

*Ancestry has Mills; SM has Mills Aly
browse if clean_priority==3 & street_raw=="MILLS"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="MILLS"
replace stname_flag="Mills Aly" if clean_priority==3 & street_raw=="MILLS"
replace checked_hn="c" if clean_priority==3 & street_raw=="MILLS"

*E Wyoming St in Ancestry; SM has Wyoming St
browse if clean_priority==3 & street_precleanedhn=="E Wyoming St"
replace hn_edit=1102 if clean_priority==3 & street_precleanedhn=="E Wyoming St"
replace hn_flag="APT 1" if clean_priority==3 & street_precleanedhn=="E Wyoming St" & line_num<9
replace hn_flag=hn_raw if clean_priority==3 & street_precleanedhn=="E Wyoming St" & line_num>8
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="E Wyoming St"
replace stname_flag="" if clean_priority==3 & street_precleanedhn=="E Wyoming St"
replace checked_hn="c, multi-unit" if clean_priority==3 & street_precleanedhn=="E Wyoming St"

*Maryland St in Ancestry; SM has Maryland Ave
browse if clean_priority==3 & street_precleanedhn=="Maryland St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="Maryland St"
replace stname_flag="Maryland Ave" if clean_priority==3 & street_precleanedhn=="Maryland St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Maryland St"

*Ezell St in SM and map
browse if clean_priority==3 & street_raw=="EZZEL"
replace st_edit="Ezell St" if clean_priority==3 & street_raw=="EZZEL"
replace checked_st="c" if clean_priority==3 & street_raw=="EZZEL"
replace checked_hn="c" if clean_priority==3 & street_raw=="EZZEL"

*Wyoming in Ancestry; Wyoming St in SM
browse if clean_priority==3 & street_raw=="E. WYOMING S"
replace st_edit="Wyoming St" if clean_priority==3 & street_raw=="E. WYOMING S"
replace checked_st="c" if clean_priority==3 & street_raw=="E. WYOMING S"
replace checked_hn="c" if clean_priority==3 & street_raw=="E. WYOMING S"

*Nevada in Ancestry; SM has Nevada St
browse if clean_priority==3 & street_raw=="NEWDA"
replace st_edit="Nevada" if clean_priority==3 & street_raw=="NEWDA"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="NEWDA"
replace stname_flag="Nevada St" if clean_priority==3 & street_raw=="NEWDA"
replace checked_hn="c" if clean_priority==3 & street_raw=="NEWDA"

*4/10
*Ferguson in Ancestry; SM has Ferguson Ave
browse if clean_priority==3 & street_raw=="FERGERSON"
replace hn_edit=219 if clean_priority==3 & street_raw=="FERGERSON" & hn==1219
replace st_edit="Ferguson" if clean_priority==3 & street_raw=="FERGERSON"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="FERGERSON"
replace stname_flag="Ferguson Ave" if clean_priority==3 & street_raw=="FERGERSON"
replace checked_hn="c" if clean_priority==3 & street_raw=="FERGERSON"

*Hard to read in Ancestry; could be Duryee. SM has Duryee Pl
browse if clean_priority==3 & street_raw=="DURYA"
replace st_edit="Duryee Pl" if clean_priority==3 & street_raw=="DURYA"
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="DURYA"
replace checked_hn="c" if clean_priority==3 & street_raw=="DURYA"

*S Spruce St in Ancestry; SM has Spruce St
browse if clean_priority==3 & street_precleanedhn=="S Spruce"
replace st_edit="S Spruce St" if clean_priority==3 & street_precleanedhn=="S Spruce"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="S Spruce"
replace stname_flag="Spruce St" if clean_priority==3 & street_precleanedhn=="S Spruce"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="S Spruce"

*S Olive in Ancestry; SM has S Olive St
browse if clean_priority==3 & street_precleanedhn=="Soute Olive"
replace st_edit="S Olive" if clean_priority==3 & street_precleanedhn=="Soute Olive"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Soute Olive"
replace stname_flag="S Olive St" if clean_priority==3 & street_precleanedhn=="Soute Olive"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Soute Olive"

*Delflor Way in Ancestry; Del Flor Way in Map; SM has Del Floe Way in neighboring ED
browse if clean_priority==3 & street_precleanedhn=="Delflor Way"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_precleanedhn=="Delflor Way"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Delflor Way"

*Virginia Blvd and S New Braunfels Ave 
browse if clean_priority==3 & image_id=="4548186_00694"
replace st_edit="Virginia Blvd" if clean_priority==3 & image_id=="4548186_00694" & line_num<98
replace st_edit="S New Braunfels Ave" if clean_priority==3 & image_id=="4548186_00694" & st_edit==""
replace checked_st="c" if clean_priority==3 & image_id=="4548186_00694"
replace checked_hn="c" if clean_priority==3 & image_id=="4548186_00694"

*Preston St in Ancestry; Preston Ave in SM
browse if clean_priority==3 & street_raw=="PRESTON STREET"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="PRESTON STREET"
replace stname_flag="Preston Ave" if clean_priority==3 & street_raw=="PRESTON STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="PRESTON STREET"

*Cooper Ave in Ancestry; Cooper St in SM
browse if clean_priority==3 & street_raw=="COOPERAVE."
replace st_edit="Cooper Ave" if clean_priority==3 & street_raw=="COOPERAVE."
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="COOPERAVE."
replace stname_flag="Cooper St" if clean_priority==3 & street_raw=="COOPERAVE."
replace checked_hn="c" if clean_priority==3 & street_raw=="COOPERAVE."

*Yucca St in Ancestry matches SM
browse if clean_priority==3 & image_id=="4548186_00844"
replace st_edit="Yucca St" if clean_priority==3 & image_id=="4548186_00844"
replace checked_st="c" if clean_priority==3 & image_id=="4548186_00844"
replace checked_hn="c" if clean_priority==3 & image_id=="4548186_00844"

*SM has inst name as only street in ED
browse if clean_priority==3 & street_raw=="YUCA STREET"
replace st_edit="Yucca St" if clean_priority==3 & street_raw=="YUCA STREET"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_raw=="YUCA STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="YUCA STREET"

*Could be Hyde Ave, which matches SM
browse if clean_priority==3 & street_raw=="HACK HYDE"
replace st_edit="Hyde Ave" if clean_priority==3 & street_raw=="HACK HYDE"
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="HACK HYDE"
replace checked_hn="c" if clean_priority==3 & street_raw=="HACK HYDE"

*Looks like Edinburgh in Ancestry; SM has Edinburgh St
browse if clean_priority==3 & street_precleanedhn=="Edmbury"
replace st_edit="Edinburgh" if clean_priority==3 & street_precleanedhn=="Edmbury"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Edmbury"
replace stname_flag="Edinburgh St" if clean_priority==3 & street_precleanedhn=="Edmbury"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Edmbury"

*Warwick Ave in Ancestry; Warwick Blvd in SM
browse if clean_priority==3 & street_precleanedhn=="Warwich Ave"
replace st_edit="Warwick Ave" if clean_priority==3 & street_precleanedhn=="Warwich Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Warwich Ave"
replace stname_flag="Warwick Blvd" if clean_priority==3 & street_precleanedhn=="Warwich Ave"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Warwich Ave"

*Avant St in Ancestry; SM has Avant Ave
browse if clean_priority==3 & street_precleanedhn=="Avant"
replace st_edit="Avant St" if clean_priority==3 & street_precleanedhn=="Avant"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Avant"
replace stname_flag="Avant Ave" if clean_priority==3 & street_precleanedhn=="Avant"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Avant"

*Ada Ave in Ancestry; Ada St in SM
browse if clean_priority==3 & street_precleanedhn=="Ada Ave"
replace hn_edit=305 if clean_priority==3 & street_precleanedhn=="Ada Ave" & hn==205
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Ada Ave"
replace stname_flag="Ada St" if clean_priority==3 & street_precleanedhn=="Ada Ave"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Ada Ave"

*SM has inst name as only street in the ED
browse if clean_priority==3 & street_raw=="SOUTH PRESA STREET"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==3 & street_raw=="SOUTH PRESA STREET"
replace stname_flag="Presa St" if clean_priority==3 & street_raw=="SOUTH PRESA STREET"
replace checked_hn="c" if clean_priority==3 & street_raw=="SOUTH PRESA STREET"

*Looks like Villita St which matches SM
browse if clean_priority==3 & street_precleanedhn=="Vierta"
replace st_edit="Villita St" if clean_priority==3 & street_precleanedhn=="Vierta"
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="Vierta"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Vierta"

*4/12
*Plaza Hotel. Seems like it is on S St Marys St but not sure
browse if clean_priority==3 & street_raw=="PLOZA H"
replace hn_edit=309 if clean_priority==3 & street_raw=="PLOZA H"
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="PLOZA H"
replace st_edit="S St Marys St" if clean_priority==3 & street_raw=="PLOZA H"
replace institution_edit="Plaza Hotel" if clean_priority==3 & street_raw=="PLOZA H"
replace inst=1 if clean_priority==3 & street_raw=="PLOZA H"
replace checked_hn="c" if clean_priority==3 & street_raw=="PLOZA H"

browse if clean_priority==3 & street_precleanedhn=="Saint Mayo"
replace institution_edit="Plaza Hotel" if clean_priority==3 & street_precleanedhn=="Saint Mayo"
replace inst=1 if clean_priority==3 & street_precleanedhn=="Saint Mayo"
replace st_edit="S St Marys St" if clean_priority==3 & street_precleanedhn=="Saint Mayo"
replace checked_st="c, ambiguous" if clean_priority==3 & street_precleanedhn=="Saint Mayo"
replace hn_edit=309 if clean_priority==3 & street_precleanedhn=="Saint Mayo" & line_num<56
replace hn_edit=321 if clean_priority==3 & street_precleanedhn=="Saint Mayo" & line_num==56
replace hn_edit=11 if clean_priority==3 & street_precleanedhn=="Saint Mayo" & line_num>56
replace checked_hn="c, ambiguous" if clean_priority==3 & street_precleanedhn=="Saint Mayo" & hn_edit==11
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Saint Mayo" & hn_edit!=11
replace st_edit="S Alamo St" if clean_priority==3 & street_precleanedhn=="Saint Mayo" & line_num==56

*S St Marys St in Ancestry; matches SM
browse if clean_priority==3 & street_precleanedhn=="S Saint Marys"
replace st_edit="S St Marys St" if clean_priority==3 & street_precleanedhn=="S Saint Marys"
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="S Saint Marys"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="S Saint Marys"

*S Presa St in Ancestry; SM has Presa St
browse if clean_priority==3 & street_precleanedhn=="S Press St"
replace hn_flag="301 rear" if clean_priority==3 & street_precleanedhn=="S Press St" & line_num<57 & line_num>53
replace st_edit="S Presa St" if clean_priority==3 & street_precleanedhn=="S Press St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="S Press St"
replace stname_flag="Presa St" if clean_priority==3 & street_precleanedhn=="S Press St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="S Press St"

*Microdata maches Ancestry and SM
browse if clean_priority==3 & street_precleanedhn=="E Nueva St"
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="E Nueva St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="E Nueva St"

*Looks like Wickes St in Ancestry; matches SM
browse if clean_priority==3 & street_precleanedhn=="Wishr St"
replace st_edit="Wickes St" if clean_priority==3 & street_precleanedhn=="Wishr St"
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="Wishr St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Wishr St"

*Hard to read but could be Mission St, which matches SM
browse if clean_priority==3 & street_precleanedhn=="Williow St"
replace st_edit="Mission St" if clean_priority==3 & street_precleanedhn=="Williow St"
replace checked_st="c, ambiguous" if clean_priority==3 & street_precleanedhn=="Williow St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Williow St"

*Looks like Cedar St, which matches SM
browse if clean_priority==3 & street_precleanedhn=="Adar St"
replace st_edit="Cedar St" if clean_priority==3 & street_precleanedhn=="Adar St"
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="Adar St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Adar St"

*Adams St in Ancestry, which matches SM
browse if clean_priority==3 & street_precleanedhn=="Adams"
replace st_edit="Adams St" if clean_priority==3 & street_precleanedhn=="Adams"
replace checked_st="c" if clean_priority==3 & street_precleanedhn=="Adams"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Adams"

*Could be Lotus St; SM has Lotus Ave
browse if clean_priority==3 & street_raw=="NO TUSST"
replace hn_edit=10 if clean_priority==3 & street_raw=="NO TUSST" & line_num<39 & line_num>32
replace hn_flag="10 B" if clean_priority==3 & street_raw=="NO TUSST" & hn_edit==10
replace st_edit="Lotus St" if clean_priority==3 & street_raw=="NO TUSST"
replace stname_flag="Lotus Ave" if clean_priority==3 & street_raw=="NO TUSST"
replace checked_st="c, ambiguous" if clean_priority==3 & street_raw=="NO TUSST"
replace checked_hn="c" if clean_priority==3 & street_raw=="NO TUSST"

*Wotus St in Ancestry but SM has Lotus St
browse if clean_priority==3 & street_precleanedhn=="Wotus St"
replace checked_st="c, ancestry match, SM missing" if clean_priority==3 & street_precleanedhn=="Wotus St"
replace stname_flag="Lotus Ave" if clean_priority==3 & street_precleanedhn=="Wotus St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Wotus St"

*S Presa St in Ancestry; SM has Presa St
browse if clean_priority==3 & street_precleanedhn=="S Presa"
replace st_edit="S Presa St" if clean_priority==3 & street_precleanedhn=="S Presa"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==3 & street_precleanedhn=="S Presa"
replace stname_flag="Presa St" if clean_priority==3 & street_precleanedhn=="S Presa"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="S Presa"

*Tremlett St in Ancestry; SM has Tremlett Ave
browse if clean_priority==3 & street_raw=="TROMLETT ST."
replace st_edit="Tremlett St" if clean_priority==3 & street_raw=="TROMLETT ST."
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="TROMLETT ST."
replace stname_flag="Tremlett Ave" if clean_priority==3 & street_raw=="TROMLETT ST."
replace checked_hn="c" if clean_priority==3 & street_raw=="TROMLETT ST."

*Parker St in Ancestry; SM has Parker Ave
browse if clean_priority==3 & street_precleanedhn=="Parker St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_precleanedhn=="Parker St"
replace stname_flag="Parker Ave" if clean_priority==3 & street_precleanedhn=="Parker St"
replace checked_hn="c" if clean_priority==3 & street_precleanedhn=="Parker St"

*Palo Blanco in Ancestry; SM has Palo Blanco St
browse if clean_priority==3 & street_raw=="PAL BLVD"
replace st_edit="Palo Blanco" if clean_priority==3 & street_raw=="PAL BLVD"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==3 & street_raw=="PAL BLVD"
replace stname_flag="Palo Blanco St" if clean_priority==3 & street_raw=="PAL BLVD"
replace checked_hn="c" if clean_priority==3 & street_raw=="PAL BLVD"

*Priority 3 finished

*4/13
*S Laredo in Ancestry; SM has S Laredo St
browse if clean_priority==4 & street_raw=="REAR S. LAREDO"
replace st_edit="S Laredo" if clean_priority==4 & street_raw=="REAR S. LAREDO"
replace hn_edit=726 if clean_priority==4 & street_raw=="REAR S. LAREDO" & hn==412
replace hn_flag="726 rear" if clean_priority==4 & street_raw=="REAR S. LAREDO" & hn==412
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_raw=="REAR S. LAREDO"
replace stname_flag="S Laredo St" if clean_priority==4 & street_raw=="REAR S. LAREDO"
replace checked_hn="c" if clean_priority==4 & street_raw=="REAR S. LAREDO"

*Does not seem to have st or hn
browse if clean_priority==4 & street_raw=="NOT USED"
replace checked_st="c, ambiguous" if clean_priority==4 & street_raw=="NOT USED"
replace checked_hn="c, ambiguous" if clean_priority==4 & street_raw=="NOT USED"

*S Flores St in Ancestry; matches SM
browse if clean_priority==4 & image_id=="4547939_00604"
replace st_edit="S Flores St" if clean_priority==4 & image_id=="4547939_00604"
replace hn_edit=921 if clean_priority==4 & image_id=="4547939_00604"
replace hn_flag="921 rear" if clean_priority==4 & image_id=="4547939_00604" & hn_flag!=""
replace checked_st="c" if clean_priority==4 & image_id=="4547939_00604"
replace checked_hn="c" if clean_priority==4 & image_id=="4547939_00604"

*Nathan St call back in Ancestry; SM has Nathan St
browse if clean_priority==4 & street_raw=="NATHAN ST CALL BACK"
replace st_edit="Nathan St" if clean_priority==4 & street_raw=="NATHAN ST CALL BACK"
replace stname_flag="Call back" if clean_priority==4 & street_raw=="NATHAN ST CALL BACK"
replace checked_st="c" if clean_priority==4 & street_raw=="NATHAN ST CALL BACK"
replace checked_hn="c" if clean_priority==4 & street_raw=="NATHAN ST CALL BACK"

*E Richie St in Ancestry; SM has Rische St
browse if clean_priority==4 & street_raw=="RICHIE"
replace hn_edit=115 if clean_priority==4 & street_raw=="RICHIE" & line_num<21
replace hn_flag="2" if clean_priority==4 & street_raw=="RICHIE" & hn_raw=="F2"
replace hn_flag=hn_raw if clean_priority==4 & street_raw=="RICHIE" & line_num>16 & line_num<21
replace st_edit="E Richie St" if clean_priority==4 & street_raw=="RICHIE"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_raw=="RICHIE"
replace stname_flag="Rische St" if clean_priority==4 & street_raw=="RICHIE"
replace checked_hn="c" if clean_priority==4 & street_raw=="RICHIE"

*Can't read street name. Might start with South
browse if clean_priority==4 & image_id=="4547939_00657"
replace hn_edit=1420 if clean_priority==4 & image_id=="4547939_00657" & hn==3
replace hn_flag="1420 rear (3)" if clean_priority==4 & image_id=="4547939_00657" & hn==3
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4547939_00657"
replace checked_hn="c" if clean_priority==4 & image_id=="4547939_00657"

*Applewhite St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Applewhite St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Applewhite St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Applewhite St"

*Lambert in Ancestry; SM has Lambert St
browse if clean_priority==4 & street_precleanedhn=="Lambert"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Lambert"
replace stname_flag="Lambert St" if clean_priority==4 & street_precleanedhn=="Lambert"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Lambert"

*Ancestry has Ceralvo; SM has Ceralvo St in diff ED
browse if clean_priorit==4 & street_precleanedhn=="Ceralvo"
replace checked_st="c, ancestry match, SM diff ED" if clean_priorit==4 & street_precleanedhn=="Ceralvo"
replace stname_flag="Ceralvo St" if clean_priorit==4 & street_precleanedhn=="Ceralvo"
replace checked_hn="c" if clean_priorit==4 & street_precleanedhn=="Ceralvo"

*Pruitt Ave in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Pruett"
replace st_edit="Pruitt Ave" if clean_priority==4 & street_precleanedhn=="Pruett"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Pruett"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Pruett"

*Mitchell in Ancestry; Mitchell Pl Add St in SM
browse if clean_priority==4 & street_precleanedhn=="Mitchell"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Mitchell"
replace stname_flag="Mitchell Pl Add St" if clean_priority==4 & street_precleanedhn=="Mitchell"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Mitchell"

*Maury in Ancestry; SM has Maury St
browse if clean_priority==4 & street_precleanedhn=="Maury"
replace hn_edit=205 if clean_priority==4 & street_precleanedhn=="Maury" & hn==305
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Maury"
replace stname_flag="" if clean_priority==4 & street_precleanedhn=="Maury"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Maury"

*McLeary in Ancestry; SM has McLeary St
browse if clean_priority==4 & street_precleanedhn=="Mcleary"
replace hn_edit=806 if clean_priority==4 & street_precleanedhn=="Mcleary"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Mcleary"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Mcleary"

*Franciscan St in Ancestry; SM has Franciscan Ave
browse if clean_priority==4 & street_precleanedhn=="Franciscan St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Franciscan St"
replace stname_flag="Franciscan Ave" if clean_priority==4 & street_precleanedhn=="Franciscan St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Franciscan St"

*Looks like Toudouze St in Ancestry; matches SM
browse if clean_priority==4 & street_raw=="TOWDANZE STREET"
replace st_edit="Toudouze St" if clean_priority==4 & street_raw=="TOWDANZE STREET"
replace checked_st="c" if clean_priority==4 & street_raw=="TOWDANZE STREET"
replace checked_hn="c" if clean_priority==4 & street_raw=="TOWDANZE STREET"

*Le Comte Pl in Ancestry; missing in SM but found in map
browse if clean_priority==4 & street_precleanedhn=="Le Camte Pl"
replace st_edit="Le Comte Pl" if clean_priority==4 & street_precleanedhn=="Le Camte Pl"
replace checked_st="c, ancestry match, SM missing" if clean_priority==4 & street_precleanedhn=="Le Camte Pl"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Le Camte Pl"

*Fairmount St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Fairmont St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Fairmont St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Fairmont St"

*Childress in ancestry; SM has Childress St in diff ED
browse if clean_priority==4 & street_precleanedhn=="Childress"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==4 & street_precleanedhn=="Childress"
replace stname_flag="Childress St" if clean_priority==4 & street_precleanedhn=="Childress"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Childress"

*Knox St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Knox St"
replace checked_hn="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Knox St" & hn>1000
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Knox St" & hn<1000
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Knox St"

*Edwards St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Edwards St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Edwards St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Edwards St" & line_num!=51
replace checked_hn="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Edwards St" & line_num==51

*Seems to be some sort of garden without proper street names
browse if clean_priority==4 & street_raw=="STWES IRRIGATED GORDENS-NO STREE"
replace st_edit="Irrigated Garderns - No Streets" if clean_priority==4 & street_raw=="STWES IRRIGATED GORDENS-NO STREE"
replace hn_edit=903 if clean_priority==4 & street_raw=="STWES IRRIGATED GORDENS-NO STREE" & line_num<63
replace hn_edit=215 if clean_priority==4 & street_raw=="STWES IRRIGATED GORDENS-NO STREE" & line_num>62
replace checked_st="c, ambiguous" if clean_priority==4 & street_raw=="STWES IRRIGATED GORDENS-NO STREE"
replace checked_hn="c, ambiguous" if clean_priority==4 & street_raw=="STWES IRRIGATED GORDENS-NO STREE"

*Looks like Boehmer Ave in Ancestry; SM has Boehmer St
browse if clean_priority==4 & street_precleanedhn=="Bochmer Ave"
replace st_edit="Boehmer Ave" if clean_priority==4 & street_precleanedhn=="Bochmer Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Bochmer Ave"
replace stname_flag="Boehmer St" if clean_priority==4 & street_precleanedhn=="Bochmer Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Bochmer Ave"

*Douran St in Ancestry; Douran Ave in SM
browse if clean_priority==4 & street_precleanedhn=="Douran St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Douran St"
replace stname_flag="Douran Ave" if clean_priority==4 & street_precleanedhn=="Douran St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Douran St"

*Hawthorne St in Ancestry; SM has it in diff ED
browse if clean_priority==4 & street_precleanedhn=="Hawthorne"
replace st_edit="Hawthorne St" if clean_priority==4 & street_precleanedhn=="Hawthorne"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==4 & street_precleanedhn=="Hawthorne"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Hawthorne"

*Sims St in Ancestry; SM has Sims Ave
browse if clean_priority==4 & street_precleanedhn=="Sans St"
replace st_edit="Sims St" if clean_priority==4 & street_precleanedhn=="Sans St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Sans St"
replace stname_flag="Sims Ave" if clean_priority==4 & street_precleanedhn=="Sans St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Sans St"

*Eskimo St in Ancestry; matches SM
browse if clean_priority==4 & overall_match=="Eskimo St"
replace checked_st="c" if clean_priority==4 & overall_match=="Eskimo St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Eskimo St"

*Barrett Pl in Ancestry; SM and map have Barret Pl
browse if clean_priority==4 & street_precleanedhn=="Barrett Pl"
replace hn_flag=hn_raw if clean_priority==4 & street_precleanedhn=="Barrett Pl"
replace hn_edit=435 if clean_priority==4 & street_precleanedhn=="Barrett Pl" & image_id=="4547940_00212" & line_num<93
replace hn_edit=439 if clean_priority==4 & street_precleanedhn=="Barrett Pl" & image_id=="4547940_00212" & line_num>93
replace hn_edit=330 if clean_priority==4 & street_precleanedhn=="Barrett Pl" & image_id=="4547940_00220"
replace hn_edit=316 if clean_priority==4 & street_precleanedhn=="Barrett Pl" & image_id=="4547940_00221"
replace st_edit="Barret Pl" if clean_priority==4 & street_precleanedhn=="Barrett Pl"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Barrett Pl"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Barrett Pl"

*4/17
*Thompson Pl in Ancestry; matches SM
browse if clean_priority==4 & street_raw=="THOMPSON PLACE"
replace hn_edit=403 if clean_priority==4 & street_raw=="THOMPSON PLACE" & hn_raw=="H03"
replace hn_flag=hn_raw if clean_priority==4 & street_raw=="THOMPSON PLACE" & hn_edit!=403
replace hn_edit=226 if clean_priority==4 & street_raw=="THOMPSON PLACE" & image_id=="4547940_00224"
replace hn_edit=424 if clean_priority==4 & street_raw=="THOMPSON PLACE" & image_id=="4547940_00228"
replace hn_edit=554 if clean_priority==4 & street_raw=="THOMPSON PLACE" & image_id=="4547940_00230" & line_num<20
replace hn_edit=506 if clean_priority==4 & street_raw=="THOMPSON PLACE" & image_id=="4547940_00230" & line_num>20
replace checked_st="c" if clean_priority==4 & street_raw=="THOMPSON PLACE"
replace checked_hn="c" if clean_priority==4 & street_raw=="THOMPSON PLACE"

*No street or house numbers. Just off Malone Ave
browse if clean_priority==4 & street_raw=="OFF OF MALONE AVENUE"
*removed hn_edit values
replace checked_st="c, ambiguous" if clean_priority==4 & street_raw=="OFF OF MALONE AVENUE"
replace checked_hn="c, ambiguous" if clean_priority==4 & street_raw=="OFF OF MALONE AVENUE"

*S Laredo in Ancestry; SM has S Laredo St
browse if clean_priority==4 & street_raw=="SO LOREDO"
replace hn_edit=310 if clean_priority==4 & street_raw=="SO LOREDO" & hn!=11342
replace hn_flag="Alley" if clean_priority==4 & street_raw=="SO LOREDO" & hn!=11342
replace checked_st="c" if clean_priority==4 & street_raw=="SO LOREDO"
replace checked_hn="c" if clean_priority==4 & street_raw=="SO LOREDO"

*Can't really read Ancestry. Could be Produce Row St, which matches SM
browse if clean_priority==4 & street_precleanedhn=="Pendton Road"
replace stname_flag="Produce Row St" if clean_priority==4 & street_precleanedhn=="Pendton Road"
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Pendton Road"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Pendton Road"

*S Monterrey in Ancestry; Monterey St in SM
browse if clean_priority==4 & street_precleanedhn=="S Monterrey"
replace hn_flag="224 1/2" if clean_priority==4 & street_precleanedhn=="S Monterrey" & hn_flag!=""
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="S Monterrey"
replace stname_flag="Monterey St" if clean_priority==4 & street_precleanedhn=="S Monterrey"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Monterrey"

*Nueva in Ancestry; not found in SM
browse if clean_priority==4 & street_precleanedhn=="Nueve"
replace st_edit="Nueva" if clean_priority==4 & street_precleanedhn=="Nueve"
replace checked_st="c, ancestry match, SM missing" if clean_priority==4 & street_precleanedhn=="Nueve"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Nueve"

*Pecos St in Ancestry; S PEcos St in SM
browse if clean_priority==4 & image_id=="4547940_00313"
replace hn_edit=312 if clean_priority==4 & image_id=="4547940_00313" & line_num>45
replace hn_flag="312 1/2" if clean_priority==4 & image_id=="4547940_00313" & line_num>45
replace st_edit="Pecos St" if clean_priority==4 & image_id=="4547940_00313"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & image_id=="4547940_00313"
replace stname_flag="S Pecos St" if clean_priority==4 & image_id=="4547940_00313"
replace checked_hn="c" if clean_priority==4 & image_id=="4547940_00313"

browse if clean_priority==4 & image_id=="4547940_00314"
replace hn_edit=312 if clean_priority==4 & image_id=="4547940_00314"
replace hn_flag="312 1/2" if clean_priority==4 & image_id=="4547940_00314"
replace st_edit="Pecos St" if clean_priority==4 & image_id=="4547940_00314"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & image_id=="4547940_00314"
replace stname_flag="S Pecos St" if clean_priority==4 & image_id=="4547940_00314"
replace checked_hn="c" if clean_priority==4 & image_id=="4547940_00314"

*S Pecos St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="S Pecos St"
replace hn_edit=424 if clean_priority==4 & street_precleanedhn=="S Pecos St" & image_id=="4547940_00323"
replace hn_flag="424 side" if clean_priority==4 & street_precleanedhn=="S Pecos St" & image_id=="4547940_00323"
replace hn_edit=410 if clean_priority==4 & street_precleanedhn=="S Pecos St" & image_id=="4547940_00324" & line_num<61
replace hn_flag="410 side" if clean_priority==4 & street_precleanedhn=="S Pecos St" & image_id=="4547940_00324" & line_num<61
replace hn_edit=408 if clean_priority==4 & street_precleanedhn=="S Pecos St" & image_id=="4547940_00324" & line_num>61
replace hn_flag="408 side" if clean_priority==4 & street_precleanedhn=="S Pecos St" & image_id=="4547940_00324" & line_num>61
replace hn_edit=516 if clean_priority==4 & street_precleanedhn=="S Pecos St" & hn_flag==""
replace hn_flag="516 side" if clean_priority==4 & street_precleanedhn=="S Pecos St" & hn_flag==""
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="S Pecos St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Pecos St"

*S Laredo St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="S Laredo St"
replace hn_flag="" if clean_priority==4 & street_precleanedhn=="S Laredo St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="S Laredo St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Laredo St"

*S Concho in Ancestry; SM has S Concho St
browse if clean_priority==4 & street_precleanedhn=="S Concho"
replace hn_edit=521 if clean_priority==4 & street_precleanedhn=="S Concho"
replace hn_flag="521 side" if clean_priority==4 & street_precleanedhn=="S Concho" & line_num<51
replace hn_flag="521 rear" if clean_priority==4 & street_precleanedhn=="S Concho" & line_num>50
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="S Concho"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Concho"

*San Luis St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="San Luis St"
replace hn_flag=hn_raw if clean_priority==4 & street_precleanedhn=="San Luis St"
*Manually edited hn_edit
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="San Luis St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="San Luis St"

*Matches SM; fixed hns
browse if clean_priority==4 & street_precleanedhn=="New Mexico Aly"
replace hn_edit=1 if clean_priority==4 & street_precleanedhn=="New Mexico Aly" & hn==414
replace hn_flag="" if clean_priority==4 & street_precleanedhn=="New Mexico Aly" & hn==414
replace hn_flag=hn_raw if clean_priority==4 & street_precleanedhn=="New Mexico Aly" & hn!=414
replace hn_edit=18 if clean_priority==4 & street_precleanedhn=="New Mexico Aly" & hn_flag=="18A"
replace hn_edit=16 if clean_priority==4 & street_precleanedhn=="New Mexico Aly" & hn_flag=="16B"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="New Mexico Aly"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="New Mexico Aly"

*S Pecos St in Ancestry; matches Ancestry
browse if clean_priority==4 & image_id=="4547940_00355"
replace st_edit="S Pecos St" if clean_priority==4 & image_id=="4547940_00355"
replace checked_st="c" if clean_priority==4 & image_id=="4547940_00355"
replace checked_hn="c" if clean_priority==4 & image_id=="4547940_00355"

*Matches SM; fixed hns
browse if clean_priority==4 & street_raw=="S. LAREDO"
replace hn_edit=629 if clean_priority==4 & street_raw=="S. LAREDO"
replace hn_flag=hn_raw if clean_priority==4 & street_raw=="S. LAREDO"
replace checked_st="c" if clean_priority==4 & street_raw=="S. LAREDO"
replace checked_hn="c, multi-unit" if clean_priority==4 & street_raw=="S. LAREDO"

*Matches SM and Ancestry
browse if clean_priority==4 & street_precleanedhn=="Monterey St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Monterey St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Monterey St"

*Matches SM; fixed hns
browse if clean_priority==4 & street_precleanedhn=="Monterrey"
replace hn_edit=907 if clean_priority==4 & street_precleanedhn=="Monterrey"
replace hn_flag="Apt 6" if clean_priority==4 & street_precleanedhn=="Monterrey" & hn==416
replace hn_flag="Apt 9" if clean_priority==4 & street_precleanedhn=="Monterrey" & hn==419
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Monterrey"
replace checked_hn="c, multi-unit" if clean_priority==4 & street_precleanedhn=="Monterrey"

*Seems to be an alley off Monterey St
browse if clean_priority==4 & street_precleanedhn=="Alley" & hn>900
replace st_edit="Monterey St" if clean_priority==4 & street_precleanedhn=="Alley" & hn>900
replace stname_flag="Alley" if clean_priority==4 & street_precleanedhn=="Alley" & hn>900
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Alley" & hn>900
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Alley" & hn>900

*Not found in SM
browse if clean_priority==4 & street_precleanedhn=="Indio Aly"
replace checked_st="c, ancestry match, SM missing" if clean_priority==4 & street_precleanedhn=="Indio Aly"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Indio Aly"

*4/18
*S San Saba St in SM, but diff ED
browse if clean_priority==4 & street_raw=="SO SAN SABAS STREET"
replace st_edit="S San Saba St" if clean_priority==4 & street_raw=="SO SAN SABAS STREET"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==4 & street_raw=="SO SAN SABAS STREET"
replace checked_hn="c" if clean_priority==4 & street_raw=="SO SAN SABAS STREET"

*San Marcos St in Ancestry; SM has S San Marcos St
browse if clean_priority==4 & street_precleanedhn=="San Mareno St"
replace st_edit="San Marcos St" if clean_priority==4 & street_precleanedhn=="San Mareno St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="San Mareno St"
replace stname_flag="S San Marcos St" if clean_priority==4 & street_precleanedhn=="San Mareno St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="San Mareno St"\

*Frio St in Ancestry; SM has S Frio St
browse if clean_priority==4 & street_precleanedhn=="Iris St"
replace hn_edit=807 if clean_priority==4 & street_precleanedhn=="Iris St" & hn==1807
replace st_edit="Frio St" if clean_priority==4 & street_precleanedhn=="Iris St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Iris St"
replace stname_flag="S Frio St" if clean_priority==4 & street_precleanedhn=="Iris St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Iris St"

*Matches SM, fixed hns
browse if clean_priority==4 & street_precleanedhn=="S Salado St"
replace hn_edit=1310 if clean_priority==4 & street_precleanedhn=="S Salado St"
replace hn_flag="APT 4" if clean_priority==4 & street_precleanedhn=="S Salado St" & hn==4
replace hn_flag=hn_raw if clean_priority==4 & street_precleanedhn=="S Salado St" & hn!=4
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="S Salado St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Salado St"

*Matches SM, fixed hns
browse if clean_priority==4 & street_precleanedhn=="S Medina St"
replace hn_edit=1219 if clean_priority==4 & street_precleanedhn=="S Medina St"
replace hn_edit=1115 if clean_priority==4 & street_precleanedhn=="S Medina St" & line_num<20
replace hn_flag=hn_raw if clean_priority==4 & street_precleanedhn=="S Medina St" & line_num>20
replace hn_flag="rear" if clean_priority==4 & street_precleanedhn=="S Medina St" & line_num<20
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="S Medina St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Medina St"

*Alley rear of Buena Vista St, which is in SM
browse if clean_priority==4 & street_precleanedhn=="Allevin Rear Of Buena Vista"
replace st_edit="Alley Rear of Buena Vista St" if clean_priority==4 & street_precleanedhn=="Allevin Rear Of Buena Vista"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Allevin Rear Of Buena Vista"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Allevin Rear Of Buena Vista"

*Alazan Creek in Ancestry; matches SM. Says no house number
browse if clean_priority==4 & street_precleanedhn=="Arazak Greek"
replace st_edit="Alazan Creek" if clean_priority==4 & street_precleanedhn=="Arazak Greek"
*Removed hn_edit values
replace hn_flag="No number" if clean_priority==4 & street_precleanedhn=="Arazak Greek"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Arazak Greek"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Arazak Greek"

*Matches SM, fixed hns
browse if clean_priority==4 & overall_match=="Durango St"
replace hn_edit=1315 if clean_priority==4 & overall_match=="Durango St"
replace checked_st="c" if clean_priority==4 & overall_match=="Durango St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Durango St"

*Could not find street name in Ancestry
browse if clean_priority==4 & image_id=="4547940_00735"
replace hn_edit=1513 if clean_priority==4 & image_id=="4547940_00735" & line_num==18
replace st_edit="Buena Vista St" if clean_priority==4 & image_id=="4547940_00735" & line_num==18
replace checked_st="c" if clean_priority==4 & image_id=="4547940_00735" & line_num==18
replace checked_hn="c" if clean_priority==4 & image_id=="4547940_00735"
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4547940_00735" & line_num!=18

*Matches SM
browse if clean_priority==4 & street_raw=="S. JOSE ST."
replace checked_st="c" if clean_priority==4 & street_raw=="S. JOSE ST."
replace checked_hn="c" if clean_priority==4 & street_raw=="S. JOSE ST."

*Matches SM, fixed hns
browse if clean_priority==4 & overall_match=="Guadalupe St"
replace hn_edit=1703 if clean_priority==4 & overall_match=="Guadalupe St"
replace checked_st="c" if clean_priority==4 & overall_match=="Guadalupe St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Guadalupe St"

*Matches SM, fixed hns
browse if clean_priority==4 & overall_match=="S Trinity St"
replace hn_edit=814 if clean_priority==4 & overall_match=="S Trinity St" & hn_raw=="R14"
replace hn_edit=806 if clean_priority==4 & overall_match=="S Trinity St" & hn_raw=="R06"
replace hn_edit=1001 if clean_priority==4 & overall_match=="S Trinity St" & hn_raw=="100"
replace checked_st="c" if clean_priority==4 & overall_match=="S Trinity St"
replace checked_hn="c" if clean_priority==4 & overall_match=="S Trinity St"

*No street on Ancestry. Could be Potosi St but not sure
browse if clean_priority==4 & image_id=="4547940_01007"
replace stname_flag="Potosi St" if clean_priority==4 & image_id=="4547940_01007"
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4547940_01007"
replace checked_hn="c" if clean_priority==4 & image_id=="4547940_01007"

*S Pinto in Ancestry; SM has Pinto St
browse if clean_priority==4 & street_precleanedhn=="S Pinto"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="S Pinto"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Pinto"
replace stname_flag="Pinto St" if clean_priority==4 & street_precleanedhn=="S Pinto"

*Tampico in Ancestry; SM has Tampico St
browse if clean_priority==4 & street_precleanedhn=="Tompier"
replace hn_edit=236 if clean_priority==4 & street_precleanedhn=="Tompier"
replace hn_flag="236 Rear" if clean_priority==4 & street_precleanedhn=="Tompier"
replace st_edit="Tampico" if clean_priority==4 & street_precleanedhn=="Tompier"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Tompier"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Tompier"
replace stname_flag="Tampico St" if clean_priority==4 & street_precleanedhn=="Tompier"

*Can't tell what street. Might be Vera Cruz St
browse if clean_priority==4 & image_id=="4547940_01020"
replace hn_edit=1010 if clean_priority==4 & image_id=="4547940_01020" & hn!=1102
replace hn_flag="2" if clean_priority==4 & image_id=="4547940_01020" & hn==10102
replace hn_flag=hn_raw if clean_priority==4 & image_id=="4547940_01020" & hn==1
replace stname_flag="Vera Cruz St" if clean_priority==4 & image_id=="4547940_01020"
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4547940_01020"
replace checked_hn="c, ambiguous" if clean_priority==4 & image_id=="4547940_01020"

*Street matches SM, but hn ambiguous
browse if clean_priority==4 & overall_match=="S Brazos St"
replace hn_flag=hn_raw if clean_priority==4 & overall_match=="S Brazos St"
replace hn_flag="APT8" if clean_priority==4 & overall_match=="S Brazos St" & hn_raw=="APT18"
replace hn_flag="APT7" if clean_priority==4 & overall_match=="S Brazos St" & hn_raw=="APT17"
replace hn_edit=1102 if clean_priority==4 & overall_match=="S Brazos St"
replace checked_hn="c, ambiguous" if clean_priority==4 & overall_match=="S Brazos St"
replace checked_st="c" if clean_priority==4 & overall_match=="S Brazos St"

*Looks like New St in Ancestry; SM doesn't have it 
browse if clean_priority==4 & street_precleanedhn=="New St"
replace checked_st="c, ancestry match, SM missing" if clean_priority==4 & street_precleanedhn=="New St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="New St"

*Looks like Penaloza in Ancestry; can't find it in SM
browse if clean_priority==4 & street_precleanedhn=="Penaloza"
replace checked_st="c, ancestry match, SM missing" if clean_priority==4 & street_precleanedhn=="Penaloza"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Penaloza"

*S Cibolo in Ancestry; SM has Cibolo St
browse if clean_priority==4 & street_precleanedhn=="S Cibolo"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="S Cibolo"
replace stname_flag="Cibolo St" if clean_priority==4 & street_precleanedhn=="S Cibolo" & hn<2000
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Cibolo"
replace st_edit="San Fernando St" if clean_priority==4 & street_precleanedhn=="S Cibolo" & hn>2000
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="S Cibolo" & hn>2000

*Matches SM, fixed hns
browse if clean_priority==4 & overall_match=="Buena Vista St"
replace hn_flag=hn_raw if clean_priority==4 & overall_match=="Buena Vista St" & ed==37
replace hn_edit=2202 if clean_priority==4 & overall_match=="Buena Vista St" & ed==37
replace hn_edit=2502 if clean_priority==4 & overall_match=="Buena Vista St" & ed==38
replace checked_st="c" if clean_priority==4 & overall_match=="Buena Vista St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Buena Vista St"

*Del Valle St in Ancestry; SM has Del Valle Aly
browse if clean_priority==4 & street_precleanedhn=="Del Valle St Not Numbered"
replace st_edit="Del Valle St" if clean_priority==4 & street_precleanedhn=="Del Valle St Not Numbered"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Del Valle St Not Numbered"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Del Valle St Not Numbered"
replace stname_flag="Del Valle Aly" if clean_priority==4 & street_precleanedhn=="Del Valle St Not Numbered"

browse if clean_priority==4 & street_precleanedhn=="Not Numbered Alley Del Valle St"
replace st_edit="Del Valle St" if clean_priority==4 & street_precleanedhn=="Not Numbered Alley Del Valle St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Not Numbered Alley Del Valle St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Not Numbered Alley Del Valle St"
replace stname_flag="Del Valle Aly" if clean_priority==4 & street_precleanedhn=="Not Numbered Alley Del Valle St"

*Looks like Aztec in Ancestry; SM has Aztec St
browse if clean_priority==4 & street_precleanedhn=="Agtic"
replace hn_edit=2609 if clean_priority==4 & street_precleanedhn=="Agtic" & line_num>42
replace st_edit="Aztec" if clean_priority==4 & street_precleanedhn=="Agtic"
replace st_edit="" if clean_priority==4 & street_precleanedhn=="Agtic" & line_num>42
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Agtic" & line_num<43
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Agtic" & line_num>42
replace stname_flag="Aztec St" if clean_priority==4 & street_precleanedhn=="Agtic" & line_num<43
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Agtic"

*S Rosillo in Ancestry; SM has Rosillos St
browse if clean_priority==4 & street_precleanedhn=="S Rosillo"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="S Rosillo"
replace stname_flag="Rosillos St" if clean_priority==4 & street_precleanedhn=="S Rosillo"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Rosillo"

*Can't tell what street it is
browse if clean_priority==4 & street_precleanedhn=="Torreon"
replace stname_flag="POSSIBLE DELETE" if clean_priority==4 & street_precleanedhn=="Torreon" & line_num<20
replace hn_edit=1220 if clean_priority==4 & street_precleanedhn=="Torreon" & line_num==25
replace hn_edit=1817 if clean_priority==4 & street_precleanedhn=="Torreon" & line_num>19 & line_num<24
replace stname_flag="POSSIBLE DELETE" if clean_priority==4 & street_precleanedhn=="Torreon" & line_num==24
replace stname_flag="" if clean_priority==4 & street_precleanedhn=="Torreon" & hn==1213
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Torreon"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Torreon"

*Eighteenth St in Ancestry
browse if clean_priority==4 & overall_match=="SW 18th St"
replace checked_st="c" if clean_priority==4 & overall_match=="SW 18th St"
replace checked_hn="c" if clean_priority==4 & overall_match=="SW 18th St"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="Colima St"
replace hn_edit=3014 if clean_priority==4 & overall_match=="Colima St" & line_num>60
replace hn_edit=2604 if clean_priority==4 & overall_match=="Colima St" & line_num<60
replace hn_flag="3014 ?" if clean_priority==4 & overall_match=="Colima St" & line_num>60
replace hn_flag="2604 ?" if clean_priority==4 & overall_match=="Colima St" & line_num<60
replace checked_st="c" if clean_priority==4 & overall_match=="Colima St"
replace checked_hn="c, ambiguous" if clean_priority==4 & overall_match=="Colima St"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="Chihuahua St"
replace hn_edit=1413 if clean_priority==4 & overall_match=="Chihuahua St" & line_num>90
replace hn_edit=2710 if clean_priority==4 & overall_match=="Chihuahua St" & line_num<16
replace hn_flag="No #" if clean_priority==4 & overall_match=="Chihuahua St" & line_num>15 & line_num<30
replace checked_st="c" if clean_priority==4 & overall_match=="Chihuahua St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Chihuahua St"

*Couldn't find street
browse if clean_priority==4 & image_id=="4548182_00422"
replace hn_edit=2221 if clean_priority==4 & image_id=="4548182_00422" & hn!=2701
replace hn_flag="Not numbered" if clean_priority==4 & image_id=="4548182_00422" & hn!=2701
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4548182_00422"
replace checked_hn="c" if clean_priority==4 & image_id=="4548182_00422"
replace checked_hn="c, ambiguous" if clean_priority==4 & image_id=="4548182_00422" & hn_flag!=""

*Last four lines are crossed out in Ancestry
browse if clean_priority==4 & overall_match=="Huerta St"
replace checked_st="c" if clean_priority==4 & overall_match=="Huerta St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Huerta St"
replace stname_flag="POSSIBLE DELTE" if clean_priority==4 & overall_match=="Huerta St" & hhid==""

*B St in Ancestry matches SM, but SM has it in diff ED
browse if clean_priority==4 & overall_match=="B St"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==4 & overall_match=="B St"
replace checked_hn="c" if clean_priority==4 & overall_match=="B St"

*W Martin St in Ancestry; SM has Martin St in ED 65
browse if clean_priority==4 & street_precleanedhn=="W Martin St"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==4 & street_precleanedhn=="W Martin St" & ed==42
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="W Martin St" & ed==65
replace stname_flag="Martin St" if clean_priority==4 & street_precleanedhn=="W Martin St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="W Martin St"

*4/19
*Looks like Palacios St in Ancestry but missing in SM
browse if clean_priority==4 & street_raw=="PALACIOS STREET"
replace checked_st="c, ancestry match, SM missing" if clean_priority==4 & street_raw=="PALACIOS STREET"
replace checked_hn="c" if clean_priority==4 & street_raw=="PALACIOS STREET"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="N Frio St"
replace hn_flag=hn_raw if clean_priority==4 & overall_match=="N Frio St"
replace hn_edit=708 if clean_priority==4 & overall_match=="N Frio St"
replace checked_st="c" if clean_priority==4 & overall_match=="N Frio St"
replace checked_hn="c" if clean_priority==4 & overall_match=="N Frio St"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="Ruiz St"
replace hn_edit=120 if clean_priority==4 & overall_match=="Ruiz St"
replace hn_flag="120-2 rear" if clean_priority==4 & overall_match=="Ruiz St" & hn==1202
replace hn_flag="120-9 rear" if clean_priority==4 & overall_match=="Ruiz St" & hn==1209
replace checked_st="c" if clean_priority==4 & overall_match=="Ruiz St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Ruiz St"

*Salinas St in Ancestry; SM has W Salinas St
browse if clean_priority==4 & street_precleanedhn=="Sabinas St"
replace st_edit="Salinas St" if clean_priority==4 & street_precleanedhn=="Sabinas St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Sabinas St"
replace stname_flag="W Salinas St" if clean_priority==4 & street_precleanedhn=="Sabinas St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Sabinas St"

*W Travis St in Ancestry; for ED 49, SM has Travis St
browse if clean_priority==4 & overall_match=="W Travis St"
replace hn_edit=1217 if clean_priority==4 & overall_match=="W Travis St" & hn==217
replace hn_flag="1217 rear" if clean_priority==4 & overall_match=="W Travis St" & hn==217
*Manually edited hn_edit values
replace hn_flag="1211 1/2 rear" if clean_priority==4 & overall_match=="W Travis St" & hn_edit==1211
replace hn_flag="1215 1/2 rear" if clean_priority==4 & overall_match=="W Travis St" & hn_edit==1215
replace hn_flag="1221 1/2 rear" if clean_priority==4 & overall_match=="W Travis St" & hn_edit==1221
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & overall_match=="W Travis St"
replace stname_flag="Travis St" if clean_priority==4 & overall_match=="W Travis St"
replace checked_hn="c" if clean_priority==4 & overall_match=="W Travis St"

*Might be N Medina St but not sure
browse if clean_priority==4 & image_id=="4548182_00655"
replace st_edit="N Medina St" if clean_priority==4 & image_id=="4548182_00655"
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4548182_00655"
replace checked_hn="c" if clean_priority==4 & image_id=="4548182_00655"

*W Martin in Ancestry; SM has Martin St in diff ED
browse if clean_priority==4 & street_precleanedhn=="W Martin"
replace hn_edit=1407 if clean_priority==4 & street_precleanedhn=="W Martin" & hn==407
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==4 & street_precleanedhn=="W Martin"
replace stname_flag="Martin St" if clean_priority==4 & street_precleanedhn=="W Martin"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="W Martin"

*Colorado St in Ancestry; SM has N Colorado St
browse if clean_priority==4 & street_precleanedhn=="Cololado St"
replace hn_edit=612 if clean_priority==4 & street_precleanedhn=="Cololado St" & hn==613
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Cololado St"
replace stname_flag="N Colorado St" if clean_priority==4 & street_precleanedhn=="Cololado St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Cololado St"

*Matches SM
browse if clean_priority==4 & overall_match=="N Brazos St"
replace checked_st="c" if clean_priority==4 & overall_match=="N Brazos St"
replace checked_hn="c" if clean_priority==4 & overall_match=="N Brazos St"

*Can't tell what street
browse if clean_priority==4 & image_id=="4548182_00717"
*Edited hn_edit values
replace hn_flag=hn_raw if clean_priority==4 & image_id=="4548182_00717" & line_num>8
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4548182_00717"
replace checked_hn="c, ambiguous" if clean_priority==4 & image_id=="4548182_00717"

*Matches SM
browse if clean_priority==4 & overall_match=="Travis St"
replace checked_st="c" if clean_priority==4 & overall_match=="Travis St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Travis St"

*Alley with no hns
browse if clean_priority==4 & street_raw=="ALLEY" & ed==53
*Removed hn_edit values
replace hn_flag="No number" if clean_priority==4 & street_raw=="ALLEY" & ed==53
replace checked_st="c" if clean_priority==4 & street_raw=="ALLEY" & ed==53
replace checked_hn="c" if clean_priority==4 & street_raw=="ALLEY" & ed==53

*Matches SM
browse if clean_priority==4 & overall_match=="Barnes Aly"
replace hn_flag="No number" if clean_priority==4 & overall_match=="Barnes Aly" & line_num>78
replace checked_st="c" if clean_priority==4 & overall_match=="Barnes Aly"
replace checked_hn="c" if clean_priority==4 & overall_match=="Barnes Aly"

*Rosillo in Ancestry; SM has Rosillos St
browse if clean_priority==4 & overall_match=="Rosillos St"
replace checked_st="c" if clean_priority==4 & overall_match=="Rosillos St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Rosillos St"

*Might be Picoso St, which matches SM
browse if clean_priority==4 & street_precleanedhn=="Picarso"
replace st_edit="Picoso St" if clean_priority==4 & street_precleanedhn=="Picarso"
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Picarso"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Picarso"

*N Spring in Ancestry; SM has Spring S
browse if clean_priority==4 & street_precleanedhn=="N Spring"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="N Spring"
replace stname_flag="Spring St" if clean_priority==4 & street_precleanedhn=="N Spring"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="N Spring"

*W Salinas St and W Travis St match SM
browse if clean_priority==4 & street_precleanedhn=="W Sabinas St"
replace st_edit="W Salinas St" if clean_priority==4 & street_precleanedhn=="W Sabinas St"
replace st_edit="W Travis St" if clean_priority==4 & street_precleanedhn=="W Sabinas St" & image_id=="4548182_01148"
replace hn_edit=4313 if clean_priority==4 & street_precleanedhn=="W Sabinas St" & image_id=="4548182_01148"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="W Sabinas St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="W Sabinas St"

*Rivas St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Ally River St"
replace st_edit="Rivas St" if clean_priority==4 & street_precleanedhn=="Ally River St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Ally River St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Ally River St"

*W Poplar St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Popler St"
replace st_edit="W Poplar St" if clean_priority==4 & street_precleanedhn=="Popler St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Popler St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Popler St"

*N Colorado St and Rivas St; which match SM
browse if clean_priority==4 & street_precleanedhn=="N Calwods St"
replace st_edit="N Colorado St" if clean_priority==4 & street_precleanedhn=="N Calwods St" & hn>1000
replace st_edit="Rivas St" if clean_priority==4 & street_precleanedhn=="N Calwods St" & hn<1000
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="N Calwods St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="N Calwods St"

*Could be Rivas St but not sure
browse if clean_priority==4 & street_raw=="?? STREET"
replace stname_flag="Rivas St" if clean_priority==4 & street_raw=="?? STREET"
replace checked_st="c, ambiguous" if clean_priority==4 & street_raw=="?? STREET"
replace checked_hn="c, ambiguous" if clean_priority==4 & street_raw=="?? STREET" & line_num<64
replace checked_hn="c" if clean_priority==4 & street_raw=="?? STREET" & line_num>63

*Looks like N Brazos St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="N Propor St"
replace st_edit="N Brazos St" if clean_priority==4 & street_precleanedhn=="N Propor St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="N Propor St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="N Propor St"

*4/20
*Corner of ?? and N Brazos St. N Brazos St in SM
browse if clean_priority==4 & street_precleanedhn=="Corner Of Dlyods - N Broy"
replace st_edit="N Brazos St" if clean_priority==4 & street_precleanedhn=="Corner Of Dlyods - N Broy"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Corner Of Dlyods - N Broy"
replace stname_flag="Corner of ?? and N Brazos St" if clean_priority==4 & street_precleanedhn=="Corner Of Dlyods - N Broy"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Corner Of Dlyods - N Broy"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="Colorado Aly"
replace hn_edit=1017 if clean_priority==4 & overall_match=="Colorado Aly" & hn_flag!=""
replace hn_flag="321 R" if clean_priority==4 & overall_match=="Colorado Aly" & hn==321
replace checked_st="c" if clean_priority==4 & overall_match=="Colorado Aly"
replace checked_hn="c" if clean_priority==4 & overall_match=="Colorado Aly"

*Ruiz St (Ruiz Aly) in Ancestry; SM only has St
browse if clean_priority==4 & street_precleanedhn=="Ruiz Street Ruiz Aly"
replace hn_edit=907 if clean_priority==4 & street_precleanedhn=="Ruiz Street Ruiz Aly" & hn_flag!=""
replace st_edit="Ruiz St" if clean_priority==4 & street_precleanedhn=="Ruiz Street Ruiz Aly"
replace stname_flag="(Ruiz Aly)" if clean_priority==4 & street_precleanedhn=="Ruiz Street Ruiz Aly"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Ruiz Street Ruiz Aly"
replace checked_hn="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Ruiz Street Ruiz Aly"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="W Laurel St"
replace hn_edit=108 if clean_priority==4 & overall_match=="W Laurel St" & line_num==16
*Manually edited hn_edit values for ed 56
replace hn_edit=2107 if clean_priority==4 & overall_match=="W Laurel St" & line_num>64
replace hn_edit=2111 if clean_priority==4 & overall_match=="W Laurel St" & line_num>67
replace hn_edit=2175 if clean_priority==4 & overall_match=="W Laurel St" & line_num>77
replace checked_st="c" if clean_priority==4 & overall_match=="W Laurel St"
replace checked_hn="c" if clean_priority==4 & overall_match=="W Laurel St"

*Colorado Ave in Ancestry; SM has N Colorado St and Colorado Aly
browse if clean_priority==4 & street_precleanedhn=="Colorado Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Colorado Ave"
replace stname_flag="N Colorado St/Colorado Aly" if clean_priority==4 & street_precleanedhn=="Colorado Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Colorado Ave"

*Granado St matches SM. Can't read other street
browse if clean_priority==4 & street_precleanedhn=="N Osugos"
replace st_edit="Granado St" if clean_priority==4 & street_precleanedhn=="N Osugos" & hn<700
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="N Osugos" & hn<700
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="N Osugos" & hn>700
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="N Osugos"

*Alley that might be off of Railroad Tracks St
browse if clean_priority==4 & street_precleanedhn=="Alley Mc R ??"
*Removed hn_edit values
replace st_edit="Alley" if clean_priority==4 & street_precleanedhn=="Alley Mc R ??"
replace stname_flag="Railroad Tracks St" if clean_priority==4 & street_precleanedhn=="Alley Mc R ??"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Alley Mc R ??"
replace checked_hn="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Alley Mc R ??"

*Looks like N Calaveras St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="N Caloresse St"
replace hn_edit=2206 if clean_priority==4 & street_precleanedhn=="N Caloresse St"
replace hn_edit=2210 if clean_priority==4 & street_precleanedhn=="N Caloresse St" & line_num>18
replace hn_edit=2212 if clean_priority==4 & street_precleanedhn=="N Caloresse St" & line_num>22
replace st_edit="N Calaveras St" if clean_priority==4 & street_precleanedhn=="N Caloresse St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="N Caloresse St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="N Caloresse St"

*Could be E Texas Ave in Ancestry; SM has Texas Ave
browse if clean_priority==4 & street_precleanedhn=="E Tyas Ave"
replace st_edit="E Texas Ave" if clean_priority==4 & street_precleanedhn=="E Tyas Ave"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="E Tyas Ave"
replace stname_flag="Texas Ave" if clean_priority==4 & street_precleanedhn=="E Tyas Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="E Tyas Ave"

*Matches SM
browse if clean_priority==4 & overall_match=="Fredericksburg Road"
replace checked_st="c" if clean_priority==4 & overall_match=="Fredericksburg Road"
replace checked_hn="c" if clean_priority==4 & overall_match=="Fredericksburg Road"

*W Kings Hwy in Ancestry; SM has Kings Hy St
browse if clean_priority==4 & street_precleanedhn=="W Kings Hwy"
replace hn_edit=2131 if clean_priority==4 & street_precleanedhn=="W Kings Hwy" & image_id=="4548183_00379" & line_num<14
replace hn_edit=2151 if clean_priority==4 & street_precleanedhn=="W Kings Hwy" & image_id=="4548183_00379" & line_num>13
replace hn_edit=2158 if clean_priority==4 & street_precleanedhn=="W Kings Hwy" & image_id=="4548183_00381"
replace hn_edit=2150 if clean_priority==4 & street_precleanedhn=="W Kings Hwy" & image_id=="4548183_00381" & line_num>5
replace hn_edit=2110 if clean_priority==4 & street_precleanedhn=="W Kings Hwy" & image_id=="4548183_00381" & line_num>8
replace stname_flag="Kings Hy St" if clean_priority==4 & street_precleanedhn=="W Kings Hwy"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="W Kings Hwy"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="W Kings Hwy"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="W French Pl"
replace hn_edit=2653 if clean_priority==4 & overall_match=="W French Pl" & ed==207
replace hn_edit=2649 if clean_priority==4 & overall_match=="W French Pl" & ed==207 & line_num>55
replace hn_edit=2643 if clean_priority==4 & overall_match=="W French Pl" & ed==207 & line_num>57
replace hn_edit=2641 if clean_priority==4 & overall_match=="W French Pl" & ed==207 & line_num>63
replace hn_edit=2027 if clean_priority==4 & overall_match=="W French Pl" & ed==208
replace hn_edit=2023 if clean_priority==4 & overall_match=="W French Pl" & ed==208 & line_num>2
replace hn_edit=2019 if clean_priority==4 & overall_match=="W French Pl" & ed==208 & line_num>5
replace checked_st="c" if clean_priority==4 & overall_match=="W French Pl"
replace checked_hn="c" if clean_priority==4 & overall_match=="W French Pl"

*San Antonio Ave matches SM. Woodlawn in Ancestry; SM has W Woodlawn Ave
browse if clean_priority==4 & overall_match=="San Antonio Ave"
replace st_edit="Woodlawn" if clean_priority==4 & overall_match=="San Antonio Ave" & line_num>10
replace checked_st="c" if clean_priority==4 & overall_match=="San Antonio Ave" & line_num<11
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & overall_match=="San Antonio Ave" & line_num>10
replace stname_flag="W Woodlawn Ave" if clean_priority==4 & overall_match=="San Antonio Ave" & line_num>10
replace checked_hn="c" if clean_priority==4 & overall_match=="San Antonio Ave"

*Can't read street names
browse if clean_priority==4 & image_id=="4548183_00405"
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4548183_00405"
replace checked_hn="c" if clean_priority==4 & image_id=="4548183_00405"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="Cincinnati Ave"
replace hn_edit=1000 if clean_priority==4 & overall_match=="Cincinnati Ave" 
replace hn_edit=1016 if clean_priority==4 & overall_match=="Cincinnati Ave" & line_num>5
replace checked_st="c" if clean_priority==4 & overall_match=="Cincinnati Ave"
replace checked_hn="c" if clean_priority==4 & overall_match=="Cincinnati Ave"

*Hamilton in Ancestry; SM has N Hamilton Ave
browse if clean_priority==4 & overall_match=="N Hamilton Ave"
replace hn_edit=1801 if clean_priority==4 & overall_match=="N Hamilton Ave" & image_id=="4548183_00419"
replace hn_edit=1714 if clean_priority==4 & overall_match=="N Hamilton Ave" & image_id=="4548183_00427"
replace checked_st="c" if clean_priority==4 & overall_match=="N Hamilton Ave"
replace checked_hn="c" if clean_priority==4 & overall_match=="N Hamilton Ave"

*Matches SM, fixed hns
browse if clean_priority==4 & overall_match=="Culebra Ave"
replace hn_edit=1452 if clean_priority==4 & overall_match=="Culebra Ave" & image_id=="4548183_00423"
*Manually edited hn_edit values
replace checked_st="c" if clean_priority==4 & overall_match=="Culebra Ave"
replace checked_hn="c" if clean_priority==4 & overall_match=="Culebra Ave"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="Wooley Ave"
*Added hn_edit values
replace checked_st="c" if clean_priority==4 & overall_match=="Wooley Ave"
replace checked_hn="c" if clean_priority==4 & overall_match=="Wooley Ave"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="Carter St"
*Added hn_edit values
replace checked_st="c" if clean_priority==4 & overall_match=="Carter St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Carter St"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="McLeod St"
*Added hn_edit values
replace checked_st="c" if clean_priority==4 & overall_match=="McLeod St"
replace checked_hn="c" if clean_priority==4 & overall_match=="McLeod St"

*Looks like Aedes St in Ancestry; SM has Aedes Ave
browse if clean_priority==4 & street_precleanedhn=="Adaer St"
replace hn_edit=430 if clean_priority==4 & street_precleanedhn=="Adaer St" & line_num<3
*Edited hn_edit values
replace st_edit="Adaes St" if clean_priority==4 & street_precleanedhn=="Adaer St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Adaer St"
replace stname_flag="Adaes Ave" if clean_priority==4 & street_precleanedhn=="Adaer St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Adaer St"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="NW 19th St"
*Added hn_edit values
replace checked_st="c" if clean_priority==4 & overall_match=="NW 19th St"
replace checked_hn="c" if clean_priority==4 & overall_match=="NW 19th St"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="Goodrich St"
*Manually edited hn_edit values
replace checked_st="c" if clean_priority==4 & overall_match=="Goodrich St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Goodrich St"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="NW 23rd St"
*Edited hn_edit values
replace checked_st="c" if clean_priority==4 & overall_match=="NW 23rd St"
replace checked_hn="c" if clean_priority==4 & overall_match=="NW 23rd St"

*Goodrich St; fixed hns
browse if clean_priority==4 & street_precleanedhn=="66th"
*Edited hn_edit values
replace st_edit="Goodrich St" if clean_priority==4 & street_precleanedhn=="66th"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="66th"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="66th"

*Adaes St in Ancestry; SM has Aedes Ave
browse if clean_priority==4 & street_precleanedhn=="Adaer"
replace st_edit="Adaes St" if clean_priority==4 & street_precleanedhn=="Adaer"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Adaer"
replace stname_flag="Adaes Ave" if clean_priority==4 & street_precleanedhn=="Adaer"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Adaer"

*Matches SM
browse if clean_priority==4 & overall_match=="Giraud St"
replace checked_st="c" if clean_priority==4 & overall_match=="Giraud St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Giraud St"

*Seems to be an alley off of Flores St. SM has N Flores St
browse if clean_priority==4 & street_precleanedhn=="Seeline Aly"
replace st_edit="Alley" if clean_priority==4 & street_precleanedhn=="Seeline Aly"
replace st_edit="Flores St" if clean_priority==4 & street_precleanedhn=="Seeline Aly" & line_num==50
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Seeline Aly"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Seeline Aly" & line_num==50
replace stname_flag="N Flores St" if clean_priority==4 & street_precleanedhn=="Seeline Aly"
replace hn_edit=641 if clean_priority==4 & street_precleanedhn=="Seeline Aly" & line_num==50
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Seeline Aly"

*Matches SM
browse if clean_priority==4 & overall_match=="Martin St"
replace checked_st="c" if clean_priority==4 & overall_match=="Martin St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Martin St"

*Looks like Rossy St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Ross St"
replace st_edit="Rossy St" if clean_priority==4 & street_precleanedhn=="Ross St"
replace hn_edit=233 if clean_priority==4 & street_precleanedhn=="Ross St" & line_num==81
replace st_edit="W Salinas St" if clean_priority==4 & street_precleanedhn=="Ross St" & line_num==81
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Ross St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Ross St"

*Looks like W Elmira in Ancestry; SM has W Elmira St
browse if clean_priority==4 & street_precleanedhn=="W Ennia"
replace st_edit="W Elmira" if clean_priority==4 & street_precleanedhn=="W Ennia"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="W Ennia"
replace stname_flag="W Elmira St" if clean_priority==4 & street_precleanedhn=="W Ennia"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="W Ennia"

*Looks like Howard in Ancestry; SM has Howard St
browse if clean_priority==4 & street_precleanedhn=="Haverd"
replace st_edit="Howard" if clean_priority==4 & street_precleanedhn=="Haverd"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Haverd"
replace stname_flag="Howard St" if clean_priority==4 & street_precleanedhn=="Haverd"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Haverd"

*4/24
*San Pedro Ave in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Sity Pedro"
replace st_edit="San Pedro Ave" if clean_priority==4 & street_precleanedhn=="Sity Pedro"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Sity Pedro"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Sity Pedro"

*W Euclid Ave in Ancestry; SM has W Euclid St
browse if clean_priority==4 & street_precleanedhn=="W Eculid Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="W Eculid Ave"
replace stname_flag="W Euclid St" if clean_priority==4 & street_precleanedhn=="W Eculid Ave"
replace st_edit="W Euclid Ave" if clean_priority==4 & street_precleanedhn=="W Eculid Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="W Eculid Ave"

*N St Marys matches SM. E Martin St in Ancestry; SM has Martin St
browse if clean_priority==4 & street_precleanedhn=="N Saint Marys"
replace hn_edit=610 if clean_priority==4 & street_precleanedhn=="N Saint Marys" & ed==86
replace hn_edit=228 if clean_priority==4 & street_precleanedhn=="N Saint Marys" & line_num>60
replace institution_edit="Affleck Apartments" if clean_priority==4 & street_precleanedhn=="N Saint Marys" & ed==86
replace institution_edit="De Sota Hotel" if clean_priority==4 & street_precleanedhn=="N Saint Marys" & ed==86 & line_num>60
replace inst=1 if clean_priority==4 & street_precleanedhn=="N Saint Marys" & ed==86
replace st_edit="E Martin St" if clean_priority==4 & street_precleanedhn=="N Saint Marys" & line_num>60
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="N Saint Marys"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="N Saint Marys" & line_num>60
replace stname_flag="Martin St" if clean_priority==4 & street_precleanedhn=="N Saint Marys" & line_num>60
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="N Saint Marys"

*Seems like N St Marys St in Ancestry, which matches SM
browse if clean_priority==4 & image_id=="4548183_00726"
replace st_edit="N St Marys St" if clean_priority==4 & image_id=="4548183_00726"
replace checked_st="c" if clean_priority==4 & image_id=="4548183_00726"
replace checked_hn="c" if clean_priority==4 & image_id=="4548183_00726"

*Looks like Polk in Ancestry; SM has Polk St
browse if clean_priority==4 & street_precleanedhn=="Folk"
replace st_edit="Polk" if clean_priority==4 & street_precleanedhn=="Folk"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Folk"
replace stname_flag="Polk St" if clean_priority==4 & street_precleanedhn=="Folk"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Folk"

*SM has similar Grissom St in diff ED, but they could be different streets
browse if clean_priority==4 & street_precleanedhn=="Grisson Ct"
replace checked_st="c, ancestry match, SM missing" if clean_priority==4 & street_precleanedhn=="Grisson Ct"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Grisson Ct"

*R? Locust on Ancestry; SM has Locust St
browse if clean_priority==4 & street_precleanedhn=="R Locust"
replace hn_edit=206 if clean_priority==4 & street_precleanedhn=="R Locust" & hn==306
replace hn_flag="206 1/2" if clean_priority==4 & street_precleanedhn=="R Locust" & hn==306
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="R Locust"
replace stname_flag="Locust St" if clean_priority==4 & street_precleanedhn=="R Locust"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="R Locust"

*Looks like it could be Erie in Ancestry; SM has Erie Ave
browse if clean_priority==4 & street_precleanedhn=="Eri"
replace st_edit="Erie" if clean_priority==4 & street_precleanedhn=="Eri"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Eri"
replace stname_flag="Erie Ave" if clean_priority==4 & street_precleanedhn=="Eri"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Eri"

*Matches SM
browse if clean_priority==4 & overall_match=="Wilmington St"
replace hn_flag="61?" if clean_priority==4 & overall_match=="Wilmington St" & line_num>70
replace checked_st="c" if clean_priority==4 & overall_match=="Wilmington St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Wilmington St" & hn_flag==""
replace checked_hn="c, ambiguous" if clean_priority==4 & overall_match=="Wilmington St" & hn_flag!=""

browse if clean_priority==4 & street_precleanedhn=="Willington"
replace st_edit="Wilmington St" if clean_priority==4 & street_precleanedhn=="Willington"
replace st_edit="E Euclid St" if clean_priority==4 & street_precleanedhn=="Willington" & hn==801
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Willington"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Willington"

*Main Ave in Ancestry; matches SM
browse if clean_priority==4 & overall_match=="E Poplar St"
replace st_edit="Main Ave" if clean_priority==4 & overall_match=="E Poplar St"
replace checked_st="c" if clean_priority==4 & overall_match=="E Poplar St"
replace checked_hn="c" if clean_priority==4 & overall_match=="E Poplar St"

*W Cypress in Ancestry; SM has Cypress St
browse if clean_priority==4 & overall_match=="Cypress St"
replace hn_edit=225 if clean_priority==4 & overall_match=="Cypress St" & line_num<19
replace hn_edit=231 if clean_priority==4 & overall_match=="Cypress St" & line_num>18
replace checked_st="c" if clean_priority==4 & overall_match=="Cypress St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Cypress St"

*W Locust in Ancestry; SM has Locust St
browse if clean_priority==4 & street_precleanedhn=="W Locust"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="W Locust"
replace stname_flag="Locust St" if clean_priority==4 & street_precleanedhn=="W Locust"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="W Locust"

*Ogden in Ancestry; SM has Ogden St
browse if clean_priority==4 & overall_match=="Ogden St"
replace checked_st="c" if clean_priority==4 & overall_match=="Ogden St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Ogden St"

*Matches SM
browse if clean_priority==4 & street_precleanedhn=="Odgen St"
replace st_edit="Ogden St" if clean_priority==4 & street_precleanedhn=="Odgen St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Odgen St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Odgen St"

*W Dewey Pl in Ancestry; SM has Dewey Pl
browse if clean_priority==4 & street_precleanedhn=="W Dewey"
replace st_edit="W Dewey Pl" if clean_priority==4 & street_precleanedhn=="W Dewey"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="W Dewey"
replace stname_flag="Dewey Pl" if clean_priority==4 & street_precleanedhn=="W Dewey"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="W Dewey"

*Can't find street name
browse if clean_priority==4 & image_id=="4548184_00112"
replace checked_hn="c" if clean_priority==4 & image_id=="4548184_00112"
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4548184_00112"

*Woodlawn Ave in Ancestry; SM has W Woodlawn Ave
browse if clean_priority==4 & street_precleanedhn=="Woodland Ave"
replace st_edit="Woodlawn Ave" if clean_priority==4 & street_precleanedhn=="Woodland Ave"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Woodland Ave"
replace stname_flag="W Woodlawn Ave" if clean_priority==4 & street_precleanedhn=="Woodland Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Woodland Ave"

*Can't find st name. Might be W French or Ashley
browse if clean_priority==4 & image_id=="4548184_00161"
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4548184_00161"
replace checked_hn="c" if clean_priority==4 & image_id=="4548184_00161"

*Looks like W Agarita Ave in Ancestry; SM has Agarita Ave
browse if clean_priority==4 & street_precleanedhn=="Wayanta Ave"
replace st_edit="W Agarita Ave" if clean_priority==4 & street_precleanedhn=="Wayanta Ave"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Wayanta Ave"
replace stname_flag="Agarita Ave" if clean_priority==4 & street_precleanedhn=="Wayanta Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Wayanta Ave"

*Looks like E Agarita Ave in Ancestry; SM has Agarita Ave
browse if clean_priority==4 & street_precleanedhn=="Eaganta Ave"
replace st_edit="E Agarita Ave" if clean_priority==4 & street_precleanedhn=="Eaganta Ave"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Eaganta Ave"
replace stname_flag="Agarita Ave" if clean_priority==4 & street_precleanedhn=="Eaganta Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Eaganta Ave"

browse if clean_priority==4 & street_precleanedhn=="E Aganta Ave"
replace st_edit="E Agarita Ave" if clean_priority==4 & street_precleanedhn=="E Aganta Ave"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="E Aganta Ave"
replace stname_flag="Agarita Ave" if clean_priority==4 & street_precleanedhn=="E Aganta Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="E Aganta Ave"

*4/25
*No clear st name on Ancestry
browse if clean_priority==4 & image_id=="4548184_00236"
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4548184_00236"
replace checked_hn="c" if clean_priority==4 & image_id=="4548184_00236"

*Very messy in ancestry. Seems like multiple sts and hns
browse if clean_priority==4 & street_precleanedhn=="W Agenita"
replace hn_edit=514 if clean_priority==4 & street_precleanedhn=="W Agenita"
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="W Agenita"
replace checked_hn="c, ambiguous" if clean_priority==4 & street_precleanedhn=="W Agenita"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="Hollywood Ave"
replace hn_flag=hn_raw if clean_priority==4 & overall_match=="Hollywood Ave"
replace hn_edit=403 if clean_priority==4 & overall_match=="Hollywood Ave" & image_id=="4548184_00289"
replace hn_edit=343 if clean_priority==4 & overall_match=="Hollywood Ave" & image_id=="4548184_00291"
replace hn_edit=123 if clean_priority==4 & overall_match=="Hollywood Ave" & image_id=="4548184_00295" & line_num<70
replace hn_edit=103 if clean_priority==4 & overall_match=="Hollywood Ave" & image_id=="4548184_00295" & line_num>70
replace hn_edit=126 if clean_priority==4 & overall_match=="Hollywood Ave" & image_id=="4548184_00296"
replace hn_edit=210 if clean_priority==4 & overall_match=="Hollywood Ave" & image_id=="4548184_00298"
replace hn_edit=314 if clean_priority==4 & overall_match=="Hollywood Ave" & image_id=="4548184_00299" & line_num<70
replace hn_edit=302 if clean_priority==4 & overall_match=="Hollywood Ave" & image_id=="4548184_00299" & line_num>70
replace hn_edit=510 if clean_priority==4 & overall_match=="Hollywood Ave" & image_id=="4548184_00301"
replace checked_st="c" if clean_priority==4 & overall_match=="Hollywood Ave"
replace checked_hn="c" if clean_priority==4 & overall_match=="Hollywood Ave"

*Looks like W Kings Hwy in Ancestry; SM has King's Hy St
browse if clean_priority==4 & street_precleanedhn=="Kings Man"
replace st_edit="W Kings Hwy" if clean_priority==4 & street_precleanedhn=="Kings Man"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Kings Man"
replace stname_flag="King's Hy St" if clean_priority==4 & street_precleanedhn=="Kings Man"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Kings Man"

*Breeden Ave in Ancestry; matches SM
browse if clean_priority==4 & overall_match=="Breeden Ave"
replace checked_st="c" if clean_priority==4 & overall_match=="Breeden Ave"
replace checked_hn="c" if clean_priority==4 & overall_match=="Breeden Ave"

*Grant in Ancestry; Grant Ave in SM
browse if clean_priority==4 & street_precleanedhn=="Grant"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Grant"
replace stname_flag="Grant Ave" if clean_priority==4 & street_precleanedhn=="Grant"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Grant"

*W Capitol in Ancestry; SM has Capital Ave
browse if clean_priority==4 & street_precleanedhn=="W Capital"
replace st_edit="W Capitol" if clean_priority==4 & street_precleanedhn=="W Capital"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="W Capital"
replace stname_flag="Capitol Ave" if clean_priority==4 & street_precleanedhn=="W Capital"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="W Capital"

*W Hollywood Ave in Ancestry; SM has Hollywood Ave
browse if clean_priority==4 & street_precleanedhn=="N Hallywood"
replace st_edit="W Hollywood Ave" if clean_priority==4 & street_precleanedhn=="N Hallywood"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="N Hallywood"
replace stname_flag="Hollywood Ave" if clean_priority==4 & street_precleanedhn=="N Hallywood"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="N Hallywood"

*W Kings Hwy in Ancestry; SM has King's Hy St
browse if clean_priority==4 & street_precleanedhn=="W Kingshighway"
replace st_edit="W Kings Hwy" if clean_priority==4 & street_precleanedhn=="W Kingshighway"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="W Kingshighway"
replace stname_flag="King's Hy St" if clean_priority==4 & street_precleanedhn=="W Kingshighway"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="W Kingshighway"

*Ridgewood St in Ancestry; W Ridgewood Ct in SM
browse if clean_priority==4 & street_precleanedhn=="Ridgewood St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Ridgewood St"
replace stname_flag="W Ridgewood Ct" if clean_priority==4 & street_precleanedhn=="Ridgewood St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Ridgewood St"

*Lullwood St in Ancestry; W Lullwood Ave in SM
browse if clean_priority==4 & street_precleanedhn=="Lullwood St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Lullwood St"
replace stname_flag="W Lullwood Ave" if clean_priority==4 & street_precleanedhn=="Lullwood St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Lullwood St"

*Hildebrand in Ancestry; SM has W Hildebrand Ave
browse if clean_priority==4 & street_precleanedhn=="Hilderbrand"
replace st_edit="Hildebrand" if clean_priority==4 & street_precleanedhn=="Hilderbrand"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Hilderbrand"
replace stname_flag="W Hildebrand Ave" if clean_priority==4 & street_precleanedhn=="Hilderbrand"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Hilderbrand"

*St Clair in Ancestry; SM has St Clair St
browse if clean_priority==4 & street_precleanedhn=="Saint Clair"
replace hn_edit=539 if clean_priority==4 & street_precleanedhn=="Saint Clair" & hn==1599
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Saint Clair"
replace stname_flag="St Clair St" if clean_priority==4 & street_precleanedhn=="Saint Clair"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Saint Clair"

*W Elsmere in Ancestry; SM has Elsmere Pl
browse if clean_priority==4 & street_precleanedhn=="W Elsmere"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="W Elsmere"
replace stname_flag="Elsmere Pl" if clean_priority==4 & street_precleanedhn=="W Elsmere"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="W Elsmere"

*W Agarita in Ancestry; Agarita Ave in SM
browse if clean_priority==4 & image_id=="4548184_00551"
replace hn_edit=1129 if clean_priority==4 & image_id=="4548184_00551" & hn==1124
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & image_id=="4548184_00551"
replace stname_flag="Agarita Ave" if clean_priority==4 & image_id=="4548184_00551"
replace checked_hn="c" if clean_priority==4 & image_id=="4548184_00551"

*Warner St in Ancestry; SM has Warner Ave
browse if clean_priority==4 & street_precleanedhn=="Warner St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Warner St"
replace stname_flag="Warner Ave" if clean_priority==4 & street_precleanedhn=="Warner St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Warner St"

browse if clean_priority==4 & image_id=="4548184_00567" & checked_st==""
replace hn_edit=311 if clean_priority==4 & image_id=="4548184_00567" & checked_st=="" & line_num>16 & line_num<23
replace st_edit="Warner St" if clean_priority==4 & image_id=="4548184_00567" & checked_st==""
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & image_id=="4548184_00567" & checked_st==""
replace stname_flag="Warner Ave" if clean_priority==4 & image_id=="4548184_00567" & checked_st==""
replace checked_hn="c" if clean_priority==4 & image_id=="4548184_00567" & checked_st==""

*W Magnolia St in Ancestry; SM has W Magnolia Ave
browse if clean_priority==4 & street_precleanedhn=="Magnolia St"
replace st_edit="W Magnolia St" if clean_priority==4 & street_precleanedhn=="Magnolia St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Magnolia St"
replace stname_flag="W Magnolia Ave" if clean_priority==4 & street_precleanedhn=="Magnolia St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Magnolia St"

*W Mistletoe in Ancestry; SM has W Mistletoe Ave
browse if clean_priority==4 & image_id=="4548184_00579"
replace hn_edit=1111 if clean_priority==4 & image_id=="4548184_00579" & hn==111
replace st_edit="W Mistletoe" if clean_priority==4 & image_id=="4548184_00579"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & image_id=="4548184_00579"
replace stname_flag="W Mistletoe Ave" if clean_priority==4 & image_id=="4548184_00579"
replace checked_hn="c" if clean_priority==4 & image_id=="4548184_00579"

*Could be Magnolia Dr, which matches SM
browse if clean_priority==4 & image_id=="4548184_00587"
replace st_edit="Magnolia Drive" if clean_priority==4 & image_id=="4548184_00587"
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4548184_00587"
replace checked_hn="c" if clean_priority==4 & image_id=="4548184_00587"

*E Russell Pl in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Russel Pl"
replace st_edit="E Russell Pl" if clean_priority==4 & street_precleanedhn=="Russel Pl"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Russel Pl"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Russel Pl"

*Laurel Heights Pl in Ancestry; SM has Laurel Hts St
browse if clean_priority==4 & street_precleanedhn=="Lawel Heights Pl"
replace st_edit="Laurel Heights Pl" if clean_priority==4 & street_precleanedhn=="Lawel Heights Pl"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Lawel Heights Pl"
replace stname_flag="Laurel Hts St" if clean_priority==4 & street_precleanedhn=="Lawel Heights Pl" 
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Lawel Heights Pl"

*No hns for Brackenridge Park, which is near Jones Ave
browse if clean_priority==4 & street_precleanedhn=="Brackenridge Park Near Jones Ave"
*Removed hn_edit values
replace hn_flag="none" if clean_priority==4 & street_precleanedhn=="Brackenridge Park Near Jones Ave"
replace st_edit="Brackenridge Park" if clean_priority==4 & street_precleanedhn=="Brackenridge Park Near Jones Ave"
replace stname_flag="Near Jones Ave" if clean_priority==4 & street_precleanedhn=="Brackenridge Park Near Jones Ave"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Brackenridge Park Near Jones Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Brackenridge Park Near Jones Ave"

*Matches SM; hns good
browse if clean_priority==4 & overall_match=="Alvin St"
replace hn_edit=226 if clean_priority==4 & overall_match=="Alvin St" & line_num>70
replace st_edit="Pastores Ave" if clean_priority==4 & overall_match=="Alvin St" & line_num>70
replace checked_st="c" if clean_priority==4 & overall_match=="Alvin St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Alvin St"

*Could be Ancona; SM has Ancona Ave
browse if clean_priority==4 & street_precleanedhn=="Ansonia"
replace st_edit="Ancona" if clean_priority==4 & street_precleanedhn=="Ansonia"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Ansonia"
replace stname_flag="Ancona Ave" if clean_priority==4 & street_precleanedhn=="Ansonia"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Ansonia"

*E Huisache in Ancestry; SM has E Huisache Ave
browse if clean_priority==4 & street_precleanedhn=="block 2114 e huisache"
replace st_edit="E Huisache" if clean_priority==4 & street_precleanedhn=="block 2114 e huisache"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="block 2114 e huisache"
replace stname_flag="E Huisache Ave" if clean_priority==4 & street_precleanedhn=="block 2114 e huisache"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="block 2114 e huisache"

*Hotel on E Houston St
browse if clean_priority==4 & overall_match=="E Houston St"
replace hn_edit=205 if clean_priority==4 & overall_match=="E Houston St"
replace inst=1 if clean_priority==4 & overall_match=="E Houston St"
replace institution_edit="Hotel" if clean_priority==4 & overall_match=="E Houston St"
replace checked_st="c" if clean_priority==4 & overall_match=="E Houston St"
replace checked_hn="c" if clean_priority==4 & overall_match=="E Houston St"

*Matches SM
browse if clean_priority==4 & image_id=="4548184_00785"
replace st_edit="E Pecan St" if clean_priority==4 & image_id=="4548184_00785"
replace hn_edit=225 if clean_priority==4 & image_id=="4548184_00785"
replace checked_st="c" if clean_priority==4 & image_id=="4548184_00785"
replace checked_hn="c" if clean_priority==4 & image_id=="4548184_00785"

*Multipe streets. Not very clear
browse if clean_priority==4 & street_precleanedhn=="Y Raca"
*Manually changed hn_edit and st_edit values
replace stname_flag="YMCA" if clean_priority==4 & street_precleanedhn=="Y Raca" & hn_edit==2640
replace stname_flag="Blue Bonnet Hotel" if clean_priority==4 & street_precleanedhn=="Y Raca" & hn_edit==2662
replace stname_flag="Martin St" if clean_priority==4 & street_precleanedhn=="Y Raca" & hn_edit==230
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Y Raca" & st_edit!=""
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Y Raca" & st_edit==""
replace checked_hn="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Y Raca" & line_num<39
replace checked_hn="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Y Raca" & line_num==49

*4/26
*Menger Hotel on 409 N Alamo in Ancestry
browse if clean_priority==4 & street_precleanedhn=="Menger Hotel North Alamo"
replace st_edit="N Alamo" if clean_priority==4 & street_precleanedhn=="Menger Hotel North Alamo"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Menger Hotel North Alamo"
replace stname_flag="N Alamo St" if clean_priority==4 & street_precleanedhn=="Menger Hotel North Alamo"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Menger Hotel North Alamo"
replace inst=1 if clean_priority==4 & street_precleanedhn=="Menger Hotel North Alamo"
replace institution_edit="Menger Hotel" if clean_priority==4 & street_precleanedhn=="Menger Hotel North Alamo"

*E Crockett in Ancestry; SM has Crockett St
browse if clean_priority==4 & street_precleanedhn=="E Crochett"
replace st_edit="E Crockett" if clean_priority==4 & street_precleanedhn=="E Crochett"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="E Crochett"
replace stname_flag="Crockett St" if clean_priority==4 & street_precleanedhn=="E Crochett"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="E Crochett"

*Center St in Ancestry; SM has N Centre St
browse if clean_priority==4 & street_precleanedhn=="Center St"
replace hn_flag="109 rear" if clean_priority==4 & street_precleanedhn=="Center St" & hn==109 & line_num<74
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Center St"
replace stname_flag="N Centre St" if clean_priority==4 & street_precleanedhn=="Center St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Center St"

*N Alamo in Ancestry; SM has N Alamo St
browse if clean_priority==4 & overall_match=="6th Aly"
replace st_edit="N Alamo" if clean_priority==4 & overall_match=="6th Aly"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & overall_match=="6th Aly"
replace stname_flag="N Alamo St" if clean_priority==4 & overall_match=="6th Aly"
replace checked_hn="c" if clean_priority==4 & overall_match=="6th Aly"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="6th St"
replace hn_edit=415 if clean_priority==4 & overall_match=="6th St"
replace checked_st="c" if clean_priority==4 & overall_match=="6th St"
replace checked_hn="c" if clean_priority==4 & overall_match=="6th St"

*Matches SM; fixed hns
browse if clean_priority==4 & overall_match=="B Ave"
replace hn_edit=918 if clean_priority==4 & overall_match=="B Ave"
replace checked_st="c" if clean_priority==4 & overall_match=="B Ave"
replace checked_hn="c" if clean_priority==4 & overall_match=="B Ave"

*Matches SM; hns correct
browse if clean_priority==4 & overall_match=="10th St"
replace checked_st="c" if clean_priority==4 & overall_match=="10th St"
replace checked_hn="c" if clean_priority==4 & overall_match=="10th St"

*Av A in Ancestry; SM has A Ave
browse if clean_priority==4 & street_precleanedhn=="Av A"
replace st_edit="A Ave" if clean_priority==4 & street_precleanedhn=="Av A"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Av A"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Av A"

*Thirteenth St in Ancestry; SM has 13th St
browse if clean_priority==4 & street_precleanedhn=="Therteenth St"
replace st_edit="13th St" if clean_priority==4 & street_precleanedhn=="Therteenth St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Therteenth St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Therteenth St"

*Twelfth St in Ancestry; SM has 12th St
browse if clean_priority==4 & street_precleanedhn=="Tevelfth St"
replace st_edit="12th St" if clean_priority==4 & street_precleanedhn=="Tevelfth St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Tevelfth St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Tevelfth St"

*Broadway in Ancestry; SM has Broadway St
browse if clean_priority==4 & street_precleanedhn=="Broad Way"
replace st_edit="Broadway" if clean_priority==4 & street_precleanedhn=="Broad Way"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Broad Way"
replace stname_flag="Broadway St" if clean_priority==4 & street_precleanedhn=="Broad Way"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Broad Way"

*Natalen Ave in Ancestry; SM has Natalen St
browse if clean_priority==4 & street_precleanedhn=="Nataley Ave"
replace st_edit="Natalen Ave" if clean_priority==4 & street_precleanedhn=="Nataley Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Nataley Ave"
replace stname_flag="Natalen St" if clean_priority==4 & street_precleanedhn=="Nataley Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Nataley Ave"

*Looks like Ira in Ancestry; SM has Ira Ave
browse if clean_priority==4 & street_precleanedhn=="Ira"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Ira"
replace stname_flag="Ira Ave" if clean_priority==4 & street_precleanedhn=="Ira"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Ira"

*Seems to say Tourist Camp in Ancestry. No hns
browse if clean_priority==4 & street_precleanedhn=="Taunist Camp"
replace st_edit="Tourist Camp" if clean_priority==4 & street_precleanedhn=="Taunist Camp"
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Taunist Camp"
*Removed hn_edit values
replace hn_flag="No numbers" if clean_priority==4 & street_precleanedhn=="Taunist Camp"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Taunist Camp"

*Matches SM
browse if clean_priority==4 & overall_match=="Post Ave"
replace checked_st="c" if clean_priority==4 & overall_match=="Post Ave"
replace checked_hn="c" if clean_priority==4 & overall_match=="Post Ave"

*Grayson St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Grayson"
replace st_edit="Grayson St" if clean_priority==4 & street_precleanedhn=="Grayson"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Grayson"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Grayson"

*E Josephine St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="E Joseph"
replace st_edit="E Josephine St" if clean_priority==4 & street_precleanedhn=="E Joseph"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="E Joseph"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="E Joseph"

*Karnes on Ancestry; SM has Karnes St. No hns
browse if clean_priority==4 & overall_match=="Karnes St"
*Manually removed hn_edit values
replace hn_flag="No numbers" if clean_priority==4 & overall_match=="Karnes St"
replace checked_st="c" if clean_priority==4 & overall_match=="Karnes St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Karnes St"

*4/27
*Looks like it could be Bowen Aly; SM has Bowen Pl
browse if clean_priority==4 & street_precleanedhn=="Boway Aly"
replace st_edit="Bowen Aly" if clean_priority==4 & street_precleanedhn=="Boway Aly"
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Boway Aly"
replace stname_flag="Bowen Pl" if clean_priority==4 & street_precleanedhn=="Boway Aly"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Boway Aly"

*Looks like Bowels Ave in Ancestry; missing in SM
browse if clean_priority==4 & street_precleanedhn=="Bowels Ave"
replace checked_st="c, ancestry match, SM missing" if clean_priority==4 & street_precleanedhn=="Bowels Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Bowels Ave"

*Mackensen Aly in Ancestry; SM has Mackensen St
browse if clean_priority==4 & street_precleanedhn=="Mackenson Aly"
replace st_edit="Mackensen Aly" if clean_priority==4 & street_precleanedhn=="Mackenson Aly"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Mackenson Aly"
replace stname_flag="Mackensen St" if clean_priority==4 & street_precleanedhn=="Mackenson Aly"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Mackenson Aly"

*Booker Aly in Ancestry; matches SM. Also says something else unclear
browse if clean_priority==4 & street_precleanedhn=="Piteger Dawson Booker Aly"
replace st_edit="Booker Aly" if clean_priority==4 & street_precleanedhn=="Piteger Dawson Booker Aly"
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Piteger Dawson Booker Aly"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Piteger Dawson Booker Aly"

*Menard Aly matches SM; can't tell what other words are
browse if clean_priority==4 & street_precleanedhn=="Menard Place Armstrong Alley Rua"
replace st_edit="Menard Aly" if clean_priority==4 & street_precleanedhn=="Menard Place Armstrong Alley Rua"
replace st_edit="N Mesquite St" if clean_priority==4 & street_precleanedhn=="Menard Place Armstrong Alley Rua" & hn==222
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Menard Place Armstrong Alley Rua"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Menard Place Armstrong Alley Rua" & hn==222
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Menard Place Armstrong Alley Rua"

*N Center St in Ancestry; SM has N Centre St
browse if clean_priority==4 & street_precleanedhn=="M Center St"
replace st_edit="N Center St" if clean_priority==4 & street_precleanedhn=="M Center St"
replace stname_flag="N Centre St" if clean_priority==4 & street_precleanedhn=="M Center St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="M Center St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="M Center St"

*Hard to read. Could be Crockett St rear of N Mesquite St
browse if clean_priority==4 & street_precleanedhn=="Blat ??Crockett Rear Of North Me"
replace st_edit="Crockett St" if clean_priority==4 & street_precleanedhn=="Blat ??Crockett Rear Of North Me"
replace stname_flag="Rear of N Mesquite St" if clean_priority==4 & street_precleanedhn=="Blat ??Crockett Rear Of North Me"
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Blat ??Crockett Rear Of North Me"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Blat ??Crockett Rear Of North Me"

*Monumental St in Ancestry; SM has N Monumental St
browse if clean_priority==4 & street_precleanedhn=="Moumental St"
replace st_edit="Monumental St" if clean_priority==4 & street_precleanedhn=="Moumental St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Moumental St"
replace stname_flag="N Monumental St" if clean_priority==4 & street_precleanedhn=="Moumental St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Moumental St"

*Seems like N Hackberry St; matches SM
browse if clean_priority==4 & image_id=="4548185_00182"
replace st_edit="N Hackberry St" if clean_priority==4 & image_id=="4548185_00182"
replace checked_st="c" if clean_priority==4 & image_id=="4548185_00182"
replace checked_hn="c" if clean_priority==4 & image_id=="4548185_00182"

browse if clean_priority==4 & image_id=="4548185_00183"
replace st_edit="N Hackberry St" if clean_priority==4 & image_id=="4548185_00183"
replace checked_st="c" if clean_priority==4 & image_id=="4548185_00183"
replace checked_hn="c" if clean_priority==4 & image_id=="4548185_00183"

*Looks like Nika St which matches SM
browse if clean_priority==4 & street_precleanedhn=="Mila St"
replace st_edit="Nika St" if clean_priority==4 & street_precleanedhn=="Mila St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Mila St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Mila St"

*Most lines crossed out
browse if clean_priority==4 & street_precleanedhn=="N Alans"
replace stname_flag="POSSIBLE DELETE" if clean_priority==4 & street_precleanedhn=="N Alans" & hn>1000
replace st_edit="Grayson St" if clean_priority==4 & street_precleanedhn=="N Alans" & hn<1000
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="N Alans" & hn>1000
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="N Alans" & hn<1000
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="N Alans"

*Crossed out in Ancestry
browse if clean_priority==4 & street_precleanedhn=="N ??"
replace stname_flag="POSSIBLE DELETE" if clean_priority==4 & street_precleanedhn=="N ??"
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="N ??"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="N ??"

*Broadway in Ancestry; SM has Broadway St
browse if clean_priority==4 & street_precleanedhn=="Brandway"
replace st_edit="Broadway" if clean_priority==4 & street_precleanedhn=="Brandway"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Brandway"
replace stname_flag="Broadway St" if clean_priority==4 & street_precleanedhn=="Brandway"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Brandway"

*Looks like Pershing Ave in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Persberry Ave"
replace st_edit="Pershing Ave" if clean_priority==4 & street_precleanedhn=="Persberry Ave"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Persberry Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Persberry Ave"

*Austin Road in Ancestry but Austin St in SM
browse if clean_priority==4 & street_precleanedhn=="Austin Road"
*Manually removed hn_edit 203
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Austin Road"
replace stname_flag="Austin St" if clean_priority==4 & street_precleanedhn=="Austin Road"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Austin Road" & hn!=203
replace checked_hn="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Austin Road" & hn==203

*Can't read stname
browse if clean_priority==4 & st_edit=="Dincan Ave Now D Ave"
replace checked_st="c, ambiguous" if clean_priority==4 & st_edit=="Dincan Ave Now D Ave"
replace checked_hn="c" if clean_priority==4 & st_edit=="Dincan Ave Now D Ave"

*Looks like Ash St; matches SM
browse if clean_priority==4 & street_precleanedhn=="And St"
replace st_edit="Ash St" if clean_priority==4 & street_precleanedhn=="And St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="And St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="And St"

*Matches SM
browse if clean_priority==4 & overall_match=="Reno St"
replace checked_st="c" if clean_priority==4 & overall_match=="Reno St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Reno St"

*Can't find street name
browse if clean_priority==4 & image_id=="4548185_00497"
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4548185_00497"
replace checked_hn="c" if clean_priority==4 & image_id=="4548185_00497"

browse if clean_priority==4 & image_id=="4548185_00507"
replace checked_st="c, ambiguous" if clean_priority==4 & image_id=="4548185_00507"
replace checked_hn="c" if clean_priority==4 & image_id=="4548185_00507"

*Bee St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Bel St"
replace st_edit="Bee St" if clean_priority==4 & street_precleanedhn=="Bel St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Bel St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Bel St"

*Van Ness St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Wan Nood St"
replace st_edit="Van Ness St" if clean_priority==4 & street_precleanedhn=="Wan Nood St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Wan Nood St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Wan Nood St"

*SR Railroad in Ancestry; SM has similar Railroad Tracks St
browse if clean_priority==4 & street_precleanedhn=="S R Railroad"
replace checked_st="c, ancestry match, SM missing" if clean_priority==4 & street_precleanedhn=="S R Railroad"
replace stname_flag="Railroad Tracks St" if clean_priority==4 & street_precleanedhn=="S R Railroad"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S R Railroad"

*Looks like New Braunfels in Ancestry; SM has N New Braunfels
browse if clean_priority==4 & street_precleanedhn=="Bew Braunfels"
replace st_edit="New Braunfels" if clean_priority==4 & street_precleanedhn=="Bew Braunfels"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Bew Braunfels"
replace stname_flag="N New Braunfels" if clean_priority==4 & street_precleanedhn=="Bew Braunfels"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Bew Braunfels"

*Rogers in Ancestry; SM has Rogers Ave
browse if clean_priority==4 & street_precleanedhn=="Roagers"
replace st_edit="Rogers" if clean_priority==4 & street_precleanedhn=="Roagers"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Roagers"
replace stname_flag="Rogers Ave" if clean_priority==4 & street_precleanedhn=="Roagers"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Roagers"

*Van Ness St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="rear 915"
replace st_edit="Van Ness St" if clean_priority==4 & street_precleanedhn=="rear 915"
replace hn_flag="922 rear" if clean_priority==4 & street_precleanedhn=="rear 915" & line_num>26 & line_num<29
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="rear 915"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="rear 915"

*Matches SM
browse if clean_priority==4 & overall_match=="Duval St"
replace checked_st="c" if clean_priority==4 & overall_match=="Duval St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Duval St"

*Pierce St in Ancestry; SM has Pierce Ave
browse if clean_priority==4 & street_precleanedhn=="Pierce St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Pierce St"
replace stname_flag="Pierce Ave" if clean_priority==4 & street_precleanedhn=="Pierce St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Pierce St"

*5/1
*Palmetto St in Ancestry; SM has N Palmetto Ave
browse if clean_priority==4 & street_precleanedhn=="Palmetts St"
replace st_edit="Palmetto St" if clean_priority==4 & street_precleanedhn=="Palmetts St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Palmetts St"
replace stname_flag="N Palmetto Ave" if clean_priority==4 & street_precleanedhn=="Palmetts St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Palmetts St"

*Pierce St in Ancestry; SM has Pierce Ave
browse if clean_priority==4 & street_precleanedhn=="Peerce"
replace st_edit="Pierce St" if clean_priority==4 & street_precleanedhn=="Peerce"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Peerce"
replace stname_flag="Pierce Ave" if clean_priority==4 & street_precleanedhn=="Peerce"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Peerce"

*Palmetto St in Ancestry; SM has N Palmetto Ave
browse if clean_priority==4 & street_precleanedhn=="Palmett St"
replace st_edit="Palmetto St" if clean_priority==4 & street_precleanedhn=="Palmett St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Palmett St"
replace stname_flag="N Palmetto Ave" if clean_priority==4 & street_precleanedhn=="Palmett St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Palmett St"

*St James in Ancestry; SM has St James St in diff ED
browse if clean_priority==4 & street_precleanedhn=="Saint James"
replace hn_edit=1022 if clean_priority==4 & street_precleanedhn=="Saint James" & hn==1023
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==4 & street_precleanedhn=="Saint James"
replace stname_flag="St James St" if clean_priority==4 & street_precleanedhn=="Saint James"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Saint James"

*Rodgers St in Ancestry; SM has Rogers Ave
browse if clean_priority==4 & street_precleanedhn=="Rodgers St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Rodgers St"
replace stname_flag="Rogers Ave" if clean_priority==4 & street_precleanedhn=="Rodgers St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Rodgers St"

*Hard to read stname in Ancestry
browse if clean_priority==4 & street_precleanedhn=="Buchers St"
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="Buchers St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Buchers St"

*Looks like it could be N Braunfels. SM has N New Braunfels Ave
browse if clean_priority==4 & street_precleanedhn=="N Bunfeld"
replace st_edit="N Braunfels" if clean_priority==4 & street_precleanedhn=="N Bunfeld"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="N Bunfeld"
replace stname_flag="N New Braunfels Ave" if clean_priority==4 & street_precleanedhn=="N Bunfeld"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="N Bunfeld"

*Hayes St in Ancestry but Hays St in SM
browse if clean_priority==4 & street_precleanedhn=="Hayes St"
replace checked_st="c, ancestry match, SM missing" if clean_priority==4 & street_precleanedhn=="Hayes St"
replace stname_flag="Hays St" if clean_priority==4 & street_precleanedhn=="Hayes St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Hayes St"

*N Center St in Ancestry; SM has N Centre St
browse if clean_priority==4 & street_precleanedhn=="N Center St"
replace hn_edit=1802 if clean_priority==4 & street_precleanedhn=="N Center St" & hn_raw=="180?"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="N Center St"
replace stname_flag="N Centre St" if clean_priority==4 & street_precleanedhn=="N Center St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="N Center St"

*Looks like Mittman St in Ancestry; matches SM 
browse if clean_priority==4 & street_precleanedhn=="N Mathman St"
replace st_edit="Mittman St" if clean_priority==4 & street_precleanedhn=="N Mathman St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="N Mathman St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="N Mathman St"

*Looks like N Monumental Ave in Ancestry; SM has N Monumental St
browse if clean_priority==4 & overall_match=="Bonnett Ave"
replace st_edit="N Monumental Ave" if clean_priority==4 & overall_match=="Bonnett Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & overall_match=="Bonnett Ave"
replace stname_flag="N Monumental St" if clean_priority==4 & overall_match=="Bonnett Ave"
replace checked_hn="c" if clean_priority==4 & overall_match=="Bonnett Ave"

*Looks like Indianola St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Indian St"
replace st_edit="Indianola St" if clean_priority==4 & street_precleanedhn=="Indian St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Indian St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Indian St"

*Looks like Water St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Waters St"
replace st_edit="Water St" if clean_priority==4 & street_precleanedhn=="Waters St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Waters St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Waters St"

*Could be Mt Zion Aly. SM has Mt Zion St in nearby ED
browse if clean_priority==4 & street_precleanedhn=="Mtzior Allen"
replace st_edit="Mt Zion Aly" if clean_priority==4 & street_precleanedhn=="Mtzior Allen"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==4 & street_precleanedhn=="Mtzior Allen"
replace stname_flag="Mt Zion St" if clean_priority==4 & street_precleanedhn=="Mtzior Allen"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Mtzior Allen"

*Victoria in Ancestry; SM has Victoria St
browse if clean_priority==4 & street_precleanedhn=="Victora"
replace st_edit="Victoria" if clean_priority==4 & street_precleanedhn=="Victora"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Victora"
replace stname_flag="Victoria St" if clean_priority==4 & street_precleanedhn=="Victora"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Victora"

*Matches SM
browse if clean_priority==4 & overall_match=="Florida St"
replace hn_edit=145 if clean_priority==4 & overall_match=="Florida St" & hn==901
replace checked_st="c" if clean_priority==4 & overall_match=="Florida St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Florida St"
replace checked_hn="c, ambiguous" if clean_priority==4 & overall_match=="Florida St" & ed==142

*5/2
*Matches SM
browse if clean_priority==4 & overall_match=="Wells St"
replace checked_st="c" if clean_priority==4 & overall_match=="Wells St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Wells St"

*Montana St and Schuback Aly match SM
browse if clean_priority==4 & image_id=="4548186_00333"
replace st_edit="Montana St" if clean_priority==4 & image_id=="4548186_00333"
replace st_edit="Schuback Aly" if clean_priority==4 & image_id=="4548186_00333" & line_num>11
replace checked_st="c" if clean_priority==4 & image_id=="4548186_00333"
replace checked_hn="c" if clean_priority==4 & image_id=="4548186_00333"

*Looks like it could be Piedmont Ave in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Tridmond Ave"
replace st_edit="Piedmont Ave" if clean_priority==4 & street_precleanedhn=="Tridmond Ave"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Tridmond Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Tridmond Ave"

*S Palmetto St in Ancestry; SM has S Palmetto Ave
browse if clean_priority==4 & street_precleanedhn=="S Pametlo St"
replace st_edit="S Palmetto St" if clean_priority==4 & street_precleanedhn=="S Pametlo St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="S Pametlo St"
replace stname_flag="S Palmetto Ave" if clean_priority==4 & street_precleanedhn=="S Pametlo St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Pametlo St"

*Matches SM, apartment
browse if clean_priority==4 & overall_match=="E Commerce St"
replace hn_edit=1702 if clean_priority==4 & overall_match=="E Commerce St"
replace hn_flag="1702 1/2 apt 1" if clean_priority==4 & overall_match=="E Commerce St" & line_num<50
replace hn_flag="1702 1/2 apt 3" if clean_priority==4 & overall_match=="E Commerce St" & line_num>49
replace checked_st="c" if clean_priority==4 & overall_match=="E Commerce St"
replace checked_hn="c, multi-unit" if clean_priority==4 & overall_match=="E Commerce St"

*S Polaris in Ancestry; SM has Polaris St
browse if clean_priority==4 & street_precleanedhn=="S Polaris"
replace st_edit="Wyoming St" if clean_priority==4 & street_precleanedhn=="S Polaris" & hn>2000
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="S Polaris"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="S Polaris" & hn>2000
replace stname_flag="Polaris St" if clean_priority==4 & street_precleanedhn=="S Polaris" & hn<2000
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Polaris"

*Not very legible but could be S Gevers, matches SM
browse if clean_priority==4 & street_precleanedhn=="S Graves"
replace st_edit="S Gevers St" if clean_priority==4 & street_precleanedhn=="S Graves"
replace checked_st="c, ambiguous" if clean_priority==4 & street_precleanedhn=="S Graves"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Graves"

*Matches SM
browse if clean_priority==4 & overall_match=="Louisiana St"
replace checked_st="c" if clean_priority==4 & overall_match=="Louisiana St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Louisiana St"

*Looks like Dreiss St, which matches SM
browse if clean_priority==4 & street_precleanedhn=="Driers St"
replace st_edit="Dreiss St" if clean_priority==4 & street_precleanedhn=="Driers St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Driers St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Driers St"

*Applin St in Ancestry; Applin Ave in SM
browse if clean_priority==4 & street_precleanedhn=="Applin St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Applin St"
replace stname_flag="Applin Ave" if clean_priority==4 & street_precleanedhn=="Applin St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Applin St"

*Walters St in Ancestry; SM has S Walters St
browse if clean_priority==4 & street_precleanedhn=="Walter St"
replace st_edit="Walters St" if clean_priority==4 & street_precleanedhn=="Walter St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Walter St"
replace stname_flag="S Walters St" if clean_priority==4 & street_precleanedhn=="Walter St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Walter St"

*Matches SM
browse if clean_priority==4 & overall_match=="Welhausen St"
replace checked_st="c" if clean_priority==4 & overall_match=="Welhausen St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Welhausen St"

*Clark Ave in Ancestry; Clarke St in SM
browse if clean_priority==4 & street_precleanedhn=="Clark Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Clark Ave"
replace stname_flag="Clarke St" if clean_priority==4 & street_precleanedhn=="Clark Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Clark Ave"

*Yorkshire in Ancestry; SM has Yorkshire Pl
browse if clean_priority==4 & street_precleanedhn=="Yark Shire"
replace st_edit="Yorkshire" if clean_priority==4 & street_precleanedhn=="Yark Shire"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Yark Shire"
replace stname_flag="Yorkshire Pl" if clean_priority==4 & street_precleanedhn=="Yark Shire"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Yark Shire"

*Berkshire in Ancestry; SM has Berkshire Ave
browse if clean_priority==4 & image_id=="4548186_01017"
replace st_edit="Berkshire" if clean_priority==4 & image_id=="4548186_01017"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & image_id=="4548186_01017"
replace stname_flag="Berkshire Ave" if clean_priority==4 & image_id=="4548186_01017"
replace checked_hn="c" if clean_priority==4 & image_id=="4548186_01017"

*Multiple streets. Can only read two of them
browse if clean_priority==4 & overall_match=="Aberdeen Pl"
*Manually changed hn_edits
replace st_edit="Berkshire Ave" if clean_priority==4 & overall_match=="Aberdeen Pl" & line_num>4
replace st_edit="" if clean_priority==4 & overall_match=="Aberdeen Pl" & line_num>6
replace checked_st="c" if clean_priority==4 & overall_match=="Aberdeen Pl" & line_num<7
replace checked_st="c, ambiguous" if clean_priority==4 & overall_match=="Aberdeen Pl" & line_num>6
replace checked_hn="c" if clean_priority==4 & overall_match=="Aberdeen Pl"

*Matches SM
browse if clean_priority==4 & street_precleanedhn=="Highland"
replace st_edit="Highland Blvd" if clean_priority==4 & street_precleanedhn=="Highland"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Highland"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Highland"

*Warwick Ave in Ancestrry; SM has Warwick Blvd
browse if clean_priority==4 & street_precleanedhn=="Warwich Ave"
replace st_edit="Warwick Ave" if clean_priority==4 & street_precleanedhn=="Warwich Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Warwich Ave"
replace stname_flag="Warwick Blvd" if clean_priority==4 & street_precleanedhn=="Warwich Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Warwich Ave"

*Avant St in Ancestry; Avant Ave in SM
browse if clean_priority==4 & street_precleanedhn=="Avant St"
replace st_edit="S Olive St" if clean_priority==4 & street_precleanedhn=="Avant St" & hn>2000
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Avant St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Avant St"
replace stname_flag="Avant Ave" if clean_priority==4 & street_precleanedhn=="Avant St" & hn<2000
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Avant St"

*Matches SM
browse if clean_priority==4 & overall_match=="S Cherry St"
replace checked_st="c" if clean_priority==4 & overall_match=="S Cherry St"
replace checked_hn="c" if clean_priority==4 & overall_match=="S Cherry St"

*Fairview Ave in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Ave Fairview"
replace st_edit="Fairview Ave" if clean_priority==4 & street_precleanedhn=="Ave Fairview"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Ave Fairview"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Ave Fairview"

*Matches SM; no house numbers
browse if clean_priority==4 & overall_match=="S New Braunfels Ave"
*removed hn_edit values
replace hn_flag="none" if clean_priority==4 & overall_match=="S New Braunfels Ave"
replace hn_flag="rear above" if clean_priority==4 & overall_match=="S New Braunfels Ave" & line_num>7
replace checked_st="c" if clean_priority==4 & overall_match=="S New Braunfels Ave"
replace checked_hn="c" if clean_priority==4 & overall_match=="S New Braunfels Ave"

*Looks like Water St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Watin St"
replace st_edit="Water St" if clean_priority==4 & street_precleanedhn=="Watin St"
replace hn_edit=119 if clean_priority==4 & street_precleanedhn=="Watin St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Watin St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Watin St"

*Looks like Nueva St; SM has E Nueva St
browse if clean_priority==4 & street_precleanedhn=="Norera St"
replace st_edit="Nueva St" if clean_priority==4 & street_precleanedhn=="Norera St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Norera St"
replace stname_flag="E Nueva St" if clean_priority==4 & street_precleanedhn=="Norera St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Norera St"

*Matches SM
browse if clean_priority==4 & overall_match=="Martinez St"
replace checked_st="c" if clean_priority==4 & overall_match=="Martinez St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Martinez St"

*Matches SM
browse if clean_priority==4 & overall_match=="Turner St"
replace checked_st="c" if clean_priority==4 & overall_match=="Turner St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Turner St"

*S Alamo in Ancestry; SM has S Alamo St
browse if clean_priority==4 & street_precleanedhn=="Saint Olamo"
replace st_edit="S Alamo" if clean_priority==4 & street_precleanedhn=="Saint Olamo"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Saint Olamo"
replace stname_flag="S Alamo St" if clean_priority==4 & street_precleanedhn=="Saint Olamo"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Saint Olamo"

*5/4
*Hard to read but looks like Forcke St which matches SM
browse if clean_priority==4 & overall_match=="Forcke St"
replace checked_st="c" if clean_priority==4 & overall_match=="Forcke St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Forcke St"

*St Marys St in Ancestry; SM has S St Marys St
browse if clean_priority==4 & street_precleanedhn=="Marys St"
replace hn_edit=1311 if clean_priority==4 & street_precleanedhn=="Marys St" & hn==311
replace st_edit="S St Marys St" if clean_priority==4 & street_precleanedhn=="Marys St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Marys St"
replace stname_flag="" if clean_priority==4 & street_precleanedhn=="Marys St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Marys St"

*S St Marys in Ancestry; SM has S St Marys St
browse if clean_priority==4 & street_precleanedhn=="S Saint Marys"
replace st_edit="S St Marys St" if clean_priority==4 & street_precleanedhn=="S Saint Marys"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="S Saint Marys"
replace stname_flag="" if clean_priority==4 & street_precleanedhn=="S Saint Marys"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Saint Marys"

*Looks like Adams St which matches SM
browse if clean_priority==4 & street_precleanedhn=="Alama St"
replace st_edit="Adams St" if clean_priority==4 & street_precleanedhn=="Alama St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Alama St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Alama St"

*Looks like Biering St in Ancestry; SM has Beiring Ave
browse if clean_priority==4 & street_precleanedhn=="Bioring St"
replace st_edit="Biering St" if clean_priority==4 & street_precleanedhn=="Bioring St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Bioring St"
replace stname_flag="Biering Ave" if clean_priority==4 & street_precleanedhn=="Bioring St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Bioring St"

*Lowell Ave in Ancestry; Lowell St in SM
browse if clean_priority==4 & street_precleanedhn=="Lowell Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Lowell Ave"
replace stname_flag="Lowell St" if clean_priority==4 & street_precleanedhn=="Lowell Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Lowell Ave"

*Matches SM
browse if clean_priority==4 & overall_match=="Bryant St"
replace checked_st="c" if clean_priority==4 & overall_match=="Bryant St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Bryant St"

*Castillo Ave in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Castillo St"
replace st_edit="Castillo Ave" if clean_priority==4 & street_precleanedhn=="Castillo St"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Castillo St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Castillo St"

*Fairplay Ave in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="??De??Lay Ave"
replace st_edit="Fairplay Ave" if clean_priority==4 & street_precleanedhn=="??De??Lay Ave"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="??De??Lay Ave"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="??De??Lay Ave"

*Looks like Alamosa St in Ancestry; SM has Alamosa Ave
browse if clean_priority==4 & street_precleanedhn=="Alamaca St"
replace st_edit="Alamosa St" if clean_priority==4 & street_precleanedhn=="Alamaca St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Alamaca St"
replace stname_flag="Alamosa Ave" if clean_priority==4 & street_precleanedhn=="Alamaca St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Alamaca St"

*Looks like S Presa St in Ancestry; SM has Presa St
browse if clean_priority==4 & street_precleanedhn=="S Aresa St"
replace st_edit="S Presa St" if clean_priority==4 & street_precleanedhn=="S Aresa St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="S Aresa St"
replace stname_flag="Presa St" if clean_priority==4 & street_precleanedhn=="S Aresa St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="S Aresa St"

*Looks like Tremlett St in Ancestry; SM has Tremlett Ave
browse if clean_priority==4 & street_precleanedhn=="Tumlett"
replace st_edit="Tremlett St" if clean_priority==4 & street_precleanedhn=="Tumlett"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Tumlett"
replace stname_flag="Tremlett Ave" if clean_priority==4 & street_precleanedhn=="Tumlett"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Tumlett"

*Parker St in Ancestry; SM has Parker Ave
browse if clean_priority==4 & street_precleanedhn=="Racker"
replace st_edit="Parker St" if clean_priority==4 & street_precleanedhn=="Racker"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Racker"
replace stname_flag="Parker Ave" if clean_priority==4 & street_precleanedhn=="Racker"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Racker"

*McMullen St in Ancestry; matches SM
browse if clean_priority==4 & street_precleanedhn=="Mcfankin"
replace st_edit="McMullen St" if clean_priority==4 & street_precleanedhn=="Mcfankin"
replace checked_st="c" if clean_priority==4 & street_precleanedhn=="Mcfankin"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Mcfankin"

*S Presa St in Ancestry; SM Presa St
browse if clean_priority==4 & street_precleanedhn=="Senth Pusa"
replace st_edit="S Presa St" if clean_priority==4 & street_precleanedhn=="Senth Pusa"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==4 & street_precleanedhn=="Senth Pusa"
replace stname_flag="Presa St" if clean_priority==4 & street_precleanedhn=="Senth Pusa"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Senth Pusa"

*Looks like Naylor in Ancestry; SM has Naylor St
browse if clean_priority==4 & street_precleanedhn=="Wayler"
replace st_edit="Naylor" if clean_priority==4 & street_precleanedhn=="Wayler"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Wayler"
replace stname_flag="Naylor St" if clean_priority==4 & street_precleanedhn=="Wayler"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Wayler"

*Looks like Eads St in Ancestry; SM has Eads Ave
browse if clean_priority==4 & street_precleanedhn=="Eado St"
replace st_edit="Eads St" if clean_priority==4 & street_precleanedhn=="Eado St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Eado St"
replace stname_flag="Eads Ave" if clean_priority==4 & street_precleanedhn=="Eado St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Eado St"

*Looks like Whiting St in Ancestry; SM has Whiting Ave
browse if clean_priority==4 & street_precleanedhn=="Witing St"
replace st_edit="Whiting St" if clean_priority==4 & street_precleanedhn=="Witing St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==4 & street_precleanedhn=="Witing St"
replace stname_flag="Whiting Ave" if clean_priority==4 & street_precleanedhn=="Witing St"
replace checked_hn="c" if clean_priority==4 & street_precleanedhn=="Witing St"

*Matches Sm; fixed hn
browse if clean_priority==4 & overall_match=="Caldwell St"
replace hn_edit=123 if clean_priority==4 & overall_match=="Caldwell St"
replace checked_st="c" if clean_priority==4 & overall_match=="Caldwell St"
replace checked_hn="c" if clean_priority==4 & overall_match=="Caldwell St"

*Priority 4 done


*9/18
*Starting Priority 5

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Dwyer Ave"
replace checked_st="c" if clean_priority==5 & overall_match=="Dwyer Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Dwyer Ave"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Galan St"
replace checked_st="c" if clean_priority==5 & overall_match=="Galan St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Galan St"

*Looks like S Laredo St in Ancestry; matches SM
browse if clean_priority==5 & image_id=="4547939_00551"
replace st_edit="S Laredo St" if clean_priority==5 & image_id=="4547939_00551"
replace checked_st="c" if clean_priority==5 & image_id=="4547939_00551"
replace checked_hn="c" if clean_priority==5 & image_id=="4547939_00551"

*Apartments on City St
browse if clean_priority==5 & overall_match=="City St"
replace hn_edit=110 if clean_priority==5 & overall_match=="City St" & line_num<45
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="City St" & line_num<38
replace hn_flag="APT 4" if clean_priority==5 & overall_match=="City St" & line_num<43 & line_num>37
replace hn_edit=218 if clean_priority==5 & overall_match=="City St" & line_num>50
replace hn_flag="APT 3" if clean_priority==5 & overall_match=="City St" & line_num>50
replace hn_flag="APT 4" if clean_priority==5 & overall_match=="City St" & line_num>62
replace checked_st="c" if clean_priority==5 & overall_match=="City St"
replace checked_hn="c, multi-unit" if clean_priority==5 & overall_match=="City St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Frasch St"
replace hn_edit=211 if clean_priority==5 & overall_match=="Frasch St" & image_id=="4547939_00632"
replace hn_edit=302 if clean_priority==5 & overall_match=="Frasch St" & line_num==53
replace hn_edit=510 if clean_priority==5 & overall_match=="Frasch St" & line_num>80
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Frasch St"
replace checked_st="c" if clean_priority==5 & overall_match=="Frasch St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Frasch St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Daniel St"
replace hn_edit=216 if clean_priority==5 & overall_match=="Daniel St"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Daniel St"
replace checked_st="c" if clean_priority==5 & overall_match=="Daniel St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Daniel St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Tunstall St"
replace checked_st="c" if clean_priority==5 & overall_match=="Tunstall St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Tunstall St"

*Looks like S Flores on Ancestry, which matches Ancestry
browse if clean_priority==5 & street_raw=="SO ??"
replace st_edit="S Flores St" if clean_priority==5 & street_raw=="SO ??"
replace hn_edit=1420 if clean_priority==5 & street_raw=="SO ??"
replace checked_st="c" if clean_priority==5 & street_raw=="SO ??"
replace checked_hn="c" if clean_priority==5 & street_raw=="SO ??"

*Looks like "unamed st" in Ancestry
browse if clean_priority==5 & overall_match=="Frame St"
replace st_edit="" if clean_priority==5 & overall_match=="Frame St"
replace stname_flag="Unnamed St" if clean_priority==5 & overall_match=="Frame St"
replace hn_edit=118 if clean_priority==5 & overall_match=="Frame St"
replace hn_flag="118 Rear 1" if clean_priority==5 & overall_match=="Frame St"
replace checked_st="c, ambiguous" if clean_priority==5 & overall_match=="Frame St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Frame St"

*Looks like S Flores in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="S Floor"
replace st_edit="S Flores St" if clean_priority==5 & street_precleanedhn=="S Floor"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="S Floor"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Floor"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Applewhite St"
replace checked_st="c" if clean_priority==5 & overall_match=="Applewhite St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Applewhite St"

*Says Unnamed St in Ancestry
browse if clean_priority==5 & street_precleanedhn=="Unnamed St"
replace stname_flag="Unnamed St" if clean_priority==5 & street_precleanedhn=="Unnamed St"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Unnamed St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Unnamed St"

*No hn in Ancestry
browse if clean_priority==5 & overall_match=="La Chappelle St"
*Deleted hn_edit values
replace checked_st="c" if clean_priority==5 & overall_match=="La Chappelle St"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="La Chappelle St"

*Matches Ancesry and SM
browse if clean_priority==5 & overall_match=="Mockert St"
replace checked_st="c" if clean_priority==5 & overall_match=="Mockert St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Mockert St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Floyd Ave"
replace checked_st="c" if clean_priority==5 & overall_match=="Floyd Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Floyd Ave"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Frio City Road"
replace checked_st="c" if clean_priority==5 & overall_match=="Frio City Road"
replace checked_hn="c" if clean_priority==5 & overall_match=="Frio City Road"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Midway Ave"
replace checked_st="c" if clean_priority==5 & overall_match=="Midway Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Midway Ave"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Park Row St"
replace checked_st="c" if clean_priority==5 & overall_match=="Park Row St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Park Row St"

*Similar to Childress St in SM
browse if clean_priority==5 & street_precleanedhn=="Childers"
replace st_edit="Childress St" if clean_priority==5 & street_precleanedhn=="Childers"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Childers"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Childers"

*Connor in Ancestry; Conner St in SM
browse if clean_priority==5 & overall_match=="Conner St"
replace checked_st="c" if clean_priority==5 & overall_match=="Conner St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Conner St"

*Home Crest Ave in Ancestry; SM has Homecrest St
browse if clean_priority==5 & street_precleanedhn=="Home Crest Ave"
replace stname_flag="Homecrest St" if clean_priority==5 & street_precleanedhn=="Home Crest Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Home Crest Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Home Crest Ave"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Nogalitos St"
replace checked_st="c" if clean_priority==5 & overall_match=="Nogalitos St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Nogalitos St"

*No street in Ancestry
browse if clean_priority==5 & image_id=="4547939_00989"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4547939_00989"
replace checked_hn="c" if clean_priority==5 & image_id=="4547939_00989"

*Fixed hns
browse if clean_priority==5 & overall_match=="Kirk Pl"
replace hn_edit=555 if clean_priority==5 & overall_match=="Kirk Pl"
replace checked_st="c" if clean_priority==5 & overall_match=="Kirk Pl"
replace checked_hn="c" if clean_priority==5 & overall_match=="Kirk Pl"

*Looks like it could be W Mitchell St, which matches SM
browse if clean_priority==5 & street_precleanedhn=="N Mitchell"
replace st_edit="W Mitchell St" if clean_priority==5 & street_precleanedhn=="N Mitchell"
replace checked_hn="c, ambiguous" if clean_priority==5 & street_precleanedhn=="N Mitchell"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="N Mitchell" & hn>600
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="N Mitchell"

*Fixed hns
browse if clean_priority==5 & overall_match=="S Flores St"
replace hn_edit=3110 if clean_priority==5 & overall_match=="S Flores St" & line_num>75
replace hn_edit=3209 if clean_priority==5 & overall_match=="S Flores St" & line_num<75
replace hn_flag="3209 rear" if clean_priority==5 & overall_match=="S Flores St" & line_num<75
replace checked_st="c" if clean_priority==5 & overall_match=="S Flores St"
replace checked_hn="c" if clean_priority==5 & overall_match=="S Flores St"

*E Glenn St in Ancestry; SM has Glenn Ave
browse if clean_priority==5 & street_precleanedhn=="E Glenn St"
replace stname_flag="Glenn Ave" if clean_priority==5 & street_precleanedhn=="E Glenn St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="E Glenn St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="E Glenn St"

*9/19
*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Sun St"
replace checked_st="c" if clean_priority==5 & overall_match=="Sun St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Sun St"

*Thelka Ave on previous Ancestry page and SM
browse if clean_priority==5 & street_precleanedhn=="Thelka St"
replace st_edit="Thelka Ave" if clean_priority==5 & street_precleanedhn=="Thelka St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Thelka St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Thelka St"

*Mitchell St in Ancestry; W Mitchell St in SM
browse if clean_priority==5 & street_precleanedhn=="Mitchell"
replace st_edit="Mitchell St" if clean_priority==5 & street_precleanedhn=="Mitchell"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Mitchell"
replace stname_flag="W Mitchell St" if clean_priority==5 & street_precleanedhn=="Mitchell"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Mitchell"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Maurmann St"
replace checked_st="c" if clean_priority==5 & overall_match=="Maurmann St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Maurmann St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Margil St"
replace checked_st="c" if clean_priority==5 & overall_match=="Margil St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Margil St"

*Franciscan St in previous Ancestry page, SM has Franciscan Ave
browse if clean_priority==5 & overall_match=="Franciscan Ave"
replace st_edit="Franciscan St" if clean_priority==5 & overall_match=="Franciscan Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & overall_match=="Franciscan Ave"
replace stname_flag="Franciscan Ave" if clean_priority==5 & overall_match=="Franciscan Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Franciscan Ave"

*Fixed hns
browse if clean_priority==5 & overall_match=="Eldorado St"
replace hn_edit=247 if clean_priority==5 & overall_match=="Eldorado St"
replace checked_st="c" if clean_priority==5 & overall_match=="Eldorado St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Eldorado St"

*W Glenn Ave in Ancestry; SM has Glenn Ave
browse if clean_priority==5 & street_precleanedhn=="W Glenn"
replace st_edit="W Glenn Ave" if clean_priority==5 & street_precleanedhn=="W Glenn"
replace stname_flag="Glenn Ave" if clean_priority==5 & street_precleanedhn=="W Glenn"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="W Glenn"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W Glenn"

*Buffalo in Ancestry; SM has Buffalo St
browse if clean_priority==5 & overall_match=="Buffalo St"
replace checked_st="c" if clean_priority==5 & overall_match=="Buffalo St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Buffalo St"

*Winnipeg in Ancestry, SM has Winnipeg Ave in next ED
browse if clean_priority==5 & street_precleanedhn=="Winnipeg"
replace st_edit="Winnipeg Ave" if clean_priority==5 & street_precleanedhn=="Winnipeg"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==5 & street_precleanedhn=="Winnipeg"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Winnipeg"

*Rochambeau in Ancestry; SM has Rochambeau St
browse if clean_priority==5 & overall_match=="Rochambeau St"
replace checked_st="c" if clean_priority==5 & overall_match=="Rochambeau St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Rochambeau St"

*Hoover in Ancestry; SM has Hoover Ave
browse if clean_priority==5 & overall_match=="Hoover Ave"
replace checked_st="c" if clean_priority==5 & overall_match=="Hoover Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Hoover Ave"

*Surry St in Ancestry; SM has Surrey St
browse if clean_priority==5 & overall_match=="Surrey St"
replace hn_edit=531 if clean_priority==5 & overall_match=="Surrey St" & hn==831
replace stname_flag="Surry St" if clean_priority==5 & overall_match=="Surrey St"
replace checked_st="c" if clean_priority==5 & overall_match=="Surrey St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Surrey St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Taft Blvd"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Taft Blvd"
replace hn_edit=302 if clean_priority==5 & overall_match=="Taft Blvd"
replace checked_st="c" if clean_priority==5 & overall_match=="Taft Blvd"
replace checked_hn="c" if clean_priority==5 & overall_match=="Taft Blvd"

*De Soto in Ancestry; De Soto St in SM
browse if clean_priority==5 & overall_match=="De Soto St"
replace checked_st="c" if clean_priority==5 & overall_match=="De Soto St"
replace checked_hn="c" if clean_priority==5 & overall_match=="De Soto St"

*Adina S in Ancestry; Adina St in SM
browse if clean_priority==5 & street_precleanedhn=="S Adina"
replace hn_edit=110 if clean_priority==5 & street_precleanedhn=="S Adina" & hn==1100
replace st_edit="Adina St" if clean_priority==5 & street_precleanedhn=="S Adina"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="S Adina"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Adina"

*Walton Ave in Ancestry; SM has Walton St
browse if clean_priority==5 & street_precleanedhn=="Walton Ave"
replace stname_flag="Walton St" if clean_priority==5 & street_precleanedhn=="Walton Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Walton Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Walton Ave"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Charlotte St"
replace checked_st="c" if clean_priority==5 & overall_match=="Charlotte St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Charlotte St"

*Looks like S Concho in Ancestry; SM has S Concho St
browse if clean_priority==5 & street_precleanedhn=="S Cavalier"
replace st_edit="S Concho St" if clean_priority==5 & street_precleanedhn=="S Cavalier"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="S Cavalier"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Cavalier"

*Santa Rosa in Ancestry; SM has Santa Rosa Ave
browse if clean_priority==5 & street_precleanedhn=="De Rosa"
replace st_edit="Santa Rosa Ave" if clean_priority==5 & street_precleanedhn=="De Rosa"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="De Rosa"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="De Rosa"

*S Laredo in Ancestry; SM has S Laredo St
browse if clean_priority==5 & street_precleanedhn=="S Loud"
replace st_edit="S Laredo St" if clean_priority==5 & street_precleanedhn=="S Loud"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="S Loud"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Loud"

*S Santa Rosa in Ancestry; SM has Santa Rosa Ave
browse if clean_priority==5 & overall_match=="Santa Rosa Ave"
replace st_edit="S Santa Rosa Ave" if clean_priority==5 & overall_match=="Santa Rosa Ave"
replace stname_flag="Santa Rosa Ave" if clean_priority==5 & overall_match=="Santa Rosa Ave"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="Santa Rosa Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Santa Rosa Ave"

*Fixed hns
browse if clean_priority==5 & overall_match=="Buena Vista St"
replace hn_edit=217 if clean_priority==5 & overall_match=="Buena Vista St" & hn==219
replace hn_edit=1213 if clean_priority==5 & overall_match=="Buena Vista St" & hn>1000
replace checked_st="c" if clean_priority==5 & overall_match=="Buena Vista St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Buena Vista St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Durango St"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Durango St"
replace hn_edit=305 if clean_priority==5 & overall_match=="Durango St"
replace checked_st="c" if clean_priority==5 & overall_match=="Durango St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Durango St"

*Fixed hns
browse if clean_priority==5 & overall_match=="S Concho St"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="S Concho St"
replace hn_edit=406 if clean_priority==5 & overall_match=="S Concho St" & line_num<50
replace hn_edit=412 if clean_priority==5 & overall_match=="S Concho St" & line_num<40
replace hn_edit=629 if clean_priority==5 & overall_match=="S Concho St" & line_num>50
replace checked_st="c" if clean_priority==5 & overall_match=="S Concho St"
replace checked_hn="c" if clean_priority==5 & overall_match=="S Concho St" & line_num<50
replace checked_hn="c, multi-unit" if clean_priority==5 & overall_match=="S Concho St" & line_num>50

*S Pecos St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Pecon St"
replace st_edit="S Pecos St" if clean_priority==5 & street_precleanedhn=="Pecon St"
replace hn_flag="309 REAR" if clean_priority==5 & street_precleanedhn=="Pecon St" & hn==259
replace hn_edit=309 if clean_priority==5 & street_precleanedhn=="Pecon St" & hn==259
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Pecon St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Pecon St"

*9/20
*Fixed hns
browse if clean_priority==5 & overall_match=="S Pecos St"
replace hn_edit=618 if clean_priority==5 & overall_match=="S Pecos St" & image_id=="4547940_00358"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="S Pecos St" & image_id=="4547940_00358"
replace hn_edit=816 if clean_priority==5 & overall_match=="S Pecos St" & image_id=="4547940_00529"
replace hn_flag="APT 7 R" if clean_priority==5 & overall_match=="S Pecos St" & image_id=="4547940_00529"
replace hn_edit=822 if clean_priority==5 & overall_match=="S Pecos St" & image_id=="4547940_00530"
replace hn_flag="APT 4" if clean_priority==5 & overall_match=="S Pecos St" & image_id=="4547940_00530"
replace hn_edit=1021 if clean_priority==5 & overall_match=="S Pecos St" & block_edit=="835"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="S Pecos St" & block_edit=="835"
replace checked_st="c" if clean_priority==5 & overall_match=="S Pecos St"
replace checked_hn="c, multi-unit" if clean_priority==5 & overall_match=="S Pecos St" & block_edit!="835"
replace checked_hn="c" if clean_priority==5 & overall_match=="S Pecos St" & checked_hn==""

*Could be Zacatecas Rear, SM has Zacatecas Aly
browse if clean_priority==5 & street_precleanedhn=="Zaration"
replace st_edit="Zacatecas Aly" if clean_priority==5 & street_precleanedhn=="Zaration"
replace stname_flag="Zacatecas Rear" if clean_priority==5 & street_precleanedhn=="Zaration"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Zaration"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Zaration"

*Mattamoras Aly in Ancestry; SM has similar Matamoras St
browse if clean_priority==5 & street_precleanedhn=="Mattamoras Aly"
replace stname_flag="Matamoras St" if clean_priority==5 & street_precleanedhn=="Mattamoras Aly"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Mattamoras Aly"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Mattamoras Aly"

*No street name in Ancestry
browse if clean_priority==5 & image_id=="4547940_00475"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4547940_00475"
replace checked_hn="c" if clean_priority==5 & image_id=="4547940_00475"

*San Fernando St in Ancestry a few pages prior; SM has both San Fernando St and Aly
browse if clean_priority==5 & street_precleanedhn=="San Fernando"
replace st_edit="San Fernando St" if clean_priority==5 & street_precleanedhn=="San Fernando"
replace stname_flag="San Fernando Aly" if clean_priority==5 & street_precleanedhn=="San Fernando"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="San Fernando"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="San Fernando"

*Fixed hns
browse if clean_priority==5 & overall_match=="S Leona St"
replace hn_edit=801 if clean_priority==5 & overall_match=="S Leona St"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="S Leona St"
replace checked_st="c" if clean_priority==5 & overall_match=="S Leona St"
replace checked_hn="c" if clean_priority==5 & overall_match=="S Leona St"

*Fixed hns
browse if clean_priority==5 & overall_match=="San Fernando Aly"
replace hn_edit=216 if clean_priority==5 & overall_match=="San Fernando Aly"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="San Fernando Aly"
replace checked_st="c" if clean_priority==5 & overall_match=="San Fernando Aly"
replace checked_hn="c" if clean_priority==5 & overall_match=="San Fernando Aly"

*Hard to read on Ancestry; can't find similar st in SM
browse if clean_priority==5 & street_precleanedhn=="Melio Aly"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Melio Aly"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Melio Aly"

*Fixed hns
browse if clean_priority==5 & overall_match=="Colima St"
replace hn_edit=217 if clean_priority==5 & overall_match=="Colima St" & image_id=="4547940_00535"
replace hn_edit=110 if clean_priority==5 & overall_match=="Colima St" & image_id=="4547940_00554"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Colima St" & image_id=="4547940_00554"
replace hn_edit=823 if clean_priority==5 & overall_match=="Colima St" & image_id=="4547940_00835"
replace hn_flag="823 rear" if clean_priority==5 & overall_match=="Colima St" & image_id=="4547940_00835"
replace hn_edit=1521 if clean_priority==5 & overall_match=="Colima St" & hn==15211
replace hn_edit=1314 if clean_priority==5 & overall_match=="Colima St" & hn==13114
replace hn_edit=1803 if clean_priority==5 & overall_match=="Colima St" & hn==18003
replace checked_st="c" if clean_priority==5 & overall_match=="Colima St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Colima St"

*Could be S Frio St, matches SM
browse if clean_priority==5 & image_id=="4547940_00553"
replace st_edit="S Frio St" if clean_priority==5 & image_id=="4547940_00553"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4547940_00553"
replace checked_hn="c" if clean_priority==5 & image_id=="4547940_00553"

*Fixed hns
browse if clean_priority==5 & overall_match=="Rubiola Aly"
replace hn_edit=104 if clean_priority==5 & overall_match=="Rubiola Aly"
replace hn_edit=106 if clean_priority==5 & overall_match=="Rubiola Aly" & line_num<73
replace hn_edit=107 if clean_priority==5 & overall_match=="Rubiola Aly" & line_num<30
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Rubiola Aly"
replace checked_st="c" if clean_priority==5 & overall_match=="Rubiola Aly"
replace checked_hn="c" if clean_priority==5 & overall_match=="Rubiola Aly"

*Some hns aren't clear
browse if clean_priority==5 & overall_match=="S Comal St"
replace checked_st="c" if clean_priority==5 & overall_match=="S Comal St"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="S Comal St" & hn==802
replace checked_hn="c" if clean_priority==5 & overall_match=="S Comal St" & hn==805

*Hard to read hn - looks like 317-M
browse if clean_priority==5 & overall_match=="Chihuahua St"
replace hn_edit=317 if clean_priority==5 & overall_match=="Chihuahua St"
replace hn_flag="317-M" if clean_priority==5 & overall_match=="Chihuahua St"
replace checked_st="c" if clean_priority==5 & overall_match=="Chihuahua St"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="Chihuahua St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Rupert Aly"
replace checked_st="c" if clean_priority==5 & overall_match=="Rupert Aly"
replace checked_hn="c" if clean_priority==5 & overall_match=="Rupert Aly"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Gertrude Aly"
replace checked_st="c" if clean_priority==5 & overall_match=="Gertrude Aly"
replace checked_hn="c" if clean_priority==5 & overall_match=="Gertrude Aly"

*Buena Vista Aly in Ancestry; SM has Bueana Vista St
browse if clean_priority==5 & street_precleanedhn=="buena vista alley mailto 109 san"
replace st_edit="Buena Vista Aly" if clean_priority==5 & street_precleanedhn=="buena vista alley mailto 109 san"
replace stname_flag="Buena Vista St" if clean_priority==5 & street_precleanedhn=="buena vista alley mailto 109 san"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="buena vista alley mailto 109 san"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="buena vista alley mailto 109 san"

*Alley behind Monterey St
browse if clean_priority==5 & street_precleanedhn=="Alley In Rear Of Monterey St"
replace st_edit="Monterey St" if clean_priority==5 & street_precleanedhn=="Alley In Rear Of Monterey St"
replace stname_flag="Alley in Rear of Monterey St" if clean_priority==5 & street_precleanedhn=="Alley In Rear Of Monterey St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Alley In Rear Of Monterey St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Alley In Rear Of Monterey St"

*Fixed hns
browse if clean_priority==5 & overall_match=="San Fernando St"
replace hn_edit=1009 if clean_priority==5 & overall_match=="San Fernando St" & hn==10091
replace hn_flag="1009 #1" if clean_priority==5 & overall_match=="San Fernando St" & hn==10091
replace hn_edit=1124 if clean_priority==5 & overall_match=="San Fernando St" & hn==134
replace checked_st="c" if clean_priority==5 & overall_match=="San Fernando St"
replace checked_hn="c" if clean_priority==5 & overall_match=="San Fernando St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Speed St"
replace hn_edit=311 if clean_priority==5 & overall_match=="Speed St"
replace checked_st="c" if clean_priority==5 & overall_match=="Speed St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Speed St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Alazan St"
replace hn_edit=111 if clean_priority==5 & overall_match=="Alazan St"
replace checked_st="c" if clean_priority==5 & overall_match=="Alazan St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Alazan St"

*Ancestry has S Las Moras; SM has Las Moras St/Aly. Also other street is unclear but could be W Commerce St
browse if clean_priority==5 & street_precleanedhn=="S Los Moreno"
replace st_edit="S Las Moras" if clean_priority==5 & street_precleanedhn=="S Los Moreno" & hn==114
replace stname_flag="Las Moras St/Aly" if clean_priority==5 & street_precleanedhn=="S Los Moreno" & hn==114
replace st_edit="W Commerce St" if clean_priority==5 & street_precleanedhn=="S Los Moreno" & hn==2208
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="S Los Moreno"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Los Moreno"

*No hns
browse if clean_priority==5 & overall_match=="Kicaster Aly"
replace checked_st="c" if clean_priority==5 & overall_match=="Kicaster Aly"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="Kicaster Aly"

*S Pinto St in Ancestry; SM has Pinto St
browse if clean_priority==5 & street_precleanedhn=="S Pinta"
replace st_edit="S Pinto St" if clean_priority==5 & street_precleanedhn=="S Pinta"
replace stname_flag="Pinto St" if clean_priority==5 & street_precleanedhn=="S Pinta"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="S Pinta"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Pinta"

*N Trinity St in Ancestry but SM has S Trinity St
browse if clean_priority==5 & overall_match=="N Trinity St"
replace stname_flag="S Trinity St" if clean_priority==5 & overall_match=="N Trinity St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="N Trinity St"
replace checked_hn="c" if clean_priority==5 & overall_match=="N Trinity St"

*Fixed hns. Ancestry has S Jose St; SM has San Jose St
browse if clean_priority==5 & overall_match=="San Jose St"
replace hn_edit=115 if clean_priority==5 & overall_match=="San Jose St"
replace hn_flag="115 rear" if clean_priority==5 & overall_match=="San Jose St"
replace checked_st="c" if clean_priority==5 & overall_match=="San Jose St"
replace checked_hn="c" if clean_priority==5 & overall_match=="San Jose St"

*9/25
*Can't read street name fully; no similar st in SM
browse if clean_priority==5 & street_precleanedhn=="S Painto"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="S Painto"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Painto"

*San Patricio St in some Ancestry pages; SM has San Patricio Aly
browse if clean_priority==5 & overall_match=="San Patricio Aly"
replace st_edit="San Patricio St" if clean_priority==5 & overall_match=="San Patricio Aly" & hn==424
replace stname_flag="San Patricio Aly" if clean_priority==5 & overall_match=="San Patricio Aly" & hn==424
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & overall_match=="San Patricio Aly" & hn==424
replace checked_st="c, ambiguous" if clean_priority==5 & overall_match=="San Patricio Aly" & hn!=424
replace checked_hn="c" if clean_priority==5 & overall_match=="San Patricio Aly"

*Fixed hns
browse if clean_priority==5 & overall_match=="Vera Cruz St"
replace hn_edit=1621 if clean_priority==5 & overall_match=="Vera Cruz St"
replace checked_st="c" if clean_priority==5 & overall_match=="Vera Cruz St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Vera Cruz St"

*No direction in Ancestry; SM has S Navidad St
browse if clean_priority==5 & overall_match=="S Navidad St"
replace st_edit="Navidad St" if clean_priority==5 & overall_match=="S Navidad St"
replace stname_flag="S Navidad St" if clean_priority==5 & overall_match=="S Navidad St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="S Navidad St"
replace checked_hn="c" if clean_priority==5 & overall_match=="S Navidad St"

*S Pinto in Ancestry; Pinto St in SM
browse if clean_priority==5 & street_precleanedhn=="S Pinte"
replace st_edit="S Pinto St" if clean_priority==5 & street_precleanedhn=="S Pinte"
replace stname_flag="Pinto St" if clean_priority==5 & street_precleanedhn=="S Pinte"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="S Pinte"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Pinte"

*Fixed hns
browse if clean_priority==5 & overall_match=="Tampico St"
replace hn_edit=813 if clean_priority==5 & overall_match=="Tampico St"
replace checked_st="c" if clean_priority==5 & overall_match=="Tampico St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Tampico St"

*S Pinto rear in Ancestry; SM has Pinto St
browse if clean_priority==5 & overall_match=="Pinto St"
replace st_edit="S Pinto St" if clean_priority==5 & overall_match=="Pinto St"
replace stname_flag="S Pinto - rear" if clean_priority==5 & overall_match=="Pinto St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="Pinto St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Pinto St"

*No hn. Trinity St in Ancestry; SM has S Trinity St
browse if clean_priority==5 & overall_match=="S Trinity St"
*Manually removed hn_edit values
replace hn_flag="-" if clean_priority==5 & overall_match=="S Trinity St"
replace st_edit="Trinity St" if clean_priority==5 & overall_match=="S Trinity St"
replace stname_flag="S Trinity St" if clean_priority==5 & overall_match=="S Trinity St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="S Trinity St"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="S Trinity St"

*Fixed hn
browse if clean_priority==5 & overall_match=="Jean St"
replace hn_edit=103 if clean_priority==5 & overall_match=="Jean St"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Jean St"
replace checked_st="c" if clean_priority==5 & overall_match=="Jean St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Jean St"

*Medio in Ancestry; SM has Medio St. Brazos St in Ancestry; SM has S Brazos St
browse if clean_priority==5 & street_precleanedhn=="Nedro"
replace st_edit="Medio St" if clean_priority==5 & street_precleanedhn=="Nedro"
replace st_edit="Brazos St" if clean_priority==5 & street_precleanedhn=="Nedro" & line_num>10
replace stname_flag="Medio" if clean_priority==5 & street_precleanedhn=="Nedro"
replace stname_flag="S Brazos St" if clean_priority==5 & street_precleanedhn=="Nedro" & line_num>10
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Nedro"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Nedro" & line_num>10
replace hn_edit=1416 if clean_priority==5 & street_precleanedhn=="Nedro" & line_num>10
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Nedro"

*No st type in Ancestry; can't find in SM
browse if clean_priority==5 & street_precleanedhn=="Pellington"
replace checked_st="c, ancestry match, SM missing" if clean_priority==5 & street_precleanedhn=="Pellington"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Pellington"

*S Rosillo in Ancestry; SM has Rosillos St
browse if clean_priority==5 & street_precleanedhn=="S Rosillo"
replace stname_flag="Rosillos St" if clean_priority==5 & street_precleanedhn=="S Rosillo"
replace st_edit="S Rosillo St" if clean_priority==5 & street_precleanedhn=="S Rosillo"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="S Rosillo"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Rosillo"

*No hns
browse if clean_priority==5 & overall_match=="S Sabinas St"
replace checked_st="c" if clean_priority==5 & overall_match=="S Sabinas St"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="S Sabinas St"

*Angela in Ancestry; SM has Angella St
browse if clean_priority==5 & overall_match=="Angella St"
replace stname_flag="Angela" if clean_priority==5 & overall_match=="Angella St"
replace checked_st="c" if clean_priority==5 & overall_match=="Angella St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Angella St"

*Ceralvo in Ancestry; SM has Ceralvo St
browse if clean_priority==5 & overall_match=="Ceralvo St"
replace checked_st="c" if clean_priority==5 & overall_match=="Ceralvo St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Ceralvo St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Monterey St"
replace hn_edit=1911 if clean_priority==5 & overall_match=="Monterey St" & image_id=="4548182_00175"
replace hn_edit=1808 if clean_priority==5 & overall_match=="Monterey St" & image_id=="4548182_00178"
replace hn_edit=1908 if clean_priority==5 & overall_match=="Monterey St" & image_id=="4548182_00248"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Monterey St" & line_num<50
replace checked_st="c" if clean_priority==5 & overall_match=="Monterey St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Monterey St"

*Del Valle Aly Not Numbered in Ancestry; SM has Del Valle Aly
browse if clean_priority==5 & street_precleanedhn=="Del Valle St Numbered"
replace st_edit="Del Valle Aly" if clean_priority==5 & street_precleanedhn=="Del Valle St Numbered"
replace stname_flag="Del Valle Aly Not Numbered" if clean_priority==5 & street_precleanedhn=="Del Valle St Numbered"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Del Valle St Numbered"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Del Valle St Numbered"

*Fixed hns
browse if clean_priority==5 & overall_match=="Torreon St"
replace hn_edit=610 if clean_priority==5 & overall_match=="Torreon St"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Torreon St"
replace checked_st="c" if clean_priority==5 & overall_match=="Torreon St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Torreon St"

*Fixed hns
browse if clean_priority==5 & overall_match=="El Paso St"
replace hn_edit=2019 if clean_priority==5 & overall_match=="El Paso St"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="El Paso St"
replace checked_st="c" if clean_priority==5 & overall_match=="El Paso St"
replace checked_hn="c" if clean_priority==5 & overall_match=="El Paso St"

*Looks like S Murry on Ancestry; SM has Murry St
browse if clean_priority==5 & street_precleanedhn=="S Masey"
replace st_edit="S Murry St" if clean_priority==5 & street_precleanedhn=="S Masey"
replace stname_flag="Murry St" if clean_priority==5 & street_precleanedhn=="S Masey"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="S Masey"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Masey"

*S Spring in Ancesry; SM has Spring St
browse if clean_priority==5 & street_precleanedhn=="S Spring"
replace st_edit="S Spring St" if clean_priority==5 & street_precleanedhn=="S Spring"
replace stname_flag="Spring St" if clean_priority==5 & street_precleanedhn=="S Spring"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="S Spring"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Spring"
replace checked_hn="c, ambiguous" if clean_priority==5 & street_precleanedhn=="S Spring" & hn>1000

*Can't read street name on Ancestry
browse if clean_priority==5 & street_precleanedhn=="S Shaundry"
replace hn_edit=2801 if clean_priority==5 & street_precleanedhn=="S Shaundry" & hn==2804
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="S Shaundry"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Shaundry"

*Elvira in Ancestry; SM has Elvira St in neighboring ED
browse if clean_priority==5 & street_precleanedhn=="Elvira"
replace st_edit="Elvira St" if clean_priority==5 & street_precleanedhn=="Elvira"
replace stname_flag="Elvira" if clean_priority==5 & street_precleanedhn=="Elvira"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==5 & street_precleanedhn=="Elvira"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Elvira"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Holly St"
replace checked_st="c" if clean_priority==5 & overall_match=="Holly St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Holly St"

*Minter St in Ancestry; SM has S Minter St
browse if clean_priority==5 & overall_match=="S Minter St"
replace hn_edit=2901 if clean_priority==5 & overall_match=="S Minter St" & hn==2904
replace stname_flag="Minter St" if clean_priority==5 & overall_match=="S Minter St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="S Minter St"
replace checked_hn="c" if clean_priority==5 & overall_match=="S Minter St"

*Picoso in Ancestry; SM has Picoso St
browse if clean_priority==5 & overall_match=="Picoso St"
replace checked_st="c" if clean_priority==5 & overall_match=="Picoso St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Picoso St"

*Fixed hns
browse if clean_priority==5 & overall_match=="San Carlos St"
replace hn_edit=1502 if clean_priority==5 & overall_match=="San Carlos St"
replace hn_flag="Second 1502" if clean_priority==5 & overall_match=="San Carlos St"
replace checked_st="c" if clean_priority==5 & overall_match=="San Carlos St"
replace checked_hn="c" if clean_priority==5 & overall_match=="San Carlos St"

*Says "no #" in Ancestry
browse if clean_priority==5 & overall_match=="Hidalgo St"
replace hn_flag="No #" if clean_priority==5 & overall_match=="Hidalgo St"
replace checked_st="c" if clean_priority==5 & overall_match=="Hidalgo St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Hidalgo St"

*9/26
*Loma Vista St in Ancestry; SM has Loma Vista Aly. Says "No #" for hns
browse if clean_priority==5 & overall_match=="Loma Vista Aly"
replace st_edit="Loma Vista St" if clean_priority==5 & overall_match=="Loma Vista Aly"
replace stname_flag="Loma Vista Aly" if clean_priority==5 & overall_match=="Loma Vista Aly"
replace hn_flag="No #" if clean_priority==5 & overall_match=="Loma Vista Aly"
*Cleared hn_edit values
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & overall_match=="Loma Vista Aly"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="Loma Vista Aly"

*S 19th St in Ancestry; SM has SW 19th St. No house numbers
browse if clean_priority==5 & overall_match=="SW 19th St"
replace st_edit="S 19th St" if clean_priority==5 & overall_match=="SW 19th St"
replace stname_flag="SW 19th St" if clean_priority==5 & overall_match=="SW 19th St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="SW 19th St"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="SW 19th St"
replace hn_flag="No #" if clean_priority==5 & overall_match=="SW 19th St"
*Cleared hn_edit values

*Brady Blvd in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Brady"
replace st_edit="Brady Blvd" if clean_priority==5 & street_precleanedhn=="Brady"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Brady"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Brady"

*Hard to read in Ancestry but looks similar to Obregon St in SM
browse if clean_priority==5 & overall_match=="Obregon St"
replace checked_st="c" if clean_priority==5 & overall_match=="Obregon St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Obregon St"

*Hazel St in Ancestry; SM has Hazel Ave
browse if clean_priority==5 & street_precleanedhn=="Hazel St"
replace stname_flag="Hazel Ave" if clean_priority==5 & street_precleanedhn=="Hazel St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Hazel St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Hazel St"

*Can't find street name in Ancestry
browse if clean_priority==5 & image_id=="4548182_00456"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548182_00456"
replace checked_hn="c" if clean_priority==5 & image_id=="4548182_00456"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Darby Blvd"
replace checked_st="c" if clean_priority==5 & overall_match=="Darby Blvd"
replace checked_hn="c" if clean_priority==5 & overall_match=="Darby Blvd"

*Fixed hns
browse if clean_priority==5 & overall_match=="N Laredo St"
replace hn_edit=807 if clean_priority==5 & overall_match=="N Laredo St" & street_raw=="NORTH LAREDO STREET"
replace hn_flag="?" if clean_priority==5 & overall_match=="N Laredo St" & street_raw=="NORTH LAREDO STREET"
replace hn_edit=132 if clean_priority==5 & overall_match=="N Laredo St" & line_num>69
replace checked_st="c" if clean_priority==5 & overall_match=="N Laredo St"
replace checked_hn="c" if clean_priority==5 & overall_match=="N Laredo St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Morales St"
replace hn_edit=317 if clean_priority==5 & overall_match=="Morales St"
replace hn_flag="317 B-C" if clean_priority==5 & overall_match=="Morales St"
replace checked_st="c" if clean_priority==5 & overall_match=="Morales St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Morales St"

*Some entries were actually N Laredo St
browse if clean_priority==5 & overall_match=="W Houston St"
replace hn_edit=916 if clean_priority==5 & overall_match=="W Houston St" & hn==0
replace hn_edit=216 if clean_priority==5 & overall_match=="W Houston St" & hn==266
replace st_edit="N Laredo St" if clean_priority==5 & overall_match=="W Houston St" & hn==266
replace checked_st="c" if clean_priority==5 & overall_match=="W Houston St"
replace checked_hn="c" if clean_priority==5 & overall_match=="W Houston St"

*W Salinas in Ancestry; SM has W Salinas St
browse if clean_priority==5 & street_precleanedhn=="W Sabinas"
replace st_edit="W Salinas St" if clean_priority==5 & street_precleanedhn=="W Sabinas"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="W Sabinas"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W Sabinas"

*W Salinas St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="W Sabinas St"
replace hn_flag="Rear" if clean_priority==5 & street_precleanedhn=="W Sabinas St" & image_id=="4548182_00571"
replace st_edit="W Salinas St" if clean_priority==5 & street_precleanedhn=="W Sabinas St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="W Sabinas St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W Sabinas St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Leal St"
replace hn_edit=215 if clean_priority==5 & overall_match=="Leal St"
replace hn_flag="Rear 215 1/2" if clean_priority==5 & overall_match=="Leal St"
replace checked_st="c" if clean_priority==5 & overall_match=="Leal St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Leal St"

*Looks like N Pecos St which matches SM
browse if clean_priority==5 & street_precleanedhn=="N Perez St"
replace st_edit="N Pecos St" if clean_priority==5 & street_precleanedhn=="N Perez St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="N Perez St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="N Perez St"

*Comal and Perez in Ancestry; SM has N Comal St and Perez St
browse if clean_priority==5 & street_precleanedhn=="Concho"
replace st_edit="Comal St" if clean_priority==5 & street_precleanedhn=="Concho"
replace st_edit="Perez St" if clean_priority==5 & street_precleanedhn=="Concho" & hn==603
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Concho" & hn!=603
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Concho" & hn==603
replace stname_flag="N Comal St" if clean_priority==5 & street_precleanedhn=="Concho" & hn!=603
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Concho"

*Looks like N Colorado St which matches Sm
browse if clean_priority==5 & street_precleanedhn=="W Colorado St"
replace st_edit="N Colorado St" if clean_priority==5 & street_precleanedhn=="W Colorado St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="W Colorado St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W Colorado St"

*Could be Ruiz Aly but not sure
browse if clean_priority==5 & street_precleanedhn=="Pez Aly"
replace stname_flag="Ruiz Aly" if clean_priority==5 & street_precleanedhn=="Pez Aly"
replace checked_st="c, ancestry match" if clean_priority==5 & street_precleanedhn=="Pez Aly"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Pez Aly"

*Trinity in Ancestry; SM has N Trinity St
browse if clean_priority==5 & street_precleanedhn=="Trinity"
replace st_edit="Trinity St" if clean_priority==5 & street_precleanedhn=="Trinity"
replace stname_flag="N Trinity St" if clean_priority==5 & street_precleanedhn=="Trinity"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Trinity"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Trinity"

*Maria in Ancestry; SM has Maria Aly
browse if clean_priority==5 & street_precleanedhn=="Maria"
replace st_edit="Maria Aly" if clean_priority==5 & street_precleanedhn=="Maria"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Maria"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Maria"

*9/27
*Camada in Ancestry; SM has Camada St in next ED
browse if clean_priority==5 & street_precleanedhn=="Camada"
replace st_edit="Camada St" if clean_priority==5 & street_precleanedhn=="Camada"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==5 & street_precleanedhn=="Camada"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Camada"

*Lyons in Ancestry; SM has Lyons St
browse if clean_priority==5 & overall_match=="Lyons St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Lyons St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Lyons St"

*Delgado in Ancestry; SM has Delgado St
browse if clean_priority==5 & overall_match=="Delgado St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Delgado St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Delgado St"

*No street name in Ancestry
browse if clean_priority==5 & image_id=="4548182_01037"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548182_01037"
replace checked_hn="c" if clean_priority==5 & image_id=="4548182_01037"

*No st name in Ancestry, could be W Travis St
browse if clean_priority==5 & image_id=="4548182_01080"
replace st_edit="W Travis St" if clean_priority==5 & image_id=="4548182_01080"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548182_01080"
replace checked_hn="c" if clean_priority==5 & image_id=="4548182_01080"

*N Murray in Ancestry while SM has Murry St. W Houston in Ancestry while SM has W Houson St
browse if clean_priority==5 & street_precleanedhn=="N Murray"
replace st_edit="W Houston St" if clean_priority==5 & street_precleanedhn=="N Murray" & hn>1000
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="N Murray" & hn>1000
replace stname_flag="Murry St" if clean_priority==5 & street_precleanedhn=="N Murray" & hn<1000
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="N Murray" & hn<1000
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="N Murray"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Rivas St"
replace checked_st="c" if clean_priority==5 & overall_match=="Rivas St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Rivas St"

*Arbor St in Ancestry; SM has Arbor Pl
browse if clean_priority==5 & street_precleanedhn=="Arbor St"
replace stname_flag="Arbor Pl" if clean_priority==5 & street_precleanedhn=="Arbor St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Arbor St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Arbor St"
replace checked_hn="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Arbor St" & hn>3000

*W Salinas St in Ancestry, matches SM
browse if clean_priority==5 & street_precleanedhn=="Sabinas St"
replace st_edit="W Salinas St" if clean_priority==5 & street_precleanedhn=="Sabinas St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Sabinas St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Sabinas St"
replace checked_hn="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Sabinas St" & hn<10

*W in Ancestry; SM has NW
browse if clean_priority==5 & street_precleanedhn=="W 24th St"
replace stname_flag="NW 24th St" if clean_priority==5 & street_precleanedhn=="W 24th St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="W 24th St"
replace checked_hn="c, ambiguous" if clean_priority==5 & street_precleanedhn=="W 24th St" & hn<1000
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W 24th St" & hn>1000

*Hard to read but could possibly be Martinez Aly which matches SM
browse if clean_priority==5 & street_precleanedhn=="Morting"
replace st_edit="Martinez ALy" if clean_priority==5 & street_precleanedhn=="Morting"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Morting"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Morting"

*San Marcos St in Ancestry; SM has N San Marcos St
browse if clean_priority==5 & street_precleanedhn=="San Marcus St"
replace st_edit="San Marcos St" if clean_priority==5 & street_precleanedhn=="San Marcus St"
replace stname_flag="N San Marcos St" if clean_priority==5 & street_precleanedhn=="San Marcus St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="San Marcus St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="San Marcus St"

*On corner of ? and Ruiz St; Ruiz St matches SM
browse if clean_priority==5 & street_precleanedhn=="Corner Of Propor Reey St"
replace st_edit="Ruiz St" if clean_priority==5 & street_precleanedhn=="Corner Of Propor Reey St"
replace stname_flag="Corner of ? and Ruiz St" if clean_priority==5 & street_precleanedhn=="Corner Of Propor Reey St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Corner Of Propor Reey St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Corner Of Propor Reey St"

*Colorado Ave in Ancestry; SM has N Colorado St
browse if clean_priority==5 & overall_match=="Princeton Ave"
replace st_edit="Colorado Ave" if clean_priority==5 & overall_match=="Princeton Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & overall_match=="Princeton Ave"
replace stname_flag="N Colorado St" if clean_priority==5 & overall_match=="Princeton Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Princeton Ave"

*N Brazos in Ancestry; SM has N Brazos St; some lines crossed out
browse if clean_priority==5 & overall_match=="N Brazos St"
replace hn_edit=1814 if clean_priority==5 & overall_match=="N Brazos St"
replace stname_flag="POSSIBLE DELETE" if clean_priority==5 & overall_match=="N Brazos St" & rel_id==65487190
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="N Brazos St"
replace checked_hn="c" if clean_priority==5 & overall_match=="N Brazos St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Mullen St"
replace hn_edit=104 if clean_priority==5 & overall_match=="Mullen St"
replace hn_edit=115 if clean_priority==5 & overall_match=="Mullen St" & line_num>12
replace checked_st="c" if clean_priority==5 & overall_match=="Mullen St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Mullen St"

*Meridian St in Ancestry; SM has Meridian Ave
browse if clean_priority==5 & street_precleanedhn=="Meridian St"
replace stname_flag="Meridian Ave" if clean_priority==5 & street_precleanedhn=="Meridian St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Meridian St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Meridian St"

*No street name in Ancestry
browse if clean_priority==5 & image_id=="4548183_00216"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548183_00216"
replace checked_hn="c" if clean_priority==5 & image_id=="4548183_00216"

*Navidad and Craig Pl in Ancestry; SM has N Navidad St and W Craig Pl
browse if clean_priority==5 & overall_match=="N Navidad St"
replace st_edit="Navidad St" if clean_priority==5 & overall_match=="N Navidad St"
replace st_edit="Craig Pl" if clean_priority==5 & overall_match=="N Navidad St" & line_num>15
replace stname_flag="N Navidad St" if clean_priority==5 & overall_match=="N Navidad St"
replace stname_flag="W Craig Pl" if clean_priority==5 & overall_match=="N Navidad St" & line_num>15
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="N Navidad St"
replace checked_hn="c" if clean_priority==5 & overall_match=="N Navidad St"

*Craig Pl in Ancestry; SM has W Craig Pl
browse if clean_priority==5 & street_precleanedhn=="Craig Ave"
replace st_edit="Craig Pl" if clean_priority==5 & street_precleanedhn=="Craig Ave"
replace stname_flag="W Craig Pl" if clean_priority==5 & street_precleanedhn=="Craig Ave"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Craig Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Craig Ave"

*Mary Louise in Ancestry; SM has Mary Louise Dr
browse if clean_priority==5 & street_precleanedhn=="Mary Linar"
replace st_edit="Mary Louise Drive" if clean_priority==5 & street_precleanedhn=="Mary Linar"
replace hn_edit=202 if clean_priority==5 & street_precleanedhn=="Mary Linar"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Mary Linar"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Mary Linar"

*Fixed hns
browse if clean_priority==5 & overall_match=="Club Drive"
replace hn_edit=315 if clean_priority==5 & overall_match=="Club Drive"
replace hn_edit=329 if clean_priority==5 & overall_match=="Club Drive" & line_num>73
replace hn_edit=339 if clean_priority==5 & overall_match=="Club Drive" & line_num>78
replace checked_st="c" if clean_priority==5 & overall_match=="Club Drive"
replace checked_hn="c" if clean_priority==5 & overall_match=="Club Drive"

*Fixed hns
browse if clean_priority==5 & overall_match=="W Gramercy Pl"
replace hn_edit=2146 if clean_priority==5 & overall_match=="W Gramercy Pl" & line_num<10
replace hn_edit=2210 if clean_priority==5 & overall_match=="W Gramercy Pl" & line_num>10
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="W Gramercy Pl"
replace checked_hn="c" if clean_priority==5 & overall_match=="W Gramercy Pl"

*Fixed hns
browse if clean_priority==5 & overall_match=="W Summit Ave"
replace hn_edit=2150 if clean_priority==5 & overall_match=="W Summit Ave"
replace hn_edit=2146 if clean_priority==5 & overall_match=="W Summit Ave" & line_num>5
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="W Summit Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="W Summit Ave"

*Fixed hns
browse if clean_priority==5 & overall_match=="N Hamilton Ave"
replace hn_edit=1414 if clean_priority==5 & overall_match=="N Hamilton Ave" & line_num<3
replace hn_edit=1051 if clean_priority==5 & overall_match=="N Hamilton Ave" & line_num>2
replace st_edit="Waverly Ave" if clean_priority==5 & overall_match=="N Hamilton Ave" & line_num>2
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="N Hamilton Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="N Hamilton Ave"

*Fixed hns
browse if clean_priority==5 & overall_match=="Kentucky Ave"
replace hn_edit=1245 if clean_priority==5 & overall_match=="Kentucky Ave"
replace hn_edit=1247 if clean_priority==5 & overall_match=="Kentucky Ave" & line_num>27
replace checked_st="c" if clean_priority==5 & overall_match=="Kentucky Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Kentucky Ave"

*Fixed hns
browse if clean_priority==5 & overall_match=="Josephine Tobin Drive"
replace hn_edit=330 if clean_priority==5 & overall_match=="Josephine Tobin Drive"
replace checked_st="c" if clean_priority==5 & overall_match=="Josephine Tobin Drive"
replace checked_hn="c" if clean_priority==5 & overall_match=="Josephine Tobin Drive"

*Fixed hns
browse if clean_priority==5 & overall_match=="Cincinnati Ave"
*Manually edited hn_edit values
replace checked_st="c" if clean_priority==5 & overall_match=="Cincinnati Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Cincinnati Ave"

*W Cincinnatti
browse if clean_priority==5 & street_precleanedhn=="Glongs On Line St"
*Manually edited hn_edit values
replace st_edit="W Cincinnati Ave" if clean_priority==5 & street_precleanedhn=="Glongs On Line St"
replace stname_flag="Cincinnati Ave" if clean_priority==5 & street_precleanedhn=="Glongs On Line St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Glongs On Line St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Glongs On Line St"

*W Texas Ave in Ancestry; SM has Texas Ave
browse if clean_priority==5 & street_precleanedhn=="W Texas"
replace st_edit="W Texas Ave" if clean_priority==5 & street_precleanedhn=="W Texas"
replace stname_flag="Texas Ave" if clean_priority==5 & street_precleanedhn=="W Texas"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="W Texas"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W Texas"

*Culebra Road in Ancestry; SM has Culebra Ave
browse if clean_priority==5 & overall_match=="Culebra Ave"
replace hn_edit=1326 if clean_priority==5 & overall_match=="Culebra Ave"
replace hn_edit=1310 if clean_priority==5 & overall_match=="Culebra Ave" & line_num>3
replace stname_flag="Culebra Road" if clean_priority==5 & overall_match=="Culebra Ave"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="Culebra Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Culebra Ave"

*Fixed hns
browse if clean_priority==5 & overall_match=="W 18th St"
replace hn_edit=1701 if clean_priority==5 & overall_match=="W 18th St"
replace checked_st="c" if clean_priority==5 & overall_match=="W 18th St"
replace checked_hn="c" if clean_priority==5 & overall_match=="W 18th St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Adaes Ave"
replace hn_edit=423 if clean_priority==5 & overall_match=="Adaes Ave"
replace checked_st="c" if clean_priority==5 & overall_match=="Adaes Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Adaes Ave"

*24th St in Ancestry; SM has NW 24th St
browse if clean_priority==5 & overall_match=="NW 24th St"
replace stname_flag="24th St" if clean_priority==5 & overall_match=="NW 24th St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="NW 24th St"
replace checked_hn="c" if clean_priority==5 & overall_match=="NW 24th St"

*23rd St in Ancestry; SM has NW 23rd St
browse if clean_priority==5 & overall_match=="NW 23rd St"
replace hn_edit=1514 if clean_priority==5 & overall_match=="NW 23rd St"
replace hn_edit=1506 if clean_priority==5 & overall_match=="NW 23rd St" & line_num>1
replace stname_flag="23rd St" if clean_priority==5 & overall_match=="NW 23rd St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="NW 23rd St"
replace checked_hn="c" if clean_priority==5 & overall_match=="NW 23rd St"

*9/28
*22nd St in Ancestry; SM has NW 22nd St in diff ED
browse if clean_priority==5 & street_precleanedhn=="22nd St"
replace hn_edit=1523 if clean_priority==5 & street_precleanedhn=="22nd St"
replace stname_flag="NW 22nd St" if clean_priority==5 & street_precleanedhn=="22nd St"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==5 & street_precleanedhn=="22nd St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="22nd St"

*W 19th St in Ancestry; SM has NW 19th St
browse if clean_priority==5 & overall_match=="NW 19th St"
replace stname_flag="W 19th St" if clean_priority==5 & overall_match=="NW 19th St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="NW 19th St"
replace checked_hn="c" if clean_priority==5 & overall_match=="NW 19th St"

*W Romana St in Ancestry; SM matches
browse if clean_priority==5 & overall_match=="Romana St"
replace st_edit="W Romana St" if clean_priority==5 & overall_match=="Romana St"
replace checked_st="c" if clean_priority==5 & overall_match=="Romana St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Romana St"

*California St in Ancestry; SM matches
browse if clean_priority==5 & street_precleanedhn=="seeline-76"
replace st_edit="California St" if clean_priority==5 & street_precleanedhn=="seeline-76"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="seeline-76"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="seeline-76"

*Fixed hns
browse if clean_priority==5 & overall_match=="Camaron St"
replace hn_edit=606 if clean_priority==5 & overall_match=="Camaron St" & image_id=="4548183_00572"
replace hn_edit=608 if clean_priority==5 & overall_match=="Camaron St" & image_id=="4548183_00573"
replace hn_flag="608 r" if clean_priority==5 & overall_match=="Camaron St" & image_id=="4548183_00573"
replace checked_st="c, ambiguous" if clean_priority==5 & overall_match=="Camaron St" & hn==215
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="Camaron St" & hn==215
replace checked_st="c" if clean_priority==5 & overall_match=="Camaron St" & checked_st==""
replace checked_hn="c" if clean_priority==5 & overall_match=="Camaron St" & checked_hn==""

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Rossy St"
replace checked_st="c" if clean_priority==5 & overall_match=="Rossy St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Rossy St"

*W Quincy in Ancestry; SM has Quincy St
browse if clean_priority==5 & street_precleanedhn=="W Quincy"
replace st_edit="W Quincy St" if clean_priority==5 & street_precleanedhn=="W Quincy"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="W Quincy"
replace stname_flag="Quincy St" if clean_priority==5 & street_precleanedhn=="W Quincy"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W Quincy"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Main Ave"
replace checked_st="c" if clean_priority==5 & overall_match=="Main Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Main Ave"

*Fixed hns
browse if clean_priority==5 & overall_match=="Lewis St"
replace hn_edit=108 if clean_priority==5 & overall_match=="Lewis St"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Lewis St"
replace checked_st="c" if clean_priority==5 & overall_match=="Lewis St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Lewis St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Augusta St"
replace hn_edit=415 if clean_priority==5 & overall_match=="Augusta St"
replace hn_flag="415 rear" if clean_priority==5 & overall_match=="Augusta St" & line_num>54
replace checked_st="c" if clean_priority==5 & overall_match=="Augusta St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Augusta St"

*Can't read street name
browse if clean_priority==5 & image_id=="4548183_00686"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548183_00686"
replace checked_hn="c" if clean_priority==5 & image_id=="4548183_00686"

*Hard to read but looks like Camden in Ancestry; SM has Camden St and Aly
browse if clean_priority==5 & street_precleanedhn=="Granden"
replace hn_edit=319 if clean_priority==5 & street_precleanedhn=="Granden" & line_num>47
replace hn_flag="319 rear" if clean_priority==5 & street_precleanedhn=="Granden"  & line_num>47
replace st_edit="Camden" if clean_priority==5 & street_precleanedhn=="Granden"
replace stname_flag="Camden St/Aly" if clean_priority==5 & street_precleanedhn=="Granden"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Granden"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Granden"

*E Quincy in Ancestry; Quincy St in SM
browse if clean_priority==5 & image_id=="4548183_00703"
replace st_edit="E Quincy St" if clean_priority==5 & image_id=="4548183_00703"
replace stname_flag="Quincy St" if clean_priority==5 & image_id=="4548183_00703" 
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & image_id=="4548183_00703"
replace checked_hn="c" if clean_priority==5 & image_id=="4548183_00703"

*No st name. Could be N St Marys St but not sure
browse if clean_priority==5 & image_id=="4548183_00709"
replace stname_flag="N St Marys St" if clean_priority==5 & image_id=="4548183_00709"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548183_00709"
replace checked_hn="c" if clean_priority==5 & image_id=="4548183_00709"

*Erie St in Ancestry; SM has Erie Ave
browse if clean_priority==5 & street_precleanedhn=="Erie St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Erie St"
replace stname_flag="Erie Ave" if clean_priority==5 & street_precleanedhn=="Erie St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Erie St"

*No st name. Could be N St Marys but not sure
browse if clean_priority==5 & image_id=="4548183_00730"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548183_00730"
replace stname_flag="N St Marys St" if clean_priority==5 & image_id=="4548183_00730"
replace checked_hn="c" if clean_priority==5 & image_id=="4548183_00730"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Claiborne Ct"
replace checked_st="c" if clean_priority==5 & overall_match=="Claiborne Ct"
replace checked_hn="c" if clean_priority==5 & overall_match=="Claiborne Ct"

*No st name. Could be Baltimore Ave but not sure
browse if clean_priority==5 & image_id=="4548183_00738"
replace stname_flag="Baltimore Ave" if clean_priority==5 & image_id=="4548183_00738"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548183_00738"
replace checked_hn="c" if clean_priority==5 & image_id=="4548183_00738"

*Not sure if Polk St or W Josephine St
browse if clean_priority==5 & overall_match=="Polk St"
replace stname_flag="W Josephine St" if clean_priority==5 & overall_match=="Polk St" & line_num>13
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Polk St"
replace checked_st="c, ambiguous" if clean_priority==5 & overall_match=="Polk St" & line_num>13
replace checked_hn="c" if clean_priority==5 & overall_match=="Polk St"

*Fixed hn
browse if clean_priority==5 & overall_match=="E Park Ave"
replace hn_edit=121 if clean_priority==5 & overall_match=="E Park Ave"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="E Park Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="E Park Ave"

*10/2
*Fixed hns
browse if clean_priority==5 & overall_match=="E Elmira St"
replace hn_edit=317 if clean_priority==5 & overall_match=="E Elmira St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="E Elmira St"
replace checked_hn="c" if clean_priority==5 & overall_match=="E Elmira St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Jones Ave"
replace checked_st="c" if clean_priority==5 & overall_match=="Jones Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Jones Ave"

*E Evergreen in Ancestry; SM has Evergreen St
browse if clean_priority==5 & overall_match=="Evergreen St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="Evergreen St"
replace stname_flag="E Evergreen" if clean_priority==5 & overall_match=="Evergreen St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Evergreen St"

*Atlanta in Ancestry; SM has Atlanta Ave
browse if clean_priority==5 & street_precleanedhn=="Altanta"
replace st_edit="Atlanta Ave" if clean_priority==5 & street_precleanedhn=="Altanta"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Altanta"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Altanta"

*Fixed hns
browse if clean_priority==5 & overall_match=="Warren St"
replace hn_edit=301 if clean_priority==5 & overall_match=="Warren St" & line_num>45
replace hn_flag="AP 1" if clean_priority==5 & overall_match=="Warren St" & line_num>45
replace hn_flag="AP 2" if clean_priority==5 & overall_match=="Warren St" & line_num>48
replace hn_edit=212 if clean_priority==5 & overall_match=="Warren St" & line_num<10
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Warren St" & line_num<10
replace checked_hn="c, multi-unit" if clean_priority==5 & overall_match=="Warren St" & line_num>45
replace checked_hn="c" if clean_priority==5 & overall_match=="Warren St" & line_num<10
replace checked_st="c" if clean_priority==5 & overall_match=="Warren St"

*Howard St in Ancestry; matches SM
browse if clean_priority==5 & overall_match=="Howard St"
replace hn_edit=505 if clean_priority==5 & overall_match=="Howard St" & image_id=="4548183_00907"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="Howard St" & image_id=="4548183_00939"
replace st_edit="Main Ave" if clean_priority==5 & overall_match=="Howard St" & image_id=="4548183_00940"
replace checked_st="c" if clean_priority==5 & overall_match=="Howard St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Howard St" & checked_hn==""

*N Main St in Ancestry; SM has Main Ave
browse if clean_priority==5 & street_precleanedhn=="N Main St"
replace stname_flag="Main Ave" if clean_priority==5 & street_precleanedhn=="N Main St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="N Main St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="N Main St"

*W Cypress St in Ancestry; Cypress St in SM
browse if clean_priority==5 & street_precleanedhn=="E Eypress"
replace st_edit="W Cypress St" if clean_priority==5 & street_precleanedhn=="E Eypress"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="E Eypress"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="E Eypress"
replace stname_flag="Cypress St" if clean_priority==5 & street_precleanedhn=="E Eypress"

*Jackson in Ancestry; Jackson St in SM
browse if clean_priority==5 & overall_match=="Jackson St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Jackson St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Jackson St"

*Russell Pl in Ancestry; W Russell Pl in SM
browse if clean_priority==5 & overall_match=="W Russell Pl"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="W Russell Pl"
replace stname_flag="Russell Pl" if clean_priority==5 & overall_match=="W Russell Pl"
replace checked_hn="c" if clean_priority==5 & overall_match=="W Russell Pl"

*No street name in Ancestry;
browse if clean_priority==5 & image_id=="4548184_00036"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548184_00036"
replace checked_hn="c" if clean_priority==5 & image_id=="4548184_00036"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Ogden St"
replace checked_st="c" if clean_priority==5 & overall_match=="Ogden St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Ogden St"

*Ogden St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Odgen"
replace st_edit="Ogden St" if clean_priority==5 & street_precleanedhn=="Odgen"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Odgen"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Odgen"

*Breeden Ave in SM; Ancestry looks very similar
browse if clean_priority==5 & overall_match=="Breeden Ave"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Breeden Ave"
replace checked_st="c" if clean_priority==5 & overall_match=="Breeden Ave" & hn>1000
replace checked_hn="c" if clean_priority==5 & overall_match=="Breeden Ave"

*Blanco Road in Ancestry; SM has Blanco St
browse if clean_priority==5 & street_precleanedhn=="Blonco Road"
replace st_edit="Blanco Road" if clean_priority==5 & street_precleanedhn=="Blonco Road"
replace stname_flag="Blanco St" if clean_priority==5 & street_precleanedhn=="Blonco Road"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Blonco Road"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Blonco Road"

*Looks lile Breeden in Ancestry; SM has Breeden Ave
browse if clean_priority==5 & street_precleanedhn=="Bruden"
replace st_edit="Breeden Ave" if clean_priority==5 & street_precleanedhn=="Bruden"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Bruden"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Bruden"

*San Pedro in Ancestry; SM has San Pedro Ave
browse if clean_priority==5 & overall_match=="San Pedro Ave"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="San Pedro Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="San Pedro Ave"

*Looks like Belknap Pl, which matches SM
browse if clean_priority==5 & street_precleanedhn=="Bel Hiugh Pl"
replace st_edit="Belknap Pl" if clean_priority==5 & street_precleanedhn=="Bel Hiugh Pl"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Bel Hiugh Pl"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Bel Hiugh Pl"

*E Gramercy in Ancestry; SM has E Gramercy Pl
browse if clean_priority==5 & overall_match=="E Gramercy Pl"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="E Gramercy Pl"
replace checked_hn="c" if clean_priority==5 & overall_match=="E Gramercy Pl"

*Hildebrand in Ancestry; SM has W Hildebrand Ave
browse if clean_priority==5 & street_precleanedhn=="Hilderbrand"
replace st_edit="Hildebrand Ave" if clean_priority==5 & street_precleanedhn=="Hilderbrand"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Hilderbrand"
replace stname_flag="W Hildebrand Ave" if clean_priority==5 & street_precleanedhn=="Hilderbrand"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Hilderbrand"

*W Aganier in Ancestry; SM has Aganier Ave
browse if clean_priority==5 & street_precleanedhn=="W Aganier"
replace st_edit="W Aganier Ave" if clean_priority==5 & street_precleanedhn=="W Aganier"
replace stname_flag="Aganier Ave" if clean_priority==5 & street_precleanedhn=="W Aganier"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="W Aganier"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W Aganier"

*Ridgewood St in Ancestry; SM has W Ridgewood Ct
browse if clean_priority==5 & street_precleanedhn=="Redge Wood"
replace st_edit="Ridgewood St" if clean_priority==5 & street_precleanedhn=="Redge Wood"
replace stname_flag="W Ridgewood Ct" if clean_priority==5 & street_precleanedhn=="Redge Wood"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Redge Wood"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Redge Wood"

browse if clean_priority==5 & street_precleanedhn=="Redgewood St"
replace st_edit="Ridgewood St" if clean_priority==5 & street_precleanedhn=="Redgewood St"
replace stname_flag="W Ridgewood Ct" if clean_priority==5 & street_precleanedhn=="Redgewood St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Redgewood St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Redgewood St"

*Hollywood St in Ancestry; SM has Hollywood Ave
browse if clean_priority==5 & street_precleanedhn=="Hallywood St"
replace st_edit="Hollywood St" if clean_priority==5 & street_precleanedhn=="Hallywood St"
replace stname_flag="Hollywood Ave" if clean_priority==5 & street_precleanedhn=="Hallywood St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Hallywood St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Hallywood St"

*W Elsmere Ave in Ancestry; SM has Elsmere Pl
browse if clean_priority==5 & street_precleanedhn=="W Alsmare Ave"
replace st_edit="W Elsmere Ave" if clean_priority==5 & street_precleanedhn=="W Alsmare Ave"
replace stname_flag="Elsmere Pl" if clean_priority==5 & street_precleanedhn=="W Alsmare Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="W Alsmare Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W Alsmare Ave"

*Hollywood in Ancestry; SM has Hollywood Ave in neighboring EDs
browse if clean_priority==5 & street_precleanedhn=="Hollywood"
replace st_edit="Hollywood Ave" if clean_priority==5 & street_precleanedhn=="Hollywood"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==5 & street_precleanedhn=="Hollywood"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Hollywood"

*Los Angeles Ave in Ancestry; SM has Los Angeles St
browse if clean_priority==5 & street_precleanedhn=="Lee Angelia Ave"
replace st_edit="Los Angeles Ave" if clean_priority==5 & street_precleanedhn=="Lee Angelia Ave"
replace stname_flag="Los Angeles St" if clean_priority==5 & street_precleanedhn=="Lee Angelia Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Lee Angelia Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Lee Angelia Ave"

*Looks like Parkmoor Ct in Ancestry; SM does not have anything similar
browse if clean_priority==5 & street_precleanedhn=="Parkmoor Ch"
replace hn_edit=107 if clean_priority==5 & street_precleanedhn=="Parkmoor Ch" & hn==187
replace st_edit="Parkmoor Ct" if clean_priority==5 & street_precleanedhn=="Parkmoor Ch"
replace checked_st="c, ancestry match, SM missing" if clean_priority==5 & street_precleanedhn=="Parkmoor Ch"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Parkmoor Ch"

*SM has Beal St in ED 215 instead of 214
browse if clean_priority==5 & overall_match=="Beal St"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==5 & overall_match=="Beal St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Beal St"

*Seems address was changed
browse if clean_priority==5 & street_precleanedhn=="Saint clair now changel to 155"
replace hn_edit=450 if clean_priority==5 & street_precleanedhn=="Saint clair now changel to 155"
replace st_edit="St Clair St" if clean_priority==5 & street_precleanedhn=="Saint clair now changel to 155"
replace stname_flag="Changed to 1550 Cullwood?" if clean_priority==5 & street_precleanedhn=="Saint clair now changel to 155"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Saint clair now changel to 155"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Saint clair now changel to 155"

*W Kings Hwy in Ancestry; SM has Kings Hy St
browse if clean_priority==5 & street_precleanedhn=="W ??"
replace st_edit="W Kings Hwy" if clean_priority==5 & street_precleanedhn=="W ??"
replace stname_flag="Kings Hy St" if clean_priority==5 & street_precleanedhn=="W ??"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="W ??"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W ??"

*Louise St and Fredericksburg Road match SM
browse if clean_priority==5 & overall_match=="Louise St"
replace st_edit="Fredericksburg Road" if clean_priority==5 & overall_match=="Louise St" & hn>1000
replace checked_st="c" if clean_priority==5 & overall_match=="Louise St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Louise St"

*W Mulberry in Ancestry; SM has W Mulberry Ave
browse if clean_priority==5 & image_id=="4548184_00568"
replace st_edit="W Mulberry Ave" if clean_priority==5 & image_id=="4548184_00568"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & image_id=="4548184_00568"
replace checked_hn="c" if clean_priority==5 & image_id=="4548184_00568"

*10/3
*Home Ave in Ancestry; Home St in SM
browse if clean_priority==5 & street_precleanedhn=="Home Ave"
replace st_edit="Home Ave" if clean_priority==5 & street_precleanedhn=="Home Ave"
replace stname_flag="Home St" if clean_priority==5 & street_precleanedhn=="Home Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Home Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Home Ave"

browse if clean_priority==5 & overall_match=="Home St"
replace st_edit="Home Ave" if clean_priority==5 & overall_match=="Home St"
replace stname_flag="Home St" if clean_priority==5 & overall_match=="Home St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & overall_match=="Home St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Home St"

*Looks like Paschal Ave in Ancestry; SM has Paschal St
browse if clean_priority==5 & street_precleanedhn=="Caschal Ave"
replace st_edit="Paschal Ave" if clean_priority==5 & street_precleanedhn=="Caschal Ave"
replace stname_flag="Paschal St" if clean_priority==5 & street_precleanedhn=="Caschal Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Caschal Ave"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Caschal Ave" & hn==120
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Caschal Ave"

*W Josephine in Ancestry; SM has W Josephine St
browse if clean_priority==5 & overall_match=="W Josephine St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="W Josephine St"
replace checked_hn="c" if clean_priority==5 & overall_match=="W Josephine St"

*Paschal in Ancestry; SM has Paschal St
browse if clean_priority==5 & overall_match=="Paschal St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Paschal St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Paschal St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Thelma Drive"
replace checked_st="c" if clean_priority==5 & overall_match=="Thelma Drive"
replace checked_hn="c" if clean_priority==5 & overall_match=="Thelma Drive"

*Gillespie in Ancestry ED 84; SM has Gillespie St in ED 83 
browse if clean_priority==5 & street_precleanedhn=="Gillespie"
replace st_edit="Gillespie St" if clean_priority==5 & street_precleanedhn=="Gillespie"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==5 & street_precleanedhn=="Gillespie"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Gillespie"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="E Summit Ave"
replace checked_st="c" if clean_priority==5 & overall_match=="E Summit Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="E Summit Ave"

*Looks like Carlton in Ancestry; SM has Carleton Ave
browse if clean_priority==5 & street_precleanedhn=="Cartoton"
replace st_edit="Carleton Ave" if clean_priority==5 & street_precleanedhn=="Cartoton"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Cartoton"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Cartoton"

*Looks like Fourth St in Ancestry; SM has 4th St in diff ED
browse if clean_priority==5 & overall_match=="4th St"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==5 & overall_match=="4th St"
replace checked_hn="c" if clean_priority==5 & overall_match=="4th St"

*E Martin in Ancestry; SM has Martin St
browse if clean_priority==5 & street_precleanedhn=="E Martice"
replace st_edit="E Martin St" if clean_priority==5 & street_precleanedhn=="E Martice"
replace stname_flag="Martin St" if clean_priority==5 & street_precleanedhn=="E Martice"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="E Martice"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="E Martice"

*Jefferson Hotel on 105 Jefferson; SM has Jefferson St
browse if clean_priority==5 & overall_match=="Jefferson St"
replace hn_edit=105 if clean_priority==5 & overall_match=="Jefferson St"
replace institution_edit="Jefferson Hotel" if clean_priority==5 & overall_match=="Jefferson St"
replace inst=1 if clean_priority==5 & overall_match=="Jefferson St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Jefferson St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Jefferson St"

*2660 Travis St (St Anthony Hotel) in Ancestry; SM has W Travis St
browse if clean_priority==5 & overall_match=="Travis St"
replace institution_edit="St Anthony Hotel" if clean_priority==5 & overall_match=="Travis St"
replace inst=1 if clean_priority==5 & overall_match=="Travis St"
replace checked_st="c" if clean_priority==5 & overall_match=="Travis St"
replace hn_edit=2660 if clean_priority==5 & overall_match=="Travis St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Travis St"

browse if clean_priority==5 & street_precleanedhn=="Saint Anthony Hotel"
replace st_edit="Travis St" if clean_priority==5 & street_precleanedhn=="Saint Anthony Hotel"
replace institution_edit="St Anthony Hotel" if clean_priority==5 & street_precleanedhn=="Saint Anthony Hotel"
replace inst=1 if clean_priority==5 & street_precleanedhn=="Saint Anthony Hotel"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Saint Anthony Hotel"
replace hn_edit=2660 if clean_priority==5 & street_precleanedhn=="Saint Anthony Hotel"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Saint Anthony Hotel"

*Looks like Bonham in Ancestry; SM has Bonham St
browse if clean_priority==5 & street_precleanedhn=="Bahnam"
replace st_edit="Bonham St" if clean_priority==5 & street_precleanedhn=="Bahnam"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Bahnam"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Bahnam"

*St Joseph College, could be on St Joseph St
browse if clean_priority==5 & image_id=="4548184_00808"
replace stname_flag="St Joseph St" if clean_priority==5 & image_id=="4548184_00808"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548184_00808"
replace checked_hn="c, ambiguous" if clean_priority==5 & image_id=="4548184_00808"

*Looks like E Crocket in Ancestry; SM has Crockett St
browse if clean_priority==5 & street_precleanedhn=="E Brochel"
replace st_edit="E Crockett St" if clean_priority==5 & street_precleanedhn=="E Brochel"
replace stname_flag="Crockett St" if clean_priority==5 & street_precleanedhn=="E Brochel"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="E Brochel"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="E Brochel"

*Some illegible words, but can see Broadway in Ancestry; SM has Broadway St
browse if clean_priority==5 & street_precleanedhn=="Trvi-Lee R Broaderray"
replace st_edit="Broadway St" if clean_priority==5 & street_precleanedhn=="Trvi-Lee R Broaderray"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Trvi-Lee R Broaderray"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Trvi-Lee R Broaderray"

*Looks like Nacogdoches in Ancestry; SM has Nacogdoches St 
browse if clean_priority==5 & street_precleanedhn=="Waergdackes"
replace st_edit="Nacogdoches St" if clean_priority==5 & street_precleanedhn=="Waergdackes"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Waergdackes"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Waergdackes"

*Zitts Aly in Ancestry; SM missing
browse if clean_priority==5 & street_precleanedhn=="Zitts Aly"
replace checked_st="c, ancestry match, SM missing" if clean_priority==5 & street_precleanedhn=="Zitts Aly"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Zitts Aly"

*Fixed hns
browse if clean_priority==5 & overall_match=="E Ave"
replace hn_edit=619 if clean_priority==5 & overall_match=="E Ave" & line_num<35
replace hn_flag="Rear 619" if clean_priority==5 & overall_match=="E Ave" & line_num<35
replace hn_edit=407 if clean_priority==5 & overall_match=="E Ave" & line_num>40
replace hn_flag="Rear 407" if clean_priority==5 & overall_match=="E Ave" & line_num>40
replace checked_st="c" if clean_priority==5 & overall_match=="E Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="E Ave"

*Can't read writing in hn field
browse if clean_priority==5 & overall_match=="Elm St"
replace hn_flag="? 321" if clean_priority==5 & overall_match=="Elm St" & line_num>56
replace checked_st="c" if clean_priority==5 & overall_match=="Elm St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Elm St"

*Broadway in Ancestry; SM has Broadway St
browse if clean_priority==5 & overall_match=="Broadway St"
replace hn_edit=510 if clean_priority==5 & overall_match=="Broadway St" & line_num<10
replace hn_flag="Rear 510" if clean_priority==5 & overall_match=="Broadway St" & line_num<10
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Broadway St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Broadway St" & line_num<10
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="Broadway St" & line_num>10

*10/4
*Fixed hns
browse if clean_priority==5 & overall_match=="B Ave"
replace hn_flag="Rear 607" if clean_priority==5 & overall_match=="B Ave"
replace hn_flag="Rear 603" if clean_priority==5 & overall_match=="B Ave" & line_num>70
replace hn_edit=607 if clean_priority==5 & overall_match=="B Ave" & line_num<70
replace hn_edit=603 if clean_priority==5 & overall_match=="B Ave" & line_num>80
replace checked_st="c" if clean_priority==5 & overall_match=="B Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="B Ave"

*Fixed hns, some cases do not have line numbers
browse if clean_priority==5 & overall_match=="5th St"
replace hn_flag="Rear 206" if clean_priority==5 & overall_match=="5th St"
replace hn_edit=206 if clean_priority==5 & overall_match=="5th St"
replace stname_flag="POSSIBLE DELETE" if clean_priority==5 & overall_match=="5th St" & hhid==""
replace checked_st="c" if clean_priority==5 & overall_match=="5th St"
replace checked_hn="c" if clean_priority==5 & overall_match=="5th St"

*12th St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Tevelfth St"
replace st_edit="12th St" if clean_priority==5 & street_precleanedhn=="Tevelfth St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Tevelfth St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Tevelfth St"

*Ave A in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Av A"
replace st_edit="A Ave" if clean_priority==5 & street_precleanedhn=="Av A"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Av A"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Av A"

*Multiple streets
browse if clean_priority==5 & image_id=="4548184_00987"
replace st_edit="Grand Ave" if clean_priority==5 & image_id=="4548184_00987" & line_num<40
replace st_edit="B Ave" if clean_priority==5 & image_id=="4548184_00987" & line_num>39 & line_num<44
replace hn_edit=1423 if clean_priority==5 & image_id=="4548184_00987" & line_num==40
replace hn_edit=1403 if clean_priority==5 & image_id=="4548184_00987" & line_num==42
replace st_edit="Oak St" if clean_priority==5 & image_id=="4548184_00987" & line_num>43
replace st_edit="N Alamo St" if clean_priority==5 & image_id=="4548184_00987" & line_num==46
replace hn_edit=336 if clean_priority==5 & image_id=="4548184_00987" & line_num==44
replace hn_edit=1419 if clean_priority==5 & image_id=="4548184_00987" & line_num==46
replace hn_edit=336 if clean_priority==5 & image_id=="4548184_00987" & line_num==49
replace checked_st="c" if clean_priority==5 & image_id=="4548184_00987" & line_num<44
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & image_id=="4548184_00987" & line_num>43
replace checked_hn="c" if clean_priority==5 & image_id=="4548184_00987"

*Claremont Ave in Ancestry; SM has Claremont St
browse if clean_priority==5 & overall_match=="Claremont St"
replace st_edit="Claremont Ave" if clean_priority==5 & overall_match=="Claremont St"
replace stname_flag="Claremont St" if clean_priority==5 & overall_match=="Claremont St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & overall_match=="Claremont St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Claremont St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Brackenridge Ave"
replace checked_st="c" if clean_priority==5 & overall_match=="Brackenridge Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Brackenridge Ave"

*Fixed hns
browse if clean_priority==5 & overall_match=="Post Ave"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Post Ave"
replace hn_edit=274 if clean_priority==5 & overall_match=="Post Ave" & line_num>80
replace hn_edit=276 if clean_priority==5 & overall_match=="Post Ave" & line_num>90
replace hn_edit=282 if clean_priority==5 & overall_match=="Post Ave" & line_num>95
replace checked_st="c" if clean_priority==5 & overall_match=="Post Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Post Ave"

*A Ave in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="H Ave"
replace st_edit="A Ave" if clean_priority==5 & street_precleanedhn=="H Ave"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="H Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="H Ave"

*James in Ancestry; SM has James St
browse if clean_priority==5 & overall_match=="James St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="James St"
replace checked_hn="c" if clean_priority==5 & overall_match=="James St"

*Looks like Newell Ave in Ancestry; matches SM
browse if clean_priority==5 & overall_match=="Newell Ave"
replace hn_edit=311 if clean_priority==5 & overall_match=="Newell Ave" & hn==1311
replace checked_st="c" if clean_priority==5 & overall_match=="Newell Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Newell Ave"

*Looks like Booker St; SM has Booker Aly
browse if clean_priority==5 & street_precleanedhn=="Burpee St"
replace hn_edit=hn_edit-100 if clean_priority==5 & street_precleanedhn=="Burpee St"
replace st_edit="Booker St" if clean_priority==5 & street_precleanedhn=="Burpee St"
replace stname_flag="Booker Aly" if clean_priority==5 & street_precleanedhn=="Burpee St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Burpee St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Burpee St"

*Looks like Eda Al; SM has Eda St
browse if clean_priority==5 & street_precleanedhn=="Edy Aly"
replace st_edit="Eda Aly" if clean_priority==5 & street_precleanedhn=="Edy Aly"
replace stname_flag="Eda St" if clean_priority==5 & street_precleanedhn=="Edy Aly"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Edy Aly"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Edy Aly"

*E Crockett St in Ancestry; SM has Crockett St
browse if clean_priority==5 & overall_match=="Crockett St"
replace st_edit="E Crockett St" if clean_priority==5 & overall_match=="Crockett St"
replace stname_flag="Crockett St" if clean_priority==5 & overall_match=="Crockett St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="Crockett St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Crockett St"

*Looks like Hackberry St in Ancestry; SM has N Hackberry St
browse if clean_priority==5 & street_precleanedhn=="Hackbert St"
replace st_edit="Hackberry St" if clean_priority==5 & street_precleanedhn=="Hackbert St"
replace stname_flag="N Hackberry St" if clean_priority==5 & street_precleanedhn=="Hackbert St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Hackbert St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Hackbert St"

*Looks like Brown Aly; SM has Brown St
browse if clean_priority==5 & street_precleanedhn=="Broom Aly"
replace st_edit="Brown Aly" if clean_priority==5 & street_precleanedhn=="Broom Aly"
replace stname_flag="Brown St" if clean_priority==5 & street_precleanedhn=="Broom Aly"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Broom Aly"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Broom Aly"

*N Mesquite in Ancestry; SM has N Mesquite St
browse if clean_priority==5 & image_id=="4548185_00055"
replace st_edit="N Mesquite St" if clean_priority==5 & image_id=="4548185_00055"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & image_id=="4548185_00055"
replace checked_hn="c" if clean_priority==5 & image_id=="4548185_00055"

*Center St in Ancestry; SM has N Centre St
browse if clean_priority==5 & street_precleanedhn=="Penter"
replace st_edit="Center St" if clean_priority==5 & street_precleanedhn=="Penter"
replace stname_flag="N Centre St" if clean_priority==5 & street_precleanedhn=="Penter"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Penter"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Penter"

*Fixed hns
browse if clean_priority==5 & overall_match=="Duval St"
replace hn_edit=108 if clean_priority==5 & overall_match=="Duval St" & line_num>62
replace checked_st="c" if clean_priority==5 & overall_match=="Duval St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Duval St"

*One street name illegible, other is Sherman. SM has Sherman St
browse if clean_priority==5 & street_precleanedhn=="Chesnut St"
replace st_edit="Sherman St" if clean_priority==5 & street_precleanedhn=="Chesnut St" & line_num>4
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Chesnut St" & line_num<5
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Chesnut St" & line_num>4
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Chesnut St"

*Ninth St in Ancestry; SM has 9th St
browse if clean_priority==5 & overall_match=="9th St"
replace checked_st="c" if clean_priority==5 & overall_match=="9th St"
replace checked_hn="c" if clean_priority==5 & overall_match=="9th St"

*Can't read hns
browse if clean_priority==5 & overall_match=="Austin St"
replace checked_st="c" if clean_priority==5 & overall_match=="Austin St"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="Austin St"

*Fixed hns
browse if clean_priority==5 & overall_match=="N Pine St"
replace hn_edit=1403 if clean_priority==5 & overall_match=="N Pine St"
replace checked_st="c" if clean_priority==5 & overall_match=="N Pine St"
replace checked_hn="c" if clean_priority==5 & overall_match=="N Pine St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="N Mesquite St" & checked_st==""
replace checked_st="c" if clean_priority==5 & overall_match=="N Mesquite St" & checked_st==""
replace checked_hn="c" if clean_priority==5 & overall_match=="N Mesquite St"

*Grayson St in Ancestry; SM matches
browse if clean_priority==5 & street_precleanedhn=="Grayson"
replace hn_edit=527 if clean_priority==5 & street_precleanedhn=="Grayson" & hn==537
replace st_edit="Grayson St" if clean_priority==5 & street_precleanedhn=="Grayson"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Grayson"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Grayson"

*Can't read street names
browse if clean_priority==5 & street_precleanedhn=="W??"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="W??"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W??"

*Carson St in Ancestry; W Carson St in SM
browse if clean_priority==5 & street_precleanedhn=="Carstain"
replace st_edit="Carson St" if clean_priority==5 & street_precleanedhn=="Carstain"
replace stname_flag="W Carson St" if clean_priority==5 & street_precleanedhn=="Carstain"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Carstain"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Carstain"

browse if clean_priority==5 & street_precleanedhn=="Casson St"
replace st_edit="Carson St" if clean_priority==5 & street_precleanedhn=="Casson St"
replace stname_flag="W Carson St" if clean_priority==5 & street_precleanedhn=="Casson St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Casson St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Casson St"

*Fixed hns
browse if clean_priority==5 & overall_match=="W Carson St"
replace hn_edit=310 if clean_priority==5 & overall_match=="W Carson St"
replace checked_st="c" if clean_priority==5 & overall_match=="W Carson St"
replace checked_hn="c" if clean_priority==5 & overall_match=="W Carson St"

*Burr Road in Ancestry; matches SM
browse if clean_priority==5 & overall_match=="Burr Road"
replace checked_st="c" if clean_priority==5 & overall_match=="Burr Road"
replace checked_st="c, ambiguous" if clean_priority==5 & overall_match=="Burr Road" & line_num==5
replace checked_hn="c" if clean_priority==5 & overall_match=="Burr Road"

*Hard to read but looks like 112 Groveland Pl
browse if clean_priority==5 & overall_match=="Groveland Pl"
replace hn_edit=112 if clean_priority==5 & overall_match=="Groveland Pl"
replace checked_st="c" if clean_priority==5 & overall_match=="Groveland Pl"
replace checked_hn="c" if clean_priority==5 & overall_match=="Groveland Pl"

*Looks like Catalpa in Ancestry; SM has Catalpa St
browse if clean_priority==5 & overall_match=="Catalpa St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Catalpa St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Catalpa St"

*Looks like Natalen Ave; SM has Natalen St
browse if clean_priority==5 & street_precleanedhn=="Matalm Ave"
replace st_edit="Natalen Ave" if clean_priority==5 & street_precleanedhn=="Matalm Ave"
replace stname_flag="Natalen St" if clean_priority==5 & street_precleanedhn=="Matalm Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Matalm Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Matalm Ave"

*10/5
*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Pinckney St"
replace checked_st="c" if clean_priority==5 & overall_match=="Pinckney St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Pinckney St"

*Tilden St in diff ED in SM
browse if clean_priority==5 & overall_match=="Tilden St"
*Added hn_flag values
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==5 & overall_match=="Tilden St"
replace checked_hn="c, multi-unit" if clean_priority==5 & overall_match=="Tilden St"

*Can't fully read st name and can't find similar st in SM
browse if clean_priority==5 & street_precleanedhn=="Andersons St"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Andersons St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Andersons St"

*New Braunfels in Ancestry; SM has N New Braunfels Ave
browse if clean_priority==5 & street_precleanedhn=="New Brampelo"
replace st_edit="New Braunfels Ave" if clean_priority==5 & street_precleanedhn=="New Brampelo"
replace stname_flag="N New Braunfels Ave" if clean_priority==5 & street_precleanedhn=="New Brampelo"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="New Brampelo"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="New Brampelo"

*Runnells St in Ancestry; SM has Runnels Ave in nearby EDs
browse if clean_priority==5 & street_precleanedhn=="Runnells St"
replace stname_flag="Runnels Ave" if clean_priority==5 & street_precleanedhn=="Runnells St"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==5 & street_precleanedhn=="Runnells St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Runnells St"

*No st name in Ancestry
browse if clean_priority==5 & image_id=="4548185_00499"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548185_00499"
replace checked_hn="c" if clean_priority==5 & image_id=="4548185_00499"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Ervin St"
replace checked_st="c" if clean_priority==5 & overall_match=="Ervin St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Ervin St"

*Hard to read but could be Bee St
browse if clean_priority==5 & street_precleanedhn=="B R St"
replace st_edit="Bee St" if clean_priority==5 & street_precleanedhn=="B R St"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="B R St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="B R St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Roper St"
replace checked_st="c" if clean_priority==5 & overall_match=="Roper St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Roper St"

*New Braunfels Ave in Ancestry; SM has N New Braunfels Ave
browse if clean_priority==5 & street_precleanedhn=="Gen Braunfels Ave"
replace st_edit="New Braunfels Ave" if clean_priority==5 & street_precleanedhn=="Gen Braunfels Ave"
replace stname_flag="N New Braunfels Ave" if clean_priority==5 & street_precleanedhn=="Gen Braunfels Ave"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Gen Braunfels Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Gen Braunfels Ave"

*Can't read hn
browse if clean_priority==5 & overall_match=="Mason St"
replace checked_st="c" if clean_priority==5 & overall_match=="Mason St"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="Mason St"

*Seguin Road in Ancestry; SM has Seguin St
browse if clean_priority==5 & street_precleanedhn=="Sequin Road"
replace st_edit="Seguin Road" if clean_priority==5 & street_precleanedhn=="Sequin Road"
replace stname_flag="Seguin St" if clean_priority==5 & street_precleanedhn=="Sequin Road"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Sequin Road"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Sequin Road"

browse if clean_priority==5 & street_precleanedhn=="105th"
replace st_edit="Seguin Road" if clean_priority==5 & street_precleanedhn=="105th"
replace stname_flag="Seguin St" if clean_priority==5 & street_precleanedhn=="105th"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="105th"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="105th"

*Looks like Crosby in Ancestry; SM has Crosby St
browse if clean_priority==5 & street_precleanedhn=="Crosley"
replace st_edit="Crosby St" if clean_priority==5 & street_precleanedhn=="Crosley"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Crosley"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Crosley"

*Duval in Ancestry; SM has Duval St
browse if clean_priority==5 & street_precleanedhn=="Dewal"
replace st_edit="Duval St" if clean_priority==5 & street_precleanedhn=="Dewal"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Dewal"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Dewal"

*No street name. Could be Spofford Ave but not sure
browse if clean_priority==5 & image_id=="4548185_00629"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548185_00629"
replace stname_flag="Spofford Ave" if clean_priority==5 & image_id=="4548185_00629"
replace checked_hn="c" if clean_priority==5 & image_id=="4548185_00629"

*Pierce in Ancestry; SM has Pierce Ave
browse if clean_priority==5 & street_precleanedhn=="Pince"
replace st_edit="Pierce Ave" if clean_priority==5 & street_precleanedhn=="Pince"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Pince"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Pince"

browse if clean_priority==5 & overall_match=="Pierce Ave"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Pierce Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Pierce Ave"

*Looks like Golita in Ancestry; SM has Golita St
browse if clean_priority==5 & image_id=="4548185_00653" | clean_priority==5 & image_id=="4548185_00654"
replace st_edit="Golita St" if clean_priority==5 & image_id=="4548185_00653" | clean_priority==5 & image_id=="4548185_00654"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & image_id=="4548185_00653" | clean_priority==5 & image_id=="4548185_00654"
replace checked_hn="c" if clean_priority==5 & image_id=="4548185_00653" | clean_priority==5 & image_id=="4548185_00654"

*Looks like Winslow St, which matches SM
browse if clean_priority==5 & street_precleanedhn=="Wenston St"
replace st_edit="Winslow St" if clean_priority==5 & street_precleanedhn=="Wenston St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Wenston St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Wenston St"

*Pierce St in Ancestry; SM has Pierce Ave
browse if clean_priority==5 & street_precleanedhn=="Peerce St"
replace st_edit="Pierce St" if clean_priority==5 & street_precleanedhn=="Peerce St"
replace stname_flag="Pierce Ave" if clean_priority==5 & street_precleanedhn=="Peerce St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Peerce St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Peerce St"

browse if clean_priority==5 & street_precleanedhn=="Piner St"
replace st_edit="Pierce St" if clean_priority==5 & street_precleanedhn=="Piner St"
replace stname_flag="Pierce Ave" if clean_priority==5 & street_precleanedhn=="Piner St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Piner St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Piner St"

*Looks like it could be Muncey St, which matches SM
browse if clean_priority==5 & street_precleanedhn=="Memery St"
replace st_edit="Muncey St" if clean_priority==5 & street_precleanedhn=="Memery St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Memery St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Memery St"

*N Pine St in Ancestry; matches SM
browse if clean_priority==5 & overall_match=="Milam St"
replace st_edit="N Pine St" if clean_priority==5 & overall_match=="Milam St"
replace checked_st="c" if clean_priority==5 & overall_match=="Milam St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Milam St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Decatur Aly"
replace checked_st="c" if clean_priority==5 & overall_match=="Decatur Aly"
replace checked_hn="c" if clean_priority==5 & overall_match=="Decatur Aly"

*Alder Aly in Ancestry; SM has Alder St
browse if clean_priority==5 & street_precleanedhn=="Alder Aly"
replace stname_flag="Alder St" if clean_priority==5 & street_precleanedhn=="Alder Aly"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Alder Aly"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Alder Aly"

*10/12
*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Gibson St"
replace checked_st="c" if clean_priority==5 & overall_match=="Gibson St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Gibson St"

*N Gevers in Ancestry; SM has N Gevers St
browse if clean_priority==5 & overall_match=="N Gevers St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="N Gevers St" 
replace checked_hn="c" if  clean_priority==5 & overall_match=="N Gevers St"

*St Martins St in Ancestry; SM has St Martin St
browse if clean_priority==5 & street_precleanedhn=="Martins St"
replace st_edit="St Martins St" if clean_priority==5 & street_precleanedhn=="Martins St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Martins St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Martins St"
replace stname_flag="St Martin St" if clean_priority==5 & street_precleanedhn=="Martins St"

browse if clean_priority==5 & overall_match=="St Martin St"
replace st_edit="St Martins St" if clean_priority==5 & overall_match=="St Martin St"
replace checked_st="c" if clean_priority==5 & overall_match=="St Martin St"
replace checked_hn="c" if clean_priority==5 & overall_match=="St Martin St"
replace stname_flag="St Martin St" if clean_priority==5 & overall_match=="St Martin St"

*Looks like Lockhart St; matches SM
browse if clean_priority==5 & street_precleanedhn=="Packhurst St"
replace st_edit="Lockhart St" if clean_priority==5 & street_precleanedhn=="Packhurst St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Packhurst St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Packhurst St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Logan St"
replace checked_st="c" if clean_priority==5 & overall_match=="Logan St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Logan St"

*Hayes St in Ancestry; SM has Hays St
browse if clean_priority==5 & overall_match=="Mayes St"
replace st_edit="Hayes St" if clean_priority==5 & overall_match=="Mayes St"
replace stname_flag="Hays St" if clean_priority==5 & overall_match=="Mayes St"
replace checked_st="c" if clean_priority==5 & overall_match=="Mayes St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Mayes St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Polaris St"
replace checked_st="c" if clean_priority==5 & overall_match=="Polaris St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Polaris St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Eross St"
replace checked_st="c" if clean_priority==5 & overall_match=="Eross St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Eross St"

*Looks like Walters St in Ancestry; SM has N Walters St
browse if clean_priority==5 & street_precleanedhn=="Watha St"
replace hn_flag="410 Rear" if clean_priority==5 & street_precleanedhn=="Watha St" & line_num>30
replace st_edit="Walters St" if clean_priority==5 & street_precleanedhn=="Watha St"
replace stname_flag="N Walters St" if clean_priority==5 & street_precleanedhn=="Watha St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Watha St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Watha St"

*Looks like Lincoln Park in Ancestry; missing in SM
browse if clean_priority==5 & street_precleanedhn=="Lencoln Park"
replace st_edit="Lincoln Park" if clean_priority==5 & street_precleanedhn=="Lencoln Park"
replace checked_st="c, ancestry match, SM missing" if clean_priority==5 & street_precleanedhn=="Lencoln Park"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Lencoln Park"

*Hard to read but could be E Commerce St; matches SM
browse if clean_priority==5 & street_precleanedhn=="E ?? St"
replace st_edit="E Commerce St" if clean_priority==5 & street_precleanedhn=="E ?? St"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="E ?? St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="E ?? St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Gorman St"
replace hn_edit=316 if clean_priority==5 & overall_match=="Gorman St"
replace checked_st="c" if clean_priority==5 & overall_match=="Gorman St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Gorman St"

*Looks like Lockhart St; matches SM
browse if clean_priority==5 & street_precleanedhn=="Lockeal St"
replace st_edit="Lockhart St" if clean_priority==5 & street_precleanedhn=="Lockeal St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Lockeal St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Lockeal St"

*Looks like N Polaris; SM has Polaris St
browse if clean_priority==5 & street_precleanedhn=="N Palosis"
replace st_edit="N Polaris St" if clean_priority==5 & street_precleanedhn=="N Palosis"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="N Palosis"
replace stname_flag="Polaris St" if clean_priority==5 & street_precleanedhn=="N Palosis"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="N Palosis"

*Saint James in Ancestry; St James St in SM
browse if clean_priority==5 & street_precleanedhn=="Saint James"
replace st_edit="St James St" if clean_priority==5 & street_precleanedhn=="Saint James"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Saint James"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Saint James"

*Fixed hns
browse if clean_priority==5 & overall_match=="N Centre St"
replace hn_edit=1105 if clean_priority==5 & overall_match=="N Centre St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="N Centre St"
replace checked_hn="c" if clean_priority==5 & overall_match=="N Centre St"

*Fixed hns
browse if clean_priority==5 & overall_match=="Garfield Aly"
replace hn_edit=307 if clean_priority==5 & overall_match=="Garfield Aly"
replace hn_flag=hn_raw if clean_priority==5 & overall_match=="Garfield Aly"
replace checked_st="c" if clean_priority==5 & overall_match=="Garfield Aly"
replace checked_hn="c" if clean_priority==5 & overall_match=="Garfield Aly"

*Looks like St Catherine in Ancestry; SM has St Catherine St
browse if clean_priority==5 & street_precleanedhn=="Noathems"
replace st_edit="St Catherine St" if clean_priority==5 & street_precleanedhn=="Noathems"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Noathems"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Noathems"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Santa Clara St"
replace checked_st="c" if clean_priority==5 & overall_match=="Santa Clara St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Santa Clara St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Delaware St"
replace checked_st="c" if clean_priority==5 & overall_match=="Delaware St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Delaware St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Boerne St"
replace checked_st="c" if clean_priority==5 & overall_match=="Boerne St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Boerne St"

*Delaware St in Ancestry; matches SM
browse if clean_priority==5 & overall_match=="Labor St"
replace st_edit="Delaware St" if clean_priority==5 & overall_match=="Labor St"
replace checked_st="c" if clean_priority==5 & overall_match=="Labor St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Labor St"

*Hard to read but could be Hoefgen Ave which matches SM
browse if clean_priority==5 & street_precleanedhn=="?? Ave"
replace st_edit="Hoefgen Ave" if clean_priority==5 & street_precleanedhn=="?? Ave"
replace checked_st="c,ambiguous" if clean_priority==5 & street_precleanedhn=="?? Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="?? Ave"

*Hard to read but could be S Mesquite St which matches SM
browse if clean_priority==5 & street_precleanedhn=="S Maratta"
replace st_edit="S Mesquite St" if clean_priority==5 & street_precleanedhn=="S Maratta"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="S Maratta"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Maratta"

*Hard to tell which street is which; could be Montana St which matches SM
browse if clean_priority==5 & street_precleanedhn=="S Mas"
replace st_edit="Montana St" if clean_priority==5 & street_precleanedhn=="S Mas"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="S Mas"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Mas"

*Mills Aly and Nebraska in Ancestry; match SM
browse if clean_priority==5 & overall_match=="Mills Aly"
replace st_edit="Nebraska St" if clean_priority==5 & overall_match=="Mills Aly" & hn==220
replace checked_st="c" if clean_priority==5 & overall_match=="Mills Aly"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Mills Aly" & hn==220
replace checked_hn="c" if clean_priority==5 & overall_match=="Mills Aly"

*S Monumental in Ancestry; SM has S Monumental St
browse if clean_priority==5 & street_precleanedhn=="E Monumental"
replace st_edit="S Monumental St" if clean_priority==5 & street_precleanedhn=="E Monumental"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="E Monumental"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="E Monumental"

*Gravel St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Draves"
replace st_edit="Gravel St" if clean_priority==5 & street_precleanedhn=="Draves"
*Fixed hns
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Draves"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Draves"

*Fixed hns
browse if clean_priority==5 & overall_match=="E Commerce St"
replace hn_edit=1702 if clean_priority==5 & overall_match=="E Commerce St"
replace hn_flag="1702 1/2 apt 3" if clean_priority==5 & overall_match=="E Commerce St" & line_num<55
replace hn_flag="1702 1/2 apt 4" if clean_priority==5 & overall_match=="E Commerce St" & line_num>54
replace checked_st="c" if clean_priority==5 & overall_match=="E Commerce St"
replace checked_hn="c" if clean_priority==5 & overall_match=="E Commerce St"

*Can't read one street name; other st is Montana St which matches SM
browse if clean_priority==5 & street_precleanedhn=="NW Me??"
replace st_edit="Montana St" if clean_priority==5 & street_precleanedhn=="NW Me??" & hn==1401
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="NW Me??" & hn==108
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="NW Me??" & hn==1401
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="NW Me??"

*Maryland St in Ancestry; SM has Maryland Ave
browse if clean_priority==5 & street_precleanedhn=="Mayland St"
replace stname_flag="Maryland Ave" if clean_priority==5 & street_precleanedhn=="Mayland St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Mayland St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Mayland St"

browse if clean_priority==5 & overall_match=="Maryland Ave"
replace hn_flag="REAR 113" if clean_priority==5 & overall_match=="Maryland Ave" & line_num>75 & line_num<79
replace st_edit="Maryland St" if clean_priority==5 & overall_match=="Maryland Ave"
replace stname_flag="Maryland Ave" if clean_priority==5 & overall_match=="Maryland Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & overall_match=="Maryland Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Maryland Ave"

*S Mittman in Ancestry; SM has Mittman St
browse if clean_priority==5 & street_precleanedhn=="S Mattman"
replace st_edit="S Mittman St" if clean_priority==5 & street_precleanedhn=="S Mattman"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="S Mattman"
replace stname_flag="Mittman St" if clean_priority==5 & street_precleanedhn=="S Mattman"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Mattman"

*10/16
*Vargas St and Dakota St in Ancestry; match SM
browse if clean_priority==5 & street_precleanedhn=="Itargar St"
replace hn_edit=117 if clean_priority==5 & street_precleanedhn=="Itargar St" & hn==107
replace st_edit="Vargas St" if clean_priority==5 & street_precleanedhn=="Itargar St" & hn==107
replace st_edit="Dakota St" if clean_priority==5 & street_precleanedhn=="Itargar St" & hn==1715
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Itargar St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Itargar St"

*Connelley St in Ancestry; SM has Connally St
browse if clean_priority==5 & street_precleanedhn=="Connelley"
replace st_edit="Connelley St" if clean_priority==5 & street_precleanedhn=="Connelley"
replace stname_flag="Connally St" if clean_priority==5 & street_precleanedhn=="Connelley"
replace checked_st="c, ancestry match, SM missing" if clean_priority==5 & street_precleanedhn=="Connelley"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Connelley"

*Vargas St in Ancestry; matches SM, but no hn
browse if clean_priority==5 & street_precleanedhn=="Garzas St"
replace st_edit="Vargas St" if clean_priority==5 & street_precleanedhn=="Garzas St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Garzas St"
replace checked_hn="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Garzas St"

*Vargas St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Varzas"
replace st_edit="Vargas St" if clean_priority==5 & street_precleanedhn=="Varzas"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Varzas"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Varzas"

*Nebraska St in Ancestry; matches SM but no hn
browse if clean_priority==5 & overall_match=="Nebraska St"
replace checked_st="c" if clean_priority==5 & overall_match=="Nebraska St"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="Nebraska St"

*Culpepper St in Ancestry; SM has similar Culpeper St in diff ED
browse if clean_priority==5 & street_precleanedhn=="Culpepper St"
replace stname_flag="Culpeper St" if clean_priority==5 & street_precleanedhn=="Culpepper St"
replace checked_st="c, ancestry match, SM diff ED" if clean_priority==5 & street_precleanedhn=="Culpepper St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Culpepper St"

*Del Rio in Ancestry; SM has Del Rio St
browse if clean_priority==5 & overall_match=="Del Rio St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Del Rio St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Del Rio St"

*Government in Ancestry; SM has Government St
browse if clean_priority==5 & overall_match=="Government St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Government St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Government St"

*Grimes in Ancestry but no hn; SM has Grimes St
browse if clean_priority==5 & overall_match=="Grimes St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Grimes St"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="Grimes St"

*Walnut St in Ancestry; SM has S Walnut St
browse if clean_priority==5 & street_precleanedhn=="Walmit St"
replace st_edit="Walnut St" if clean_priority==5 & street_precleanedhn=="Walmit St"
replace stname_flag="S Walnut St" if clean_priority==5 & street_precleanedhn=="Walmit St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Walmit St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Walmit St"

*Indiana St in Ancestry; matches SM
browse if clean_priority==5 & image_id=="4548186_00620"
replace st_edit="Indiana St" if clean_priority==5 & image_id=="4548186_00620"
replace hn_edit=708 if clean_priority==5 & image_id=="4548186_00620" & line_num==51
replace checked_st="c" if clean_priority==5 & image_id=="4548186_00620"
replace checked_hn="c" if clean_priority==5 & image_id=="4548186_00620"

*Delaware St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Al??"
replace st_edit="Delaware St" if clean_priority==5 & street_precleanedhn=="Al??"
replace hn_edit=1014 if clean_priority==5 & street_precleanedhn=="Al??"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Al??"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Al??"

*Piedmont St in Ancestry; SM has Piedmont Ave
browse if clean_priority==5 & street_precleanedhn=="Predmont St"
replace st_edit="Piedmont St" if clean_priority==5 & street_precleanedhn=="Predmont St"
replace stname_flag="Piedmont Ave" if clean_priority==5 & street_precleanedhn=="Predmont St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Predmont St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Predmont St"

*N New Braunfels Ave in Ancestry; SM has S as direction
browse if clean_priority==5 & street_precleanedhn=="N Braunfels Ave"
replace st_edit="N New Braunfels Ave" if clean_priority==5 & street_precleanedhn=="N Braunfels Ave"
replace stname_flag="S New Braunfels Ave" if clean_priority==5 & street_precleanedhn=="N Braunfels Ave"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="N Braunfels Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="N Braunfels Ave"

*S Pine in Ancestry; SM has S Pine St
browse if clean_priority==5 & street_precleanedhn=="W Pine"
replace st_edit="S Pine St" if clean_priority==5 & street_precleanedhn=="W Pine"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="W Pine"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W Pine"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="S Walters St"
replace checked_st="c" if clean_priority==5 & overall_match=="S Walters St"
replace checked_hn="c" if clean_priority==5 & overall_match=="S Walters St"

*S Mittman in Ancestry; SM has Mittman St
browse if clean_priority==5 & street_precleanedhn=="Witman"
replace st_edit="S Mittman St" if clean_priority==5 & street_precleanedhn=="Witman"
replace stname_flag="Mittman St" if clean_priority==5 & street_precleanedhn=="Witman"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Witman"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Witman"

*No street name, could be Nopal St
browse if clean_priority==5 & image_id=="4548186_00805"
replace stname_flag="Nopal St" if clean_priority==5 & image_id=="4548186_00805"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548186_00805"
replace checked_hn="c, ambiguous" if clean_priority==5 & image_id=="4548186_00805"

*St matches Ancestry and SM; hn is unclear
browse if clean_priority==5 & overall_match=="Ranger St"
replace hn_flag="No no." if clean_priority==5 & overall_match=="Ranger St"
replace checked_st="c" if clean_priority==5 & overall_match=="Ranger St"
replace checked_hn="c, ambiguous" if clean_priority==5 & overall_match=="Ranger St"

*Hackberry St in Ancestry; SM has S Hackberry St
browse if clean_priority==5 & overall_match=="S Hackberry St"
replace st_edit="Hackberry St" if clean_priority==5 & overall_match=="S Hackberry St"
replace stname_flag="S Hackberry St" if clean_priority==5 & overall_match=="S Hackberry St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="S Hackberry St"
replace checked_hn="c" if clean_priority==5 & overall_match=="S Hackberry St"

*Drexel in Ancestry; SM has Drexel Ave
browse if clean_priority==5 & overall_match=="Drexel Ave"
replace hn_edit=443 if clean_priority==5 & overall_match=="Drexel Ave"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Drexel Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="Drexel Ave"

*St Anthony in Ancestry; SM has St Anthony Ave
browse if clean_priority==5 & overall_match=="St Anthony Ave"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="St Anthony Ave"
replace checked_hn="c" if clean_priority==5 & overall_match=="St Anthony Ave"

*Adele in Ancestry; SM has Adele St
browse if clean_priority==5 & overall_match=="Adele St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Adele St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Adele St"

*Can't make out street name
browse if clean_priority==5 & street_precleanedhn=="H??H"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="H??H"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="H??H"

*10/17
*Clark Ave in Ancestry; SM has Clarke St
browse if clean_priority==5 & street_precleanedhn=="Clark Ave"
replace stname_flag="Clarke St" if clean_priority==5 & street_precleanedhn=="Clark Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Clark Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Clark Ave"

*Ancestry has both Highland and Warwick Blvd; both match SM
browse if clean_priority==5 & street_precleanedhn=="highland blvd 4 warwick Ave"
replace st_edit="Warwick Blvd" if clean_priority==5 & street_precleanedhn=="highland blvd 4 warwick Ave"
replace stname_flag="Highland Blvd" if clean_priority==5 & street_precleanedhn=="highland blvd 4 warwick Ave"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="highland blvd 4 warwick Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="highland blvd 4 warwick Ave"

*S Presa St in Ancestry; SM has Presa St
browse if clean_priority==5 & street_precleanedhn=="S Presa St"
replace st_edit="S Presa St" if clean_priority==5 & street_precleanedhn=="S Presa St"
replace stname_flag="Presa St" if clean_priority==5 & street_precleanedhn=="S Presa St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="S Presa St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Presa St"

*Avant St in Ancestry; SM has Avant Ave
browse if clean_priority==5 & street_precleanedhn=="Avant St"
replace stname_flag="Avant Ave" if clean_priority==5 & street_precleanedhn=="Avant St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Avant St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Avant St"

*S Presa St in Ancestry; SM has Presa St
browse if clean_priority==5 & overall_match=="S Pine St"
replace st_edit="S Presa St" if clean_priority==5 & overall_match=="S Pine St"
replace stname_flag="Presa St" if clean_priority==5 & overall_match=="S Pine St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="S Pine St"
replace checked_hn="c" if clean_priority==5 & overall_match=="S Pine St"

*Looks like Steves Ave in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Steaco Ave"
replace st_edit="Steves Ave" if clean_priority==5 & street_precleanedhn=="Steaco Ave"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Steaco Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Steaco Ave"

*White St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Lohit St"
replace st_edit="White St" if clean_priority==5 & street_precleanedhn=="Lohit St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Lohit St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Lohit St"

*Fixed hn. Image ID is off
browse if clean_priority==5 & overall_match=="Mahucke Ct"
replace hn_edit=157 if clean_priority==5 & overall_match=="Mahucke Ct"
replace checked_st="c" if clean_priority==5 & overall_match=="Mahucke Ct"
replace checked_hn="c" if clean_priority==5 & overall_match=="Mahucke Ct"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Ada St"
replace checked_st="c" if clean_priority==5 & overall_match=="Ada St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Ada St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="S Cherry St"
replace checked_st="c" if clean_priority==5 & overall_match=="S Cherry St"
replace checked_hn="c" if clean_priority==5 & overall_match=="S Cherry St"

*No st or hn
browse if clean_priority==5 & street_precleanedhn=="facing north-block 125"
*Manually removed hn_edits
replace hn_flag="None" if clean_priority==5 & street_precleanedhn=="facing north-block 125"
replace stname_flag=street_precleanedhn if clean_priority==5 & street_precleanedhn=="facing north-block 125"
replace st_edit="" if clean_priority==5 & street_precleanedhn=="facing north-block 125"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="facing north-block 125"
replace checked_hn="c, ambiguous" if clean_priority==5 & street_precleanedhn=="facing north-block 125"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Miller St"
replace checked_st="c" if clean_priority==5 & overall_match=="Miller St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Miller St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="S Gevers St"
replace checked_st="c" if clean_priority==5 & overall_match=="S Gevers St"
replace checked_hn="c" if clean_priority==5 & overall_match=="S Gevers St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Cosgrove St"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & overall_match=="Cosgrove St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Cosgrove St"

*Water St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Waton St"
replace st_edit="Water St" if clean_priority==5 & street_precleanedhn=="Waton St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Waton St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Waton St"

*Looks like Rusk St in Ancestry; matches SM
browse if clean_priority==5 & overall_match=="Rusk St"
replace checked_st="c" if clean_priority==5 & overall_match=="Rusk St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Rusk St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Market St"
replace checked_st="c" if clean_priority==5 & overall_match=="Market St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Market St"

*Rusk St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Rank St"
replace st_edit="Rusk St" if clean_priority==5 & street_precleanedhn=="Rank St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Rank St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Rank St"

*Rusk St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Rush St"
replace st_edit="Rusk St" if clean_priority==5 & street_precleanedhn=="Rush St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Rush St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Rush St"

*Plaza Hotel; no st or hn
browse if clean_priority==5 & street_precleanedhn=="Plaza Hotel"
replace inst=1 if clean_priority==5 & street_precleanedhn=="Plaza Hotel"
replace institution_edit="Plaza Hotel" if clean_priority==5 & street_precleanedhn=="Plaza Hotel"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Plaza Hotel"
replace checked_hn="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Plaza Hotel"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Johnson St"
replace checked_st="c" if clean_priority==5 & overall_match=="Johnson St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Johnson St"

*S Alamo and S Presa in Ancestry; SM has S Alamo St and Presa St
browse if clean_priority==5 & street_precleanedhn=="Alama"
replace st_edit="S Alamo St" if clean_priority==5 & street_precleanedhn=="Alama"
replace st_edit="S Presa St" if clean_priority==5 & street_precleanedhn=="Alama" & line_num==22
*Manually fixed hn_edits
replace stname_flag="Presa St" if clean_priority==5 & street_precleanedhn=="Alama" & line_num==22
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Alama"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Alama" & line_num==22
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Alama"

*No st name
browse if clean_priority==5 & image_id=="4548187_00234"
replace checked_st="c, ambiguous" if clean_priority==5 & image_id=="4548187_00234"
replace checked_hn="c" if clean_priority==5 & image_id=="4548187_00234"

*10_18
*E Guenther in Ancestry; SM has E Guenther St
browse if clean_priority==5 & street_precleanedhn=="203rd"
replace st_edit="E Guenther St" if clean_priority==5 & street_precleanedhn=="203rd"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="203rd"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="203rd"

*Fixed hns
browse if clean_priority==5 & street_precleanedhn=="Stieren St"
replace hn_edit=406 if clean_priority==5 & street_precleanedhn=="Stieren St" & line_num>67
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Stieren St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Stieren St"
replace checked_hn="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Stieren St" & line_num>69

*Ancestry has S St Marys; SM has S St Marys St
browse if clean_priority==5 & street_precleanedhn=="S Saint Marys"
replace st_edit="S St Marys St" if clean_priority==5 & street_precleanedhn=="S Saint Marys"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="S Saint Marys"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Saint Marys"

*S Presa in Ancestry; SM has Presa St
browse if clean_priority==5 & street_precleanedhn=="S Presa" & checked_st==""
replace hn_edit=1311 if clean_priority==5 & street_precleanedhn=="S Presa" & checked_st==""
replace st_edit="S Presa St" if clean_priority==5 & street_precleanedhn=="S Presa" & checked_st==""
replace stname_flag="Presa St" if clean_priority==5 & street_precleanedhn=="S Presa" & checked_st==""
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="S Presa" & checked_st==""
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Presa" & checked_st==""

*Vitra St in Ancestry; SM has Vitra Pl
browse if clean_priority==5 & overall_match=="Vitra Pl"
replace hn_edit=140 if clean_priority==5 & overall_match=="Vitra Pl"
replace st_edit="Vitra St" if clean_priority==5 & overall_match=="Vitra Pl"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & overall_match=="Vitra Pl"
replace checked_hn="c" if clean_priority==5 & overall_match=="Vitra Pl"

*Vitra St and Marne St in Ancestry; SM has Vitra Pl and Marne St
browse if clean_priority==5 & street_precleanedhn=="Litra St"
replace st_edit="Vitra St" if clean_priority==5 & street_precleanedhn=="Litra St" & line_num<5
replace st_edit="Marne St" if clean_priority==5 & street_precleanedhn=="Litra St" & line_num>5
replace stname_flag="Vitra Pl" if clean_priority==5 & street_precleanedhn=="Litra St" & line_num<5
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Litra St" & line_num<5
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Litra St" & line_num>5
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Litra St" & line_num<5
replace checked_hn="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Litra St" & line_num>5

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Simpson St"
replace checked_st="c" if clean_priority==5 & overall_match=="Simpson St"
replace checked_hn="c" if clean_priority==5 & overall_match=="Simpson St"

*Lowell Ave and Roosevelt Ave in Ancestry; SM has Lowell St and Roosevelt Ave
browse if clean_priority==5 & street_precleanedhn=="Lowell Ave"
replace st_edit="Roosevelt Ave" if clean_priority==5 & street_precleanedhn=="Lowell Ave" & line_num>93
replace st_edit="Lowell St" if clean_priority==5 & street_precleanedhn=="Lowell Ave" & line_num<94
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Lowell Ave"
replace hn_edit=310 if clean_priority==5 & street_precleanedhn=="Lowell Ave" & line_num>93
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Lowell Ave"

*Looks like Whittier St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="W Whellery St"
replace st_edit="Whittier St" if clean_priority==5 & street_precleanedhn=="W Whellery St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="W Whellery St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="W Whellery St"

*Matches Ancestry and SM
browse if clean_priority==5 & overall_match=="Baity Ct"
replace checked_st="c" if clean_priority==5 & overall_match=="Baity Ct"
replace checked_hn="c" if clean_priority==5 & overall_match=="Baity Ct"

*Alamosa St in Ancestry; SM has Alamosa Ave
browse if clean_priority==5 & street_precleanedhn=="Alamasa St"
replace st_edit="Alamosa St" if clean_priority==5 & street_precleanedhn=="Alamasa St"
replace stname_flag="Alamosa Ave" if clean_priority==5 & street_precleanedhn=="Alamasa St"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Alamasa St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Alamasa St"

*Hard to read but looks like S Presa St in Ancestry; SM has Presa St
browse if clean_priority==5 & street_precleanedhn=="Saint Dresa St"
replace st_edit="S Presa St" if clean_priority==5 & street_precleanedhn=="Saint Dresa St"
replace stname_flag="Presa St" if clean_priority==5 & street_precleanedhn=="Saint Dresa St"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="Saint Dresa St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Saint Dresa St"

*St name illegible
browse if clean_priority==5 & street_precleanedhn=="Mill Hill"
replace stname_flag="E Mitchell St" if clean_priority==5 & street_precleanedhn=="Mill Hill"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Mill Hill"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Mill Hill"

*Looks like Concepcion Road in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Cow Copleville C R Road"
replace st_edit="Concepcion Road" if clean_priority==5 & street_precleanedhn=="Cow Copleville C R Road"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Cow Copleville C R Road"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Cow Copleville C R Road"

*Hicks Ave in Ancestry; SM has Hicks St
browse if clean_priority==5 & street_precleanedhn=="Saint Hicks Ave"
replace hn_edit=324 if clean_priority==5 & street_precleanedhn=="Saint Hicks Ave" & hn==374
replace st_edit="Hicks Ave" if clean_priority==5 & street_precleanedhn=="Saint Hicks Ave"
replace stname_flag="Hicks St" if clean_priority==5 & street_precleanedhn=="Saint Hicks Ave"
replace checked_st="c, ancestry match, SM diff type" if clean_priority==5 & street_precleanedhn=="Saint Hicks Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Saint Hicks Ave"

*S Presa in Ancestry; SM has Presa St
browse if clean_priority==5 & street_precleanedhn=="S Persa"
replace st_edit="S Presa St" if clean_priority==5 & street_precleanedhn=="S Persa"
replace stname_flag="Presa St" if clean_priority==5 & street_precleanedhn=="S Persa"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="S Persa"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Persa"

*Hard to read but could be S Presa. SM has Presa St
browse if clean_priority==5 & street_precleanedhn=="South Ter"
replace st_edit="S Presa St" if clean_priority==5 & street_precleanedhn=="South Ter"
replace stname_flag="Presa St" if clean_priority==5 & street_precleanedhn=="South Ter"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="South Ter"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="South Ter"

browse if clean_priority==5 & street_precleanedhn=="S Pressa"
replace st_edit="S Presa St" if clean_priority==5 & street_precleanedhn=="S Pressa"
replace stname_flag="Presa St" if clean_priority==5 & street_precleanedhn=="S Pressa"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & street_precleanedhn=="S Pressa"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="S Pressa"

*Parkview in Ancestry; SM has Park View Drive
browse if clean_priority==5 & street_precleanedhn=="Parkview Ave"
replace st_edit="Park View Drive" if clean_priority==5 & street_precleanedhn=="Parkview Ave"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_precleanedhn=="Parkview Ave"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Parkview Ave"

*No st name, unclear hns
browse if clean_priority==5 & image_id=="4548187_00414" & street_raw==""
replace stname_flag="Concepcion Road" if clean_priority==5 & image_id=="4548187_00414" & street_raw==""
replace hn_flag="?" if clean_priority==5 & image_id=="4548187_00414" & street_raw=="" & line_num>61
replace checked_st="c, ambiguous" if  lean_priority==5 & image_id=="4548187_00414" & street_raw==""
replace checked_hn="c" if clean_priority==5 & image_id=="4548187_00414" & street_raw=="" & line_num==60
replace checked_hn="c, ambiguous" if clean_priority==5 & image_id=="4548187_00414" & street_raw=="" & line_num>60

*Can't read st name
browse if clean_priority==5 & street_precleanedhn=="Rick Petal ??"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Rick Petal ??"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Rick Petal ??"

*Can't read st name
browse if clean_priority==5 & street_precleanedhn=="Para Par"
replace checked_st="c, ambiguous" if clean_priority==5 & street_precleanedhn=="Para Par"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Para Par"

*S Presa in Ancestry; SM has Presa St
browse if clean_priority==5 & overall_match=="Presa St" & image_id=="4548187_00439"
replace st_edit="S Presa St" if clean_priority==5 & overall_match=="Presa St" & image_id=="4548187_00439"
replace stname_flag="Presa St" if clean_priority==5 & overall_match=="Presa St" & image_id=="4548187_00439"
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & overall_match=="Presa St" & image_id=="4548187_00439"
replace checked_hn="c" if clean_priority==5 & overall_match=="Presa St" & image_id=="4548187_00439"

browse if clean_priority==5 & image_id=="4548187_00439" & street_raw==""
replace st_edit="S Presa St" if clean_priority==5 & image_id=="4548187_00439" & street_raw==""
replace stname_flag="Presa St" if clean_priority==5 & image_id=="4548187_00439" & street_raw==""
replace checked_st="c, ancestry match, SM diff dir" if clean_priority==5 & image_id=="4548187_00439" & street_raw==""
replace checked_hn="c" if clean_priority==5 & image_id=="4548187_00439" & street_raw==""

*Looks like Whiting in Ancestry; SM ha Whiting Ave
browse if clean_priority==5 & street_raw=="WITING"
replace st_edit="Whiting Ave" if clean_priority==5 & street_raw=="WITING"
replace checked_st="c, ancestry match, type from SM" if clean_priority==5 & street_raw=="WITING"
replace checked_hn="c" if clean_priority==5 & street_raw=="WITING"

*Naylor St in Ancestry; matches SM
browse if clean_priority==5 & street_precleanedhn=="Waytor St"
replace st_edit="Naylor St" if clean_priority==5 & street_precleanedhn=="Waytor St"
replace checked_st="c" if clean_priority==5 & street_precleanedhn=="Waytor St"
replace checked_hn="c" if clean_priority==5 & street_precleanedhn=="Waytor St"

*Done with Priority 5
*Priorities 1-5 all cleaned
