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
#https://rstudio.github.io/shinydashboard/structure.html
library(shinyWidgets)
library(nnet)
library(shinythemes)
library(ggthemes)
library(hrbrthemes)
library(plotly)

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

#See shiny alert and modal



all_list=NULL
item_list_text=NULL
word_vectors_list=NULL


ui <- fluidPage(
  
  #setBackgroundColor(color = c("#C8A8D1", "#FFB6B6"),gradient = "linear",direction = c("top", "left")),
  #setBackgroundColor(color = c("#5974A4","#FFFFFF"),gradient = "linear",direction = c("top", "left")),
  #setBackgroundColor(color = c("black","black"),gradient = "linear",direction = c("top", "left")),
  
  
  #5974A4
  tags$head(tags$style(
    HTML('
         #sidebar {
            background-color: #5974A4;
            
        }
         
         '))),
  #5974A4
  tags$head(tags$style(
    HTML('
         #wellpanel {
            background-color: #5974A4;
            
        }
         
         '))),
  
  tags$head(tags$style(##cde5fe; ,  #e2e1ff; , #c5c4f3;
    HTML('
         #wellpanel_card {
            background-color: #CEE0F9;
            
        }
         
         '))),
  tags$head(tags$style(
    HTML('
         #simple_card {
            background-color: #5974A4;
            
        }
         
         '))),
  
  tags$head(tags$style(
    HTML('
         #topicvis {
            background-color: #C8A8D1;
            
        }
         
         '))),
  
  titlePanel(title = "Welcome to ClickTMtool",windowTitle = "CTMT" ),
  #tabsetPanel(type = "tabs",
  #navlistPanel("Navigation List",
  #navbarMenu("Navigation Menu",
  #dashboardSidebar()
  navbarPage(theme = shinytheme("sandstone"),
             title="", collapsible = TRUE,
              tabPanel("Hints",
                       dashboardPage(
                         dashboardHeader(title = "",disable = T),
                         dashboardSidebar(disable = T),
                       dashboardBody(style = "overflow-x:scroll;",
                         tags$head(tags$style(HTML('

                                
                                .content-wrapper, .right-side {
                                background-color: #5974A4;
                                }
                                
                                '))),
                          tags$h1("Info"),
                          fluidRow(
                            column(width = 4,valueBox(width=NULL,"Green","Green color refers to actions that have been completed.",color = "green")),
                            column(width = 4,valueBox(width=NULL,"Blue","Blue color refers to actions that can/should be completed.",color = "blue")),
                            column(width = 4,valueBox(width=NULL,"Yellow","Yellow color refers to actions that cannot be completed due to the unavailability of inputs that should be established based on previous actions/hints.",color = "yellow")),  
                          
                             ),
                         tags$h1("Actions"),
                         tags$h2("File tab"),
                         
                         #box(
                         fluidRow(
                           column(width = 6,valueBoxOutput("hint_load_files",width = NULL)),
                           column(width = 6,valueBoxOutput("hint_var_ass",width = NULL)),
                         ),
                         fluidRow(
                           column(width = 6,valueBoxOutput("hint_split",width = NULL)),
                           column(width = 6,valueBoxOutput("hint_add_var",width = NULL)),
                           
                         ),
                         tags$h2("Text preprocessing tab"),
                         tags$h3("Document Term Matrix"),
                         fluidRow(
                           column(width = 4,valueBoxOutput("hint_term_weight",width = NULL)),
                           column(width = 4,valueBoxOutput("hint_doc_freq",width = NULL)),
                           column(width = 4,valueBoxOutput("hint_pre_options",width = NULL)),
                           
                         ),
                         tags$h3("Word vectors"),
                         fluidRow(
                           column(width = 4,valueBoxOutput("hint_word_repr",width = NULL)),
                           column(width = 4,valueBoxOutput("hint_word_dim_red",width = NULL)),
                           column(width = 4,valueBoxOutput("hint_no_dim",width = NULL)),
                           
                         ),
                         tags$h2("Feature Selection tab"),
                         fluidRow(
                           column(width = 6,valueBoxOutput("hint_fe_options",width = NULL)),
                           column(width = 6,valueBoxOutput("hint_fs_complete",width = NULL)),

                         ),
                         
                         tags$h2("Word clustering tab"),
                         fluidRow(
                           column(width = 6,valueBoxOutput("hint_word_clust_model",width = NULL)),
                           column(width = 6,valueBoxOutput("hint_top_term_options_clust",width = NULL)),

                         ),
                         
                         tags$h2("Topic Modeling tab"),
                         fluidRow(
                           column(width = 6,valueBoxOutput("hint_topic_model",width = NULL)),
                           column(width = 6,valueBoxOutput("hint_top_terms_options_topic",width = NULL)),
                           
                         ),
                         
                         tags$h2("Document vectors tab"),
                         fluidRow(
                           column(width = 12,valueBoxOutput("hint_doc_vec",width = NULL))

                         ),
                         
                         tags$h2("Prediction models tab"),
                         fluidRow(
                           column(width = 12,valueBoxOutput("hint_pred_models",width = NULL))
                           
                         ),
                                              
                         )
                       
                       )
              )
                       ,
              tabPanel("File",style = "overflow-x:scroll;",
                       tabsetPanel(
                         tabPanel("Defining main variables",
                       
                         wellPanel(id="wellpanel",
                           
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
                            
                           
                           
                           ),
                       
                         
                         
                         #Visualization of the imported data
                         fluidRow(infoBox("Main Data","View the main properties of the data")),
                         wellPanel(id="wellpanel_card",
                         dataTableOutput(outputId = "main_table"),
                         ),
                         #Visualization of the Split Data
                         fluidRow(infoBox("Split Data","View the main properties of the split data. True values indicate that the record belongs to the training dataset and False values indicate that tge record belongs to the testing dataset.")),
                         wellPanel(id="wellpanel_card",
                                   dataTableOutput(outputId = "split_table"),
                         ),
                         
                         
                         
                         #Frequencies or Distribution of the target variable
                         fluidRow(infoBox("Target Variable frequencies","View the main statistics of the target variable")),
                         wellPanel(id="wellpanel_card",
                                   tableOutput(outputId = "variable_table"),
                                   
                                   #Bar plot of the target variable
                                   plotlyOutput(outputId = "variable_plot",height = 500),
                         ),
                         
                         
                        
                       
       
                       
                         ),
                       tabPanel("Defining extra variables",
                                wellPanel(id="wellpanel",
                                #Additional Variables
                                tags$h2(tags$strong("Add more variables")),
                                
                                
                                #Additional variables used in classification and regression
                                radioButtons(inputId = "nom_con_extra_var",label = "Nominal or Continuous variable?",choices = c("Nominal"="nom_choice","Continuous"="con_choice"),selected = "nom_choice"),
                                
                                selectizeInput(inputId = "extra_var_col",label="Select column",choices="Column names"),
                                fluidRow(column(width = 6,offset = 0,actionButton(inputId = "add_extra_var",label = "Add extra variable",value = 1)),column(width = 6,offset = 0,actionButton(inputId = "del_extra_var",label = "Delete extra variable",value = 2))),
                                tableOutput("extra_var_display")
                                ),
                                #Bar plots of the extra variables
                                fluidRow(infoBox("Extra Variable Frequencies","View the main statistics of the extra variables used for text classification. You can add ass many as you want.")),
                                uiOutput("extra_var_plots")
                       )
                       )
                       ),
              tabPanel("Text Preprocessing", style = "overflow-x:scroll;",
                       tabsetPanel(
                       tabPanel("Document Term Matrix",
                         wellPanel(id="wellpanel",
                           ##complete text preprocessing
                           
                           #Bag of Words or TF-IDF
                           tags$h3(tags$b("Document Representation Options")),

  
                           radioButtons(inputId="dtm_tfidf_choose",label="Term weighting",choices = c("Raw Term Count"="tf_chosen","TF-IDF"="tfidf_chosen","Binary Weights"="binarytf_chosen")),
                          
                           #Thersholds for word occurence
                           tags$h4(tags$b("Keyword-Document Frequency ratio (0.002 means that a word should occur in more than 0.2% of the training documents)"))
                           ,
                           fluidRow(column(width = 4,offset = 0,numericInput(inputId = "min_doc",label = "min",value = 0.002,min=0,max=1)),column(width = 4,offset = 0,numericInput(inputId = "max_doc",label = "max",value = 0.5,min=0,max=1))),
                           
                           #
                           tags$h4(tags$b("Ratio of All Data or Training Data")),
                           radioButtons(inputId="thres_limits_data",label="Data percentage",choices = c("All Data"="all_data_chosen","Training Data"="training_data_chosen")),
                           
                           
                           #Text preprocessing options
                           HTML(paste("<h3 style='font-weight: bold'>","Preprocessing Options","</h3>",sep="")),
                           checkboxInput(inputId = "bp",label = "Basic preprocess",value = F),
                           checkboxInput(inputId = "do_stem",label = "Do stemming",value = F),
                           checkboxInput(label = "Remove stopwords",inputId = "do_rmv_stop",value = F),
                           
                           checkboxInput(inputId = "ngrams_clause",label = "N-grams",value = F),
                           conditionalPanel(condition = "input.ngrams_clause == true",fluidRow(column(width = 4,offset = 0,numericInput(inputId = "min_ngrams",label = "min ngrams",value = 2,min=1,max=6)),column(width = 4,offset = 0,numericInput(inputId = "max_ngrams",label = "max ngrams",value = 4,min=2,max=6)))),
                           
                           conditionalPanel(condition = "input.bp== false",checkboxGroupInput(inputId = "txt_preprocess",label = "Additional Text Preprocessing Options",choices=c(
                                                                                                                                                    "lower case transformation ('DOne' -> 'done')"="do_lower_case","remove mentions ('@a' -> '')"="do_rmv_mention", "replace numbers ('1' -> 'one')"="do_rpl_number", "remove hashtags ('#a' -> '')"="do_rpl_hash","replace html ('<p>Some text</p>' -> 'Some text')"="do_rpl_html", "replace question marks ('?' -> 'questionmark')"="do_rpl_qmark", "replace exclamation marks ('!' -> 'exclamationmark')"="do_rpl_emark","replace punctutation ('.' -> '')"="do_rpl_punct","replace digits ('a1' -> 'a' , '1' -> '')"="do_rpl_digit"))),
                           actionButton(inputId = "complete_preprocessing",label = "Apply text preprocessing"),
                           
                           br(),
                           
                           textOutput("proc_time_DTM"),

                         ),
                           
                         
                         
                          
                           
                           br(),
                          fluidRow(infoBoxOutput("no_words_info_box")),
                         
                           
                           #Bar plot of word frequencies
                           tags$h2(tags$b("Barplot of Word frequencies")),
                           br(),
                           
                           numericInput(inputId = "word_bar_plot_no_items",label = "Number of Words",value = 20,min = 2),
                           br(),
                           plotlyOutput(outputId = "word_barplot",height = 1000),
                           br(),
                           br(),
                           
                         
                       
                       #Wordcloud
                      
                       tags$h2(tags$b("Wordcloud")),
                       br(),
                       fluidRow(column(width = 6,offset = 0,selectizeInput(inputId = "word_cloud_shape",label="Word Cloud Shape",choices = list("Circle"="circle","Cardioid"="cardioid","Diamond"="diamond","Triange-Forward"="triangle-forward","Triangle"="triangle","Pentagon"="pentagon","Star"="star"))),column(width = 6,offset = 0,numericInput(inputId = "word_cloud_no_items",label = "Number of Words",value = 20,min = 2))),
                       
                       br(),
                       wordcloud2Output("word_cloud",height = 1000)
                       ),
                       tabPanel("Word Representations",
                                wellPanel(id="wellpanel",
                                          #build word vectors
                                          HTML(paste("<h3 style='font-weight: bold'>","Word Representation Options","</h3>",sep="")),
                                          
                                          selectizeInput(inputId = "vector_choice",label="Select word vectors",choices = list("GloVe full binary co-occurrence"="glove_tcm","GloVe full co-occurrence"="glove_tcm_full","GloVe skipgram"="glove_skip","TCM standarized"="tcm_stand","TCM Inclusion Index"="tcm_ii","TCM reverse Inclusion Index"="tcm_rev_ii","TCM Jaccard similarity coefficient"="tcm_ji","TCM Equivalence Index"="tcm_ei","Term existence"="tdm_te","Spearman correlation coefficient on Term existence matrix"="spearman_word_corr","Word2vec (Skipgram)"="word2vec_skipgram","Word2vec (CBOW)"="word2vec_cbow")),#
                                          conditionalPanel("input.vector_choice!='tdm_te' &&  input.vector_choice!= 'spearman_word_corr' && input.vector_choice!='tcm_stand' && input.vector_choice!='tcm_rev_ii' && input.vector_choice!='tcm_ii' && input.vector_choice!='tcm_ji' && input.vector_choice!='tcm_ei' ",numericInput(inputId = "vector_size",label = "Vector size",value = 50,min = 1)),
                                          
                                          HTML(paste("<h4 style='font-weight: bold'>","Auto encoder options","</h4>",sep="")),
                                          
                                          checkboxInput(inputId = "auto_enc",label="Apply auto encoder"),
                                          numericInput(inputId = "auto_enc_dim",label = "Number of Dimensions",value = 20,min = 2),
                                          
                                          
                                          #Alternatives of Dimensionality reduction algorithms applied on word representations. Not available when the approach that is based on the Leiden algorithm and the similarity measures are selected.
                                          #When the UMAP Dimensionality reduction technique is selected, one additional parameter is available.
                                          
                                          
                                          radioButtons(inputId = "dim_red_options",label = "Dimensionality Reduction Options",choices = list("No Reduction"="no_red","UMAP"="umap_red")), #,"Factor Analysis"="factanal_red","t-SNE"="tsne_red","PCA"="pca_red","SVD"="svd_red" , "MDS" maybe
                                          numericInput(inputId = "no_umap_dims",label = "Number of Dimensions",value = 2),                 
                                          conditionalPanel(condition = "input.dim_red_options == 'umap_red'",numericInput(inputId = "nn_umap",label = "UMAP nearest neighbors",min=2,step=1,value = 5),
                                                           
                                          ),
                                          
                                          
                                          actionButton(inputId = "vector_build",label = "Build word representations"),
                                          br(),
                                          textOutput("proc_time_WV")
                                          
                                ),
                                #Output indicating the finalization of word vectors
                                tags$h2(tags$b("Information of word representations")),
                                
                                (infoBoxOutput(outputId = "no_vec")),
                                
                                (infoBoxOutput(outputId = "word_vec_dim")),
                                )
                       )
                       ),
              tabPanel("Feature Selection", style = "overflow-x:scroll;",
                        
                         wellPanel(id="wellpanel",
                           tags$h2(tags$strong("Feature Evaluation and Selection Options")),
                           
                           #Feature evaluation options
                           selectizeInput(inputId = "matrix_feature_evaluation",label="Select Matrix for feature evaluation",choices = list("Document Term Matrix"="dtm_mf","Document Term Matrix (dichotomized)"="dtmd_mf")),
                           selectizeInput(inputId = "method_feature_evaluation",label="Method for feature evaluation",choices = list(
                             "Joint impurity filter - JIM" = "jim_ff", #new
                             "Minimal joint mutual information maximisation filter - JMIM"="jmim_ff",
                             "Joint mutual information filter - JMI"="jmi_ff",
                             
                             "Mutual information maximisation filter - MIM"="mim_ff",
                             "Minimal normalised joint mutual information maximisation filter - NJMIM" = "njmim_ff", #new
                             "Minimum redundancy maximal relevancy filter- MRMR"="mrmr_ff",
                             
                             "Double input symmetrical relevance filter - DISR"="disr_ff",
                             
                             "Conditional mutual information maximisation filter - CMI"="cmi_ff", #new
                             "Minimal conditional mutual information maximisation filter - CMIM"="cmim_ff",
                             "Cosine Similarity"="cossimil_ff",
                             "Spearman Correlation"="spearman_ff"
                             )),
                           #No of features to select
                           numericInput(inputId = "no_feature_evaluation",label="Number of features",value = 20,min = 1,step = 1),
                           #Button for feature evaluation
                           actionButton(inputId = "perform_feature_evaluation",label = "Perform Feature Evaluation"),
                           
                           br(),
                           textOutput("proc_time_FE"),
                           br(),
                           
                           #Button for feature selection. Updating Document Term Matrix (DTM) and Term Co-occurence Matrix (TCM)
                           actionButton(inputId = "select_features",label = "Perform Feature Selection"),
                           br(),
                           textOutput("proc_time_FS"),
                           
                           
                         ),
                         #Feature evaluation output
                        fluidRow(infoBox("Feature Scores","Review most informative words-ngrams and exclude the rest from the analysis if needed")),
                       wellPanel(id="wellpanel_card",
                                 
                           dataTableOutput(outputId = "feature_table")
                       )
                       
                       ),
  
              tabPanel("Word Clustering", style = "overflow-x:scroll;",
                        
                       wellPanel(id="wellpanel",
                           ##build model
                           tags$h2(tags$strong("Keyword Clustering Options")),
                           
                           #Selecting one of the three proposed clustering approaches
                           selectizeInput(inputId = "model_choice",label="Select model",choices = list("Fuzzy K-means Clustering"="f_clust","Gaussian Mixtures model based clustering"="m_clust","Graph Clustering Using the Leiden Algorithm"="leiden")),
                           
                           #Additional options for the approach that is based on the Leiden algorithm
                           conditionalPanel(condition = "input.model_choice == 'leiden'",radioButtons(inputId = "leiden_features",label="Clustering Features",choices = list("Word Vectors"="word_simil","Word similarity measures"="II_simil"))),
                           conditionalPanel(condition = "input.model_choice == 'leiden' && input.leiden_features == 'II_simil'",radioButtons(inputId = "sim_option",label = "Word similarity options",choices=list("Inclusion Index"="ii_choice","Reverse Inclusion Index"="rev_ii_choice","Jaccard similarity coefficient"="ji_choice","Equivalence Index"="ei_choice"),selected = "ii_choice")),
                           
                           #Number of top terms used for the evaluation and selection of the final model based on topic coherence 
                           numericInput(inputId = "num_top_c",label = "Number of top terms",value = 10,min = 2,max = 50,step = 1),
                           
                           #Option to not include the word frequencies to identify the top words, including only the topic memberships of words produced by the selected approach.
                           checkboxInput(inputId = "center_top_Words",label = "Do not include the word frequencies to find the top words of clusters",value = F),
                           #Option to standarize the topic memberships of words produced by the approach that is based on the Leiden algorithm
                           conditionalPanel(condition = "input.model_choice == 'leiden'",checkboxInput(inputId = "stand_leiden_words_mem",label = "Do not standarize the topic memberships of words",value = F)),
                           
                           #Selecting minimum and maximum number of clusters to be evaluated. Not available when the approach that is based on the Leiden algorithm is selected.
                           conditionalPanel(condition = "input.model_choice != 'leiden'",numericInput(inputId = "min_num_top_c",label = "Minimum number of clusters",min=2,step=1,value = 2),
                                            numericInput(inputId = "max_num_top_c",label = "Maximum number of clusters",min=2,step=1,value = 20),
                                                                        ),
                           
                           
                           #Model build
                           actionButton(inputId = "model_build",label = "Build model"),
                           br(),
                           textOutput("proc_time_WC")
                         ),
                       tags$h2("Cluster evaluation"),
                       fluidRow(infoBox("Cluster evaluation","Review the performance metrics of the models according to topic coherence and divergence. The best model is selected according to the maximum coherence.")),
                       plotlyOutput(outputId = 'no_clust_eval'),
                       
                           
                       #Top terms per cluster
                       tags$h2("Top terms"),
                       fluidRow(infoBox("Top words per cluster","Inspect the most relevent words (columns) to each cluster (rows) to identify the concepts of each cluster.")),
                       
                       wellPanel(id="wellpanel_card",
                                 dataTableOutput(outputId = "main_clust_keyword_table"),
                       ),
                           
                           
                         
                       
                       
                       #Full view or short view (top terms) of the extracted clusters. Short view is not availablewhen the approach that is based on the Leiden algorithm is selected.  
                       tags$h2("2d Cluster Plot"),
                       fluidRow(infoBox("Cluster visualization","A more direct approach to inspect the clusters through 2d visualizations.")),
                       
                       conditionalPanel("input.model_choice != 'leiden'",selectizeInput(inputId = "main_plot_topic_view",label="Cluster view",choices=list("Top words View"="top_words_view","Full View"="full_view"))),
                       br(),
                       #Main visualization of words and clusters
                       plotOutput(outputId = "main_plot_topic",height = 1000),
                       
                       #Visualization of topic divergence and prevalence, based on LDAvis
                       tags$h2("LDAvis"),
                       
                       fluidRow(infoBox("Topic-based cluster visualization","A detailed analysis of the extracted topics via the LDAvis framework to understand the relative word frequencies within a cluster and the distances between clusters.")),
                       
                      wellPanel(id="topicvis", visOutput(outputId = "topic_vis_plot_clust")),
                       
                       #Results of a Generalized Linear Model using the topic memberships of the documents as independent variables and the target variable, selected in the File Tab, as the dependent variable.
                      tags$h2("Weighting"),
                      fluidRow(infoBox("Weights between the clusters and the target variable","Review significant clusters affecting the target variable through statistical analysis, i.e. regression modeling or correlation coefficients.")),
                      selectizeInput(inputId = "multinomial_reg_value_clust",label="Reference Class on Multinomial Logistic Regression",choices = list()),
                       wellPanel(id="wellpanel_card",
                       dataTableOutput(outputId = "reg_table_clust")
                       ),
                       ),
  
  
              tabPanel("Topic Modelling",style = "overflow-x:scroll;",
                        
                       wellPanel(id="wellpanel",
                           #Build topic model
                           tags$h2(tags$strong("Topic Modelling Options")),
                           #Available alternatives of topic modelling algorithms
                           fluidRow(column(width = 6,offset = 0,selectizeInput(inputId = "topic_model_choice",label="Select topic model",choices = list("Latent Dirichlet Allocation - LDA (VEM)"="LDA_vem","Latent Dirichlet Allocation - LDA (Collapsed Gibbs Sampling)"="LDA_m","Non-negatve Matrix Factorization - NMF"="NMF","Correlated Topic Models - CTM (VEM)"="CTM_vem","Structural Topic Models - STM"='STM_vem'))),column(width = 6,offset = 0,numericInput(inputId = "no_topics",label = "Number of topics",value = 10,min = 2))),
                           #,"ETM"='ETM'
                           #,"LSA"="LSA"
                           
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
                           br(),
                           textOutput("proc_time_Topic")
                           
                         ),
                         
                           #Top terms per topic
                       tags$h2("Top terms"),
                       fluidRow(infoBox("Top terms per topic","Inspect the most relevent words (columns) to each topic (rows) to identify the concepts of each topic.")),
                       wellPanel(id="wellpanel_card",
                                 dataTableOutput(outputId = "main_topic_keyword_table"),
                                 
                                 ),
                          
                           
                         
                       
                       #Visualization of topic divergence and prevalence, based on LDAvis
                       tags$h2("LDAvis"),
                       fluidRow(infoBox("Topic visualization","A detailed analysis of the extracted topics via the LDAvis framework to understand the relative word frequencies within a topic the distances between topics")),
                       wellPanel(id="topicvis",visOutput(outputId = "topic_vis_plot")),
                       
                       #Results of a Generalized Linear Model using the topic memberships of the documents as independent variables and the target variable, selected in the File Tab, as the dependent variable.
                       tags$h2("Weighting"),
                       fluidRow(infoBox("Weights between the topics and the target variable","Review significant topics affecting the target variable through statistical analysis, i.e. regression modeling or correlation coefficients.")),
                       selectizeInput(inputId = "multinomial_reg_value_topic",label="Reference Class on Multinomial Logistic Regression",choices = list()),
                       wellPanel(
                         id="wellpanel_card",
                         dataTableOutput(outputId = "reg_table_topic")
                         
                       ),
                        ),
              tabPanel("Document Vectors",style = "overflow-x:scroll;",
                       
                       wellPanel(id="wellpanel",
                           #Building Document vectors mostly based on different neural network architectures
                           tags$h2(tags$strong("Document Vector Options")),
                           
                           #Available alternatives of models
                           selectizeInput(inputId = "doc_vec_model",label = "Document Vector Types",choices=list("Latent Semantic Analysis (LSA)"="lsa_model","Starspace"="star_model",'FastText'="ft_model","Deep Averaging Networks"="dan_model")),#
                           #,"Convolutional Neural Network (CNN)"="CNN","Recurrent Neural Network (RNN)"="RNN","Long Short Term Memory (LSTM)"="LSTM"
                           #Number of dimensions
                           numericInput(inputId = "doc_vec_dims",label = "Number of Dimensions",value = 50,min = 2,step = 5),
                           #Information passed to the models, not available when the fastText or the starspace model is selected. Building a model using the all words, the words included in the Document Term Matrix with initialized weights (word vectors - see Text Preprocessing Tab) and without initialized weights. 
                           conditionalPanel("input.doc_vec_model != 'star_model' && input.doc_vec_model != 'ft_model' && input.doc_vec_model !='lsa_model'",selectizeInput(inputId = "type_words_doc_vec",label="Type of word weights initilization",choices = list("All words with no initiliazed weights"="all_words","DTM words with no initiliazed weights"="dtm_nw","DTM words with initialized weights"="dtm_ww"))),
                           #Button for model building
                           fluidRow(column(width = 4,offset = 0,actionButton(inputId = "docvec_model_build",label = "Build Document Vectors"))),
                           br(),
                           textOutput("proc_time_DV")
                           
                         ),
                         
                           #Maybe add some Information in the next update
                           tags$h2(tags$strong("Trained Document Vectors")),
                           
                          infoBoxOutput("doc_vecs_info"),
                          infoBoxOutput("doc_vecs_info_dims")
                             
                         
                       
              ),
              tabPanel("Prediction Models", style = "overflow-x:scroll;",
                        
                         wellPanel(id="wellpanel",
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
                           radioButtons(inputId = "ml_lib_choice",label="Machine learning library",choices = list(
                             "h2o"="h2o_lib",
                             "caret"="caret_lib"
                           )),
                           
                          
                           #Button for model building
                           actionButton(inputId = "classification_w_p",label = "Classification with properties"),
                           br(),
                           textOutput("proc_time_PM")
                           
                         ),
                         
                           #Visualization of Classification and Regression performance measures
                           tags$h2("Performance evaluation"),
                       fluidRow(infoBox("Performance evaluation","Inspect the performance of the different models to decide if the desired accuracy levels are reached.")),
                       wellPanel(id="wellpanel_card",
                                 dataTableOutput(outputId = "train_acc"),
                                 
                                 )    

                       
              ),
             
             tabPanel("Import Files", style = "overflow-x:scroll;",
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
             tabPanel("Export Files", style = "overflow-x:scroll;",
                      
                      
                        wellPanel(id="wellpanel",
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
                                                  
                                                  "Regression/Correlation Results (Clusters)" = "reg_res_clust",
                                                  "Regression/Correlation Results (Topics)" = "reg_res_topic",
                                                  "Feature Selection Results" = "feat_selec_res",
                                                  "Split Data (True and False values)"="split2_att"
                                                  
                                                  
                                                  )
                                                  
                                      ),
                          
                          #Button for file exporting
                          downloadButton("download_button", "Download")
                        ),
                        
                          #Visualization of the selected features
                          dataTableOutput(outputId = "download_table")
                          
                        
                      
             ),
             tabPanel("Datasets", style = "overflow-x:scroll;",
                      
                      span(tags$h2("Datasets in the Repository"),style="color:blue"),
                     
                      
                        tags$h3("File: 20newsgroup_combined.csv"),
                          tags$body("Description: The 20 Newsgroups data set is a collection of approximately 20,000 newsgroup documents, partitioned (nearly) evenly across 20 different newsgroups. Each observation has a textual decription and is assigned to 1 class indicating its general theme"),
                          br(),br(),
                          tags$body("Reference: Lang, K. (1995). Newsweeder: Learning to filter netnews. In Machine learning proceedings 1995 (pp. 331-339). Morgan Kaufmann."),
                     
                        tags$h3("File: bbc-text.csv"),
                          tags$body("Description: Dataset with 2225 observations originated from the BBC news. Each observation has a textual decription and is assigned to 1 class indicating its general theme"),
                          br(),br(),
                          tags$body("Reference: D. Greene and P. Cunningham. 'Practical Solutions to the Problem of Diagonal Dominance in Kernel Document Clustering', Proc. ICML 2006."),
                          br(),br(),
                          tags$body("Notes: This dataset was used in the Readme/Quick tour of the official ClickTMtool repository"),
                        tags$h3("File: df_title_cwe_exploit_from_2009.xlsx"),
                          tags$body("Description: 144166 records of sotware vulnerabilities from 2009 to 2023"),
                          br(),br(),
                          tags$body("Reference: Charmanas, K., Mittas, N., & Angelis, L. (2021, November). Predicting the existence of exploitation concepts linked to software vulnerabilities using text mining. In 25th Pan-Hellenic Conference on Informatics (pp. 352-356)."),
                          br(),
                          tags$body("Reference: Charmanas, K., Mittas, N., & Angelis, L. (2023). Exploitation of vulnerabilities: a topic-based machine learning framework for explaining and predicting exploitation. Information, 14(7), 403."),
                      
                          br(),br(),
                          tags$body("Notes: This dataset contains textual descriptions and multiple severity metrics of software vulneraibilities"),
                        tags$h3("File: df_exploit_no_cwe_codes (R Data Structure - RDS"),
                          tags$body("Description: 8210 records of sotware vulnerabilities from 2022. This dataset is good for practice as it is coherent, without long descriptions and a relatively small size."),
                          br(),
                          tags$body("Reference: Charmanas, K., Mittas, N., & Angelis, L. (2023). Exploitation of vulnerabilities: a topic-based machine learning framework for explaining and predicting exploitation. Information, 14(7), 403."),
                      
                          br(),br(),
                          tags$body("Reference: Charmanas, K., Mittas, N., & Angelis, L. (2021, November). Predicting the existence of exploitation concepts linked to software vulnerabilities using text mining. In 25th Pan-Hellenic Conference on Informatics (pp. 352-356)."),
                          br(), br(),
                          tags$body("Notes: This dataset contains textual descriptions and multiple severity metrics of softwware vulneraibilities"),

                      span(tags$h2("External datasets"),style="color:blue"),
                      
                      tags$h3("Note 1"),
                      tags$body("You can use external datasets but they must follow a specific data format. Currently, the following formats are supported: .csv, .xlsx, .RDS"),
                      
                      tags$h3("Note 2"),
                      tags$body("The file that is about to be loaded should be stored in the same file or subfiles of the repository"),
                      
                      tags$h3("Note 3"),
                      tags$body("The loaded file must represent a dataframe where observations are denoted by rows and variables are denoted by columns"),
                      
                      tags$h3("Note 4"),
                      tags$body("The file/dataframe MUST include the textual information (Text column) and target variable (Class column) of the observations."),
                      tags$h3("Note 5"),
                      tags$body("The file/dataframe may include (optionally) a variable indicating the split values of the observations. 
                      Values equal to TRUE indicate that the observation belongs to the training dataset
                        while values equal to FALSE indicate that the observation belongs to the testing dataset. 
                                When there are not split values, the user can define a random varable as split values (Split column) and then use the Additional Split Options of the tool"),
                      
                      tags$h3("Note 6"),
                      tags$body("Additionally, the user can define extra nominal or continuous variables to be included when training machine learning models."),
                      
                      tags$h3("Note 7"),
                      tags$body("Both nominal and continuous variables are supported, where continuous variables should exclusively include only numerical values."),
                      
                      tags$h3("Note 8"),
                      tags$body("Missing values not allowed."),
                      
                      
                      br(), br(),
                      
                      
                      span(tags$h2("Thank you for using the ClickTMtool, we hope that you find this guide useful. For any misunderstanding or further guidance, please commend on our repository so that we can complementary
 additional information"),style="color:green"), br(),
                      br(),br(),br()
                      )
              
              )
  
  
) 

server <- function(input, output, session) {
  options(shiny.maxRequestSize=300*1024^2)
  
  
  output$hint_load_files<-renderValueBox({valueBox(width=NULL,"Load File","Go to the File tab and load a file using the browse button. It is recommended to load a file from the same directory as the project. Currently, .csv, .xlsx and .RDS data formats are supported.",color = "blue")})
  
  output$hint_var_ass<-renderValueBox({valueBox(width=NULL,"Set variables","Please carefully select the variables (columns) characterizing the text, the target variable and the split attributes (train/test) with TRUE/FALSE values. Splitting is optional it can be done later as well. To confirm the selected columns, please press the 'CONFIRM VARIABLE ASSESSMENT' button. Note that you should carefully select whether the target variable constitutes a nominal/categorical/ordinal or continuous one",color = "yellow")})
  
  output$hint_split<-renderValueBox({valueBox(width=NULL,"Split data","You can split your data using the buttons 'RANDOM SPLIT 70-30' and 'NO TESTING DATASET'. Note that when defining no testing dataset, you won't be able to perfrorm text classification.",color = "yellow")})
  
  output$hint_add_var<-renderValueBox({valueBox(width=NULL,"Additional variables","You may use additional variables for text classification using 'ADD EXTRA VARIABLE' button.",color = "yellow")})
  
  output$hint_term_weight<-renderValueBox({valueBox(width=NULL,"Term weighting","'Document Term Matrix Options'.Select a term weighting function for the Document-Term Matrix. Currently the Raw Term Count or Bag of Words (number of occurences of a term within a dcoument), the Term Frequency - Inverse Document Frequency (Tf-Idf) and the Binary Weighting (0 = The word does not occur in the document , 1 = The word occurs in the document at least once) functions are supported.",color = "yellow")})
  
  output$hint_doc_freq<-renderValueBox({valueBox(width=NULL,"Exclude words","'Keyword-Document Frequency ratio'. Select the minimum and the maximum number of documents (ratio of the training dataset) that a term/word should occur to be included in the Document Term Matrix.",color = "yellow")})
  
  output$hint_pre_options<-renderValueBox({valueBox(width=NULL,"Text preprocessing options","'Preprocessing options'. Select the primary preprocessing options. You may select multiple settings from the 'Additional Text Preprocessing Options' section. To avoid these additional settings, you can select the 'Basic preprocess' option which Keeps only alphanumeric characters, Removes multiple spaces, Removes leading/trailing spaces, Performs lowercasing." ,color = "yellow")})
  
  output$hint_word_repr<-renderValueBox({valueBox(width=NULL,"Word representation type","'Select word vectors'. The initial word vectors would be based on this option." ,color = "yellow")})
  
  output$hint_word_dim_red<-renderValueBox({valueBox(width=NULL,"Dimensionality reduction","'Dimensionality Reduction Options'. You can select a dimensionality reduction algorithm to be applied the initial word vectors." ,color = "yellow")})
  
  output$hint_no_dim<-renderValueBox({valueBox(width=NULL,"Dimensionality of word vectors","'Vector size' and 'Number of Dimensions'. You can select the dimensionality of the initial word vectors (when applicable) and of the outcoming word vectors after the dimensionality reduction implementation." ,color = "yellow") })
  
  output$hint_fe_options<-renderValueBox({valueBox(width=NULL,"Feature evaluation","'PERFORM FEATURE EVALUATION'. You can select the document representation, the method and the number of the top features/words/terms to be evaluated for feature selection" ,color = "yellow")})
  
  output$hint_fs_complete<-renderValueBox({valueBox(width=NULL,"Feature selection","'PERFORM FEATURE SELECTION'. After the completion of feature evaluation, you can keep only the top terms/words as defined in feature evaluation." ,color = "yellow")})
  
  
  output$hint_word_clust_model<-renderValueBox({valueBox(width=NULL,"Word clustering models","'Select model'. According to your preferences, you can select an algorithm which will be used to implement word clustering." ,color = "yellow")})
  
  output$hint_top_term_options_clust<-renderValueBox({valueBox(width=NULL,"Top terms","You can define the number of terms to be selected when evaluating a word clustering model. Since the word clustering process automatically identifies the best model based on coherence, this choice is vital. In addition, you may use the two last checkboxes to alter the function that is used to select the top words/terms of each cluster." ,color = "yellow")})
  
  
  output$hint_topic_model<-renderValueBox({valueBox(width=NULL,"Topic model selection","You can select a topic modeling algorithm among the available options and define the number of topics to be evaluated in order to identify the underlying topics within your dataset." ,color = "yellow")})
  
  
  output$hint_top_terms_options_topic<-renderValueBox({valueBox(width=NULL,"Topic terms","You can define the top terms that will be used to evaluate the topic coherence and divergence of the trained model." ,color = "yellow")})
  
  
  output$hint_doc_vec<-renderValueBox({valueBox(width=NULL,"Document vectors","You can establish document vectors/representations and select their dimensionality (Number of Dimensions). Document vectors can be used for text classification" ,color = "yellow")})
  
  output$hint_pred_models<-renderValueBox({valueBox(width=NULL,"Text classification","You can use the different options for document representations in order to build classification models (on training subset) and evaluate their performance (on testing subset). Note that, different performance measures are calculated according to the nature of the target variable (nominal/continuous). For more information about the machine learning models please review the h2o and caret packages." ,color = "yellow")})
  

  
 
  
  
 
  
  
  output$no_vec<- renderInfoBox({
    infoBox("Number of Words",nrow(word_vectors_list$words))
    
  })
  output$word_vec_dim<- renderInfoBox({
    infoBox("Number of Dimensions",ncol(word_vectors_list$words))
  })
  
  
  output$main_table<-renderDataTable(dataset_chosen$main_matrix,caption="MAIN DATA")
  
  output$split_table<-renderDataTable(
    matrix(dataset_chosen$split2),caption="SPLIT DATA"
  )
  
  output$variable_table <- renderTable({
    if(dataset_chosen$output_var_type=="nom_choice"){
      df_temp=cbind(dataset_chosen$table_label,dataset_chosen$new_values)
      df_temp=cbind(names(dataset_chosen$table_label),df_temp)
      colnames(df_temp)=c("Class","Frequency","New value")
      
    }else if (dataset_chosen$output_var_type=="con_choice"){
      df_temp = dataset_chosen$table_label
      df_temp=cbind(names(dataset_chosen$table_label),df_temp)
      colnames(df_temp)=c("Measure","Value")
      
    }
    
    rownames(df_temp)=NULL
    return(df_temp)})
  
  output$variable_plot<-renderPlotly({

    df=data.frame(dataset_chosen$main_matrix[,dataset_chosen$class_col])
    colnames(df)="class_col"
    return(
      ggplotly(
        ggplot(df, aes(x=class_col))+
             geom_histogram(color="darkblue", fill="lightblue") +
             ggtitle("Target variable frequencies")+
              xlab("value")+
             theme_solarized_2(light = F)) 
    )
  })
  
  
  
  output$extra_var_plots <- renderUI({
    if(length(extra_vars$extra_var_names)>0){
      tagList(
        
        lapply(1:length(extra_vars$extra_var_names),
               function(i) {
                 renderPlotly({
                   
                   df=data.frame(dataset_chosen$main_matrix[,extra_vars$extra_var_names[i]])
                   colnames(df)="class_col"
                   return(
                     ggplotly(
                       ggplot(df, aes(x=class_col))+
                         geom_histogram(color="darkblue", fill="lightblue")+
                         ggtitle(paste(extra_vars$extra_var_names[i],"frequencies"))+
                         xlab("value")+
                         theme_solarized_2(light = F)) 
                   )
                   
                 })
               }
        )
      )
    }
    
  })
  
  output$word_barplot<-renderPlotly({
   
    col_sums_all=diag(item_list_text$tcm)
    order_csa=order(col_sums_all,decreasing = T)
    
    DF=data.frame("Words"=names(col_sums_all[order_csa[1:input$word_bar_plot_no_items]]),"Occurences"=col_sums_all[order_csa[1:input$word_bar_plot_no_items]])
    p=
      ggplotly(
      ggplot(DF, aes(Words, Occurences)) +               
      theme(text = element_text(size = 20))+
      theme(axis.text.x = element_text(angle = 90))+
      geom_bar(stat = "identity", fill = "lightblue", color = "blue")+
      scale_x_discrete(limits = names(col_sums_all[order_csa[1:input$word_bar_plot_no_items]]))+
      ggtitle("Keyword - Document Occurence (Train Set)")+
      ylab("Number of documents")+
      theme_solarized_2(light = F)+
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
      )
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
                 color="chocolate", backgroundColor = "black"
                 #, color = "random-light"
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
      #mylogit_mat=glm(formula = as.numeric(dataset_chosen$main_matrix[dataset_chosen$split2==T,dataset_chosen$class_col]) ~., data = as.data.frame(model()$document_memberships[dataset_chosen$split2==T,]),family = gaussian)
      #mylogit_mat=format(summary(mylogit_mat)$coefficients,scientific=F)
      
      mylogit_mat=cor(cbind(as.data.frame(model()$document_memberships[dataset_chosen$split2==T,]),as.numeric(dataset_chosen$main_matrix[dataset_chosen$split2==T,dataset_chosen$class_col])),method="spearman")
      colnames(mylogit_mat)[ncol(mylogit_mat)]="Target Variable"
      rownames(mylogit_mat)=colnames(mylogit_mat)
      
      r_names=rownames(mylogit_mat); c_names=colnames(mylogit_mat)
      mylogit_mat=matrix(as.numeric(mylogit_mat),ncol=ncol(mylogit_mat));rownames(mylogit_mat)=r_names;colnames(mylogit_mat)=c_names
      #mylogit_mat[,1]=exp(mylogit_mat[,1])
    }
    
    mylogit_mat=as.data.frame(round(mylogit_mat,4))
    
    return(mylogit_mat)
  })
  output$reg_table_clust<-renderDataTable(
    
    
    reg_res_cluster(),
    caption=paste("Coefficients:",input$model_choice))
  
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
      #mylogit = glm(formula = as.numeric(dataset_chosen$main_matrix[dataset_chosen$split2==T,dataset_chosen$class_col]) ~., data = as.data.frame(model_topic()$document_memberships[dataset_chosen$split2==T,]),family = gaussian)#(link = "logit")
      #mylogit_mat=summary(mylogit)$coefficients
      
      mylogit_mat=cor(cbind(as.data.frame(model_topic()$document_memberships[dataset_chosen$split2==T,]),as.numeric(dataset_chosen$main_matrix[dataset_chosen$split2==T,dataset_chosen$class_col])),method="spearman")
      colnames(mylogit_mat)[ncol(mylogit_mat)]="Target Variable"
      rownames(mylogit_mat)=colnames(mylogit_mat)
      
      mylogit_mat=round(mylogit_mat,4)
      return(mylogit_mat)
    }
    
    
    
  })
  output$reg_table_topic<-renderDataTable(
    
    reg_res_topic(),
    caption=paste("Coefficients:",input$topic_model_choice))
  
  
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
  
  output$main_topic_keyword_table<-renderDataTable(t(as.matrix(model_topic()$keyword_table)),caption=paste("Top Words Data - NPMI:",round(as.numeric(model_topic()$coherence_npmi),3),"Topic Divergence (Top terms):",round(as.numeric(model_topic()$topic_divergence),3),"Topic Divergence (All terms):",round(as.numeric(model_topic()$topic_divergence_all),3)))
  
  output$main_clust_keyword_table<-renderDataTable(t(as.matrix(model()$top_terms)),caption=paste("Top Words Data - NPMI:",round(as.numeric(model()$max_coh),3),"Topic Divergence (Top terms):",round(as.numeric(model()$topic_divergence),3),"Topic Divergence (All terms):",round(as.numeric(model()$topic_divergence_all),3)))#
  

  
  
  output$no_clust_eval<-renderPlotly({
    if(!is.null(model()$f_clust)|!is.null(model()$m_clust)){
      if((clust_no_range$max- clust_no_range$min) >0){
        
      
    
    max_topics_l=clust_no_range$max- clust_no_range$min+1
    
    ev_1=unlist(model()$coherence_npmi)[(clust_no_range$min-1):(clust_no_range$max-1)]
    ev_2=unlist(model()$topic_divergence_list)[(clust_no_range$min-1):(clust_no_range$max-1)]
    ev_3=unlist(model()$topic_divergence_all_list)[(clust_no_range$min-1):(clust_no_range$max-1)]
    
    #a=ev_1+ev_2+ev_3
    
    
    df=data.frame("Type"=c(rep("Coherence",max_topics_l),rep("Topic_Divergence",max_topics_l),rep("Topic_Divergence_ALL",max_topics_l)),#,rep("SUM",max_topics_l)
                  "Eval"=c(ev_1,ev_2,ev_3),#,a
                  "No_topics"=c(clust_no_range$min:clust_no_range$max,clust_no_range$min:clust_no_range$max,clust_no_range$min:clust_no_range$max))#,clust_no_range$min:clust_no_range$max

    
    library(ggplot2)
    library(plotly)
    library(ggthemes)
    ggplotly(ggplot(data=df, aes(x=No_topics, y=Eval, group=Type)) +
               geom_line(aes(color=Type))+
               geom_point(aes(color=Type))+
               theme(
                 panel.background = element_rect(fill = "white",
                                                 colour = "lightblue",
                                                 size = 0.5, linetype = "solid"),
                 panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                                 colour = "lightgrey"), 
                 panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                                 colour = "lightgrey")
               )+
               ggtitle("Evaluation of different numbers of clusters/topics")+
               xlab("Number of Clusters")+
               ylab("Evaluation")+
               theme_solarized_2(light = F)
    )
    
      }
    
    }
  })
  
  
  
  
  
  
  output$train_acc<-renderDataTable(
    
    data.frame(round(class_predictions_acc()$eval_list,3),"Training time seconds"=round(unlist(class_predictions_acc()$training_time),3)),
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
      
      output$hint_load_files<-renderValueBox({valueBox(width=NULL,"Load File","Go to the File tab and load a file using the browse button. It is recommended to load a file from the same directory as the project. Currently, .csv, .xlsx and .RDS data formats are supported.",color = "green")})
      output$hint_var_ass<-renderValueBox({valueBox(width=NULL,"Set variables","Please carefully select the variables (columns) characterizing the text, the target variable and the split attributes (train/test) with TRUE/FALSE values. Splitting is optional it can be done later as well. To confirm the selected columns, please press the 'CONFIRM VARIABLE ASSESSMENT' button. Note that you should carefully select whether the target variable constitutes a nominal/categorical/ordinal or continuous one",color = "blue")})
      
      
      
    }
    
    #extra_vars=reactiveValues(extra_var_names=c(),extra_var_nom_con=c(),table_extra_var=NULL)

    extra_vars$extra_var_names=c()
    extra_vars$extra_var_nom_con=c()
    extra_vars$table_extra_var=NULL
    
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
      updateSelectInput(inputId = "doc_vec_model",choices=list("Latent Semantic Analysis (LSA)"="lsa_model","Starspace"="star_model",'FastText'="ft_model","Deep Averaging Networks"="dan_model"))#
      #,"Convolutional Neural Network (CNN)"="CNN","Recurrent Neural Network (RNN)"="RNN","Long Short Term Memory (LSTM)"="LSTM"
      #updateRadioButtons(inputId = "imb_options_nn",choices = list("Imbalance"=T,"No Imbalance"=F))
      updateSelectInput(inputId = "method_feature_evaluation",choices = list(
        "Joint impurity filter - JIM" = "jim_ff", #new
        "Minimal joint mutual information maximisation filter - JMIM"="jmim_ff",
        "Joint mutual information filter - JMI"="jmi_ff",
        
        "Mutual information maximisation filter - MIM"="mim_ff",
        "Minimal normalised joint mutual information maximisation filter - NJMIM" = "njmim_ff", #new
        "Minimum redundancy maximal relevancy filter- MRMR"="mrmr_ff",
        
        "Double input symmetrical relevance filter - DISR"="disr_ff",
        
        "Conditional mutual information maximisation filter - CMI"="cmi_ff", #new
        "Minimal conditional mutual information maximisation filter - CMIM"="cmim_ff"
      ))
    }else if(dataset_chosen$output_var_type=="con_choice"){
      updateSelectInput(inputId = "doc_vec_model",choices=list("Latent Semantic Analysis (LSA)"="lsa_model","Deep Averaging Networks"="dan_model"))#
      #,"Convolutional Neural Network (CNN)"="CNN","Recurrent Neural Network (RNN)"="RNN","Long Short Term Memory (LSTM)"="LSTM"
      #updateRadioButtons(inputId = "imb_options_nn",choices = list("No Imbalance"=F))
      updateSelectInput(inputId = "method_feature_evaluation",choices = list(
        "Cosine Similarity"="cossimil_ff",
        "Spearman Correlation"="spearman_ff"
      ))
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
    
    removeUI(selector = "#ml_sample_choice")
    removeUI(selector = "#ml_bal_choice")
    
    
    if(dataset_chosen$output_var_type=="nom_choice"){
      
      dataset_chosen$table_label=table(dataset_chosen$main_matrix[,dataset_chosen$class_col])
      
      
      insertUI(selector = "#ml_lib_choice",where = "afterEnd",
      ui=conditionalPanel(condition = "input.ml_lib_choice =='caret_lib'",
                       radioButtons(inputId = "ml_sample_choice",label="Imbalance handling",choices = list(
                         "Upsampling"="up_sample_choice",
                         "Downsampling"="down_sample_choice"
                       ))
      )
      )
      
      insertUI(selector = "#ml_lib_choice",where = "afterEnd",ui=conditionalPanel(condition = "input.ml_lib_choice =='h2o_lib'",radioButtons(inputId = "ml_bal_choice",label="Imbalance handling",choices = list("Weighting"="weight_choice","Resampling"="balance_choice"))))
      
      
      
      showModal(dataModal_confirm_var())
    }
    if(dataset_chosen$output_var_type=="con_choice"){
      dataset_chosen$table_label=as.matrix(summary(dataset_chosen$main_matrix[,dataset_chosen$class_col]))
      dataset_chosen$table_label=cbind(rownames(dataset_chosen$table_label),dataset_chosen$table_label)
      colnames(dataset_chosen$table_label)=c("Measurement","Value")
      
      
      
      
      
    }
    

    
    output$hint_var_ass<-renderValueBox({valueBox(width=NULL,"Set variables","Please carefully select the variables (columns) characterizing the text, the target variable and the split attributes (train/test) with TRUE/FALSE values. Splitting is optional it can be done later as well. To confirm the selected columns, please press the 'CONFIRM VARIABLE ASSESSMENT' button. Note that you should carefully select whether the target variable constitutes a nominal/categorical/ordinal or continuous one",color = "green")})
    output$hint_split<-renderValueBox({valueBox(width=NULL,"Split data","You can split your data using the buttons 'RANDOM SPLIT 70-30' and 'NO TESTING DATASET'. Note that when defining no testing dataset, you won't be able to perfrorm text classification.",color = "blue")})
    output$hint_add_var<-renderValueBox({valueBox(width=NULL,"Additional variables","You may use additional variables for text classification using 'ADD EXTRA VARIABLE' button.",color = "blue")})
    
    output$hint_term_weight<-renderValueBox({valueBox(width=NULL,"Term weighting","'Document Term Matrix Options'.Select a term weighting function for the Document-Term Matrix. Currently the Raw Term Count or Bag of Words (number of occurences of a term within a dcoument), the Term Frequency - Inverse Document Frequency (Tf-Idf) and the Binary Weighting (0 = The word does not occur in the document , 1 = The word occurs in the document at least once) functions are supported.",color = "blue")})
    output$hint_doc_freq<-renderValueBox({valueBox(width=NULL,"Exclude words","'Keyword-Document Frequency ratio'. Select the minimum and the maximum number of documents (ratio of the training dataset) that a term/word should occur to be included in the Document Term Matrix.",color = "blue")})
    output$hint_pre_options<-renderValueBox({valueBox(width=NULL,"Text preprocessing options","'Preprocessing options'. Select the primary preprocessing options. You may select multiple settings from the 'Additional Text Preprocessing Options' section. To avoid these additional settings, you can select the 'Basic preprocess' option which Keeps only alphanumeric characters, Removes multiple spaces, Removes leading/trailing spaces, Performs lowercasing." ,color = "blue")})
    
    
    
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
    if(length(extra_vars$extra_var_names)>0){
      
    temp_table=cbind(extra_vars$extra_var_names,extra_vars$extra_var_nom_con)
    colnames(temp_table)=c("Variable name","Variable type")
    
    return(temp_table)
    }
    })
  
  
  ###Information extracted after text preprocessing
  item_list_text=reactiveValues(text=NULL,dtm=NULL,tcm=NULL)
  
  #Function called for text preprocessing
  observeEvent(input$complete_preprocessing,{
    
    showModal(modalDialog(title = "Text is getting processed please wait",footer=NULL))
    
    start_time=proc.time()[3]
    
    temp=text_preprocessing(all_set_text = dataset_chosen$main_matrix[,dataset_chosen$txt_col],
                            thres_limits_data=input$thres_limits_data  ,   
                       split2=dataset_chosen$split2,
                       term_weight_fun=input$dtm_tfidf_choose,
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
    end_time=proc.time()[3]
    
    
    
    item_list_text$text=temp$text
    item_list_text$dtm=temp$dtm
    item_list_text$tcm=temp$tcm
    item_list_text$old_words=temp$old_words
    
    
    output$no_words_info_box<-renderInfoBox({
      infoBox("No words or ngrams", paste(nrow(item_list_text$tcm),"Unique items"),icon = icon('list'),color='blue')
    })
    
    removeModal()
    
    output$proc_time_DTM<- renderText({return(paste("Processing time in seconds to construct Document Term Matrix:",round((end_time-start_time),3)))})#
    
    
    output$hint_term_weight<-renderValueBox({valueBox(width=NULL,"Term weighting","'Document Term Matrix Options'.Select a term weighting function for the Document-Term Matrix. Currently the Raw Term Count or Bag of Words (number of occurences of a term within a dcoument), the Term Frequency - Inverse Document Frequency (Tf-Idf) and the Binary Weighting (0 = The word does not occur in the document , 1 = The word occurs in the document at least once) functions are supported.",color = "green")})
    output$hint_doc_freq<-renderValueBox({valueBox(width=NULL,"Exclude words","'Keyword-Document Frequency ratio'. Select the minimum and the maximum number of documents (ratio of the training dataset) that a term/word should occur to be included in the Document Term Matrix.",color = "green")})
    output$hint_pre_options<-renderValueBox({valueBox(width=NULL,"Text preprocessing options","'Preprocessing options'. Select the primary preprocessing options. You may select multiple settings from the 'Additional Text Preprocessing Options' section. To avoid these additional settings, you can select the 'Basic preprocess' option which Keeps only alphanumeric characters, Removes multiple spaces, Removes leading/trailing spaces, Performs lowercasing." ,color = "green")})
    
    output$hint_word_repr<-renderValueBox({valueBox(width=NULL,"Word representation type","'Select word vectors'. The initial word vectors would be based on this option." ,color = "blue")})
    
    output$hint_word_dim_red<-renderValueBox({valueBox(width=NULL,"Dimensionality reduction","'Dimensionality Reduction Options'. You can select a dimensionality reduction algorithm to be applied the initial word vectors." ,color = "blue")})
    
    output$hint_no_dim<-renderValueBox({valueBox(width=NULL,"Dimensionality of word vectors","'Vector size' and 'Number of Dimensions'. You can select the dimensionality of the initial word vectors (when applicable) and of the outcoming word vectors after the dimensionality reduction implementation." ,color = "blue") })
    
    output$hint_fe_options<-renderValueBox({valueBox(width=NULL,"Feature evaluation","'PERFORM FEATURE EVALUATION'. You can select the document representation, the method and the number of the top features/words/terms to be evaluated for feature selection" ,color = "blue")})
    
    output$hint_topic_model<-renderValueBox({valueBox(width=NULL,"Topic model selection","You can select a topic modeling algorithm among the available options and define the number of topics to be evaluated in order to identify the underlying topics within your dataset." ,color = "blue")})
    
    
    output$hint_top_terms_options_topic<-renderValueBox({valueBox(width=NULL,"Topic terms","You can define the top terms that will be used to evaluate the topic coherence and divergence of the trained model." ,color = "blue")})
    
    
    output$hint_doc_vec<-renderValueBox({valueBox(width=NULL,"Document vectors","You can establish document vectors/representations and select their dimensionality (Number of Dimensions). Document vectors can be used for text classification" ,color = "blue")})
    
    output$hint_pred_models<-renderValueBox({valueBox(width=NULL,"Text classification","You can use the different options for document representations in order to build classification models (on training subset) and evaluate their performance (on testing subset). Note that, different performance measures are calculated according to the nature of the target variable (nominal/continuous)." ,color = "blue")})
    
    
  })
  
  #word vectors
  word_vectors_list=reactiveValues(words=NULL)
  
  #Building word vectors
  observeEvent(input$vector_build,{
    showModal(modalDialog(title = "Training word vectors please wait",footer=NULL))
    start_time=proc.time()[3]
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
      
      
    }else if(input$vector_choice=="tcm_ji"){
      graph_tokens_rev_ii=item_list_text$tcm
      
      for(i in 1:(nrow(graph_tokens_rev_ii)-1)){
        for(j in (i+1):nrow(graph_tokens_rev_ii)){
          
          temp_val=(graph_tokens_rev_ii[i,j])/( graph_tokens_rev_ii[i,i] + graph_tokens_rev_ii[j,j] - graph_tokens_rev_ii[i,j])
          graph_tokens_rev_ii[i,j]=temp_val
          graph_tokens_rev_ii[j,i]=temp_val
        }
      }
      diag(graph_tokens_rev_ii)=1
      word_vectors_list$words=graph_tokens_rev_ii
      
      
    }else if(input$vector_choice=="tcm_ei"){
      graph_tokens_rev_ii=item_list_text$tcm
      
      for(i in 1:(nrow(graph_tokens_rev_ii)-1)){
        for(j in (i+1):nrow(graph_tokens_rev_ii)){
          
          temp_val=(graph_tokens_rev_ii[i,j]^2)/( graph_tokens_rev_ii[i,i]* graph_tokens_rev_ii[j,j])
          graph_tokens_rev_ii[i,j]=temp_val
          graph_tokens_rev_ii[j,i]=temp_val
        }
      }
      diag(graph_tokens_rev_ii)=1
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
    
    end_time=proc.time()[3]
    
    
    
    print("word vectors done")
    removeModal()
    
    output$proc_time_WV<- renderText({return(paste("Processing time in seconds to construct Word Vectors:",round((end_time-start_time),3)))})
    
    
    output$hint_word_repr<-renderValueBox({valueBox(width=NULL,"Word representation type","'Select word vectors'. The initial word vectors would be based on this option." ,color = "green")})
    
    output$hint_word_dim_red<-renderValueBox({valueBox(width=NULL,"Dimensionality reduction","'Dimensionality Reduction Options'. You can select a dimensionality reduction algorithm to be applied the initial word vectors." ,color = "green")})
    
    output$hint_no_dim<-renderValueBox({valueBox(width=NULL,"Dimensionality of word vectors","'Vector size' and 'Number of Dimensions'. You can select the dimensionality of the initial word vectors (when applicable) and of the outcoming word vectors after the dimensionality reduction implementation." ,color = "green") })
    
    
    output$hint_word_clust_model<-renderValueBox({valueBox(width=NULL,"Word clustering models","'Select model'. According to your preferences, you can select an algorithm which will be used to implement word clustering." ,color = "blue")})
    
    output$hint_top_term_options_clust<-renderValueBox({valueBox(width=NULL,"Top terms","You can define the number of terms to be selected when evaluating a word clustering model. Since the word clustering process automatically identifies the best model based on coherence, this choice is vital. In addition, you may use the two last checkboxes to alter the function that is used to select the top words/terms of each cluster." ,color = "blue")})
    
    
  })
  
  #Feature evaluation
  feature_evaluation_list=eventReactive(input$perform_feature_evaluation,{
    showModal(modalDialog(title = "Feature evaluation is in progress please wait",footer = NULL))
    start_time=proc.time()[3]
   temp_f=Feature_evaluation_methods(item_list_text = item_list_text
  ,split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],
  method_feature = input$method_feature_evaluation,matrix_feature =input$matrix_feature_evaluation ,no_feature = input$no_feature_evaluation)
  
   end_time=proc.time()[3]
   
   
   
   
   
   
   removeModal()
  
   output$proc_time_FE<- renderText({return(paste("Processing time in seconds to complete Feature evaluation:",round((end_time-start_time),3)))})
   
   
  output$hint_fe_options<-renderValueBox({valueBox(width=NULL,"Feature evaluation","'PERFORM FEATURE EVALUATION'. You can select the document representation, the method and the number of the top features/words/terms to be evaluated for feature selection" ,color = "green")})
  
  output$hint_fs_complete<-renderValueBox({valueBox(width=NULL,"Feature selection","'PERFORM FEATURE SELECTION'. After the completion of feature evaluation, you can keep only the top terms/words as defined in feature evaluation." ,color = "blue")})
  
  
  
  return(temp_f)
   })
  
  #Feature Selection
  observeEvent(input$select_features,{
    showModal(modalDialog(title = "Feature selection is in progress please wait",footer = NULL))
    start_time=proc.time()[3]
    
    
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
    
    end_time=proc.time()[3]
    
    
    removeModal()
    
    output$proc_time_FS<- renderText({return(paste("Processing time in seconds to complete Feature selection:",round((end_time-start_time),3)))})
    
    
    output$hint_fs_complete<-renderValueBox({valueBox(width=NULL,"Feature selection","'PERFORM FEATURE SELECTION'. After the completion of feature evaluation, you can keep only the top terms/words as defined in feature evaluation." ,color = "green")})
    
    }
    )
  
  #topic model from clustering approaches
  clust_no_range=reactiveValues(min=NULL,max=NULL)
  
  
  model<-eventReactive(input$model_build,{
    showModal(modalDialog(title = "Word clustering is in progress please wait",footer = NULL))
    
    start_time=proc.time()[3]
    
    if(input$model_choice=="f_clust"){
      temp=(fclust_mapping_with_npmi(word_vectors = word_vectors_list$words,min_topics = input$min_num_top_c,topic_range = input$max_num_top_c,tSparse_train = item_list_text$dtm,center_top_Words = input$center_top_Words,l=input$num_top_c,type = "fclust",tcm = item_list_text$tcm,split2=dataset_chosen$split2,categories_assignement=dataset_chosen$main_matrix[,dataset_chosen$class_col]))
    }else if(input$model_choice=="m_clust"){
      temp=(fclust_mapping_with_npmi(word_vectors = word_vectors_list$words,min_topics = input$min_num_top_c,topic_range = input$max_num_top_c,tSparse_train = item_list_text$dtm,center_top_Words = input$center_top_Words,l=input$num_top_c,type = "mclust",tcm = item_list_text$tcm,split2=dataset_chosen$split2,categories_assignement=dataset_chosen$main_matrix[,dataset_chosen$class_col]))
      
    }else if(input$model_choice=="leiden"){
      ii_cond=ifelse(input$leiden_features=="word_simil",yes=T,no=F)
      temp=(fclust_mapping_with_npmi(word_vectors = word_vectors_list$words,min_topics = input$min_num_top_c,topic_range = input$max_num_top_c,tSparse_train = item_list_text$dtm,center_top_Words = input$center_top_Words,l=input$num_top_c,type = "leiden",tcm = item_list_text$tcm,glove_leiden=ii_cond,stand_leiden_words_mem = input$stand_leiden_words_mem,split2=dataset_chosen$split2,categories_assignement=dataset_chosen$main_matrix[,dataset_chosen$class_col],sim_option=input$sim_option))
      
    }
    
    end_time=proc.time()[3]
    
    

    colnames(temp$document_memberships)=paste("Cluster",c(1:ncol(temp$document_memberships)))
    colnames(temp$top_terms)=paste("Cluster",c(1:ncol(temp$top_terms)))
    
    clust_no_range$min=input$min_num_top_c
    clust_no_range$max=input$max_num_top_c
    
    
    
    removeModal()
    
    output$proc_time_WC<- renderText({return(paste("Processing time in seconds to construct Word clustering models:",round((end_time-start_time),3)))})
    
    
    output$hint_word_clust_model<-renderValueBox({valueBox(width=NULL,"Word clustering models","'Select model'. According to your preferences, you can select an algorithm which will be used to implement word clustering." ,color = "green")})
    
    output$hint_top_term_options_clust<-renderValueBox({valueBox(width=NULL,"Top terms","You can define the number of terms to be selected when evaluating a word clustering model. Since the word clustering process automatically identifies the best model based on coherence, this choice is vital. In addition, you may use the two last checkboxes to alter the function that is used to select the top words/terms of each cluster." ,color = "green")})
    
    
    return(temp)
    })
  
  #topic modelling alternatives
  model_topic<-eventReactive(input$topic_model_build,{
    showModal(modalDialog(title = "Topic modeling is in progress please wait",footer = NULL))
    start_time=proc.time()[3]
    
    print(paste(input$topic_model_choice,input$no_topics,input$min_doc,input$max_doc))
    temp=(topic_models(item_list_text = item_list_text,word_vectors = word_vectors_list$words,type = input$topic_model_choice,no_topics = input$no_topics,split2=dataset_chosen$split2,iter_var=input$topic_iter,alpha_var=input$topic_alpha,beta_var=input$topic_beta,as_alpha=input$as_alpha,no_top_terms=input$num_top_t,categories_assignement=dataset_chosen$main_matrix[,dataset_chosen$class_col]))
    colnames(temp$document_memberships)=paste("Topic",c(1:ncol(temp$document_memberships)))
    colnames(temp$keyword_table)=paste("Topic",c(1:ncol(temp$keyword_table)))
    
    end_time=proc.time()[3]
    
    
    
    removeModal()
    
    output$proc_time_Topic <- renderText({return(paste("Processing time in seconds to construct Topic models:",round((end_time-start_time),3)))})
    
    
    output$hint_topic_model<-renderValueBox({valueBox(width=NULL,"Topic model selection","You can select a topic modeling algorithm among the available options and define the number of topics to be evaluated in order to identify the underlying topics within your dataset." ,color = "green")})
    
    
    output$hint_top_terms_options_topic<-renderValueBox({valueBox(width=NULL,"Topic terms","You can define the top terms that will be used to evaluate the topic coherence and divergence of the trained model." ,color = "green")})
    
    
    
    
    return(temp)
    })
  
  
  #output$doc_vecs_info<-renderText("Not trained yet")
  
  #document vectors
  model_docvec=reactiveValues(doc_vectors = NULL)
  observeEvent(input$docvec_model_build,{
    showModal(modalDialog(title = "Training document vectors please wait",footer = NULL))
    start_time=proc.time()[3]
    model_docvec$doc_vectors=Document_vectors(word_vectors=word_vectors_list$words,item_list_text=item_list_text,categories_assignement=dataset_chosen$main_matrix[,dataset_chosen$class_col],split2=dataset_chosen$split2,option=dataset_chosen$output_var_type,type=input$doc_vec_model,no_dims=input$doc_vec_dims,type_words=input$type_words_doc_vec)
    
    end_time=proc.time()[3]
    
    
    
    model_trained_temp=switch(input$doc_vec_model,"lsa_model"="LSA","star_model"="Starspace","ft_model"='FastText',"dan_model"="Deep Averaging Networks","CNN"="Convolutional Neural Network (CNN)","RNN"="Recurrent Neural Network (RNN)","LSTM"="Long Short Term Memory (LSTM)")
    output$doc_vecs_info<-renderInfoBox(
      {
        infoBox("Type:",model_trained_temp)
      }
      )
    output$doc_vecs_info_dims<-renderInfoBox(
      {
        infoBox("No dimensions",ncol(model_docvec$doc_vectors))
        
      }
    )
    removeModal()
    
    output$proc_time_DV <- renderText({return(paste("Processing time in seconds to construct Document Vectors:",round((end_time-start_time),3)))})
    
    
    output$hint_doc_vec<-renderValueBox({valueBox(width=NULL,"Document vectors","You can establish document vectors/representations and select their dimensionality (Number of Dimensions). Document vectors can be used for text classification" ,color = "green")})
    
    
    })
  
  
  
  #Random Split option
  observeEvent(input$random_split,{
    showModal(modalDialog(title = "Splitting data please wait",footer = NULL))
    
    if(dataset_chosen$output_var_type=="nom_choice"){
      dataset_chosen$split2=sample.split(dataset_chosen$main_matrix[,dataset_chosen$class_col],SplitRatio=0.7)
      
    }else{
      library(caret)
      temp_sample= createDataPartition(dataset_chosen$main_matrix[,dataset_chosen$class_col], p = .7, times = 1)

      dataset_chosen$split2=rep(F,nrow(dataset_chosen$main_matrix))
      

      dataset_chosen$split2[temp_sample[[1]]]=T
      
    }
    removeModal()
    
    output$hint_split<-renderValueBox({valueBox(width=NULL,"Split data","You can split your data using the buttons 'RANDOM SPLIT 70-30' and 'NO TESTING DATASET'. Note that when defining no testing dataset, you won't be able to perfrorm text classification.",color = "green")})
    
    
  })
  
  observeEvent(input$all_train_split,{
    showModal(modalDialog(title = "Splitting data please wait",footer = NULL))
    
    dataset_chosen$split2=rep(T,nrow(dataset_chosen$main_matrix))
    removeModal()
    
    output$hint_split<-renderValueBox({valueBox(width=NULL,"Split data","You can split your data using the buttons 'RANDOM SPLIT 70-30' and 'NO TESTING DATASET'. Note that when defining no testing dataset, you won't be able to perfrorm text classification.",color = "green")})
    
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
    showModal(modalDialog(title = "Text classification is in progress please wait",footer = NULL))
    start_time=proc.time()[3]
    
    print(paste("extra features:",length(extra_vars$extra_var_names)))
    
    
    if(input$model_properties_choice=="s_model"){
      if(dataset_chosen$output_var_type=="nom_choice"){
      
      
     eval_list=train_test_functions(features = data.frame(model_docvec$doc_vectors,dataset_chosen$main_matrix[,extra_vars$extra_var_names])
                                    ,split2 = dataset_chosen$split2,categories_assignement  = dataset_chosen$main_matrix[,dataset_chosen$class_col],ml_lib = input$ml_lib_choice, ml_sample_choice=input$ml_sample_choice
                                    ,weight_or_balance = input$ml_bal_choice)
      
      
      
      
      }else if(dataset_chosen$output_var_type=="con_choice"){

        eval_list=Train_Regression(features = data.frame(model_docvec$doc_vectors,dataset_chosen$main_matrix[,extra_vars$extra_var_names])
                                   ,split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],ml_lib = input$ml_lib_choice)
        
        
    }
    }
    
    if(dataset_chosen$output_var_type=="con_choice"){
      if(input$model_properties_choice=="c_model"){
        eval_list=Train_Regression(features = data.frame(model()$document_memberships,dataset_chosen$main_matrix[,extra_vars$extra_var_names]), split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],ml_lib = input$ml_lib_choice)
        
      }else if(input$model_properties_choice=="t_model"){
        eval_list=Train_Regression(features = data.frame(model_topic()$document_memberships,dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                             split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],ml_lib = input$ml_lib_choice)
        
      }else if(input$model_properties_choice=="dtm_model"){
        
        eval_list=Train_Regression(features = data.frame(item_list_text$dtm,dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                             split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],ml_lib = input$ml_lib_choice)
        
      }else if(input$model_properties_choice=="dtm_model_dich"){
        library(binda)
        
        eval_list=Train_Regression(features = data.frame(dichotomize(item_list_text$dtm,thresh = .Machine$double.xmin),dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                             split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],ml_lib = input$ml_lib_choice)
        
      }else if(input$model_properties_choice=="avg_word_vec_model"){
        
        eval_list=Train_Regression(features = data.frame(as.matrix(item_list_text$dtm)%*%as.matrix(word_vectors_list$words)/rowSums(item_list_text$dtm),dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                             split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],ml_lib = input$ml_lib_choice)
        
      }
    }else if(dataset_chosen$output_var_type=="nom_choice"){
      if(input$model_properties_choice=="c_model"){
        eval_list=train_test_functions(features = data.frame(model()$document_memberships,dataset_chosen$main_matrix[,extra_vars$extra_var_names]), split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],ml_lib = input$ml_lib_choice, ml_sample_choice=input$ml_sample_choice
                                       ,weight_or_balance = input$ml_bal_choice)
        
      }else if(input$model_properties_choice=="t_model"){
        eval_list=train_test_functions(features = data.frame(model_topic()$document_memberships,dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                               split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],ml_lib = input$ml_lib_choice, ml_sample_choice=input$ml_sample_choice
                               ,weight_or_balance = input$ml_bal_choice)
              
        }else if(input$model_properties_choice=="dtm_model"){
          
          eval_list=train_test_functions(features = data.frame(item_list_text$dtm,dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                                 split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],ml_lib = input$ml_lib_choice, ml_sample_choice=input$ml_sample_choice
                                 ,weight_or_balance = input$ml_bal_choice)
          
      }else if(input$model_properties_choice=="dtm_model_dich"){
        library(binda)
        
        eval_list= train_test_functions(features = data.frame(dichotomize(item_list_text$dtm,thresh = .Machine$double.xmin),dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                               split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],ml_lib = input$ml_lib_choice, ml_sample_choice=input$ml_sample_choice
                               ,weight_or_balance = input$ml_bal_choice)
       
      }else if(input$model_properties_choice=="avg_word_vec_model"){
        
        eval_list=train_test_functions(features = data.frame(as.matrix(item_list_text$dtm)%*%as.matrix(word_vectors_list$words)/rowSums(item_list_text$dtm),dataset_chosen$main_matrix[,extra_vars$extra_var_names]),
                               split2 = dataset_chosen$split2,categories_assignement = dataset_chosen$main_matrix[,dataset_chosen$class_col],ml_lib = input$ml_lib_choice, ml_sample_choice=input$ml_sample_choice
                               ,weight_or_balance = input$ml_bal_choice)
        
      }
    }
    
    end_time=proc.time()[3]
    
    
    
    removeModal()
    
    output$proc_time_PM<- renderText({return(paste("Processing time in seconds to construct and evaluate predictive Machine Learning models:",round((end_time-start_time),3)))})
    
    
    output$hint_pred_models<-renderValueBox({valueBox(width=NULL,"Text classification","You can use the different options for document representations in order to build classification models (on training subset) and evaluate their performance (on testing subset). Note that, different performance measures are calculated according to the nature of the target variable (nominal/continuous)." ,color = "green")})
    
    
    
    return(eval_list)
    
    

  },)
  
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
                       "reg_res_clust" = as.data.frame(reg_res_cluster()),
                       "reg_res_topic" = as.data.frame(reg_res_topic()),
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