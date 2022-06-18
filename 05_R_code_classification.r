# Questo è il quinto script che useremo a lezione
# R_code_classification.r

# Carico il pacchetto raster
library(raster)
# Carico il pacchetto RStoolbox
library(RStoolbox)

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Windows 

# Utilizzo la funzione "brick" per importare l'immagine e la assegno ad un oggetto
# Utilizzo la funzione "brick" perché l'immagine è un RGB
SO <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# Chiamo l'oggetto per visualizzarne le informazioni
SO

# Essendo un immagine RGB, faccio un plot RGB 
# Utilizzo sia lo stretch lineare che a istogramma
plotRGB(SO, 1, 2, 3, stretch="lin")
plotRGB(SO, 1, 2, 3, stretch="hist")
dev.off()

# Classifico l'immagine sulla base di come si sono disposti i pixel nello spazio delle tre bande a nostra disposizione
# Per farlo utilizzo la funzione "unsuperClass" indicando il numero di classi che voglio e la assegno ad un oggetto
SOc <- unsuperClass(SO, nClasses=3)
# Chiamo l'oggetto per visualizzarne le informazioni
SOc
# Plotto l'immagine classificata legandola alla mappa creata durante la classificazione
# Creo una nuova scala colori per miglirare la visualizzazione
cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(SOc$map, col=cl)
dev.off()

# Importo una nuova immagine
# Utilizzo la funzione "brick" per importare l'immagine e la assegno ad un oggetto
# Utilizzo la funzione "brick" perché l'immagine è un RGB
GC <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
# Chiamo l'oggetto per visualizzarne le informazioni
GC

# Essendo un immagine RGB, faccio un plot RGB 
plotRGB(GC, 1, 2, 3, stretch="lin")
plotRGB(GC, 1, 2, 3, stretch="hist")
dev.off()

# Classifico l'immagine sulla base di come si sono disposti i pixel nello spazio delle tre bande a nostra disposizione
# Per farlo utilizzo la funzione "unsuperClass" indicando il numero di classi che voglio e la assegno ad un oggetto
GCc2 <- unsuperClass(GC, nClasses=2)
# Chiamo l'oggetto per visualizzarne le informazioni
GCc2
# Plotto l'immagine classificata legandola alla mappa creata durante la classificazione
plot(GCc2$map)
dev.off()

# Faccio una nuova classificazione aumentando il numero di classi
# Se voglio mantenere le stesse classi ogni volta che faccio questa classificazione utilizzo il comando "set.seed()"
set.seed(1)
GCc4 <- unsuperClass(GC, nClasses=4)
# Chiamo l'oggetto per visualizzarne le informazioni
GCc4
# Plotto l'immagine classificata legandola alla mappa creata durante la classificazione
# Creo una nuova scala colori per miglirare la visualizzazione
cl2 <- colorRampPalette(c('yellow','red','blue','black'))(100)
plot(GCc4$map, col=cl2)
dev.off()

# Comparo la mappa classificata con quella originale
par(mfrow=c(2,1))
plot(GCc4$map, col=cl2)
plotRGB(GC, 1, 2, 3, stretch="hist")
dev.off()
