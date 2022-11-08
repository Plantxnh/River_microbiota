wd<- "/path/data"
setwd(wd)
library(psych)
library(foreach)  
library(doParallel)  
library(abind)
#read in data
otu_table = read.table('OTU.txt', sep="\t", header=T)
head(otu_table)
#run
network_construct <- function(otu_table,threads){
  otu_table2 <- apply(otu_table,2,rank)  
  r <- function(rx,ry){  
    n <- length(rx)  
    lxy <- sum((rx-mean(rx))*(ry-mean(ry)))  
    lxx <- sum((rx-mean(rx))^2)  
    lyy <- sum((ry-mean(ry))^2)   
    r <- lxy/sqrt(lxx*lyy)   
    t <- (r * sqrt(n - 2))/sqrt(1 - r^2)   
    p <- -2 * expm1(pt(abs(t), (n - 2), log.p = TRUE))    
    return(c(r,p))  
  }  
  arraybind <- function(...){    
    abind(...,along = 3,force.array=TRUE)  
  } 
  nc <- ncol(otu_table) 
  registerDoParallel(cores = 16)  
  corr <- foreach (i = 1:nc,.combine = "arraybind") %dopar%{   
    corr1 <- matrix(rep(0,2*nc),nrow = 2,ncol=nc)   
    for(j in 1:nc) {     
      if(j > i) corr1[,j] <- r(otu_table2[,i],otu_table2[,j])  
    }   
    corr <- corr1  
  }  
  rr <- corr[1,,] 
  rr <- rr+t(rr)  
  diag(rr) <- 1 
  pp <- corr[2,,] 
  lp <- lower.tri(pp) 
  pa <- pp[lp]  
  pa <- p.adjust(pa, "fdr")  
  pp[lower.tri(pp, diag = FALSE)] <- pa  
  pp <- pp+t(pp)  
  rownames(pp) <- colnames(otu_table) 
  colnames(pp) <- colnames(otu_table)  
  rownames(rr) <- colnames(otu_table) 
  colnames(rr) <- colnames(otu_table)  
  return(list(r = rr,p = pp))
  
}
occor <- network_construct(otu_table[,1:1175],8)
R <- data.frame(occor$r)
P <- data.frame(occor$p)
R[P>0.05|abs(R)<0.8] = 0
write.csv(R, 'Correlation .csv', quote = FALSE)
