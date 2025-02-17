library(shiny)
library(shinyjs)
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
library(viridis)
library(plotly)
library(philentropy)
library(binda)
library(praznik)
library(ggrepel)
library(textmineR)


set.seed(831)


source("functions/text_preprocessing.R")
source("functions/prepare_glove.R")
source("functions/prepare_glove_new.R")

source("functions/fclust_mapping_with_npmi.R")
source("functions/find_coh.R")

source("functions/topic_models.R")
source("functions/topic_extraction_new.R")

source("functions/train_test_class_new.R")
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
            background-color: #fcba03;
            
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
  
  
  
  
  
  tags$style(HTML("
    .info-box {
        background-color: #fcba03 !important; /* Card background color */
        color: white !important; /* Text color */
        border-radius: 15px !important; /* Rounded corners */
        padding: 20px !important; /* Padding for a card-like effect */
        margin: 10px 0 !important; /* Spacing between cards */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2) !important; /* Shadow effect */
        display: flex !important;
        flex-direction: column !important; /* Stack icon and content vertically */
        align-items: center !important; /* Center-align content */
        text-align: center !important; /* Center-align text */
        width: 100% !important; /* Set full width */
        max-width: 1000px !important; /* Optional: Limit max width */
    }
    .info-box-icon {
        flex: 0 0 auto !important; /* Allow icon to size naturally */
        text-align: center !important; /* Center the icon */
        background-color: #1e3fa7 !important; /* Optional: Background color for icon */
        color: white !important; /* Icon color */
        display: flex !important; /* Flexbox for centering icon */
        align-items: center !important; /* Vertically center icon */
        justify-content: center !important; /* Horizontally center icon */
        height: 80px !important; /* Larger height for the icon container */
        width: 80px !important; /* Fixed width for icon container */
        border-radius: 50% !important; /* Circular icon container */
        margin-bottom: 15px !important; /* Space between icon and text */
    }
    .info-box-content {
        flex: 1 !important; /* Allow content to grow */
        font-size: 24px !important; /* Larger font size for better readability */
    }
    .info-box-title {
        font-weight: bold !important; /* Bold title */
        font-size: 24px !important; /* Larger font size for title */
    }
    .info-box-number {
        font-size: 24px !important; /* Larger font size for number */
    }
")),
  
  tags$head(
    tags$style(HTML("
      /* General Table Styling */
      table.dataTable {
        border-collapse: collapse !important;
        width: 100% !important;
        font-family: 'Arial', sans-serif;
      }
      /* Header Row Styling */
      table.dataTable thead th {
        background-color: #fcba03; /* Green Header */
        color: white;
        font-weight: bold;
        text-align: center;
        border: 1px solid #dddddd;
        font-size: 14px;
      }
      /* Body Cell Styling */
      table.dataTable tbody td {
        text-align: center;
        color: #333333;
        font-size: 13px;
        padding: 8px;
        border: 1px solid #dddddd;
        vertical-align: middle;
      }
      /* Hover Effects */
      table.dataTable tbody tr:hover {
        background-color: #f1f1f1 !important;
      }
      /* Alternate Row Colors */
      table.dataTable.stripe tbody tr:nth-child(odd) {
        background-color: #f9f9f9;
      }
      table.dataTable.stripe tbody tr:nth-child(even) {
        background-color: #ffffff;
      }
      /* Highlight Selected Row */
      table.dataTable tbody tr.selected {
        background-color: #d1ecf1 !important;
        color: #0c5460 !important;
      }
    "))
  ),
  
  
  titlePanel(title = "Welcome to LaborTMtool",windowTitle = "LTMT" ),
  #tabsetPanel(type = "tabs",
  #navlistPanel("Navigation List",
  #navbarMenu("Navigation Menu",
  #dashboardSidebar()
  
 
  
  navbarPage(theme = shinytheme("sandstone"), id="main_page_all",#theme = shinytheme("yeti") shinytheme("sandstone") #simplex
             title="", collapsible = T,
              
              tabPanel(id="file_tab",title="Load Data",value = "file_tab_val",style = "overflow-x:scroll;",
                       
                       tags$h1("Finalize data properties"),
                       
                       tabsetPanel(id="File_tab_pan",
                         tabPanel(id='sel_file',title = "Select file", 
                                   wellPanel(id="wellpanel",
                                             tags$h2("Step 1: Select a file from the machine"),
                                             fileInput(inputId = "file_choose",label = "Select your Dataset"),
                                             
                                             ),
                                  
                               
                                  dataTableOutput(outputId = "main_table"),
                                  
                                   
                                   
                                   
                         ),
                         tabPanel(id="define_filt",title = "Filters",
                                   

                                  wellPanel(id="wellpanel",
                                            tags$h2("Select categorical variables to create groups"),
                                            
                                            # Autocomplete input
                                          
                                            selectInput(
                                              
                                              inputId = "select_filter_option", 
                                              label = "Select one or more options", 
                                              choices = NULL,
                                              multiple = T ,
                                              
                                              
                                            ),
                                            
                                            actionButton(inputId = "complete_var_ass",label = "Confirm variables"),
                                            
                                  ),
                                  tags$h2("Group Details"),
                                  
                                  wellPanel(id="wellpanel1",
                                            
                                         dataTableOutput("label_table"),
                                         
                                         ),
                                  tags$h2('Filter new groups (Double click on cell for edit)'),
                                  
                                  wellPanel(id="wellpanel1",
                                  
                                  fluidRow(column(width = 2,DTOutput("label_table_new")),column(width = 2,uiOutput("group_remove_check_box_UI"))) ,
                                  br(),br(),
                                  actionButton(inputId = "complete_groups_but",label = "Confirm groups for the analysis")
                                  
                                  )
                         )
                         
                         
                         
                       )
                      

                       
              ),

             tabPanel(id="text_pre_tab",title="Text Preprocessing",value = "text_pre_tab_val",style = "overflow-x:scroll;",
                      tabsetPanel(
               tabPanel("Document Term Matrix",
                        wellPanel(id="wellpanel",
                                  ##complete text preprocessing
                                  radioGroupButtons("dtm_option_sel",label = "Document-Term Matrix option",choices = list("Preprocessing"="pre_opt","Import new file"="file_opt")),
                                  conditionalPanel("input.dtm_option_sel=='pre_opt'",
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
                                                   checkboxInput(inputId = "bp",label = "Basic preprocess",value = T),
                                                   checkboxInput(inputId = "do_stem",label = "Do stemming",value = T),
                                                   checkboxInput(label = "Remove stopwords",inputId = "do_rmv_stop",value = T),
                                                   
                                                   checkboxInput(inputId = "ngrams_clause",label = "N-grams",value = F),
                                                   conditionalPanel(condition = "input.ngrams_clause == true",fluidRow(column(width = 4,offset = 0,numericInput(inputId = "min_ngrams",label = "min ngrams",value = 2,min=1,max=6)),column(width = 4,offset = 0,numericInput(inputId = "max_ngrams",label = "max ngrams",value = 4,min=2,max=6)))),
                                                   
                                                   conditionalPanel(condition = "input.bp== false",checkboxGroupInput(inputId = "txt_preprocess",label = "Additional Text Preprocessing Options",choices=c(
                                                     "lower case transformation ('DOne' -> 'done')"="do_lower_case","remove mentions ('@a' -> '')"="do_rmv_mention", "replace numbers ('1' -> 'one')"="do_rpl_number", "remove hashtags ('#a' -> '')"="do_rpl_hash","replace html ('<p>Some text</p>' -> 'Some text')"="do_rpl_html", "replace question marks ('?' -> 'questionmark')"="do_rpl_qmark", "replace exclamation marks ('!' -> 'exclamationmark')"="do_rpl_emark","replace punctutation ('.' -> '')"="do_rpl_punct","replace digits ('a1' -> 'a' , '1' -> '')"="do_rpl_digit"))),
                                                   actionButton(inputId = "complete_preprocessing",label = "Apply text preprocessing"),
                                                   
                                                   ),
                                  conditionalPanel("input.dtm_option_sel=='file_opt'",fileInput(inputId = "complete_dtm_load",label = "Load existing Document-Term Matrix")),
                                  

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
                                  
                                  selectizeInput(inputId = "vector_choice",label="Select word vectors",choices = list("Standarized co-occurences"="tcm_stand",
                                                                                                                      "GloVe full binary co-occurrence"="glove_tcm",
                                                                                                                      "GloVe full co-occurrence"="glove_tcm_full"
                                                                                                                      #,"GloVe skipgram"="glove_skip"
                                                                                                                      #"TCM Inclusion Index"="tcm_ii",
                                                                                                                      #"TCM reverse Inclusion Index"="tcm_rev_ii",
                                                                                                                      #"TCM Jaccard similarity coefficient"="tcm_ji",
                                                                                                                      #"TCM Equivalence Index"="tcm_ei",
                                                                                                                      #"Term existence"="tdm_te",
                                                                                                                      #"Spearman correlation coefficient on Term existence matrix"="spearman_word_corr",
                                                                                                                      #"Word2vec (Skipgram)"="word2vec_skipgram",
                                                                                                                      #"Word2vec (CBOW)"="word2vec_cbow")
                                                                                                                      )),#
                                  
                                  conditionalPanel("input.vector_choice!='tdm_te' &&  input.vector_choice!= 'spearman_word_corr' && input.vector_choice!='tcm_stand' && input.vector_choice!='tcm_rev_ii' && input.vector_choice!='tcm_ii' && input.vector_choice!='tcm_ji' && input.vector_choice!='tcm_ei' ",numericInput(inputId = "vector_size",label = "Vector size",value = 50,min = 1)),
                                  
                                  HTML(paste("<h4 style='font-weight: bold'>","Auto encoder options","</h4>",sep="")),
                                  
                                  checkboxInput(inputId = "auto_enc",label="Apply auto encoder"),
                                  numericInput(inputId = "auto_enc_dim",label = "Number of Dimensions",value = 20,min = 2),
                                  
                                  
                                  #Alternatives of Dimensionality reduction algorithms applied on word representations. Not available when the approach that is based on the Leiden algorithm and the similarity measures are selected.
                                  #When the UMAP Dimensionality reduction technique is selected, one additional parameter is available.
                                  
                                  
                                  radioButtons(inputId = "dim_red_options",label = "Dimensionality Reduction Options",choices = list("UMAP"="umap_red","No Reduction"="no_red")), #,"Factor Analysis"="factanal_red","t-SNE"="tsne_red","PCA"="pca_red","SVD"="svd_red" , "MDS" maybe
                                  numericInput(inputId = "no_umap_dims",label = "Number of Dimensions",value = 5),                 
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
               ),
               tabPanel("Topic Extraction",

                        fluidRow(infoBoxOutput("text_groups_not_done")),      
                        
                        br(),br(),
                        
                        tags$h1("Develop models for each Group"),
                        br(),
                        tabsetPanel(
                          tabPanel("Auto topic extraction",
                          wellPanel(id="wellpanel",
                                    tags$h1("Please select algorithm to proceed and the range of topics"),
                                    selectizeInput(inputId = "topic_model_alg",label="Select algorithm",
                                                   choices=list("Non-Negative Matrix Factorization (NMF)"="nmf",
                                                                "Latent Dirichlet Allocation (LDA)"="lda",
                                                                "Fuzzy K-means (FKM)"="fkm",
                                                                "Gaussian Mixture Models (GMM)"="gmm"
                                                   )),
                                    selectInput(inputId = "topic_model_group",label="Select groups",multiple = T,choices=NULL),
                                    
                                    numericInput(inputId = "min_num_topics",label = "Minimum number of topics",min=2,step=1,value = 2),
                                    numericInput(inputId = "max_num_topics",label = "Maximum number of topics",min=2,step=1,value = 20),
                                    
                                    numericInput(inputId = "no_top_terms_topics",label = "Number of top terms for evaluation",min=2,step=1,value = 5),
                                    
                                    radioGroupButtons(inputId = "topic_rank_opt",label = "Select criterion",choices = list("Topic Coherence"="tc_rank","Topic Divergence (Top words per topic)"="td_rank","Combined Rank"="all_rank")),
                                    br(),
                                    tags$h4("Start the process"),
                                    actionButton("topic_model_set","Confirm Settings"),
                                    textOutput("proc_time_topic")
                                    
                          ),
                          ),
                          tabPanel("Manual topic extraction",
                                  wellPanel( id="wellpanel",
                                   selectizeInput(inputId = "topic_model_alg_man",label="Select algorithm",
                                                  choices=list("Latent Dirichlet Allocation (LDA)"="lda",
                                                               "Non-Negative Matrix Factorization (NMF)"="nmf",
                                                               "Fuzzy K-means (FKM)"="fkm",
                                                               "Gaussian Mixture Models (GMM)"="gmm"
                                                  )),
                                   selectizeInput(inputId = "topic_model_group_man",label="Select Group",choices=NULL),
                                   numericInput("num_topics_man",label="Select number of topics",min = 2,step=1,value = 10),
                                   actionButton("topic_model_set_man","Confirm Settings"),
                                   textOutput("proc_time_topic_man")
                                   
                          )
                          )
                        ),
                        br(),br(),
                        tags$h1("Inspect the developed models"),
                        wellPanel(id="wellpanel",
                                  
                          selectizeInput(inputId = "topic_model_inspect_sel",label="Select Group to inspect",choices=NULL),
                          br(),
                          tags$h2("Model evaluations"),
                          dataTableOutput("topic_model_inspect_perf_eval"),#,label="Inspect evaluations per topic"
                          br(),
                          tags$h2("Top words per topic"),
                          br(),
                          dataTableOutput("topic_model_inspect_top_words")#,label="Inspect top words per topic"
                          
                          
                        )

                        
               ),
               tabPanel("Confirmation",
                        wellPanel(id="wellpanel",
                                  tags$h2("Please develop a document term matrix and word vectors.Also, make sure that you set a topic model for each group (see the card)"),
                                 actionButton("confirm_dtm_wv","Confirm Settings"), 
                                 
                        )
                        )
             )
  ),
  tabPanel(id="main_dashboard",value = "main_dashboard_val",title = "Main dashboard",style = "overflow-x:scroll;",
                      
                         tags$h1("Overview"),
           
           downloadButton("download_data","Download the data"),
           br(),
                          
                            fluidRow(
                                 infoBoxOutput(outputId = "no_obs_dash"),
                                 infoBoxOutput(outputId = "no_groups_dash"),
                                 infoBoxOutput(outputId = "no_words_now"),
                                
                            ),
                          
                                   
                         br(),br(),

           
           tags$h2("Groups"),
           wellPanel(#id="wellpanel_card",#"wellpanel_card" "wellpanel"
             dataTableOutput("groups_view")
           ),
           
                        br(),br(),

                        
                        tags$h1("Data Details"),
                        wellPanel(#id="wellpanel_card",
                          dataTableOutput("main_data_view"),
                        ),
           ),
  tabPanel(id="text_analytics",value = "text_analytics_val",title = "Text Analytics",style = "overflow-x:scroll;",
           
           tabsetPanel(
             tabPanel("Word Information",
                      
                      tags$h1("Global word frequencies"),
                      br(),
                      
                      wellPanel(
                        plotlyOutput("glob_word_frequencies_plot"),
                        
                        br(),
                        numericInput("glob_word_pag",label = "Page",value = 1,min = 1,step = 1),
                        
                        br(),br(),
                        dataTableOutput("glob_word_frequencies_table"),
                        
                   
                      ),
                      br(),
                      tags$h1("Word frequencies per group"),
                      wellPanel(
                        
                        selectizeInput(inputId = "select_group_word_freq",label="Select group",choices=NULL),
                        br(),
                        plotlyOutput("group_word_frequencies_plot"),
                        br(),
                        numericInput("group_word_pag",label = "Page",value = 1,min = 1,step = 1),
                        br(),br(),
                        dataTableOutput("group_word_frequencies_table"),

                        

                      ),
             ),
             tabPanel("Group Projection",
                      tags$h1("Content-based group projection"),
                      wellPanel(
                        actionButton(inputId = "start_projection_but","Start projection"),
                        br(),br(),
                        
                        tags$h1("2d projection of groups (Multidimensional scaling)"),
                        br(),
                        plotlyOutput(outputId = "text_projection"),
                        
                        br(),br(),
                        tags$h1("Distances between groups (Jensen-Shannon Divergence)"),
                        br(),
                        plotlyOutput(outputId = "group_simil"),
                        br(),
                        selectizeInput(inputId = "select_group_group_simil",label="Select target group",choices=NULL),
                        
                      )
               
             ),
             tabPanel("Key features",
                      tags$h1("Find key features (Mutual Information)"),
                      wellPanel( 
                                 dataTableOutput("glob_word_mutual_info")
                      ),
                      
                      tags$h1("Find key features per group"),
                      wellPanel(id="wellpanel",
                        selectizeInput(inputId = "select_group_key_feat","Select group",choices=NULL),
                        actionButton("start_key_feat","Confirm Settings")
                      ),
                      br(),
                      tags$h2("Feature evaluation (Mutual Information and Spearman Correlation)"),
                      wellPanel(
                        dataTableOutput("feat_info_one_output")
                      ),
                      br(),
                      tags$h2("Unanticipated features"),
                      
                      wellPanel(
                        tags$h3("Word percentage in group versus outside the group"),
                        dataTableOutput("key_feat_one_output"),

                      )
                      
               
             )
           ),

          
                   ),
  tabPanel(id="topic_analysis",value = "topic_analysis_tab",title = "Topic analysis",style = "overflow-x:scroll;",
           
           tabsetPanel(
             tabPanel(title = "Topic Information",
                      wellPanel(
                        tags$h1("Details per group"),
                        dataTableOutput("topic_group_gen_info")
                      ),
                      
                      tags$h1("Topic Inspection per group"),
           wellPanel(
                     br(),
                     selectizeInput(inputId = "topic_analysis_inspect_sel",label="Select Group to inspect",choices=list()),
                     br(),
                     tags$h2("Evaluations of different No topics"),
                     dataTableOutput("topic_analysis_no_dif_topics"),
                     
                     tags$h2("Topic size"),
                     br(),
                     dataTableOutput("topic_analysis_topic_size"),
                     tags$h2("Top words per topic (Table)"),
                     br(),
                     dataTableOutput("topic_analysis_inspect_top_words"),#,label="Inspect top words per topic"
                     br(),
                     tags$h2("Top words per topic (Plot)"),
                     selectizeInput(inputId = "topic_analysis_inspect_sel_topic",label="Select topic to inspect",choices=NULL),
                     br(),
                     plotlyOutput(outputId = "topic_analysis_inspect_top_words_topic"),
                     numericInput(inputId = "topic_analysis_inspect_top_words_page",label = "Page",min = 1,max = Inf,value = 1)

                     
           )
             ),
           tabPanel(title = "Topic comparisons",
                    wellPanel(id="wellpanel",
                       selectInput(inputId = "topic_comp_sel",label = "Select groups to compare",choices = NULL,multiple = T),
                       actionButton(inputId = "topic_comp_but",label = "Confirm Settings")
                    ),
                    wellPanel(
                      tags$h2("Topic projection"),
                      plotlyOutput("topic_comp_plot"),
                     
                      br(),
                      
                      tags$h2("Details with a target group"),
                      fluidRow(column(4,selectizeInput("topic_comp_table_sel_group","Select Target Group",choices=NULL)),column(4,selectizeInput("topic_comp_table_sel_topic","Select Topic",choices=NULL))),
                      dataTableOutput("topic_comp_table_filt")   ,
                      
                      br(),
   
                      tags$h2("Topic distances"),
                      dataTableOutput("topic_comp_table"),
                    )
                    ),
           tabPanel(title = "Key topics",
                    br(),
                    tabsetPanel(
                      tabPanel(title = "Global Topics",
                        tags$h1("Analysis per topic"),
                        wellPanel(id="wellpanel",
                          selectizeInput(inputId = "select_global_topic","Select topic",choices=NULL),
                          actionButton("start_global_key_topic","Confirm Settings")
                          
                        ),
                        br(),
                        tags$h1("Outputs"),
                        wellPanel(
                          tags$h2("Topic percentage in group versus percentage outside the group"),
                          dataTableOutput("global_key_topic_unant"),
                          br(),
                          tags$h2("Boxplots per group"),
                          plotlyOutput("global_key_topic_boxplots"),
                          

                        )
                      ),
                      tabPanel(title = "Group Topics",
                               tags$h1("Find key topics per group"),
                               wellPanel(id="wellpanel",
                                         selectizeInput(inputId = "select_group_key_topic","Select group",choices=NULL),
                                         actionButton("start_group_key_topic","Confirm Settings")
                               ), 
                               br(),
                               
                               tags$h1("Coherence comparison of top words"),
                               wellPanel(
                                 
                                 tags$h2("Settings"),
                                 numericInput("coh_sel_top_comp",label="No top words",value=2,min=2,max=NA),
                                 actionButton("coh_sel_confirm_comp",label="Confirm Settings"),
                                 
                                 br(),
                                 tags$h2("Output"),
                                 dataTableOutput("coh_sel_output_comp")
                                 
                               ),
                               
                               br(),
                               
                               tags$h1("Distance from other topics"),
                               
                               
                               wellPanel(
                               
                                 
                                 tags$h2("Minimum distance from other topics (Excluding global topics and topics in the same group)"),
                                 dataTableOutput("min_dist_group_key_topic"),
                                 br(),
                                 tags$h2("Minimum distance of topics per group"),
                                 
                                 dataTableOutput("dist_group_key_topic")
                               )
                               
                               

                      )
                    )
                    
           )
           )
           
  ),
  tabPanel(id="pre_models",value = "pred_models_tab",title="Classification models",style = "overflow-x:scroll;",
           
           tags$h1("Explore if the different groups can be predicted from text"),
           br(),
           wellPanel(id="wellpanel",
                     tags$h3("Classify a group with negative sampling or all groups together"),
                     br(),
                     radioGroupButtons("select_target_pred_models",label = "Classification type",choices=list("With target group"="target_choice","Without target group"="no_target_choice")),
                     conditionalPanel("input.select_target_pred_models=='target_choice'",
                                      selectizeInput(inputId = "select_group_pred_models",label="Select target group",choices=NULL)
                                      ,selectInput(inputId = "select_groups_other_pred_models",label="Select groups to compare",multiple = T,choice=NULL)
                                      ),
                     
                     br(),
                     
                     radioGroupButtons("select_feat_pred_models",label = "Select document features",choices=list("Global topic weights"="topic_choice","Document vectors"="vectors_choice")),
                     radioGroupButtons("select_imb_hand_pred_models",label = "Select Sampling Strategy",choices=list("Upsample"="up_sample_choice","Downsample"="down_sample_choice")),
                     
                     br(),
                     tags$h3("Start the process"),
                     actionButton("confirm_pred_models",label = "Confirm Settings")
                     ),
           br(),
           tags$h1("Outputs"),
           br(),
           wellPanel(
             tags$h2("Model performance"),
             selectizeInput("pred_target_view","Target Group",choices=NULL),
             br(),
             dataTableOutput("pred_model_view"),
             br(),
             tags$h2("Variable importance (Random Forest - permute)"),
             dataTableOutput("pred_model_view_fi")
           )
           )
                      )
          
  
) 





server <- function(input, output, session) {
  options(shiny.maxRequestSize=300*1024^2)
  
  
  dataset_chosen=reactiveValues(main_matrix=data.frame("Data"=NULL))
  table_val=reactiveValues(mat=NULL,sel=NULL)
  
  item_list_text=reactiveValues(text=NULL,dtm=NULL,tcm=NULL,tcm_list=list())
  word_vectors_list=reactiveValues(words=NULL,words_list=list())
  
  topic_models_list=reactiveValues(model_list=list(),done=c(),not_done=c())
  
  hideTab(inputId="main_page_all",target="text_pre_tab_val")
  hideTab(inputId="main_page_all",target="main_dashboard_val")
  hideTab(inputId="main_page_all",target="text_analytics_val")
  hideTab(inputId="main_page_all",target="pred_models_tab")
  hideTab(inputId="main_page_all",target="topic_analysis_tab")
  
  
  showModal(
    modalDialog(
      title = tags$h2("Load a file or start a new session"),
      
      footer = tagList(
        fluidRow(column(width = 3,  modalButton("Start new session"))), # 'No' closes the modal
        fluidRow(column(width = 6,fileInput(inputId = "file_choose_all",label = ""))),
      )
    )
  )
  
  observeEvent(input$file_choose_all,{
    
    if (is.null(input$file_choose_all)) return(t(matrix(c("Text (character)","Class (numeric)","Split - Values with TRUE (train) or FALSE (test)"))))
    
    #all_data=readRDS(input$file_choose_all$name)
    all_data=readRDS(input$file_choose_all$datapath)
    
    for(name in names(all_data[['dataset_chosen']])){
      dataset_chosen[[name]]=all_data[['dataset_chosen']][[name]]
    }
    
    for(name in names(all_data[['item_list_text']])){
      item_list_text[[name]]=all_data[['item_list_text']][[name]]
    }
    
    for(name in names(all_data[['table_val']])){
      table_val[[name]]=all_data[['table_val']][[name]]
    }
    #print(table_val)
    
    for(name in names(all_data[['word_vectors_list']])){
      word_vectors_list[[name]]=all_data[['word_vectors_list']][[name]]
    }
    
    for(name in names(all_data[['topic_models_list']])){
      topic_models_list[[name]]=all_data[['topic_models_list']][[name]]
    }

    
    hideTab(inputId="main_page_all",target="file_tab_val")
    
    showTab(inputId="main_page_all",target="main_dashboard_val")
    showTab(inputId="main_page_all",target="text_analytics_val")
    showTab(inputId="main_page_all",target="pred_models_tab")
    showTab(inputId="main_page_all",target="topic_analysis_tab")
    
    table_now_vals=unique(table_val$mat$new_group)
    choices <- setNames(table_now_vals, table_now_vals)
    
    updateSelectizeInput(inputId = "select_group_word_freq",choices = choices)
    updateSelectizeInput(inputId = "select_group_group_simil",choices = choices)
    updateSelectizeInput(inputId = "select_group_key_feat",choices = choices)
    updateSelectizeInput(inputId = "select_group_key_topic",choices = choices)
    updateSelectizeInput(inputId ="select_group_pred_models",choices = choices)
    updateSelectizeInput(inputId ="select_groups_other_pred_models",choices = choices)
    
    
    
    table_now_vals=c("all_data",unique(table_val$mat$new_group))
    choices <- setNames(table_now_vals, table_now_vals)
    
    updateSelectizeInput(inputId ="topic_analysis_inspect_sel",choices = choices)
    updateSelectizeInput(inputId ="topic_comp_sel",choices = choices)
    
    
    table_now_vals=c(1:ncol(topic_models_list$model$Model$theta))
    choices <- setNames(table_now_vals, table_now_vals)
    
    updateSelectizeInput(inputId ="select_global_topic",choices = choices)
    
    removeModal()
    
  })
  
  
  
  observeEvent(input$file_choose,{
    
    if (is.null(input$file_choose)) return(t(matrix(c("Text (character)","Class (numeric)","Split - Values with TRUE (train) or FALSE (test)"))))
    if(length(grep(pattern = ".xlsx",x = input$file_choose$name))>0){
      
      #dataset_chosen$main_matrix=as.data.frame(read_xlsx(input$file_choose$name))
      dataset_chosen$main_matrix=as.data.frame(read_xlsx(input$file_choose$datapath))
      
    }else if(length(grep(pattern = ".csv",x = input$file_choose$name))>0){
      #dataset_chosen$main_matrix=as.data.frame(read.csv(input$file_choose$name))
      dataset_chosen$main_matrix=as.data.frame(read.csv(input$file_choose$datapath))
      
    }else{
      
      #dataset_chosen$main_matrix=as.data.frame(readRDS(input$file_choose$name))
      dataset_chosen$main_matrix=as.data.frame(readRDS(input$file_choose$datapath))
      
    }
    
    choices <- setNames(as.list(colnames(dataset_chosen$main_matrix)), colnames(dataset_chosen$main_matrix))
    
    updateSelectInput(inputId = "select_filter_option",choices=choices)
    
    output$main_table<-renderDataTable(dataset_chosen$main_matrix,caption="MAIN DATA")
    
    dataset_chosen$split2=rep(T,nrow(dataset_chosen$main_matrix))
    
  })
  
  
  
  observeEvent(input$complete_var_ass,{
    
    table_val$sel=input$select_filter_option
    
    table_val$mat=table(dataset_chosen$main_matrix[,input$select_filter_option])
    table_val$mat=as.data.frame(table_val$mat)
    table_val$mat$group=as.character(c(1:nrow(table_val$mat)))
    
    if(length(table_val$sel)==1){
      colnames(table_val$mat)[1]=table_val$sel
      table_val$mat$new_group=as.character(table_val$mat[,1])
      
    }else{
      table_val$mat$new_group=as.character(c(1:nrow(table_val$mat)))
      
      }

    output$label_table<-renderDataTable({
      table_val$mat[,-ncol(table_val$mat)]
    })
    
    
    output$label_table_new <- renderDT({
      datatable(
        data.frame(
          "New_group" = table_val$mat[, 'new_group']
        ),
        escape = FALSE, # Allow rendering of HTML
        editable = list(target = "cell", columns = 1), # Restrict editing to the first column
        options = list(
          paging = TRUE,    # Enable pagination
          searching = FALSE # Disable search bar
        ),
        rownames = FALSE
      )
    }, server = TRUE) # Use server-side processing

    output$group_remove_check_box_UI <- renderUI({
      tagList(
        br(),
        tags$h3("Remove Group"),
        lapply(1:nrow(table_val$mat), function(x) {
          checkboxInput(
            inputId = paste0("group_remove_check_box_", x),
            label = paste("Group", table_val$mat$new_group[x]),
            value = FALSE
          )
        })
      )
    })
    
    
  })
    
    


  
  
  # Observe edits to the editable table
  observeEvent(input$label_table_new_cell_edit, {
    info <- input$label_table_new_cell_edit
    #str(info) # Debugging: Show edit info in the console
    table_val$mat[info$row,ncol(table_val$mat)]=as.character(info$value)
    
  })
  
  observeEvent(input$complete_groups_but,{
    
    #print(table_val$mat)
    
    choices <- setNames(as.list(colnames(dataset_chosen$main_matrix)), colnames(dataset_chosen$main_matrix))
    
    
    showModal(
      modalDialog(
        title = "Confirmation",
        selectizeInput(inputId = "select_text_col",label="Select text column",choices=choices),
        "Do you want to confirm the groups and text?",
        
        footer = tagList(
          modalButton("No"), # 'No' closes the modal
          actionButton("yes_btn_file", "Yes") # 'Yes' triggers further action
        )
      )
    )
    
    

  })
  
  # Observe "Yes" button click
  observeEvent(input$yes_btn_file, {
    
    dataset_chosen$txt_col=input$select_text_col
    dataset_chosen$main_matrix[,dataset_chosen$txt_col]=as.character(unlist(dataset_chosen$main_matrix[,dataset_chosen$txt_col]))
    
    
    dataset_chosen$main_matrix <- merge(
      dataset_chosen$main_matrix,
      table_val$mat[,-(ncol(table_val$mat)-2)], # Adjust "Var1" to the correct column name
      by.x = table_val$sel, # Column to match in dataset$main_matrix
      by.y = table_val$sel,        # Corresponding column in table_val$mat
      all.x = TRUE          # Retain all rows in dataset$main_matrix
    )
    
    to_rmv_data=c()
    to_rmv_groups=c()
    
    for (i in 1:length(table_val$mat$group)){
      temp_now=     table_val$mat$group[i]
      #print(input[[paste0("group_remove_check_box_", i)]])
      if(input[[paste0("group_remove_check_box_", i)]]==T){
        to_rmv_data=c(to_rmv_data,which(dataset_chosen$main_matrix$group==i))
        to_rmv_groups=c(to_rmv_groups,i)
      }
    }

    to_rmv_data=unique(to_rmv_data)
    
    #print(nrow(dataset_chosen$main_matrix))
    #print(nrow(table_val$mat))
    
    if(length(to_rmv_groups)>0){
      
      dataset_chosen$main_matrix=dataset_chosen$main_matrix[-to_rmv_data,]
      dataset_chosen$split2=dataset_chosen$split2[-to_rmv_data]
      
      table_val$mat=table_val$mat[-to_rmv_groups,]
    }
    
    
    dataset_chosen$main_matrix$group=NULL  
    table_val$mat$group=NULL
    
    #print(nrow(dataset_chosen$main_matrix))
    #print(nrow(table_val$mat))
    
    

    
    hideTab(inputId="main_page_all",target="file_tab_val")
    showTab(inputId="main_page_all",target="text_pre_tab_val")
    
    
    table_now_vals=c("all_data",unique(table_val$mat$new_group))
    choices <- setNames(table_now_vals, table_now_vals)
    
    updateSelectInput(inputId = "topic_model_group",choices=choices)
    updateSelectizeInput(inputId = "topic_model_group_man",choices=choices)
    
    topic_models_list$not_done=c(table_now_vals)
    
    # Remove the modal
    removeModal()
    
  })
  
  
  output$text_groups_not_done<-renderInfoBox({
    infoBox(title = "Groups remaining:",value = paste(topic_models_list$not_done,collapse = ", "),subtitle = "all_data refers to the dataset as a whole",icon = icon("book"))

  }  )
  
  
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
    
    
    

    item_list_text$tcm=temp$tcm
    item_list_text$old_words=temp$old_words
    
    if(length(temp$zero_rows)>0){
      
      dataset_chosen$main_matrix=dataset_chosen$main_matrix[-temp$zero_rows,]
      dataset_chosen$split2=dataset_chosen$split2[-temp$zero_rows]
      item_list_text$text=temp$text[-temp$zero_rows]
      item_list_text$dtm=temp$dtm[-temp$zero_rows,]
      
    }else{
      
      item_list_text$text=temp$text
      item_list_text$dtm=temp$dtm
      
    }
    #temp$zero_rows=NULL
    
    output$no_words_info_box<-renderInfoBox({
      infoBox("No words or ngrams", paste(nrow(item_list_text$tcm),"Unique items"),icon = icon('list'),color='blue')
    })
    

    groups_all=unique(table_val$mat$new_group)#names(table(dataset_chosen$main_matrix$new_group))
    
    for(i in groups_all){
      
      print(paste("Group",i,"TCM"))
      temp_mat=dichotomize(as.matrix(item_list_text$dtm)[which(dataset_chosen$main_matrix$new_group==i),],thresh = 1)
      item_list_text$tcm_list[[i]]=t(temp_mat)%*%temp_mat
      
    }
    
    end_time=proc.time()[3]
    
    
    output$proc_time_DTM<- renderText({return(paste("Processing time in seconds to construct Document Term Matrix:",round((end_time-start_time),3)))})#
    
    
    removeModal()
    

    })
  
  observeEvent(input$complete_dtm_load,{
    
    showModal(modalDialog(title = "Document-Term matrix is loading: please wait",footer=NULL))
    
    
    if (is.null(input$complete_dtm_load)) return(t(matrix(c("Text (character)","Class (numeric)","Split - Values with TRUE (train) or FALSE (test)"))))
    if(length(grep(pattern = ".xlsx",x = input$complete_dtm_load$name))>0){
      
      #item_list_text$dtm=as.data.frame(read_xlsx(input$complete_dtm_load$name))
      item_list_text$dtm=as.data.frame(read_xlsx(input$complete_dtm_load$datapath))
      
    }else if(length(grep(pattern = ".csv",x = input$complete_dtm_load$name))>0){
      #item_list_text$dtm=as.data.frame(read.csv(input$complete_dtm_load$name))
      item_list_text$dtm=as.data.frame(read.csv(input$complete_dtm_load$datapath))
      
    }else{
      
      #item_list_text$dtm=as.data.frame(readRDS(input$complete_dtm_load$name))
      item_list_text$dtm=as.data.frame(readRDS(input$complete_dtm_load$datapath))
      
      

      
    }
    
    item_list_text$old_words=colnames(item_list_text$dtm)
    
    item_list_text$tcm=crossprod(binda::dichotomize(item_list_text$dtm,thresh = .Machine$double.xmin))
    
    item_list_text$text=""

    
    
    groups_all=unique(table_val$mat$new_group)#names(table(dataset_chosen$main_matrix$new_group))
    
    
    for(i in groups_all){
      
      print(paste("Group",i,"TCM"))
      temp_mat=dichotomize(as.matrix(item_list_text$dtm)[which(dataset_chosen$main_matrix$new_group==i),],thresh = 1)
      item_list_text$tcm_list[[i]]=t(temp_mat)%*%temp_mat
      
    }
    
    removeModal()
    
    
  })
  
  
  output$word_barplot<-renderPlotly({
    
    col_sums_all=diag(item_list_text$tcm)
    order_csa=order(col_sums_all,decreasing = T)
    
    DF=data.frame("Words"=names(col_sums_all[order_csa[1:input$word_bar_plot_no_items]]),"Occurences"=col_sums_all[order_csa[1:input$word_bar_plot_no_items]])
    p=
      ggplotly(
        ggplot(DF, aes(Words, Occurences)) +               
          theme(text = element_text(size = 20))+
          #theme(axis.text.x = element_text(angle = 90))+
          geom_bar(stat = "identity", fill = "lightblue", color = "blue")+
          scale_x_discrete(limits = names(col_sums_all[order_csa[1:input$word_bar_plot_no_items]]))+
          ggtitle("Keyword - Document Occurence (Train Set)")+
          ylab("Number of documents")+
          theme_solarized_2(light = T)+
          coord_flip()
          #theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
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
  
  
  #word vectors
  
  

  #Building word vectors
  observeEvent(input$vector_build,{
    showModal(modalDialog(title = "Training word vectors please wait",footer=NULL))
    start_time=proc.time()[3]
    
    
    groups_all=unique(table_val$mat$new_group)#names(table(dataset_chosen$main_matrix$new_group))
    

    for(group_now in groups_all){
      
      which_in=which(dataset_chosen$main_matrix$new_group==group_now)
      
      print(paste("Group",group_now,"WV"))
      print(length(which_in))
      
      if(input$vector_choice=="glove_tcm"){
        word_vectors_list$words_list[[group_now]]=prepare_glove_new(dtm_now = item_list_text$dtm[which_in,],tcm_now = item_list_text$tcm_list[[group_now]],text_now = item_list_text$text[which_in],glove_skipgram_clause = F,ws = 21,split2=rep(T,length(which_in)),dimensions=input$vector_size)
      }else if(input$vector_choice=="glove_skip"){
        word_vectors_list$words_list[[group_now]]=prepare_glove_new(dtm_now = item_list_text$dtm[which_in,],tcm_now = item_list_text$tcm_list[[group_now]],text_now = item_list_text$text[which_in],glove_skipgram_clause = T,ws = 21,split2=rep(T,length(which_in)),dimensions=input$vector_size)
      }else if(input$vector_choice=="tdm_te"){
        word_vectors_list$words_list[[group_now]]=t(binda::dichotomize(item_list_text$dtm[which_in,],.Machine$double.xmin))
      }else if (input$vector_choice=="spearman_word_corr"){
        word_vectors_list$words_list[[group_now]]=cor(x = (binda::dichotomize(item_list_text$dtm[which_in,],.Machine$double.xmin)),method ="spearman")
      }else if(input$vector_choice=="glove_tcm_full"){
        word_vectors_list$words_list[[group_now]]=prepare_glove_new(dtm_now = item_list_text$dtm[which_in,],tcm_now = item_list_text$tcm_list[[group_now]],text_now = item_list_text$text[which_in],glove_skipgram_clause = F,ws = 21,split2=rep(T,length(which_in)),full_tcm_clause=T,dimensions=input$vector_size)
      }else if(input$vector_choice=="tcm_stand"){
        
        word_vectors_list$words_list[[group_now]]=item_list_text$tcm_list[[group_now]]/diag(item_list_text$tcm_list[[group_now]])
        word_vectors_list$words_list[[group_now]][which(is.nan(word_vectors_list$words_list[[group_now]]))]=0
        diag(word_vectors_list$words_list[[group_now]])[which(diag(word_vectors_list$words_list[[group_now]])==0)]=1
        
      }else if(input$vector_choice=="tcm_rev_ii"){
        
        graph_tokens_rev_ii=item_list_text$tcm_list[[group_now]]
        graph_tokens_rev_ii=graph_tokens_rev_ii/diag(graph_tokens_rev_ii)
        
        for(i in 1:(nrow(graph_tokens_rev_ii)-1)){
          
          for(j in (i+1):nrow(graph_tokens_rev_ii)){
            
            
            #min or max
            temp_val=min(graph_tokens_rev_ii[i,j],graph_tokens_rev_ii[j,i])
            
            graph_tokens_rev_ii[i,j]=temp_val
            graph_tokens_rev_ii[j,i]=temp_val
          }
        }
        word_vectors_list$words_list[[group_now]]=graph_tokens_rev_ii
        
      }else if(input$vector_choice=="tcm_ii"){
        
        graph_tokens_rev_ii=item_list_text$tcm_list[[group_now]]
        graph_tokens_rev_ii=graph_tokens_rev_ii/diag(graph_tokens_rev_ii)
        
        for(i in 1:(nrow(graph_tokens_rev_ii)-1)){
          
          for(j in (i+1):nrow(graph_tokens_rev_ii)){
            
            
            #min or max
            temp_val=min(graph_tokens_rev_ii[i,j],graph_tokens_rev_ii[j,i])
            
            graph_tokens_rev_ii[i,j]=temp_val
            graph_tokens_rev_ii[j,i]=temp_val
          }
        }
        word_vectors_list$words_list[[group_now]]=graph_tokens_rev_ii
        
        
      }else if(input$vector_choice=="tcm_ji"){
        graph_tokens_rev_ii=item_list_text$tcm_list[[group_now]]
        
        for(i in 1:(nrow(graph_tokens_rev_ii)-1)){
          for(j in (i+1):nrow(graph_tokens_rev_ii)){
            
            temp_val=(graph_tokens_rev_ii[i,j])/( graph_tokens_rev_ii[i,i] + graph_tokens_rev_ii[j,j] - graph_tokens_rev_ii[i,j])
            graph_tokens_rev_ii[i,j]=temp_val
            graph_tokens_rev_ii[j,i]=temp_val
          }
        }
        diag(graph_tokens_rev_ii)=1
        word_vectors_list$words_list[[group_now]]=graph_tokens_rev_ii
        
        
      }else if(input$vector_choice=="tcm_ei"){
        graph_tokens_rev_ii=item_list_text$tcm_list[[group_now]]
        
        for(i in 1:(nrow(graph_tokens_rev_ii)-1)){
          for(j in (i+1):nrow(graph_tokens_rev_ii)){
            
            temp_val=(graph_tokens_rev_ii[i,j]^2)/( graph_tokens_rev_ii[i,i]* graph_tokens_rev_ii[j,j])
            graph_tokens_rev_ii[i,j]=temp_val
            graph_tokens_rev_ii[j,i]=temp_val
          }
        }
        diag(graph_tokens_rev_ii)=1
        word_vectors_list$words_list[[group_now]]=graph_tokens_rev_ii
        
      }else if(input$vector_choice=="word2vec_skipgram"){
        h2o.init(nthreads = -1)
        word_vectors_list$words_list[[group_now]] <- h2o.word2vec(training_frame = h2o.tokenize(as.h2o(item_list_text$text[which_in]),split = " "),word_model = "SkipGram",vec_size = input$vector_size,window_size = 5)
        word_vectors_list$words_list[[group_now]] <- h2o.transform(model = word_vectors_list$words_list[[group_now]],words=as.h2o(item_list_text$old_words))
        word_vectors_list$words_list[[group_now]] <- as.matrix(word_vectors_list$words_list[[group_now]])
        
        rownames(word_vectors_list$words_list[[group_now]])=colnames(item_list_text$tcm)
        
        
        
      }else if(input$vector_choice=="word2vec_cbow"){
        h2o.init(nthreads = -1)
        
        word_vectors_list$words_list[[group_now]] <- h2o.word2vec(training_frame = h2o.tokenize(as.h2o(item_list_text$text[which_in]),split =" "),word_model = "CBOW",vec_size = input$vector_size,window_size = 10)
        word_vectors_list$words_list[[group_now]] <- h2o.transform(model = word_vectors_list$words_list[[group_now]],words=as.h2o(item_list_text$old_words))
        word_vectors_list$words_list[[group_now]] <- as.matrix(word_vectors_list$words_list[[group_now]])
        
        rownames(word_vectors_list$words_list[[group_now]])=colnames(item_list_text$tcm)
        
      }
      if(input$auto_enc==T){
        h2o.init(nthreads = -1)
        word_vectors_list$words_list[[group_now]]=auto_encoders(features=word_vectors_list$words_list[[group_now]],dimensions=input$auto_enc_dim)
      }
      
      print("DIM REDUCT")
      word_vectors_list$words_list[[group_now]]=dimensionality_reduction_options(word_vectors = word_vectors_list$words_list[[group_now]],tSparse_colnames=colnames(item_list_text$dtm),nn = input$nn_umap,umap_metric="cosine",dim_red_options=input$dim_red_options,no_umap_dims=input$no_umap_dims)
      
     
      
    }
    
    
    
    print(paste("Group","ALL","WV"))
    
    
    if(input$vector_choice=="glove_tcm"){
      word_vectors_list$words=prepare_glove_new(dtm_now = item_list_text$dtm,tcm_now = item_list_text$tcm,text_now = item_list_text$text,glove_skipgram_clause = F,ws = 21,split2=dataset_chosen$split2,dimensions=input$vector_size)
      
    }else if(input$vector_choice=="glove_skip"){
      word_vectors_list$words=prepare_glove_new(dtm_now = item_list_text$dtm,tcm_now = item_list_text$tcm,text_now = item_list_text$text,glove_skipgram_clause = T,ws = 21,split2=dataset_chosen$split2,dimensions=input$vector_size)
      
    }else if(input$vector_choice=="tdm_te"){
      word_vectors_list$words=t(binda::dichotomize(item_list_text$dtm[dataset_chosen$split2==T,],.Machine$double.xmin))
    }else if (input$vector_choice=="spearman_word_corr"){
      word_vectors_list$words=cor(x = (binda::dichotomize(item_list_text$dtm[dataset_chosen$split2==T,],.Machine$double.xmin)),method ="spearman")
      
    }else if(input$vector_choice=="glove_tcm_full"){
      word_vectors_list$words=prepare_glove_new(dtm_now = item_list_text$dtm,tcm_now = item_list_text$tcm,text_now = item_list_text$text,glove_skipgram_clause = F,ws = 21,split2=dataset_chosen$split2,full_tcm_clause=T,dimensions=input$vector_size)
      
       }else if(input$vector_choice=="tcm_stand"){
      
      word_vectors_list$words=item_list_text$tcm/diag(item_list_text$tcm)
      word_vectors_list$words[which(is.nan(word_vectors_list$words))]=0
      diag(word_vectors_list$words)[which(diag(word_vectors_list$words)==0)]=1
      
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
    
    word_vectors_list$words=dimensionality_reduction_options(word_vectors = word_vectors_list$words,tSparse_colnames=colnames(item_list_text$dtm),nn = input$nn_umap,umap_metric="cosine",dim_red_options=input$dim_red_options,no_umap_dims=input$no_umap_dims)
    
    
    
    end_time=proc.time()[3]
    
    
    
    print("word vectors done")
    removeModal()
    
    output$proc_time_WV<- renderText({return(
      paste("Processing time in seconds to construct Word Vectors:",round((end_time-start_time),3)))
      })
    

    
  })
  
  observeEvent(input$topic_model_set,{
    
    showModal(modalDialog(title = "Training topic models please wait",footer=NULL))
    start_time=proc.time()[3]
    
    groups_all=input$topic_model_group
    
    for(group_now in groups_all){
      
      if(group_now=="all_data"){
        print("Topic extraction Group: all")
        topic_models_list$model=topic_extraction_new(
          text=item_list_text$text,
          word_vectors = word_vectors_list$words,
          dtm = item_list_text$dtm,
          tcm = item_list_text$tcm,
          algorithm = input$topic_model_alg,min_topics = input$min_num_topics,
          max_topics = input$max_num_topics
          ,best_cond = input$topic_rank_opt,return_model = F,
          no_top_terms = input$no_top_terms_topics
        )
        
      }else{
        print(paste("Topic extraction Group:",group_now))
        which_in=which(dataset_chosen$main_matrix$new_group==group_now)
        
        topic_models_list$model_list[[group_now]]=topic_extraction_new(
          text=item_list_text$text[which_in],
          word_vectors = word_vectors_list$words_list[[group_now]],
          dtm = item_list_text$dtm[which_in,],
          tcm = item_list_text$tcm_list[[group_now]],
          algorithm = input$topic_model_alg,min_topics = input$min_num_topics,
          max_topics = input$max_num_topics,no_top_terms = 10
          ,best_cond = input$topic_rank_opt,return_model = F
        )
      }

    }
    

    
    end_time=proc.time()[3]
    output$proc_time_topic<- renderText({return(paste("Processing time in seconds to construct topic extraction Models proc_time_topic:",round((end_time-start_time),3)))})
    
    topic_models_list$done=unique(c(topic_models_list$done,groups_all))
    choices <- setNames(topic_models_list$done, topic_models_list$done)
    
    updateSelectInput(input="topic_model_inspect_sel",choices=choices)
    
    
    match_done=match(groups_all,topic_models_list$not_done)
    which_not_na=which(!is.na(match_done))
    if(length(which_not_na)>0)topic_models_list$not_done=topic_models_list$not_done[-match_done[which_not_na]]
    
    removeModal()
    
    print("Topic models auto done")
    
  })
  
  observeEvent(input$topic_model_set_man,{
    showModal(modalDialog(title = "Training topic models please wait",footer=NULL))
    start_time=proc.time()[3]
    
    group_now=input$topic_model_group_man
    
    print(paste("Topic extraction Group:",group_now))
    
    if(group_now=="all_data"){
      
      if(is.null(topic_models_list$model$Eval_list)){
        topic_models_list$model=list()
        topic_models_list$model$Eval_list=data.frame()
      }
      
      topic_models_list$model$Model=topic_extraction_new(
        
        text=item_list_text$text,
        word_vectors = word_vectors_list$words,
        dtm = item_list_text$dtm,
        tcm = item_list_text$tcm,
        algorithm = input$topic_model_alg_man,min_topics = input$num_topics_man,
        max_topics = input$num_topics_man,no_top_terms = 10
        ,best_cond = "all_rank",return_model = T
        
      )
      
      

    }else{
      which_in=which(dataset_chosen$main_matrix$new_group==group_now)
      
      if(is.null(topic_models_list$model_list[[group_now]]$Eval_list)){
        topic_models_list$model_list[[group_now]]=list()
        topic_models_list$model_list[[group_now]]$Eval_list=data.frame()
      }
      
      topic_models_list$model_list[[group_now]]$Model=topic_extraction_new(
        
        text=item_list_text$text[which_in],
        word_vectors = word_vectors_list$words_list[[group_now]],
        dtm = item_list_text$dtm[which_in,],
        tcm = item_list_text$tcm_list[[group_now]],
        algorithm = input$topic_model_alg_man,min_topics = input$num_topics_man,
        max_topics = input$num_topics_man,no_top_terms = 10
        ,best_cond = "all_rank",return_model = T
        
      )
      
    }
    

    end_time=proc.time()[3]
    output$proc_time_topic_man<- renderText({return(paste("Processing time in seconds to construct a topic extraction Model:",round((end_time-start_time),3)))})
    
    
    topic_models_list$done=unique(c(topic_models_list$done,group_now))
    choices <- setNames(topic_models_list$done, topic_models_list$done)
    updateSelectInput(input="topic_model_inspect_sel",choices=choices)
    
    match_done=match(group_now,topic_models_list$not_done)
    if(!is.na(match_done))topic_models_list$not_done=topic_models_list$not_done[-match_done]

    removeModal()
    
    print("Topic models manual done")
    
  })
  
  
  observeEvent(input$topic_model_inspect_sel,{
    
    if(input$topic_model_inspect_sel=="all_data"){
      temp_dt_1=topic_models_list$model$Model$phi
    }else{
      temp_dt_1=topic_models_list$model_list[[input$topic_model_inspect_sel]]$Model$phi
      
    }
    
    output$topic_model_inspect_top_words<-renderDT({
      

      datatable(
        t(temp_dt_1),
        extensions = c("Buttons", "Scroller"),
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          scrollX = TRUE,
          scrollY = "400px",
          scroller = TRUE,
          pageLength = 10,
          lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
          class = "display compact stripe hover"
        )
      )
      
  })
    
    
    if(input$topic_model_inspect_sel=="all_data"){
      temp_dt_2=topic_models_list$model$Eval_list
    }else{
      temp_dt_2=topic_models_list$model_list[[input$topic_model_inspect_sel]]$Eval_list
      
    }
    
    output$topic_model_inspect_perf_eval<-renderDT({
      
      
      datatable(
        (temp_dt_2),
        extensions = c("Buttons", "Scroller"),
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          scrollX = TRUE,
          scrollY = "400px",
          scroller = TRUE,
          pageLength = 10,
          lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
          class = "display compact stripe hover"
        )
      )
      
    })
    
    #
  })
  
  
  output$no_vec<- renderInfoBox({
    infoBox(title = "Number of Words: ",value = nrow(word_vectors_list$words))
    
  })
  output$word_vec_dim<- renderInfoBox({
    infoBox(title = "Number of Dimensions: ",value = ncol(word_vectors_list$words))
  })
  
  
  # Export selected dataset in excel
  output$download_data <- downloadHandler(
    
    filename = function() {
      paste("data_LMTM")
    },
    content = function(file) {
      
      
      saveRDS(list(
        dataset_chosen=reactiveValuesToList(dataset_chosen),
                   item_list_text=reactiveValuesToList(item_list_text),
                   table_val=reactiveValuesToList(table_val),
                   word_vectors_list=reactiveValuesToList(word_vectors_list),
                   topic_models_list=reactiveValuesToList(topic_models_list)
                   )
              , file)
      
    }
  )
  
  observeEvent(input$confirm_dtm_wv,{
    done_all_check=0
    
    #item_list_text=reactiveValues(text=NULL,dtm=NULL,tcm=NULL,tcm_list=list())
    #word_vectors_list=reactiveValues(words=NULL,words_list=list())
    #topic_models_list=reactiveValues(model_list=list(),done=c(),not_done=c())
    error_message=""
    
    if(!is.null(item_list_text$text)){
      done_all_check=done_all_check+1
    }else{
      error_message=paste(error_message,"Document Term Matrix not developed",sep = "; ")
    }
    
      if(!is.null(word_vectors_list$words)){
      done_all_check=done_all_check+1
    }else{
      error_message=paste(error_message,"Word vectors not developed",sep = "; ")
    }
    
      if(length(topic_models_list$model_list)==length(unique(table_val$mat$new_group))){
      done_all_check=done_all_check+1
    } else{
      error_message=paste(error_message,";","Remaining groups without topic models:",length(unique(table_val$mat$new_group))-length(topic_models_list$model_list))
    }
    
    if(!is.null(topic_models_list$model)){
      done_all_check=done_all_check+1
      
    }else{
      error_message=paste(error_message,";","Topic model for all data not developed")
    }
    
    if(done_all_check==4){
      
      hideTab(inputId="main_page_all",target="text_pre_tab_val")
      
      showTab(inputId="main_page_all",target="main_dashboard_val")
      showTab(inputId="main_page_all",target="text_analytics_val")
      showTab(inputId="main_page_all",target="pred_models_tab")
      showTab(inputId="main_page_all",target="topic_analysis_tab")
      
      
      table_now_vals=unique(table_val$mat$new_group)
      choices <- setNames(table_now_vals, table_now_vals)
      
      updateSelectizeInput(inputId = "select_group_word_freq",choices = choices)
      updateSelectizeInput(inputId = "select_group_group_simil",choices = choices)
      updateSelectizeInput(inputId = "select_group_key_feat",choices = choices)
      updateSelectizeInput(inputId = "select_group_key_topic",choices = choices)
      updateSelectizeInput(inputId = "select_group_pred_models",choices = choices)
      updateSelectizeInput(inputId ="select_groups_other_pred_models",choices = choices)
      
      table_now_vals=c("all_data",unique(table_val$mat$new_group))
      choices <- setNames(table_now_vals, table_now_vals)
      
      updateSelectizeInput(inputId = "topic_analysis_inspect_sel",choices = choices)
      updateSelectizeInput(inputId ="topic_comp_sel",choices = choices)
      
      
      table_now_vals=c(1:ncol(topic_models_list$model$Model$theta))
      choices <- setNames(table_now_vals, table_now_vals)
      updateSelectizeInput(inputId ="select_global_topic",choices = choices)
      
      
    }else{
      showModal(
        modalDialog(title = "Please preprocess the documents and train word vectors and topic models (for each group)",
                    tags$h4("Details:",error_message),
                    footer=modalButton("Continue"))
      )
    }

  })
  
  output$main_data_view<-renderDataTable({
    
      datatable(
        dataset_chosen$main_matrix,
        extensions = c("Buttons", "Scroller"),
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          scrollX = TRUE,
          scrollY = "400px",
          scroller = TRUE,
          pageLength = 10,
          lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
          class = "display compact stripe hover"
        )
      )
   
    
    
  })
  
  
  output$groups_view<-renderDataTable({
    datatable(
      table_val$mat,
      extensions = c("Buttons", "Scroller"),
      options = list(
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        scrollX = TRUE,
        scrollY = "400px",
        scroller = TRUE,
        pageLength = 10,
        lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
        class = "display compact stripe hover"
      )
    )
    
  })
  

  output$no_obs_dash<-renderInfoBox({
    infoBox(title = "No observations: ",value = nrow(dataset_chosen$main_matrix),icon = icon("database"),color = "yellow",fill = T)
  })
  
  output$no_groups_dash<-renderInfoBox({
   
    infoBox(title = "No groups: ",value = length(unique(table_val$mat$new_group)),icon = icon("sitemap"),color = "red",fill=T)
    
  })
  
  output$no_words_now<-renderInfoBox({
    
    infoBox(title = "No features: ",value = nrow(item_list_text$tcm),icon = icon("book"),color = "red",fill=T)
    
  })
  

  output$glob_word_frequencies_table<-renderDataTable({
    
    df_now=data.frame("Word"=rownames(item_list_text$tcm),"Frequency"=diag(item_list_text$tcm))
    df_now=df_now[order(df_now$Frequency,decreasing = T),]
    rownames(df_now)=NULL
    
    datatable(
      df_now,
      extensions = c("Buttons", "Scroller"),
      options = list(
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        scrollX = TRUE,
        scrollY = "400px",
        scroller = TRUE,
        pageLength = 10,
        lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
        class = "display compact stripe hover"
      )
    )
    
  })
  
  output$glob_word_frequencies_plot<-renderPlotly({
    
    df_now=data.frame("Word"=rownames(item_list_text$tcm),"Frequency"=diag(item_list_text$tcm))
    df_now=df_now[order(df_now$Frequency,decreasing = T),]
    
    rownames(df_now)=NULL
    min_now=20*(input$glob_word_pag-1)+1
    max_now=20*(input$glob_word_pag)
    
    df_filt_now=df_now[min_now:max_now,]
    df_filt_now$Word=reorder(df_filt_now$Word, df_filt_now$Frequency)
    
    ggplot(df_filt_now,aes(x=Word,y=Frequency))+
      geom_bar(stat = "identity", fill = "#fcba03") +
      coord_flip() +
      labs(title = paste("Page", input$glob_word_pag),
           x = "Word", y = "Frequency") +
      theme_solarized_2(light = T,base_size = 15)
  })
  
  output$glob_word_mutual_info<-renderDT({
    
    dtm_dich=dichotomize(X = item_list_text$dtm,.Machine$double.xmin)

    res_feat_eval=MIM(X = as.data.frame(dtm_dich),Y = as.factor(dataset_chosen$main_matrix$new_group),k = ncol(dtm_dich))
    
    res_feat_eval=data.frame("Feature"=names(res_feat_eval$score),"Score"=unlist(res_feat_eval$score))
    rownames(res_feat_eval)=NULL
    
    datatable(
      res_feat_eval,
      extensions = c("Buttons", "Scroller"),
      options = list(
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        scrollX = TRUE,
        scrollY = "400px",
        scroller = TRUE,
        pageLength = 10,
        lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
        class = "display compact stripe hover"
      )
    )
  })
  
  
  output$group_word_frequencies_table<-renderDataTable({
    
    df_now=data.frame("Word"=rownames(item_list_text$tcm_list[[input$select_group_word_freq]]),"Frequency"=diag(item_list_text$tcm_list[[input$select_group_word_freq]]))
    df_now=df_now[order(df_now$Frequency,decreasing = T),]
    rownames(df_now)=NULL
    
    datatable(
      df_now,
      extensions = c("Buttons", "Scroller"),
      options = list(
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        scrollX = TRUE,
        scrollY = "400px",
        scroller = TRUE,
        pageLength = 10,
        lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
        class = "display compact stripe hover"
      )
    )
    
  })
  
  output$group_word_frequencies_plot<-renderPlotly({
    
    df_now=data.frame("Word"=rownames(item_list_text$tcm_list[[input$select_group_word_freq]]),"Frequency"=diag(item_list_text$tcm_list[[input$select_group_word_freq]]))
    df_now=df_now[order(df_now$Frequency,decreasing = T),]
    
    rownames(df_now)=NULL
    min_now=20*(input$group_word_pag-1)+1
    max_now=20*(input$group_word_pag)
    
    
    
    df_filt_now=df_now[min_now:max_now,]
    df_filt_now$Word=reorder(df_filt_now$Word, df_filt_now$Frequency)
    
    ggplot(df_filt_now,aes(x=Word,y=Frequency))+
      geom_bar(stat = "identity", fill = "#fcba03") +
      coord_flip() +
      labs(title = paste("Page", input$group_word_pag),
           x = "Word", y = "Frequency") +
      theme_solarized_2(light = T,base_size = 15)
  })
  
  
  
  observeEvent(input$start_projection_but,{
    
    
    group_vectors = do.call(rbind,lapply(names(item_list_text$tcm_list),function(x){
      which_in=which(dataset_chosen$main_matrix$new_group==x)
      
      v_now=colSums(item_list_text$dtm[which_in,])
      v_now=v_now/sum(v_now)
      
      return(v_now)
    }))
    
    #group_vectors = do.call(rbind,lapply(item_list_text$tcm_list,function(x){vec_now=diag(x)/sum(diag(x))vec_now}))
    
    dist_now=JSD(x = group_vectors)
    rownames(dist_now)=names(item_list_text$tcm_list)
    colnames(dist_now)=names(item_list_text$tcm_list)
    
    
    new_coords=cmdscale( d = dist_now,k=2)
    new_coords=as.data.frame(new_coords)
    colnames(new_coords)=c("x","y")
    
    new_coords$size=unlist(lapply(item_list_text$tcm_list,function(x)sum(diag(x))))
    new_coords$label=names(item_list_text$tcm_list)
    
    
    
    
    output$text_projection<-renderPlotly({
      

      plot_now <- ggplotly(
        ggplot(data = new_coords, aes(x = x, y = y, size = size, color = label)) +
          geom_point(alpha=0.6) + # Use filled points with a gradient fill        
          geom_text(aes(label = label), size = 3,color="black",check_overlap = T) +
          #geom_text_repel(aes(label = label), size = 4, color = "black") +  # Repels overlapping labels
          scale_size_continuous(range = c(5, 15)) +
          theme(legend.position = "none")+ # Hides all legends
          #expand_limits(x = new_coords$x, y = new_coords$y)+ # Adjust limits to fit the data
          coord_cartesian(xlim = range(new_coords$x) + c(-0.1, 0.1), ylim = range(new_coords$y) + c(-0.1, 0.1))+
          
          theme_solarized_2(light = T)
        
      )%>% layout(showlegend = FALSE)
      
      return(plot_now)
    })
    
    
    output$group_simil<-renderPlotly({
      selected_now=input$select_group_group_simil

      
      match_pos_now=match(selected_now,rownames(dist_now))

      
      df_now=data.frame("Group"=rownames(dist_now),"Distance"=dist_now[match_pos_now,])
      df_now=df_now[-match_pos_now,]
      df_now$Group=reorder(df_now$Group, df_now$Distance)
      
      ggplot(df_now,aes(x=Group ,y=Distance))+
        geom_bar(stat = "identity", fill = "#fcba03") +
        coord_flip() +
        labs(title = paste("Distance from Group", selected_now),
             x = "Group", y = "Jensen-Shannon Divergence") +
        #theme_minimal(base_size = 15)
        theme_solarized_2(light = T,base_size = 15)
      
    })
    
    
  })
  
  
  observeEvent(input$start_key_feat,{
    
    showModal(modalDialog(title = "Feature evaluation in progress. please wait",footer=NULL))
    
    
    selected_now=input$select_group_key_feat
    
    categories_now=rep(0,nrow(item_list_text$dtm))
    categories_now[which(dataset_chosen$main_matrix$new_group==selected_now)]=1
    
    dtm_dich=dichotomize(X = item_list_text$dtm,.Machine$double.xmin)
    
    res_feat_eval=MIM(X = as.data.frame(dtm_dich),Y = categories_now,k = ncol(dtm_dich))
    res_feat_eval=data.frame(Word=names(res_feat_eval$score),Mutual_Information=unlist(res_feat_eval$score))
    #cor_now=cor(dtm_dich,categories_now)[,1];cor_now[which(is.na(cor_now))]=0
    res_feat_eval$Correlation=cor(dtm_dich,categories_now,method="spearman")[,1]
    res_feat_eval=res_feat_eval[order(res_feat_eval$Correlation,decreasing = T),]
    
    
    rownames(res_feat_eval)=NULL
    
    output$feat_info_one_output <- renderDT({
      datatable(
        res_feat_eval,
        extensions = c("Buttons", "Scroller"),
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          scrollX = TRUE,
          scrollY = "400px",
          scroller = TRUE,
          pageLength = 10,
          lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
          class = "display compact stripe hover"
        )
      )
    })
    
    
    
    
    
    no_documents=nrow(item_list_text$dtm)
    no_in=length(which(dataset_chosen$main_matrix$new_group==selected_now))
    
    tcm_now_filt=item_list_text$tcm_list[[selected_now]]
    
    outputs_two=list()
    outputs_one=list()
    
    outputs_two$main=round((tcm_now_filt/no_in)/((item_list_text$tcm-tcm_now_filt + .Machine$double.eps)/(no_documents-no_in)),4)
    
    
    outputs_one$main=data.frame("Word"=rownames(outputs_two$main),
                                "In_all"=diag(item_list_text$tcm),"In_group"=diag(tcm_now_filt)
                                #"In_all"=round(diag(item_list_text$tcm)/no_documents,5),"In_group"=round(diag(tcm_now_filt)/no_in,5)
                                ,"Score"=diag(outputs_two$main)
                                ,"Score_filtered"=round((diag(outputs_two$main)-1)*(diag(item_list_text$tcm)/no_documents),4)
                                #,"No_all"=no_documents,"No_in"=no_in
                                
    )
    

    
    rownames(outputs_one$main)=NULL
    outputs_one$main=outputs_one$main[order(outputs_one$main$Score,outputs_one$main$In_all,decreasing=T),]
    #outputs_one$main=outputs_one$main[order(outputs_one$main$Score_filtered,outputs_one$main$In_all,decreasing=T),]
    
    
    output$key_feat_one_output<-renderDT({
      datatable(
        outputs_one$main,
        extensions = c("Buttons", "Scroller"),
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          scrollX = TRUE,
          scrollY = "400px",
          scroller = TRUE,
          pageLength = 10,
          lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
          class = "display compact stripe hover"
        )
      )
    })
    

    
    
    removeModal()
    
  })
  
  output$topic_group_gen_info<-renderDT({
    
    topic_det_mat=list("Group"="All Data","No topics"=ncol(topic_models_list$model$Model$theta),"Cumulative Weight"=sum(as.numeric(topic_models_list$model$Model$theta),na.rm = T))
    
    group_names=names(topic_models_list[["model_list"]])
    for(i in 1:length(group_names)){
      temp_now=topic_models_list[["model_list"]][[group_names[i]]]
      topic_det_mat[["Group"]][i+1]=group_names[i]
      topic_det_mat[["No topics"]][i+1]=ncol(topic_models_list$model_list[[group_names[i]]]$Model$theta)
      topic_det_mat[["Cumulative Weight"]][i+1]=sum(as.numeric(topic_models_list$model_list[[group_names[i]]]$Model$theta),na.rm = T)
    }
    
    topic_det_mat=as.data.frame(topic_det_mat)
    
    datatable(
      topic_det_mat,
      extensions = c("Buttons", "Scroller"),
      options = list(
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        scrollX = TRUE,
        scrollY = "400px",
        scroller = TRUE,
        pageLength = 10,
        lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
        class = "display compact stripe hover"
      )
    )
  })
  
  observeEvent(input$topic_analysis_inspect_sel,{
    
    if(input$topic_analysis_inspect_sel=="all_data"){
      
      temp_dt_1=topic_models_list$model$Model$phi
      temp_dt_3=topic_models_list$model$Eval_list
    }else{
      #print(topic_models_list$model_list[[input$topic_analysis_inspect_sel]]$Model$theta)
      
      temp_dt_1=topic_models_list$model_list[[input$topic_analysis_inspect_sel]]$Model$phi
      temp_dt_3=topic_models_list$model_list[[input$topic_analysis_inspect_sel]]$Eval_list
    }
    
    output$topic_analysis_no_dif_topics<-renderDataTable({
      datatable(
        temp_dt_3,
        extensions = c("Buttons", "Scroller"),
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          scrollX = TRUE,
          scrollY = "400px",
          scroller = TRUE,
          pageLength = 10,
          lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
          class = "display compact stripe hover"
        )
      )

    })
    
    output$topic_analysis_topic_size<-renderDT({
      if(input$topic_analysis_inspect_sel=="all_data"){
        
        temp_dt_2=colSums(topic_models_list$model$Model$theta, na.rm = T)
        
      }else{

        temp_dt_2=colSums(topic_models_list$model_list[[input$topic_analysis_inspect_sel]]$Model$theta,na.rm = T)
        
      }
      
      datatable(
        data.frame(row.names = NULL,"Topic"=c(1:length(temp_dt_2)),"Weight"=temp_dt_2),
        extensions = c("Buttons", "Scroller"),
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          scrollX = TRUE,
          scrollY = "400px",
          scroller = TRUE,
          pageLength = 10,
          lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
          class = "display compact stripe hover"
        )
      )
    })
    
    output$topic_analysis_inspect_top_words<-renderDT({
      
      
      datatable(
        t(temp_dt_1),
        extensions = c("Buttons", "Scroller"),
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          scrollX = TRUE,
          scrollY = "400px",
          scroller = TRUE,
          pageLength = 10,
          lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
          class = "display compact stripe hover"
        )
      )
      
    })
    
    
    if(length(nrow(temp_dt_1))!=0){
      
      choices=paste0("Topic_",c(1:nrow(temp_dt_1)))
      choices=setNames(choices,choices)
      updateSelectizeInput(inputId ="topic_analysis_inspect_sel_topic",choices = choices)
      
      
    }
  
   
  })
  
  
  
  observeEvent(input$topic_analysis_inspect_sel_topic,{
    
    if(input$topic_analysis_inspect_sel_topic!=""){
      
      if(input$topic_analysis_inspect_sel=="all_data"){
        temp_dt_2=topic_models_list$model$Model$phi
        
      }else{
        
        temp_dt_2=topic_models_list$model_list[[input$topic_analysis_inspect_sel]]$Model$phi
        
      }
      
      selected_now=(unlist(strsplit(input$topic_analysis_inspect_sel_topic,split = "_"))[[2]])
      selected_now=as.numeric(selected_now)
      
      df_now=data.frame("Word"=colnames(temp_dt_2),"Percentage"=as.numeric(temp_dt_2[selected_now,]))
      rownames(df_now)=NULL
      df_now=df_now[order(df_now$Percentage,decreasing = T),]

     
      
      
      output$topic_analysis_inspect_top_words_topic<-renderPlotly({
        min_now=20*(input$topic_analysis_inspect_top_words_page-1)+1
        max_now=20*(input$topic_analysis_inspect_top_words_page)
        
        
        df_filt_now=df_now[min_now:max_now,]
        df_filt_now$Word=reorder(df_filt_now$Word, df_filt_now$Percentage)
        df_filt_now$Percentage=round(df_filt_now$Percentage,6)
        
        
        ggplot(df_filt_now,aes(x=Word ,y=Percentage))+
          geom_bar(stat = "identity", fill = "#fcba03") +
          coord_flip() +
          labs(title = paste("Word percentage in topic", selected_now),
               x = "Word", y = "Percentage") +
          #theme_minimal(base_size = 15)
          theme_solarized_2(light = T,base_size = 15)
        
        
      })
    }
    
 
    
  })

  
  
  
  
  observeEvent(input$topic_comp_but,{
    
    if(length(input$topic_comp_sel)>0){
      
      #please wait
      showModal(modalDialog(title = "Topic projection is in progress please wait",footer = NULL))
      
      
      choices_group=setNames(input$topic_comp_sel,input$topic_comp_sel)
      updateSelectizeInput(inputId = "topic_comp_table_sel_group",choices = choices_group)

      
      
      topics_sel_phi=do.call(
        rbind,lapply(input$topic_comp_sel,function(x){
          if(x=="all_data"){
            temp_row=topic_models_list$model$Model$phi
            rownames(temp_row)=paste0("all_data_topic_",c(1:nrow(temp_row)))
            temp_row=cbind(temp_row,colSums(topic_models_list$model$Model$theta,na.rm = T))
          }else{
            temp_row=topic_models_list[["model_list"]][[x]]$Model$phi
            rownames(temp_row)=paste0("group_",x,"_topic_",c(1:nrow(temp_row)))
            temp_row=cbind(temp_row,colSums(topic_models_list[["model_list"]][[x]]$Model$theta,na.rm = T))
            
            
          }
          return(temp_row)
          
        })
      )
      

      
      jsd_dist=JSD(x = topics_sel_phi[,-ncol(topics_sel_phi)])
      rownames(jsd_dist)=rownames(topics_sel_phi)
      colnames(jsd_dist)=rownames(topics_sel_phi)
      
      
      new_coords=cmdscale( d = jsd_dist,k=2)
      new_coords=as.data.frame(new_coords)
      colnames(new_coords)=c("x","y")
      rownames(new_coords)=rownames(topics_sel_phi)
      new_coords$size=topics_sel_phi[,ncol(topics_sel_phi)]
      new_coords$Group="0"
      new_coords$Topic="0"
      
      for(i in 1:nrow(new_coords)){
        
        split_name=unlist(strsplit(rownames(new_coords)[i],"_"))
        new_coords$Topic[i]=split_name[4]
        
        if(length(grep(pattern = "all_data",rownames(new_coords)[i]))>0){
          new_coords$Group[i]="all_data"
        }else{
          new_coords$Group[i]=split_name[2]
        }
      }
      
      output$topic_comp_plot<-renderPlotly({
        
        
        plot_now <- ggplotly(
          ggplot(data = new_coords, aes(x = x, y = y, size = size, color = Group,label=Topic)) +
            geom_point(alpha=0.6) + # Use filled points with a gradient fill        
            geom_text(aes(label = Topic), size = 4,color="black") +
            scale_size_continuous(range = c(5, 20)) +
            theme(legend.position = "none")+ # Hides all legends
            #expand_limits(x = new_coords$x, y = new_coords$y)+ # Adjust limits to fit the data
            coord_cartesian(xlim = range(new_coords$x) + c(-0.1, 0.1), ylim = range(new_coords$y) + c(-0.1, 0.1))+
            
            theme_solarized_2(light = T)
          
        )%>% layout(showlegend = FALSE)
        
        return(plot_now)
      })
      
      output$topic_comp_table<-renderDT({
        
        

        
        datatable(
          #jsd_dist[,which_in],
          jsd_dist,
          extensions = c("Buttons", "Scroller"),
          options = list(
            dom = 'Bfrtip',
            buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
            scrollX = TRUE,
            scrollY = "400px",
            scroller = TRUE,
            pageLength = 10,
            lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
            class = "display compact stripe hover"
          )
        )
      })
      

        observeEvent(input$topic_comp_table_sel_group,{
          if(input$topic_comp_table_sel_group!=""){
            #print(input$topic_comp_table_sel_group)
            
            if(input$topic_comp_table_sel_group=="all_data"){
              choices_topic=paste0("Topic_",c(1:nrow(topic_models_list$model$Model$phi)))
              
            }else{
              choices_topic=paste0("Topic_",c(1:nrow(topic_models_list$model_list[[input$topic_comp_table_sel_group]]$Model$phi)))
              
            }

            choices_topic=c("All topics",choices_topic)
            choices_topic=setNames(choices_topic,choices_topic)
            updateSelectizeInput(inputId = "topic_comp_table_sel_topic",choices = choices_topic)
            
            output$topic_comp_table_filt<-renderDT({
              
              selected_now=input$topic_comp_table_sel_group
              which_in=which(new_coords$Group==selected_now)
              
              if(input$topic_comp_table_sel_topic!="All topics"){
                topic_now_sel=unlist(strsplit(input$topic_comp_table_sel_topic,"_"))[[2]]
                which_in=which_in[as.numeric(topic_now_sel)]
              }
              
              return( datatable(
                data.frame(jsd_dist[,which_in]),
                extensions = c("Buttons", "Scroller"),
                options = list(
                  dom = 'Bfrtip',
                  buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
                  scrollX = TRUE,
                  scrollY = "400px",
                  scroller = TRUE,
                  pageLength = 10,
                  lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
                  class = "display compact stripe hover"
                )
              ))
              
            })
          }

          
        })




      

      
    removeModal()
      
    }else{
      showModal(
        modalDialog(title = "Please select at least one group",
                    tags$h4("Details:",error_message),
                    footer=modalButton("Continue"))
      )    
      }

  })
  
  
  observeEvent(input$start_global_key_topic,{
    selected_now=as.numeric(input$select_global_topic)
    
    df_topic_now=data.frame("Group"=dataset_chosen$main_matrix$new_group,"Weight"=topic_models_list$model$Model$theta[,selected_now])
    
    output$global_key_topic_boxplots<-renderPlotly({
      # Create the ggplot
      plot_now <- ggplotly(
        
        ggplot(data = df_topic_now, aes(x = Group, y = Weight, fill = Group, color = Group)) +
        #geom_violin(width = 2.1, size = 0.2) +
        geom_boxplot(width = 2.1, size = 0.2) +
        scale_fill_viridis(discrete = TRUE) +
        scale_color_viridis(discrete = TRUE) +
        #theme_ipsum() +
        theme_solarized_2(light = T)+
        theme(
          legend.position = "none"
        ) +
        coord_flip() + # Switch X and Y axis for horizontal version
        #theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
        xlab("Group") +
        ylab("Weight")
      
      )
        
    })
    
    
    unique_groups=unique(table_val$mat$new_group)
    score_un_group=data.frame("Group"=unique_groups,"No_Observations"=0,"Topic_Percentage_in"=0,"Topic_Percentage_out"=sum(df_topic_now$Weight),"Ratio"=0)
    
    for(i in 1:length(unique_groups)){
      
      which_in=which(dataset_chosen$main_matrix$new_group==unique_groups[i])
      score_un_group$No_Observations[i]=length(which_in)
      score_un_group$Topic_Percentage_in[i]=sum(topic_models_list$model$Model$theta[which_in,selected_now])#/length(which_in)
      score_un_group$Topic_Percentage_out[i]=(score_un_group$Topic_Percentage_out[i]-score_un_group$Topic_Percentage_in[i]+.Machine$double.xmin)/(nrow(dataset_chosen$main_matrix)-length(which_in))
      score_un_group$Topic_Percentage_in[i]=score_un_group$Topic_Percentage_in[i]/length(which_in)
      score_un_group$Ratio[i]=score_un_group$Topic_Percentage_in[i]/score_un_group$Topic_Percentage_out[i]
      
      
      }
    
    score_un_group=score_un_group[order(score_un_group$Ratio,decreasing = T),]
    
    output$global_key_topic_unant<-renderDT({
      return( datatable(
        data.frame(score_un_group),
        extensions = c("Buttons", "Scroller"),
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          scrollX = TRUE,
          scrollY = "400px",
          scroller = TRUE,
          pageLength = 10,
          lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
          class = "display compact stripe hover"
        )
      ))
    })
    
  })
  
  
  observeEvent(input$start_group_key_topic,{
    
    selected_now=input$select_group_key_topic
    
    temp_row_selected=topic_models_list$model_list[[selected_now]]$Model$phi
    
    topics_sel_phi=do.call(
      cbind,lapply(c("all_data",unique(table_val$mat$new_group)),function(x){
        if(x=="all_data"){
          temp_row=topic_models_list$model$Model$phi
          label=x
        }else{
          temp_row=topic_models_list[["model_list"]][[x]]$Model$phi
          label=x
        }
        jsd_dist_now=JSD(rbind(temp_row_selected,temp_row))
        
        jsd_dist_now=jsd_dist_now[1:nrow(temp_row_selected),-c(1:nrow(temp_row_selected))]
        
        min_val=apply(X=jsd_dist_now,FUN =function(y){
          if(x!=selected_now){
            return(min(y))
            
          }else{
            return(y[order(y)][2])
          }
          }
          ,MARGIN=1)
        
        return(min_val)
        
      })
    )
    
    
    #topics_sel_phi=as.data.frame(topics_sel_phi)
    
    rownames(topics_sel_phi)=paste0("Topic_",c(1:nrow(topics_sel_phi)))
    colnames(topics_sel_phi)=c("all_data",unique(table_val$mat$new_group))
    
    match_group=match(selected_now,unique(table_val$mat$new_group))
    min_s_mat=data.frame("Min_distance"=apply(topics_sel_phi[,-c(1,match_group+1)],1,function(x)min(x)))
    rownames(min_s_mat)=paste0("Topic_",c(1:nrow(topics_sel_phi)))
    
    output$min_dist_group_key_topic<-renderDT({
      
      return( datatable(
        min_s_mat,
        extensions = c("Buttons", "Scroller"),
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          scrollX = TRUE,
          scrollY = "400px",
          scroller = TRUE,
          pageLength = 10,
          lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
          class = "display compact stripe hover"
        )
      ))
      
    })
    
    output$dist_group_key_topic<-renderDT({
      
      return( datatable(
        t(topics_sel_phi),
        extensions = c("Buttons", "Scroller"),
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          scrollX = TRUE,
          scrollY = "400px",
          scroller = TRUE,
          pageLength = 10,
          lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
          class = "display compact stripe hover"
        )
      ))
      
    })
    
  
    observeEvent(input$coh_sel_confirm_comp,{
      
      #GetTopTerms(model$phi, no_top_terms, return_matrix = TRUE)
      top_words_per_topic=GetTopTerms(phi = temp_row_selected,M = input$coh_sel_top_comp,return_matrix = T)
      
      coherence_data_frame=matrix(0,nrow=length(names(item_list_text$tcm_list)),ncol=nrow(temp_row_selected))
      rownames(coherence_data_frame)=names(item_list_text$tcm_list)
      colnames(coherence_data_frame)=paste0("Topic_",c(1:nrow(temp_row_selected)))
      
      for(name_now in rownames(coherence_data_frame)){
        which_in=which(table_val[["mat"]][["new_group"]]==name_now)
        if(which_in>0){
          rows_in_group_now=sum(table_val[["mat"]]$Freq[which_in])
        }else{
          rows_in_group_now=(table_val[["mat"]]$Freq[which_in])
        }
        
        coherence_data_frame[name_now,]=find_coh(ldaOut.terms = top_words_per_topic,tcm = item_list_text$tcm_list[[name_now]],rows_train = rows_in_group_now,mean_now = F)
      }
      
      output$coh_sel_output_comp<-renderDT({
        
        return( datatable(
          coherence_data_frame,
          extensions = c("Buttons", "Scroller"),
          options = list(
            dom = 'Bfrtip',
            buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
            scrollX = TRUE,
            scrollY = "400px",
            scroller = TRUE,
            pageLength = 10,
            lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
            class = "display compact stripe hover"
          )
        ))
        
      })
      
    })
    
    
  })
  
  
  
  
  eval_list=reactiveValues("all_data"=NULL)
  
  observeEvent(input$confirm_pred_models,{
    
    showModal(modalDialog(title = "Text classification is in progress please wait",footer = NULL))
    
    
    library(caTools)
    
    
    if(input$select_target_pred_models=="no_target_choice"){
      
      split2=sample.split(dataset_chosen$main_matrix$new_group,SplitRatio=0.7)
      categories_assignement=dataset_chosen$main_matrix$new_group
      order_to_do=c(1:length(categories_assignement))
      
      
    }else if (input$select_target_pred_models=="target_choice"){
      #categories_assignement=rep(0,nrow(dataset_chosen$main_matrix))
      #categories_assignement[dataset_chosen$main_matrix$new_group==input$select_group_pred_models]=1

      which_in_no_target=which(dataset_chosen$main_matrix$new_group%in%unlist(input$select_groups_other_pred_models))
      categories_assignement=rep(0,length(which_in_no_target))
      
      which_in_target=which(dataset_chosen$main_matrix$new_group==input$select_group_pred_models)
      categories_assignement=c(categories_assignement,rep(1,length(which_in_target)))
      
      split2=sample.split(categories_assignement,SplitRatio=0.7)
      
      order_to_do=c(which_in_no_target,which_in_target)

    }
    
    if(input$select_feat_pred_models=="topic_choice"){
      
      features=topic_models_list$model$Model$theta[order_to_do,]
      ret_fi=T

    }else if (input$select_feat_pred_models=="vectors_choice"){
      library(textmineR)
      library(DirichletReg)
      library(Matrix)
      
      model_now_lsa=FitLsaModel(dtm = Matrix(as.matrix(item_list_text$dtm[order_to_do[which(split2==T)],]),sparse = T),k = 100)
      features=predict(model_now_lsa,Matrix(as.matrix(item_list_text$dtm[order_to_do,])))
      
      ret_fi=F
      
      
    }

    eval_list$all_data=train_test_class_new(features = features,split2 = split2,categories_assignement = categories_assignement,
                                     ml_lib="caret_lib"
                                     ,ml_sample_choice = input$select_imb_hand_pred_models
                                     ,ret_fi=ret_fi)
    

    if(length(table(categories_assignement))==2){
      eval_list$option="Single"
      
      updateSelectizeInput(inputId = "pred_target_view",choices=NULL)
      
      output$pred_model_view<-renderDT(
        datatable(
          eval_list$all_data$acc_mat
          ,
          extensions = c("Buttons", "Scroller"),
          options = list(
            dom = 'Bfrtip',
            buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
            scrollX = TRUE,
            scrollY = "400px",
            scroller = TRUE,
            pageLength = 10,
            lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
            class = "display compact stripe hover"
          )
        )
        
      )
      
    removeUI(selector = "#pred_model_view_acc")
      
      
    }else{
      eval_list$option="Multiple"
      
      table_now_vals=unique(table_val$mat$new_group)
      choices <- setNames(table_now_vals, table_now_vals)
      
      updateSelectizeInput(inputId = "pred_target_view",choices=choices)
      
      
      output$pred_model_view<-renderDT({

        
        datatable(
          eval_list$all_data$acc_mat[[input$pred_target_view]]
          ,
          extensions = c("Buttons", "Scroller"),
          options = list(
            dom = 'Bfrtip',
            buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
            scrollX = TRUE,
            scrollY = "400px",
            scroller = TRUE,
            pageLength = 10,
            lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
            class = "display compact stripe hover"
          )
        )
      
      })
      
      insertUI(
        selector = "#pred_model_view",
        where = "afterEnd",
        ui = textOutput(outputId = "pred_model_view_acc")
        
      )
      
      max_acc_now=(max(unlist(eval_list$all_data$acc_mat$accuracy)))
      
      output$pred_model_view_acc<-renderText({
        paste("Maximum Accuracy:",max_acc_now )
        
      })

    }
    
    #eval_list=outputs_now$eval_list
    
    output$pred_model_view_fi <-renderDT({
      datatable(
        eval_list$all_data$vimp_mat
        ,
        extensions = c("Buttons", "Scroller"),
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          scrollX = TRUE,
          scrollY = "400px",
          scroller = TRUE,
          pageLength = 10,
          lengthMenu = list(c(5, 10, 20, 50), c('5 rows', '10 rows', '20 rows', '50 rows')),
          class = "display compact stripe hover"
        )
      )
    })
    
    removeModal()  
    
    print("Classification models completed")
    
  })
  
  
  
   session$onSessionEnded(function() {
     #h2o.shutdown(prompt = F)
     
   })
   
   
}


shinyApp(ui, server)