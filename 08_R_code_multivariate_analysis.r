# Questo è l'ottavo script che useremo a lezione
# R_code_multivariate_analysis.r

# Carico il pacchetto raster
library(raster)
# Carico il pacchetto RStoolbox
library(RStoolbox)
# Carico il pacchetto ggplot2
library(ggplot2) # for ggplot plotting
# Carico il pacchetto patchwork
library(patchwork) # multiframe with ggplot2 graphs

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Windows 

# Utilizzo la funzione "brick" per importare l'immagine e la assegno ad un oggetto
# Utilizzo la funzione "brick" perché l'immagine è un RGB
I11 <- brick("p224r63_2011_masked.grd")
# Chiamo l'oggetto per visualizzarne le informazioni
I11

# Faccio un plot dell'immagine
plot(I11)

# Prima di procedere con l'analisi multivariata devo fare un ricampionamento dell'immagine
# Per poterlo fare utilizzo la funzione aggregate 
I11res <- aggregate(I11, fact=10)

# Essendo immagini RGB, faccio un plot delle immagini utilizzando la funzione ggRGB e le metto una sopra all'altra
g1 <- ggRGB(I11, 4, 3, 2)
g2 <- ggRGB(I11res, 4, 3, 2)
g1/g2 # Thanks to patchwork!

# Faccio un nuovo ricampionamento poù "aggressivo"
I11res2 <- aggregate(I11, fact=100)

# Faccio un nuovo plot con le tre ummagini incolonnate
g1 <- ggRGB(I11, 4, 3, 2)
g2 <- ggRGB(I11res, 4, 3, 2)
g3 <- ggRGB(I11res2, 4, 3, 2)
g1/g2/g3

# PCA analysis
# Faccio la PCA dell'oggetto appena ricampionato
# Per farlo utilizzo la funzione rasterPCA e la assegno ad un ogggetto
I11respca <- rasterPCA(I11res)

# Faccio il riassunto dell'oggetto appena creato attraverso la funzione summary
summary(I11respca$model)

# Faccio il plot della PCA
plot(I11respca$map)

# Faccio una serie di ggplot utilizzando due diversi elementi della PCA e due mappe differenti dell'immagine ricampionata

g4 <- ggplot()+
geom_raster(I11respca$map, mapping =aes(x=x, y=y, fill=PC1))+
scale_fill_viridis(option = "inferno") +
ggtitle("PC1")

g5 <-ggplot()+
geom_raster(I11respca$map, mapping =aes(x=x, y=y, fill=PC7))+
scale_fill_viridis(option = "inferno") +
ggtitle("PC7")

g4+g5

g6 <-ggplot()+
geom_raster(I11res, mapping =aes(x=x, y=y, fill=B4_sre))+
scale_fill_viridis(option = "inferno") +
ggtitle("NIR")

g4+g6

g7 <- ggRGB(I11res, 2, 3, 4, stretch="hist")

g4+g7

# Faccio due plot RGB differenti di tre livelli della PCA
plotRGB(I11respca$map, 1, 2, 3, stretch="lin")
plotRGB(I11respca$map, 5, 6, 7, stretch="lin")

 
