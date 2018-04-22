library(pheatmap)
library(RColorBrewer)
library(viridis)
library(ggsci)

dna <- read.csv("/Users/jacobluber/Desktop/pqe/dna_bc.txt",header=TRUE,row.names=1,sep=' ',check.names=FALSE)
rna <- read.csv("/Users/jacobluber/Desktop/pqe/dna_bc.txt",header=TRUE,row.names=1,sep=' ',check.names=FALSE)
tax <- read.csv("/Users/jacobluber/Desktop/pqe/dna_bc.txt",header=TRUE,row.names=1,sep=' ',check.names=FALSE)
m1 <- as.matrix(rbind(dna,rna))
m2 <- as.matrix(rbind(m1,tax))
mat_breaks <- quantile_breaks(m2, n = 10)

quantile_breaks <- function(xs, n = 10) {
  breaks <- quantile(xs, probs = seq(0, 1, length.out = n))
  breaks[!duplicated(breaks)]
}
individual <- c("10042055","10042055","10042055","10042055","10057608","10057608","10057608","10057608","10598702","10598702","10598702","10598702","11188967","11188967","11188967","11188967","11275441","11275441","11275441","11275441","11287767","11287767","11287767","11287767","11418230","11418230","11418230","11418230","11486372","11486372","11486372","11486372","11507229","11507229","11507229","11507229","11715866","11715866","11715866","11715866","11992832","11992832","11992832","11992832","12112483","12112483","12112483","12112483","12289378","12289378","12289378","12289378","12293355","12293355","12293355","12293355","12542142","12542142","12542142","12542142","12656695","12656695","12656695","12656695","12780703","12780703","12780703","12780703","13092959","13092959","13092959","13092959","13111491","13111491","13111491","13111491","13241014","13241014","13241014","13241014","13530241","13530241","13530241","13530241","14040721","14040721","14040721","14040721","14175675","14175675","14175675","14175675","14390583","14390583","14390583","14390583","14952019","14952019","14952019","14952019","15487950","15487950","15487950","15487950","15785561","15785561","15785561","15785561","16020939","16020939","16020939","16020939","16853657","16853657","16853657","16853657","16863149","16863149","16863149","16863149","16913125","16913125","16913125","16913125","16935973","16935973","16935973","16935973","17086721","17086721","17086721","17086721","17437941","17437941","17437941","17437941","17675569","17675569","17675569","17675569","18075722","18075722","18075722","18075722","18346018","18346018","18346018","18346018","18628150","18628150","18628150","18628150","18706034","18706034","18706034","18706034","18754574","18754574","18754574","18754574","19061811","19061811","19061811","19061811","19251414","19251414","19251414","19251414","19272639","19272639","19272639","19272639","19498608","19498608","19498608","19498608","19517140","19517140","19517140","19517140","19702233","19702233","19702233","19702233","19745900","19745900","19745900","19745900","19966838","19966838","19966838","19966838","20037920","20037920","20037920","20037920","20192639","20192639","20192639","20192639","30293054","30293054","30293054","30293054","30629079","30629079","30629079","30629079","30733891","30733891","30733891","30733891","30756617","30756617","30756617","30756617","30826086","30826086","30826086","30826086","40006207","40006207","40006207","40006207","40179385","40179385","40179385","40179385","40262354","40262354","40262354","40262354","40531258","40531258","40531258","40531258","40550164","40550164","40550164","40550164","50466110","50466110","50466110","50466110","50492523","50492523","50492523","50492523","50682950","50682950","50682950","50682950","50694555","50694555","50694555","50694555","60148502","60148502","60148502","60148502","60238506","60238506","60238506","60238506","60338620","60338620","60338620","60338620","70059005","70059005","70059005","70059005","70572554","70572554","70572554","70572554","70636351","70636351","70636351","70636351","70863791","70863791","70863791","70863791","70995736","70995736","70995736","70995736","71382449","71382449","71382449","71382449","71429144","71429144","71429144","71429144","71705246","71705246","71705246","71705246","71936712","71936712","71936712","71936712","72111792","72111792","72111792","72111792","72164642","72164642","72164642")
timepoint <- c("1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3","4","1","2","3")
#timepoint <- c("early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late","late","early","early","late")
#annotation_row = data.frame(Individual = individual, Timepoint = timepoint)
annotation_row = data.frame(Timepoint = timepoint)
#annotation_col = data.frame(Individual = individual, Timepoint = timepoint)
dff <- read.csv("/Users/jacobluber/Desktop/pqe/tax_bc.txt",header=TRUE,row.names=1,sep=' ',check.names=FALSE)
dfb <- dff[-312,-312]
mat <- as.matrix(dfb)
#mat_breaks <- quantile_breaks(mat, n = 10)
rownames(annotation_col) <- colnames(mat)
#mat_colors <- list(Individual=viridis(78),Timepoint=brewer.pal(3, "Set3")[-1.])
mat_colors <- list(Timepoint=brewer.pal(4, "Set3"))
#mat_colors <- list(Individual=viridis(78),Timepoint=brewer.pal(4, "Set3"))
names(mat_colors$Timepoint) <- unique(timepoint)
#names(mat_colors$Individual) <- unique(individual)
pheatmap(
  mat               = mat,
  #color             = pal_material("red", alpha = 1)(length(mat_breaks) - 1),
  color             = magma(length(mat_breaks) - 1),
  breaks            = mat_breaks,
  border_color      = NA,
  show_colnames     = FALSE,
  show_rownames     = FALSE,
  annotation_row   = annotation_row,
  #annotation_col    = annotation_col,
  legend = TRUE,
  annotation_colors = mat_colors,
  annotation_legend = TRUE,
  drop_levels       = TRUE,
  fontsize          = 18,
  cluster_cols      = TRUE,
  cluster_row       = TRUE,
  main              = "Taxonomy (Marker Gene) Bray-Curtis β-Diversity Scores"
)

