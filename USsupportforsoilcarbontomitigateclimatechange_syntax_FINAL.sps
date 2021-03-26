* Encoding: UTF-8.
* Encoding: .
*make sure weights are off while caluclating all new variables

WEIGHT OFF.


*   recoding data for new variables for anlysis  (e.g., ATN, Perceieved Naturlnesss, different soil carbon variables, etc.)

RECODE Q2 (2=1) (3=2) (1=3) INTO ACC_recoded. 
EXECUTE.
DATASET ACTIVATE DataSet1. 

RECODE Q7B_2 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) INTO AR_TampersNature_reversed_PNAT. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE Q7B_5 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) INTO BECCS_TampersNature_reversed_PNAT. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE Q7B_1 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) INTO DAC_TampersNature_reversed_PNAT. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE Q7B_4 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) INTO SCS_TampersNature_reversed_PNAT. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE Q7B_3 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) INTO SCSB_TampersNature_reversed_PNAT. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE Q7C_2 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) INTO AR_Disturbs_reserved. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE Q7C_5 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) INTO BECCS_Disturbs_reserved. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE Q7C_1 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) INTO DAC_Disturbs_reserved. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE Q7C_4 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) INTO SCS_Disturbs_reserved. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE Q7C_3 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) INTO SCSB_Disturbs_reserved. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE Q20B (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) INTO TamperWithNature_reversed_ATN. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 


*computing new scaled varibales for analyses  (i.e., ATN, Perceieved Naturlnesss, etc.)

COMPUTE AR_PNAT=MEAN.3(AR_TampersNature_reversed_PNAT,AR_Disturbs_reserved,Q7A_2). 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE BECCS_PNAT=MEAN.3(BECCS_TampersNature_reversed_PNAT,BECCS_Disturbs_reserved, 
    Q7A_5). 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE DAC_PNAT=MEAN.3(DAC_TampersNature_reversed_PNAT,DAC_Disturbs_reserved, 
   Q7A_1). 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE SCS_PNAT=MEAN.3(SCS_TampersNature_reversed_PNAT,SCS_Disturbs_reserved, 
    Q7A_4). 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE SCSB_PNAT=MEAN.3(SCSB_TampersNature_reversed_PNAT,SCSB_Disturbs_reserved, 
   Q7A_3). 
DATASET ACTIVATE DataSet1. 

COMPUTE ATN=MEAN.5(Q20A,Q20C,Q20D,Q20E,TamperWithNature_reversed_ATN). 
EXECUTE. 
DATASET ACTIVATE DataSet1. 
 


*coding "dummy" varibales for education

RECODE EDUC4 (1=0) (4=0) (3=0) (2=1) INTO EDU_HS_grad_or_equal. 
VARIABLE LABELS  EDU_HS_grad_or_equal. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE EDUC4 (1=0) (4=0) (3=1) (2=0) INTO EDU_Some_College. 
VARIABLE LABELS  EDU_Some_College. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE EDUC4 (1=0) (2=0) (4=1) (3=0) INTO EDU_BA_or_above. 
VARIABLE LABELS  EDU_BA_or_above. 
EXECUTE. 
DATASET ACTIVATE DataSet1.


*coding "dummy" varibales for anthropogenic climate change beliefs

RECODE Q2 (1=1) (2=0) (3=0) INTO CauseOfClimateChange_humans_dummy. 
VARIABLE LABELS  CauseOfClimateChange_humans_dummy. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

RECODE Q2 (2=0) (1=0) (3=1) INTO CauseOfClimateChange_both_dummy. 
VARIABLE LABELS  CauseOfClimateChange_both_dummy. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 


*recoding soil carbon varibales for analyses to compare

DO IF  (SOLUTION_4 = 1). 
RECODE SOLUTION_4 (1=1) INTO SCS_coded1. 
END IF. 
EXECUTE. 
 DATASET ACTIVATE DataSet1. 

DO IF  (SOLUTION_3 = 1). 
RECODE SOLUTION_3 (1=2) INTO SCSB_coded2. 
END IF. 
EXECUTE. 
 DATASET ACTIVATE DataSet1. 

COMPUTE SCS_and_SCSB_CDRs_combined=sum.1(SCS_coded1,SCSB_coded2).
EXECUTE.
 DATASET ACTIVATE DataSet1. 

COMPUTE SCS_and_SCSB_PNATs_combined=sum.1(SCS_PNAT,SCSB_PNAT). 
EXECUTE.

 COMPUTE SCS_and_SCSB_Support_combined=sum.1(Q11_4,Q11_3). 
