# Questo è il secondo script che useremo a lezione

# Carico e/o installo una serie di pacchetti che verranno utilizzati nello script
# Carico il pacchetto raster
library(raster)
# Carico il pacchetto RStoolbox che serve per calcolare l'indice della vegetazione
#library(RStoolbox)
# Installo il pacchetto rasterdiv
#install.packages("rasterdiv")
# Carico il pacchetto rasterdiv che serve per...
#library(rasterdiv) # for the worldwide NDVI
# Installo il pacchetto rasterVis
#install.packages("rasterVis")
# Carico il pacchetto rasterVis per...
#library(rasterVis)

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

# Calcolo il difference vegetation index (differenza tra le riflettanze nel NIR e ner rosso)
# Il calcolo lo faccio sia per il 1992 che per il 2006
# 1992
dvi1992 <- L1992$defor1.1 - L1992$defor1.2

# Chiamo l'oggetto per visualizzarne le informazioni
dvi1992

# Plotto il DVI del 1992
plot(dvi1992)

# Creo una nuova scala colori per miglirare la visualizzazione
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

plot(dvi1992, col=cl, main="DVI at 1992")

# 2006
dvi2006 <- L2006$defor2.1 - L2006$defor2.2

dvi2006

plot(dvi2006, col=cl, main="DVI at 2006")

par(mfrow=c(2,1))
plot(dvi1992, col=cl, main="DVI at 1992")
plot(dvi2006, col=cl, main="DVI at 2006")
dev.off()

# DVI nel tempo
difdvi <- dvi1992 - dvi2006

# dev.off()

cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld, main=" Differenza del DVI tra il 1992 e il 2006")

