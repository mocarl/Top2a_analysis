// "image_mean"
//
// This macro takes the image mean of the entire image as well as the mean of pixels not considered particles
// This macro batch processes all the files in a folder and any
// subfolders in that folder.

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
             percent = ((n++ / count)/2)*100;
             showStatus("!"+percent+"%");
             path = dir+list[i];
             processFile(path);
          }
      }
  }
 function processFile(path) {
	if (endsWith(list[i], ".czi") || endsWith(list[i], ".tif")) {
		// Set options
		run("Set Measurements...", "area mean standard modal min centroid center perimeter bounding fit shape feret's integrated median skewness area_fraction stack display redirect=None decimal=3");
		//Open image and duplicate it. Create image IDs for later reference
		run("Bio-Formats Importer", "open=path autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT stitch_tiles");
		run("Split Channels");
		windows = getList("image.titles");
		for(k = 0;k<windows.length;k++){
			selectWindow(windows[k]);
			run("Measure");
		}
		close("*");
		}
		}
}

//Save results file as xls
		if(isOpen("Results")){
			selectWindow("Results");
			saveAs("Results", dir + "img_stat.csv");
		}
run("Close");

Dialog.create("Message");
  Dialog.addMessage("Data is processed!");
  Dialog.show;
