"Accurancy_2_Vectors_new"<-function(predicts,test,mean_eval=T){
  
  library(MLmetrics)
  
  predicts=as.vector(predicts)
  
  test=as.vector(test)
  
  table_test_values=table(test)
 
  
  acc_list=list()
 
  
  
  
  if(length(table_test_values)==2){
    acc_list[["precision"]]= Precision(y_true = test, y_pred = predicts,positive = 1)
    
    acc_list[["recall"]]=  Recall(y_true = test, y_pred = predicts,positive = 1)
    
    
    
    acc_list[["f1"]]=F1_Score( y_true = test, y_pred = predicts,positive = 1)
    #acc_list[["auc"]]=AUC(test, predicts)
  }else{
    
    prec_list=list()
    rec_list=list()
    f1_list=list()
    auc_list=list()
    acc_list_temp=list()
    
    for(i in 1:length(table_test_values)){
      
      temp_test=test
      #
      #pos_pos=which(temp_test==(i-1))
      #pos_neg=which(temp_test!=(i-1))
      
      #
      pos_pos=which(temp_test==names(table_test_values)[i])
      pos_neg=which(temp_test!=names(table_test_values)[i])
      
      temp_test[pos_pos]=1
      temp_test[pos_neg]=0
      
      temp_predicts=predicts
      pos_pos=which(temp_predicts==names(table_test_values)[i])
      pos_neg=which(temp_predicts!=names(table_test_values)[i])
      temp_predicts[pos_pos]=1
      temp_predicts[pos_neg]=0
      
      prec_list[[names(table_test_values)[i]]]=Precision(y_true = temp_test,y_pred = temp_predicts,positive = 1)
      rec_list[[names(table_test_values)[i]]]=Recall(y_true = temp_test,y_pred = temp_predicts,positive = 1)
      f1_list[[names(table_test_values)[i]]]=F1_Score(y_true = temp_test,y_pred = temp_predicts,positive = 1)
      acc_list_temp[[names(table_test_values)[i]]]=Accuracy(y_true = temp_test,y_pred = temp_predicts)
      #auc_list[i]=AUC(y_true = temp_test,y_pred = temp_predicts)
      

    }
    
    if(mean_eval==T){
      acc_list[["precision"]]= mean(unlist(prec_list))
      acc_list[["recall"]]=  mean(unlist(rec_list))
      acc_list[["f1"]]=mean(unlist(f1_list))
    }else{
      
      acc_list[["precision"]]=prec_list
      acc_list[["recall"]]=rec_list
      acc_list[["f1"]]=f1_list
      acc_list[["accuracy_list"]]=acc_list_temp
      
    }

    #acc_list[["auc"]]=mean(auc_list)
  }
  
  acc_list[["accuracy"]]=Accuracy( y_true = test, y_pred = predicts)
  return(acc_list)
}