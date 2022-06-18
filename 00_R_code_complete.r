# R_code_complete.r - Telerilevamento Geo-Ecologico

#---------------------------------------------------

# Summary

# 01. Remote sensing first code
# 02. Specrtal indices
# 03. Time series greenland
# 04. Time series lockdown
# 05. Classification
# 06. Land cover
# 07. Variability
# 08. Multivariate analysis
# 09. Variability 2
# 10. LiDAR
# 11. SDM
# 12. Colorist
# 13. Functions


#---------------------------------------------------

# 01. Remote sensing first code
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

# 02. Specrtal indices
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

# 03.Time series greenland
# Questo è il terzo script che useremo a lezione

# Time series analysis of Greenland increase LST data (temperature)

# Carico e/o installo una serie di pacchetti che verranno utilizzati nello script
# Carico il pacchetto raster
library(raster)
# Carico il pacchetto rgdal
library(rgdal)
# Installo il pacchetto rasterVis
#install.packages("rasterVis")
# Carico il pacchetto rasterVis che implementa metodi per una maggiore visualizzazione e interazione dei dati raster
library(rasterVis)

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/greenland") # Windows 

# Assegno a degli oggetti la funzione "raster" necessaria per importare le immagini che verranno utilizzate
Lst_2000 <- raster("lst_2000.tif")
Lst_2005 <- raster("lst_2005.tif")
Lst_2010 <- raster("lst_2010.tif")
Lst_2015 <- raster("lst_2015.tif")

# Chiamo gli oggetti per visualizzare le loro informazioni
Lst_2000
Lst_2005
Lst_2010
Lst_2015

# Plotto l'immagine del 2000
plot(Lst_2000)
dev.off()

# Costruisco un multiframe con le 4 immagini
# Creo una nuova scala colori per miglirare la visualizzazione
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
par(mfrow=c(2,2))
plot(Lst_2000, col=cl)
plot(Lst_2005, col=cl)
plot(Lst_2010, col=cl)
plot(Lst_2015, col=cl)
dev.off()

# Metodo per importare contemporaneamente tutte le immagini 
# Creo una lista di files utilizzando la funzione "list.files" e la assegno ad un oggetto
# "pattern" ricerca all'interno della cartella di lavoro tutti i file con all'interno del nome una parte comune (in questo caso "lst")
rlist <- list.files(pattern="lst")
# Visualizzo i files all'interno della mia lista
rlist

# Applico la funzione "raster" alla lista utilizzando un'altra funzione chiamata "lapply" e la assegno ad un oggetto
import <- lapply(rlist,raster)
# Visualizzo i files importati
import

# Creo un singolo file, unendo le 4 immagini, utilizzando la funzione "stack" e lo assegno ad un oggetto
TGr <- stack(import)
# Visualizzo il nuovo file
TGr

# Plotto il nuovo file
plot(TGr, col=cl)
dev.off()

# Plotto una singola immagine
plot(TGr[[3]], col=cl)
dev.off()

# Plotto TGr in RGB utilizzando diverse sovrapposizioni
plotRGB(TGr, 1, 2, 3, stretch="Lin") 
plotRGB(TGr, 2, 3, 4, stretch="Lin") 
plotRGB(TGr, 4, 3, 2, stretch="Lin") 




#---------------------------------------------------

# 04. Time series lockdown
# Questo è il quarto script che useremo a lezione


# R code for chemical cycling study
# time series of NO2 change in Europe during the lockdown
# https://www.esa.int/Applications/Observing_the_Earth/Copernicus/Sentinel-5P/Coronavirus_lockdown_leading_to_drop_in_pollution_across_Europe
# https://acp.copernicus.org/preprints/acp-2020-995/acp-2020-995.pdf

# Carico il pacchetto raster
library(raster)

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/EN") # Windows 

# Utilizzo la funzione "raster" per importare la prima immagine della time series e la assegno ad un oggetto
EN01 <- raster("EN_0001.png") # 29/01/20
# Chiamo l'oggetto per visualizzarne le informazioni
EN01

