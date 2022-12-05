// "particle_count_V4"
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
		run("Bio-Formats Importer", "open=path autoscale color_mode=Default rois_import=[ROI manager] specify_range view=Hyperstack stack_order=XYCZT t_begin=1 t_end=1 t_step=1");
		original = getImageID();
		original_title = getTitle();
		selectImage(original);
		run("Duplicate...", "duplicate");
		maskID = getImageID();
		mask_title = getTitle();
		rename(mask_title + "_mask");
		mask_title = getTitle();
		selectWindow(mask_title);
		
			//Generate masks on each memeber of stack
				//run("Maximum...", "radius=1 stack");
				//run("Unsharp Mask...", "radius=1 mask=0.60 stack");
				//run("Gaussian Blur...", "sigma=1 stack");
				run("Auto Threshold", "method=Triangle ignore_black ignore_white white stack");
				setOption("BlackBackground", true);
				//run("Dilate", "stack");
				run("Close-", "stack");
				run("Erode", "stack");
				//run("Open", "stack");
				run("Watershed", "stack");
			run("Set Measurements...", "area mean standard min centroid center perimeter bounding fit shape feret's integrated median skewness area_fraction limit display redirect=[" + original_title + "] decimal=3");
			selectWindow(mask_title);
			run("Select None");
			run("Analyze Particles...", "size=6-Infinity pixel circularity=0.0-1.00 display exclude clear summarize overlay add");
			//run("Create Selection");
			selectWindow(original_title);
			//run("From ROI Manager");
			roiManager("show all without labels");
			//run("Restore Selection");
			run("Flatten");
			run("8-bit");
			saveAs("tiff", dir + File.getName(list[i]) + "_overlay_outlines.tiff"); 
			close(original_title + "_overlay_outlines.tiff");
			close(original_title);
//Save outline images
		drawings = getList("image.titles");
		for(m=0;m<drawings.length;m++){
			if(startsWith(drawings[m],"Drawing")){
				selectWindow(drawings[m]);
				saveAs("tiff", dir + File.getName(list[i]) + "_outlines.tiff"); 
				close(File.getName(list[i]) + "_outlines.tiff");
				close("drawings[m]");
			} else {
			continue;
			}
		}
//Save summary as xls
		selectWindow("Summary");
		saveAs("Results", dir + File.getName(list[i]) + "_Summary.xls"); 
		close(File.getName(list[i]) + "_Summary.xls");
		close("Summary");

//Save results file as xls
		if(isOpen("Results")){
			selectWindow("Results");
			saveAs("Results", dir + File.getName(list[i]) + "_Results.csv");
		}
		
		}
		close("*");
		}
	}


run("Close");

Dialog.create("Message");
  Dialog.addMessage("Data is processed!");
  Dialog.show;

