
import quickpbsa as pbsa

tracefile = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221205/Top2a_25nM_MYC_100nM_BSAslides_PBSA/345/Experiment-345_difference.csv'

KVthreshold = 75
KV_maxiter = 100

kvout, kv_outfile, kv_jsonfile = pbsa.steps_preliminary.kv_file(tracefile, KVthreshold, KV_maxiter)
