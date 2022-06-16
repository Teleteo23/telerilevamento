# Questo è il secondo script che useremo a lezione
# R_code_spectral_indices.r


# Carico e/o installo una serie di pacchetti che verranno utilizzati nello script
# Carico il pacchetto raster
library(raster)
# Carico il pacchetto RStoolbox che serve per calcolare l'indice della vegetazione
library(RStoolbox)
# Installo il pacchetto rasterdiv
#install.packages("rasterdiv")
# Carico il pacchetto rasterdiv che serve per calcolare gli indici di diversità su matrici numeriche
library(rasterdiv) # for the worldwide NDVI

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Comando per Windows users

# Assegno a degli oggetti le funzioni per importare le due immagini che verranno utilizzate
L1992 <- brick("defor1.jpg")
L2006 <- brick("defor2.jpg")

# Chiamo gli oggetti per visualizzare le loro informazioni
L1992
L2006

# Legenda delle mappe
# defor.1 = NIR
# defor.2 = rosso
# defor.3 = verde

# Costruisco un multiframe 
# Sopra metto l'immagine del 1992 (linear stretch)
# Sotto metto l'immagine del 2006 (linear stretch)
par(mfrow=c(2,1))
plotRGB(L1992, r=1, g=2, b=3, stretch="lin")
plotRGB(L2006, r=1, g=2, b=3, stretch="lin")
dev.off()

# Calcolo il difference vegetation index(DVI)(differenza tra le riflettanze nel NIR e nel rosso)
# Il calcolo lo faccio sia per il 1992 che per il 2006

# 1992
dvi1992 <- L1992$defor1.1 - L1992$defor1.2

# Chiamo l'oggetto per visualizzarne le informazioni
dvi1992

# Plotto il DVI del 1992
plot(dvi1992)

# Creo una nuova scala colori per miglirare la visualizzazione
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

# Plotto il DVI del 1992 con la nuova scala colori
plot(dvi1992, col=cl, main="DVI at 1992")

# 2006
dvi2006 <- L2006$defor2.1 - L2006$defor2.2

# Chiamo l'oggetto per visualizzarne le informazioni
dvi2006

# Plotto il DVI del 2006 con la nuova scala colori
plot(dvi2006, col=cl, main="DVI at 2006")

# Creo un multiframe con il DVI del 1992 e del 2006
par(mfrow=c(2,1))
plot(dvi1992, col=cl, main="DVI at 1992")
plot(dvi2006, col=cl, main="DVI at 2006")
dev.off()

# Calcolo la differenza del DVI nel tempo
difdvi <- dvi1992 - dvi2006

# Creo una nuova scala colori e plotto la differenza del DVI calcolata
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld, main="Differenza del DVI tra il 1992 e il 2006")

# Il range del DVI a 8 bit va da -255 a 255
# Il range del NDVI a 8 bit va da -1 a 1
# Il range del DVI a 16 bit va da -65535 a 65535
# Il range del NDVI a 16 bit va da -1 a 1
# E' meglio utilizzare l'NDVI perché è possibile fare un confronto tra immagini con risoluzione radiometrica differente

# Calcolo l'NDVI per il 1992
ndvi1992 <- (L1992[[1]] - L1992[[2]])/(L1992[[1]] + L1992[[2]])

# Chiamo l'oggetto per visualizzarne le informazioni
ndvi1992

# Plotto il NDVI del 1992
plot(ndvi1992, col=cl)

# Costruisco un multiframe 
# Sopra metto l'immagine del 1992 in RGB (linear stretch)
# Sotto metto l'NDVI del 1992
par(mfrow=c(2,1))
plotRGB(L1992, r=1, g=2, b=3, stretch="lin")
plot(ndvi1992, col=cl)
#dev.off()

# Calcolo l'NDVI per il 2006
ndvi2006 <- (L2006[[1]] - L2006[[2]])/(L2006[[1]] + L2006[[2]])

# Chiamo l'oggetto per visualizzarne le informazioni
ndvi2006

# Plotto il NDVI del 2006
plot(ndvi2006, col=cl)

# Costruisco un multiframe 
# Sotto metto l'NDVI del 1992
# Sotto metto l'NDVI del 2006
par(mfrow=c(2,1))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)
dev.off()

# Carico il pacchetto "RStoolbox" (vedi ad inizio script)

# Calcolo gl'indici spettrali dell'immagine del 1992 attraverso la funzione "spectralIndices"
si1992 <- spectralIndices(L1992, green=3, red=2, nir=1)

# Plotto l'si del 1992
plot(si1992, col=cl)

# Calcolo gl'indici spettrali dell'immagine del 2006 attraverso la funzione "spectralIndices"
si2006 <- spectralIndices(L2006, green=3, red=2, nir=1)

# Plotto l'si del 2006
plot(si2006, col=cl)

# Installo e/o carico il pacchetto "rasterdiv" (vedi ad inizio script)
# Plotto diversi indici spettrali
plot(copNDVI)