# Plotto i valori di NO2 di Gennaio con una scala colori che ne migliora la visualizzazione
cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(EN01, col=cl)
dev.off()

# Importo l'immagine dei valori di NO2 di fine Marzo (13° dato) e la plotto
EN13 <- raster("EN_0013.png")
plot(EN13, col=cl)
dev.off()

# Per caricare e visualizzare tutti i files della cartella in maniera rapida utilizzo il seguente metodo:
# Creo una lista di files utilizzando la funzione "list.files" e la assegno ad un oggetto
# "pattern" ricerca all'interno della cartella di lavoro tutti i file con all'interno del nome una parte comune
rlist <- list.files(pattern="EN")
# Visualizzo i files all'interno della mia lista
rlist

# Applico la funzione "raster" alla lista utilizzando un'altra funzione chiamata "lapply" e la assegno ad un oggetto
rimp <- lapply(rlist,raster)
# Visualizzo i files importati
rimp

# Creo un singolo file, unendo le 13 immagini, utilizzando la funzione "stack" e lo assegno ad un oggetto
ENs <- stack(rimp)
# Visualizzo il nuovo file
ENs

# Plotto il nuovo file
# Creo una nuova scala colori per miglirare la visualizzazione
cls <- colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(ENs, col=cls)
dev.off()

# Voglio plottare la prima e l'ultima immagine insieme
# Per farlo posso usare diversi metodi
# Metodo 1
# Costruisco un multiframe chiamando gli oggetti che ho creato all'inizio dello script
par(mfrow=c(2,1))
plot(EN01, col=cl)
plot(EN13, col=cl)
dev.off()

# Metodo 2
# Plotto le immagini dallo stack chiamando gli oggetti che mi interessano
par(mfrow=c(2,1))
plot(ENs$EN_0001, col=cl)
plot(ENs$EN_0013, col=cl)
dev.off()

# Metodo 3
# Facico uno stack con solo i due elementi che mi servono e li plotto
EN113 <- stack(ENs[[1]], ENs[[13]])
plot(EN113, col=cl)
dev.off()

# Faccio la differenza tra il primo e il tredicesimo elemento
# In questo modo vedo la variazione di NO2 durante il lockdown
difEN <- ENs[[1]] - ENs[[13]]
# Creo una nuova scala colori per miglirare la visualizzazione
cldif <- colorRampPalette(c('blue','white','red'))(100) 
# Plotto la differenza appena calcolata
plot(difEN, col=cldif)
# Il rosso è Gennaio e il blu è Marzo
dev.off()

# Faccio un plot RGB con tre immagnini unite assieme (Gennaio, Febbraio, Marzo)
plotRGB(ENs, r=1, g=7, b=13, stretch="lin")
plotRGB(ENs, r=1, g=7, b=13, stretch="hist")
dev.off()

# Attraverso la funzione "source" richiamo un codice esterno al mio script
source("R_inputcode.r")


#---------------------------------------------------

# 05. Classification
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




#---------------------------------------------------

# 06. Land cover
# Questo è il sesto script che useremo a lezione


# Carico il pacchetto raster
library(raster)
# Carico il pacchetto RStoolbox
library(RStoolbox)
# Installo il pacchetto ggplot2
#install.packages("ggplot2")
# Carico il pacchetto ggplot2
library(ggplot2)
# Carico il pacchetto gridExtra
library(gridExtra)
# Installo il pacchetto patchwork
#install.packages("patchwork")
# Carico il pacchetto patchwork
library(patchwork)

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Windows 

# Utilizzo la funzione "brick" per importare l'immagine e la assegno ad un oggetto
# Utilizzo la funzione "brick" perché l'immagine è un RGB
L92 <- brick("defor1.jpg")
# Chiamo l'oggetto per visualizzarne le informazioni
L92

# Essendo un immagine RGB, faccio un plot RGB
# Faccio il plot con le due tipologie di stretch
# NIR 1, RED 2, GREEN 3
plotRGB(L92, 1, 2, 3, stretch="lin")
plotRGB(L92, 1, 2, 3, stretch="hist")
dev.off()

