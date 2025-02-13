"dimensionality_reduction_options" <- function(tSparse_colnames,word_vectors,no_umap_dims=2,dim_red_options="no_red",nn=5,spr=1,md=0.01,umap_metric="cosine"){
  set.seed(831)
  
    if(dim_red_options=="umap_red"){
      library(uwot)
      if(umap_metric=="dist"){
        umap_tcm_ii=umap(X = as.dist(word_vectors),verbose = TRUE,n_neighbors =nn,n_components = no_umap_dims,local_connectivity =1,spread = spr,min_dist = md)# ,n_epochs = 10000 , 5 or 10 neighbors 
        
      }else{
        umap_tcm_ii=umap(X = word_vectors,verbose = TRUE,n_neighbors =nn,metric = umap_metric,n_components = no_umap_dims,local_connectivity =1,spread = spr,min_dist = md)# ,n_epochs = 10000 , 5 or 10 neighbors 
        
      }
      rownames(umap_tcm_ii)=tSparse_colnames
      # 
    }else if(dim_red_options=="pca_red"){
      library(FactoMineR)
      umap_tcm_ii=PCA(X =   word_vectors,ncp = no_umap_dims)$svd$U
      rownames(umap_tcm_ii)=tSparse_colnames
      
    }else if(dim_red_options=="svd_red"){
      umap_tcm_ii=svd(word_vectors,nv = no_umap_dims) ;  umap_tcm_ii= umap_tcm_ii$u%*%umap_tcm_ii$v
      rownames(umap_tcm_ii)=tSparse_colnames
      
    }else if(dim_red_options=="tsne_red"){
      library(Rtsne)
      umap_tcm_ii=Rtsne(word_vectors,dims = no_umap_dims)$Y
      rownames(umap_tcm_ii)=tSparse_colnames
      
    }else if(dim_red_options=="factanal_red"){
      umap_tcm_ii=factanal(word_vectors,factors = no_umap_dims,scores = "Bartlett")$scores
      rownames(umap_tcm_ii)=tSparse_colnames
      
    }else if(dim_red_options=="no_red"){
      umap_tcm_ii=word_vectors
      rownames(umap_tcm_ii)=tSparse_colnames
      
    }
  
  
  return(umap_tcm_ii)
}