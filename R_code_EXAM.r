library(raster)
library(RStoolbox)
library(ggplot2)
library(rgdal)
library(gridExtra)

setwd("C:/lab/Esame")

# Carico le immagini


# 1984

list1984 <- list.files(pattern="1984_B")   #il "pattern" è il nome che identifica un gruppo di immagini salvate
import1984 <- lapply(list1984, raster)  # applico la funzione raster
I1984<-stack(import1984)# tramite la funzione "stack" unisco le componenti della lista in un unico file
I1984
plot(I1984)
plotRGB(I1984, r=1, g=2, b=4, stretch="lin") #NIR



jpeg("H1984.jpg", 600, 800)
plotRGB(I1984, r=1, g=2, b=4, stretch="lin")
dev.off()

# 2022

list2022 <- list.files(pattern="2022_B")   #il "pattern" è il nome che identifica un gruppo di immagini salvate
import2022 <- lapply(list2022, raster)  # applico la funzione raster
I2022<-stack(import2022)# tramite la funzione "stack" unisco le componenti della lista in un unico file
I2022
plot(I2022) 
plotRGB(I2022, r=2, g=3, b=4, stretch="lin") #NIR


jpeg("H2022.jpg", 600, 800)
plotRGB(I2022, r=2, g=3, b=4, stretch="lin")
dev.off()

# Chiamo le immagini appena salvate e le plotto

H1984 <- brick("H1984.jpg")
H1984
plot(H1984)
plotRGB(H1984, 1, 2, 3)


H2022 <- brick("H2022.jpg")
H2022
plot(H2022)
plotRGB(H2022, 1, 2, 3)



## DVI

dvi1<- H1984$H1984.1 - H1984$H1984.2
dvi1
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl)

dvi2<- H2022$H2022.1 - H2022$H2022.2
dvi2
plot(dvi2, col=cl)

par(mfrow=c(2,1))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi<- dvi1-dvi2
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi,col=cld)

# Salvo le immagini prodotte

jpeg("dvi1.jpg", 600, 400)
plot(dvi1, col=cl)
dev.off()

jpeg("dvi2.jpg", 600, 400)
plot(dvi2, col=cl)
dev.off()

jpeg("pardvi.jpg", 600, 800)
par(mfrow=c(2,1))
plot(dvi1, col=cl)
plot(dvi2, col=cl)
dev.off()

jpeg("difdvi.jpg", 600, 400)
plot(difdvi, col=cld)
dev.off()



## NDVI
#(NIR-RED)/(NIR+RED)

ndvi1<-(dvi1)/(H1984$H1984.1 + H1984$H1984.2)
plot(ndvi1,col=cl)

ndvi2<-dvi2/(H2022$H2022.1 + H2022$H2022.2)
plot(ndvi2,col=cl)

par(mfrow=c(2,1))
plot(ndvi1, col=cl)
plot(ndvi2, col=cl)


difndvi<-ndvi1-ndvi2
plot(difndvi,col=cld)

# Salvo le immagini prodotte

jpeg("ndvi1.jpg", 600, 400)
plot(ndvi1, col=cl)
dev.off()

jpeg("ndvi2.jpg", 600, 400)
plot(ndvi2, col=cl)
dev.off()

jpeg("parndvi.jpg", 600, 800)
par(mfrow=c(2,1))
plot(ndvi1, col=cl)
plot(ndvi2, col=cl)
dev.off()

jpeg("difndvi.jpg", 600, 400)
plot(difndvi,col=cld)
dev.off()



## Classificazione


class1984<- unsuperClass(H1984, nClasses=4)
class1984
# classi: bosco, terreno agricolo, acqua, zone urbanizzate
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(class1984$map, col=cl)


class2022<- unsuperClass(H2022, nClasses=4)
class2022
# classi: bosco, terreno agricolo, acqua, zone urbanizzate
plot(class2022$map, col=cl)

# Salvo le immagini prodotte

jpeg("class1984.jpg", 600, 400)
plot(class1984$map, col=cl)
dev.off()

jpeg("class2022.jpg", 600, 400)
plot(class2022$map, col=cl)
dev.off()

# Calcolo le frequenze

freq(class1984$map)
freq(class2022$map)


tot1984 <- 38511 + 57738 + 75576 + 63787
tot2022 <- 65647 + 27517 + 67325 + 76116

tot1984
tot2022


perc_forest1984 <- 75576*100/tot1984
perc_forest2022 <- 67325*100/tot2022
perc_forest1984
perc_forest2022


perc_agric1984 <- 38511*100/tot1984
perc_agric2022 <- 65647*100/tot2022
perc_agric1984
perc_agric2022


perc_acqua1984 <- 57738*100/tot1984
perc_acqua2022 <- 27517*100/tot2022
perc_acqua1984
perc_acqua2022


perc_altro1984 <- 63787*100/tot1984
perc_altro2022 <- 76116*100/tot2022
perc_altro1984
perc_altro2022


# Costruisco un data frame

class <- c("Foresta","Agricultura","Acqua","Altro")
percent_1984 <- c(32.08, 16.34, 24.51, 27.07)
percent_2022 <- c(28.46, 27.74, 11.63, 32.17)
differenza <- c(percent_1984-percent_2022)

Tab.perc <- data.frame(class, percent_1984, percent_2022, differenza)
Tab.perc
View(Tab.perc)

write.table(Tab.perc, "Tab.perc.csv", sep = ",")

PL1 <- ggplot(Tab.perc, aes(x=class, y=percent_1984, fill=class)) + geom_bar(stat="identity")
PL2 <- ggplot(Tab.perc, aes(x=class, y=percent_2022, fill=class)) + geom_bar(stat="identity")
grid.arrange(PL1, PL2, nrow=1)

jpeg("histo.jpg", 800, 500)
grid.arrange(PL1, PL2, nrow=1)
dev.off()

