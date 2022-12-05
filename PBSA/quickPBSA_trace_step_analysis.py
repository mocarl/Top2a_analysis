import quickpbsa as pbsa
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import tifffile as tifffile
import multiprocessing as mp

tracefile = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221205/Top2a_25nM_MYC_100nM_BSAslides_PBSA/Experiment-343_difference.csv'
pd.read_csv(tracefile, header=1).loc[:71, :]

KVthreshold = 100
KV_maxiter = 100
pardict = {'norm': 1000,
           'crop': False}

pbsa.pbsa_file(tracefile, KVthreshold, KV_maxiter, preliminary_optional=pardict, num_cores=4)

kvout, kv_outfile, kv_jsonfile = pbsa.steps_preliminary.kv_file(tracefile, KVthreshold, KV_maxiter)

kvout.iloc[25:30,:14]

