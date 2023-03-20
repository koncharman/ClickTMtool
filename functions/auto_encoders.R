"auto_encoders"<-function(features,dimensions){
  set.seed(831)
  library(h2o)
  
  
  all_pos=c(1:ncol(features))
  
  
  
  hidden_dim=dimensions
  
  train.auto_enc=h2o.deeplearning(x=all_pos,reproducible = T,activation = "Tanh",
                                  seed = 831,training_frame = as.h2o(features),average_activation=1,fast_mode = F,
                                  autoencoder = T,hidden = hidden_dim,epochs = 10,rate=0.005,adaptive_rate = F
                                  #,loss="CrossEntropy"
  )
  auto_enc_matrix=as.matrix(h2o.deepfeatures(train.auto_enc, as.h2o(features), layer = 1))
  if(nrow(auto_enc_matrix)!=nrow(features))auto_enc_matrix=auto_enc_matrix[-1,]
  rownames(auto_enc_matrix)=rownames(features)
  

  return(auto_enc_matrix)
  
}