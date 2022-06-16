# R_code_complete.r - Telerilevamento Geo-Ecologico

#---------------------------------------------------

# Summary

# 1. Remote sensing first code
# 2. Specrtal indices
# 3.
# 4.
# 5.
# 6. 
# 7.
# 8. 
# 9.
# 10.
# 11.
# 12.

#---------------------------------------------------

# 1. Remote sensing first code
# Questo è il primo script che useremo a lezione


# Installo il pacchetto "raster", utile a lavorare su file in formato raster
# Install.packages ("raster")
# Richiamo il pacchetto
library(raster)

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Comando per Windows users

# Assegno ad un'oggetto la funzione "brick" per importare la prima immagine che verrà utilizzata
# Le "" vengono usate per richiamare qualcosa dall'esterno di R
L2011 <- brick("p224r63_2011.grd")

# Chiamo l'oggetto (raster brick) per visualizzare le sue informazioni
L2011
# Si aprono gli attributi di dato raster (dimensioni, sorgente, classe, ecc.)
# Il file caricato è un raster brick, ovvero una serie di bande sovrapposte

# Plotto l'immagine e visualizzo le bande di riflettanza
plot(L2011)

# Cambio i colori delle immagini per avere una migliore visualizzazione utilizzando la funzione "colorRampPalette"
# Assegno ad un vettore la scala di colori che ho scelto dicendo quanti passaggi di colore si devono fare (100)
# Assegno il tutto ad una variabile 
cl <- colorRampPalette(c("black","grey","light grey")) (100) 
# Plotto di nuovo l'immagine richiamando anche la nuova scala di colori
# "col" serve per definire i colori
plot(L2011, col=cl)
# Chiudo la finestra grafica in modo da partire da zero con la prossima immagine
dev.off()

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

# Plotto "Trinity" inserendo una scala di colori diversa che va dal dark blue al blue al light blue
# Assegno ad una variabile "clb" il vettore della scala di colori che ho scelto dicendo quanti passaggi di colore si devono fare (100)
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100) 
plot(L2011$B1_sre, col=clb)
dev.off()

# Esporto l'immagine in formato pdf e la salvo nella cartella lab
pdf("banda1.pdf")
plot(L2011$B1_sre, col=clb)
dev.off()

# Esporto l'immagine in formato png e la salvo nella cartella lab
png("banda1.png")
plot(L2011$B1_sre, col=clb)
dev.off()

# Plotto la banda del verde con una scala di colori che va dal dark green al green al light green
# Assegno ad una variabile "clg" il vettore della scala di colori che ho scelto dicendo quanti passaggi di colore si devono fare (100)
clg <- colorRampPalette(c("dark green", "green", "light green")) (100) 
plot(L2011$B2_sre, col=clg)

# Creo un multiframe "mf" composto da unna riga "row e due colonne" salvandole in un vettore "c"
# Se non facessimo questo una volta plottata la banda 2 ci cancella il plot precedente della banda 1
par(mfrow=c(1,2))
# Inserisco i plot della banda 1 (del blu) e della banda 2 (del verde)
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

# Creo un secondo multiframe con all'interno sempre la banda del blu e la banda del verde
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
# Inserisco i plot delle 4 bande
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
dev.off()

# Esporto il multiframe in formato pdf e la salvo nella cartella lab
pdf("multiframe3.pdf")
par(mfrow=c(2,2))
# Inserisco i plot delle 4 bande
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)
plot(L2011$B3_sre, col=clr)
plot(L2011$B4_sre, col=clnir)
dev.off()

# Schema RGB: ogni schermo utilizza il rosso, il verde e il blu, che mischiandosi generano tutti gli altri colori per generare le immagini con colori "naturali"
# Nello schema RGB posso utilizzare tre bande per volta
# Plotto lo schema RGB
# Sovrappongo la banda del rosso(3), del verde(2) e del blu(1), con questo schema possiamo visualizzare le immagini con colori naturali
plotRGB(L2011, r=3, g=2, b=1, stretch="lin")
# Con "stretch" prendiamo le bande e le allunghiamo in modo da non visualizzare meglio una banda a discapito di un'altra, in modo da schiacciare i valori
# Con questo formato di colori risulta difficile distinguere forme da altre
# Non mettiamo "B1_sre" perché la funzione è progettata per usare direttamente il numero del layer invece del nome della banda, quindi mettiamo direttamente in che punto del nostro pacchetto è la banda corrispondente

# Voglio utilizzare la danda NIR (per avere una risoluzione infrarossa)
# Aumento di 1 i valori di r, g e b, escludendo la banda del blu
plotRGB(L2011, r=4, g=3, b=2, stretch="lin")
# Siccome nella componente "red" abbiamo montato l'infrarosso, la vegetazione ha altissima riflettanza in questa banda (in questo modo la vegetazione diventa rossa)

# Cambio di nuovo la combinazione r g b mettendo l'infrarosso  nel "g" e otterrò un immagine "fluorescente"
plotRGB(L2011, r=3, g=4, b=2, stretch="lin")
# Si vedono pattern che prima non erano visibili all'interno della foresta, il viola invece rappresenta sempre suolo nudo visualizzando bene la componente agricola

# Visualizzo meglio le zone di suolo nudo inserendo la banda del NIR nel "b"
plotRGB(L2011, r=3, g=2, b=4, stretch="lin")

# Esiste un altro tipo di stretch che è l'"histogram", invece di fare il profilo lineare, questa funzione allunga ancora di più la banda, ha una potenza media più alta
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

#---------------------------------------------------

# 2. Specrtal indices
# Questo è il secondo script che useremo a lezione



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

#---------------------------------------------------



#---------------------------------------------------



#---------------------------------------------------




#---------------------------------------------------




#---------------------------------------------------




#---------------------------------------------------




#---------------------------------------------------




#---------------------------------------------------





#---------------------------------------------------





#---------------------------------------------------










