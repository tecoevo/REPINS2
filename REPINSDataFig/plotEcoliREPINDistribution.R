library(ggtree)
library(ggplot2)
library(colorspace)
library(ape)
root=c("1_ASM993143v1_genomic","1_ASM301829v1_genomic")
delete=c("1_Unitig_genomic","1_ASM90049747v1_genomic")
tree=read.tree("ecoli_trans.nwk")
tree=drop.tip(tree,delete)
tree=root(tree,root)
tree=multi2di(tree)
theme=theme(axis.line.x = element_line(colour = "black"),legend.key = element_rect(fill = "white"),axis.line.y = element_line(colour = "black"),panel.grid.major = element_blank(),panel.grid.minor = element_blank(),panel.border = element_blank(),panel.background = element_blank(),legend.justification = c(0, 1), legend.position = c(0.1, 1),legend.title=element_blank(),legend.text = element_text(hjust=0),panel.spacing=unit(2,"lines"))
folder="./"
tIS5=read.delim(paste0(folder,"presAbs_0_IS5.txt"))
tIS5=tIS5[!tIS5[,1]%in%delete,]

t=read.delim(paste0(folder,"presAbs_0_yafM.txt"))
t=t[!t[,1]%in%delete,]
plotAll=function(t,tIS5,tree,name){
  print(tree)
  t$IS5=0
  tIS5$IS5=2
  tIS5[,3]=tIS5[,2] #copy number of IS5 copies into REPIN space
  RAYTPA=t
  t=rbind(t,tIS5)

  t[t[,2]==0 & t$IS5==0,]$IS5="REPINs found in genomes lacking a RAYT gene"
  t[t[,2]==1 & t$IS5==0,]$IS5="REPINs found in genomes containing a RAYT gene"
  t[t$IS5==2,]$IS5=name
  cols=c("REPINs found in genomes lacking a RAYT gene"="deepskyblue","REPINs found in genomes containing a RAYT gene"="dodgerblue2","IS5"="red")
  ggplot(t,aes(x=t[,3],fill=as.factor(IS5),color=as.factor(IS5)))+geom_histogram(position="identity",alpha=0.5,breaks=0:52*5)+theme+xlab("Number of REPINs(blue)/IS5 copies(red)")+ylab("Number of genomes")+scale_color_manual(values=cols)+scale_fill_manual(values=cols)
  ggsave(paste0(folder,"REPIN_",name,"_distribution.pdf"),width=5,height=5)
}
plotAll(t,tIS5,tree,"IS5")
