// Exporting from Stata to other formats


** Preliminaries -------------------------------------

version 18

set more off

* Turns off any log that is open 

capture log close 

* Set my working directory

cd "C:\Users\user\Documents\GitHub\applied-latex"

log using stata_exports_log_clase.txt, replace

* use a random dataset

webuse nhanes2l

*** Descriptive statistics --------------------------------

dtable age weight // does not export

dtable age weight, by(region) // cool group by statistics

dtable age weight, by(region) export("outputs/table_by_region_stata_export.docx")

summarize age // cannot be exported unless you do a lengthy workflow with collect export.

** Regressions ---------------------------------------------

quietly regress bpsystol age weight i.region // quietly does not give output

estimates store model1

etable, estimates(model1) showstars showstarsnote title("Tabla Regresion") export ("outputs/word_doc_stata_export.docx", replace)

* now, using outreg2 

* ssc install outreg2 if u havent done so 

outreg2 using "outputs/word_doc_stata_export.docx", replace

* with multiple models

quietly regress bpsystol age weight // quietly does not give output

estimates store model2

outreg2 [model1 model2] "outputs/word_doc_stata_export.docx", replace

* with latex

outreg2 [model1 model2] using "outputs/latex_stata_export.tex", replace 

* now with esttout

* ssc install esttout if u havent done so before. 

// Export both models to LaTeX
esttab model1 model2 using "outputs/latex_stata_export.tex", replace ///
title("Tabla Regresion") b(%9.3f) se star booktabs

esttab model1 model2 using "outputs/word_stata_export.docx", replace 

** Finalize -------------------------------------

log close

exit