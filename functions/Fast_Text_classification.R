"Fast_Text_classification"<-function(all_set_text,categories_assignement,split2){
  
  set.seed(831)
  
  library(fastTextR)
  
  library(caret)
  
  ft_whole_set=paste("__label__",categories_assignement," ",all_set_text,sep="")
  
  ft_whole_set_train=subset(ft_whole_set,split2==TRUE)
  ft_whole_set_test=subset(ft_whole_set,split2==FALSE)
  
  exploits_output=categories_assignement
  
  exploits_output=subset(categories_assignement, split2==TRUE)
  
  train<-ft_normalize(ft_whole_set_train)
  writeLines(train, con = "fastText_train.train")
  
  set.seed(831)
  
  cntrl <- cntrl <- ft_control(word_vec_size = 20, learning_rate = 0.05, max_len_ngram = 5L,
                               min_count = 1L, nbuckets = 10000000L, epoch = 200, nthreads = 2L)#epoch = 200L,
  
  model <- ft_train(file = "fastText_train.train", method = "supervised", control = cntrl)
  
  
  test_desc=subset(all_set_text,split2==FALSE)
  test_exploit=subset(categories_assignement,split2==FALSE)
  
  test=ft_normalize(test_desc)
  
  test_pred <- ft_predict(model, newdata=test, k = 1L)
  
  test_pred_final=test_pred$label
  
  test_pred_final=gsub("__label__","",test_pred_final)
  
  test_pred_final=as.character(test_pred_final)
  
  library("MLmetrics")
  
  
  acc_list=Accurancy_2_Vectors_new(test_pred_final,as.character(test_exploit))
  return(list("acc_list"=acc_list,"predictions"=test_pred_final))
  
}