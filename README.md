
## **ClickTMtool and Rstudio**
### Package installations
Download the ClickTMtool from the github repository. In this guide we unzipped the folder into the directory D:/ClickTMtool. Now open Rstudio and type the following scripts.

#Path of ClickTMtool in your machine

setwd("D:/ClickTMtool/ClickTMtool-main/ClickTMtool-main/") 

install.packages("readxl")

library(readxl)

packages\_to\_install <- read\_xlsx(path = "ClickTMtool\_all\_required\_packages.xlsx")

install.packages(packages\_to\_install$new\_values)

#maybe try installing in batches for example install.packages(packages\_to\_install$new\_values[1:10])

install.packages(packages\_to\_install$new\_values[11:20]) #etc.

### To run the project (Requires python and Java JDK).
#If you used option 1 for python, then you should define the python path.

reticulate::use\_python("D:/Python/python.exe",required = T)

setwd("D:/ClickTMtool/ClickTMtool-main/ClickTMtool-main/")  #ClickTMtool directory

library(shiny)

runApp("ClickTMtool\_main\_UI.R")

### Run the second project with exploratory analytics per group
setwd("D:/ClickTMtool/ClickTMtool-main/ClickTMtool-main/")  #ClickTMtool directory

library(shiny)

runApp("ClickTMtool\_main\_UI_2.R")



# Installation Instructions
## **Python installation**
We propose the first option (python install, pip install and reticulate later from Rstudio). Currently, you can avoid installing python as we tried to eliminate all python dependencies. In the future, we intend to add neural networks to train document and word representations that require these installations.
### Option 1
Install python, useful link: <https://www.python.org/downloads/>. Currently tested on the version 3.10.2 <https://www.python.org/downloads/release/python-3916/> . Make sure that the installer fits the specifications of your console. We downloaded the Windows installer (64-bit). Settings: <https://www.youtube.com/watch?v=8cAEH1i_5s0> . Also, in the last slide disable the path length limit if it is not disabled yet.

![Python installation 1](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/Python_1.PNG?raw=true)

![Python installation 2](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/Python_2.PNG?raw=true)

![Python installation 3](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/Python_3.PNG?raw=true)

Next, you will need to install the following python packages from the command line prompt. If some errors occur, we encourage the users try other versions of the following packages, usually older. For example, for tensorflow both in R (see later) and python, other versions could be compatible too. Make sure that the installed version of tensorflow is compatible with the installed version of keras as these two packages are aligned. In our case, the following installations from command line prompt were suitbale with ClickTMtool.

- pip install torch
- pip install keras
- pip install tensorflow==2.8
### Option 2
In contrast to option 1, you are able to call python from Rstudio that will create a virtual environment for python. If you do so, you need to install the python dependencies using the following scripts:

torch::install\_torch()

#https://tensorflow.rstudio.com/reference/tensorflow/install\_tensorflow 

keras::install\_keras(tensorflow = "2.8")

The versions of torch, keras and tensorflow should be compatible with the machine s system. Also, you may need to install specific versions of all libraries, it is an important step that affects some functionalities of ClickTMtool. In the future, you might want to install more recent versions so you will need to re-run both scripts from Rstudio.
## **Installation of R and Rstudio**
The following step is to install R and Rstudio. For R <https://cran.r-project.org/bin/windows/base/> and Rstudio <https://support--rstudio-com.netlify.app/products/rstudio/download/#download>. Current version of Rstudio [RStudio Desktop - Posit](https://posit.co/download/rstudio-desktop/). Need to update Rstudio to the latest version. No changes in the default settings are needed.

![R installation 1](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/R_1.PNG?raw=true)

![R installation 2](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/R_2.PNG?raw=true)

![R installation 3](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/R_3.PNG?raw=true)

![R installation 4](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/R_4.PNG?raw=true)


## **Additional installations for GPU**
This part is optional, it can be omitted at this moment. In the future, we intend to add neural networks to train document and word representations that require these installations.

Download a CUDA version, example of 11.2.2: <https://developer.nvidia.com/cuda-11.2.2-download-archive>. It is needed for the packages torch, keras and tensorflow which is used for neural networks. Also, the package torch is compatible with several CUDA versions so you need to pick the installed version accordingly. Also, you need to look for your compute capability before selecting the appropriate version capability. 

An important step is to download additional files for CUDA, in our case we needed the file CUDNN64\_8.DLL. We saved the file in the following directory: \Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.2\bin or search for a similar directory depending on your installation.
## **H2o dependencies**
Java JDK and the H2o library is required to train models using word2vec (Word Representations) and Deep Averaging Networks (Document Vectors). Also, H2o is required to train machine learning models (Prediction Models) when this library is selected instead of CARET. If you dont intend to explore these utilities, you can proceed with the rest functionalities of ClickTMtool.

Potential error resulting when 32-bit Java is installed.

Warning: Error in value[[3L]]: You have a 32-bit version of Java. H2O works best with 64-bit Java.

Please download the latest 

Java SE JDK from the following URL:

https://www.oracle.com/technetwork/java/javase/downloads/index.html

Set the JAVA environment variable value depending on the file installation of java JDK, which is selected from the online link above. We installed JDK in D:\Java\jdk-19\. In your system search for **Environment Variables** and** then **Edit the system environment variables.** Useful Link: <https://confluence.atlassian.com/doc/setting-the-java_home-variable-in-windows-8895.html> 

