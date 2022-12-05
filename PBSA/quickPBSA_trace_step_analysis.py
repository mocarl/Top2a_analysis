import numpy as np
import json
import matplotlib.pyplot as plt
import pandas as pd
import quickpbsa as pbsa


tracefile = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221205/Top2a_25nM_MYC_100nM_BSAslides_PBSA/Experiment-343_difference.csv'
pd.read_csv(tracefile, header=1).loc[:71, :]

KVthreshold = 100
KV_maxiter = 200




kvout, kv_outfile, kv_jsonfile = pbsa.steps_preliminary.kv_file(tracefile, KVthreshold, KV_maxiter)

kvout.iloc[25:30,:14]

