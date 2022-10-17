// "particle_count_top_down"
//
// This macro detects particles in dual/triple-channel images 
// Method uses Yoyo1 channel to detect particles and then applies the list of ROI on the subsequent channels to find corresponding particles in other channels
// This macro batch processes all the files in a folder and any
// subfolders in that folder. In this example, it runs the Subtract 
// Background command of TIFF files. For other kinds of processing,
// edit the processFile() function at the end of this macro.

var top;
var chan;
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
		original = getImageID();
		find_channel(path);
		if (i == 0) {
		choose_ref();
		top++;
		}
		//luts = newArray("thallium", "Red Hot", "Orange Hot");
		luts = newArray();
		for (p = 0; p < chan.length; p++) {
		if (chan[p] == "Yoyo1") {
			luts = Array.concat(luts,"Green");
		} else if (chan[p] == "AF647") {
		luts = Array.concat(luts,"Red");
		} else if (chan[p] == "AF546") {
		luts = Array.concat(luts,"Orange Hot");
		}
		}
		//Array.print(luts);
		if (channels < 2) {
			continue;
		} else {
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
			mask = "C" + top + "-" + mask_title;
			selectWindow(mask);
			//Generate masks on each memeber of stack
				run("Maximum...", "radius=1 stack");
				run("Unsharp Mask...", "radius=1 mask=0.60 stack");
				run("Gaussian Blur...", "sigma=1 stack");
				run("Auto Threshold", "method=Triangle ignore_black ignore_white white stack");
				setOption("BlackBackground", true);
				run("Dilate", "stack");
				run("Close-", "stack");
				run("Open", "stack");
				run("Watershed", "stack");
			
		
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
			C++;
			run("Set Measurements...", "area mean standard min centroid center perimeter bounding fit shape feret's integrated median skewness area_fraction limit display redirect=[" + redir + "] decimal=3");
			selectWindow(mask);
			run("Select None");
			Stack.setSlice(q);
			run("Analyze Particles...", "size=6-Infinity pixel circularity=0.0-1.00 display exclude clear summarize overlay add");
			//run("Create Selection");
			selectWindow(redir);
			//run("From ROI Manager");
			roiManager("show all without labels");
			//run("Restore Selection");
			run("Flatten");
			run("8-bit");
			lut = luts[q];
			run(lut);
			saveAs("tiff", dir + File.getName(list[i]) + "_" + chan[q] + "_overlay_outlines.tiff"); 
			close(redir + "_overlay_outlines.tiff");
			close(redir);
//Save outline images
		drawings = getList("image.titles");
		for(m=0;m<drawings.length;m++){
			if(startsWith(drawings[m],"Drawing")){
				selectWindow(drawings[m]);
				saveAs("tiff", dir + File.getName(list[i]) + "_" + chan[q] + "_outlines.tiff"); 
				close(File.getName(list[i]) + "_" + chan[q] + "_outlines.tiff");
				close("drawings[m]");
			} else {
			continue;
			}
		}
//Save summary as xls
		selectWindow("Summary");
		saveAs("Results", dir + File.getName(list[i]) + "_" + chan[q] + "_Summary.xls"); 
		close(File.getName(list[i]) + "_" + chan[q] + "_Summary.xls");
		close("Summary");

//Save results file as xls
		if(isOpen("Results")){
			selectWindow("Results");
			saveAs("Results", dir + File.getName(list[i]) + "_" + chan[q] + "_Results.csv");
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

function find_channel(path) { 
	run("Bio-Formats Macro Extensions");
	chan = newArray();
// function description: finds what the channels are and in what order
	Ext.setId(path);
//selectImage(original);
	getDimensions(width, height, channels, slices, frames);
//filePath = File.openDialog("Choose a file");
	C = 1;
	for (j = 0; j < channels; j++) {
		Ext.getMetadataValue("Information|Image|Channel|Name #"+C,val);
		chan = Array.concat(chan,val);
		C++;
		}
		//Array.print(chan);
		return chan;
}

function choose_ref() { 
// function description choose channel to be used reference channel

//waitForUser("Choose reference channel");
Dialog.create("Choose your reference channel");  //enable user interactivity
 for (i = 0; i < chan.length; i++) {
	 Dialog.addMessage(i + "-" + chan[i]);
//choices = Array.concat(choices,choice);
}
//Dialog.addChoice("Reference channel is:", Array.getSequence(chan.length));
 Dialog.addNumber("Reference channel is:", 0);
Dialog.show();
	top = Dialog.getNumber();
   	//top = Dialog.getChoice();
}
