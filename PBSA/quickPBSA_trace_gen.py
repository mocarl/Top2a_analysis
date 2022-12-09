import quickpbsa as pbsa
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import tifffile as tifffile


tiffstack = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221207/Top2a_25nM_BSAslides/Rep 1_sample1/PBSA/Experiment-374.tif'
tsout = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221207/Top2a_25nM_BSAslides/Rep 1_sample1/PBSA/Experiment-374.tif_Results.csv'


#im = tifffile.imread(tiffstack)
#plt.figure()
#plt.imshow(im[0,:,:], cmap='gray')
#plt.axis('off')
#plt.show()


rpeak = 3  # radius of the ROI
rbg1 = 4   # inner radius of the background ring
rbg2 = 6   # outer radius of the background ring
mindist = 6 # minimum distance between ROI peak positions

pbsa.trace_extraction.extract_traces_localization(tiffstack, tsout, rpeak, rbg1, rbg2, mindist);


