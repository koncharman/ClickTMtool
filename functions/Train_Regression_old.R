"Train_Regression"<-function(features,split2,class_labels){
  
  new2_trainSparse=cbind(features[split2==T,],class_labels[split2==T])
  new2_testSparse=cbind(features[split2==FALSE,],class_labels[split2==FALSE])
  
  new2_trainSparse=as.data.frame(new2_trainSparse)
  new2_testSparse=as.data.frame(new2_testSparse)
  
  colnames(new2_trainSparse)[ncol(new2_trainSparse)]="Exploit_output"
  colnames(new2_testSparse)=colnames(new2_trainSparse)
  
  library(caret)
  control <- trainControl(method="cv", number=10)
  metric <- "Rsquared"
  
  
  
  reg_models_names=c("rf","lm")
  
  model_list=list()
  
  
  for(i in 1:length(reg_models_names)){
    #,preProcess=prep
    print(reg_models_names[i])
    model_list[[reg_models_names[i]]]=train(Exploit_output~., data=new2_trainSparse, method=reg_models_names[i], metric=metric, 
                                            #tuneGrid=hyperparams_grid[[reg_models_names[i]]],
                                            trControl=control)
  }
  
  pred_list=list()
  
  for(i in 1:length(reg_models_names)){
    pred_list[[reg_models_names[i]]]=predict(model_list[[reg_models_names[i]]],new2_testSparse)
  }
  
  eval_list=matrix(nrow = length(reg_models_names),ncol = 3)
  rownames(eval_list)=reg_models_names
  colnames(eval_list)=c("RMSE","Rsquared","MAE")
  
  
  for(i in 1:length(pred_list)){
    eval_list[i,]=postResample(pred = pred_list[[reg_models_names[i]]],
                                                  obs = new2_testSparse[,ncol(new2_testSparse)])
  }
  
  #rsq <- function (x, y) cor(x, y) ^ 2
  
  #rsq(pred_list[[1]],new2_testSparse$Exploit_output)
  
  return(eval_list)
}