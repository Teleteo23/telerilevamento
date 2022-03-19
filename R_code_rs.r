# questo è il primo script che useremo a lezione

# Install.packages ("raster")
library(raster)

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Comando per Windows users

# Assegno ad un'oggetto la funzione per importare l'immagine
L2011 <- brick("p224r63_2011.grd")

# Chiamo l'oggetto (raster brick) per visualizzare le sue informazioni
L2011

# Plotto l'immagine
plot(L2011)

# Cambio i colori delle immagini per avere una migliore visualizzazione utilizzando la funzione "colorRampPalette"
# Assegno ad un vettore la scala di colori che ho scelto dicendo quanti passaggi di colore si devono fare (100)
# Assegno il tutto ad una variabile 
# Plotto di nuovo l'immagine richiamando anche la nuova scala di colori
cl <- colorRampPalette(c("black","grey","light grey")) (100) 
plot(L2011, col=cl)

# Legenda delle mappe plottate
# Landsat ETM+
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino (NIR)
# b5 = infrarosso medio
# b6 = infrarosso termico
# b7 = infrarosso medio


# plotto una singola banda (banda del blu)
# metodo 1
# invididuo il nome della banda lanciando l'elemento "L2011"
# alla riga "names" vedo che nome ha il primo elemento (B1_sre)
# utilizzando il simbolo "$" lego assieme due oggetti
plot(L2011$B1_sre) # trinity
# metodo 2
# utilizzando la doppia parentesi quadra richiamo un elemento
plot(L2011[[1]]) # neo
# plotto trinity inserendo la scala colori "cl"
plot(L2011$B1_sre, col=cl)
# plotto trinity inserendo una scala di colori che va dal dark blue al blue al light blue
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100) 
plot(L2011$B1_sre, col=clb)
# esporto l'immagine in formato pdf e la salvo nella cartella lab
pdf("banda1.pdf")
plot(L2011$B1_sre, col=clb)
dev.off()
# esporto l'immagine in formato png e la salvo nella cartella lab
png("banda1.png")
plot(L2011$B1_sre, col=clb)
dev.off()

# plotto la banda del verde con una scala di colori che va dal dark green al green al light green
clg <- colorRampPalette(c("dark green", "green", "light green")) (100) 
plot(L2011$B2_sre, col=clg)


# creo un multiframe con all'interno la banda del blu e la banda del verde
# apro una finestra composta da una riga e due colonne
par(mfrow=c(1,2))
#inserisco i plot della banda 1 e della banda 2
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)
dev.off()

# esporto il multiframe in formato pdf e la salvo nella cartella lab
pdf("multiframe.pdf")
par(mfrow=c(1,2))
#inserisco i plot della banda 1 e della banda 2
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)
dev.off()

# creo un multiframe con all'interno la banda del blu e la banda del verde
# apro una finestra composta da due righe e una colonna
par(mfrow=c(2,1))
#inserisco i plot della banda 1 e della banda 2
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)
dev.off()

# esporto il multiframe in formato pdf e la salvo nella cartella lab
pdf("multiframe2.pdf")
par(mfrow=c(2,1))
#inserisco i plot della banda 1 e della banda 2
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)
dev.off()

# creo un multiframe con all'interno la banda del blu, del verde, del rosso e dell'infrarosso vicino
# apro una finestra composta da due righe e due colonne
par(mfrow=c(2,2))
#inserisco i plot della banda 1 e della banda 2
# blue
plot(L2011$B1_sre, col=clb)
# green 
plot(L2011$B2_sre, col=clg) 
# inserisco i plot della banda 3 e 4 inserendo anche le relative scale di colore
# red
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(L2011$B3_sre, col=clr) 
# NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(L2011$B4_sre, col=clnir) 

# esporto il multiframe in formato pdf e la salvo nella cartella lab
pdf("multiframe3.pdf")
par(mfrow=c(2,2))
#inserisco i plot delle 4 bande
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)
plot(L2011$B3_sre, col=clr)
plot(L2011$B4_sre, col=clnir)
dev.off()
