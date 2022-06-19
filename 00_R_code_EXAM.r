# R_code_EXAM.r
# Questo è lo script utilizzato per il progetto finale del corso di Telerilevamento Geo-Ecologico


# Carico il pacchetto raster
library(raster)
# Carico il pacchetto RStoolbox
library(RStoolbox)
# Carico il pacchetto ggplot2
library(ggplot2)
# Carico il pacchetto gridExtra
library(gridExtra)

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/Esame") # Percorso per Windows users

## Importo le immagini di partenza del 1984 e del 2022
# Per 'importazione delle immagini utilizzo uno stack

# 1984

# Inizialmente creo una lista di files utilizzando la funzione "list.files" e la assegno ad un oggetto
# "pattern" ricerca all'interno della cartella di lavoro tutti i file con all'interno del nome una parte comune
list1984 <- list.files(pattern="1984_B")  
# Applico la funzione "raster" alla lista utilizzando un'altra funzione chiamata "lapply" e la assegno ad un oggetto
import1984 <- lapply(list1984, raster) 
# Infine, creo un singolo file, unendo le 13 immagini, utilizzando la funzione "stack" e lo assegno ad un oggetto
I1984<-stack(import1984)# tramite la funzione "stack" unisco le componenti della lista in un unico file
# Visualizzo il nuovo file
I1984
# Plotto il nuovo file
plot(I1984)
# Faccio un plotRGB del file e metto la banda dell'infrarosso vicino sul RED, la banda del rosso sul GREEN e la banda del verde sul BLUE
plotRGB(I1984, r=1, g=2, b=4, stretch="lin") 
# In questo modo nell'immagine verrà risaltata la porzione di territorio coperta da vegetazione (colore rosso)

# Tramite la funzione "jpeg" esporto questa nuova immagine nella mia cartella di lavoro e le assegno un nuovo nome
jpeg("H1984.jpg", 600, 800)
plotRGB(I1984, r=1, g=2, b=4, stretch="lin")
dev.off()

# 2022

# Lo stesso procedimento di importazione, creazione del nuovo oggetto ed esportazione dell'immagine è stata eseguita anche per il 2022
list2022 <- list.files(pattern="2022_B")   
import2022 <- lapply(list2022, raster)  
I2022<-stack(import2022)
I2022
plot(I2022) 
plotRGB(I2022, r=2, g=3, b=4, stretch="lin") 


jpeg("H2022.jpg", 600, 800)
plotRGB(I2022, r=2, g=3, b=4, stretch="lin")
dev.off()

# Importo le due immagini appena esportate (per salvarle come oggetti) 
# Utilizzo la funzione "brick" per importare le immagini e le assegno ad un oggetto
# Utilizzo la funzione "brick" perché le immagini sono degli RGB
H1984 <- brick("H1984.jpg")
# Chiamo l'oggetto per visualizzarne le informazioni
H1984
# Faccio un plot dell'oggetto
plot(H1984)
# Essendo un immagine RGB, faccio un plot RGB
plotRGB(H1984, 1, 2, 3)


H2022 <- brick("H2022.jpg")
H2022
plot(H2022)
plotRGB(H2022, 1, 2, 3)


## Calcolo degl'indici spettrali
# DVI

# Calcolo il difference vegetation index(DVI)(differenza tra le riflettanze nel NIR e nel rosso)
dvi1<- H1984$H1984.1 - H1984$H1984.2
# Chiamo l'oggetto per visualizzarne le informazioni
dvi1
# Creo una nuova scala colori per miglirare la visualizzazione
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
# Plotto il DVI del 1984 con la nuova scala colori
plot(dvi1, col=cl)

# Lo stesso procedimento lo applico anche all'immagine del 2022
dvi2<- H2022$H2022.1 - H2022$H2022.2
dvi2
plot(dvi2, col=cl)

# Il range del DVI nelle immagini a 8 bit può andare da -255 a 255
# Nell'immagine del 1984 il range del DVI va da -162 a 205
# Nell'immagine del 2022 il range del DVI va da -152 a 219

