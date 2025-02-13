"prepare_glove_new"<-function(dtm_now=NULL,tcm_now=NULL,text_now=NULL,vector_type,glove_skipgram_clause=T,ws=21,split2,full_tcm_clause=F,dimensions=200){
  
  
  set.seed(831)

  #####GLOVE
  library(text2vec)
  
  if(glove_skipgram_clause==T){
    

    contents=text_now
    itokens = space_tokenizer(contents)
    

    
    it=itoken(itokens)
    
    library(tm)
    vocab=create_vocabulary(it)
    
    vocab[,1]=make.names(vocab[,1])
    
    
    

    #vocab_pruned = prune_vocabulary(vocab, doc_proportion_min = 0.002,doc_proportion_max = 0.5) #*
    vocab_pruned=vocab[match(colnames(dtm_now),vocab[,1]),]

    vectorizer=vocab_vectorizer(vocab_pruned)


    windowsize=ws #*
    
    tcm_glove = create_tcm(it = it,vectorizer =  
                             vectorizer, skip_grams_window =windowsize,skip_grams_window_context = 'symmetric',binary_cooccurence = T) # ,weights = rep(1,windowsize) *
    

  }else{
    if(full_tcm_clause==T){
      tcm_glove=crossprod(as.matrix(dtm_now))
    }else{
      tcm_glove=tcm_now
    }
  }
 
  
  

  library(text2vec)
  lr=0.05 ; ct=-1

  glove = GloVe$new(rank = dimensions,x_max = 1000 ) #x_max = 10, ,learning_rate=lr
  
  set.seed(831)

  wv_main = glove$fit_transform(as.matrix(tcm_glove), convergence_tol = ct, n_threads = 4) #, n_iter = 100

  #
  wv_context = glove$components
  dim(wv_context)
  
  #
  word_vectors = wv_main + t(wv_context)
  

  
  return(word_vectors)
  
}