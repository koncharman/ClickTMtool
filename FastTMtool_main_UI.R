library(shiny)
library(ggplot2)
library(caTools)
library(DT)
library(LDAvis)
library(binda)
library(readxl)
library(writexl)
library(ruimtehol)
library(h2o)
library(wordcloud2)
library(shinydashboard)
library(shinyWidgets)
library(nnet)

set.seed(831)


source("functions/text_preprocessing.R")
source("functions/prepare_glove.R")
source("functions/fclust_mapping_with_npmi.R")
source("functions/find_coh.R")

source("functions/topic_models.R")
source("functions/train_test_functions.R")
source("functions/Train_Regression.R")
source("functions/Feature_evaluation_methods.R")
source("functions/auto_encoders.R")
source("functions/Document_vectors.R")
source("functions/tensorflow_keras_nn_funs.R")
source("functions/dimensionality_reduction_options.R")

source("functions/Accurancy_2_Vectors_new.R")

#
#h2o.init(nthreads = -1)




all_list=NULL
item_list_text=NULL
word_vectors_list=NULL


ui <- fluidPage(
  
  #setBackgroundColor(color = c("#C8A8D1", "#FFB6B6"),gradient = "linear",direction = c("top", "left")),
 
  
  titlePanel(title = "Welcome to FastTMtool",windowTitle = "FTMT"),
  #tabsetPanel(type = "tabs",
  #navlistPanel("Navigation List",
  #navbarMenu("Navigation Menu",
  #dashboardSidebar()
  navbarPage("",
              tabPanel("File",
                       
                       sidebarLayout( 
                         sidebarPanel(
                           
                           ##complete file and variables assesmment
                           tags$h2(tags$strong("Import Data")),
                           #File selection
                           fileInput(inputId = "file_choose",label = "Select your Dataset"),
                           #Selection of the appropriate columns of the imported Data Frame
                           selectizeInput(inputId = "txt_col",label = "Text column",choices = "text column"),
                           selectizeInput(inputId = "class_col",label = "Class column",choices = "class column"),
                           selectizeInput(inputId = "spl_col",label = "Split column",choices = "split column"),
                           
                           
                           
                           #Radio button defining nominal or continuous variable
                           radioButtons(inputId = "nom_con_var",label = "Nominal or Continuous variable?",choices = c("Nominal"="nom_choice","Continuous"="con_choice"),selected = "nom_choice"),
                           
                      
                           
                           #complete variable assessment
                           actionButton(inputId = "complete_var_ass",label = "Confirm variable assessment"),
                           
                          
                             
                           
                           #Random Split Option
                           tags$h2(tags$strong("Additional Split Options")),
                           
                           
                           actionButton(inputId = "random_split",label = "Random Split 70-30"),
                           actionButton(inputId = "all_train_split",label = "No testing dataset"),
                            
                           #Additional Variables
                           tags$h2(tags$strong("Add more variables")),
                           
                           
                           #Additional variables used in classification and regression
                           radioButtons(inputId = "nom_con_extra_var",label = "Nominal or Continuous variable?",choices = c("Nominal"="nom_choice","Continuous"="con_choice"),selected = "nom_choice"),
                           
                           selectizeInput(inputId = "extra_var_col",label="Select column",choices="Column names"),
                           fluidRow(column(width = 6,offset = 0,actionButton(inputId = "add_extra_var",label = "Add extra variable",value = 1)),column(width = 6,offset = 0,actionButton(inputId = "del_extra_var",label = "Delete extra variable",value = 2))),
                           tableOutput("extra_var_display"),
                           
                           ),
                       mainPanel(
                         
                         
                         #Visualization of the imported data
                         dataTableOutput(outputId = "main_table"),
                         
                         #Visualization of the Split Data
                         dataTableOutput(outputId = "split_table"),
                         
                         #Frequencies or Distribution of the target variable
                         tags$h2(tags$strong("Target Variable Frequencies")),
                         tableOutput(outputId = "variable_table"),
                         
                         
                        
                       )
                         ),
                       #Bar plot of the target variable
                       plotOutput(outputId = "variable_plot"),
                       #Bar plots of the extra variables
                       uiOutput("extra_var_plots")
                       ),
              tabPanel("Text Preprocessing",
                       sidebarLayout( 
                         sidebarPanel(
                           ##complete text preprocessing
                           
                           #Bag of Words or TF-IDF
                           tags$h3(tags$b("Document Representation Options")),

  
                           radioButtons(inputId="dtm_tfidf_choose",label="Document Term Matrix Options",choices = c("Raw Term Count"="tf_chosen","TF-IDF"="tfidf_chosen")),
                          
                           #Thersholds for word occurence
                           textOutput(outputId = "Document_ratio_title"),
                           fluidRow(column(width = 4,offset = 0,numericInput(inputId = "min_doc",label = "min",value = 0.002,min=0,max=1)),column(width = 4,offset = 0,numericInput(inputId = "max_doc",label = "max",value = 0.5,min=0,max=1))),
                           
                           #Text preprocessing options
                           HTML(paste("<h3 style='font-weight: bold'>","Preprocessing Options","</h3>",sep="")),
                           checkboxInput(inputId = "bp",label = "Basic preprocess",value = F),
                           checkboxInput(inputId = "do_stem",label = "Do stemming",value = F),
                           checkboxInput(label = "Remove stopwords",inputId = "do_rmv_stop",value = F),
                           
                           checkboxInput(inputId = "ngrams_clause",label = "N-grams",value = F),
                           conditionalPanel(condition = "input.ngrams_clause == true",fluidRow(column(width = 4,offset = 0,numericInput(inputId = "min_ngrams",label = "min ngrams",value = 2,min=1,max=6)),column(width = 4,offset = 0,numericInput(inputId = "max_ngrams",label = "max ngrams",value = 4,min=2,max=6)))),
                           
                           conditionalPanel(condition = "input.bp== false",checkboxGroupInput(inputId = "txt_preprocess",label = "Additional Text Preprocessing Options",choices=c(
                                                                                                                                                    "lower case transformation"="do_lower_case","remove mentions"="do_rmv_mention", "replace numbers"="do_rpl_number", "replace hash code"="do_rpl_hash","replace html"="do_rpl_html", "replace question marks"="do_rpl_qmark", "replace exclamation marks"="do_rpl_emark","replace punctutation"="do_rpl_punct","replace digits"="do_rpl_digit"))),
                           actionButton(inputId = "complete_preprocessing",label = "Apply text preprocessing"),
                           
                           #build word vectors
                           HTML(paste("<h3 style='font-weight: bold'>","Word Representation Options","</h3>",sep="")),
                           
                           selectizeInput(inputId = "vector_choice",label="Select word vectors",choices = list("GloVe full binary coocurence"="glove_tcm","GloVe full coocurence"="glove_tcm_full","GloVe skipgram"="glove_skip","TCM standarized"="tcm_stand","TCM inclusion index"="tcm_ii","TCM reverse inclusion index"="tcm_rev_ii","Term existence"="tdm_te","Spearman correlation coefficient on Term existence matrix"="spearman_word_corr","Word2vec (Skipgram)"="word2vec_skipgram","Word2vec (CBOW)"="word2vec_cbow")),
                           conditionalPanel("input.vector_choice!='tdm_te' &&  input.vector_choice!= 'spearman_word_corr' && input.vector_choice!='tcm_stand' && input.vector_choice!='tcm_rev_ii' && input.vector_choice!='tcm_ii'",numericInput(inputId = "vector_size",label = "Vector size",value = 50,min = 1)),
                           fluidRow(column(width = 6,offset = 0,checkboxInput(inputId = "auto_enc",label="Apply auto encoder")),column(width = 6,offset = 0,numericInput(inputId = "auto_enc_dim",label = "Number of Dimensions",value = 20,min = 2))),
                           
                           
                           #Alternatives of Dimensionality reduction algorithms applied on word representations. Not available when the approach that is based on the Leiden algorithm and the Inclusion Index is selected.
                           #When the UMAP dimensionality reduction technique is selected, one additional parameter is available.
                           
                                        
                           radioButtons(inputId = "dim_red_options",label = "Dimensionality Reduction Options",choices = list("No Reduction"="no_red","Factor Analysis"="factanal_red","UMAP"="umap_red","t-SNE"="tsne_red","PCA"="pca_red","SVD"="svd_red")),
                           numericInput(inputId = "no_umap_dims",label = "Number of Dimensions",value = 2),                 
                           conditionalPanel(condition = "input.dim_red_options == 'umap_red'",numericInput(inputId = "nn_umap",label = "UMAP word neighbors",min=2,step=1,value = 5),
                                            
                           ),
                           
                           
                           actionButton(inputId = "vector_build",label = "Build word representations"),
                           
                           
                           
                         ),
                         mainPanel(
                           #Output indicating the finalization of word vectors
                           tags$h2(tags$b("Information of word representations")),
                           
                           tags$h4(textOutput(outputId = "no_vec")),
                           
                           tags$h4(textOutput(outputId = "word_vec_dim")),
                           
                           br(),
                           
                           #Bar plot of word frequencies
                           tags$h2(tags$b("Barplot of Word frequencies")),
                           br(),
                           
                           numericInput(inputId = "word_bar_plot_no_items",label = "Number of Words",value = 20,min = 2),
                           br(),
                           plotOutput(outputId = "word_barplot"),
                           br(),
                           br()
                           
                         )
                       ),
                       #Wordcloud
                      
                       tags$h2(tags$b("Wordcloud")),
                       br(),
                       fluidRow(column(width = 6,offset = 0,selectizeInput(inputId = "word_cloud_shape",label="Word Cloud Shape",choices = list("Circle"="circle","Cardioid"="cardioid","Diamond"="diamond","Triange-Forward"="triangle-forward","Triangle"="triangle","Pentagon"="pentagon","Star"="star"))),column(width = 6,offset = 0,numericInput(inputId = "word_cloud_no_items",label = "Number of Words",value = 20,min = 2))),
                       
                       br(),
                       wordcloud2Output("word_cloud")
                       ),
              tabPanel("Feature Selection",
                       sidebarLayout( 
                         sidebarPanel(
                           tags$h2(tags$strong("Feature Evaluation and Selection Options")),
                           
                           #Feature evaluation options
                           selectizeInput(inputId = "matrix_feature_evaluation",label="Select Matrix for feature evaluation",choices = list("Document term matrix"="dtm_mf","Document term matrix (dichotomized)"="dtmd_mf")),
                           selectizeInput(inputId = "method_feature_evaluation",label="Method for feature evaluation",choices = list(
                             "JIM" = "jim_ff", #new
                             "JMIM"="jmim_ff",
                             "JMI"="jmi_ff",
                             
                             "MIM"="mim_ff",
                             "NJMIM" = "njmim_ff", #new
                             "MRMR"="mrmr_ff",
                             
                             "DISR"="disr_ff",
                             
                             "CMI"="cmi_ff", #new
                             "CMIM"="cmim_ff",
                             "Cosine Similarity"="cossimil_ff",
                             "Spearman Correlation"="spearman_ff"
                             )),
                           #No of features to select
                           numericInput(inputId = "no_feature_evaluation",label="Number of features",value = 20,min = 1,step = 1),
                           #Button for feature evaluation
                           actionButton(inputId = "perform_feature_evaluation",label = "Perform Feature Evaluation"),
                           
                           #Button for feature selection. Updating Document Term Matrix (DTM) and Term Co-occurence Matrix (TCM)
                           actionButton(inputId = "select_features",label = "Perform Feature Selection")
                           
                         ),
                         #Feature evaluation output
                         mainPanel(
                           dataTableOutput(outputId = "feature_table")
                         )
                       ) 
                       ),
              tabPanel("Word Clustering",
                       sidebarLayout( 
                         sidebarPanel(
                           ##build model
                           tags$h2(tags$strong("Keyword Clustering Options")),
                           
                           #Selecting one of the three proposed clustering approaches
                           selectizeInput(inputId = "model_choice",label="Select model",choices = list("Fuzzy K-means Clustering"="f_clust","Gaussian Mixtures model based clustering"="m_clust","Graph Clustering Using the Leiden Algorithm"="leiden")),
                           
                           #Additional options for the approach that is based on the Leiden algorithm
                           conditionalPanel(condition = "input.model_choice == 'leiden'",radioButtons(inputId = "leiden_features",label="Clustering Features",choices = list("Word Vectors"="word_simil","Inclusion Index similarity"="II_simil"))),
                           conditionalPanel(condition = "input.model_choice == 'leiden' && input.leiden_features == 'II_simil'",radioButtons(inputId = "ii_or_rev_ii",label = "Inclusion index choices",choices=list("Inclusion Index"="ii_choice","Reverse Inclusion Index"="rev_ii_choice"),selected = "ii_choice")),
                           
                           #Number of top terms used for the evaluation and selection of the final model based on topic coherence 
                           numericInput(inputId = "num_top_c",label = "Number of top terms",value = 10,min = 2,max = 50,step = 1),
                           
                           #Option to not include the word frequencies to identify the top words, including only the topic memberships of words produced by the selected approach.
                           checkboxInput(inputId = "center_top_Words",label = "Do not include the word frequencies to find the top words of clusters",value = F),
                           #Option to standarize the topic memberships of words produced by the approach that is based on the Leiden algorithm
                           conditionalPanel(condition = "input.model_choice == 'leiden'",checkboxInput(inputId = "stand_leiden_words_mem",label = "Do not standarize the topic memberships of words",value = F)),
                           
                           #Selecting minimum and maximum number of clusters to be evaluated. Not available when the approach that is based on the Leiden algorithm is selected.
                           conditionalPanel(condition = "input.model_choice != 'leiden'",numericInput(inputId = "min_num_top_c",label = "Minimum number of clusters",min=2,step=1,value = 2),
                                            numericInput(inputId = "max_num_top_c",label = "Maximum number of clusters",min=2,step=1,value = 20)
                           ),
                           
                           
                           #Model build
                           actionButton(inputId = "model_build",label = "Build model"),
                           
                         ),
                         mainPanel(
                           
                           
                           #Top terms per cluster
                           dataTableOutput(outputId = "main_clust_keyword_table")
                           
                           
                         )
                       ),
                       
                       #Full view or short view (top terms) of the extracted clusters. Short view is not availablewhen the approach that is based on the Leiden algorithm is selected.  
                       conditionalPanel("input.model_choice != 'leiden'",selectizeInput(inputId = "main_plot_topic_view",label="Cluster view",choices=list("Top words View"="top_words_view","Full View"="full_view"))),
                       br(),
                       #Main visualization of words and clusters
                       plotOutput(outputId = "main_plot_topic"),
                       
                       #Visualization of topic divergence and prevalence, based on LDAvis
                       visOutput(outputId = "topic_vis_plot_clust"),
                       
                       #Results of a Generalized Linear Model using the topic memberships of the documents as independent variables and the target variable, selected in the File Tab, as the dependent variable.
                       selectizeInput(inputId = "multinomial_reg_value_clust",label="Reference Class on Multinomial Logistic Regression",choices = list()),
                       dataTableOutput(outputId = "reg_table_clust")
                       ),
              tabPanel("Topic Modelling",
                       sidebarLayout( 
                         sidebarPanel(
                           #Build topic model
                           tags$h2(tags$strong("Topic Modelling Options")),
                           #Available alternatives of topic modelling algorithms
                           fluidRow(column(width = 6,offset = 0,selectizeInput(inputId = "topic_model_choice",label="Select topic model",choices = list("LDA (VEM)"="LDA_vem","LDA (Collapsed Gibbs Sampling)"="LDA_m","NMF"="NMF","CTM (VEM)"="CTM_vem","STM"='STM_vem',"ETM"='ETM',"LSA"="LSA"))),column(width = 6,offset = 0,numericInput(inputId = "no_topics",label = "Number of topics",value = 10,min = 2))),
                           #Number of top terms used for the evaluation and selection of the final model based on topic coherence 
                           numericInput(inputId = "num_top_t",label = "Number of top terms",value = 10,min = 2,max = 50,step = 1),
                           #Alpha and Beta, prior parameters of LDA, assessment when the LDA with Collapsed Gibbs Sampling topic modelling algorithm is selected
                           conditionalPanel(condition = "input.topic_model_choice == 'LDA_m'",
                                            checkboxInput(inputId = 'as_alpha',label = "Asymmetric alpha",value = F),
                                            fluidRow(
                                              conditionalPanel(condition = "input.as_alpha == false", column(width = 6,offset = 0,numericInput(inputId = 'topic_alpha',label = "Alpha",value=1,min = 0))),
                                                     column(width = 6,offset = 0,numericInput(inputId = 'topic_beta',label = "Beta",value=1,min = 0)),
                                                     
                                              )),
                           conditionalPanel(condition = "input.topic_model_choice == 'LDA_m' | input.topic_model_choice == 'ETM'",numericInput(inputId = 'topic_iter',label = "Iterations",value=10,min = 1,step = 1)),
                           
                           #Button for model building
                           fluidRow(column(width = 4,offset = 0,actionButton(inputId = "topic_model_build",label = "Build topic model"))),
                           
                         ),
                         mainPanel(
                           #Top terms per topic
                           dataTableOutput(outputId = "main_topic_keyword_table")
                          
                           
                         )
                       ),
                       #Visualization of topic divergence and prevalence, based on LDAvis
                       visOutput(outputId = "topic_vis_plot"),
                       #Results of a Generalized Linear Model using the topic memberships of the documents as independent variables and the target variable, selected in the File Tab, as the dependent variable.
                       selectizeInput(inputId = "multinomial_reg_value_topic",label="Reference Class on Multinomial Logistic Regression",choices = list()),
                       
                       dataTableOutput(outputId = "reg_table_topic")
                        ),
              tabPanel("Document Vectors",
                       sidebarLayout( 
                         sidebarPanel(
                           #Building Document vectors mostly based on different neural network architectures
                           tags$h2(tags$strong("Document Vector Options")),
                           
                           #Available alternatives of models
                           selectizeInput(inputId = "doc_vec_model",label = "Document Vector Types",choices=list("Starspace"="star_model",'FastText'="ft_model","Deep Averaging Networks"="dan_model","Convolutional Neural Network (CNN)"="CNN","Recurrent Neural Network (RNN)"="RNN","Long Short Term Memory (LSTM)"="LSTM")),
                           #Number of dimensions
                           numericInput(inputId = "doc_vec_dims",label = "Number of Dimensions",value = 50,min = 2,step = 5),
                           #Information passed to the models, not available when the fastText or the starspace model is selected. Building a model using the all words, the words included in the Document Term Matrix with initialized weights (word vectors - see Text Preprocessing Tab) and without initialized weights. 
                           conditionalPanel("input.doc_vec_model != 'star_model' && input.doc_vec_model != 'ft_model'",selectizeInput(inputId = "type_words_doc_vec",label="Type of word weights initilization",choices = list("All words with no initiliazed weights"="all_words","DTM words with no initiliazed weights"="dtm_nw","DTM words with initialized weights"="dtm_ww"))),
                           #Button for model building
                           fluidRow(column(width = 4,offset = 0,actionButton(inputId = "docvec_model_build",label = "Build Document Vectors"))),

                         ),
                         mainPanel(
                           #Maybe add some Information in the next update
                         )
                       )
              ),
              tabPanel("Prediction Models",
                       sidebarLayout( 
                         sidebarPanel(
                           tags$h2(tags$strong("Prediction Model Options")),
                           
                           ##Classification and Regression Options
                           
                           #Alternatives options for document features to be used in model building
                           radioButtons(inputId = "model_properties_choice",label="Classification features",choices = list(
                             "Document Term Matrix"="dtm_model",
                             "Doument Term Matrix (Dichotomized)"="dtm_model_dich",
                             "Average Word Vectors" = "avg_word_vec_model",
                             "Cluster Model"="c_model",
                             "Topic Model"="t_model",
                             "Document Vectors"="s_model"
                             )),
                           #Button for model building
                           actionButton(inputId = "classification_w_p",label = "Classification with properties"),
                           
                         ),
                         mainPanel(
                           #Visualization of Classification and Regression performance measures
                           dataTableOutput(outputId = "train_acc"),
                           
                         )
                       )
              ),
             
             tabPanel("Import Files",
                      tags$h2(tags$strong("Data Import Options")),
                      
                      selectInput("import_list", "Choose a dataset:",
                                  choices = c( 
                                              
                                              "Document Term Matrix" = "dtm_fin",
                                              "Word Vectors" = "word_vectors",
                                              "Document Vectors" = "doc_vectors",
                                              "Processed text"="pro_text",
                                              "Term co occurrence matrix" = "tcm_fin",
                                              "Split Data (True and False values)" = "split2_att" 
                                  )
                                  
                      ),
                      fileInput(inputId = "import_choose",label = "Select Import file"),
                      
                      ),
             tabPanel("Export Files",
                      
                      sidebarLayout( 
                        sidebarPanel(
                          tags$h2(tags$strong("Data Export Options")),
                          
                          selectInput("download_list", "Choose a dataset:",
                                      choices = c("Main Attributes"="all_list_elements", 
                                                  "Processed Text" = "pro_text",
                                                  "Document Term Matrix" = "dtm_fin",
                                                  "Document Cluster Memberships" = "doc_clust_mem",
                                                  "Document topic Memberships" = "doc_topic_mem",
                                                  "Term co occurrence matrix" = "tcm_fin",
                                                  "Topic Word Memberships" = "topic_word_mem",
                                                  "Cluster Word Memberships" = "clust_word_mem",
                                                  "Cluster top terms" = "clust_top_terms",
                                                  "Topic top terms" = "topic_top_terms",
                                                  "Word Vectors" = "word_vectors",
                                                  "Document vectors" = "doc_vectors",
                                                  "Classification-Regression Performance" = "perf_val_mem",
                                                  "Predictions from machine learning models" = "pred_ml",
                                                  
                                                  "Regression Results (Clusters)" = "reg_res_clust",
                                                  "Regression Results (Topics)" = "reg_res_topic",
                                                  "Feature Selection Results" = "feat_selec_res",
                                                  "Split Data (True and False values)"="split2_att"
                                                  
                                                  
                                                  )
                                                  
                                      ),
                          
                          #Button for file exporting
                          downloadButton("download_button", "Download")
                        ),
                        mainPanel(
                          #Visualization of the selected features
                          dataTableOutput(outputId = "download_table")
                          
                        )
                      )
             ),
             tabPanel("Guide and Info",
                      
                      tags$h2("Datasets in the Repository"),
                      
                        tags$h3("File: 20newsgroup_combined.csv"),
                          tags$body("Description: The 20 Newsgroups data set is a collection of approximately 20,000 newsgroup documents, partitioned (nearly) evenly across 20 different newsgroups. Each observation has a textual decription and is assigned to 1 class indicating its general theme"),
                          br(),br(),
                          tags$body("Reference: Lang, K. (1995). Newsweeder: Learning to filter netnews. In Machine learning proceedings 1995 (pp. 331-339). Morgan Kaufmann."),
                     
                        tags$h3("File: bbc-text.csv"),
                          tags$body("Description: Dataset with 2225 observations originated from the BBC news. Each observation has a textual decription and is assigned to 1 class indicating its general theme"),
                          br(),br(),
                          tags$body("Reference: D. Greene and P. Cunningham. 'Practical Solutions to the Problem of Diagonal Dominance in Kernel Document Clustering', Proc. ICML 2006."),
                          br(),br(),
                          tags$body("Notes: This dataset was used in the Readme/Quick tour of the official FastTMtool repository"),
                        tags$h3("File: df_title_cwe_exploit_from_2009.xlsx"),
                          tags$body("Description: 144166 records of sotware vulnerabilities from 2009 to 2023"),
                          br(),br(),
                          tags$body("Reference: Charmanas, K., Mittas, N., & Angelis, L. (2021, November). Predicting the existence of exploitation concepts linked to software vulnerabilities using text mining. In 25th Pan-Hellenic Conference on Informatics (pp. 352-356)."),
                          br(),br(),
                          tags$body("Notes: This dataset contains textual descriptions and multiple severity metrics of softwware vulneraibilities"),
                        tags$h3("File: df_exploit_no_cwe_codes (R Data Structure - RDS"),
                          tags$body("Description: 8210 records of sotware vulnerabilities from 2022. This dataset is good for practice as it is coherent, without long descriptions and a relatively small size."),
                          br(), br(),
                          tags$body("Reference: Charmanas, K., Mittas, N., & Angelis, L. (2021, November). Predicting the existence of exploitation concepts linked to software vulnerabilities using text mining. In 25th Pan-Hellenic Conference on Informatics (pp. 352-356)."),
                          br(), br(),
                          tags$body("Notes: This dataset contains textual descriptions and multiple severity metrics of softwware vulneraibilities"),
                      tags$h2("File Tab"),
                        tags$h3("Necessary Actions"),
                          tags$body("Step 1: Load your data through the browse button. The data should be stored in the same directory or sub directories of the file 'FastTMtool_main_UI.R'. Currently supported data structures (.csv,.xlsx,.RDS)"),
                          br(), br(),
                          tags$body("Step 2: Define Text column, Class column, Split column and then select whether your output class is nominal or continuous. Then press the button Confirm variable assessment to confirm your choices. Do not afraid to define a random column of the data as a split column if there is not one initially. You can use the button 'Random Split' or the button 'No testing dataset' afterwards."),
                        
                        tags$h3("Optional Actions"),
                          tags$body("Step 3: When the data contain a column that indicates whether an observation belongs to the training or testing dataset (TRUE and FALSE values), the buttons 'Random Split' and 'No testing dataset' can be avoided. Otherwise, the user must select 1 of these 2 options"),
                          br(), br(),
                          tags$body("Step 4: The user can select additional variables (Nominal or Continuous) that will be used to train machine learning models later"),
                      tags$h2("Text Preprocessing"),
                        tags$h3("Document Representation Options"),
                          tags$body("Document Term Matrix Options: The user must select an option for the desired document representation where the raw term count (Bag of Words) and the Term Frequency - Inverse Document Frequency are currently supported. Useful Link: 'https://en.wikipedia.org/wiki/Tf-idf'"),
                      br(), br(),   
                        tags$body("Keyword-Document frequency ratio: The user should define the min and max parameters, i.e. the minimum and maximum number of documents a word must occur to be included in the Document Term Matrix."),
                        tags$h3("Preprocessing Options"),
                          tags$body("Do stemming: Apply stemming procedures where each token/word is transformed into its root content. For example, the words 'match','matching' and 'matches' will be transformed into the word 'match'.
                                    "),br(), br(),
                                    tags$body("Remove stopwords: Stopwords are a set of common words that are used in general context and do not carry significant information. Words like 'the', 'too', 'i','and','my','it' are among the stopwords.
                                    "),br(), br(),
                      tags$body("N-grams: A sequence of words of N items that form a phrase which is accounted as a token in the Document Term Matrix when this option is selected. Usefull Link - https://en.wikipedia.org/wiki/N-gram"),
                          tags$h4("Option 1: 'Basic Preprocess' Lower case transformation and keeping only alphanumeric characters."),
                          tags$h4("Option 2:  Additional Text Preprocessing Options"),
                            tags$body("lower case transformation: Transform all upper case characters into lower case"),
                      br(), br(),      
                      tags$body("remove mentions: Words or subwords that start with the symbol '@' are replaced by white space"),
                      br(), br(),      
                      tags$body("replace numbers: Numbers are replaced by words. for example the number 124 is replaced by tge phrase 'one hundred twenty-four'. Words like '123rt' are not replaced"),
                      br(), br(),    
                      tags$body("replace hash code: Words or subwords that start with the symbol '#' are replaced by white space"),
                            br(), br(),
                      tags$body("replace html: All characters that are included inbetween a text that starts with '<' and ends with '>' are removed"),
                      br(), br(),      
                      tags$body("replace question marks: Question marks are replaced with the word 'questionmark'"),
                      br(), br(),     
                      tags$body("replace exclamation marks: Exclamation marks are replaced with the word 'exclamationmark'"),
                      br(), br(),     
                      tags$body("replace punctutation: All punctuation characters are removed, e.g. '.', '$', '%'."),
                      br(), br(),     
                      tags$body("replace digits: All numerical characters are replaced by whitespace. For example the phrase '123rt' is transformed into ' rt'"),
                      br(), br(),     
                      tags$h4("When you finish selecting all the necessary options, i.e. Document representations, Keyword-Document frequency ratio and Preprocessing Options, you should press the button Apply text preprocessing which will construct a document term matrix and term co-occurence matrix based on your selections. These two matrices constitute the basis for the utilities of FastTMtool."),
                        tags$h3("Word Vectors Options"),
                          tags$h4("Select word vectors"),
                            tags$body("GloVe, from Global Vectors, is an unsupervised method for creating word embeddings where words that co-occur frequently are projected nearby in the new embedding space. The respective inputs reflect on word co-occurences or relevant measurements of co-occurence. 
                                    Word2Vec is an unsupervised method that is similar to GloVe and aims at establishing efficient word vectors. TCM refers to the Term Co-occurence Matrix and can be used to effectively capture the similarities between the words. The proposed variations manipulate the initial Term Co-occurence Matrix based on different rules.
                                    The spearman correlation coefficient establishes word reperesentations based on their pairwise correlations.
                                    An autoencoder is also an unsupervised method used to transform high demensional representations into a new, usually a lower dimensional, structure.
                                    "),
                          tags$h4("Dimensionality Reduction Options"),
                            tags$body("There are multiple available dimensionality reduction options that reduce the dimensionality of the initial word embeddings/vectors. In general, these approaches support the clustering methodologies in detecting coherent clusters.
                                    "),br(),br(),
                                    tags$body("UMAP: Unifold Manifold Approximation Projection"),br(),br(),
                                    tags$body("Factor Analysis"),br(),br(),
                                    tags$body("t-SNE: T-distributed stochastic neighbor embedding"),br(),br(),
                                    tags$body("PCA: Principal Component Analysis"),br(),br(),
                                    tags$body("SVD: Singular Value Decomposition"),
                      br(),br(),      
                      tags$h4("The button 'Build Word representations' builds the configured word representation and then apply an auto encoder and a dimensinolitry reduction algorithm, when they are selected"),
                      tags$h2("Feature Selection"),
                        tags$h3("Select Matrix for feature evaluation"),
                          tags$body("Available options: Document Term matrix (Created in the previous tab) and Document Term matrix (dichotomized) that dichotomizes the Document Term Matrix where values equal to 1 indicate the occurence of a word, at least once, in a document while values equal to 0 indicate the opposite"),
                        tags$h3("Method for feature evaluation"),
                          tags$body("A method is selected to evaluate the importance of each word based on the output variable. The available options are based on the R package 'praznik' while also the cosine similarity and the spearman correlation coeffecient can be used to evaluate the words' importance as well.
                                    "),
                          br(),br(),
                          tags$h4("The button 'Perform Feature Evaluation' evaluates the importance of each word and then the button 'Perform Feature Selection' can be used to exclude the words that are not included in the subset of the most important words (defined by the users via the 'Number of features' option) from your analysis."),
                      tags$h2("Word Clustering"),
                        tags$h3("Select model"),
                          tags$body("Short Description: 3 word clustering techniques for discovering underlying topics from word representations (discussed previously). The first two rely on spatial information to identify clusters and define their properties. The third one is uses word co-occurences or similarities from word embeddings/representations to establish networks/graphs whose edges indicate strong similarities or frequent co-occurences"),br(),br(),
                          tags$body("Fuzzy k-means Clustering: A variation of the standard k-means algorithm where each data point is assigned to all clusters with a positive degree of memebrship.
                                    All the memberships add to one for each data point (in our case words). The memberships are calculated based on the distance of each data point from the centroids of each cluster. Relevant R package: fclust"),br(),br(),
                                    tags$body("Gaussian Mixture model based clustering: This algorithm establishes clusters that carry gaussian properties, i.e. mean (or center) and covariance, which are used to calculate the cluster memberships of the words. Relevant R package: mclust"),br(),br(),
                          tags$body("Graph Clustering Using the Leiden Algorithm: In this approach, we employ the Leiden algorithm for network clustering (see R package igraph) that is able to detect network communities that are formed by nodes and edges. In our case, a node is denoted by a word or N-gram and the edges
                                    indicate strong Co-occurences between the connected nodes."),br(),br(),
                        tags$h4("Notes: FastTMtool trains several models for the selected algorithm and picks the 'optimal' one based on a topic coherence measure, i.e. a measure that evaluates the quality of the extracted topics expressed by clusters.
                                 When the leiden Algorithm is selected, FastTMtool trains 100 models using different parameters to identify the 'optimal' model while for the rest 2 options the user is able define the range of topics/clusters, Default range is 2-20 topics."),br(),
                        
                          tags$body("Do not include the word frequencies to find the top words of clusters: The topic coherence of a model relies on the Co-occurence frequencies between the most probable words of each topic/cluster for a predefined number of words ('Number of top terms')"),br(),br(),
                          tags$body("Do not standarize the topic memberships of words: In the proposed approach that is based on the Leiden algorithm, the topic membership of a word is measured by the overall linkage of this word with the words that form each cluster. When this options is selected, these memberships are not standarized to sum to one"),br(),br(),
                          tags$body("Do not include the word frequencies to find the top words of clusters: The topic membership of a word and the overall number of documents that this word occurs form the basis to calculate a score between a word and a topic in order to define top words of each topic. 
                                    When this option is selected, only the initial topic memberships are used to calculate these scores."), br(),br(),
                        tags$h4("Build model: Based on the predefined options FastTMtool builds several models and selects the 'optimal' one for further analysis."), br(),
                      tags$h2("Topic modelling"),br(),
                        tags$h3("Select topic model"),br(),
                          tags$body("LDA (VEM): Latent Dirichlet Allocation wit the Variational Expectation Maximization algorithm"),br(),br(),
                          tags$body("LDA (Collapsed Gibbs Sampling): Latent Dirichlet Allocation with the Collapsed Gibbs Sampler"),br(),br(),
                          tags$body("NMF: Non Negative Matrix Factorization"),br(),br(),
                          tags$body("CTM: Correlated Topic Models with the Variational Expectation Maximization algorithm"),br(),br(),
                          tags$body("STM: Structural Topic Models"),br(),br(),
                          tags$body("ETM: Topic Models in Embedding Spaces"),br(),br(),
                          tags$body("LSA: Latent Semantic Analysis"),br(),br(),
                        tags$h3("Number of topics: A model is trained for a predefined number of topics"), br(),br(),
                        tags$h3("Number of top terms: The number of top terms that are used to calculate the topic coherence and divergence of a topic."), br(),br(),
                      tags$h2("Document Vectors"), br(),br(),
                        tags$h3("Document Vector Types: FastTMtool leverages several existing architectures that are based on neural networks to create models for text classification. These
                                architectures are displayed with their full description. The CNN, RNN and LSTM have python dependencies while Deep Averaging Networks have Java dependencies."), br(),
                        tags$h3("Number of Dimensions: Usually as this parameter increases, the model captures the similarities between the documents more accurately but they also require massive memory and lead to slower calculations"), br(),
                        tags$h3("Notes: Currently, Document Vectors are only used to train text classification models. We believe that a more experienced user should intervene to the main source code files that are related to the Document Vectors, i.e. 'Document_vectors' and 'tensorflow_keras_nn_funs'"), br(),
                      tags$h2("Classification features"), br(),
                        tags$h3("In this tab, a user can train a machine learning model based on different structures that establish document vectors. The model is trained using the 
                                dependent variable and the training dataset that are defined in the File Tab. The models are then evaluated using the observations that belong to the testing dataset which is also defined in the same Tab."),br(),
                          tags$h4("Document Term Matrix: Uses the Document Term Matrix created in the Text Preprocessing Tab to train machine learning models"), br(),
                          tags$h4("Document Term Matrix: The Document Term Matrix is manipulated so that that values greater than 0 are all transformed to 1."), br(),
                          tags$h4("Average Word Vectors: If you have established word vectors, then this approach calculates the average word vector for a document using the Document Term Matrix and the Word Vectors."), br(),
                          tags$h4("Cluster Model: This option leverages the posterior cluster memberships (Word Clustering Tab) to train machine learning models"), br(),
                          tags$h4("Topic Model: This option leverages the posterior topic memberships (Topic Modelling Tab) to train machine learning models"), br(),
                          tags$h4("Document Vectors: The Document Vevtors (Document Vectors Tab) are used  to train machine learning models"), br(),
                      tags$h2("Import Files"),br(),
                        tags$h3("The user is able to import data from an external source, i.e. his pc. Note that the Document Term Matrix, the Word Vectors and the Term Co-occurence matrix should agree. We suggest that you experiment on an existing dataset and export these files (see next Tab) so that you will understand the appropriate format of the imported data"), br(),
                      tags$h2("Export Files"),br(),
                        tags$h3("The user is able to export data to an external source, i.e. his pc. We tried to give the opportunity to export every available data structure so that the users can leverage the outcoming findings/structures for meta analysis."),br(),
                      
                      tags$h2("Thank you for using the FastTMtool, we hope that you find this guide useful. For any misunderstanding or further guidance, please commend on our repository so that we can complementary
 additional information"), br(),
                      br(),br(),br()
                      )
              
              )
  
  
) 

server <- function(input, output, session) {
  options(shiny.maxRequestSize=300*1024^2)
  
  
  
  output$Document_ratio_title<- renderText({
    "Keyword-Document frequency ratio"
  })
  
  
 
  
  
  output$no_vec<- renderText({
    temp_text=paste("Number of Words:",nrow(word_vectors_list$words))
    
    return(temp_text)
  })
  output$word_vec_dim<- renderText({
    temp_text=paste("Number of Dimensions:",ncol(word_vectors_list$words))
    return(temp_text)
  })
  
  
  output$main_table<-renderDataTable(dataset_chosen$main_matrix,caption="MAIN DATA")
  
  output$split_table<-renderDataTable(
    matrix(dataset_chosen$split2),caption="SPLIT DATA"
  )
  
  output$variable_table <- renderTable({
    df_temp=cbind(dataset_chosen$table_label,dataset_chosen$new_values)
    df_temp=cbind(names(dataset_chosen$table_label),df_temp)
    colnames(df_temp)=c("Class","Frequency","New value")
    rownames(df_temp)=NULL
    return(df_temp)})
  
  output$variable_plot<-renderPlot({

    df=data.frame(dataset_chosen$main_matrix[,dataset_chosen$class_col])
    colnames(df)="class_col"
    return(ggplot(df, aes(x=class_col))+
             geom_histogram(color="darkblue", fill="lightblue") +
             ggtitle("Target variable frequencies")) 
  })
  
  
  
  output$extra_var_plots <- renderUI({
    tagList(
      
      lapply(1:length(extra_vars$extra_var_names),
             function(i) {
               renderPlot({
        
                 df=data.frame(dataset_chosen$main_matrix[,extra_vars$extra_var_names[i]])
                 colnames(df)="class_col"
                 return(ggplot(df, aes(x=class_col))+
                          geom_histogram(color="darkblue", fill="lightblue")+
                          ggtitle(paste(extra_vars$extra_var_names[i],"frequencies"))) 
               
                 
               })
             }
      )
    )
  })
  
  output$word_barplot<-renderPlot({
   
    col_sums_all=diag(item_list_text$tcm)
    order_csa=order(col_sums_all,decreasing = T)
    
    DF=data.frame("Words"=names(col_sums_all[order_csa[1:input$word_bar_plot_no_items]]),"Occurences"=col_sums_all[order_csa[1:input$word_bar_plot_no_items]])
    p=ggplot(DF, aes(Words, Occurences)) +               
      theme(text = element_text(size = 20))+
      theme(axis.text.x = element_text(angle = 90))+
      geom_bar(stat = "identity", fill = "lightblue", color = "blue")+
      scale_x_discrete(limits = names(col_sums_all[order_csa[1:input$word_bar_plot_no_items]]))+
      ggtitle("Keyword - Document Occurence (Train Set)")
    return(p)
    
  })
  
  word_cloud_shape_react=reactive(input$word_cloud_shape)
  
  output$word_cloud<-
    renderWordcloud2({
      
      w <- data.frame(rownames(item_list_text$tcm), diag(item_list_text$tcm))
      w=w[order(w[,2],decreasing = T),]
      w=w[c(1:input$word_cloud_no_items),]
      colnames(w) <- c('word', 'freq')
      return(wordcloud2(w,
                 size = 1,
                 shape = word_cloud_shape_react(),
                 rotateRatio = 0.5,
                 minSize = 0.1,
                 color="chocolate"
                 
      ))
    })
  
  
  output$feature_table<-renderDataTable(
    
    feature_evaluation_list(),
    caption=paste("Feature Evaluation:",input$method_feature_evaluation,"No features:",input$no_feature_evaluation))
  
  
  reg_res_cluster=reactive({
    if(dataset_chosen$output_var_type=="nom_choice"){
      
      if(length( dataset_chosen$table_label)==2){
        mylogit_mat=glm(formula = as.numeric(dataset_chosen$main_matrix[dataset_chosen$split2==T,dataset_chosen$class_col]) ~., data = as.data.frame(model()$document_memberships[dataset_chosen$split2==T,]),family = binomial)
        mylogit_mat=format(summary(mylogit_mat)$coefficients,scientific=F)
        r_names=rownames(mylogit_mat); c_names=colnames(mylogit_mat)
        mylogit_mat=matrix(as.numeric(mylogit_mat),ncol=ncol(mylogit_mat));rownames(mylogit_mat)=r_names;colnames(mylogit_mat)=c_names
        #mylogit_mat[,1]=exp(mylogit_mat[,1]) #exp
        
        }else{
        target_class_res=strsplit(x = input$multinomial_reg_value_clust,split = "_")
        target_class_res=as.numeric(target_class_res[[1]][1])+1
        print(paste("Target class",target_class_res))
        df=as.factor(dataset_chosen$main_matrix[dataset_chosen$split2==T,dataset_chosen$class_col])
        df=relevel(df,ref=target_class_res)
        df=data.frame(df,as.data.frame(model()$document_memberships[dataset_chosen$split2==T,]))
        form_df=as.formula(paste(colnames(df)[1],"~",paste(colnames(df)[-1],collapse = " +")))#
        
        mylogit_mat=t((coef(multinom(form_df, data= df))))
        #mylogit_mat=exp(mylogit_mat)#exp
      }
      
      
      
    }else{
      mylogit_mat=glm(formula = as.numeric(dataset_chosen$main_matrix[dataset_chosen$split2==T,dataset_chosen$class_col]) ~., data = as.data.frame(model()$document_memberships[dataset_chosen$split2==T,]),family = gaussian)
      mylogit_mat=format(summary(mylogit_mat)$coefficients,scientific=F)
      r_names=rownames(mylogit_mat); c_names=colnames(mylogit_mat)
      mylogit_mat=matrix(as.numeric(mylogit_mat),ncol=ncol(mylogit_mat));rownames(mylogit_mat)=r_names;colnames(mylogit_mat)=c_names
      #mylogit_mat[,1]=exp(mylogit_mat[,1])
    }
    
    mylogit_mat=as.data.frame(round(mylogit_mat,4))
    
    return(mylogit_mat)
  })
  output$reg_table_clust<-renderDataTable(
    
    
    reg_res_cluster(),
    caption=paste("Regression coefficients:",input$model_choice))
  
  reg_res_topic=reactive({
    #colnames(model_topic()$document_memberships)=paste("Topic",c(1:ncol(model_topic()$document_memberships)))
    if(dataset_chosen$output_var_type=="nom_choice"){
      
      if(length( dataset_chosen$table_label)==2){
        mylogit_mat=glm(formula = as.numeric(dataset_chosen$main_matrix[dataset_chosen$split2==T,dataset_chosen$class_col]) ~., data = as.data.frame(model_topic()$document_memberships[dataset_chosen$split2==T,]),family = binomial)
        mylogit_mat=format(summary(mylogit_mat)$coefficients,scientific=F)
        r_names=rownames(mylogit_mat); c_names=colnames(mylogit_mat)
        mylogit_mat=matrix(as.numeric(mylogit_mat),ncol=ncol(mylogit_mat));rownames(mylogit_mat)=r_names;colnames(mylogit_mat)=c_names
        
      }else{
        target_class_res=strsplit(x = input$multinomial_reg_value_topic,split = "_")
        target_class_res=as.numeric(target_class_res[[1]][1])+1
        print(paste("Target class",target_class_res))
        df=as.factor(dataset_chosen$main_matrix[dataset_chosen$split2==T,dataset_chosen$class_col])
        df=relevel(df,ref=target_class_res)
        df=data.frame(df,as.data.frame(model_topic()$document_memberships[dataset_chosen$split2==T,]))
        form_df=as.formula(paste(colnames(df)[1],"~",paste(colnames(df)[-1],collapse = " +")))#
        
        mylogit_mat=t((coef(multinom(form_df, data= df))))#exp
      }
      
      mylogit_mat=as.data.frame(round(mylogit_mat,4))
      return(mylogit_mat)
    }else{
      mylogit = glm(formula = as.numeric(dataset_chosen$main_matrix[dataset_chosen$split2==T,dataset_chosen$class_col]) ~., data = as.data.frame(model_topic()$document_memberships[dataset_chosen$split2==T,]),family = gaussian)#(link = "logit")
      mylogit_mat=summary(mylogit)$coefficients
      mylogit_mat=round(mylogit_mat,4)
      return(mylogit_mat)
    }
    
    
    
  })
  output$reg_table_topic<-renderDataTable(
    
    reg_res_topic(),
    caption=paste("Regression coefficients:",input$topic_model_choice))
  
  
  output$main_plot_topic <- renderPlot({
    if(input$model_choice == 'leiden') return(plot(model()$short_visualization))
    if(input$main_plot_topic_view=="full_view"){
      #plot(model()$full_visualization)
      model()$full_visualization
    }else{
      #plot(model()$short_visualization)
      model()$short_visualization
    }
  })
  
  output$main_topic_keyword_table<-renderDataTable(model_topic()$keyword_table,caption=paste("Top Words Data - NPMI:",model_topic()$coherence_npmi,"Topic Divergence (Top terms):",model_topic()$topic_divergence,"Topic Divergence (All terms):",model_topic()$topic_divergence_all))
  
  output$main_clust_keyword_table<-renderDataTable(model()$top_terms,caption="Top Words Data")#
  
  

  
  
  
  
  
  
  output$train_acc<-renderDataTable(
    
    class_predictions_acc()$eval_list,
    caption="Models' Prediction Performance")
  
 
  
  output$topic_vis_plot_clust<- renderVis({
    model()$topic_vis
  })
  
  output$topic_vis_plot<- renderVis({
    model_topic()$topic_vis
  })
  
  
  ##Chosen dataset
  dataset_chosen=reactiveValues(main_matrix=matrix(),txt_col=NULL,class_col=NULL,spl_col=NULL,output_var_type=NULL,no_examples=NULL,split2=matrix())
   
  observeEvent(input$file_choose,{
    if (is.null(input$file_choose)) return(t(matrix(c("Text (character)","Class (numeric)","Split - Values with TRUE (train) or FALSE (test)"))))
    if(length(grep(pattern = ".xlsx",x = input$file_choose$name))>0){
      
      dataset_chosen$main_matrix=as.data.frame(read_xlsx(input$file_choose$name))
      
    }else if(length(grep(pattern = ".csv",x = input$file_choose$name))>0){
      dataset_chosen$main_matrix=as.data.frame(read.csv(input$file_choose$name))
      
    }else{
      
      dataset_chosen$main_matrix=as.data.frame(readRDS(input$file_choose$name))
      
    }
    
    
    
    updateSelectizeInput(inputId = "extra_var_col",choices = colnames(dataset_chosen$main_matrix))
    
    #txt_col spl_col class_col
    updateSelectizeInput(inputId = "txt_col",choices = colnames(dataset_chosen$main_matrix))
    updateSelectizeInput(inputId = "class_col",choices = colnames(dataset_chosen$main_matrix))
    updateSelectizeInput(inputId = "spl_col",choices = colnames(dataset_chosen$main_matrix))
    
  })
  
  
  
  
  
  #Modal for variable asssement of the target variable
  dataModal_confirm_var <- function(failed = F) {
    
    modalDialog(
     title = "Put the values in an order based on their meaning",
     lapply(1:length(dataset_chosen$table_label), function(i) {
       sliderInput(inputId = paste0("var_value_", i), label = paste("Variable value", names(dataset_chosen$table_label)[i]),
                   min = 0, max = (length(dataset_chosen$table_label)-1), value = (i-1), step = 1)
     }),
      footer = tagList(
        actionButton("cmp_var_rows",label = "Complete assessment")
        
      )
    )
  }
  
  observeEvent(input$complete_var_ass,{
    
    
    dataset_chosen$txt_col=input$txt_col
    dataset_chosen$class_col=input$class_col
    dataset_chosen$spl_col=input$spl_col
    dataset_chosen$output_var_type=input$nom_con_var
    if(dataset_chosen$output_var_type=="nom_choice"){
      updateSelectInput(inputId = "doc_vec_model",choices=list("Starspace"="star_model",'FastText'="ft_model","Deep Averaging Networks"="dan_model","Convolutional Neural Network (CNN)"="CNN","Recurrent Neural Network (RNN)"="RNN","Long Short Term Memory (LSTM)"="LSTM"))
      updateRadioButtons(inputId = "imb_options_nn",choices = list("Imbalance"=T,"No Imbalance"=F))
      
    }else if(dataset_chosen$output_var_type=="con_choice"){
      updateSelectInput(inputId = "doc_vec_model",choices=list("Deep Averaging Networks"="dan_model","Convolutional Neural Network (CNN)"="CNN","Recurrent Neural Network (RNN)"="RNN","Long Short Term Memory (LSTM)"="LSTM"))
      updateRadioButtons(inputId = "imb_options_nn",choices = list("No Imbalance"=F))
      
    }
    dataset_chosen$no_examples=nrow(dataset_chosen$main_matrix)
    
    print(paste(dataset_chosen$txt_col,dataset_chosen$class_col,dataset_chosen$spl_col))
    
    
    dataset_chosen$main_matrix[,dataset_chosen$txt_col]=as.character(unlist(dataset_chosen$main_matrix[,dataset_chosen$txt_col]))
    
    
    if(dataset_chosen$output_var_type=="con_choice"){
      dataset_chosen$main_matrix[,dataset_chosen$class_col]=as.numeric(unlist(dataset_chosen$main_matrix[,dataset_chosen$class_col]))
      na_values_match=which(is.na(dataset_chosen$main_matrix[,dataset_chosen$class_col]))
      if(length(na_values_match)>0)dataset_chosen$main_matrix[na_values_match,dataset_chosen$class_col]=median(dataset_chosen$main_matrix[,dataset_chosen$class_col],na.rm = T)
      
    }else if(dataset_chosen$output_var_type=="nom_choice"){
     
       dataset_chosen$main_matrix[,dataset_chosen$class_col]=as.character(unlist(dataset_chosen$main_matrix[,dataset_chosen$class_col]))
      
    }
    dataset_chosen$split2=matrix(unlist(dataset_chosen$main_matrix[,dataset_chosen$spl_col]))
    
    if(dataset_chosen$output_var_type=="nom_choice"){
      
      dataset_chosen$table_label=table(dataset_chosen$main_matrix[,dataset_chosen$class_col])
      
      
      
      showModal(dataModal_confirm_var())
    }
    if(dataset_chosen$output_var_type=="con_choice"){
      dataset_chosen$table_label=as.matrix(summary(dataset_chosen$main_matrix[,dataset_chosen$class_col]))
      dataset_chosen$table_label=cbind(rownames(dataset_chosen$table_label),dataset_chosen$table_label)
      colnames(dataset_chosen$table_label)=c("Measurement","Value")
    }
  })
  
  
  observeEvent(input$cmp_var_rows, {
    dataset_chosen$new_values=c()
    print(dataset_chosen$table_label)
    new_values=list()
    for(i in 1:length(dataset_chosen$table_label)){
      match_values=which(dataset_chosen$main_matrix[,dataset_chosen$class_col]==names(dataset_chosen$table_label)[i])
      new_values[match_values]=input[[paste0("var_value_", i)]]
      dataset_chosen$new_values[i]=input[[paste0("var_value_", i)]]
    }
    
    new_values=as.numeric(unlist(new_values))
    print(table(new_values))
    na_values_match=which(is.na(new_values))
    if(length(na_values_match)>0)new_values[na_values_match]=median(new_values,na.rm = T)
    
    dataset_chosen$main_matrix[,dataset_chosen$class_col]=new_values
    
    if(length(dataset_chosen$table_label)>2){
      choices_new=list()
      choices_new[paste0(names(dataset_chosen$table_label)," (",dataset_chosen$new_values,")")]=paste0((dataset_chosen$new_values),"_multnom_clust")
      print(paste("new_values",dataset_chosen$new_values))
      updateSelectizeInput(inputId = "multinomial_reg_value_clust",choices = choices_new)
      updateSelectizeInput(inputId = "multinomial_reg_value_topic",choices = choices_new)
      
    }
    
    removeModal() 
  })
  
  
  #Add extra variables
  extra_vars=reactiveValues(extra_var_names=c(),extra_var_nom_con=c(),table_extra_var=NULL)
  
  #Modal adding extra nominal variables
  dataModal_confirm_extra_var <- function(failed = F) {

    
    modalDialog(
      title = "Put the values in an order based on their meaning",
      lapply(1:length(extra_vars$table_extra_var), function(i) {
        sliderInput(inputId = paste0("extra_var_value_", i), label = paste("Variable value", names(extra_vars$table_extra_var)[i]),
                    min = 0, max = (length(extra_vars$table_extra_var)-1), value = (i-1), step = 1)
      }),
      footer = tagList(
        actionButton("cmp_extra_var_rows",label = "Complete assessment")
        
      )
    )
  }
  
  observeEvent(input$cmp_extra_var_rows, { 

    temp_extra_var=(dataset_chosen$main_matrix[,input$extra_var_col])
    
    new_values=list()
    for(i in 1:length(extra_vars$table_extra_var)){
      match_values=which(temp_extra_var==names(extra_vars$table_extra_var)[i])
      new_values[match_values]=input[[paste0("extra_var_value_", i)]]
    }
    temp_extra_var=as.numeric(unlist(new_values))
    
    na_values_match=which(is.na(temp_extra_var))
    
    if(length(na_values_match)>0)temp_extra_var[na_values_match]=median(temp_extra_var,na.rm = T)
    
    dataset_chosen$main_matrix[,input$extra_var_col]=temp_extra_var
    
   
    
    removeModal() 
  })
  
  
  observeEvent(input$add_extra_var,{
    
    if(is.na(match(input$extra_var_col,extra_vars$extra_var_names))){
    extra_vars$extra_var_names=append(extra_vars$extra_var_names,input$extra_var_col)
    
    
    
    if(input$nom_con_extra_var=="con_choice"){
      dataset_chosen$main_matrix[,input$extra_var_col]=as.numeric(unlist(dataset_chosen$main_matrix[,input$extra_var_col]))    
      na_values_match=which(is.na(dataset_chosen$main_matrix[,input$extra_var_col]))
      if(length(na_values_match)>0)dataset_chosen$main_matrix[na_values_match,input$extra_var_col]=median(dataset_chosen$main_matrix[,input$extra_var_col],na.rm = T)
      
      extra_vars$extra_var_nom_con=append(extra_vars$extra_var_nom_con,"Continuous")
      }else if(input$nom_con_extra_var=="nom_choice"){
      
      extra_vars$extra_var_nom_con=append(extra_vars$extra_var_nom_con,"Nominal")
      dataset_chosen$main_matrix[,input$extra_var_col]=as.character(unlist(dataset_chosen$main_matrix[,input$extra_var_col]))    
      extra_vars$table_extra_var=table(dataset_chosen$main_matrix[,input$extra_var_col])
      showModal(dataModal_confirm_extra_var())
    }
    
    } 
  })
  
  
  
  
  observeEvent(input$del_extra_var,{
    var_match=match(input$extra_var_col,extra_vars$extra_var_names)
    if(!is.na(var_match)){
      extra_vars$extra_var_names=extra_vars$extra_var_names[-var_match]
      extra_vars$extra_var_nom_con=extra_vars$extra_var_nom_con[-var_match]
    }
    
    
  })
  
  
  output$extra_var_display <- renderTable({
    temp_table=cbind(extra_vars$extra_var_names,extra_vars$extra_var_nom_con)
    colnames(temp_table)=c("Variable name","Variable type")
    return(temp_table)
    })
  
  
  ###Information extracted after text preprocessing
  item_list_text=reactiveValues(text=NULL,dtm=NULL,tcm=NULL)
  
  #Function called for text preprocessing
  observeEvent(input$complete_preprocessing,{
    
    temp=text_preprocessing(all_set_text = dataset_chosen$main_matrix[,dataset_chosen$txt_col],
                             
                       split2=dataset_chosen$split2,
                       is_tfidf=ifelse(input$dtm_tfidf_choose=="tf_chosen",yes=F,no = T),
                       min_doc_r=input$min_doc,
                       max_doc_r=input$max_doc,
                       ngrams_clause = input$ngrams_clause,
                       
                       ret_dtm=T,
                       do_stem =input$do_stem ,
                       do_rmv_stop = input$do_rmv_stop,
                       do_lower_case = ifelse(is.na(match("do_lower_case",input$txt_preprocess)),yes=F,no=T),
                       do_rmv_mention = ifelse(is.na(match("do_rmv_mention",input$txt_preprocess)),yes=F,no=T),
                       do_rpl_number = ifelse(is.na(match("do_rpl_number",input$txt_preprocess)),yes=F,no=T),
                       do_rpl_hash = ifelse(is.na(match("do_rpl_hash",input$txt_preprocess)),yes=F,no=T),
                       do_rpl_html = ifelse(is.na(match("do_rpl_html",input$txt_preprocess)),yes=F,no=T),
                       do_rpl_qmark = ifelse(is.na(match("do_rpl_qmark",input$txt_preprocess)),yes=F,no=T),
                       do_rpl_emark = ifelse(is.na(match("do_rpl_emark",input$txt_preprocess)),yes=F,no=T),
                       do_rpl_punct = ifelse(is.na(match("do_rpl_punct",input$txt_preprocess)),yes=F,no=T),
                       do_rpl_digit = ifelse(is.na(match("do_rpl_digit",input$txt_preprocess)),yes=F,no=T),
                       basic_preprocess = input$bp,
                       min_ngrams=input$min_ngrams,
                       max_ngrams=input$max_ngrams
                       )
    item_list_text$text=temp$text
    item_list_text$dtm=temp$dtm
    item_list_text$tcm=temp$tcm
    item_list_text$old_words=temp$old_words
  })
  
  #word vectors
  word_vectors_list=reactiveValues(words=NULL)
  
  #Building word vectors
  observeEvent(input$vector_build,{
    if(input$vector_choice=="glove_tcm"){
      word_vectors_list$words=prepare_glove(item_list_text,glove_skipgram_clause = F,ws = 21,split2=dataset_chosen$split2,dimensions=input$vector_size)
    }else if(input$vector_choice=="glove_skip"){
      word_vectors_list$words=prepare_glove(item_list_text,glove_skipgram_clause = T,ws = 21,split2=dataset_chosen$split2,dimensions=input$vector_size)
    }else if(input$vector_choice=="tdm_te"){
      word_vectors_list$words=t(binda::dichotomize(item_list_text$dtm[dataset_chosen$split2==T,],.Machine$double.xmin))
    }else if (input$vector_choice=="spearman_word_corr"){
      word_vectors_list$words=cor(x = (binda::dichotomize(item_list_text$dtm[dataset_chosen$split2==T,],.Machine$double.xmin)),method ="spearman")
      
    }else if(input$vector_choice=="glove_tcm_full"){
      word_vectors_list$words=prepare_glove(item_list_text,glove_skipgram_clause = F,ws = 21,split2=dataset_chosen$split2,full_tcm_clause=T,dimensions=input$vector_size)
    }else if(input$vector_choice=="tcm_stand"){

      word_vectors_list$words=item_list_text$tcm/diag(item_list_text$tcm)
    }else if(input$vector_choice=="tcm_rev_ii"){
      
      graph_tokens_rev_ii=item_list_text$tcm
      graph_tokens_rev_ii=graph_tokens_rev_ii/diag(graph_tokens_rev_ii)
      
      for(i in 1:(nrow(graph_tokens_rev_ii)-1)){
        
        for(j in (i+1):nrow(graph_tokens_rev_ii)){
        
          
          #min or max
          temp_val=min(graph_tokens_rev_ii[i,j],graph_tokens_rev_ii[j,i])
          
          graph_tokens_rev_ii[i,j]=temp_val
          graph_tokens_rev_ii[j,i]=temp_val
        }
      }
      word_vectors_list$words=graph_tokens_rev_ii
      
    }else if(input$vector_choice=="tcm_ii"){
      graph_tokens_rev_ii=item_list_text$tcm
      graph_tokens_rev_ii=graph_tokens_rev_ii/diag(graph_tokens_rev_ii)
      
      for(i in 1:(nrow(graph_tokens_rev_ii)-1)){
        
        for(j in (i+1):nrow(graph_tokens_rev_ii)){
          
          
          #min or max
          temp_val=min(graph_tokens_rev_ii[i,j],graph_tokens_rev_ii[j,i])
          
          graph_tokens_rev_ii[i,j]=temp_val
          graph_tokens_rev_ii[j,i]=temp_val
        }
      }
      word_vectors_list$words=graph_tokens_rev_ii
      
      
    }else if(input$vector_choice=="word2vec_skipgram"){
      h2o.init(nthreads = -1)
      word_vectors_list$words <- h2o.word2vec(training_frame = h2o.tokenize(as.h2o(item_list_text$text[dataset_chosen$split2==T]),split = " "),word_model = "SkipGram",vec_size = input$vector_size,window_size = 5)
      word_vectors_list$words <- h2o.transform(model = word_vectors_list$words,words=as.h2o(item_list_text$old_words))
      word_vectors_list$words <- as.matrix(word_vectors_list$words)
      
      rownames(word_vectors_list$words)=colnames(item_list_text$tcm)
      
      
      
      }else if(input$vector_choice=="word2vec_cbow"){
      h2o.init(nthreads = -1)
      
      word_vectors_list$words <- h2o.word2vec(training_frame = h2o.tokenize(as.h2o(item_list_text$text[dataset_chosen$split2==T]),split =" "),word_model = "CBOW",vec_size = input$vector_size,window_size = 10)
      word_vectors_list$words <- h2o.transform(model = word_vectors_list$words,words=as.h2o(item_list_text$old_words))
      word_vectors_list$words <- as.matrix(word_vectors_list$words)
      
      rownames(word_vectors_list$words)=colnames(item_list_text$tcm)
      
      }
    if(input$auto_enc==T){
      h2o.init(nthreads = -1)
      word_vectors_list$words=auto_encoders(features=word_vectors_list$words,dimensions=input$auto_enc_dim)
    }
    
    word_vectors_list$words=dimensionality_reduction_options(tSparse_colnames=colnames(item_list_text$dtm),nn = input$nn_umap,umap_metric="cosine",dim_red_options=input$dim_red_options,no_umap_dims=input$no_umap_dims,word_vectors = word_vectors_list$words,)
    
    print("word vectors done")
  })
  
  #Feature evaluation
  feature_evaluation_list=eventReactive(input$perform_feature_evaluation,{
   Feature_evaluation_methods(item_list_text = item_list_text
  ,split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],
  method_feature = input$method_feature_evaluation,matrix_feature =input$matrix_feature_evaluation ,no_feature = input$no_feature_evaluation)
  })
  
  #Feature Selection
  observeEvent(input$select_features,{
    matched_names=match(feature_evaluation_list()$Feature_name,colnames(item_list_text$dtm))
    item_list_text$dtm=item_list_text$dtm[,matched_names]
    word_vectors_list$words=word_vectors_list$words[matched_names,]
    item_list_text$tcm=item_list_text$tcm[matched_names,matched_names]
    item_list_text$old_words=item_list_text$old_words[matched_names]
    
    r_sums=rowSums(item_list_text$dtm)
    
    col_s=colSums(item_list_text$dtm)
    col_s_max=which(col_s==max(col_s))
    
    r_sums_0=which(r_sums==0)
    
    if(length(r_sums_0)>0){
      item_list_text$text[r_sums_0]=unlist(lapply(item_list_text$text[r_sums_0],function(x)paste(x,names(col_s_max))))
      item_list_text$dtm[r_sums_0,col_s_max]=1
      r_sums[r_sums_0]=1
    } 
    })
  
  #topic model from clustering approaches
  model<-eventReactive(input$model_build,{
    if(input$model_choice=="f_clust"){
      return(fclust_mapping_with_npmi(word_vectors = word_vectors_list$words,min_topics = input$min_num_top_c,topic_range = input$max_num_top_c,tSparse_train = item_list_text$dtm,center_top_Words = input$center_top_Words,l=input$num_top_c,type = "fclust",tcm = item_list_text$tcm,split2=dataset_chosen$split2,categories_assignement=dataset_chosen$main_matrix[,dataset_chosen$class_col]))
    }else if(input$model_choice=="m_clust"){
      return(fclust_mapping_with_npmi(word_vectors = word_vectors_list$words,min_topics = input$min_num_top_c,topic_range = input$max_num_top_c,tSparse_train = item_list_text$dtm,center_top_Words = input$center_top_Words,l=input$num_top_c,type = "mclust",tcm = item_list_text$tcm,split2=dataset_chosen$split2,categories_assignement=dataset_chosen$main_matrix[,dataset_chosen$class_col]))
      
    }else if(input$model_choice=="leiden"){
      ii_cond=ifelse(input$leiden_features=="word_simil",yes=T,no=F)
      ii_or_rev=ifelse(input$ii_or_rev_ii=='rev_ii_choice',yes=T,no=F)
      return(fclust_mapping_with_npmi(word_vectors = word_vectors_list$words,min_topics = input$min_num_top_c,topic_range = input$max_num_top_c,tSparse_train = item_list_text$dtm,center_top_Words = input$center_top_Words,l=input$num_top_c,type = "leiden",tcm = item_list_text$tcm,glove_leiden=ii_cond,ii_rev=ii_or_rev,stand_leiden_words_mem = input$stand_leiden_words_mem,split2=dataset_chosen$split2,categories_assignement=dataset_chosen$main_matrix[,dataset_chosen$class_col]))
      
    }
  })
  
  #topic modelling alternatives
  model_topic<-eventReactive(input$topic_model_build,{
    print(paste(input$topic_model_choice,input$no_topics,input$min_doc,input$max_doc))
    temp=(topic_models(item_list_text = item_list_text,word_vectors = word_vectors_list$words,type = input$topic_model_choice,no_topics = input$no_topics,split2=dataset_chosen$split2,iter_var=input$topic_iter,alpha_var=input$topic_alpha,beta_var=input$topic_beta,as_alpha=input$as_alpha,no_top_terms=input$num_top_t,categories_assignement=dataset_chosen$main_matrix[,dataset_chosen$class_col]))
    colnames(temp$document_memberships)=paste("Topic",c(1:ncol(temp$document_memberships)))
    colnames(temp$keyword_table)=paste("Topic",c(1:ncol(temp$keyword_table)))
    
    return(temp)
    })
  
  #document vectors
  model_docvec=reactiveValues(doc_vectors = NULL)
  observeEvent(input$docvec_model_build,{
    model_docvec$doc_vectors=Document_vectors(word_vectors=word_vectors_list$words,item_list_text=item_list_text,categories_assignement=dataset_chosen$main_matrix[,dataset_chosen$class_col],split2=dataset_chosen$split2,option=dataset_chosen$output_var_type,type=input$doc_vec_model,no_dims=input$doc_vec_dims,type_words=input$type_words_doc_vec)
    })
  
  
  
  #Random Split option
  observeEvent(input$random_split,{
    if(dataset_chosen$output_var_type=="nom_choice"){
      dataset_chosen$split2=sample.split(dataset_chosen$main_matrix[,dataset_chosen$class_col],SplitRatio=0.7)
      
    }else{
      temp_sample=sample(nrow(dataset_chosen$main_matrix),0.7*nrow(dataset_chosen$main_matrix))
      dataset_chosen$split2=rep(F,nrow(dataset_chosen$main_matrix))
      dataset_chosen$split2[temp_sample]=T
    }
    
  })
  
  observeEvent(input$all_train_split,{
    dataset_chosen$split2=rep(T,nrow(dataset_chosen$main_matrix))
  })
  
  #Updating options for the word information passed to the alternative models for building document vectors
  observeEvent(input$doc_vec_model,{
    if(input$doc_vec_model!="dan_model"){
      updateSelectizeInput(inputId = "type_words_doc_vec",choices = list("All words with no initiliazed weights"="all_words","DTM words with no initiliazed weights"="dtm_nw","DTM words with initialized weights"="dtm_ww"))
    }else{
      updateSelectizeInput(inputId = "type_words_doc_vec",choices  = list("DTM words with no initiliazed weights"="dtm_nw","DTM words with initialized weights"="dtm_ww"))
      
    }
  })
  
  
  #Classification and Regression tasks
  class_predictions_acc<-eventReactive(input$classification_w_p,{
    h2o.init(nthreads = -1)
    print(paste("extra features:",length(extra_vars$extra_var_names)))
    
    
    if(input$model_properties_choice=="s_model"){
      if(dataset_chosen$output_var_type=="nom_choice"){
      
      
      eval_list=train_test_functions(features = data.frame(model_docvec$doc_vectors,dataset_chosen$main_matrix[,extra_vars$extra_var_names]),split2 = dataset_chosen$split2,categories_assignement  = dataset_chosen$main_matrix[,dataset_chosen$class_col])
      
      
      return(eval_list)
      
      }else if(dataset_chosen$output_var_type=="con_choice"){

        eval_list=Train_Regression(features = data.frame(model_docvec$doc_vectors,dataset_chosen$main_matrix[,extra_vars$extra_var_names])
                                   ,split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col])
        return(eval_list)
        
    }
    }
    
    if(dataset_chosen$output_var_type=="con_choice"){
      if(input$model_properties_choice=="c_model"){
        Train_Regression(features = data.frame(model()$document_memberships,dataset_chosen$main_matrix[,extra_vars$extra_var_names]), split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col])
        
      }else if(input$model_properties_choice=="t_model"){
        Train_Regression(features = data.frame(model_topic()$document_memberships,dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                             split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col])
        
      }else if(input$model_properties_choice=="dtm_model"){
        
        Train_Regression(features = data.frame(item_list_text$dtm,dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                             split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col])
        
      }else if(input$model_properties_choice=="dtm_model_dich"){
        library(binda)
        
        Train_Regression(features = data.frame(dichotomize(item_list_text$dtm,thresh = .Machine$double.xmin),dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                             split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col])
        
      }else if(input$model_properties_choice=="avg_word_vec_model"){
        
        Train_Regression(features = data.frame(as.matrix(item_list_text$dtm)%*%as.matrix(word_vectors_list$words)/rowSums(item_list_text$dtm),dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                             split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col])
        
      }
    }else if(dataset_chosen$output_var_type=="nom_choice"){
      if(input$model_properties_choice=="c_model"){
         train_test_functions(features = data.frame(model()$document_memberships,dataset_chosen$main_matrix[,extra_vars$extra_var_names]), split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col])
        
      }else if(input$model_properties_choice=="t_model"){
          train_test_functions(features = data.frame(model_topic()$document_memberships,dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                               split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col])
              
        }else if(input$model_properties_choice=="dtm_model"){
          
            train_test_functions(features = data.frame(item_list_text$dtm,dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                                 split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col])
          
      }else if(input$model_properties_choice=="dtm_model_dich"){
        library(binda)
        
          train_test_functions(features = data.frame(dichotomize(item_list_text$dtm,thresh = .Machine$double.xmin),dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                               split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col])
       
      }else if(input$model_properties_choice=="avg_word_vec_model"){
        
          train_test_functions(features = data.frame(as.matrix(item_list_text$dtm)%*%as.matrix(word_vectors_list$words)/rowSums(item_list_text$dtm),dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                               split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col])
        
      }
    }
    
    

  })
  
  #Exporting options of different features
  dataset_download_chosen <- reactive({
    switch(input$download_list,
           "all_list_elements"=as.data.frame(cbind(dataset_chosen$main_matrix[,dataset_chosen$txt_col],dataset_chosen$main_matrix[,dataset_chosen$class_col],dataset_chosen$split2,dataset_chosen$main_matrix[,extra_vars$extra_var_names])), 
                       "pro_text" = as.data.frame(item_list_text$text),
                       "dtm_fin" = as.data.frame(item_list_text$dtm),
                       "tcm_fin" = data.frame(item_list_text$tcm),
                       "doc_clust_mem" = as.data.frame(model()$document_memberships),
                       "doc_topic_mem" = as.data.frame(model_topic()$document_memberships),
                       "topic_word_mem" = as.data.frame(model_topic()$phi),
                       "clust_word_mem" = as.data.frame(model()$phi),
                       "clust_top_terms" = as.data.frame(model()$top_terms),
                       "topic_top_terms" = as.data.frame(model_topic()$keyword_table),
                       "word_vectors" = data.frame(rownames(word_vectors_list$words),word_vectors_list$words),#
                       "perf_val_mem" = as.data.frame(class_predictions_acc()$eval_list),
                       "pred_ml" = as.data.frame(class_predictions_acc()$pred_list),
                       "doc_vectors" = as.data.frame(model_docvec$doc_vectors),
                       "reg_res_clust" = as.data.frame(model()$reg_res),
                       "reg_res_topic" = as.data.frame(model_topic()$reg_res),
                       "feat_selec_res" = as.data.frame(feature_evaluation_list()),
                       "split2_att"=as.data.frame(dataset_chosen$split2),
                       
    )
  })
  
   #Data import
   observeEvent(input$import_choose,{

    if(length(grep(pattern = ".xlsx",x = input$import_choose$name))>0){
      dc=read_xlsx(input$import_choose$name)
    }else if(length(grep(pattern = ".csv",x = input$import_choose$name))>0){
      dc=as.data.frame(read.csv(input$import_choose$name))
      
    }else{
      dc=readRDS(input$import_choose$name)
    }
     
     print(input$import_list)
     if(input$import_list=="dtm_fin"){
       item_list_text$dtm=as.matrix(dc)
     }else if(input$import_list=="tcm_fin"){
       
       item_list_text$tcm=as.matrix(dc)
       rownames(item_list_text$tcm)=colnames(item_list_text$tcm)
     }else if(input$import_list=="pro_text"){
      item_list_text$text=as.matrix(dc) 
     }else if(input$import_list=="word_vectors"){
       r_names=as.character(unlist(dc[,1]))
       word_vectors_list$words=as.matrix(dc[,-1])
       rownames(word_vectors_list$words)=r_names
     }else if (input$import_list=="doc_vectors"){
       model_docvec$doc_vectors=as.matrix(dc)
       }else if(input$import_list=="split2_att"){
       dataset_chosen$split2=unlist(dc[,1])
     }
     
    
    
  })
  
  # Table of selected dataset 
  output$download_table <- renderDataTable(dataset_download_chosen())
  
  # Export selected dataset in excel
  output$download_button <- downloadHandler(
    filename = function() {
      paste(input$download_list, ".xlsx", sep = "")
    },
    content = function(file) {
      write_xlsx(dataset_download_chosen(), file)
      
    }
  )
   session$onSessionEnded(function() {
     h2o.shutdown(prompt = F)
     
   })
}

shinyApp(ui, server)