# Creo un multiframe con il DVI del 1984 e del 2022
par(mfrow=c(2,1))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

# Calcolo la differenza del DVI nel tempo
difdvi<- dvi1-dvi2
# Creo una nuova scala colori e plotto la differenza del DVI calcolata
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi,col=cld)

# Le zone visualizzate col colore rosso indicano dove c'è stata più alta variazione (forte deforestazione)

# Esporto le immagini prodotte utilizzanfo la funzione "jpeg"

# DVI del 1984
jpeg("dvi1.jpg", 600, 400)
plot(dvi1, col=cl)
dev.off()

# DVI del 2022
jpeg("dvi2.jpg", 600, 400)
plot(dvi2, col=cl)
dev.off()

# DVI delle due annate messi assieme
jpeg("pardvi.jpg", 600, 800)
par(mfrow=c(2,1))
plot(dvi1, col=cl)
plot(dvi2, col=cl)
dev.off()

# Differenza tra i due DVI
jpeg("difdvi.jpg", 600, 400)
plot(difdvi, col=cld)
dev.off()



# NDVI
# Calcolo il normalized difference vegetation index(NDVI)(rapporto tra la differenza e la somma tra le riflettanze nel NIR e nel rosso)
#(NIR-RED)/(NIR+RED)
ndvi1<-(dvi1)/(H1984$H1984.1 + H1984$H1984.2)
# Chiamo l'oggetto per visualizzarne le informazioni
ndvi1
# Plotto l'NDVI del 1984 con la scala colori utilizzata per il DVI
plot(ndvi1,col=cl)

# Lo stesso procedimento lo applico anche all'immagine del 2022
ndvi2<-dvi2/(H2022$H2022.1 + H2022$H2022.2)
ndvi2
plot(ndvi2,col=cl)

# Il range del NDVI a 8 bit va da -1 a 1

# Creo un multiframe con il DVI del 1984 e del 2022
par(mfrow=c(2,1))
plot(ndvi1, col=cl)
plot(ndvi2, col=cl)

# Calcolo la differenza del DVI nel tempo
difndvi<-ndvi1-ndvi2
# Plotto la differenza dell'NDVI con la scala colori utilizzata per la differenza DVI
plot(difndvi,col=cld)

# Esporto le immagini prodotte utilizzanfo la funzione "jpeg"

# NDVI del 1984
jpeg("ndvi1.jpg", 600, 400)
plot(ndvi1, col=cl)
dev.off()

# NDVI del 2022
jpeg("ndvi2.jpg", 600, 400)
plot(ndvi2, col=cl)
dev.off()

# NDVI delle due annate messi assieme
jpeg("parndvi.jpg", 600, 800)
par(mfrow=c(2,1))
plot(ndvi1, col=cl)
plot(ndvi2, col=cl)
dev.off()

# Differenza tra i due NDVI
jpeg("difndvi.jpg", 600, 400)
plot(difndvi,col=cld)
dev.off()



## Classificazione

# Classifico l'immagine del 1984 sulla base alla riflettanza di ogni pixel dell'immagine sia nella banda del rosso che dell'infrarosso vicino
# Per farlo utilizzo la funzione "unsuperClass" indicando il numero di classi che voglio e la assegno ad un oggetto (in questo caso sno state utilizzate 4 classi)
class1984<- unsuperClass(H1984, nClasses=4)
# Chiamo l'oggetto per visualizzarne le informazioni
class1984
# Classi: 
# 1. Altro
# 2. Foresta
# 3. Agricoltura 
# 4. Acqua
# Plotto l'immagine classificata legandola alla mappa creata durante la classificazione
# Creo una nuova scala colori per miglirare la visualizzazione
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(class1984$map, col=cl)

# Lo stesso procedimento lo applico anche all'immagine del 2022
class2022<- unsuperClass(H2022, nClasses=4)
class2022
# Classi: 
# 1. Acqua
# 2. Altro
# 3. Foresta
# 4. Agricoltura 
plot(class2022$map, col=cl)

