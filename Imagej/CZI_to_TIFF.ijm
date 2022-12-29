dir = getDirectory("Choose a Directory ");
tiffdir=dir+"/tiff-files/";
File.makeDirectory(tiffdir);
list = getFileList(dir);
for (i=0; i<list.length; i++) {
	path = dir+list[i];
	if (endsWith(list[i], ".czi")) {
		run("Bio-Formats Importer", "open=[" + path + "] autoscale color_mode=Default quiet rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT show");
		extname = replace( list[i] , ".czi" , "" );
		saveAs("Tiff", tiffdir+extname);
		close();
}
}

Dialog.create("Message");
  Dialog.addMessage("Data is processed! Tiff files are saved in the same location.");
  Dialog.show;