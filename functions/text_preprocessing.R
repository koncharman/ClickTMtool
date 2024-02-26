"text_preprocessing"<-function(all_set_text,ngrams_clause=F,min_doc_r=0.002,max_doc_r=0.005,ret_dtm=T,do_stem=F,do_rmv_stop=T,do_lower_case=T,do_rmv_mention=T,do_rpl_number=T,do_rpl_hash=T,do_rpl_html=T,do_rpl_qmark=T,do_rpl_emark=T,do_rpl_punct=T,do_rpl_digit=T,basic_preprocess=T,split2,term_weight_fun="tf_chosen",min_ngrams=2,max_ngrams=4,thres_limits_data="all_data_chosen"){
  
  #ngrams_clause=F;min_doc_r=0.002;max_doc_r=0.005;ret_dtm=T;do_stem=F;do_rmv_stop=T;do_lower_case=T;do_rmv_mention=T;do_rpl_number=T;do_rpl_hash=T;do_rpl_html=T;do_rpl_qmark=T;do_rpl_emark=T;do_rpl_punct=T;do_rpl_digit=T;basic_preprocess=T;term_weight_fun=F
  
  set.seed(831)
  library(tm)
  library(word2vec)
  library("stringr")
  
  corpus = Corpus(VectorSource(all_set_text))
  
  if(basic_preprocess==T){
    corpus = Corpus(VectorSource(txt_clean_word2vec(x = all_set_text)))
    }else{
 
  library(textclean)
  
  library(tm)
  corpus = Corpus(VectorSource(all_set_text))
  if(do_lower_case==T) corpus = tm_map(corpus, tolower)
  if(do_rmv_mention==T)  corpus = tm_map(corpus, function(x)str_replace_all(string = x,pattern = "@\\w+", replacement = " ") )#"\\@.*? |\\@.*?[:punct:]"
  if(do_rpl_number==T)  corpus = tm_map(corpus, replace_number)
  if(do_rpl_hash==T)  corpus = tm_map(corpus, replace_hash)
  if(do_rpl_html==T)  corpus = tm_map(corpus, replace_html)
  corpus = tm_map(corpus, replace_contraction)
  corpus = tm_map(corpus, replace_word_elongation)
  
  if(do_rpl_qmark==T) corpus = tm_map(corpus, function(x)str_replace_all(x,"\\?", " questionmark"))
  if(do_rpl_emark==T) corpus = tm_map(corpus, function(x)str_replace_all(x,"\\!", " exclamationmark"))
  if(do_rpl_punct==T) corpus = tm_map(corpus, function(x)str_replace_all(x,"[:punct:]", " "))
  if(do_rpl_digit==T) corpus = tm_map(corpus, function(x)str_replace_all(x,"[:digit:]", " "))
  
  #corpus = tm_map(corpus, str_trim)
  corpus = tm_map(corpus, str_squish)
  
  
  
  }
  
  if(do_rmv_stop==T) corpus = tm_map(corpus, removeWords,  c("the",stopwords("english")))#Glove # see stopwords("smart")
  
  
  if (do_stem==T) corpus = tm_map(corpus, stemDocument) 
  
  
  if(ngrams_clause==T){
    
    library(tokenizers)
    NLP_tokenizer <- function(x)lapply(x,function(y)unlist(lapply(tokenize_ngrams(x = y,n_min = min_ngrams,n=max_ngrams,ngram_delim = "_"), paste, collapse = " ")))
    
    
    corpus=tm_map(corpus,NLP_tokenizer)
  }
  
  
  item_ret=list()
  item_ret[['text']]=corpus$content[1:length(corpus)]
  
  
  if(ret_dtm){
    
    
    
    if(thres_limits_data=="all_data_chosen"){
      min_doc=length(all_set_text)*min_doc_r # 0.1 0.002 *
      max_doc=length(all_set_text)*max_doc_r # 0.05 0.5 *
    }else if(thres_limits_data=="training_data_chosen"){
      min_doc=length(all_set_text[split2])*min_doc_r # 0.1 0.002 *
      max_doc=length(all_set_text[split2])*max_doc_r # 0.05 0.5 *
    }
    
    
    
    frequencies=DocumentTermMatrix(corpus[split2==T], control = list(bounds = list(global = c(min_doc, max_doc))))
    #frequencies=DocumentTermMatrix(corpus, control = list(bounds = list(global = c(min_doc, max_doc))))
    
    
    
    
    terms_chosen=frequencies$dimnames$Terms
   
    item_ret$old_words=terms_chosen
    
    
    frequencies=DocumentTermMatrix(corpus)
    

    
    tSparse = as.data.frame(as.matrix(frequencies[,terms_chosen]))
    
    
    
    colnames(tSparse)=make.names(colnames(tSparse))
    
    r_sums=rowSums(tSparse)
    
    col_s=colSums(tSparse)
    col_s_max=which(col_s==max(col_s))
    
    r_sums_0=which(r_sums==0)
    
    if(length(r_sums_0)>0){
      item_ret$text[r_sums_0]=unlist(lapply(item_ret$text[r_sums_0],function(x)paste(x,names(col_s_max))))
      tSparse[r_sums_0,col_s_max]=1
      r_sums[r_sums_0]=1
    } 
    
    
    if(term_weight_fun=="tfidf_chosen"){
      
      library(binda)
      term_doc_exist=colSums(dichotomize(tSparse[split2==T,],.Machine$double.xmin))
      tSparse=tSparse/r_sums
      tSparse=t(t(tSparse)*log(x = length(which(split2==T))/term_doc_exist,base = 2))
    }
    
    if(term_weight_fun=="binarytf_chosen"){
      tSparse= dichotomize(X = tSparse,thresh = .Machine$double.xmin)
    }
    
    item_ret[['dtm']]=tSparse
    #Used for topic coherence - existence of term in a document, binary relation
    item_ret[['tcm']]=crossprod(binda::dichotomize(tSparse[split2==T,],thresh = .Machine$double.xmin))
    rownames(item_ret[['tcm']])=colnames(item_ret[['dtm']])
    colnames(item_ret[['tcm']])=colnames(item_ret[['dtm']])
    
  
  }
  
  
  
  
  
  return(item_ret)
  
  
  
  
  
  
  
}