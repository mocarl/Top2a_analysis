// "coords_extraction_PBSA"
//
//The macro extracts the XY coordinates for local maximums for use in downstream PBSA analysis

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
	if (endsWith(list[i], ".tif")) {
		// Set options
		run("Colors...", "foreground=black background=black selection=lightgray");
		//Open image and duplicate it. Create image IDs for later reference
		run("Bio-Formats Importer", "open=path autoscale color_mode=Default rois_import=[ROI manager] specify_range view=Hyperstack stack_order=XYCZT t_begin=1 t_end=1 t_step=1");
		original = getImageID();
		original_title = getTitle();
		getStatistics(area,mean);
		getPixelSize(unit, pixelWidth, pixelHeight);
		if (unit == "microns" && pixelWidth == pixelHeight) 
			pixel = pixelWidth * 1000;
		else {
			pixel = 1;
		}
		run("Find Maxima...", "prominence=["+mean+"] output=List");
		selectWindow(original_title);
		run("Find Maxima...", "prominence=["+mean+"] output=[Point Selection]");
			run("Flatten");
			saveAs("tiff", dir + File.getName(list[i]) + "_overlay_outlines.tiff"); 
			close(original_title + "_overlay_outlines.tiff");
			close(original_title);


//Save results file as xls
		if(isOpen("Results")){
			selectWindow("Results");
			for(n=0; n<nResults; n++) { 
				x = getResult("X", n); 
				setResult("x [nm]", n, pixel*x);
				y = getResult("Y", n); 
				setResult("y [nm]", n, pixel*y); 
			}
			}
			saveAs("Results", dir + File.getName(list[i]) + "_Results.csv");
			close(File.getName(list[i]) + "_Results.csv");
		}
		
		}
		close("*");
		}



run("Close");

Dialog.create("Message");
  Dialog.addMessage("Data is processed!");
  Dialog.show;

