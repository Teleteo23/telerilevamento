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
