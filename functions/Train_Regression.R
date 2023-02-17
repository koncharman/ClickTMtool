"Train_Regression"<-function(features,split2,categories_assignement){


  
 features=data.frame(features,categories_assignement)
  
 colnames(features)[ncol(features)]="Exploit_output"
  
 new2_trainSparse=features[split2,]
 new2_testSparse=features[split2==F,]
 
 features=NULL
 
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
                     "RANDOM FOREST",
                     #"Naive bayes",
                     #"eXtreme Gradient Boosting",
                     "Deep Learning",
                     
                     #"Stacked Ensemble",
                     "Ensemble (Median)")
  
  
  pred_list=list()
  
  k=1
  model <- h2o.glm(y = y_pos, x = x_pos, training_frame =as.h2o(new2_trainSparse),seed = 831,family= "AUTO")
  pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=as.h2o(new2_testSparse))$predict)
  if(length(pred_list[[k]])!=nrow(new2_testSparse)){
    pred_list[[k]]=pred_list[[k]][-1]
  }
  
  k=k+1
  model <- h2o.gbm(y = y_pos, x = x_pos, training_frame =as.h2o(new2_trainSparse),seed = 831, ntrees = 10,max_depth = 3,min_rows = 2, learn_rate = 0.2,distribution= "AUTO")
  pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=as.h2o(new2_testSparse))$predict)
  if(length(pred_list[[k]])!=nrow(new2_testSparse)){
    pred_list[[k]]=pred_list[[k]][-1]
  }
  
  k=k+1
  model <- h2o.randomForest(y = y_pos, x = x_pos, training_frame =as.h2o(new2_trainSparse),seed = 831)
  pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=as.h2o(new2_testSparse))$predict)
  if(length(pred_list[[k]])!=nrow(new2_testSparse)){
    pred_list[[k]]=pred_list[[k]][-1]
  }
  
 
  
  k=k+1
  model <- h2o.deeplearning(x=x_pos,y = y_pos,reproducible = T,activation = "Tanh",seed = 831,training_frame = new2_trainSparse,average_activation=1,fast_mode = F,hidden = 128,epochs = 10,rate=0.005)#,loss="CrossEntropy"
  pred_list[[k]]=as.vector(h2o.predict(object = model,newdata=new2_testSparse)$predict)
  if(length(pred_list[[k]])!=nrow(new2_testSparse)){
    pred_list[[k]]=pred_list[[k]][-1]
  }
  
  k=k+1
  pred_list[[k]]=list()
  
  for(i in 1:nrow(new2_testSparse)){
    temp=c()
    for(j in 1:(length(reg_models_names)-1)){
      temp[j]=pred_list[[j]][i]
    }
    pred_list[[k]][i]=median(temp)
  }
  
  pred_list[[k]]=unlist(pred_list[[k]])
  
  eval_list=matrix(nrow = length(reg_models_names),ncol = 3)
  rownames(eval_list)=reg_models_names
  colnames(eval_list)=c("RMSE","MAE","Rsquare")
  
  library(MLmetrics)
  
  for(i in 1:length(pred_list)){
    print(i)
    eval_list[i,1]=RMSE(y_pred = pred_list[[i]],y_true = as.numeric(categories_assignement[split2==F]))
    eval_list[i,2]=MAE(y_pred = pred_list[[i]],y_true = as.numeric(categories_assignement[split2==F]))
    eval_list[i,3]=R2_Score(y_pred = pred_list[[i]],y_true = as.numeric(categories_assignement[split2==F]))
    
  }
  
  pred_list=matrix(unlist(pred_list),ncol=length(pred_list))
  colnames(pred_list)=reg_models_names
  
  return(list("eval_list"=eval_list,"pred_list"=pred_list))
}