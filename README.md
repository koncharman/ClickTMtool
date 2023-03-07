# Python installation
We propose the first option (python install, pip install and reticulate later from Rstudio).
## **Option 1**
Install python, useful link: <https://www.python.org/downloads/>. Currently tested on the version 3.10.2 <https://www.python.org/downloads/release/python-3916/> . Make sure that the installer fits the specifications of your console. We downloaded the Windows installer (64-bit). Settings: <https://www.youtube.com/watch?v=8cAEH1i_5s0> . Also, in the last slide disable the path length limit if it is not disabled yet.

![Python installation 1](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/Python_1.png?raw=true)


Next, you will need to install the following python packages from the command line prompt. If some errors occur, we encourage the users try other versions of the following packages, usually older. For example, for tensorflow both in R (see later) and python, other versions could be compatible too. Make sure that the installed version of tensorflow is compatible with the installed version of keras as these two packages are aligned. In our case, the following installations from command line prompt were suitbale with FastTMtool.

- pip install torch
- pip install keras
- pip install tensorflow==2.8
## **Option 2**
In contrast to option 1, you are able to call python from Rstudio that will create a virtual environment for python. If you do so, you need to install the python dependencies using the following scripts:

torch::install\_torch()

#https://tensorflow.rstudio.com/reference/tensorflow/install\_tensorflow 

keras::install\_keras(tensorflow = "2.8")

The versions of torch, keras and tensorflow should be compatible with the machine ’s system. Also, you may need to install specific versions of all libraries, it is an important step that affects some functionalities of FastTMtool. In the future, you might want to install more recent versions so you will need to re-run both scripts from Rstudio.
# Installation of R and Rstudio
The following step is to install R and Rstudio. For R <https://cran.r-project.org/bin/windows/base/> and Rstudio <https://support--rstudio-com.netlify.app/products/rstudio/download/#download>. Current version of Rstudio [RStudio Desktop - Posit](https://posit.co/download/rstudio-desktop/). Need to update Rstudio to the latest version. No changes in the default settings are needed.




# Additional installations for GPU
Download a CUDA version, example of 11.2.2: <https://developer.nvidia.com/cuda-11.2.2-download-archive>. It is needed for the packages torch, keras and tensorflow which is used for neural networks. Also, the package torch is compatible with several CUDA versions so you need to pick the installed version accordingly. Also, you need to look for your compute capability before selecting the appropriate version capability. 

An important step is to download additional files for CUDA, in our case we needed the file CUDNN64\_8.DLL. We saved the file in the following directory: \Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.2\bin or search for a similar directory depending on your installation.
# H2o dependencies
Potential error resulting when 32-bit Java is installed.

Warning: Error in value[[3L]]: You have a 32-bit version of Java. H2O works best with 64-bit Java.

Please download the latest 

Java SE JDK from the following URL:

https://www.oracle.com/technetwork/java/javase/downloads/index.html

Set the JAVA environment variable value depending on the file installation of java JDK, which is selected from the online link above. We installed JDK in D:\Java\jdk-19\. In your system search for **Environment Variables** and** then **Edit the system environment variables.** Useful Link: <https://confluence.atlassian.com/doc/setting-the-java_home-variable-in-windows-8895.html> 

Variable Name: JAVA\_HOME Variable Value:'D:\Java\jdk-19\'

Where the directory is the same of the JDK installation.
# FastTMtool and Rstudio
## **Package installations**
Next download the FastTMtool from the github repository. In this guide we unzipped the folder into the directory D:/FastTMtool. Now open Rstudio and type the following scripts.

#Path of FastTMtool in your machine

setwd("D:/FastTMtool/FastTMtool-main/FastTMtool-main/") 

install.packages("readxl")

#python path that is defined previously

library(readxl)

packages\_to\_install <- read\_xlsx(path = "FastTMtool\_all\_required\_packages.xlsx")

install.packages(packages\_to\_install$new\_values)

#maybe try installing in batches for example install.packages(packages\_to\_install$new\_values[1:10])

install.packages(packages\_to\_install$new\_values[11:20]) #etc.

## **To run the project.**
#If you used option 1 for python, then you should define the python path.

reticulate::use\_python("D:/Python/python.exe",required = T)

setwd("D:/FastTMtool/FastTMtool-main/FastTMtool-main/")  #FastTMtool directory

library(shiny)

runApp("FastTMtool\_main\_UI.R")



