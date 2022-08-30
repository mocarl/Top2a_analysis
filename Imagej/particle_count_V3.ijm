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
		run("Colors...", "foreground=black background=black selection=lightgray");
		//Open image and duplicate it. Create image IDs for later reference
		run("Bio-Formats Importer", "open=path autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT stitch_tiles");
		getDimensions(width, height, channels, slices, frames);
		if (channels < 2) {
			continue;
		} else {
		original = getImageID();
		for (j = 1; j <= channels; j++) {
			Stack.setChannel(j);
			run("Enhance Contrast", "saturated=0.35");
		}
		selectImage(original);
		run("Duplicate...", "duplicate");
		maskID = getImageID();
		mask_title = getTitle();
		rename(mask_title + "_mask");
		mask_title = getTitle();
		selectWindow(mask_title);
		run("Split Channels");
		C = 1;
		for (p = 0; p < channels; p++) {
			mask = "C" + C + "-" + mask_title;
			C++;
			selectWindow(mask);
			//Generate masks on each memeber of stack
			if (p > 0) {
				run("Maximum...", "radius=1 stack");
				run("Unsharp Mask...", "radius=1 mask=0.60 stack");
				run("Gaussian Blur...", "sigma=1 stack");
				run("Auto Threshold", "method=Triangle ignore_black ignore_white white stack");
				setOption("BlackBackground", true);
				run("Dilate", "stack");
				run("Close-", "stack");
				run("Open", "stack");
				run("Watershed", "stack");
			
			} else {
		run("Auto Threshold", "method=Triangle ignore_black ignore_white white stack");
		setOption("BlackBackground", true);
		run("Open", "stack");
		run("Watershed", "stack");
			}
		}
		//Split channels and create reference
		selectImage(original);
		Property.set("CompositeProjection", "null");
		Stack.setDisplayMode("color");
		original_title = getTitle();
		run("Split Channels");
		//selectImage(maskID);
		//mask_title = getTitle();
		//run("Split Channels");
		C = 1;
		for (q = 0; q < channels; q++) {
			redir = "C" + C + "-" + original_title;
			mask = "C" + C + "-" + mask_title;
			C++;
			run("Set Measurements...", "area mean standard min centroid center perimeter bounding fit shape feret's integrated median skewness area_fraction limit display redirect=[" + redir + "] decimal=3");
			selectWindow(mask);
			run("Select None");
			Stack.setSlice(q);
			run("Analyze Particles...", "size=6-Infinity pixel circularity=0.0-1.00 display exclude clear summarize add");
			//run("Create Selection");
			selectWindow(redir);
			//run("From ROI Manager");
			roiManager("show all without labels");
			//run("Restore Selection");
			run("Flatten");
			saveAs("tiff", dir + File.getName(list[i]) + "_C" + q + "_overlay_outlines.tiff"); 
			close(redir + "_overlay_outlines.tiff");
			close(redir);
			close(mask);
//Save outline images
		drawings = getList("image.titles");
		for(m=0;m<drawings.length;m++){
			if(startsWith(drawings[m],"Drawing")){
				selectWindow(drawings[m]);
				saveAs("tiff", dir + File.getName(list[i]) + "_C" + q + "_outlines.tiff"); 
				close(File.getName(list[i]) + "_C" + q + "_outlines.tiff");
				close("drawings[m]");
			} else {
			continue;
			}
		}
//Save summary as xls
		selectWindow("Summary");
		saveAs("Results", dir + File.getName(list[i]) + "_C" + q + "_Summary.xls"); 
		close(File.getName(list[i]) + "_C" + q + "_Summary.xls");
		close("Summary");

//Save results file as xls
		if(isOpen("Results")){
			selectWindow("Results");
			saveAs("Results", dir + File.getName(list[i]) + "_C" + q + "_Results.csv");
		}
		
		}
		close("*");
		}
	}
}

run("Close");

Dialog.create("Message");
  Dialog.addMessage("Data is processed!");
  Dialog.show;
