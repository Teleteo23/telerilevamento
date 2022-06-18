# Questo è il decimo script che useremo a lezione
# R_code_LiDAR.r

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
