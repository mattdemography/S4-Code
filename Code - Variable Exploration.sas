libname home40 "Z:/Users/Matt/SanAntonio/StataFiles_Other/1940/Cleaning_micro_data"; run;
libname home30 "Z:/Users/Matt/SanAntonio/Micro Data Files/"; run;

libname test "C:/Users/mmarti24/Desktop"; run;

*1930;
proc freq data=home30.SA_1930; tables self_empty_info_race; run;

*Clean Race Variables;
	data white30; set home30.SA_1930;
	self_empty_info_race=upcase(self_empty_info_race);
	self_empty_info_occupation=upcase(self_empty_info_occupation);
	if self_empty_info_race='WHITE' then white=1;
	if white=1;
	run;
	data mex30; set home30.SA_1930;
	self_empty_info_race=upcase(self_empty_info_race);
	self_empty_info_occupation=upcase(self_empty_info_occupation);
	if (self_empty_info_race='MEXICAN' | self_empty_info_race='SPANISH') then mex=1;
	if mex=1;
	run;
	data black30; set home30.SA_1930;
	self_empty_info_race=upcase(self_empty_info_race);
	self_empty_info_occupation=upcase(self_empty_info_occupation);
	if (self_empty_info_race='NEGRO' | self_empty_info_race='BLACK')  then black=1;
	if black=1;
	run;

*Determine White Occupations;
	proc freq data=white30 noprint; tables self_empty_info_occupation/out=whoccu; run;
	*Remove Occupations with 5 or less;
	data whoccu; set whoccu;
	if count gt 5;
	run;
	proc sort data=whoccu; by count ; run;
	*Top Five - Salesman, Soldier, Teacher, Carpenter, Stenographer

*Determine black Occupations;
	proc freq data=black30 noprint; tables self_empty_info_occupation/out=bloccu; run;
	*Remove Occupations with 5 or less;
	data bloccu; set bloccu;
	if count gt 5;
	run;
	proc sort data=bloccu; by count ; run;
	*Top Five - Cook, Laborer, Laundress, Servant, Porter, Maid

*Determine Mexican Occupations;
	*Fix Shellers;
	data Mex30; set Mex30;
	if (self_empty_info_occupation="SHELLS PECANS" | self_empty_info_occupation="SHELLING NUTS" |
	self_empty_info_occupation="SHELLER" | self_empty_info_occupation="NUT SHELLER" |
	self_empty_info_occupation="PECAN PICKER" | self_empty_info_occupation="NUT CRACKER" |
	self_empty_info_occupation="SHELLING PECANS" | self_empty_info_occupation="PECAN SHELLING") THEN self_empty_info_occupation="PECAN SHELLER";
	run;
	proc freq data=mex30 noprint; tables self_empty_info_occupation/out=mexoccu; run;
	*Remove Occupations with 5 or less;
	data mexoccu; set mexoccu;
	if count gt 5;
	run;
	proc sort data=mexoccu; by count ; run;
	*Top Five - Laborer, Pecan Sheller, Seamstress, Truck Driver, Carpenter;

*Bring back race datasets into one;
	data all; set white30 black30 mex30; run;
*Data manipulation;
	data kids; set all;
	age=self_residence_info_age;
	age_10f=age+11;
	age_10=age+10;
	age_10b=age+9;
	f_name=self_empty_name_given;
	l_name=self_empty_name_surname;
	race=self_empty_info_race;
	birth=self_birth_place_empty;
	sex=self_empty_info_gender;
	marry=self_empty_info_maritalstatus;
	f_birthpl=father_birth_place_empty;
	m_birthpl=mother_birth_place_empty;
	birth=general_pr_estimated_birth_year;
	attend=general_attended_school;
	read_write=general_able_to_read_and_write;
	english=general_able_to_speak_english;
	occupation=self_empty_info_occupation;

	if 5<=age<19;
	if attend="Yes"; 

	keep serial age age_10f age10 age_10b f_name l_name race sex;

	run;

	proc freq data=kids; tables self_empty_info_maritalstatus; run;

*1940;
proc contents data=home.SA_1940; run;
proc freq data=home40.SA_1940 noprint; tables general_occupation/out=occu; run;
