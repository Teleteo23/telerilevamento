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

# Importo l'immagine dei valori di NO2 di fine Marzo e la plotto
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