# Esporto le immagini prodotte

# Immagine del 1984 classificata
jpeg("class1984.jpg", 600, 400)
plot(class1984$map, col=cl)
dev.off()

# Immagine del 2022 classificata
jpeg("class2022.jpg", 600, 400)
plot(class2022$map, col=cl)
dev.off()

# Calcolo la frequenza di pixel appartenenti rispettivamente alle 4 classi
# Per farlo utilizzo la funzione "freq" 
freq(class1984$map)
# Classe 1: 63787
# Classe 2: 75576
# Classe 3: 38551
# Classe 4: 57738

# Calcolo la frequenza di pixel appartenenti rispettivamente alle 4 classi
# Per farlo utilizzo la funzione "freq" 
freq(class2022$map)
# Classe 1: 27517
# Classe 2: 76116
# Classe 3: 67325
# Classe 4: 65647

# Calcolo il numero di pixels totali per le due immagini e visualizzo i risultati
tot1984 <- 38511 + 57738 + 75576 + 63787
tot1984
# 235612

tot2022 <- 65647 + 27517 + 67325 + 76116
tot2022
# 236605

# Calcolo la percentuale di pixel appartenenti rispettivamente alle 4 classi e ne visualizzo i valori
# Foresta
perc_forest1984 <- 75576*100/tot1984
perc_forest2022 <- 67325*100/tot2022
perc_forest1984
# 32.08 %
perc_forest2022
# 28.46 %

# Agricoltura
perc_agric1984 <- 38511*100/tot1984
perc_agric2022 <- 65647*100/tot2022
perc_agric1984
# 16.34 %
perc_agric2022
# 27.74 %

# Acqua
perc_acqua1984 <- 57738*100/tot1984
perc_acqua2022 <- 27517*100/tot2022
perc_acqua1984
# 24.51 %
perc_acqua2022
# 11.63 %

# Altro
perc_altro1984 <- 63787*100/tot1984
perc_altro2022 <- 76116*100/tot2022
perc_altro1984
# 27.07 %
perc_altro2022
# 32.17 %


# Costruisco un data frame con quattro colonne
# La prima colonna sarà la classe, la seconda i valori percentuali del 1984, la terza i valori percentuali del 2022 e la quarta la differenza tra le varie classi
# Assegno ogni colonna ad una variabile
class <- c("Foresta","Agricultura","Acqua","Altro")
percent_1984 <- c(32.08, 16.34, 24.51, 27.07)
percent_2022 <- c(28.46, 27.74, 11.63, 32.17)
differenza <- c(percent_1984-percent_2022)

# Utilizzando la funzione "data.frame" creo un data frame con all'interno i dati precedentemente salvati
Tab.perc <- data.frame(class, percent_1984, percent_2022, differenza)
# Chiamo l'oggetto per visualizzarne le informazioni
Tab.perc

# Attraverso la funzione "View" visualizzo il dataframe in un'altra finestra
View(Tab.perc)

# Con la funzione "write.table" esporto il dataframe in formato "csv" 
write.table(Tab.perc, "Tab.perc.csv", sep = ",")

# Plotto il data frame creando due immagini a istogrammi
# Salvo in due variabili le due immagini create attraverso la funzione "ggplot" + la funzione "geom_bar"
PL1 <- ggplot(Tab.perc, aes(x=class, y=percent_1984, fill=class)) + geom_bar(stat="identity")
PL2 <- ggplot(Tab.perc, aes(x=class, y=percent_2022, fill=class)) + geom_bar(stat="identity")
# Attraverso la funzione "grid.arrange" plotto le due immagini nella stessa pagina
grid.arrange(PL1, PL2, nrow=1)

# Esporto il grid.arrange come file ".jpg" e lo salvo nella mia cartella di lavoro 
jpeg("histo.jpg", 800, 500)
grid.arrange(PL1, PL2, nrow=1)
dev.off()
