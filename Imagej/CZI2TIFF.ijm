run("Bio-Formats Importer", "open=/Volumes/Carl_Extern/20201104/Xrs2_L_20nM/Xrs2_L_40nM_1.czi autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
run("Bio-Formats Exporter", "save=/Volumes/Carl_Extern/20201104/Xrs2_L_20nM/Xrs2_L_40nM_1.tif compression=Uncompressed");
run("Close");
