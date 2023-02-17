"Feature_evaluation_methods"<-function(item_list_text,split2,categories_assignement,method_feature,matrix_feature,no_feature){
  set.seed(831)
  library(binda)
  
  
  if(matrix_feature=="dtm_mf"){
    features=item_list_text$dtm[split2==T,]
  }else if(matrix_feature=="dtmd_mf"){
    features=dichotomize(item_list_text$dtm[split2==T,],1)
    
  }

  if(method_feature=="jmim_ff"){
    library(praznik)
    model=JMIM(X = as.data.frame(features),Y = as.factor(categories_assignement[split2==T]),k = no_feature)
    
    return(data.frame("Feature_name"=names(model$selection),"Score"=as.numeric(model$score)))
  }else if(method_feature=="mim_ff"){
    library(praznik)
    model=MIM(X = as.data.frame(features),Y = as.factor(categories_assignement[split2==T]),k = no_feature)
    
    return(data.frame("Feature_name"=names(model$selection),"Score"=as.numeric(model$score)))
  }else if(method_feature=="mrmr_ff"){
    library(praznik)
    model= MRMR(X = as.data.frame(features),Y = as.factor(categories_assignement[split2==T]),k = no_feature)
    
    return(data.frame("Feature_name"=names(model$selection),"Score"=as.numeric(model$score)))
  }else if(method_feature=="jmi_ff"){
    library(praznik)
    model= JMI(X = as.data.frame(features),Y = as.factor(categories_assignement[split2==T]),k = no_feature)
    
    return(data.frame("Feature_name"=names(model$selection),"Score"=as.numeric(model$score)))
  }else if(method_feature=="disr_ff"){
    library(praznik)
    model= DISR(X = as.data.frame(features),Y = as.factor(categories_assignement[split2==T]),k = no_feature)
    
    return(data.frame("Feature_name"=names(model$selection),"Score"=as.numeric(model$score)))
  }else if(method_feature=="cmim_ff"){
    library(praznik)
    model= CMIM(X = as.data.frame(features),Y = as.factor(categories_assignement[split2==T]),k = no_feature)
    
    return(data.frame("Feature_name"=names(model$selection),"Score"=as.numeric(model$score)))
  }else if(method_feature == "jim_ff"){
    library(praznik)
    model=JIM(X = as.data.frame(features),Y = as.factor(categories_assignement[split2==T]),k = no_feature)
    return(data.frame("Feature_name"=names(model$selection),"Score"=as.numeric(model$score)))
    
  }else if(method_feature == "njmim_ff"){
    library(praznik)
    model=NJMIM(X = as.data.frame(features),Y = as.factor(categories_assignement[split2==T]),k = no_feature)
    return(data.frame("Feature_name"=names(model$selection),"Score"=as.numeric(model$score)))
    
  }else if(method_feature == "cmi_ff"){
    library(praznik)
    model=CMI(X = as.data.frame(features),Y = as.factor(categories_assignement[split2==T]),k = no_feature)
    return(data.frame("Feature_name"=names(model$selection),"Score"=as.numeric(model$score)))
    
  }else if(method_feature=="cossimil_ff"){
    library(lsa)
    model=matrix(nrow = ncol(features),ncol=3)
    for(i in 1:ncol(features)){
      temp_value=cosine(x = features[,i],y = as.numeric(categories_assignement[split2==T]))
      model[i,]=cbind(colnames(features)[i],abs(temp_value),temp_value)
    } 
    model=model[order(as.numeric(model[,2]),decreasing = T),]
    return(data.frame("Feature_name"=model[1:no_feature,1],"Absolute Score"=as.numeric(model[1:no_feature,2]),"Score" = as.numeric(model[1:no_feature,3])))
    }else if (method_feature=="spearman_ff"){
      model=matrix(nrow = ncol(features),ncol=3)
      for(i in 1:ncol(features)){
        temp_value=cor(method="spearman",x = features[,i],y = as.numeric(categories_assignement[split2==T]))
        model[i,]=cbind(colnames(features)[i],abs(temp_value),temp_value)
      } 
      model=model[order(as.numeric(model[,2]),decreasing = T),]
      return(data.frame("Feature_name"=model[1:no_feature,1],"Absolute Score"=as.numeric(model[1:no_feature,2]),"Score" = as.numeric(model[1:no_feature,3])))
      
  }
}