EXECUTE.


*mean centering terms for interaction analyses

COMPUTE AR_PNAT_MeanCenter=AR_PNAT - 5.37. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE BECCS_PNAT_MeanCenter=BECCS_PNAT - 3.63. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE DAC_PNAT_MeanCenter=DAC_PNAT - 3.60. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE SCS_PNAT_MeanCenter=SCS_PNAT - 4.61. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE SCSB_PNAT_MeanCenter=SCSB_PNAT - 4.41. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE ATN_MeanCenter=ATN - 3.90. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE Political_Ideology_MeanCenter=Q31 - 3.79. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 


*computing interaction terms for supplemental

COMPUTE ATN_AR_PNAT_interact=ATN_MeanCenter * AR_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE ATN_BECCS_PNAT_interact=ATN_MeanCenter * BECCS_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE ATN_DAC_PNAT_interact=ATN_MeanCenter * DAC_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE ATN_SCS_PNAT_interact=ATN_MeanCenter * SCS_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE ATN_SCSB_PNAT_interact=ATN_MeanCenter * SCSB_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE AR_PNAT_Political_Ideology_interact=Political_Ideology_MeanCenter* AR_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE BECCS_PNAT_Political_Ideology_interact=Political_Ideology_MeanCenter * BECCS_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE DAC_PNAT_Political_Ideology_interact=Political_Ideology_MeanCenter * DAC_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE SCS_PNAT_Political_Ideology_interact=Political_Ideology_MeanCenter * SCS_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE SCSB_PNAT_Political_Ideology_interact=Political_Ideology_MeanCenter * SCSB_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE EDU_HS_or_Equal_Political_Ideology_interact=Political_Ideology_MeanCenter * 
    EDU_HS_grad_or_equal. 
EXECUTE. 
DATASET ACTIVATE DataSet1.

COMPUTE EDU_Some_College_or_Equal_Political_Ideology_interact=Political_Ideology_MeanCenter * 
    EDU_Some_College. 
EXECUTE. 
DATASET ACTIVATE DataSet1.

COMPUTE EDU_BA_or_Above_Political_Ideology_interact=Political_Ideology_MeanCenter * 
 EDU_BA_or_above. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE Climate_Change_Cause_Human_AR_PNAT_interact=CauseOfClimateChange_humans_dummy * 
    AR_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE Climate_Change_Cause_Human_BECCS_PNAT_interact=CauseOfClimateChange_humans_dummy * 
    BECCS_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE Climate_Change_Cause_Human_DAC_PNAT_interact=CauseOfClimateChange_humans_dummy * 
    DAC_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE Climate_Change_Cause_Human_SCS_PNAT_interact=CauseOfClimateChange_humans_dummy * 
    SCS_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE Climate_Change_Cause_Human_SCSB_PNAT_interact=CauseOfClimateChange_humans_dummy * 
    SCSB_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE Climate_Change_Cause_Both_AR_PNAT_interact=CauseOfClimateChange_both_dummy * 
    AR_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE Climate_Change_Cause_Both_BECCS_PNAT_interact=CauseOfClimateChange_both_dummy * 
    BECCS_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE Climate_Change_Cause_Both_DAC_PNAT_interact=CauseOfClimateChange_both_dummy * 
    DAC_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE Climate_Change_Cause_Both_SCS_PNAT_interact=CauseOfClimateChange_both_dummy * 
    SCS_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 

COMPUTE Climate_Change_Cause_Both_SCSB_PNAT_interact=CauseOfClimateChange_both_dummy * 
    SCSB_PNAT_MeanCenter. 
EXECUTE. 
DATASET ACTIVATE DataSet1. 


  *compute demographic stats ( make sure wights are off) - Table 1
 
 WEIGHT OFF.

FREQUENCIES VARIABLES=AGE4 GENDER RACETHNICITY Q30 EDUC4 INCOME Q31 
  /ORDER=ANALYSIS.


*testing scaled varibales with reliabilty test (weights still off) - Alphas in Table 2

 WEIGHT OFF.

RELIABILITY 
  /VARIABLES=AR_TampersNature_reversed_PNAT,AR_Disturbs_reserved,Q7A_2 
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA.

RELIABILITY 
  /VARIABLES=BECCS_TampersNature_reversed_PNAT,BECCS_Disturbs_reserved, 
    Q7A_5
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA.

RELIABILITY 
  /VARIABLES=DAC_TampersNature_reversed_PNAT,DAC_Disturbs_reserved, 
   Q7A_1
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA.

