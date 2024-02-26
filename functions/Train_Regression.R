"Train_Regression"<-function(features,split2,categories_assignement,ml_lib="caret_lib"){


  
 features=data.frame(features,categories_assignement)
  
 colnames(features)[ncol(features)]="Exploit_output"
  
 new2_trainSparse=features[split2,]
 new2_testSparse=features[split2==F,]
 
 features=NULL

 #library(UBL) ; set.seed(831) ; new2_trainSparse=SMOGNRegress(form = Exploit_output~.,dat = new2_trainSparse,k = 5)#"HEOM"

  
 if(ml_lib=="caret_lib"){
   library(caret)
   control <- trainControl(method="none")
   metric <- "Rsquared"
   
   reg_models_names=c("glm","rpart2","xgbLinear","gbm") #"glmnet", "glm" , "gamboost" , "nnet" , "gbm_h2o","C5.0" ,"mlp","treebag","rf"
   
   hyperparams_grid=list()
   
   hyperparams_grid[["glm"]]=NA
   #hyperparams_grid[["glmnet"]]=NA
   #hyperparams_grid[["glmboost"]]=NA
   #hyperparams_grid[["gamboost"]]=NA


   hyperparams_grid[["gbm"]]=NA
   #hyperparams_grid[["treebag"]]=NA
   hyperparams_grid[["xgbLinear"]]=NA
   #hyperparams_grid[["mlp"]]=NA
   #hyperparams_grid[["nnet"]]=NA
   #hyperparams_grid[["pcaNNet"]]=NA
   
   
   #hyperparams_grid[["Rborist"]]=NA
   #hyperparams_grid[["rf"]]=expand.grid(mtry=10)
   hyperparams_grid[["rpart2"]]=expand.grid(maxdepth=20)
   
   pred_list=list()
   training_time=list()
   
   
   
   for(i in 1:length(reg_models_names)){
     print(paste(i,reg_models_names[i]))
     set.seed(831)
     start_time <- proc.time()[3]
     
     if(is.na(hyperparams_grid[[reg_models_names[i]]][1])){
       model=train(Exploit_output~., 
                   data=new2_trainSparse, method=reg_models_names[i],
                   #tuneGrid=hyperparams_grid[[reg_models_names[i]]],
                   metric=metric, trControl=control
                   #,weights = init_weights
       )
     }else{
       model=train(Exploit_output~., 
                   data=new2_trainSparse, method=reg_models_names[i],
                   tuneGrid=hyperparams_grid[[reg_models_names[i]]],
                   metric=metric, trControl=control
                   #,weights = init_weights
       )
     }
     end_time <- proc.time()[3]
     training_time[[reg_models_names[i]]]=end_time-start_time
     
     
     pred_list[[reg_models_names[i]]]=predict(model,new2_testSparse)
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
     pred_list[[reg_models_names[i]]]=unlist(pred_list[[reg_models_names[i]]]$predicted)
     
     gc()
     
   }
   
   
   eval_list=matrix(nrow = length(reg_models_names),ncol = 3)
   rownames(eval_list)=reg_models_names
   colnames(eval_list)=c("RMSE","MAE","Rsquared")
   
   library(MLmetrics)
   
   for(i in 1:length(pred_list)){
     print(i)
     eval_list[i,1]=MLmetrics::RMSE(y_pred = pred_list[[reg_models_names[i]]],y_true = as.numeric(categories_assignement[split2==F]))
     eval_list[i,2]=MLmetrics::MAE(y_pred = pred_list[[reg_models_names[i]]],y_true = as.numeric(categories_assignement[split2==F]))
     eval_list[i,3]=MLmetrics::R2_Score(y_pred = pred_list[[reg_models_names[i]]],y_true = as.numeric(categories_assignement[split2==F]))
     
   }
   
   
 }else if (ml_lib=="h2o_lib"){
  h2o.init(nthreads = -1)
   
   tr_length=nrow(new2_trainSparse)
   te_length=nrow(new2_testSparse)
   
   new2_trainSparse=as.h2o(new2_trainSparse)
   new2_testSparse=as.h2o(new2_testSparse)
   
   if(nrow(new2_trainSparse)!=tr_length){new2_trainSparse=new2_trainSparse[-1,]}
   
   if(nrow(new2_testSparse)!=te_length){new2_testSparse=new2_testSparse[-1,]}
   
   
  
  x_pos=1:(ncol(new2_trainSparse)-1)
  y_pos=ncol(new2_trainSparse)
  
  
    
  
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
  
  k=1
  
  start_time <- proc.time()[3]
  
  
  model <- h2o.glm(y = y_pos, x = x_pos, training_frame =as.h2o(new2_trainSparse),seed = 831,family= "AUTO")
  
  end_time <- proc.time()[3]
  training_time[[k]]=end_time-start_time
  
  
  pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=as.h2o(new2_testSparse))$predict)
  if(length(pred_list[[k]])!=nrow(new2_testSparse)){
    pred_list[[k]]=pred_list[[k]][-1]
  }
  
  k=k+1
  
  start_time <- proc.time()[3]
  
  model <- h2o.gbm(y = y_pos, x = x_pos, training_frame =as.h2o(new2_trainSparse),seed = 831, ntrees = 10,max_depth = 3,min_rows = 2, learn_rate = 0.2,distribution= "AUTO")
  
  end_time <- proc.time()[3]
  training_time[[k]]=end_time-start_time
  
  
  pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=as.h2o(new2_testSparse))$predict)
  if(length(pred_list[[k]])!=nrow(new2_testSparse)){
    pred_list[[k]]=pred_list[[k]][-1]
  }
  
  k=k+1
  
  start_time <- proc.time()[3]
  
  model <- h2o.randomForest(y = y_pos, x = x_pos, training_frame =as.h2o(new2_trainSparse),seed = 831)
  
  end_time <- proc.time()[3]
  training_time[[k]]=end_time-start_time
  
  
  pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=as.h2o(new2_testSparse))$predict)
  if(length(pred_list[[k]])!=nrow(new2_testSparse)){
    pred_list[[k]]=pred_list[[k]][-1]
  }
  
 
  
  k=k+1
  
  start_time <- proc.time()[3]
  
  model <- h2o.deeplearning(x=x_pos,y = y_pos,reproducible = T,activation = "Tanh",seed = 831,training_frame = new2_trainSparse,average_activation=1,fast_mode = F,hidden = 128,epochs = 10,rate=0.005)#,loss="CrossEntropy"
  
  end_time <- proc.time()[3]
  training_time[[k]]=end_time-start_time
  
  
  pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
  if(length(pred_list[[k]])!=nrow(new2_testSparse)){
    pred_list[[k]]=pred_list[[k]][-1]
  }
  
  k=k+1
  pred_list[[k]]=list()
  
  start_time <- proc.time()[3]
  
  for(i in 1:nrow(new2_testSparse)){
    temp=c()
    for(j in 1:(length(reg_models_names)-1)){
      temp[j]=pred_list[[j]][i]
    }
    pred_list[[k]][i]=median(temp)
  }
  
  pred_list[[k]]=unlist(pred_list[[k]])
  
  end_time <- proc.time()[3]
  training_time[[k]]=end_time-start_time
  
  eval_list=matrix(nrow = length(reg_models_names),ncol = 3)
  rownames(eval_list)=reg_models_names
  colnames(eval_list)=c("RMSE","MAE","Rsquare")
  
  library(MLmetrics)
  
  for(i in 1:length(pred_list)){
    print(i)
    eval_list[i,1]=MLmetrics::RMSE(y_pred = pred_list[[i]],y_true = as.numeric(categories_assignement[split2==F]))
    eval_list[i,2]=MLmetrics::MAE(y_pred = pred_list[[i]],y_true = as.numeric(categories_assignement[split2==F]))
    eval_list[i,3]=MLmetrics::R2_Score(y_pred = pred_list[[i]],y_true = as.numeric(categories_assignement[split2==F]))
    
  }
  
  
  
 }
  
 pred_list=matrix(unlist(pred_list),ncol=length(pred_list))
 colnames(pred_list)=reg_models_names
 
 
 
 print(training_time)
 
 
 return(list("eval_list"=eval_list,"pred_list"=pred_list,"training_time"=training_time))
 
}