Variable Name: JAVA\_HOME Variable Value:'D:\Java\jdk-19\'

Where the directory is the same of the JDK installation.

# Quick tour
In this case study, we used the BBC News dataset (Greene and Cunningham, 2006) that constitutes a benchmark dataset in previous studies for validation purposes on topic classification tasks. This dataset contains a total of 2225 articles (*bbc dataset*), where each article is labeled under one of the following five classes or categories: business, entertainment, politics, sport and tech. This dataset is associated with two main tasks that both match the utilities of *ClickTMtool*. The first task is to identify the primary topics by providing coherent and reasonable results while the second one is to build machine learning models to predict the classes of new records. We initially create a training and a testing dataset using the random split option included in the *File Tab*. Also, the process of label encoding and the frequency of the labels across the dataset are shown in the following figures.

![bbc case study 1](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_1.jpg?raw=true)



![bbc case study 2](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_2.jpg?raw=true)


In the next step, we select different thresholds for the minimum and maximum proportion of documents that a word should occur to be included in the Document Term Matrix (*DTM*), as the default options led in extracting more than 5000 words. After experimentations, we discovered that the selection of these two thresholds is a decisive step that significantly affects the subsequent text mining approaches as both frequent and infrequent words may lead in several issues. These issues are mostly related to producing non-satisfactory topic coherence evaluations, discovering redundant or lackluster topics as well as extracting overlapping and not distinct topics. As a result, for the following experiments we set the first threshold equal to 0.8% and the second threshold equal to 10%, gathering 2108 words in total to form the DTM. Furthermore, we present the results of the feature evaluation, using the Conditional Mutual Information maximization (*CMI*) criterion (Fleuret, 2004), where we identify some very meaningful words that are strongly related to only one of the five topics e.g. film, coach, music, technolog, econom etc. 

![bbc case study 3](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_3.jpg?raw=true)


![bbc case study 4](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_4.jpg?raw=true)



In combination to the selection of the two main thresholds (discussed previously), the selection of the appropriate algorithms as well as the investigation of several alternatives and options is necessary. Indicatively, in this case the *FKM* and *GMM* approaches produced topics with low coherence evaluations due to the occurrence and inclusion of too many words in the *DTM*. Thus, in this case study we present our experiments using the *Leiden* algorithm for network clustering, using the Inclusion Index, as it helps us extract interpretable results with high coherence evaluations and relatively few topics. The main network of the extracted model, some of the most probable words per topics well as the visualization of the topic divergence and prevalence are presented below.

![bbc case study 5](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_5.jpg?raw=true)

![bbc case study 6](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_6.jpg?raw=true)

![bbc case study 7](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_7.jpg?raw=true)

Overall, 36 distinct topics are discovered with a relatively satisfying coherence score of 0.617 and no significant overlaps, indicating that the utilized approach is indeed an acceptable alternative for topic modelling tasks. By briefly observing the main words of the topics included in the network, we distinguish some highly interpretable subclasses that are strongly related to the five main classes e.g. cinema and films, labor parties and elections, music and related technologies, economy etc. Moreover, without reviewing the initial texts of the dataset, we successfully distribute the extracted topics into the five main classes based on our inspections of the most probable words and the main network.


|Topic No|Class|Topic No|Class|Topic No|Class|Topic No|Class|
| :- | :- | :- | :- | :- | :- | :- | :- |
|1|politics|10|politics|19|politics|28|tech|
|2|entertainment|11|politics|20|entertainment|29|sports|
|3|entertainment|12|tech|21|tech|30|sports|
|4|politics|13|politics|22|sports|31|tech|
|5|politics|14|entertainment|23|business|32|business|
|6|business|15|sports|24|entertainment|33|sports|
|7|sport|16|sports|25|politics|34|sports|
|8|politics|17|sports|26|tech|35|entertainment|
|9|politics|18|business|27|politics|36|entertainment|

As the main classes of this case study are totally independent, the estimations of the GLM, Multinomial Logistic Regression in this case, should be thoroughly investigated in order to identify the most relevant topics of each class. Indicatively, we observe the potential change of the log odds in a unit increase of cluster memberships, when the reference class is *sports*. Thus, we can observe that the log odds of an observation belonging to another class, apart from *sports*, are decreased when the memberships of clusters 15, 16, 17 are increased.  We previously distinguished that the first four clusters are associated to this class, meaning that the extracted coefficients from the Multinomial Logistic Regression confirm the information provided previously.

![bbc case study 9](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_9.jpg?raw=true)



Finally, by leveraging the topic distributions of the documents that are produced from the previous analysis, we build classification models to predict the classes of the test dataset. The evaluation of the trained models is presented below, where we should mention that the evaluations of precision, recall and F1 score are averaged across the five labels since the classification task is not binary. By examining the extracted results, we can easily infer that the classification models present high values in all evaluation metrics as they correctly predict the majority of the observations included in the test dataset. Consequently, we conclude that the extracted topics from the *Leiden* algorithm contain substantial information as they capture the semantics of the texts effectively both in terms of topic coherence and text classification. 

![bbc case study 10](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_10.jpg?raw=true)

## **REFERENCES**
Fleuret, F. (2004). Fast binary feature selection with conditional mutual information. Journal of Machine learning research, 5(9).

Greene, D., & Cunningham, P. (2006, June). Practical solutions to the problem of diagonal dominance in kernel document clustering. In Proceedings of the 23rd international conference on Machine learning (pp. 377-384).

