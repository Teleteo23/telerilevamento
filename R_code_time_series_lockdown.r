# Questo è il quarto script che useremo a lezione

# R code for chemical cycling study
# time series of NO2 change in Europe during the lockdown
# https://www.esa.int/Applications/Observing_the_Earth/Copernicus/Sentinel-5P/Coronavirus_lockdown_leading_to_drop_in_pollution_across_Europe
# https://acp.copernicus.org/preprints/acp-2020-995/acp-2020-995.pdf

# Carico e/o installo una serie di pacchetti che verranno utilizzati nello script
# Carico il pacchetto raster
library(raster)

# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/EN") # Windows 

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

#*
-------------------
# SISTEMARE QUESTA PARTE DI CODICE E  INSERIRLA ALL'INIZIO DELLO SCRIPT
EN01 <- raster("EN_0001.png")
cl <- colorRampPalette(c('red','orange','yellow'))(100) # 

# plot the NO2 values of January 29/01/20 by the cl palette
plot(EN01, col=cl)

# import the end of March NO2 and plot it
EN13 <- raster("EN_0013.png")
plot(EN13, col=cl)
dev.off()

# *
# plotto la prima e l'ultima immagine insieme
# metodo 1
# Build a multiframe window with 2 rows and 1 column with the par function
par(mfrow=c(2,1))
plot(EN01, col=cl)
plot(EN13, col=cl)
dev.off()

# metodo 2
# plot the images from the stack
par(mfrow=c(2,1))
plot(ENs$EN_0001, col=cl)
plot(ENs$EN_0013, col=cl)
dev.off()

# metodo 3
# facico uno stack co solo i due elementi che mi servono
EN113 <- stack(ENs[[1]], ENs[[13]])
plot(EN113)
dev.off()

# faccio la differenza tra il primo e il tredicesimo elemento
difEN <- ENs[[1]] - ENs[[13]]
cldif <- colorRampPalette(c('blue','white','red'))(100) #
plot(difEN, col=cldif)
# il rosso è gennaio e il blu è marzo
dev.off()
