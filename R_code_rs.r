# questo è il primo script che useremo a lezione

#Install.packages ("raster")
library(raster)

#Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Comando per Windows users

#Assegno ad un'oggetto la funzione per importare l'immagine
L2011 <- brick("p224r63_2011.grd")

#Chiamo l'oggetto (raster brick) per visualizzare le sue informazioni
L2011

#Plotto l'immagine
plot(L2011)

#Cambio i colori delle immagini per avere una migliore visualizzazione utilizzando la funzione "colorRampPalette"
#Assegno ad un vettore la scala di colori che ho scelto dicendo quanti passaggi di colore si devono fare (100)
#Assegno il tutto ad una variabile 
#Plotto di nuovo l'immagine richiamando anche la nuova scala di colori
cl <- colorRampPalette(c("black","grey","light grey")) (100) 
plot(L2011, col=cl)
