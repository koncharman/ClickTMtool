"Accurancy_2_Vectors_new"<-function(predicts,test){
  library(MLmetrics)
  
  predicts=as.vector(predicts)
  
  test=as.vector(test)
  
  table_test_values=table(test)
 
  
  acc_list=list()
 
  if(length(table_test_values)==2){
    acc_list[["precision"]]= Precision(y_true = test, y_pred = predicts,positive = 1)
    
    acc_list[["recall"]]=  Recall(y_true = test, y_pred = predicts,positive = 1)
    
    
    
    acc_list[["f1"]]=F1_Score( y_true = test, y_pred = predicts,positive = 1)
    acc_list[["auc"]]=AUC(test, predicts)
  }else{
    prec_list=c()
    rec_list=c()
    f1_list=c()
    auc_list=c()
    for(i in 1:length(table_test_values)){
      temp_test=test
      pos_pos=which(temp_test==(i-1))
      pos_neg=which(temp_test!=(i-1))
      temp_test[pos_pos]=1
      temp_test[pos_neg]=0
      
      temp_predicts=predicts
      pos_pos=which(temp_predicts==(i-1))
      pos_neg=which(temp_predicts!=(i-1))
      temp_predicts[pos_pos]=1
      temp_predicts[pos_neg]=0
      
      prec_list[i]=Precision(y_true = temp_test,y_pred = temp_predicts,positive = 1)
      rec_list[i]=Recall(y_true = temp_test,y_pred = temp_predicts,positive = 1)
      f1_list[i]=F1_Score(y_true = temp_test,y_pred = temp_predicts,positive = 1)
      auc_list[i]=AUC(y_true = temp_test,y_pred = temp_predicts)
      
    }
    acc_list[["precision"]]= mean(prec_list)
    
    acc_list[["recall"]]=  mean(rec_list)
    
    
    
    acc_list[["f1"]]=mean(f1_list)
    acc_list[["auc"]]=mean(auc_list)
  }
  
  acc_list[["accuracy"]]=Accuracy( y_true = test, y_pred = predicts)
  return(acc_list)
}