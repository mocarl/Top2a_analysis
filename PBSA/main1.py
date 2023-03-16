import os.path

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import quickpbsa as pbsa
import tifffile


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    paths = [
            '/Volumes/Carl_Ext_3/20230301/25nM_Top2_noDNA/Rep2/PBSA/Experiment-06-Scene-4-P2.czi_split/Experiment-06-Scene-4-P2']

    for path in paths:
        tiffstack = path + '.tif'
        print(tiffstack)
        tsout = path + '.tif' + '_Results.csv'
        print(tsout)

        rpeak = 3  # radius of the ROI
        rbg1 = 4  # inner radius of the background ring
        rbg2 = 6  # outer radius of the background ring
        mindist = 6  # minimum distance between ROI peak positions

        pbsa.trace_extraction.extract_traces_localization(tiffstack, tsout, rpeak, rbg1, rbg2, mindist, binning=20)
        tracefile = path + '_difference.csv'
        print(tracefile)

        KVthreshold = 100
        maxiter =200
        pbsa.pbsa_file(tracefile, KVthreshold, maxiter)
        print('Done!')
        # Plot eacb trace
        result = pd.read_csv(path + '_difference_result.csv', header=1)

        # Filter flagged traces
        result = result.loc[result['flag'] == 1, :]

        traces = np.array(result.loc[result['type'] == 'trace', '0':])
        fluors_full = np.array(result.loc[result['type'] == 'fluors_full', '0':])
        fluors = range(np.size(pd.unique(result.iloc[:, 0])))
        print(fluors)
        for x in fluors:
            num = str(x)
            print(num)
            fig, ax = plt.subplots()
            ax.set_title(os.path.basename(path)+'_trace_'+num)
            ax.plot(traces[x, :-1])
            ax.set_ylabel('Intensity')
            ax1 = ax.twinx()
            ax1.plot(fluors_full[x, :-1], 'r--')
            ax1.set_ylabel('Fluorophores', color='r')
            fig.set_size_inches([6, 4])
            fig.savefig(path + '_trace_' + num + '.svg', dpi=300, format="svg")
