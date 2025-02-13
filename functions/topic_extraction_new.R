"topic_extraction_new"<-function(text,word_vectors,dtm,tcm,algorithm,min_topics=2,max_topics=20,no_top_terms=10,best_cond="all_rank",return_model=F){
  
  library(textmineR)
  library(DirichletReg)
  library(Matrix)
  library(RcppML)
  library(RcppML)
  library(fclust)
  
  
  if(return_model==F){
    eval_list=data.frame("No_topics"=c(min_topics:max_topics),"Topic_Coherence_Top_Terms"=0,"Topic_Divergence_Top_Terms"=0)#,"Topic_Divergence_ALL"=0
    
  }
  
    
    k=0
    
    for (i in min_topics:max_topics){
      
      print(paste("Topic",i))
      set.seed(132)
      
      k=k+1
      #eval_list[k,1]=i

      if(algorithm=="lda"){
        

        
        model=FitLdaModel(dtm = Matrix(as.matrix(dtm),sparse = T),k=i,iterations = 10,alpha = 1,beta = 1)
        
        model=list(phi=model$phi,theta=model$theta)

      }else if (algorithm == "nmf"){
        
        model=nmf(A = dtm,k=i)
        model=list(phi=model$h,theta=model$w*model$d)
        colnames(model$phi)=colnames(dtm)
        model$theta=model$theta/rowSums(model$theta)
        
      }else if (algorithm=="fkm"){
        model_temp=FKM(X = word_vectors,k = i)
        
        model=list(theta=as.matrix(dtm)%*%model_temp$U,phi=t(model_temp$U*diag(tcm)))
        model$theta=model$theta/rowSums(dtm)
        model$phi=model$phi/rowSums(model$phi)
        
      }else if (algorithm=="gmm"){
        
        library(mclust)
        #mclust.options("emModelNames")
        model_temp=Mclust(word_vectors,G=i,verbose = TRUE)#,modelNames = c("VVV")
        
        model=list(theta=as.matrix(dtm)%*%model_temp$z,phi=t(model_temp$z*diag(tcm)))
        model$theta=model$theta/rowSums(dtm)
        model$phi=model$phi/rowSums(model$phi)
        
        
      }
      
      rownames(model$phi)=paste0("Topic_",c(1:nrow(model$phi)))
      colnames(model$theta)=paste0("Topic_",c(1:ncol(model$theta)))
      
      
      if(return_model==F){
        ldaOut.terms=GetTopTerms(model$phi, no_top_terms, return_matrix = TRUE)
        
        fc=find_coh(ldaOut.terms = ldaOut.terms,tcm = tcm,rows_train = nrow(dtm))
        eval_list[k,2]=fc
        gc()
        
        eval_list[k,3]=length(unique(as.vector(ldaOut.terms)))/(no_top_terms*i)
        gc()
        
        #td_all=JSD(model$phi)
        #if(length(td_all)==1){
        #  eval_list[k,4]=(td_all)
        #}else{
         # td_all=td_all[row(td_all)>col(td_all)]
        #  eval_list[k,4]=mean(td_all)
        #}

      }
      
      gc()
      
      
      
    }
    

    
    if(return_model==T){
      return(model)
      
    }else{
      
      eval_list$Rank_Topic_Coherence_Top_Terms=rank(eval_list$Topic_Coherence_Top_Terms)
      eval_list$Rank_Topic_Divergence_Top_Terms=rank(eval_list$Topic_Divergence_Top_Terms)
      eval_list$Overall_Rank= rank(eval_list$Rank_Topic_Coherence+eval_list$Rank_Topic_Divergence_Top_Terms)
      
      if(best_cond=="all_rank"){
        #eval_list$Rank_Topic_Divergence_All=rank(eval_list$Topic_Divergence_ALL)
        #eval_list$Overall_Rank= eval_list$Rank_Topic_Coherence+eval_list$Rank_Topic_Divergence_Top10+eval_list$Rank_Topic_Divergence_All
        
        best_no_topic=which(eval_list$Overall_Rank==max(eval_list$Overall_Rank))
        best_no_topic=eval_list$No_topics[best_no_topic]
      }else if (best_cond=="tc_rank"){
        best_no_topic=which(eval_list$Rank_Topic_Coherence_Top_Terms==max(eval_list$Rank_Topic_Coherence_Top_Terms))
        best_no_topic=eval_list$No_topics[best_no_topic]
      }else if (best_cond=="td_rank"){
        best_no_topic=which(eval_list$Rank_Topic_Divergence_Top_Terms==max(eval_list$Rank_Topic_Divergence_Top_Terms))
        best_no_topic=eval_list$No_topics[best_no_topic]
      }
      
      print(paste("Best no topics:",best_no_topic))
      
      model=topic_extraction_new(text = text,word_vectors = word_vectors,dtm = dtm,tcm = tcm,
                                 min_topics = best_no_topic,max_topics = best_no_topic,algorithm = algorithm,no_top_terms = 10,
                                 return_model = T)
      
      return(list("Model"=model,"Eval_list"=eval_list))
      
    }

  
  
}