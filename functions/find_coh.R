'find_coh'<-function(ldaOut.terms,tcm,rows_train){
  set.seed(831)
  
  
  library(text2vec)
  coherence_list=coherence(ldaOut.terms, tcm,n_doc_tcm =rows_train,metrics ="mean_npmi")
  mean(coherence_list)
}