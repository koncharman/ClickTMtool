"topic_models"<-function(item_list_text,word_vectors=NULL,type="LDA_vem",no_topics=10,split2,alpha_var=1,beta_var=1,iter_var=10,as_alpha=F,no_top_terms=10,categories_assignement){
  set.seed(831)
  
  library(text2vec)
  
  library(LDAvis)
  library(servr)
  library("tsne")
  svd_tsne <- function(x) tsne(svd(x)$u)
  
  
 
  
  
  row_s=rowSums(item_list_text$dtm)
  col_s=colSums(item_list_text$dtm)
  
  if(type=="LDA_vem"){
    library(topicmodels)
    model=LDA(x = item_list_text$dtm[split2==T,],k=no_topics)
    ldaOut.terms=terms(model,no_top_terms)
    fc=find_coh(ldaOut.terms,item_list_text$tcm,nrow(item_list_text$dtm[split2==T,]))
    topic_vis=createJSON(mds.method = svd_tsne,phi = exp(model@beta),theta = model@gamma,doc.length = row_s[split2==T],vocab = colnames(item_list_text$dtm),term.frequency = colSums(item_list_text$dtm[split2==T,]))
    
    doc_mem=topicmodels::posterior(model,item_list_text$dtm)$topics
    
    
    
    return(list("phi"=exp(model@beta),'model'=model,'keyword_table'=ldaOut.terms,'coherence_npmi'=fc,"document_memberships"=doc_mem,'topic_vis'=topic_vis))
    
    
  }else if(type=="CTM_vem"){
    library(topicmodels)
    model=CTM(item_list_text$dtm[split2==T,], k = no_topics)
    
    ldaOut.terms=terms(model,no_top_terms)
    
    fc=find_coh(ldaOut.terms,item_list_text$tcm,nrow(item_list_text$dtm[split2==T,]))
    topic_vis=createJSON(mds.method = svd_tsne,phi = exp(model@beta),theta = model@gamma,doc.length = row_s[split2==T],vocab = colnames(item_list_text$dtm),term.frequency = colSums(item_list_text$dtm[split2==T,]))
    
    doc_mem=topicmodels::posterior(object = model,newdata = item_list_text$dtm)$topics
    
    
    
    return(list("phi"=exp(model@beta),'model'=model,'keyword_table'=ldaOut.terms,'coherence_npmi'=fc,"document_memberships"=doc_mem,'topic_vis'=topic_vis))
    
    
  }else if(type=="STM_vem"){
    
    library(stm)
    
    doc_train=strsplit(x = item_list_text$text,split = " ")
    
    for(i in 1:length(item_list_text$text)){
      doc_train[[i]]=match(doc_train[[i]],item_list_text$old_words)
      doc_train[[i]]=doc_train[[i]][which(!is.na(doc_train[[i]]))]
      temp=table(doc_train[[i]])
      doc_train[[i]]=rbind(as.numeric(names(temp)),as.numeric(temp))
    }
    
    model <- stm(documents =doc_train[split2==T],vocab = colnames(item_list_text$dtm),K = no_topics)
    
    ldaOut.terms=matrix(nrow = no_topics,ncol=no_top_terms)
    for(i in 1:no_topics){
      ldaOut.terms[i,]=colnames(item_list_text$dtm)[order(model$beta$logbeta[[1]][i,],decreasing = T)[1:no_top_terms]]
    }
    
    fc=find_coh(ldaOut.terms,item_list_text$tcm,nrow(item_list_text$dtm[split2==T,]))
    
    
    topic_vis=createJSON(mds.method = svd_tsne ,phi = exp(model$beta$logbeta[[1]]),theta = model$theta,doc.length = row_s[split2==T],vocab = colnames(item_list_text$dtm),term.frequency = colSums(item_list_text$dtm[split2==T,]))
    
    doc_mem=fitNewDocuments(model = model,documents = doc_train)$theta
    
   
    
    return(list('phi'=exp(model$beta$logbeta[[1]]),'model'=model,'keyword_table'=ldaOut.terms,'coherence_npmi'=fc,"document_memberships"=doc_mem,'topic_vis'=topic_vis))
    
    
  }else if(type=="ETM"){
    library(topicmodels.etm)
    library(torch)
    library(Matrix)
    
    dtm= as(as.matrix(item_list_text$dtm), "dgCMatrix")
    set.seed(831)
    torch_manual_seed(831)
    
    model <- ETM(k = no_topics, dim = ncol(word_vectors), embeddings = word_vectors, dropout = 0.5)
    
    optimizer <- optim_adam(params = model$parameters, lr = 0.005, weight_decay = 0.0000012)
    tryCatch(expr ={
      overview <- model$fit(data = dtm[split2,], optimizer = optimizer, epoch = iter_var, batch_size = 1000)
      ldaOut.terms=mapply(function(x)return(x$term), predict(model, type='terms',top_n = no_top_terms))
      
      fc=find_coh(ldaOut.terms,item_list_text$tcm,nrow(item_list_text$dtm[split2==T,]))
      
      doc_mem=predict(object = model,newdata=dtm,type='topics')
      
      rem_bal=1-rowSums(doc_mem)
      for(i in 1:nrow(doc_mem)){
        max_pos=which(doc_mem[i,]==max(doc_mem[i,]))
        doc_mem[i,max_pos]=doc_mem[i,max_pos]+rem_bal[i]
      } 
      
      
      
      phi=t(mapply(function(x)return(x$beta[match(colnames(dtm),x$term)]),predict(model, type='terms',top_n = ncol(item_list_text$dtm))))
      colnames(phi)=colnames(dtm)
      rownames(phi)=colnames(doc_mem)
      
      rem_bal=1-rowSums(phi)
      for(i in 1:nrow(phi)){
        max_pos=which(phi[i,]==max(phi[i,]))
        phi[i,max_pos]=phi[i,max_pos]+rem_bal[i]
      } 
      
      
      
      
      print(summary(rowSums(phi)))
      
      topic_vis=createJSON(mds.method = svd_tsne ,phi = phi,theta = doc_mem[split2==T,],doc.length = row_s[split2==T],vocab = colnames(item_list_text$dtm),term.frequency = colSums(item_list_text$dtm[split2==T,]))
      
      
      
      
      return(list('phi'=phi,'model'=model,'keyword_table'=ldaOut.terms,'coherence_npmi'=fc,"document_memberships"=doc_mem,'topic_vis'=topic_vis))
      
    } ,
             error<-{
               overview <- model$fit(data = rbind(dtm[split2,],dtm[split2,]), optimizer = optimizer, epoch = iter_var, batch_size = 1000)
               
               ldaOut.terms=mapply(function(x)return(x$term), predict(model, type='terms',top_n = no_top_terms))
               
               fc=find_coh(ldaOut.terms,item_list_text$tcm,nrow(item_list_text$dtm[split2==T,]))
               
               doc_mem=predict(object = model,newdata=dtm,type='topics')
               
               rem_bal=1-rowSums(doc_mem)
               for(i in 1:nrow(doc_mem)){
                 max_pos=which(doc_mem[i,]==max(doc_mem[i,]))
                 doc_mem[i,max_pos]=doc_mem[i,max_pos]+rem_bal[i]
               } 
               
               
               
               phi=t(mapply(function(x)return(x$beta[match(colnames(dtm),x$term)]),predict(model, type='terms',top_n = ncol(item_list_text$dtm))))
               colnames(phi)=colnames(dtm)
               rownames(phi)=colnames(doc_mem)
               
               rem_bal=1-rowSums(phi)
               for(i in 1:nrow(phi)){
                 max_pos=which(phi[i,]==max(phi[i,]))
                 phi[i,max_pos]=phi[i,max_pos]+rem_bal[i]
               } 
               
               
               
               
               print(summary(rowSums(phi)))
               
               topic_vis=createJSON(mds.method = svd_tsne ,phi = phi,theta = doc_mem[split2==T,],doc.length = row_s[split2==T],vocab = colnames(item_list_text$dtm),term.frequency = colSums(item_list_text$dtm[split2==T,]))
               
               
               
               
               return(list('phi'=phi,'model'=model,'keyword_table'=ldaOut.terms,'coherence_npmi'=fc,"document_memberships"=doc_mem,'topic_vis'=topic_vis))
               
               
               }
             )

  }else if(type=="LSA"){
    

    library(textmineR)
    library(DirichletReg)
    library(Matrix)
    model=FitLsaModel(dtm = Matrix(as.matrix(item_list_text$dtm[split2==T,]),sparse = T),k = no_topics)
    ldaOut.terms=GetTopTerms(model$phi, no_top_terms, return_matrix = TRUE)


    
    
    fc=find_coh(ldaOut.terms,item_list_text$tcm,nrow(item_list_text$dtm[split2==T,]))
    

    doc_mem=predict(model,Matrix(as.matrix(item_list_text$dtm)),iterations = iter_var)
    
    
    
    return(list('model'=model,'keyword_table'=ldaOut.terms,'coherence_npmi'=fc,"document_memberships"=doc_mem))#,'topic_vis'=topic_vis
    
    
    
  }else if(type=="LDA_m"){
    library(textmineR)
    library(DirichletReg)
    library(Matrix)

    if(as_alpha==T){
      f_alpha=c()
      for(i in 1:no_topics){
        f_alpha[i]=1/(i+sqrt(no_topics))
      }
    }else{
      f_alpha=alpha_var
    }
    
    model=FitLdaModel(dtm = Matrix(as.matrix(item_list_text$dtm[split2==T,]),sparse = T),k=no_topics,iterations = iter_var,alpha = f_alpha,beta = beta_var)
    ldaOut.terms=GetTopTerms(model$phi, no_top_terms, return_matrix = TRUE)
    fc=find_coh(ldaOut.terms,item_list_text$tcm,nrow(item_list_text$dtm[split2==T,]))
    
    topic_vis=createJSON(mds.method = svd_tsne ,phi = model$phi,theta = model$theta,doc.length = row_s[split2==T],vocab = colnames(item_list_text$dtm),term.frequency = colSums(item_list_text$dtm[split2==T,]))
    
    doc_mem=predict(model,Matrix(as.matrix(item_list_text$dtm)),iterations = iter_var)
    
    
    return(list("phi"=model$phi,'model'=model,'keyword_table'=ldaOut.terms,'coherence_npmi'=fc,"document_memberships"=doc_mem,'topic_vis'=topic_vis))
    
  }
}