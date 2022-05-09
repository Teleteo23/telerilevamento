# Questo è il settimo script che useremo a lezione

# Carico il pacchetto raster
library(raster)
# Carico il pacchetto RStoolbox
library(RStoolbox)
# Carico il pacchetto ggplot2
library(ggplot2) # for ggplot plotting
# Carico il pacchetto patchwork
library(patchwork) # multiframe with ggplot2 graphs
# Installo il pacchetto viridis
#install.packages("viridis")
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
ggRGB(sen, 1, 2, 3, stretch="lin")
# Posso anche non mettere lo stretch perché la funzione ggRGB lo fa automaticamente
ggRGB(sen, 1, 2, 3)
dev.off()
# Metto il NIR nella componente green
ggRGB(sen, 2, 1, 3)

# Plotto i due grafici uno accanto all'altro
g1 <- ggRGB(sen, 1, 2, 3)
g2 <- ggRGB(sen, 2, 1, 3)
g1+g2 # Thanks to patchwork!

# Calcolo la variabilità dell'immagine
# La calcolo sul NIR (primo elemento)
nir <- sen[[1]]
# Per fare il calcolo utilizzo la funzione focal ed usando una finestra 3x3
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # la funzione è basata sulla deviazione standard

# Plotto l'immagine della variabilità
# Creo una nuova scala colori per miglirare la visualizzazione
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(sd3, col=clsd)
dev.off()

# Faccio un plot con ggplot
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer))

# Faccio un plot con la legenda viridis
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster...
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("Standard deviation by viridis package")

# Faccio un plot con la legenda cividis
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster...
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "cividis") +
ggtitle("Standard deviation by viridis package")

# Faccio un plot con la legenda magma
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster...
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")

# Calcolo la variabilità dell'immagine attraverso la funzione focal ed utilizzo una finestra 7x7
# La calcolo sul NIR (primo elemento)
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd) # la funzione è basata sulla deviazione standard

# Plotto l'immagine della variabilità utilizzando la nuova scala colori
plot(sd7, col=clsd)
dev.off()
