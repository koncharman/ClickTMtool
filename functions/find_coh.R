'find_coh'<-function(ldaOut.terms,tcm,rows_train,mean_now=T){
  
  set.seed(831)
  
  
  library(text2vec)
  #coherence_list=coherence(x = ldaOut.terms, tcm = tcm,n_doc_tcm =rows_train,metrics ="mean_npmi",smooth = 1e-12)
  coh_list=c()
  for (i in 1:ncol(ldaOut.terms)){
    coh_list_temp=c()
    k=0
    for (j in 1:(nrow(ldaOut.terms)-1)){
      for (t in (j+1):nrow(ldaOut.terms)){
       
       f_1=tcm[ldaOut.terms[j,i],ldaOut.terms[j,i]]
       f_2=tcm[ldaOut.terms[t,i],ldaOut.terms[t,i]]
       f_co=tcm[ldaOut.terms[j,i],ldaOut.terms[t,i]]
       
       p_1=f_1/rows_train+1e-12
       p_2=f_2/rows_train+1e-12
       p_co=f_co/rows_train+1e-12
       
       if(f_1!=0&f_2!=0){
         k=k+1
         coh_list_temp[k]=(log2((p_co/p_1/p_2)))/(-log2(p_co))
       }
       
      }
    }
    if(length(coh_list_temp)>0){
      coh_list[i]=mean(coh_list_temp)
      
    }else{
      coh_list[i]=0
    }
  }
  if(mean_now){
    mean(coh_list)
    
  }else{
    coh_list
  }
  
}