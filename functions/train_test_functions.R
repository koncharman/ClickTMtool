"train_test_functions"<-function(features,split2,categories_assignement,imbalance_cond=T,weight_or_balance="weight_choice",ml_lib="caret_lib",ml_sample_choice="down_sample_choice"){
  
  set.seed(831)
  
  new2_trainSparse=as.data.frame(features[split2==T,])
  new2_testSparse=as.data.frame(features[split2==FALSE,])
  
  new2_trainSparse$Exploit_output=(categories_assignement[split2==T])
  new2_testSparse$Exploit_output=(categories_assignement[split2==F])
  
  
  
  features=NULL
  
  
  init_weights=rep(1,length(split2[split2==T]))
  balance_cond=F
  
  table_output=table(categories_assignement[split2])
  
  
  
  if(imbalance_cond==T){
  if(weight_or_balance=="weight_choice"){
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
  print("Oversample or Downsample:",balance_cond)
  print("Table weights")
  print(table(init_weights))
  
  colnames(new2_trainSparse)[ncol(new2_trainSparse)]="Exploit_output"
  colnames(new2_testSparse)=colnames(new2_trainSparse)
  #
  new2_trainSparse$Exploit_output=as.factor(new2_trainSparse$Exploit_output)
  new2_testSparse$Exploit_output=as.factor(new2_testSparse$Exploit_output)
  

  print(table(new2_trainSparse$Exploit_output))
  ##
  
  
  if(ml_lib=="caret_lib"){
    
    library(caret)
    control <- trainControl(method="none")
    metric <- "Accuracy"
    
    #downSample
    #upSample
    set.seed(831)
    if(ml_sample_choice =="down_sample_choice"){
      new2_trainSparse=downSample(x = new2_trainSparse[,-ncol(new2_trainSparse)],y = new2_trainSparse[,ncol(new2_trainSparse)],yname = "Exploit_output")
      
    }else if(ml_sample_choice =="up_sample_choice"){
      new2_trainSparse=upSample(x = new2_trainSparse[,-ncol(new2_trainSparse)],y = new2_trainSparse[,ncol(new2_trainSparse)],yname = "Exploit_output")
      
    }
    
    
    reg_models_names=c("rpart2","xgbLinear","gbm") #"glmnet", "nnet", "gbm_h2o","mlp" ,"treebag","rf","C5.0"
   
    hyperparams_grid=list()
    
    if(length(table_output)==2){
      
      reg_models_names=append("glm",reg_models_names)
      hyperparams_grid[["glm"]]=NA
      
    }else{
      #or multinom
      reg_models_names=append("glmnet",reg_models_names)
      hyperparams_grid[["glmnet"]]=NA
      
    }
    #hyperparams_grid[["glmnet"]]=NA
    #hyperparams_grid[["glmboost"]]=NA
    #hyperparams_grid[["gamboost"]]=NA
    #hyperparams_grid[["LogitBoost"]]=NA
    #hyperparams_grid[["multinom"]]=NA
    

    

    #hyperparams_grid[["spls"]]=NA
    
    hyperparams_grid[["gbm"]]=NA
    #hyperparams_grid[["treebag"]]=NA
    hyperparams_grid[["xgbLinear"]]=NA
    #hyperparams_grid[["mlp"]]=NA
    #hyperparams_grid[["nnet"]]=NA
    
    
    #hyperparams_grid[["Rborist"]]=NA
    #hyperparams_grid[["rf"]]=expand.grid(mtry=10)#3
    #hyperparams_grid[["C5.0"]]=expand.grid(winnow=F,trials=50,model="tree")
    hyperparams_grid[["rpart2"]]=expand.grid(maxdepth=20)
    
    pred_list=list()
    training_time=list()
    
    for(i in 1:length(reg_models_names)){
      print(paste(i,reg_models_names[i]))
      set.seed(831)
      start_time <- proc.time()[3]
      if(is.na(hyperparams_grid[[reg_models_names[i]]][1])){
        model=caret::train(Exploit_output~., 
                    data=new2_trainSparse, method=reg_models_names[i],
                    #tuneGrid=hyperparams_grid[[reg_models_names[i]]],
                    metric=metric, trControl=control
                    #,weights = init_weights
        )
      }else{
        model=caret::train(Exploit_output~., 
                    data=new2_trainSparse, method=reg_models_names[i],
                    tuneGrid=hyperparams_grid[[reg_models_names[i]]],
                    metric=metric, trControl=control
                    #,weights = init_weights
        )
      }
      end_time <- proc.time()[3]
      training_time[[reg_models_names[i]]]=end_time-start_time
      
      pred_list[[reg_models_names[i]]]=predict(model,new2_testSparse)
      #pred_list[[reg_models_names[i]]]=predict(model,new2_testSparse,type = "prob")
      
      gc()

    }
    
    #Random Forest
    {
      i=i+1
      
      library(randomForestSRC)
      reg_models_names=append(reg_models_names,"randomForestSRC")
      
      print(paste(i,reg_models_names[i]))
      
      set.seed(831)
      start_time <- proc.time()[3]
      model=rfsrc.fast(Exploit_output~., data=new2_trainSparse,forest = T)
      end_time <- proc.time()[3]
      training_time[[reg_models_names[i]]]=end_time-start_time
      
      pred_list[[reg_models_names[i]]]=predict(object = model,newdata = new2_testSparse)
      pred_list[[reg_models_names[i]]]=unlist(apply(X = pred_list[[reg_models_names[i]]]$predicted,FUN = function(x)(which(x==max(x))[1]-1),1))
      
      gc()
      
    }
    
    
    eval_list=matrix(nrow = length(reg_models_names),ncol = 4)#5
    rownames(eval_list)=reg_models_names
    colnames(eval_list)=c("Precision","Recall","F1 score","Accuracy")#,"AUC"
    
    for(i in 1:length(pred_list)){
      print(i)
      eval_list[i,]=unlist(Accurancy_2_Vectors_new(predicts  = pred_list[[reg_models_names[i]]],
                                                   test =   new2_testSparse[,ncol(new2_testSparse)]))
      
      
    }
    
    
  }else if (ml_lib=="h2o_lib"){
    
    h2o.init(nthreads = -1)
    
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
                       "Random Forest",
                       #"Naive bayes",
                       #"eXtreme Gradient Boosting",
                       "Deep Learning",
                       
                       #"Stacked Ensemble",
                       "Ensemble (Median)")
    
    
    pred_list=list()
    training_time=list()
    
    
    if(balance_cond==F){
      k=1
      start_time <- proc.time()[3]
      
      model <- h2o.glm(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831,family= "AUTO",weights_column = "weight",balance_classes = balance_cond)
      
      end_time <- proc.time()[3]
      training_time[[k]]=end_time-start_time
      
      
      
      pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
      if(length(pred_list[[k]])!=nrow(new2_testSparse)){
        pred_list[[k]]=pred_list[[k]][-1]
      }
      
      k=k+1
      
      start_time <- proc.time()[3]
      
      model <- h2o.gbm(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831, ntrees = 10,max_depth = 3,min_rows = 2, learn_rate = 0.2,distribution= "AUTO",weights_column = "weight",balance_classes = balance_cond)
      
      end_time <- proc.time()[3]
      training_time[[k]]=end_time-start_time
      
      pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
      if(length(pred_list[[k]])!=nrow(new2_testSparse)){
        pred_list[[k]]=pred_list[[k]][-1]
      }
      
      k=k+1
      
      start_time <- proc.time()[3]
      
      model <- h2o.randomForest(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831,weights_column = "weight",balance_classes = balance_cond)
      
      end_time <- proc.time()[3]
      training_time[[k]]=end_time-start_time
      
      pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
      if(length(pred_list[[k]])!=nrow(new2_testSparse)){
        pred_list[[k]]=pred_list[[k]][-1]
      }
      
      #k=k+1
      #model <- h2o.naiveBayes(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831)
      #pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
      #if(length(pred_list[[k]])!=nrow(new2_testSparse)){
      #  pred_list[[k]]=pred_list[[k]][-1]
      #}
      
      k=k+1
      
      start_time <- proc.time()[3]
      
      model <- h2o.deeplearning(x=x_pos,y = y_pos,reproducible = T,activation = "Tanh",
                                seed = 831,training_frame = new2_trainSparse,average_activation=1,fast_mode = F,
                                hidden = 128,epochs = 10,rate=0.005
                                ,weights_column = "weight",balance_classes = balance_cond
                                #,loss="CrossEntropy"
      )
      
      end_time <- proc.time()[3]
      training_time[[k]]=end_time-start_time
      
      
     
      
      pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
      if(length(pred_list[[k]])!=nrow(new2_testSparse)){
        pred_list[[k]]=pred_list[[k]][-1]
      }
      
    
      
    }else{
      k=1
      
      start_time <- proc.time()[3]
      
      model <- h2o.glm(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831,family= "AUTO",balance_classes = balance_cond)
      
      end_time <- proc.time()[3]
      training_time[[k]]=end_time-start_time
      
      pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
      if(length(pred_list[[k]])!=nrow(new2_testSparse)){
        pred_list[[k]]=pred_list[[k]][-1]
      }
      
      k=k+1
      
      start_time <- proc.time()[3]
      
      
      model <- h2o.gbm(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831, ntrees = 10,max_depth = 3,min_rows = 2, learn_rate = 0.2,distribution= "AUTO",balance_classes = balance_cond)
      
      end_time <- proc.time()[3]
      training_time[[k]]=end_time-start_time
      
      pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
      if(length(pred_list[[k]])!=nrow(new2_testSparse)){
        pred_list[[k]]=pred_list[[k]][-1]
      }
      
      k=k+1
      
      start_time <- proc.time()[3]
      
      model <- h2o.randomForest(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831,weights_column = "weight",balance_classes = balance_cond)
      
      
     
      
      
      end_time <- proc.time()[3]
      training_time[[k]]=end_time-start_time
      
      pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
      if(length(pred_list[[k]])!=nrow(new2_testSparse)){
        pred_list[[k]]=pred_list[[k]][-1]
      }
      
      #k=k+1
      #model <- h2o.naiveBayes(y = y_pos, x = x_pos, training_frame =new2_trainSparse,seed = 831,balance_classes =F)
      #pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
      #if(length(pred_list[[k]])!=nrow(new2_testSparse)){
      #  pred_list[[k]]=pred_list[[k]][-1]
      #}
      
      k=k+1
      
      start_time <- proc.time()[3]
      
      
      model <- h2o.deeplearning(x=x_pos,y = y_pos,reproducible = T,activation = "Tanh",
                                seed = 831,training_frame = new2_trainSparse,average_activation=1,fast_mode = F,
                                hidden = 128,epochs = 10,rate=0.005
                                ,balance_classes = balance_cond
                                #,loss="CrossEntropy"
      )
      
      end_time <- proc.time()[3]
      training_time[[k]]=end_time-start_time
      
      
      
      pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
      if(length(pred_list[[k]])!=nrow(new2_testSparse)){
        pred_list[[k]]=pred_list[[k]][-1]
      }
      
      
    }
    
    Mode <- function(x) {
      ux <- unique(x)
      ux[which.max(tabulate(match(x, ux)))]
    }
    
    
    k=k+1
    pred_list[[k]]=list()
    
    start_time <- proc.time()[3]
    
    
    for(i in 1:nrow(new2_testSparse)){
      temp=c()
      for(j in 1:(length(reg_models_names)-1)){
        temp[j]=pred_list[[j]][i]
      }
      pred_list[[k]][i]=Mode(temp)
    }
    
    pred_list[[k]]=unlist(pred_list[[k]])
    
    end_time <- proc.time()[3]
    training_time[[k]]=end_time-start_time
    
    eval_list=matrix(nrow = length(reg_models_names),ncol = 4)#5
    rownames(eval_list)=reg_models_names
    colnames(eval_list)=c("Precision","Recall","F1 score","Accuracy")#,"AUC"
    
    for(i in 1:length(pred_list)){
      print(i)
      eval_list[i,]=unlist(Accurancy_2_Vectors_new(predicts  = pred_list[[i]],
                                                   test =   new2_testSparse[,ncol(new2_testSparse)]))
      
      
    }
    
   
    
    
    
  }
  
  pred_list=matrix(unlist(pred_list),ncol=length(pred_list))
  colnames(pred_list)=reg_models_names
  
  print(training_time)
  
  return(list("eval_list"=eval_list,"pred_list"=pred_list,"training_time"=training_time))
 
  
}