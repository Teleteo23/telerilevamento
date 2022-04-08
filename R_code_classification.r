# Questo è il quinto script che useremo a lezione

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
