# questo è il primo script che useremo a lezione

# Install.packages ("raster")
library(raster)

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Comando per Windows users

# Assegno ad un'oggetto la funzione per importare la prima immagine che verrà utilizzata
L2011 <- brick("p224r63_2011.grd")

# Chiamo l'oggetto (raster brick) per visualizzare le sue informazioni
L2011

# Plotto l'immagine
plot(L2011)

# Cambio i colori delle immagini per avere una migliore visualizzazione utilizzando la funzione "colorRampPalette"
# Assegno ad un vettore la scala di colori che ho scelto dicendo quanti passaggi di colore si devono fare (100)
# Assegno il tutto ad una variabile 
cl <- colorRampPalette(c("black","grey","light grey")) (100) 
# Plotto di nuovo l'immagine richiamando anche la nuova scala di colori
plot(L2011, col=cl)

# Legenda delle mappe plottate
# Landsat ETM+
# B1 = blu
# B2 = verde
# B3 = rosso
# B4 = infrarosso vicino (NIR)
# B5 = infrarosso medio
# B6 = infrarosso termico
# B7 = infrarosso medio

# Plotto una singola banda (banda del blu)

# Metodo 1
# Invididuo il nome della banda lanciando l'elemento "L2011"
L2011
# Alla riga "names" vedo che nome ha il primo elemento (B1_sre)
# Utilizzando il simbolo "$" lego assieme due oggetti
plot(L2011$B1_sre) # "Trinity"

# Metodo 2
# Utilizzando la doppia parentesi quadra richiamo un elemento (in questo caso il primo)
plot(L2011[[1]]) # "Neo"
# Plotto "Trinity" inserendo la scala colori "cl"
plot(L2011$B1_sre, col=cl)

# Plotto trinity inserendo una scala di colori diversa che va dal dark blue al blue al light blue
# Assegno ad una variabile "clb" il vettore della scala di colori che ho scelto dicendo quanti passaggi di colore si devono fare (100)
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100) 
plot(L2011$B1_sre, col=clb)

# Esporto l'immagine in formato pdf e la salvo nella cartella lab
pdf("banda1.pdf")
plot(L2011$B1_sre, col=clb)
dev.off()

# Esporto l'immagine in formato png e la salvo nella cartella lab
png("banda1.png")
plot(L2011$B1_sre, col=clb)
dev.off()

# Plotto la banda del verde con una scala di colori che va dal dark green al green al light green
# Assegno ad una variabile "clG" il vettore della scala di colori che ho scelto dicendo quanti passaggi di colore si devono fare (100)
clg <- colorRampPalette(c("dark green", "green", "light green")) (100) 
plot(L2011$B2_sre, col=clg)

# Creo un multiframe con all'interno la banda del blu e la banda del verde
# Apro una finestra composta da una riga e due colonne
par(mfrow=c(1,2))
# Inserisco i plot della banda 1 e della banda 2
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)
dev.off()

# Esporto il multiframe in formato pdf e la salvo nella cartella lab
pdf("multiframe.pdf")
par(mfrow=c(1,2))
# Inserisco i plot della banda 1 e della banda 2
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)
dev.off()

# Creo un secondo multiframe con all'interno la banda del blu e la banda del verde
# Apro una finestra composta da due righe e una colonna
par(mfrow=c(2,1))
# Inserisco i plot della banda 1 e della banda 2
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)
dev.off()

# Esporto il multiframe in formato pdf e la salvo nella cartella lab
pdf("multiframe2.pdf")
par(mfrow=c(2,1))
# Inserisco i plot della banda 1 e della banda 2
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)
dev.off()

# Creo un terzo multiframe con all'interno la banda del blu, del verde, del rosso e dell'infrarosso vicino
# Apro una finestra composta da due righe e due colonne
par(mfrow=c(2,2))
# Inserisco i plot della banda 1 e della banda 2
# Blue
plot(L2011$B1_sre, col=clb)
# Green 
plot(L2011$B2_sre, col=clg) 
# Inserisco i plot della banda 3 e 4 inserendo anche le relative scale di colore
# Red
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(L2011$B3_sre, col=clr) 
# NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(L2011$B4_sre, col=clnir) 

# Esporto il multiframe in formato pdf e la salvo nella cartella lab
pdf("multiframe3.pdf")
par(mfrow=c(2,2))
# Inserisco i plot delle 4 bande
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)
plot(L2011$B3_sre, col=clr)
plot(L2011$B4_sre, col=clnir)
dev.off()

# Plotto lo schema RGB
# Sovrappongo la banda del rosso, del verde e del blu 
plotRGB(L2011, r=3, g=2, b=1, stretch="lin")
# Voglio utilizzare la danda NIR (per avere una risoluzione infrarossa)
# Aumento di 1 i valori di r, g e b, escludendo la banda del blu
plotRGB(L2011, r=4, g=3, b=2, stretch="lin")
# Cambio di nuovo la combinazione r g b mettendo l'infrarosso  nel "g" e otterrò un immagine fluorescente
plotRGB(L2011, r=3, g=4, b=2, stretch="lin")
# Visualizzo meglio le zone di suolo nudo inserendo la banda del NIR nel "b"
plotRGB(L2011, r=3, g=2, b=4, stretch="lin")

#
plotRGB(L2011, r=3, g=4, b=2, stretch="hist")

# Costruisco un multiframe 
# Sopra metto la scala del visibile RGB (linear stretch)
# Sotto metto la scala del RGB con all'interno il NIR (histogram streatch)
par(mfrow=c(2,1))
plotRGB(L2011, r=3, g=2, b=1, stretch="lin")
plotRGB(L2011, r=3, g=4, b=2, stretch="hist")

# Carico l'immagine del 1988
L1988 <- brick("p224r63_1988.grd")

# Chiamo l'oggetto per visualizzare le sue informazioni
L1988

# Plotto l'immagine
plot(L1988)

# Costruisco un multiframe 
# Sopra metto l'immagine del 1988 con la scala.... (linear stretch)
# Sotto metto l'immagine del 2011 con la scala....(linear stretch)
par(mfrow=c(2,1))
plotRGB(L1988, r=4, g=3, b=2, stretch="lin")
plotRGB(L2011, r=4, g=3, b=2, stretch="lin")
