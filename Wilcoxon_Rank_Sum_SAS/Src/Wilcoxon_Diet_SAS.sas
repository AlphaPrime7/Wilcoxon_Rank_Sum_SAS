* author: Tingwei Adeck
* date: 2022-11-13
* purpose: Wilcoxon Rank Sum Test (Non-parametric paired t-test) analysis of Diet and athletic performance (distance ran)
* license: public domain
* Input: wilcoxon.sav
* Output: Wilcoxon_Diet_SAS.pdf
* Description: Understand the impact of diet on athletic performance (running)
* Results: Carb and protein diets are better than Carb only diet;

%let path=/home/u40967678/sasuser.v94;


libname disney
    "&path/sas_umkc/input";
    
filename wilcox
    "&path/sas_umkc/input/wilcoxon.sav";   
    
ods pdf file=
    "&path/sas_umkc/output/Wilcoxon_Diet_SAS.pdf";
    
options papersize=(8in 4in) nonumber nodate;

proc import file= wilcox
	out=disney.wilcox
	dbms=sav
	replace;
run;


title 'summary (first 10 obs) of diet choice data';
proc print data=disney.wilcox (obs=10);


/*create new dataset with difference between two diet treatments*/
data disney.wilcox_diff;
    set disney.wilcox;
    diet_diff=carb_protein-carb;
run;

/*perform Wilcoxon Signed Rank Test*/
title 'Wilcoxon signed rank test for diet_activity data';
proc univariate data=disney.wilcox_diff;
    var diet_diff;
run;

ods pdf close;
