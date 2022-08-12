// "split_tiles"
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
		run("Bio-Formats Importer", "open=path autoscale color_mode=Default open_files open_all_series rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		File.makeDirectory(dir+"/"+list[i]+"_split");
		windows = getList("image.titles");
		for(k = 0;k<windows.length;k++){
				selectWindow(windows[k]);
				saveAs("Tiff", dir+"/"+list[i]+"_split/"+windows[k]);
				close(windows[k]);
		}
		close("*");
		}
}

//run("Close");

Dialog.create("Message");
  Dialog.addMessage("Data is processed!");
  Dialog.show;
