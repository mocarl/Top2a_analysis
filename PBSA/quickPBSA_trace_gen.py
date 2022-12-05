import quickpbsa as pbsa
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import tifffile as tifffile

tiffstack = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221205/Top2a_25nM_MYC_100nM_BSAslides_PBSA/Experiment-343.tif'
tsout = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221205/Top2a_25nM_MYC_100nM_BSAslides_PBSA/Experiment-343.czi_Results.csv'


im = tifffile.imread(tiffstack)
plt.figure()
plt.imshow(im[0,:,:], cmap='gray')
plt.axis('off')
plt.show()

pd.read_csv(tsout).loc[:71,:]

rpeak = 3  # radius of the ROI
rbg1 = 4   # inner radius of the background ring
rbg2 = 6   # outer radius of the background ring
mindist = 6 # minimum distance between ROI peak positions

pbsa.trace_extraction.extract_traces_localization(tiffstack, tsout, rpeak, rbg1, rbg2, mindist);


peak_file = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221205/Top2a_25nM_MYC_100nM_BSAslides_PBSA/Experiment-343_peak.csv'
bg_file = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221205/Top2a_25nM_MYC_100nM_BSAslides_PBSA/Experiment-343_bg.csv'
diff_file = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221205/Top2a_25nM_MYC_100nM_BSAslides_PBSA/Experiment-343_difference.csv'

# First line
print(open(diff_file).readline())
# Difference Traces
diff = pd.read_csv(diff_file, header=1)
diff.loc[:5,:]

peak = pd.read_csv(peak_file, header=1)
bg = pd.read_csv(bg_file, header=1)

plt.figure()
plt.plot(np.array(peak.loc[71,'0':]), label='Peak')
plt.plot(np.array(bg.loc[71,'0':]), label='Background')
plt.plot(np.array(diff.loc[71,'0':]), label='Difference')
plt.legend()
plt.xlabel('Frames')
plt.ylabel('Intensity')
plt.show()



pbsa.pbsa_file(file, threshold, maxiter)