# Utilizzo la funzione "brick" per importare l'immagine e la assegno ad un oggetto
# Utilizzo la funzione "brick" perché l'immagine è un RGB
L06 <- brick("defor2.jpg")
# Chiamo l'oggetto per visualizzarne le informazioni
L06

# Plotto entrambe le immagini in un'unica finestra
# Essendo un immagine RGB, faccio un plot RGB 
# NIR 1, RED 2, GREEN 3
par(mfrow=c(2,1))
plotRGB(L92, 1, 2, 3, stretch="lin")
plotRGB(L06, 1, 2, 3, stretch="lin")
dev.off()

# Faccio un plot RGB, utilizzando ggplot2, delle due immagini 
ggRGB(L92, 1, 2, 3, stretch="lin")
ggRGB(L06, 1, 2, 3, stretch="lin")
dev.off()

# Creo un multiframe utilizzando ggplot2 e patchwork
# Assegno a due variabili i plot ggRGB delle due immagini
p1 <- ggRGB(L92, 1, 2, 3, stretch="lin")
p2 <- ggRGB(L06, 1, 2, 3, stretch="lin")
# Visualizzo le due immagini assieme sulla stessa riga
p1+p2
dev.off()
# Visualizzo le due immagini assieme sulla stessa colonna
p1/p2
dev.off()

# Classifico l'immagine L92 sulla base di come si sono disposti i pixel nello spazio delle tre bande a nostra disposizione
# Per farlo utilizzo la funzione "unsuperClass" indicando il numero di classi che voglio e la assegno ad un oggetto
L92c <- unsuperClass(L92, nClasses=2)
# Chiamo l'oggetto per visualizzarne le informazioni
L92c

# Plotto l'immagine classificata legandola alla mappa creata durante la classificazione
# Creo una nuova scala colori per miglirare la visualizzazione
cl <- colorRampPalette(c('yellow','red'))(100)
plot(L92c$map, col=cl)
dev.off()
# La classe 1 è classificata come foresta, mentre la parte agricola più l'acqua è classificata come classe 2

# Classifico l'immagine L06 sulla base di come si sono disposti i pixel nello spazio delle tre bande a nostra disposizione
# Per farlo utilizzo la funzione "unsuperClass" indicando il numero di classi che voglio e la assegno ad un oggetto
L06c <- unsuperClass(L06, nClasses=2)
# Chiamo l'oggetto per visualizzarne le informazioni
L06c

# Plotto l'immagine classificata legandola alla mappa creata durante la classificazione
plot(L06c$map, col=cl)
dev.off()
# Anche in questo caso la classe 1 è classificata come foresta, mentre la parte agricola più l'acqua 

# Calcolo la frequenza di pixel appartenenti rispettivamente alla classe della foresta (classe 1) e alla classe agricolo+acqua (classe2)
freq(L92c$map)
# Pixels classe 1: 307021
# Pixels classe 2: 34271

# Pixels totali
tot92 <- 307021+34271
tot92
# Proporzione della foresta
prop_forest92 <- 307021/tot92
prop_forest92
# Percentuale della foresta
perc_forest92 <- 307021*100/tot92
perc_forest92
# Percentuale della porzione agricola
perc_agr92 <- 34271*100/tot92
perc_agr92
# Percentuale della foresta: 89.95845
# Percentuale della porzione agricola: 10.04155


# Calcolo la frequenza di pixel appartenenti rispettivamente alla classe della foresta (classe 1) e alla classe agricolo+acqua (classe2)
freq(L06c$map)
# Pixels classe 1: 178699
# Pixels classe 2: 164027

# Pixels totali
tot06 <- 178699+164027
tot06
# Proporzione della foresta
prop_forest06 <- 178699/tot06
prop_forest06
# Percentuale della foresta
perc_forest06 <- 178699*100/tot06
perc_forest06
# Percentuale della porzione agricola
perc_agr06 <- 164027*100/tot06
perc_agr06
# Percentuale della foresta: 52.14049
# Percentuale della porzione agricola: 47.85951

