"train_test_functions"<-function(features,split2,class_labels){
  
  #class_labels=as.vector(as.factor(class_labels))
  
  
  new2_trainSparse=as.data.frame(features[split2==T,])
  new2_testSparse=as.data.frame(features[split2==FALSE,])
  
  new2_trainSparse$Exploit_output=(class_labels[split2==T])
  new2_testSparse$Exploit_output=(class_labels[split2==F])
 
  #Oversample
  library(smotefamily)
  Adasyn=ADAS(X = new2_trainSparse[,-ncol(new2_trainSparse)],target = new2_trainSparse[,ncol(new2_trainSparse)],K=5)
  
  new2_trainSparse=Adasyn$data
  
  colnames(new2_trainSparse)[ncol(new2_trainSparse)]="Exploit_output"
  colnames(new2_testSparse)=colnames(new2_trainSparse)
  #
  
  library(MLmetrics)
  library(caret)
  control <- trainControl(method="cv", number=10)
  metric <- "Accuracy"
  
  reg_models_names=c("rf","C5.0")
  model_list=list()
  
  #########Hyper parameters tuning
  hyperparams_grid=list()
  hyperparams_grid[["rf"]]=expand.grid(mtry=10)
  
  hyperparams_grid[["C5.0"]]=expand.grid(winnow=F,trials=50,model="tree")
  
  for(i in 1:length(reg_models_names)){
    print(paste(i,reg_models_names[i]))
    #,preProcess=prep
    set.seed(831)
    model_list[[reg_models_names[i]]]=train(Exploit_output~., 
                                            data=new2_trainSparse, method=reg_models_names[i],
                                            #tuneGrid=hyperparams_grid[[i]],
                                            #tuneGrid=hyperparams_grid[[reg_models_names[i]]],
                                            #tunelength=5,
                                            metric=metric, trControl=control)
  }
  
  pred_list=list()
  
  for(i in 1:length(reg_models_names)){
    print(paste(i,reg_models_names[i]))
    pred_list[[reg_models_names[i]]]=predict(model_list[[reg_models_names[i]]],new2_testSparse)
  }
  
  eval_list=matrix(nrow = length(reg_models_names),ncol = 5)
  rownames(eval_list)=reg_models_names
  colnames(eval_list)=c("Precision","Recall","F1 score","AUC","Accuracy")
  
  for(i in 1:length(pred_list)){
    print(i)
    eval_list[i,]=unlist(Accurancy_2_Vectors_new(predicts  = pred_list[[reg_models_names[i]]],
                                                             test =   new2_testSparse[,ncol(new2_testSparse)]))
    
    
  }
  
  
  
  return(eval_list)
  
}