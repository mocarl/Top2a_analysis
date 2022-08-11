// "particle_count_V2"
//
// This macro detects particles in dual-channel images 
// This macro batch processes all the files in a folder and any
// subfolders in that folder. In this example, it runs the Subtract 
// Background command of TIFF files. For other kinds of processing,
// edit the processFile() function at the end of this macro.

dir = getDirectory("Choose a Directory ");
list = getFileList(dir);
setBatchMode(true);
count = 0;
countFiles(dir);
n = 0;
processFiles(dir);


for (i=0; i<list.length; i++) {
	path = dir+list[i];
   function countFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              countFiles(""+dir+list[i]);
          else
              count++;
      }
  }

   function processFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              processFiles(""+dir+list[i]);
          else {
             showProgress(n++, count);
             path = dir+list[i];
             processFile(path);
          }
      }
  }
 function processFile(path) {
	if (endsWith(list[i], ".czi")) {
		run("Set Measurements...", "area mean standard min centroid center perimeter bounding fit shape feret's integrated median skewness area_fraction limit display redirect=None decimal=3");
		run("Bio-Formats Importer", "open=path autoscale color_mode=Default rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT stitch_tiles");
		windows = getList("image.titles");
		for(k = 0;k<windows.length;k++){
				selectWindow(windows[k]);
				run("Enhance Contrast", "saturated=0.35");
				run("Auto Threshold", "method=Triangle ignore_black ignore_white white");
				str = split(getTitle(), ".");
				str = str[0]+"_roi-";
				run("Analyze Particles...", "size=3-Infinity pixel show=Outlines display exclude clear summarize overlay");
//Save outline images
		drawings = getList("image.titles");
		for(m=0;m<drawings.length;m++){
			if(startsWith(drawings[m],"Drawing")){
				selectWindow(drawings[m]);
				saveAs("tiff", dir + File.getName(list[i]) + "_" + windows[k]+ "_outlines.tiff"); 
				close(File.getName(list[i]) + "_" + windows[k] + "_outlines.tiff");
				close("drawings[m]");
			} else {
			continue;
			}
		}
//Save summary as xls
		selectWindow("Summary");
		saveAs("Results", dir + File.getName(list[i]) + "_" + windows[k] + "_Summary.xls"); 
		close(File.getName(list[i]) + "_" + windows[k] + "_Summary.xls");
		close("Summary");

//Save results file as xls
		if(isOpen("Results")){
			selectWindow("Results");
			saveAs("Results", dir + File.getName(list[i]) + "_" + windows[k] + "_Results.csv");
		}
		
		}
		close("*");
		}
}

//run("Close");

Dialog.create("Message");
  Dialog.addMessage("Data is processed!");
  Dialog.show;
