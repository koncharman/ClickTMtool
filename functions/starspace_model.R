"starspace_model"<-function(all_set_text_final,min_doc_r=0.0001,categories_assignement){
  #labels as list
 
  
  #tags_paste=(sapply(X = categories_assignement,FUN = function(x)paste0("__label__",x)))
  
  
  library("ruimtehol")
  
  
  
  min_doc=length(all_set_text_final)*min_doc_r #0.002
  
  model <- embed_tagspace(x = all_set_text_final,
                          y = categories_assignement,
                          #early_stopping = 0.5,
                          dim = 20,
                          #minCount = min_doc,
                          minCount = 1,
                          
                          minCountLabel = 1 
                          ,ngrams=2 #ngrams = 2 , 5
                          ,adagrad=T
                          , lr=0.05 #lr=0.3
                          ,loss='hinge' # loss='hinge' , 'softmax'
                          ,margin=0.05
                          ,negSearchLimit=50
                          ,similarity="cosine"
                          , ws=5
                          ,epoch=10
                          ,bucket=10000000L
  )
  
  
  dictionary_ss=starspace_dictionary(model)
  
  knn_model=predict(object = model,newdata = dictionary_ss$labels,type='knn',k=30)
  
  label_similarity_matrix=matrix(nrow=30*length(knn_model),ncol=3)
  colnames(label_similarity_matrix)=c("class_label","keyword or class label","cosine similarity")
  
  for(i in 1:length(knn_model)){
    pos_start=30*(i-1)+1
    pos_end=30*i
    label_similarity_matrix[pos_start:pos_end,1]=dictionary_ss$labels[i]
    label_similarity_matrix[pos_start:pos_end,2]=knn_model[[i]]$label
    label_similarity_matrix[pos_start:pos_end,3]=knn_model[[i]]$similarity
    
  }
  
  
  #see starspace_main
  return(list("model"=model,"label_similarities"=label_similarity_matrix))
}