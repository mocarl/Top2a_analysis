### Statistical analysis of particles deposited on functionalized glass slides
Scripts and functions contained within the repository is aimed to perform statistical analysis on particles deposited on functionalized cover glass
Images are first analysed with Imagej and the macro written within that environment to detect and measure particles on deoposited on the surface. 
The data is then consolidated and arranged by suitable scripts within the R project. After consolidation use the copy function to copy .xlsx files to the Data folder within the project wd.
This will allow all paths used within scripts and functions to work as intended. 

# Make note that no data should be committed to the repository. Make sure that the Data folder is included in .gitignore
# Make note that no output should be committed to the repository. Make sure that the Output folder is included in .gitignore

# For functions and scripts to work open always open the project via the Project file and run the "dependencies" script at start up

### Functions 

import_xlsx(path, str)
# Import the conditions you want to analyse by defining search words for the files names
# All subfolders in Data will be checked for matching files

mass_coloc(channel1,channel2)
# Define the two channels you want to analyse. Channel1 is assumed to be channel of interest.
# Coloc is defined as particles having any overlapping point on a circle defined by the particles mass centre and a radius derived from particle area.
# The particles is assumed to be perfect circles in this approach as this is the most likely footprint of a true protein condensate.
# See outline images with particle mask for true geometry of detected particles.
