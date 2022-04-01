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
import <- lapply(rlist,raster)
# Visualizzo i files importati
import

# Creo un singolo file, unendo le 13 immagini, utilizzando la funzione "stack" e lo assegno ad un oggetto
ENr <- stack(import)
# Visualizzo il nuovo file
ENr
# Plotto il nuovo file
# Creo una nuova scala colori per miglirare la visualizzazione
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(ENr, col=cl)
dev.off()
