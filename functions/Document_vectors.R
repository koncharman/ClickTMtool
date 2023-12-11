"Document_vectors"<-function(word_vectors=NULL,item_list_text,categories_assignement,split2,option="nom_choice",type="star_model",no_dims=50,type_words="all_words"){
  set.seed(831)
  
  if(type=="lsa_model"){
    library(textmineR)
    library(DirichletReg)
    library(Matrix)
    model=FitLsaModel(dtm = Matrix(as.matrix(item_list_text$dtm[split2==T,]),sparse = T),k = no_dims)
    return(predict(model,Matrix(as.matrix(item_list_text$dtm))))#,iterations = iter_var
  }
  
  
  if(option=="nom_choice"){
    if(type=="star_model"){
     library(ruimtehol)
      model <- embed_tagspace(x = item_list_text$text[split2],
                              y = categories_assignement[split2],
dim = no_dims, minCount = 1,minCountLabel = 1 ,ngrams=2 ,adagrad=T, lr=0.05 ,loss='hinge' ,margin=0.05,negSearchLimit=50,similarity="cosine", ws=5,epoch=10,bucket=10000000L,early_stopping = 1)
      return(predict(object = model,newdata = item_list_text$text,type='embedding'))
    }else if (type=="ft_model"){
      library(fastTextR)
      
      library(caret)
      
      ft_whole_set=paste("__label__",categories_assignement[split2]," ",item_list_text$text[split2],sep="")
      
      
      train<-ft_normalize(ft_whole_set)
      writeLines(train, con = "fastText_train.train")
      
      set.seed(831)
      
      cntrl <- cntrl <- ft_control(word_vec_size  = no_dims, learning_rate = 0.05, max_len_ngram = 5L,
                                   min_count = 1L, nbuckets = 10000000L, epoch = 200, nthreads = 2L)#epoch = 200L,
      
      model <- ft_train(file = "fastText_train.train", method = "supervised", control = cntrl)
      
      return(ft_word_vectors(model,words = item_list_text$text))
    }else if (type=="dan_model"){
      h2o.init(nthreads = -1)
      initial_weights=list(NULL,NULL,NULL)
      hiden_l=c(no_dims,no_dims)
      if(type_words=="dtm_ww"){
        hiden_l=c(ncol(word_vectors),no_dims)
        initial_weights=list(t(as.h2o(word_vectors)),NULL,NULL)
      } 
      
      x_pos=1:ncol(item_list_text$dtm)
      y_pos=ncol(item_list_text$dtm)+1
      model=h2o.deeplearning(x=x_pos,y = y_pos,reproducible = T,activation = "Tanh",
                             seed = 831,training_frame = as.h2o(cbind(item_list_text$dtm[split2,],as.factor(categories_assignement[split2]))),average_activation=1,fast_mode = F,
                             autoencoder = F,hidden = hiden_l,epochs = 10,rate=0.005
                             #,loss="CrossEntropy"
                             #balance_classes=T
                             ,initial_weights=initial_weights,initial_biases = list(NULL,NULL,NULL)
      )
      ret_mat_vec=as.matrix(h2o.deepfeatures(model, as.h2o(item_list_text$dtm), layer = 2))
      if(nrow(ret_mat_vec)!=length(item_list_text$text))ret_mat_vec=ret_mat_vec[-1,]

     return(ret_mat_vec)
      
    }
    
  }else if(option=="con_choice"){
    if(type=="star_model"){
      library(ruimtehol)
      model <- embed_wordspace(x = item_list_text$text[split2],
                             
                              dim = no_dims, minCount = 1,ngrams=2 ,adagrad=T, lr=0.05 ,loss='hinge' ,margin=0.05,negSearchLimit=50,similarity="cosine", ws=5,epoch=10,bucket=10000000L)
      return(predict(object = model,newdata = item_list_text$text,type='embedding'))
    }else if (type=="ft_model"){
      library(fastTextR)
      ft_whole_set=paste(item_list_text$text[split2],sep="")
      train<-ft_normalize(ft_whole_set)
      writeLines(train, con = "fastText_train.train")
      
      set.seed(831)
      
      cntrl <- cntrl <- ft_control(word_vec_size  = no_dims, learning_rate = 0.05, max_len_ngram = 2L,
                                   min_count = 1L, nbuckets = 1000L, epoch = 10, nthreads = 2L)#epoch = 200L,
      
      model <- ft_train(file = "fastText_train.train", method = "skipgram", control = cntrl)
      
      return(ft_word_vectors(model,words = item_list_text$text))
    }else if(type=="dan_model"){
      h2o.init(nthreads = -1)
      initial_weights=list(NULL,NULL,NULL)
      hiden_l=c(no_dims,no_dims)
      if(type_words=="dtm_ww"){
        hiden_l=c(ncol(word_vectors),no_dims)
        initial_weights=list(t(as.h2o(word_vectors)),NULL,NULL)
      } 
      
      x_pos=1:ncol(item_list_text$dtm)
      y_pos=ncol(item_list_text$dtm)+1
      model=h2o.deeplearning(x=x_pos,y = y_pos,reproducible = T,activation = "Tanh",
                             seed = 831,training_frame = as.h2o(cbind(item_list_text$dtm[split2,],as.numeric(categories_assignement[split2]))),average_activation=1,fast_mode = F,
                             autoencoder = F,hidden = hiden_l,epochs = 10,rate=0.005
                             #,loss="CrossEntropy"
                             #balance_classes=T
                             ,initial_weights=initial_weights,initial_biases = list(NULL,NULL,NULL)
      )
      ret_mat_vec=as.matrix(h2o.deepfeatures(model, as.h2o(item_list_text$dtm), layer = 2))
      if(nrow(ret_mat_vec)!=length(item_list_text$text))ret_mat_vec=ret_mat_vec[-1,]
      
      
      return(ret_mat_vec)
    }
  }
  
  if(option=="nom_choice"){
    return(tensorflow_keras_nn_funs(all_set_text_final = item_list_text$text,categories_assignement = categories_assignement,split2 = split2,imbalance_cond = T,nom_con_var = option,type = type,no_dims = no_dims,type_words=type_words,item_list_text=item_list_text,word_vectors=word_vectors))
  }else if(option=="con_choice"){
    return(tensorflow_keras_nn_funs(all_set_text_final = item_list_text$text,categories_assignement = categories_assignement,split2 = split2,imbalance_cond = F,nom_con_var = option,type = type,no_dims = no_dims,type_words=type_words,item_list_text=item_list_text,word_vectors=word_vectors))
  }

  }