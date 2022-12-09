
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import quickpbsa as pbsa
import tifffile


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    tiffstack = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221207/Top2a_25nM_BSAslides/Rep_1_sample1/PBSA/Experiment-374/Experiment-374.tif'
    tsout = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221207/Top2a_25nM_BSAslides/Rep_1_sample1/PBSA/Experiment-374/Experiment-374.tif_Results.csv'

    rpeak = 3  # radius of the ROI
    rbg1 = 4  # inner radius of the background ring
    rbg2 = 6  # outer radius of the background ring
    mindist = 6  # minimum distance between ROI peak positions

    pbsa.trace_extraction.extract_traces_localization(tiffstack, tsout, rpeak, rbg1, rbg2, mindist);

    tracefile = '/Volumes/Carl_Ext_2/EXPERIMENTS/20221207/Top2a_25nM_BSAslides/Rep_1_sample1/PBSA/Experiment-374/Experiment-374_difference.csv'

    KVthreshold = 75
    KV_maxiter = 100

    kvout, kv_outfile, kv_jsonfile = pbsa.steps_preliminary.kv_file(tracefile, KVthreshold, KV_maxiter)

    result = pbsa.steps_refinement.improve_steps_file(kv_outfile, kv_jsonfile)


    result = pd.read_csv(
        '/Volumes/Carl_Ext_2/EXPERIMENTS/20221207/Top2a_25nM_BSAslides/Rep_1_sample1/PBSA/Experiment-374/Experiment-374_difference_result.csv',
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

    plt.savefig('/Volumes/Carl_Ext_2/EXPERIMENTS/20221207/Top2a_25nM_BSAslides/Rep_1_sample1/PBSA/Experiment-374_trace_histo.svg', dpi=300, format="svg")

    plt.show()