RELIABILITY 
  /VARIABLES=SCS_TampersNature_reversed_PNAT,SCS_Disturbs_reserved, 
    Q7A_4
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA.

RELIABILITY 
  /VARIABLES=SCSB_TampersNature_reversed_PNAT,SCSB_Disturbs_reserved, 
   Q7A_3
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA.

RELIABILITY 
  /VARIABLES=Q20A,Q20C,Q20D,Q20E,TamperWithNature_reversed_ATN
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA.


*statistics for CDR strategies for Perceived Naturalness and Support (weighted for mean and standard deviation ** make sure weights are on) - Mean and SD inTable 2
make sure weihgts are on

WEIGHT BY WEIGHT.

FREQUENCIES VARIABLES=AR_PNAT BECCS_PNAT DAC_PNAT SCS_PNAT SCSB_PNAT 
  /FORMAT=NOTABLE 
  /STATISTICS=STDDEV MEAN 
  /ORDER=analyses.

FREQUENCIES VARIABLES=Q11_2 Q11_5 Q11_1 Q11_4 Q11_3 
  /FORMAT=NOTABLE 
  /STATISTICS=STDDEV MEAN 
  /ORDER=analyses.

FREQUENCIES VARIABLES=ATN
  /FORMAT=NOTABLE 
  /STATISTICS=STDDEV MEAN 
  /ORDER=analyses.

FREQUENCIES VARIABLES=Q11_2 Q11_5 Q11_1 Q11_4 Q11_3 
  /ORDER=ANALYSIS

* unweighted stats for number of responses for Suport and PNAT (**make sure weights are off) - N in Table 2

WEIGHT OFF.

FREQUENCIES VARIABLES=AR_PNAT BECCS_PNAT DAC_PNAT SCS_PNAT SCSB_PNAT 
  /FORMAT=NOTABLE 
  /STATISTICS=STDDEV MEAN 
  /ORDER=analyses.

FREQUENCIES VARIABLES=Q11_2 Q11_5 Q11_1 Q11_4 Q11_3
  /FORMAT=NOTABLE 
  /STATISTICS=STDDEV MEAN 
  /ORDER=analyses.


*turn weights back on before analyses

WEIGHT BY WEIGHT.


*T-tests for Support and Perceived Naturalness and Support

T-TEST
  /TESTVAL=4
  /MISSING=ANALYSIS
  /VARIABLES=AR_PNAT BECCS_PNAT DAC_PNAT SCS_PNAT SCSB_PNAT
  /CRITERIA=CI(.95).

T-TEST
  /TESTVAL=3
  /MISSING=ANALYSIS
  /VARIABLES=Q11_2 Q11_5 Q11_1 Q11_4 Q11_3
    /CRITERIA=CI(.95).


*Main regression analyses - Table 3

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Q11_2 
  /METHOD=ENTER AR_PNAT ATN Q31 EDU_HS_grad_or_equal EDU_Some_College 
    EDU_BA_or_above GENDER AGE.

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Q11_5 
  /METHOD=ENTER BECCS_PNAT ATN Q31 EDU_HS_grad_or_equal EDU_Some_College 
    EDU_BA_or_above GENDER AGE.


  REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Q11_1 
  /METHOD=ENTER DAC_PNAT ATN Q31 EDU_HS_grad_or_equal EDU_Some_College 
    EDU_BA_or_above GENDER AGE.
  
REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Q11_4 
  /METHOD=ENTER SCS_PNAT ATN Q31 EDU_HS_grad_or_equal EDU_Some_College 
    EDU_BA_or_above GENDER AGE.

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Q11_3 
  /METHOD=ENTER SCSB_PNAT ATN Q31 EDU_HS_grad_or_equal EDU_Some_College 
    EDU_BA_or_above GENDER AGE.


*ANOVA analyses for comparing SCS and SCSB done with weights off
make sure to turn weights off before anlysis

WEIGHT OFF. 

ONEWAY SCS_and_SCSB_PNATs_combined BY SCS_and_SCSB_CDRs_combined 
  /MISSING analyses.

ONEWAY SCS_and_SCSB_Support_combined BY SCS_and_SCSB_CDRs_combined 
  /MISSING analyses.


*footnote 2 on page 6 weighted support and PNAT Soil Carbon comparison

WEIGHT BY WEIGHT.

  ONEWAY SCS_and_SCSB_PNATs_combined BY SCS_and_SCSB_CDRs_combined 
  /MISSING analyses.

