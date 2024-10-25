		
log using wageoutput.log, replace		
		
*CPS sample for market productivities, Table B1, Table B2 and Figure B1
				
*HECKMAN SAMPLE		
		
set more off		
		
use cpsmar10.dta, clear 
		
keep h_hhnum h_idnum1 h_idnum2 gestcen hh5to18 hunder15 hunder18 hrpaidcc hhinc htotval hpctcut hearnval hinc_ws hwsval  fspouidx ftot_r ftotval fearnval finc_ws fwsval fownu6 fownu18 prcitshp prdtrace a_sex a_age age1 pecohab a_maritl a_enrlw a_hga agi ptot_r ptotval a_lfsr a_wkstat prwkstat wexp earner ern_val pearnval a_hrlywk a_hrspay wsal_val wsal_yn ws_val a_grswk pehruslt a_uslhrs a_hrs1 hrswk wewkrs hrcheck wkcheck wrk_ck fedtax_ac fedtax_bc paidccyn ctc_crd actc_crd eit_cred marg_tax hea wkswork mjocc a_untype pemlr int_yn int_val		
		
keep if a_sex==2		
keep if a_age>=18 & a_age<50		
drop if a_maritl==1 | a_maritl==2		
keep if pecohab==-1		
keep if fownu18>0		
		
gen child6=0		
replace child6=1 if fownu6>0		
gen numkids6=fownu6		
gen numkids6sq=numkids6^2		
gen numkids18=fownu18		
gen numkids18sq=numkids18^2		
		
gen work=0		
replace work=1 if a_lfsr==1 | a_lfsr==2		
		
drop if a_lfsr==0		
gen badluck=0		
replace badluck=1 if a_lfsr==3 & a_untype~=3		
replace badluck=1 if a_lfsr==4 & a_untype~=3		
tab badluck if child6==1		
drop if badluck==1		
		
gen wage=.		
replace wage=a_hrspay if a_hrlywk==1 & a_lfsr==1 & earner==1		
replace wage=a_hrspay if a_hrlywk==1 & a_lfsr==2 & earner==1		
replace wage=pearnval/(hrswk*wkswork) if a_hrlywk==0 & pearnval>0 & hrswk>0 & a_lfsr==1  & earner==1 & wage==.		
replace wage=pearnval/(hrswk*wkswork) if a_hrlywk==0 & pearnval>0 & hrswk>0 & a_lfsr==2  & earner==1 & wage==.		
replace wage=wsal_val/(hrswk*wkswork) if a_hrlywk==0 & wsal_val>0 & hrswk>0 & a_lfsr==1 & earner==1 & wage==.		
replace wage=wsal_val/(hrswk*wkswork) if a_hrlywk==0 & wsal_val>0 & hrswk>0 & a_lfsr==2 & earner==1 & wage==.		
replace wage=ws_val/(hrswk*wkswork) if a_hrlywk==0 & ws_val>0 & a_lfsr==1 & earner==1 & hrswk>0  & wage==.		
replace wage=ws_val/(hrswk*wkswork) if a_hrlywk==0 & ws_val>0 & a_lfsr==2 & earner==1 & hrswk>0  & wage==.		
drop if work==1 & wage<=0		
drop if work==1 & wage==.		
		
gen lnwage=.		
replace lnwage=log(wage) if wage>0 & wage<=50		
		
gen health=0		
replace health=1 if hea==5		
replace health=2 if hea==4		
replace health=3 if hea==3		
replace health=4 if hea==2		
replace health=5 if hea==1		
		
gen age=a_age		
gen agesq=age^2		
gen educ=a_hga		
		
gen white=0		
replace white=1 if prdtrace==1		
gen black=0		
replace black=1 if prdtrace==2		
		
