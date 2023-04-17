//Loop through all image in folder, displays them and sorts out the ones deemed low quality
//
// This macro opens and adjust all czi images in a folder in order for the user to assess the quality
// This macro batch processes all the files in a folder and any
// subfolders in that folder. In this example, it runs the Subtract 
// Background command of TIFF files. For other kinds of processing,
// edit the processFile() function at the end of this macro.

dir = getDirectory("Choose a Directory ");
list = getFileList(dir);
setBatchMode(false);
choice = newArray("Do not Include", "Include");
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
	if (endsWith(list[i], ".czi") || endsWith(list[i],  ".tif")) {
		run("Bio-Formats Importer", "open=path autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT stitch_tiles");
		original = getTitle();
		Stack.getDimensions(width, height, channels, slices, frames);
		for(k = 0;k<channels;k++){
				Stack.setChannel(k);
				run("Enhance Contrast...", "saturated=0.35");
		}
		run("Make Montage...", "columns=3 rows=1 scale=1 label");
		close(original);
		Dialog.createNonBlocking("Categorize");
			Dialog.addChoice("Quality", choice, choice[1]);
			Dialog.show();
			
		category = Dialog.getChoice();
		if (category==choice[0]) {
			if (File.exists(dir+"/Bad")) {
				File.rename(path, dir+"/Bad/"+list[i]);
				close("*");
				continue;
				}else {
					File.makeDirectory(dir+"/Bad");
					File.rename(path, dir+"/Bad/"+list[i]);
					close("*");
					continue;
		}
		}else {
			close("*");
			continue;
		}
}
}

close("Log");
Dialog.create("Message");
  Dialog.addMessage("Images are processed!");
  Dialog.show;
