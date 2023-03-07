"tensorflow_keras_nn_funs"<-function(all_set_text_final,categories_assignement,split2,type="LSTM",nom_con_var="nom_choice",imbalance_cond=T,no_dims=50,type_words="all_words",item_list_text,word_vectors){
  set.seed(831)
  
 
  ####Data prepare
  # Data Wrangling
  library(tidyverse)
  
  
  # Deep Learning
  library(keras)
  library(tensorflow)
    
  library(furrr) 
  plan(multisession, workers = 4) # Using 4 CPU cores
  
  # Maximum Length of Word to use
  maxlen <- 250
  
  if(type_words=="all_words"){
    
    
    num_words <- paste(all_set_text_final, collapse = " ") %>% 
      str_split(" ") %>% 
      unlist() %>% 
      n_distinct()
    
    tokenizer <- text_tokenizer(num_words = num_words) %>% 
      fit_text_tokenizer(all_set_text_final[split2==T])
    
    
    
    x_set=texts_to_sequences(tokenizer, all_set_text_final) %>% 
      pad_sequences(maxlen = maxlen, padding = "pre", truncating = "post")
    
    word_weights_cond=NULL
    
  }else if (type_words=="dtm_nw"){
    num_words=ncol(item_list_text$dtm)+1
    
    x_set=matrix(nrow=length(item_list_text$text),ncol = maxlen,0)
    
    
    doc_train=strsplit(x = item_list_text$text,split = " ")
    
    for(i in 1:length(item_list_text$text)){
      doc_train[[1]]=match(doc_train[[1]],item_list_text$old_words)
      doc_train[[1]]=doc_train[[1]][which(!is.na(doc_train[[1]]))]
      
      temp_pivot=length(doc_train[[1]])
      
      if(temp_pivot==maxlen){
        x_set[i,]=doc_train[[1]]
        
      }else if(temp_pivot>=maxlen){
        x_set[i,]=doc_train[[1]][1:maxlen]
      }
      else{
        x_set[i,]=c(rep(0,(maxlen-temp_pivot)),doc_train[[1]])
      }
      doc_train[[1]]=NULL
    }
    

    
    word_weights_cond=NULL
    doc_train=NULL
    
  }else if (type_words=="dtm_ww"){
    num_words=ncol(item_list_text$dtm)+1
    
    x_set=matrix(nrow=length(item_list_text$text),ncol = maxlen,0)
    
    
    doc_train=strsplit(x = item_list_text$text,split = " ")
    
    for(i in 1:length(item_list_text$text)){
      doc_train[[1]]=match(doc_train[[1]],item_list_text$old_words)
      doc_train[[1]]=doc_train[[1]][which(!is.na(doc_train[[1]]))]
      
      temp_pivot=length(doc_train[[1]])
      
      if(temp_pivot==maxlen){
        x_set[i,]=doc_train[[1]]
        
      }else if(temp_pivot>=maxlen){
        x_set[i,]=doc_train[[1]][1:maxlen]
      }
      else{
        x_set[i,]=c(rep(0,(maxlen-temp_pivot)),doc_train[[1]])
      }
      doc_train[[1]]=NULL
    }
    
    
    
    word_weights_cond=1
    doc_train=NULL

  }
  
  
  
  if(nom_con_var=="con_choice"){
    class_weights_all=NULL
    init_weights=rep(1,length(split2[split2==T]))
    
  }else{
    if(imbalance_cond==T){
      table_output=table(categories_assignement[split2])
      max_index=match(max(table_output),table_output)
      
      min_index=c(1:length(table_output)); min_index=min_index[-max_index]
      
      init_weights=rep(1,length(split2[split2==T]))
      class_weights_all=list()
      class_weights_all[[names(table_output)[max_index]]]=1
      for(i in 1:length(min_index)){
        temp_match=which(categories_assignement[split2]==names(table_output[min_index[i]]))
        init_weights[temp_match]=table_output[max_index]/table_output[min_index[i]]
        class_weights_all[[names(table_output)[min_index[i]]]]=table_output[max_index]/table_output[min_index[i]]
      }
    }else{
      class_weights_all=NULL
      init_weights=rep(1,length(split2[split2==T]))
      
    }
  }
  
  
  
  

  if(nom_con_var=="nom_choice"){
    if(length(min_index)==1){
    loss_fun="binary_crossentropy"
    output_dense_dim=1
    categories_assignement=as.matrix(categories_assignement,ncol=1)
    }else{
    loss_fun="categorical_crossentropy"
    
    
    c_a=to_categorical(categories_assignement)
    
    categories_assignement=c_a
    c_a=NULL

    output_dense_dim=ncol(categories_assignement)
    }
    metric_applied="accuracy"
    
  }else if(nom_con_var=="con_choice"){
    loss_fun="mse"
    metric_applied="mae"
    output_dense_dim=1
    categories_assignement=as.matrix(categories_assignement,ncol=1)
    
  }
  
  
  
  if(type=="LSTM"){
    
    if(!is.null(word_weights_cond)){
      model <- keras_model_sequential(name = "lstm_model") %>% 
        layer_embedding(trainable = T,input_dim = num_words, output_dim = ncol(word_vectors), input_length = maxlen,weights = list(rbind(rep(0,ncol(word_vectors)),word_vectors)))
      }else{
        model <- keras_model_sequential(name = "lstm_model") %>% 
          layer_embedding(name = "input",
                          input_dim = num_words,
                          input_length = maxlen,
                          output_dim = 8
                          ) 
    }
    

    model%>% layer_lstm(name = "LSTM",
                 units = 8,
                 kernel_regularizer = regularizer_l1_l2(l1 = 0.05, l2 = 0.05),
                 return_sequences = F
      ) %>%
      layer_dense(no_dims)%>%
      layer_dense(name = "Output",
                  units = output_dense_dim,
                  activation = "sigmoid"
      )
    
    
   
    
    
    
    model %>% 
      compile(optimizer = optimizer_adam(learning_rate  = 0.001),
              metrics = metric_applied,
              loss = loss_fun
      )
    
    epochs <- 10
    batch_size <- 64
    
    
    history <- model %>%
      fit(
        x = x_set[split2==T,],
        y = categories_assignement[split2,],
        batch_size = batch_size,
        epochs = epochs,
        validation_split = 0.2,sample_weight = init_weights,class_weight=class_weights_all
      )
    
    

    pop_layer(model)

    pred_test <- predict(model, x_set) 
    
    
    
   
   
  }else if(type=="RNN"){
    model <- keras_model_sequential()
    
    if(!is.null(word_weights_cond)){
      model %>%
        layer_embedding(trainable = T,input_dim = num_words, output_dim = ncol(word_vectors), input_length = maxlen,weights = list(rbind(rep(0,ncol(word_vectors)),word_vectors)))    
      }else{
      model %>%
        layer_embedding(input_dim = num_words, output_dim = 128) 
    }
    

      model %>% layer_simple_rnn(units = 64, dropout = 0.2, recurrent_dropout = 0.2) %>% 
      layer_dense(units = no_dims)%>%
      layer_dense(units = output_dense_dim, activation = 'sigmoid')
    
    model %>% compile(
      loss = loss_fun,
      optimizer = 'adam',
      metrics = metric_applied
    )
    
    batch_size = 128
    epochs = 10
    validation_split = 0.2
    
    
    history <- model %>%
      fit(
        x = x_set[split2==T,],
        y = categories_assignement[split2,],
        batch_size = batch_size,
        epochs = epochs,
        validation_split = 0.2,sample_weight = init_weights,class_weight=class_weights_all
      )
    
    
    pop_layer(model)
    
    pred_test <- predict(model, x_set)
   
   
  }else if(type=="CNN"){
    batch_size <- 32
    embedding_dims <- 50
    filters <- 64
    kernel_size <- 3
    hidden_dims <- 50
    epochs <- 10
    
    img_rows <- 1
    img_cols <- maxlen
    
    if(!is.null(word_weights_cond)){
      model <- keras_model_sequential() %>% 
        layer_embedding(trainable = T,input_dim = num_words, output_dim = ncol(word_vectors), input_length = maxlen,weights = list(rbind(rep(0,ncol(word_vectors)),word_vectors))) %>% #(rbind(rep(0,20),word_vectors))
        layer_dropout(0.2)
    }else{
      model <- keras_model_sequential() %>% 
        layer_embedding(input_dim = num_words, output_dim = embedding_dims, input_length = maxlen) %>%
        layer_dropout(0.2)
    }
    
   
      
    model %>%layer_conv_1d(
        filters, kernel_size, 
        padding = "valid", activation = "relu", strides = 1
      ) %>%
      layer_global_max_pooling_1d() %>%
      layer_dense(hidden_dims) %>%
      layer_dropout(0.2) %>%
      layer_activation("relu") %>%
      layer_dense(no_dims) %>%
      layer_dense(output_dense_dim) %>%
      layer_activation("sigmoid") %>% compile(
        loss = loss_fun,
        optimizer = "adam",
        metrics = metric_applied
      )
    

    
      history <- model %>%
        fit(
          x = x_set[split2==T,],
          y = categories_assignement[split2,],
          batch_size = batch_size,
          epochs = epochs,
          validation_split = 0.2,sample_weight = init_weights,class_weight=class_weights_all
        )
    
    
    
    plot(history)
    
    pop_layer(model)
    pop_layer(model)

    pred_test <- predict(model, x_set) 
    
    
    #######
  }
  
  return(pred_test)
}