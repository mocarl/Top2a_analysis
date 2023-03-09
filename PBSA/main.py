
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import quickpbsa as pbsa
import tifffile


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    path = '/Volumes/Carl_Ext_3/20230223/25nM_Top2_100nM_MYC_noDNA/Rep1/PBSA/Experiment-160-Scene-4-P1.czi_split/Experiment-160-Scene-4-P1'
    tiffstack = path + '.tif'
    print(tiffstack)
    tsout = path + '.tif' + '_Results.csv'
    print(tsout)

    rpeak = 3  # radius of the ROI
    rbg1 = 4  # inner radius of the background ring
    rbg2 = 6  # outer radius of the background ring
    mindist = 6  # minimum distance between ROI peak positions

    pbsa.trace_extraction.extract_traces_localization(tiffstack, tsout, rpeak, rbg1, rbg2, mindist)

    tracefile = path + '_difference.csv'
    print(tracefile)
    KVthreshold = 75
    KV_maxiter = 100

    kvout, kv_outfile, kv_jsonfile = pbsa.steps_preliminary.kv_file(tracefile, KVthreshold, KV_maxiter)

    result = pbsa.steps_refinement.improve_steps_file(kv_outfile, kv_jsonfile)


    result = pd.read_csv(
        path + '_difference_result.csv',
        header=1)
    # Filter flagged traces
    result = result.loc[result['flag'] == 1, :]

    traces = np.array(result.loc[result['type'] == 'trace', '0':])
    fluors_full = np.array(result.loc[result['type'] == 'fluors_full', '0':])

    fig, ax = plt.subplots(1, 2)
    ax[0].plot(traces[5, :1000])
    ax[0].set_ylabel('Intensity')
    ax1 = ax[0].twinx()
    ax1.plot(fluors_full[5, :1000], 'r--')
    ax1.set_ylabel('Fluorophores', color='r')
    ax[1].hist(fluors_full[:, 0], bins=np.arange(30) + 0.5)
    fig.set_size_inches([10, 4])

    plt.savefig(path + '_trace_histo.svg', dpi=300, format="svg")

   # plt.show()
