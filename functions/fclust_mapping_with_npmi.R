"fclust_mapping_with_npmi"<-function(word_vectors,min_topics=2,topic_range=20,tSparse_train,center_top_Words=F,l=10,type="fclust",tcm,glove_leiden=F,split2,categories_assignement,leiden_option_mem=2,no_clust_mem_cond=F,stand_leiden_words_mem=F,sim_option=NULL){
  
  set.seed(831)
  library(philentropy)
  
  library(LDAvis)
  library(servr)
  library("tsne")
  svd_tsne <- function(x) tsne(svd(x)$u)
  
  
  
  
  col_sums=diag(x = tcm)
  
  rows_train=nrow(tSparse_train[split2==T,])
  
  tSparse_colnames=colnames(tSparse_train)
  
  
  row_s=rowSums(tSparse_train)
  col_s=colSums(tSparse_train)
  
  col_s_train=colSums(tSparse_train[split2==T,])

  

  
  

  if(type=="fclust"){
  
  library(fclust)
  library(factoextra)
  library(ggplot2)
  library(ggrepel)
    
    coh_list=c()
    div_list=c()
    div_list_all=c()
    
  for(i in min_topics:topic_range){
    gc()
    set.seed(831)
    
    f_clust=FKM(X = word_vectors,k = i)
    #
    ldaOut.terms=matrix(ncol = f_clust$k,nrow=l)
    
    for(j in 1:ncol(ldaOut.terms)){
      if(center_top_Words){
        ldaOut.terms[,j]=names(sort(f_clust$U[,j],decreasing = T))[1:l]
      }
      else{
        ldaOut.terms[,j]=names(sort(f_clust$U[,j]*col_sums,decreasing = T))[1:l]
        
      }
      
      
    }
    
    fc=find_coh(ldaOut.terms,tcm,rows_train)
    coh_list[i-1]=fc
    
    td_temp=length(unique(as.vector(ldaOut.terms)))/(l*i)
    div_list[i-1]=td_temp
    
    
    td_all_temp=t(f_clust$U*col_sums)
    td_all_temp=td_all_temp/rowSums(td_all_temp)
    td_all_temp=mean(as.vector(JSD(td_all_temp)))
    div_list_all[i-1]=td_all_temp
    
    print(paste(i,fc,td_temp,td_all_temp))
    
    if(i ==min_topics){
      td_all=td_all_temp
      td=td_temp
      max_coh=fc
      f_clust_final=f_clust
      ldaOut.terms_final=ldaOut.terms
    }else if(fc>max_coh){
      td_all=td_all_temp
      td=td_temp
      f_clust_final=f_clust
      max_coh=fc
      ldaOut.terms_final=ldaOut.terms
    }
  }
  
  f_clust=f_clust_final
  tSparse_fclust= as.matrix(tSparse_train)%*%f_clust$U
  tSparse_fclust=tSparse_fclust/as.numeric(row_s)
  
  
  
  temp_t=colSums(tSparse_fclust[split2,]*row_s[split2])
  cs_order_mem=order(temp_t,decreasing = T)
  ldaOut.terms=ldaOut.terms_final[,cs_order_mem]
  tSparse_fclust=tSparse_fclust[,cs_order_mem]
  #f_clust$U=f_clust$U[,cs_order_mem]
  match_order=match(c(1:ncol(f_clust$U)),cs_order_mem)
  #f_clust$clus[,1]=match_order[f_clust$clus[,1]]
  #f_clust$H=f_clust$H[cs_order_mem,]
  colnames(tSparse_fclust)=paste("Topic ",c(1:ncol(tSparse_fclust)))
  
  
  pos=unique(match(ldaOut.terms,rownames(f_clust$Xca)))
  
  if(ncol(f_clust$Xca)!=2){
    library(uwot)
    
      word_vectors=umap(X =   word_vectors,n_neighbors = 5,n_components = 2,metric =  "cosine",verbose = T)
      
    
  }
  
  colnames(word_vectors)=c("x","y")
  
  library(concaveman)
  library(ggforce)
  
  library(ggrepel)
  word_vectors=data.frame("x"=word_vectors[,1],"y"=word_vectors[,2])
  word_vectors$Cluster=as.factor(match_order[f_clust$clus[,1]])
  colnames(word_vectors)=c("x","y","Cluster")
  rownames(word_vectors)=tSparse_colnames
  
  ppl2=ggplot( data = as.data.frame(word_vectors),mapping = aes(x, y,colour = Cluster,label = rownames(word_vectors))) +
    geom_mark_ellipse(aes(fill = Cluster,label=as.factor(Cluster)))+
    #geom_mark_hull(aes(fill = Cluster,label=as.factor(Cluster)),concavity = 5) +
    #geom_text_repel(max.overlaps = 50)+
    labs(colour="Cluster",x="x",y="y")+
    ggtitle("Cluster Plot")+
    theme_solarized_2(light = F)
  
  
  ppl=ggplot( data = as.data.frame(word_vectors[pos,]),mapping = aes(x, y,colour = Cluster,label = rownames(word_vectors[pos,]))) +
    geom_mark_ellipse(aes(fill = Cluster,label=as.factor(Cluster)))+
    #geom_mark_hull(aes(fill = Cluster,label=as.factor(Cluster)),concavity = 5) +
    geom_text_repel(max.overlaps = 50)+
    labs(colour="Cluster",x="x",y="y")+
    ggtitle(paste("Fuzzy k-means Clustering Plot NPMI:",max_coh,"Topic Divergence (Top terms):",td,"Topic Divergence (All Terms):",td_all))+
    xlim(c(min(word_vectors[pos,1])-1,max(word_vectors[pos,1])+1))+
    ylim(c(min(word_vectors[pos,2])-1,max(word_vectors[pos,2])+1))+
    theme_solarized_2(light = F)
  
 
  
  
  phi=t(f_clust$U[,cs_order_mem]*col_sums)
  phi=phi/rowSums(phi)
  
  
  
  
  topic_vis=createJSON(mds.method = svd_tsne,phi = phi,theta = tSparse_fclust[split2==T,],doc.length = row_s[split2==T],vocab = colnames(tSparse_train),term.frequency = col_s_train)
  
  
  
  return(list("phi"=phi,"f_clust"=f_clust,"short_visualization"=ppl,"full_visualization"=ppl2,"document_memberships"=tSparse_fclust,"coherence_npmi"=coh_list,'max_coh'=max_coh,"top_terms"=ldaOut.terms,'topic_vis'=topic_vis,"topic_divergence"=td,"topic_divergence_list"=div_list,"topic_divergence_all"=td_all,"topic_divergence_all_list"=div_list_all))
  
  
  }else if(type=="mclust"){
    library(mclust) 
    library(factoextra)
    library(ggplot2)
    library(ggrepel)
    
    coh_list=c()
    div_list=c()
    div_list_all=c()
    
    for(i in min_topics:topic_range){
      gc()
      set.seed(831)
      
      m_clust=Mclust(word_vectors,G=i,verbose = TRUE) #,control = em_control or not umap
      ldaOut.terms=matrix(ncol = m_clust$G,nrow=l)
      

      for(j in 1:ncol(ldaOut.terms)){
        if(center_top_Words){
          ldaOut.terms[,j]=names(sort(m_clust$z[,j],decreasing = T))[1:l]
        }
        else{
          ldaOut.terms[,j]=names(sort(m_clust$z[,j]*col_sums,decreasing = T))[1:l]
          
        }
        
        
      }
      
      fc=find_coh(ldaOut.terms,tcm,rows_train)
      coh_list[i-1]=fc
      
      td_temp=length(unique(as.vector(ldaOut.terms)))/(l*i)
      div_list[i-1]=td_temp
     
      
      td_all_temp=t(m_clust$z*col_sums)
      td_all_temp=td_all_temp/rowSums(td_all_temp)
      td_all_temp=mean(as.vector(JSD(td_all_temp)))
      div_list_all[i-1]=td_all_temp
      
      print(paste(i,fc,td_temp,td_all_temp))
      
      if(i ==min_topics){
        td_all=td_all_temp
        td=td_temp
        
        max_coh=fc
        m_clust_final=m_clust
        ldaOut.terms_final=ldaOut.terms
      }else if(fc>max_coh){
        td_all=td_all_temp
        td=td_temp
        
        m_clust_final=m_clust
        max_coh=fc
        ldaOut.terms_final=ldaOut.terms
      }
      
    }
    
    tSparse_mclust= as.matrix(tSparse_train)%*%m_clust_final$z
    tSparse_mclust=tSparse_mclust/as.numeric(row_s)
    
    
    temp_t=colSums(tSparse_mclust[split2,]*row_s[split2])
    cs_order_mem=order(temp_t,decreasing = T)
    ldaOut.terms=ldaOut.terms_final[,cs_order_mem]
    tSparse_mclust=tSparse_mclust[,cs_order_mem]
    #m_clust_final$z=m_clust_final$z[,cs_order_mem]
    match_order=match(c(1:ncol(m_clust_final$z)),cs_order_mem)
    #m_clust_final$classification=match_order[m_clust_final$classification]
    colnames(tSparse_mclust)=paste("Topic ",c(1:ncol(tSparse_mclust)))
    
    
    
    
    if(ncol(m_clust_final$data)!=2){
      library(uwot)
      
      word_vectors=umap(X =   word_vectors,n_neighbors = 5,n_components = 2,metric =  "cosine",verbose = T)
      rownames(word_vectors)=tSparse_colnames
      
    }else{
      word_vectors=m_clust_final$data
      
    }
    colnames(word_vectors)=c("x","y")
    
    
    pos=unique(match(ldaOut.terms,rownames(m_clust_final$z)))
    
    
    library(concaveman)
  library(ggforce)
  
  library(ggrepel)
    
    word_vectors=data.frame("x"=word_vectors[,1],"y"=word_vectors[,2])
    word_vectors$Cluster=as.factor(match_order[m_clust_final$classification])
    colnames(word_vectors)=c("x","y","Cluster")
    rownames(word_vectors)=tSparse_colnames
    
    ppl2=ggplot( data = as.data.frame(word_vectors),mapping = aes(x, y,colour = Cluster,label = rownames(word_vectors))) +
      geom_mark_ellipse(aes(fill = Cluster,label=as.factor(Cluster))) +
      #geom_text_repel(max.overlaps = 50)+
      labs(colour="Cluster",x="x",y="y")+
      ggtitle("Cluster Plot")+
      theme_solarized_2(light = F)
    
    
    ppl=ggplot( data = as.data.frame(word_vectors[pos,]),mapping = aes(x, y,colour = Cluster,label = rownames(word_vectors[pos,]))) +
      geom_mark_ellipse(aes(fill = Cluster,label=as.factor(Cluster))) +
      geom_text_repel(max.overlaps = 100)+
      labs(colour="Cluster",x="x",y="y")+
      ggtitle(paste("Gaussian Mixture Models Clustering Plot NPMI:",max_coh,"Topic Divergence (Top terms):",td,"Topic Divergence (All terms):",td_all))+
      xlim(c(min(word_vectors[pos,1])-1,max(word_vectors[pos,1])+1))+
      ylim(c(min(word_vectors[pos,2])-1,max(word_vectors[pos,2])+1))+
      theme_solarized_2(light = F)
    
    
  
    
    
    phi=t(m_clust_final$z[,cs_order_mem]*col_sums)
    phi=phi/rowSums(phi)
    
    topic_vis=createJSON(mds.method = svd_tsne,phi = phi,theta = tSparse_mclust[split2==T,],doc.length = row_s[split2==T],vocab = colnames(tSparse_train),term.frequency = col_s_train)
    
    
    return(list("phi"=phi,"m_clust"=m_clust_final,"short_visualization"=ppl,"full_visualization"=ppl2,"document_memberships"=tSparse_mclust,"coherence_npmi"=coh_list,'max_coh'=max_coh,"top_terms"=ldaOut.terms,'topic_vis'=topic_vis,"topic_divergence"=td,"topic_divergence_list"=div_list,"topic_divergence_all"=td_all,"topic_divergence_all_list"=div_list_all))
    
  }else if(type=="leiden"){
    
    
    #Use of word vectors or use coocurences 
    if(glove_leiden==T){
      library(lsa)
       graph_tokens_rev_ii=as.matrix(cosine(t(word_vectors)))
       graph_tokens_rev_ii[which(graph_tokens_rev_ii<0)]=0

    }else{
      graph_tokens_rev_ii=tcm
      
      if(sim_option=="ii_choice" | sim_option=="rev_ii_choice") graph_tokens_rev_ii=graph_tokens_rev_ii/diag(graph_tokens_rev_ii)
      
      for(i in 1:(nrow(graph_tokens_rev_ii)-1)){
        for(j in (i+1):nrow(graph_tokens_rev_ii)){
          
          if(sim_option=="ii_choice"){
            temp_val= max(graph_tokens_rev_ii[i,j],graph_tokens_rev_ii[j,i])
              
           
            
          }else if(sim_option=="rev_ii_choice"){
           temp_val= min(graph_tokens_rev_ii[i,j],graph_tokens_rev_ii[j,i])
          }else if(sim_option=="ji_choice"){
            temp_val=(graph_tokens_rev_ii[i,j])/( graph_tokens_rev_ii[i,i] + graph_tokens_rev_ii[j,j] - graph_tokens_rev_ii[i,j])
            
          }else if(sim_option=="ei_choice"){
            temp_val=(graph_tokens_rev_ii[i,j]^2)/( graph_tokens_rev_ii[i,i]* graph_tokens_rev_ii[j,j])
            
          }
          
          
          graph_tokens_rev_ii[i,j]=temp_val
          graph_tokens_rev_ii[j,i]=temp_val
        }
      }
      diag(graph_tokens_rev_ii)=1
      
    }
    
    ii_thres=c(seq(0.1,0.8,0.1))
    
    rp_values=c(0.0001,0.0003,0.0005,0.0008,0.001,0.003,0.005,0.01,0.02,0.03,0.05,0.08,0.1,0.2,0.3,0.6,0.8,1,2,3,5,10,20,30,50)
    
    coh_list=list()
    div_list=list()
    #div_list_all=list()
    
    for(k_ii in 1:length(ii_thres)){
    ##II - threshold link
    library(binda)
    graph_tokens_rev_ii_dich=dichotomize(X = graph_tokens_rev_ii,thresh = ii_thres[k_ii])
    diag(graph_tokens_rev_ii_dich)=0
    ##no edges
    no_edges=rowSums(graph_tokens_rev_ii_dich)
    zero_edges=which(no_edges==0)
    
    if(length(zero_edges)!=nrow(graph_tokens_rev_ii_dich)){
      
    
    ##igraph
    library(igraph)
    if(length(zero_edges)==0){
      g <-graph.adjacency(adjmatrix = graph_tokens_rev_ii_dich, mode="undirected") # For directed networks - graph_from_adjacency_matrix
      
    }else{
      g <-graph.adjacency(adjmatrix = graph_tokens_rev_ii_dich[-zero_edges,-zero_edges], mode="undirected") # For directed networks - graph_from_adjacency_matrix
      
    }
    
    
    
    
    
    for(i in 1:length(rp_values)){
      gc()
      
      leiden_clust=cluster_leiden(graph = g,resolution_parameter=rp_values[i],objective_function = "modularity",n_iterations = 10)#objective_function = "modularity" or "CPM"
      
      
      leiden_clust$nb_clusters=length(sizes(leiden_clust))
      
      if(length(leiden_clust)!=0){
      
      token_memberships=as.numeric(membership(leiden_clust))
      match_all_names=match(rownames(graph_tokens_rev_ii_dich),names(membership(leiden_clust)))
      
      if(length(token_memberships)!=nrow(tcm)){
        token_memberships_all=matrix(nrow=nrow(graph_tokens_rev_ii_dich),ncol=1)
        
        token_memberships_all[which(is.na(match_all_names)==T)]=0
        token_memberships_all[which(is.na(match_all_names)==F)]=token_memberships
        
      }else{
        token_memberships_all=token_memberships
        
      }
      if(leiden_option_mem==1){
        rel_com=matrix(0,nrow=nrow(graph_tokens_rev_ii_dich),ncol = leiden_clust$nb_clusters)
        rownames(rel_com)=rownames(graph_tokens_rev_ii_dich)
        for(j in 1:nrow(graph_tokens_rev_ii_dich)){
          pos_edge=which(graph_tokens_rev_ii_dich[j,]==1)
          if(length(pos_edge>0)){
            mem_edge=table(token_memberships_all[pos_edge])
            rel_com[j,as.numeric(names(mem_edge))]=as.numeric(mem_edge)/length(pos_edge)
          }
        }
      }else if(leiden_option_mem==2){
        rel_com=matrix(0,nrow=nrow(graph_tokens_rev_ii_dich),ncol = leiden_clust$nb_clusters)
        rownames(rel_com)=rownames(graph_tokens_rev_ii_dich)
        for(j in 1:ncol(rel_com)){
          match_clusters=which(token_memberships_all==j)
          if(length(match_clusters)==1){
            rel_com[,j]=graph_tokens_rev_ii[,match_clusters]
            
          }else{
            rel_com[,j]=rowSums(graph_tokens_rev_ii[,match_clusters])
            
          }
        }
        if(no_clust_mem_cond){
        if(!is.na(match(0,token_memberships_all))){
          match_clusters=which(token_memberships_all==0)
          if(length(match_clusters)==1){
            rel_com=cbind(rel_com,graph_tokens_rev_ii[,match_clusters])
            
          }else{
            rel_com=cbind(rel_com,rowSums(graph_tokens_rev_ii[,match_clusters]))
            
          }
        }
        }
        # Do or Do not
        if(!stand_leiden_words_mem) rel_com=rel_com/rowSums(rel_com)
        rownames(rel_com)=rownames(graph_tokens_rev_ii_dich)
        
      }
      
      
      ldaOut.terms=matrix(ncol = ncol(rel_com),nrow=l)
      
    for(j in 1:ncol(rel_com)){
      if(center_top_Words){
        ldaOut.terms[,j]=names(sort(rel_com[,j],decreasing = T))[1:l]
      }
      else{
        ldaOut.terms[,j]=names(sort(rel_com[,j]*col_sums,decreasing = T))[1:l]
        
      }
    }
      
      zero_clust=which(is.nan(rowSums(rel_com))|rowSums(rel_com)==0)
      if(length(zero_clust)!=0){
        temp_s=1/ncol(rel_com)
        
        rel_com[zero_clust,]=temp_s
      }
      
      fc=find_coh(ldaOut.terms,tcm,rows_train)
      coh_list[[paste("ii_thres:",ii_thres[k_ii],"Res_parameter:",rp_values[i])]]=fc
      
      td_temp=length(unique(as.vector(ldaOut.terms)))/(l*ncol(rel_com))
      div_list[[paste("ii_thres:",ii_thres[k_ii],"Res_parameter:",rp_values[i])]]=td_temp
      
      #td_all_temp=t(rel_com*col_sums)
      #td_all_temp=td_all_temp/rowSums(td_all_temp)
      #td_all_temp=mean(as.vector(JSD(td_all_temp)))
      #div_list_all[[paste("ii_thres:",ii_thres[k_ii],"Res_parameter:",rp_values[i])]]=td_all_temp
      
      print(paste("threshold:",ii_thres[k_ii],"rp:",rp_values[i],"no clusters:",leiden_clust$nb_clusters,"coherence:",fc,"divergence",td_temp))
      
      if(i==1 && k_ii==1){
        #td_all=td_all_temp
        td=td_temp
        
        max_coh=fc
        l_clust_final=leiden_clust
        ldaOut.terms_final=ldaOut.terms
        rel_com_final=rel_com
        token_memberships_all_final=token_memberships_all
        ii_thres_final=ii_thres[k_ii]
        rp_final=rp_values[i]
        g_final=g
        
      }else if(fc>max_coh){
        td=td_temp
        
        l_clust_final=leiden_clust
        max_coh=fc
        ldaOut.terms_final=ldaOut.terms
        rel_com_final=rel_com
        token_memberships_all_final=token_memberships_all
        ii_thres_final=ii_thres[k_ii]
        rp_final=rp_values[i]
        g_final=g
        
      }
      
    }
    }
    }
    }
    
    
    disc_nodes_pos=which(token_memberships_all_final==0)
    if(leiden_option_mem==1){
      if(length(disc_nodes_pos)>0){
        add_disc_nodes_clust=matrix(0,nrow = nrow(rel_com_final),ncol=1)
        add_disc_nodes_clust[disc_nodes_pos]=0.85
        
        rel_com_final=cbind(rel_com_final,add_disc_nodes_clust)
        rel_com_final[disc_nodes_pos,-ncol(rel_com_final)]=(15/100)/(ncol(rel_com_final)-1)
      }
    }
    
    
    tSparse_lclust= as.matrix(tSparse_train)%*%rel_com_final
    tSparse_lclust=tSparse_lclust/rowSums(tSparse_lclust)
    
    row_s_clust=rowSums(tSparse_lclust)
    zero_clust=which(is.nan(row_s_clust)|row_s_clust==0)
    if(length(zero_clust)!=0){
      temp_s=1/ncol(tSparse_lclust)
      tSparse_lclust[zero_clust,]=temp_s
    }
    
    
    temp_t=colSums(tSparse_lclust[split2,]*row_s[split2])
    cs_order_mem=order(temp_t,decreasing = T)
    ldaOut.terms_final=ldaOut.terms_final[,cs_order_mem]
    tSparse_lclust=tSparse_lclust[,cs_order_mem]
    rel_com_final=rel_com_final[,cs_order_mem]
    match_order=match(c(1:ncol(rel_com_final)),cs_order_mem)
    token_memberships_all_final[-disc_nodes_pos]=match_order[token_memberships_all_final[-disc_nodes_pos]]
    
    colnames(tSparse_lclust)=paste("Topic ",c(1:ncol(tSparse_lclust)))
    
    
    
    coords <- layout.fruchterman.reingold(g_final)*0.5
    
    
    
    
    
    if(length(disc_nodes_pos)==0){
      all_df=cbind(coords,as.numeric(token_memberships_all_final))
      all_df=cbind(all_df,rownames(rel_com_final))
      
      
      
    }else{
      all_df=cbind(coords,as.numeric(token_memberships_all_final[-disc_nodes_pos]))
      all_df=cbind(all_df,rownames(rel_com_final)[-disc_nodes_pos])
  
    }
    
    
    all_df=as.data.frame(all_df)
    
    all_df$V1=as.numeric(all_df$V1)
    all_df$V2=as.numeric(all_df$V2)
    all_df$V3=as.numeric(all_df$V3)
    
    
    colnames(all_df)=c("V1","V2","cluster","label")
    
    g_matrix <- get.data.frame(g_final)
    
    g_matrix$from.x <- all_df$V1[match(g_matrix$from, all_df$label)]  
    g_matrix$from.y <- all_df$V2[match(g_matrix$from, all_df$label)]
    g_matrix$to.x <- all_df$V1[match(g_matrix$to, all_df$label)]  
    g_matrix$to.y <- all_df$V2[match(g_matrix$to, all_df$label)]
    
    palete_col=rainbow(n = (l_clust_final$nb_clusters+1))
    
    library(ggplot2)
    ppl= ggplot()+
    ggtitle(paste("II threshold:",ii_thres_final,"Resolution Parameter:",rp_final,"No clusters:",l_clust_final$nb_clusters,"NPMI coherence:",max_coh,"Topic Divergence (Top terms):",td))+
    geom_segment(data=g_matrix,aes(x=from.x,xend = to.x, y=from.y,yend = to.y),colour="black") + #size="weight"
    geom_point(data=all_df,aes(x=V1,y=V2),size=5,colour=(palete_col[as.numeric(all_df$cluster)+1])) +
    geom_text(data=all_df,aes(x=as.numeric(V1),y=as.numeric(V2),label=paste(all_df$cluster,all_df$label)))+
      theme_solarized_2(light = F)
      
    
    print(table(token_memberships_all_final))
    
    
    
    
    phi=t(rel_com_final*col_sums)
    phi=phi/rowSums(phi)
    
    
    
    
    topic_vis=createJSON(mds.method = svd_tsne,phi = phi,theta = tSparse_lclust[split2==T,],doc.length = row_s[split2==T],vocab = colnames(tSparse_train),term.frequency = col_s_train)
    
    
      
    return(list("phi"=phi,'leiden_clust'=l_clust_final,"document_memberships"=tSparse_lclust,"keyword_memberships"=rel_com_final,"short_visualization"=ppl,"coherence_npmi"=coh_list,'max_coh'=max_coh,"top_terms"=ldaOut.terms_final,"topic_vis"=topic_vis,"topic_divergence"=td,"topic_divergence_list"=div_list))
    
  }
}