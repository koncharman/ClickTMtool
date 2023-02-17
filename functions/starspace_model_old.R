"starspace_model"<-function(all_set_text_final,min_doc_r=0.001,df,characteristics_pos){
  #labels as list
  print(1)
  set.seed(831)
  
  chars_names=colnames(df)[characteristics_pos]
  
  chars_df=list()
  
  for(i in 1:length(characteristics_pos)){
    #print(i)
    chars_df[[chars_names[i]]]=lapply(df[,characteristics_pos[i]],function(x){
      for(j in 1:length(x)){
        x[[j]]=paste(chars_names[i],"_",x[[j]],sep="")
      }
      return(x)
    })
  }
  
  tags_paste=list()
  for(i in 1:nrow(df)){
    #print(i)
    tags_paste[[i]]=paste(unlist(chars_df[[1]][[i]]),collapse = " __label__",sep="")
    if(length(chars_df)>1){
      for(j in 2:length(chars_df)){
        temp_tags=paste(unlist(chars_df[[j]][[i]]),collapse = " __label__")
        tags_paste[[i]]=paste(tags_paste[[i]],temp_tags,sep = " __label__")
      }
      #tags_paste[[i]]=strsplit(x = tags_paste[[i]],split = " ")
    }
    
  }
  
  
  library("ruimtehol")
  
  
  
  min_doc=length(all_set_text_final)*min_doc_r #0.002
  
  model <- embed_tagspace(x = all_set_text_final,
                          y = tags_paste,
                          #early_stopping = 0.5,
                          dim = 20,
                          minCount = 1,#minCount = min_doc
                          minCountLabel = 1, ngrams=5 #ngrams = 2
                          
                          , lr=0.05 #lr=0.3
                          ,loss='softmax' # loss='hinge' , 'softmax'
                          , ws=5
                          ,epoch=200
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