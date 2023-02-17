"tensorflow_keras_nn_funs"<-function(all_set_text_final,categories_assignement,split2,type="LSTM_new",nom_con_var="nom_choice",imbalance_cond=T,no_dims=50){
  set.seed(831)
  
  ####Link
  #https://cran.r-project.org/web/packages/keras/keras.pdf
  #https://cran.r-project.org/web/packages/tensorflow/tensorflow.pdf
  
  ####Data prepare
  # Data Wrangling
  library(tidyverse)
  
  # Text Preprocessing
  library(tidytext)
  library(textclean)
  library(hunspell)
  
  # Model Evaluation
  library(yardstick)
  
  # Naive Bayes
  library(e1071)
  
  # Deep Learning
  library(keras)
  library(tensorflow)
  
  #install_keras()
  #install_tensorflow(version = "nightly") # install_tensorflow()
  #use_condaenv("r-tensorflow")
  
  library(furrr) 
  plan(multisession, workers = 4) # Using 4 CPU cores
  
  
  num_words <- paste(all_set_text_final, collapse = " ") %>% 
    str_split(" ") %>% 
    unlist() %>% 
    n_distinct()
  
  tokenizer <- text_tokenizer(num_words = num_words) %>% 
    fit_text_tokenizer(all_set_text_final[split2==T])
  
  # Maximum Length of Word to use
  maxlen <- 250
  
  x_set=texts_to_sequences(tokenizer, all_set_text_final) %>% 
    pad_sequences(maxlen = maxlen, padding = "pre", truncating = "post")
  
  minor_class=c(1:(length(table(categories_assignement[split2])[-1])))
  over_sample_data=data.frame()
  over_sample_output=c()
  
  if(nom_con_var=="nom_choice"){
  if(imbalance_cond==T){
    multiclass_values=table(categories_assignement[split2])
    max_class=match(max(as.numeric(multiclass_values)),as.numeric(multiclass_values))
    
    minor_class=names(multiclass_values)[-max_class]
    max_class=names(multiclass_values)[max_class]
    
    
    library(smotefamily)
    
    max_class_pos=which(categories_assignement[split2]==max_class)
    
    temp_train_frame=data.frame(x_set[split2==T,],categories_assignement[split2])
    colnames(temp_train_frame)=c(colnames(x_set[split2==T,]),"categories_assignement[split2]")
    
    for(i in 1:length(minor_class)){
      min_class_pos=which(categories_assignement[split2]==minor_class[i])
      Adasyn=ADAS(X = temp_train_frame[c(min_class_pos,max_class_pos),-c((maxlen+1))],target = temp_train_frame[c(min_class_pos,max_class_pos),c((maxlen+1))],K=5)
      
      colnames(Adasyn$syn_data)=colnames(temp_train_frame)
      
      over_sample_data=rbind(over_sample_data,as.matrix(Adasyn$syn_data[,-c((maxlen+1))]))
      over_sample_output=append(over_sample_output,Adasyn$syn_data[,c((maxlen+1))])
      
    }
    
    
    temp_train_frame=NULL
    Adasyn=NULL
  }
  }

  if(imbalance_cond==T){
    over_sample_output=as.numeric(over_sample_output)
    rownames(over_sample_data)=rownames(x_set)
    colnames(over_sample_data)=colnames(x_set)
    
  }
#tensorflow::set_random_seed(123)
  # Build model architecture
  if(nom_con_var=="nom_choice"){
    if(length(minor_class)==1){
    loss_fun="binary_crossentropy"
    output_dense_dim=1
    }else{
    loss_fun="categorical_crossentropy"
    categories_assignement[split2]=to_categorical(categories_assignement[split2])
    categories_assignement[split2==F]=to_categorical(categories_assignement[split2==F])
    over_sample_data=to_categorical(over_sample_data)
      
    output_dense_dim=ncol(categories_assignement[split2])
    }
    metric_applied="accuracy"
    
  }else if(nom_con_var=="con_choice"){
    loss_fun="mse"
    metric_applied="mae"
    output_dense_dim=1
  }
  
  
  
  if(type=="LSTM"){
    model <- keras_model_sequential(name = "lstm_model") %>% 
      layer_embedding(name = "input",
                      input_dim = num_words,
                      input_length = maxlen,
                      output_dim = 8
      ) %>% 
      layer_lstm(name = "LSTM",
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
    
    if(imbalance_cond==T){
      history <- model %>%
        fit(
          x = rbind(x_set[split2==T,],as.matrix(over_sample_data)),
          y = append(categories_assignement[split2],over_sample_output),
          batch_size = batch_size,
          epochs = epochs,
          validation_split = 0.2
        ) 
    }else{
      history <- model %>%
        fit(
          x = x_set[split2==T,],
          y = categories_assignement[split2],
          batch_size = batch_size,
          epochs = epochs,
          validation_split = 0.2
        )
    }
    
    #evaluate(model, x_set[split2==F,], categories_assignement[split2==F], verbose = 0)
    
    pop_layer(model)

    pred_test <- predict(model, x_set) 
    
    
    
   
   
  }else if(type=="RNN"){
    model <- keras_model_sequential()
    model %>%
      layer_embedding(input_dim = num_words, output_dim = 128) %>% 
      layer_simple_rnn(units = 64, dropout = 0.2, recurrent_dropout = 0.2) %>% 
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
    
    if(imbalance_cond==T){
      history <- model %>%
        fit(
          x = rbind(x_set[split2==T,],as.matrix(over_sample_data)),
          y = append(categories_assignement[split2],over_sample_output),
          batch_size = batch_size,
          epochs = epochs,
          validation_split = 0.2
        ) 
    }else{
      history <- model %>%
        fit(
          x = x_set[split2==T,],
          y = categories_assignement[split2],
          batch_size = batch_size,
          epochs = epochs,
          validation_split = 0.2
        )
    }
    
    #evaluate(model, x_set[split2==F,], categories_assignement[split2==F], verbose = 0)
    pop_layer(model)
    
    pred_test <- predict(model, x_set)
   
   
  }else if (type=="LSTM_new"){
    #######Lstm new
    model <- keras_model_sequential()
    
    model %>%
      layer_embedding(input_dim = num_words, output_dim = 128) %>% 
      layer_lstm(units = 64, dropout = 0.2, recurrent_dropout = 0.2) %>% 
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
    
    if(imbalance_cond==T){
      history <- model %>%
        fit(
          x = rbind(x_set[split2==T,],as.matrix(over_sample_data)),
          y = append(categories_assignement[split2],over_sample_output),
          batch_size = batch_size,
          epochs = epochs,
          validation_split = 0.2
        ) 
    }else{
      history <- model %>%
        fit(
          x = x_set[split2==T,],
          y = categories_assignement[split2],
          batch_size = batch_size,
          epochs = epochs,
          validation_split = 0.2
        )
    }
    
    
    pop_layer(model)

    pred_test <- predict(model, x_set)
    
    
    
  }else if(type=="CNN"){
    batch_size <- 32
    embedding_dims <- 50
    filters <- 64
    kernel_size <- 3
    hidden_dims <- 50
    epochs <- 10
    
    # Input image dimensions
    img_rows <- 1
    img_cols <- maxlen
    
    model <- keras_model_sequential() %>% 
      layer_embedding(input_dim = num_words, output_dim = embedding_dims, input_length = maxlen) %>%
      layer_dropout(0.2) %>%
      layer_conv_1d(
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
    

    if(imbalance_cond==T){
      history <- model %>%
        fit(
          x = rbind(x_set[split2==T,],as.matrix(over_sample_data)),
          y = append(categories_assignement[split2],over_sample_output),
          batch_size = batch_size,
          epochs = epochs,
          validation_split = 0.2
        ) 
    }else{
      history <- model %>%
        fit(
          x = x_set[split2==T,],
          y = categories_assignement[split2],
          batch_size = batch_size,
          epochs = epochs,
          validation_split = 0.2
        )
    }
    
    
    plot(history)
    
    pop_layer(model)
    pop_layer(model)

    pred_test <- predict(model, x_set) 
    
    
    #######
  }
  
  return(pred_test)
}