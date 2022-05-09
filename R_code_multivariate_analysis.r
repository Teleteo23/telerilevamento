# Questo è l'ottavo script che useremo a lezione

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
