### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from statistics
## Author: Carl Möller mocarl@chalmers.se

import_csv("Output/pFLIP/pFLIP_relaxed_10nM_Top2a_noATP")
import_csv("Output/pFLIP/pFLIP_relaxed_10nM_Top2a_ATP")
rm(pFLIP_relaxed_10nM_Top2a_noATP__coloc_statistics)
rm(pFLIP_relaxed_10nM_Top2a_ATP__coloc_statistics)
x=Top2_FLIP_rel_10nM_wATP_YOYO1_results_coloc_pop$Area
y=Top2_FLIP_rel_10nM_wATP_YOYO1_results_coloc_pop$Mean
scatterBar.Norm(x,y,FALSE)
