

*Bring the dataset
*Change the directory according to your need
use "C:\Users\DELETE ME METTE\Desktop\thesis with stata\sample\model_data2.dta", clear

*DESCRIPTIVE STATISTICS
sum nonwhite age ed work earn if children == 0
sum nonwhite age ed work earn if children >= 1
sum nonwhite age ed work earn if children == 1
sum nonwhite age ed work earn if children >= 2

*GENERATE DUMMIES
gen child = 1 if children >= 1
replace child = 0 if children == 0

gen post1993 = 1 if year >= 1994
replace post1993 = 0 if year <= 1993

gen did=child*post1993

*sort data
bysort year child: egen workmean=mean(work)

twoway (line workmean year if child == 1) (line workmean year if child == 0)
gen work1991 = 1 if workmean | year == 1991
replace work1991 = 0 if year >= 1992
gen test = .5122606
twoway (line workmean year if child == 1) (line workmean year if child == 0) (line test year)


*Regression and sum with conditions
reg work child post1993 did, r
reg work child##post1993, r

sum work if children == 1 | post1993 == 1
sum work if children == 1 | post1993 == 0
gen child1 = 1 if children == 1
replace child1 = 0 if children == 0
gen did1=child1*post1993
reg work child1 post1993 did1, r

sum work if children >= 2 | post1993 == 1
sum work if children >= 2 | post1993 == 0
gen child2 = 1 if children >= 2
replace child2 = 0 if children == 0
gen did2=child2*post1993
reg work child2 post1993 did2, r

reg work child post1993 did, r
reg work urate child post1993 did, r
reg work nonwhite child post1993 did, r
reg work age child post1993 did, r
reg work ed child post1993 did, r
reg work urate nonwhite age ed child post1993 did, r

gen placeboyear = 1 if year == 1992 | year == 1993
replace placeboyear = 0 if year == 1991
gen postplacebo = child*placeboyear
reg work urate nonwhite age ed child placeboyear postplacebo, r
