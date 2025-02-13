"train_test_class_new" <-function(features,split2,categories_assignement,ml_lib="caret_lib",ml_sample_choice="down_sample_choice",ret_fi=F){
  
  
  set.seed(831)
  
  new2_trainSparse=as.data.frame(features[split2==T,])
  new2_testSparse=as.data.frame(features[split2==FALSE,])
  
  new2_trainSparse$Exploit_output=(categories_assignement[split2==T])
  new2_testSparse$Exploit_output=(categories_assignement[split2==F])
  
  
  colnames(new2_trainSparse)[ncol(new2_trainSparse)]="Exploit_output"
  colnames(new2_testSparse)=colnames(new2_trainSparse)
  #
  new2_trainSparse$Exploit_output=as.factor(new2_trainSparse$Exploit_output)
  new2_testSparse$Exploit_output=as.factor(new2_testSparse$Exploit_output)
  
  
  features=NULL
  
  
  table_output=table(categories_assignement[split2])
  print(table_output)
  
  
  if(ml_lib=="caret_lib"){
    
    
    
    library(caret)
    control <- trainControl(method="none")
    metric <- "Accuracy"
    
    set.seed(831)
    if(ml_sample_choice =="down_sample_choice"){
      new2_trainSparse=downSample(x = new2_trainSparse[,-ncol(new2_trainSparse)],y = new2_trainSparse[,ncol(new2_trainSparse)],yname = "Exploit_output")
      
    }else if(ml_sample_choice =="up_sample_choice"){
      new2_trainSparse=upSample(x = new2_trainSparse[,-ncol(new2_trainSparse)],y = new2_trainSparse[,ncol(new2_trainSparse)],yname = "Exploit_output")
      
    }
    
    print(table(new2_trainSparse$Exploit_output))
    
    
    reg_models_names=c("rpart2","xgbLinear","gbm") #"glmnet", "nnet", "gbm_h2o","mlp" ,"treebag","rf","C5.0"
    
    hyperparams_grid=list()
    

    
    hyperparams_grid[["gbm"]]=NA
    hyperparams_grid[["xgbLinear"]]=NA
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
                           metric=metric, trControl=control
        )
      }else{
        model=caret::train(Exploit_output~., 
                           data=new2_trainSparse, method=reg_models_names[i],
                           tuneGrid=hyperparams_grid[[reg_models_names[i]]],
                           metric=metric, trControl=control
        )
      }
      end_time <- proc.time()[3]
      training_time[[reg_models_names[i]]]=end_time-start_time
      
      pred_list[[reg_models_names[i]]]=predict(model,new2_testSparse)

      gc()
      
    }
    
    #Random Forest
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
      pred_list[[reg_models_names[i]]]=unlist(apply(X = pred_list[[reg_models_names[i]]]$predicted
                                                    ,FUN = function(x){
                                                      wm=which(x==max(x))[1]
                                                      return(colnames(pred_list[[reg_models_names[i]]]$predicted)[wm])
                                                    }(),1))
      
      gc()
      
      
      eval_list=list()#5
      
      if(ret_fi==T){
        eval_list[["vimp_mat"]]=vimp(model, importance = "permute")$importance      
        gc()
      }


    
    if(length(table_output)==2){
      
      eval_list_temp=matrix(nrow = length(reg_models_names),ncol = 4)
      rownames(eval_list_temp)=reg_models_names
      colnames(eval_list_temp)=c("Precision","Recall","F1 score","Accuracy")#,"AUC"
      for(i in 1:length(pred_list)){
        eval_list_temp[i,]=unlist(Accurancy_2_Vectors_new(
          predicts  = pred_list[[reg_models_names[i]]],
          test =   new2_testSparse[,ncol(new2_testSparse)] 
          ,mean_eval=T)
        )
      }
      eval_list[["acc_mat"]]=eval_list_temp

    }else{
      
      
      eval_list[["acc_mat"]]=list('accuracy'=c())
      
      for (i in 1:length(table_output)){
        
        eval_list_temp=matrix(nrow = length(pred_list),ncol = 4)
        rownames(eval_list_temp)=reg_models_names
        colnames(eval_list_temp)=c("Precision","Recall","F1","Accuracy")#,"AUC"
        
        eval_list[["acc_mat"]][[names(table_output)[i]]]=eval_list_temp
        
      }
      
      for(i in 1:length(pred_list)){
        

        eval_list_temp=Accurancy_2_Vectors_new(
          predicts  = pred_list[[reg_models_names[i]]],
          test =   new2_testSparse[,ncol(new2_testSparse)]
          ,mean_eval=F)
        
        for(j in 1:length(table_output)){
          
          eval_list[["acc_mat"]][[names(table_output)[j]]][i,1]=eval_list_temp$precision[[names(table_output)[j]]]
          eval_list[["acc_mat"]][[names(table_output)[j]]][i,2]=eval_list_temp$recall[[names(table_output)[j]]]
          eval_list[["acc_mat"]][[names(table_output)[j]]][i,3]=eval_list_temp$f1[[names(table_output)[j]]]
          eval_list[["acc_mat"]][[names(table_output)[j]]][i,4]=eval_list_temp$accuracy_list[[names(table_output)[j]]]
          
        }
        eval_list[["acc_mat"]][['accuracy']][[names(pred_list)[i]]]=eval_list_temp$accuracy

      }
      
      

    }
      
     
   
      
       
    
  }
  
  return(eval_list)
}