# DATI FINALI:
# Percentuale della foresta 1992: 89.95845
# Percentuale della porzione agricola 1992: 10.04155
# Percentuale della foresta 2006: 52.14049
# Percentuale della porzione agricola 2006: 47.85951

# Creo un data frame con tre colonne
# La prima colonna sarà la classe, la seconda i valori percentuali del 1992 e la terza i valori percentuali del 2006
class <- c("Forest","Agriculture")
percent_1992 <- c(89.95, 10.05)
percent_2006 <- c(52.15, 47.85)
multitemporal <- data.frame(class, percent_1992, percent_2006)
multitemporal
View(multitemporal)

# Plotto il data frame creando un immagine a istogrammi
PL1 <- ggplot(multitemporal, aes(x=class, y=percent_1992, color=class)) + geom_bar(stat="identity", fill="black")
PL2 <- ggplot(multitemporal, aes(x=class, y=percent_2006, color=class)) + geom_bar(stat="identity", fill="white")
grid.arrange(PL1, PL2, nrow=1)

# Salvo in pdf il data frame
pdf("data_frame")
grid.arrange(PL1, PL2, nrow=1)
dev.off()


#---------------------------------------------------

# 07. Variability
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
# Per fare il calcolo della variabilità utilizzo la funzione focal ed utilizzo una finestra di 3x3 pixels
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

# A seguire, è stato eseguito lo stesso plot con tre legende differenti estratte dal pacchetto viridis

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



#---------------------------------------------------
# 08. Multivariate analysis
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

# PCA analysis
# Faccio la PCA dell'oggetto appena ricampionato
# Per farlo utilizzo la funzione rasterPCA e la assegno ad un ogggetto
I11respca <- rasterPCA(I11res)

# Faccio il riassunto dell'oggetto appena creato attraverso la funzione summary
summary(I11respca$model)

# Faccio il plot della PCA
plot(I11respca$map)

# Faccio una serie di ggplot utilizzando due diversi elementi della PCA e due mappe differenti dell'immagine ricampionata

g4 <- ggplot()+
geom_raster(I11respca$map, mapping =aes(x=x, y=y, fill=PC1))+
scale_fill_viridis(option = "inferno") +
ggtitle("PC1")

g5 <-ggplot()+
geom_raster(I11respca$map, mapping =aes(x=x, y=y, fill=PC7))+
scale_fill_viridis(option = "inferno") +
ggtitle("PC7")

g4+g5

g6 <-ggplot()+
geom_raster(I11res, mapping =aes(x=x, y=y, fill=B4_sre))+
scale_fill_viridis(option = "inferno") +
ggtitle("NIR")

g4+g6

g7 <- ggRGB(I11res, 2, 3, 4, stretch="hist")

g4+g7

# Faccio due plot RGB differenti di tre livelli della PCA
plotRGB(I11respca$map, 1, 2, 3, stretch="lin")
plotRGB(I11respca$map, 5, 6, 7, stretch="lin")

 




#---------------------------------------------------

# 09. Variability 2
# Questo è il nono script che useremo a lezione


# Carico il pacchetto raster
library(raster)
# Carico il pacchetto RStoolbox
library(RStoolbox)
# Carico il pacchetto ggplot2
library(ggplot2) # for ggplot plotting
# Carico il pacchetto patchwork
library(patchwork) # multiframe with ggplot2 graphs
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
# Posso anche non mettere lo stretch perché la funzione ggRGB lo fa automaticamente
ggRGB(sen, 1, 2, 3)
dev.off()
# Metto il NIR nella componente green
ggRGB(sen, 2, 1, 3)

# Faccio un'analisi multivariata
sen_pca <- rasterPCA(sen)
# Chiamo l'oggetto per visualizzarne le informazioni
sen_pca

# Faccio un summary della PCA
summary(sen_pca$model)

# Plotto la PCA
plot(sen_pca$map)

# Preparo delle immagini che verranno plottate
pc1 <- sen_pca$map$PC1
pc2 <- sen_pca$map$PC2
pc3 <- sen_pca$map$PC3

