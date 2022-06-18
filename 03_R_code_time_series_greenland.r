# R_code_time_series_greenland.r
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

