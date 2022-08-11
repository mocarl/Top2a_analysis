// "particle_count_prot_loc"
//
// This macro detects particles in dual-channel images 
// This macro batch processes all the files in a folder and any
// subfolders in that folder. For other kinds of processing,
// edit the processFile() function at the end of this macro.

var fred;

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
		run("Set Measurements...", "area mean standard min centroid center perimeter bounding fit shape feret's integrated median skewness area_fraction limit display add redirect=None decimal=3");
		run("Bio-Formats Importer", "open=["+path+"] autoscale color_mode=Default rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT stitch_tiles");
		windows = getList("image.titles");
		for(k = 0;k<windows.length;k++){
			selectWindow(windows[k]);
			//run("8-bit");
			//changeValues(0, 0, NaN);
			//changeValues(255, 255, NaN);
			run("Enhance Contrast", "saturated=0.35");
			BuildThreshStack();
			selectWindow(windows[k]);
			//setOption("BlackBackground", true);
			//setAutoThreshold(fred + " dark ignore_black ignore_white");
			run("Auto Threshold", "method=" + fred + " ignore_black ignore_white white");
			//run("Threshold");
			str = split(getTitle(), ".");
			str = str[0]+"_roi-";
			run("Analyze Particles...", "size=3-Infinity pixel show=Outlines display clear summarize overlay add");

			
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
			run("Clear Results");
		}
		
		for ( j=0; j<roiManager("count"); j++ ) { 
				roiManager("select", j);
				outline2results(str+(j+1));
			}
			//Save ROI file as xls
		if(isOpen("Results")){
			selectWindow("Results");
			saveAs("Results", dir + File.getName(list[i]) + "_" + windows[k] + "_ROI.csv");
			close("Results");
		}
		}
		close("*");
		}
}

//run("Close");

Dialog.create("Message");
  Dialog.addMessage("Data is processed!");
  Dialog.show;


//FUNCTION Choose global Threshold Method
function BuildThreshStack() {
	run("Auto Threshold", "method=[Try all] ignore_black ignore_white white");
	setBatchMode("show");
	
	selectWindow("Montage"); 
	run("Montage to Stack...", "images_per_row=5 images_per_column=4 border=0");
	run("RGB Color");
	run("Colors...", "foreground=green background=black selection=red");
 	style = 4; // Font.BOLD
 	call("ij.gui.TextRoi.setFont", "Sans", 80, style) 


//run("Label...", "format=0000 x=14 y=20 font=32 text=Method use use_text"); 
setSlice(1);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[Default] range=1-1");
setSlice(2);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[Huang] range=2-2");
setSlice(3);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[Huang2] range=3-3");
setSlice(4);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[Intermodes] range=4-4");
setSlice(5);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[IsoData] range=5-5");
setSlice(6);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[li] range=6-6");
setSlice(7);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[MaxEntropy] range=7-7");
setSlice(8);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[Mean] range=8-8");
setSlice(9);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[MinError] range=9-9");
setSlice(10);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[Minimum] range=10-10");
setSlice(11);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[Moments] range=11-11");
setSlice(12);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[Otsu] range=12-12");
setSlice(13);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[Percentile] range=13-13");
setSlice(14);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[RenyiEntropy] range=14-14");
setSlice(15);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[Shahbhag] range=15-15");
setSlice(16);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[Triangle] range=16-16");
setSlice(17);
run("Label...", "format=Text starting=0 interval=1 x=10 y=30 font=80 text=[Yen] range=17-17");

setBatchMode("show");
wait(1000);
waitForUser("Browse the Stack to choose the best Method \n then click OK to input your choice");
Dialog.create("Choose your desired threshold");  //enable user interactivity
 Dialog.addChoice("Best threshold is:", newArray("Default", "Huang","Huang2","Intermodes","IsoData","Li","MaxEntropy","Mean","MinError","Minimum","Moments","Otsu","Percentile","RenyiEntropy","Shanbhag","Triangle","Yen"));
Dialog.show();
   fred = Dialog.getChoice();
//print("Dialog gives fred as ", fred);
selectWindow("Stack");
close("Stack");

selectWindow("Montage");
close("Montage");

}

//ensure var fred is set
//End of function BuildThreshStack


function outline2results(lbl) {
	nR = nResults;
	Roi.getCoordinates(x, y);
	for (i=0; i<x.length; i++) {
		setResult("Label", i+nR, lbl);
		setResult("X", i+nR, x[i]);
		setResult("Y", i+nR, y[i]);
	}
}