# Faccio un plot con ggplot del PC1
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster
g1 <- ggplot() + 
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))

# Faccio un plot con ggplot del PC2
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster
g2 <- ggplot() + 
geom_raster(pc2, mapping=aes(x=x, y=y, fill=PC2))

# Faccio un plot con ggplot del PC3
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster
g3 <- ggplot() + 
geom_raster(pc3, mapping=aes(x=x, y=y, fill=PC3))

# Metto nella stessa finestra le tre immagini grazie al pacchetto patchwork
g1+g2+g3

# Calcolo la variabilità della PC1
# Per fare il calcolo utilizzo la funzione focal ed usando una finestra 3x3
sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd) # la funzione è basata sulla deviazione standard

# Faccio un plot con ggplot della PC1 con la legenda viridis
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis()

# Faccio un plot con ggplot della PC1 con la legenda cividis
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "cividis")

# Faccio un plot con ggplot della PC1 con la legenda inferno
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno")

# Fccio un plot, utilizzando patchwork, delle tre fasi dell'analisi dell'immagine
im1 <- ggRGB(sen, 2, 1, 3)
im2 <- ggplot() + 
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))
im3 <- ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno")
im1 + im2 + im3

# Calcolo la variabilità della PC1
# Per fare il calcolo utilizzo la funzione focal ed usando una finestra 5x5
sd5 <- focal(pc1, matrix(1/25, 5, 5), fun=sd) # la funzione è basata sulla deviazione standard

# Faccio un plot con ggplot della PC1 con la legenda inferno
im4 <- ggplot() + 
geom_raster(sd5, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno")
im4

# Fccio un plot, utilizzando patchwork, dell'immagine 3x3 e dell'immagine 5x5
im3 + im4

# Calcolo la variabilità della PC1
# Per fare il calcolo utilizzo la funzione focal ed usando una finestra 7x7
sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd) # la funzione è basata sulla deviazione standard

