libname home40 "Z:/Users/Matt/SanAntonio/Micro Data Files/1940"; run;
libname home30 "Z:/Users/Matt/SanAntonio/Micro Data Files/1930"; run;

*1930;
proc freq data=home30.SanAntonioTx_studauto_1930; tables self_empty_info_race; run;
data home30.sanantonio_tx_match30; set home30.SanAntonioTx_studauto_1930; run;
proc contents data=home30.sanantoniotx_studauto_1930; run;

*Clean Race Variables;
	data home30.sanantonio_tx_match30; set home30.sanantonio_tx_match30;
	self_empty_info_race=upcase(self_empty_info_race);
	self_empty_info_occupation=upcase(self_empty_info_occupation);

	length race30 $7;
	race30=self_empty_info_race;

	*Clean Race Variable;
	white=.;
	if self_empty_info_race='WHITE' | self_empty_info_race='W'  then white=1;
	if self_empty_info_race='WHITE' | self_empty_info_race='W'  then race30="WHITE";
	mexican=.;
	if self_empty_info_race='SPANI' | self_empty_info_race='MEXIC' | self_empty_info_race='M'  then mexican=1;
	if self_empty_info_race='SPANI' | self_empty_info_race='MEXIC' | self_empty_info_race='M'  then race30="MEXICAN";
	black=.;
	if self_empty_info_race='BLACK' | self_empty_info_race='COLOR' | self_empty_info_race='MULAT'
		| self_empty_info_race='NEGRO' | self_empty_info_race='QUADR' then black=1;
	if self_empty_info_race='BLACK' | self_empty_info_race='COLOR' | self_empty_info_race='MULAT'
		| self_empty_info_race='NEGRO' | self_empty_info_race='QUADR' then race30="BLACK";

	*Clean Occupation Variable;
	if (self_empty_info_occupation="SHELLS PECANS" | self_empty_info_occupation="SHELLING NUTS" |
	self_empty_info_occupation="SHELLER" | self_empty_info_occupation="NUT SHELLER" |
	self_empty_info_occupation="PECAN PICKER" | self_empty_info_occupation="NUT CRACKER" |
	self_empty_info_occupation="SHELLING PECANS" | self_empty_info_occupation="PECAN SHELLING") THEN self_empty_info_occupation="PECAN SHELLER";

	age_10f=age+11;
	age_10=age+10;
	age_10b=age+9;
	occupation30=self_empty_info_occupation;
	age30=age;
	f_name30=self_empty_name_given;
	l_name30=self_empty_name_surname;
	birthpl30=self_birth_place_empty;
	sex30=self_empty_info_gender;
	marry30=self_empty_info_maritalstatus;
	f_birthpl30=father_birth_place_empty;
	m_birthpl30=mother_birth_place_empty;
	birthyr30=general_pr_estimated_birth_year;
	attend30=general_attended_school;
	read_write30=general_able_to_read_and_write;
	english30=general_able_to_speak_english;
	serial30=serial;
	pid30=pid;
	relate30=self_empty_info_relationtohead;
	marst30=marst;
	lang_spoken30=general_language_spoken;
	natural30=general_naturalization;
	arrivedate30=self_arrival_date_year;
	empstat30=general_employment;
	own30=general_home_ownership;
	houseval30=general_value_of_home;
	st_preclean30=street_precleaned;
	st_original30=st;
	st_final30=autostud_street;
	hn_raw30=hn_raw;
	hn_auto30=hn_auto;
	hn30=hn;
	ed30=enumdist;
	block30=block_orig;
	mpcid30=mpcid;

	keep year serial30 pid30 race30 white black mexican 
	occupation30 age30 age_10f age_10 age_10b
	f_name30 l_name30 birthpl30 sex30 marry30
	f_birthpl30 m_birthpl30 birthyr30
	attend30 read_write30 english30
	relate30 marst30 lang_spoken30
	natural30 arrivedate30 empstat30
	own30 houseval30 st_preclean30 st_original30 st_final30
	hn30 hn_raw30 hn_auto30 ed30 block30 mpcid30;

	run;

	data home30.kids30; set home30.sanantonio_tx_match30;
	if 5<=age30<19;
	if attend30="Yes"; 
	run;

	proc freq data=home30.sanantonio_tx_match30; tables occupation30; run;
	proc freq data=home30.kids; tables self_empty_info_maritalstatus; run;

	PROC EXPORT DATA= HOME30.KIDS30
            OUTFILE= "Z:\Users\Matt\SanAntonio\Micro Data Files\1930\kids30.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
	RUN;

*1940;
proc contents data=home.SA_1940; run;
proc freq data=home40.SA_1940 noprint; tables general_occupation/out=occu; run;