ONEWAY SCS_and_SCSB_Support_combined BY SCS_and_SCSB_CDRs_combined 
  /MISSING analyses.


*Supplemental regressions with interacitons - SUPP TABLE S1 (weights back on)

WEIGHT BY WEIGHT.

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Q11_2 
  /METHOD=ENTER AR_PNAT_MeanCenter ATN_MeanCenter Political_Ideology_MeanCenter 
    CauseOfClimateChange_humans_dummy CauseOfClimateChange_both_dummy EDU_HS_grad_or_equal 
    EDU_Some_College EDU_BA_or_above GENDER AGE ATN_AR_PNAT_interact 
    AR_PNAT_Political_Ideology_interact Climate_Change_Cause_Human_AR_PNAT_interact 
    Climate_Change_Cause_Both_AR_PNAT_interact EDU_HS_or_Equal_Political_Ideology_interact EDU_Some_College_or_Equal_Political_Ideology_interact 
     EDU_BA_or_Above_Political_Ideology_interact.

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Q11_5 
  /METHOD=ENTER BECCS_PNAT_MeanCenter ATN_MeanCenter Political_Ideology_MeanCenter 
    CauseOfClimateChange_humans_dummy CauseOfClimateChange_both_dummy EDU_HS_grad_or_equal 
    EDU_Some_College EDU_BA_or_above GENDER AGE ATN_BECCS_PNAT_interact 
    BECCS_PNAT_Political_Ideology_interact Climate_Change_Cause_Human_BECCS_PNAT_interact 
    Climate_Change_Cause_Both_BECCS_PNAT_interact EDU_HS_or_Equal_Political_Ideology_interact EDU_Some_College_or_Equal_Political_Ideology_interact 
     EDU_BA_or_Above_Political_Ideology_interact.

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Q11_1 
  /METHOD=ENTER DAC_PNAT_MeanCenter ATN_MeanCenter Political_Ideology_MeanCenter 
    CauseOfClimateChange_humans_dummy CauseOfClimateChange_both_dummy EDU_HS_grad_or_equal 
    EDU_Some_College EDU_BA_or_above GENDER AGE ATN_DAC_PNAT_interact 
    DAC_PNAT_Political_Ideology_interact Climate_Change_Cause_Human_DAC_PNAT_interact 
    Climate_Change_Cause_Both_DAC_PNAT_interact EDU_HS_or_Equal_Political_Ideology_interact EDU_Some_College_or_Equal_Political_Ideology_interact 
     EDU_BA_or_Above_Political_Ideology_interact.

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Q11_4 
  /METHOD=ENTER SCS_PNAT_MeanCenter ATN_MeanCenter Political_Ideology_MeanCenter 
    CauseOfClimateChange_humans_dummy CauseOfClimateChange_both_dummy EDU_HS_grad_or_equal 
    EDU_Some_College EDU_BA_or_above GENDER AGE ATN_SCS_PNAT_interact 
    SCS_PNAT_Political_Ideology_interact Climate_Change_Cause_Human_SCS_PNAT_interact 
    Climate_Change_Cause_Both_SCS_PNAT_interact EDU_HS_or_Equal_Political_Ideology_interact EDU_Some_College_or_Equal_Political_Ideology_interact 
     EDU_BA_or_Above_Political_Ideology_interact.

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Q11_3 
  /METHOD=ENTER SCSB_PNAT_MeanCenter ATN_MeanCenter Political_Ideology_MeanCenter 
    CauseOfClimateChange_humans_dummy CauseOfClimateChange_both_dummy EDU_HS_grad_or_equal 
    EDU_Some_College EDU_BA_or_above GENDER AGE ATN_SCSB_PNAT_interact 
    SCSB_PNAT_Political_Ideology_interact Climate_Change_Cause_Human_SCSB_PNAT_interact 
    Climate_Change_Cause_Both_SCSB_PNAT_interact EDU_HS_or_Equal_Political_Ideology_interact EDU_Some_College_or_Equal_Political_Ideology_interact 
     EDU_BA_or_Above_Political_Ideology_interact.


*CORRELTAION MATRIX - (turn weights back on)  supp S2

 WEIGHT BY WEIGHT.  

NONPAR CORR 
  /VARIABLES=Q11_2 Q11_5 Q11_1 Q11_4 Q11_3 AR_PNAT BECCS_PNAT DAC_PNAT SCS_PNAT SCSB_PNAT ATN 
    ACC_recoded Q31 EDUC4 GENDER AGE 
  /PRINT=KENDALL TWOTAIL NOSIG 
  /MISSING=PAIRWISE.