# Faccio un plot con ggplot della PC1 con la legenda inferno
im5 <- ggplot() + 
geom_raster(sd7, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno")
im5

# Fccio un plot, utilizzando patchwork, delle tre immagini (3x3, 5x5, 7x7)
im3 + im4 + im5



#---------------------------------------------------

# 10. LiDAR
# Questo è il decimo script che useremo a lezione


# Carico il pacchetto raster
library(raster) #"Geographic Data Analysis and Modeling"
# Carico il pacchetto RStoolbox
library(RStoolbox)
# Carico il pacchetto rgdal
library(rgdal) #"Geospatial Data Abstraction Library"
# Carico il pacchetto ggplot2
library(ggplot2) # for ggplot plotting
# Carico il pacchetto viridis
library(viridis)
# Installo il pacchetto lidr
#install.packages("lidR")
# Carico il pacchetto lidr
library(lidR)

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Windows 

# Utilizzo la funzione "raster" per importare il dsm 2013
dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
# Chiamo l'oggetto per visualizzarne le informazioni
dsm_2013

# Utilizzo la funzione "raster" per importare il dtm 2013
dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")
# Chiamo l'oggetto per visualizzarne le informazioni
dtm_2013

# Faccio un plot del dtm 2013
plot(dtm_2013)

# Faccio il chm del 2013 come differenza del dsm e del dtm
chm_2013 <- dsm_2013-dtm_2013
# Chiamo l'oggetto per visualizzarne le informazioni
chm_2013 

# Faccio il plot del chm 2013 con la legenda viridis
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster
ggplot() + 
geom_raster(chm_2013, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM 2013 San Genesio/Jenesien")

# Utilizzo la funzione "raster" per importare il dsm 2004
dsm_2004 <- raster("2004Elevation_DigitalElevationModel-2.5m.tif")
# Chiamo l'oggetto per visualizzarne le informazioni
dsm_2004

# Utilizzo la funzione "raster" per importare il dtm 2004
dtm_2004 <- raster("2004Elevation_DigitalTerrainModel-2.5m.tif")
# Chiamo l'oggetto per visualizzarne le informazioni
dtm_2004

# Faccio il chm del 2004 come differenza del dsm e del dtm
chm_2004 <- dsm_2004 - dtm_2004
# Chiamo l'oggetto per visualizzarne le informazioni
chm_2004

# Faccio il plot del chm 2004 con la legenda viridis
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster
ggplot() + 
geom_raster(chm_2004, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM 2004 San Genesio/Jenesien")

# Cambio la risoluzione del chm 2013 per poter fare la differenza tra i due chm
# Lo faccio attraverso il ricampionamento dell'immagine
chm_2013_r <- resample(chm_2013, chm_2004)

# Confronto i due chm 
diffchm <- chm_2013_r - chm_2004
# Chiamo l'oggetto per visualizzarne le informazioni
diffchm

# Faccio il plot del diffchm con la legenda viridis
# Apro un ggplot vuoto e gli aggiungo la funzione geom_raster
ggplot() + 
geom_raster(diffchm, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM difference San Genesio/Jenesien")

# Utilizzo la funzione "readLAS" per importare il point_cloud
point_cloud <- readLAS("point_cloud.laz")

# Faccio un plot del point cloud
plot(point_cloud)




#---------------------------------------------------

# 11. SDM
# Questo è l'undicesimo script che useremo a lezione

# Installo il pacchetto sdm
# install.packages("sdm")

# Carico il pacchetto sdm
library(sdm)
# Carico il pacchetto raster
library(raster) # predictors
# Carico il pacchetto rgdal
library(rgdal) # species

# In questo caso non faccio il settaggio della working directory perché useremo un file di sistema
# Utilizzo la funzione "system.file" per leggere il file di sistema
file <- system.file("external/species.shp", package="sdm") 
# Chiamo l'oggetto per visualizzarne le informazioni
file
# Utilizzo la funzione "shapefile" per creare uno shapefile
species <- shapefile(file)
# Chiamo l'oggetto per visualizzarne le informazioni
species

# Faccio un plot della specie
plot(species, pch=19)

# Assegno ad un oggetto le occurence della specie e lo chiamo per visualizzarlo
occ <- species$Occurrence
occ

# Visualizzo solo i punti in cui l'occorrenza è uguale a 1
plot(species[occ == 1,],col='blue',pch=19)
# Aggiungo dei punti al grafico precedente attraverso la funzione "points"
points(species[occ == 0,],col='red',pch=19)

# Utilizzo la funzione "path" per caricare il file dei predittori
path <- system.file("external", package="sdm")
# Faccio una lista di questi predittori
lst <- list.files(path=path,pattern='asc$',full.names = T)
# Visualizzo la lista
lst

# Faccio lo stack di questa lista
preds <- stack(lst)
# Visualizzo lo stack
preds 

# Faccio il plot dei predittori
# Creo una nuova scala colori per miglirare la visualizzazione
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# Assegno dei nomi più corti ai predittori
elev <- preds$elevation
prec <- preds$precipitation
temp <- preds$temperature
vege <- preds$vegetation

# Faccio un plot per ognuno dei predittori sovrapposti allo stack
plot(elev, col=cl)
points(species[occ == 1,], pch=19)

plot(prec, col=cl)
points(species[occ == 1,], pch=19)

plot(temp, col=cl)
points(species[occ == 1,], pch=19)

plot(vege, col=cl)
points(species[occ == 1,], pch=19)

# Inizio a costruire il mio modello

# Utilizzo la funzione "sdmData" che dichiara i dati
datasdm <- sdmData(train=species, predictors=preds)
# Chiamo l'oggetto per visualizzarne le informazioni
datasdm

# Utilizzo la funzione "sdm" 
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")
# Chiamo l'oggetto per visualizzarne le informazioni
m1

# Utilizzo la funzione "predict" per fare la previosione della mappa finale
p1 <- predict(m1, newdata=preds) 
# Chiamo l'oggetto per visualizzarne le informazioni
p1

# Faccio il plot di questa previsione aggiungendo anche i punti della distribuzione della specie
plot(p1, col=cl)
points(species[occ == 1,], pch=19)

# Faccio uno stack dello stack precedente e della previsione
s1 <- stack(preds,p1)

# Faccio il plot di questo nuovo stack
plot(s1, col=cl)

# Voglio cambiare i nomi nel plot dello stack
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')

# Rifaccio il plot di questo nuovo stack
plot(s1, col=cl)

# In alternativa posso fare un par con le 5 immagini
par(mfrow=c(2,3))
plot(p1, col=cl)
plot(elev, col=cl)
plot(prec, col=cl)
plot(temp, col=cl)
plot(vege, col=cl)




#---------------------------------------------------

# 12. Colorist
# Questo è il dodicesimo script che useremo


# Carico il pacchetto colorist
library(colorist)
# Carico il pacchetto ggplot2
library(ggplot2)

# Utilizzo la funzione "data" per leggere il file di sistema
data("fiespa_occ")

met1 <- metrics_pull(fiespa_occ)

# Creo una nuova palette attraverso la funzione "palette_timecycle"
pal<- palette_timecycle(fiespa_occ)

# Creo una mappa multipla
map_multiples(met1, pal, ncol = 3, labels = names(fiespa_occ))

# Estraggo una mappa singola
map_single(met1, pal, layer = 6)

# Manipolo le mappe cambiando i colori
p1_custom <- palette_timecycle(12, start_hue = 60)
map_multiples(met1, p1_custom, ncol = 4, labels = names(fiespa_occ))

# Metrica
met1_distill <- metrics_distill(fiespa_occ) # we can distill the information
map_single(met1_distill, pal)
map_single(met1_distill, p1_custom)
# le parti più colorate indicano hanno + alta specificità (la specie si trova lì in primavera/estate/inverno/ecc)
# le parti grigie sono meno specifiche: si può trovare la specie in qualsiasi periodo dell'anno

# Creo una legenda
legend_timecycle(pal, origin_label = "1 jan")

# Carico un nuovo dato e lo visualizzo
data("fisher_ud")
fisher_ud

# Creo la metrica e la visualizzo
m2 <- metrics_pull(fisher_ud)
m2

# Creo una nuova palette nel tempo non lineare e la visualizzo
pal2 <- palette_timeline(fisher_ud)
head(pal2)

# Creo una mappa multipla
map_multiples(m2, pal2, ncol = 3, labels = names(fisher_ud))
map_multiples(m2, pal2, ncol = 3, lambda_i = -12, labels = names(fisher_ud))

# Faccio la metrica e estraggo una mappa singola
m2_distill<-metrics_distill(fisher_ud)
map_single(m2_distill,pal2,lambda_i = -10)

# Creo una nuova legenda
legend_timeline(pal2)




#---------------------------------------------------

# 13. Functions
# Questo è il tredicesimo script che useremo a lezione


library(raster)
# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Windows

# Faremo una serie di funzioni

# Funzione 1
# Creo una funzione che, una volta chiamata, "saluta" il nome inserito
cheer_me <- function(your_name) {
cheer_string <- paste("Hello", your_name, sep = " ")
print(cheer_string)
}   

cheer_me("matteo")

# Funzione 2
# Creo una funzione che, una volta chiamata, "saluta" il nome inserito n volte, dove "n" lo scelgo io
cheer_me_n_times <- function(your_name, n) {
cheer_string <- paste("Hello", your_name, sep = " ")

for(i in seq(1, n)) {
print(cheer_string)
}
}

cheer_me_n_times("matteo", 5)


# Funzione 3
# Creo una funzione che, risciamata un'immagine dalla cartella di lavoro, posso scegliere se plottarla con una palette creata da me o lasciare quella di default
dato <- raster("sentinel.png")

plot(dato)

plot_raster <- function(r, col = NA){
if(!is.na(col)) {
pal <- colorRampPalette(col) (100)
plot(r, col = pal)
} else {
plot(r)
}

}

plot_raster(dato, c("brown", "yellow", "green"))
plot_raster(dato)








