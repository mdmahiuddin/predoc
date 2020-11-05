*Bring the dataset
*change your directory according to dataset locations. Or manually import the dataset
use "C:\Users\DELETE ME METTE\Desktop\thesis with stata\sample\model_data1.dta", clear
 

*Summary of whole dataset
summarize*
 
*final probit model
probit pat6 age csp cattle collegeeducation croplandacres spouseofffarm serviceissue infofd techacct

margins, dydx(*) atmeans

margins, dydx(*) 

estat classification 

poisson total6 age csp cattle collegeeducation croplandacres spouseofffarm serviceissue infofd techacct

margins, dydx(*) atmeans

margins, dydx(*) 

nbreg total6 age csp cattle collegeeducation croplandacres spouseofffarm serviceissue infofd techacct

margins, dydx(*) atmeans

margins, dydx(*)

* with robust standard error
probit pat6 age csp cattle collegeeducation croplandacres spouseofffarm serviceissue infofd techacct, vce(robust)
poisson total6 age csp cattle collegeeducation croplandacres spouseofffarm serviceissue infofd techacct, vce(robust)

*pearson statistic from poisson
glm total6 age csp cattle collegeeducation croplandacres spouseofffarm serviceissue infofd techacct, nolog family(poisson)
glm total6 age csp cattle collegeeducation croplandacres spouseofffarm serviceissue infofd techacct, nolog family(nbinomial ml)


*pairwise correlation
pwcorr age csp  collegeeducation cattle croplandacres spouseofffarm serviceissue infofd techacct


*summary of all variables
summarize pat6 total6 age csp collegeeducation cattle croplandacres spouseofffarm serviceissue infofd techacct


*new graph for age
recode age (min/30=1) (31/50=2) (51/70=3) (71/max=4), gen(age_group)
tabstat total6, by(age_group)
graph bar total6, over(age_group) name(age_vs_totaltech, replace)

*new graph for crop land acres
recode croplandacres (min/2500=1) (2501/5000=2) (5001/7500=3) (7501/max=4), gen(cropacre_group)
tabstat total6, by(cropacre_group)
graph bar total6, over(cropacre_group) name(cropland_total, replace)

*new graph for gross income
tabstat total6, by( gincome )
graph bar total6, over( gincome ) name( gincomevstotal, replace)


*new graph for education
tabstat total6, by( education )
graph bar total6, over(  education ) name(  educationvstotal, replace)

*new graph for csp
tabstat total6, by(csp)
graph bar total6, over(csp) name(cspvstotal, replace)

*cattle
tabstat total6, by( cattle )
graph bar total6, over( cattle ) name( cattlevstotal, replace)

*spouse off farm income
tabstat total6, by( spouseofffarm )
graph bar total6, over( spouseofffarm ) name( spouseofffarmvstotal, replace)

*service issue
tabstat total6, by( serviceissue )
graph bar total6, over( serviceissue) name( serviceissuevstotal, replace)
*info fd
tabstat total6, by( infofd )
graph bar total6, over( infofd ) name( infofdvstotal, replace)
*tech acct computer
tabstat total6, by( techacct )
graph bar total6, over( techacct ) name( techacctvstotal, replace)


*summary of informaiton sources
summarize infofd infocs infosdext infofarmer infofamily infotrade infonews infogovt

*summary of use of compputer and ipad/smartphone
summarize techacct techrk techinv techmkt techst techfs techrm techmktinfo

*ttest
ttest age, by(pat6)
ttest csp, by(pat6)
ttest cattle, by(pat6)
ttest education, by(pat6)
replace education=0 if education==1
replace education=0 if education==2
replace education=0 if education==3
replace education=1 if education==4
replace education=1 if education==5
replace education=1 if education==6
ttest education, by(pat6)
ttest croplandacres, by(pat6)
ttest spouseofffarm, by(pat6)
ttest serviceissue, by(pat6)
ttest infofd, by(pat6)
ttest techacct, by(pat6)