gen state=gestcen		
gen unem=0		
replace unem=8.2 if state==11		
replace unem=6.1 if state==12		
replace unem=6.4 if state==13		
replace unem=8.3 if state==14		
replace unem=11.7 if state==15		
replace unem=9.3 if state==16		
replace unem=8.6 if state==21		
replace unem=9.6 if state==22		
replace unem=8.5 if state==23		
replace unem=10 if state==31		
replace unem=10.1 if state==32		
replace unem=10.5 if state==33		
replace unem=12.7 if state==34		
replace unem=8.5 if state==35		
replace unem=7.3 if state==41		
replace unem=6.3 if state==42		
replace unem=9.4 if state==43		
replace unem=3.8 if state==44		
replace unem=5 if state==45		
replace unem=4.7 if state==46		
replace unem=7.2 if state==47		
replace unem=8 if state==51		
replace unem=7.8 if state==52		
replace unem=10.1 if state==53		
replace unem=6.9 if state==54		
replace unem=8.5 if state==55		
replace unem=10.9 if state==56		
replace unem=11.2 if state==57		
replace unem=10.2 if state==58		
replace unem=11.3 if state==59		
replace unem=10.2 if state==61		
replace unem=9.8 if state==62		
replace unem=9.5 if state==63		
replace unem=10.5 if state==64		
replace unem=7.9 if state==71		
replace unem=7.5 if state==72		
replace unem=6.9 if state==73		
replace unem=8.2 if state==74		
replace unem=6.9 if state==81		
replace unem=8.8 if state==82		
replace unem=7 if state==83		
replace unem=8.9 if state==84		
replace unem=7.9 if state==85		
replace unem=10.5 if state==86		
replace unem=8 if state==87		
replace unem=13.7 if state==88		
replace unem=9.9 if state==91		
replace unem=10.7 if state==92		
replace unem=12.4 if state==93		
replace unem=8 if state==94		
replace unem=6.9 if state==95		
			
compress		

*Table B1 Summary Statistics

sum age numkids6 numkids18 white black work child6
gen highschool=0
replace highschool=1 if educ==39
sum highschool
gen college=0
replace college=1 if educ>39
sum college
gen hours=0		
replace hours=hrswk*wkswork if hrswk>0 & wkswork>0
sum hours if hours>0
				
*Table B2 Wage equation		
				
xi: heckman lnwage age agesq i.educ numkids18 numkids18sq i.health white black unem i.state, sel(work = age agesq i.educ child6 numkids18 numkids18sq i.health white black unem i.state) twostep 		
predict workhat, xbsel		
gen t=child6		
replace child6=0		
predict workhatno, xbsel		
replace child6=t		
drop t		
gen mills=(normalden(workhat)-normalden(workhatno))/(normal(workhat)-normal(workhatno)) if work==0		
local lambda=e(lambda)		
		
predict lnwagehat		
gen logwage=lnwage		
replace logwage=lnwagehat+`lambda'*mills if work==0		
		
gen wagehat=exp(logwage)		
		
gen z=wage		
replace z=wagehat if work==0		
		
/*HISTOGRAMS*/		
		
keep if child6==1		
		
count if z>40		
drop if z>40		

* Figure B1	Wage distribution	
histogram z 
		
sum z 			
			
* Wage bins and corresponding labour hours for numerical exercises
			
foreach n of num 1/99{		
egen ptile`n'=pctile(z), p(`n')		
}		
		
gen wageq=0		
replace wageq=1		if z<=ptile2 
replace wageq=2		if z>ptile2 
replace wageq=3		if z>ptile4 
replace wageq=4		if z>ptile6 
replace wageq=5		if z>ptile8
replace wageq=6		if z>ptile10
replace wageq=7		if z>ptile12
replace wageq=8		if z>ptile14
replace wageq=9		if z>ptile16
replace wageq=10		if z>ptile18
replace wageq=11		if z>ptile20
replace wageq=12		if z>ptile22
replace wageq=13		if z>ptile24
replace wageq=14		if z>ptile26
replace wageq=15		if z>ptile28
replace wageq=16		if z>ptile30
replace wageq=17		if z>ptile32
replace wageq=18		if z>ptile34
replace wageq=19		if z>ptile36
replace wageq=20		if z>ptile38
replace wageq=21		if z>ptile40
replace wageq=22		if z>ptile42
replace wageq=23		if z>ptile44
replace wageq=24		if z>ptile46
replace wageq=25		if z>ptile48
replace wageq=26		if z>ptile50
replace wageq=27		if z>ptile52
replace wageq=28		if z>ptile54
replace wageq=29		if z>ptile56
replace wageq=30		if z>ptile58
replace wageq=31		if z>ptile60
replace wageq=32		if z>ptile62
replace wageq=33		if z>ptile64
replace wageq=34		if z>ptile66
replace wageq=35		if z>ptile68
replace wageq=36		if z>ptile70
replace wageq=37		if z>ptile72
replace wageq=38		if z>ptile74
replace wageq=39		if z>ptile76
replace wageq=40		if z>ptile78
replace wageq=41		if z>ptile80
replace wageq=42		if z>ptile82
replace wageq=43		if z>ptile84
replace wageq=44		if z>ptile86
replace wageq=45		if z>ptile88
replace wageq=46		if z>ptile90
replace wageq=47		if z>ptile92
replace wageq=48		if z>ptile94
replace wageq=49		if z>ptile96
replace wageq=50		if z>ptile98
		
foreach n of num 1/99{		
sum ptile`n'		
}		
		
foreach n of num 1/50{		
sum hours if hours>0 & wageq==`n'		
}		
		
log close
