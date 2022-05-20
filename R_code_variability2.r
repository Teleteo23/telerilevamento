# Questo è il nono script che useremo a lezione

# Carico il pacchetto raster
library(raster)
# Carico il pacchetto RStoolbox
library(RStoolbox)
# Carico il pacchetto ggplot2
library(ggplot2) # for ggplot plotting
# Carico il pacchetto patchwork
library(patchwork) # multiframe with ggplot2 graphs
# Carico il pacchetto viridis
library(viridis)

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Windows 

# Utilizzo la funzione "brick" per importare l'immagine e la assegno ad un oggetto
# Utilizzo la funzione "brick" perché l'immagine è un RGB
sen <- brick("sentinel.png")
sen
# band1 = NIR
# band2 = red
# band3 = green

# Essendo un immagine RGB, faccio un plot dell'immagine utilizzando la funzione ggRGB
# Posso anche non mettere lo stretch perché la funzione ggRGB lo fa automaticamente
ggRGB(sen, 1, 2, 3)
dev.off()
# Metto il NIR nella componente green
ggRGB(sen, 2, 1, 3)

# Faccio un'analisi multivariata
sen_pca <- rasterPCA(sen)
# Chiamo l'oggetto per visualizzarne le informazioni
sen_pca

# Faccio un summary della PCA
summary(sen_pca$model)

# Plotto la PCA
plot(sen_pca$map)

# Preparo delle immagini che verranno plottate
pc1 <- sen_pca$map$PC1
pc2 <- sen_pca$map$PC2
pc3 <- sen_pca$map$PC3

# Faccio un plot con ggplot del PC1
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster
g1 <- ggplot() + 
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))

# Faccio un plot con ggplot del PC2
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster
g2 <- ggplot() + 
geom_raster(pc2, mapping=aes(x=x, y=y, fill=PC2))

# Faccio un plot con ggplot del PC3
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster
g3 <- ggplot() + 
geom_raster(pc3, mapping=aes(x=x, y=y, fill=PC3))

# Metto nella stessa finestra le tre immagini grazie al pacchetto patchwork
g1+g2+g3

# Calcolo la variabilità della PC1
# Per fare il calcolo utilizzo la funzione focal ed usando una finestra 3x3
sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd) # la funzione è basata sulla deviazione standard

# Faccio un plot con ggplot della PC1 con la legenda viridis
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis()

# Faccio un plot con ggplot della PC1 con la legenda cividis
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "cividis")

# Faccio un plot con ggplot della PC1 con la legenda inferno
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno")

# Fccio un plot, utilizzando patchwork, delle tre fasi dell'analisi dell'immagine
im1 <- ggRGB(sen, 2, 1, 3)
im2 <- ggplot() + 
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))
im3 <- ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno")
im1 + im2 + im3

# Calcolo la variabilità della PC1
# Per fare il calcolo utilizzo la funzione focal ed usando una finestra 5x5
sd5 <- focal(pc1, matrix(1/25, 5, 5), fun=sd) # la funzione è basata sulla deviazione standard

# Faccio un plot con ggplot della PC1 con la legenda inferno
im4 <- ggplot() + 
geom_raster(sd5, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno")
im4

# Fccio un plot, utilizzando patchwork, dell'immagine 3x3 e dell'immagine 5x5
im3 + im4

# Calcolo la variabilità della PC1
# Per fare il calcolo utilizzo la funzione focal ed usando una finestra 7x7
sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd) # la funzione è basata sulla deviazione standard

# Faccio un plot con ggplot della PC1 con la legenda inferno
im5 <- ggplot() + 
geom_raster(sd7, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno")
im5

# Fccio un plot, utilizzando patchwork, delle tre immagini (3x3, 5x5, 7x7)
im3 + im4 + im5
