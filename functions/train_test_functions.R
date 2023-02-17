"train_test_functions"<-function(features,split2,categories_assignement,imbalance_cond=T,weight_or_balance="weight_choice"){
  
  set.seed(831)
  
  new2_trainSparse=as.data.frame(features[split2==T,])
  new2_testSparse=as.data.frame(features[split2==FALSE,])
  
  new2_trainSparse$Exploit_output=(categories_assignement[split2==T])
  new2_testSparse$Exploit_output=(categories_assignement[split2==F])
  
  features=NULL
  
  
  init_weights=rep(1,length(split2[split2==T]))
  balance_cond=F
  
  if(imbalance_cond==T){
  if(weight_or_balance=="weight_choice"){
    table_output=table(categories_assignement[split2])
    max_index=match(max(table_output),table_output)
    
    min_index=c(1:length(table_output)); min_index=min_index[-max_index]
    
    
    
    for(i in 1:length(min_index)){
      temp_match=which(categories_assignement[split2]==names(table_output[min_index[i]]))
      init_weights[temp_match]=table_output[max_index]/table_output[min_index[i]]
    }
    
  }else if (weight_or_balance=="balance_choice"){
    balance_cond=T
    
    
    
  }
}
  colnames(new2_trainSparse)[ncol(new2_trainSparse)]="Exploit_output"
  colnames(new2_testSparse)=colnames(new2_trainSparse)
  #
  new2_trainSparse$Exploit_output=as.factor(new2_trainSparse$Exploit_output)
  new2_testSparse$Exploit_output=as.factor(new2_testSparse$Exploit_output)
  
  new2_trainSparse$Exploit_output
  
  print(table(new2_trainSparse$Exploit_output))
  ##
  
  
  

  
  
  x_pos=1:(ncol(new2_trainSparse)-1)
  y_pos=ncol(new2_trainSparse)
  

  tr_length=nrow(new2_trainSparse)
  te_length=nrow(new2_testSparse) 
  
  new2_trainSparse$weight=init_weights
  
  new2_trainSparse=as.h2o(new2_trainSparse)
  new2_testSparse=as.h2o(new2_testSparse)
  
  if(nrow(new2_trainSparse)!=tr_length){new2_trainSparse=new2_trainSparse[-1,]}
  
  if(nrow(new2_testSparse)!=te_length){new2_testSparse=new2_testSparse[-1,]}
  
  reg_models_names=c("Generalized Linear Models",
                     "Gradient Boosting Machines",
                     "RANDOM FOREST",
                     "Naive bayes",
                     #"eXtreme Gradient Boosting",
                     "Deep Learning",
                     
                     #"Stacked Ensemble",
                     "Ensemble (Median)")
  

  pred_list=list()
  
  if(balance_cond==F){
    k=1
    model <- h2o.glm(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831,family= "AUTO",weights_column = "weight",balance_classes = balance_cond)
    pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
    if(length(pred_list[[k]])!=nrow(new2_testSparse)){
      pred_list[[k]]=pred_list[[k]][-1]
    }
    
    k=k+1
    model <- h2o.gbm(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831, ntrees = 10,max_depth = 3,min_rows = 2, learn_rate = 0.2,distribution= "AUTO",weights_column = "weight",balance_classes = balance_cond)
    pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
    if(length(pred_list[[k]])!=nrow(new2_testSparse)){
      pred_list[[k]]=pred_list[[k]][-1]
    }
    
    k=k+1
    model <- h2o.randomForest(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831,weights_column = "weight",balance_classes = balance_cond)
    pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
    if(length(pred_list[[k]])!=nrow(new2_testSparse)){
      pred_list[[k]]=pred_list[[k]][-1]
    }
    
    k=k+1
    model <- h2o.naiveBayes(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831)
    pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
    if(length(pred_list[[k]])!=nrow(new2_testSparse)){
      pred_list[[k]]=pred_list[[k]][-1]
    }
    
    k=k+1
    model <- h2o.deeplearning(x=x_pos,y = y_pos,reproducible = T,activation = "Tanh",
                              seed = 831,training_frame = new2_trainSparse,average_activation=1,fast_mode = F,
                              hidden = 128,epochs = 10,rate=0.005
                              ,weights_column = "weight",balance_classes = balance_cond
                              #,loss="CrossEntropy"
    )
    pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
    if(length(pred_list[[k]])!=nrow(new2_testSparse)){
      pred_list[[k]]=pred_list[[k]][-1]
    }
  }else{
    k=1
    model <- h2o.glm(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831,family= "AUTO",balance_classes = balance_cond)
    pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
    if(length(pred_list[[k]])!=nrow(new2_testSparse)){
      pred_list[[k]]=pred_list[[k]][-1]
    }
    
    k=k+1
    model <- h2o.gbm(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831, ntrees = 10,max_depth = 3,min_rows = 2, learn_rate = 0.2,distribution= "AUTO",balance_classes = balance_cond)
    pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
    if(length(pred_list[[k]])!=nrow(new2_testSparse)){
      pred_list[[k]]=pred_list[[k]][-1]
    }
    
    k=k+1
    model <- h2o.randomForest(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831,weights_column = "weight",balance_classes = balance_cond)
    pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
    if(length(pred_list[[k]])!=nrow(new2_testSparse)){
      pred_list[[k]]=pred_list[[k]][-1]
    }
    
    k=k+1
    model <- h2o.naiveBayes(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831,balance_classes =F)
    pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
    if(length(pred_list[[k]])!=nrow(new2_testSparse)){
      pred_list[[k]]=pred_list[[k]][-1]
    }
    
    k=k+1
    model <- h2o.deeplearning(x=x_pos,y = y_pos,reproducible = T,activation = "Tanh",
                              seed = 831,training_frame = new2_trainSparse,average_activation=1,fast_mode = F,
                              hidden = 128,epochs = 10,rate=0.005
                              ,balance_classes = balance_cond
                              #,loss="CrossEntropy"
    )
    pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
    if(length(pred_list[[k]])!=nrow(new2_testSparse)){
      pred_list[[k]]=pred_list[[k]][-1]
    }
  }
  
 
  k=k+1
  pred_list[[6]]=list()
  
  for(i in 1:nrow(new2_testSparse)){
    temp=c()
    for(j in 1:(length(reg_models_names)-1)){
      temp[j]=pred_list[[j]][i]
    }
    pred_list[[6]][i]=median(temp)
  }
  
  pred_list[[6]]=unlist(pred_list[[6]])
  
  eval_list=matrix(nrow = length(reg_models_names),ncol = 5)
  rownames(eval_list)=reg_models_names
  colnames(eval_list)=c("Precision","Recall","F1 score","AUC","Accuracy")
  
  for(i in 1:length(pred_list)){
    print(i)
    eval_list[i,]=unlist(Accurancy_2_Vectors_new(predicts  = pred_list[[i]],
                                                 test =   new2_testSparse[,ncol(new2_testSparse)]))
    
    
  }
  
  pred_list=matrix(unlist(pred_list),ncol=length(pred_list))
  colnames(pred_list)=reg_models_names
  
  
  return(list("eval_list"=eval_list,"pred_list"=pred_list))
  
}