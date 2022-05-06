# Questo è il sesto script che useremo a lezione

# Carico il pacchetto raster
library(raster)
# Carico il pacchetto RStoolbox
library(RStoolbox)
# Installo il pacchetto ggplot2
#install.packages("ggplot2")
# Carico il pacchetto ggplot2
library(ggplot2)
# Installo il pacchetto gridExtra
#install.packages("gridExtra")
# Carico il pacchetto gridExtra
library(gridExtra)
# Installo il pacchetto patchwork
install.packages("patchwork")
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
# Percentuale della foresta 92: 89.95845
# Percentuale della porzione agricola 92: 10.04155
# Percentuale della foresta 06: 52.14049
# Percentuale della porzione agricola 06: 47.85951

# Creo un data frame con tre colonne
# La prima colonna sarà la classe, la seconda i valori percentuali del 92 e la terza i valori percentuali del 06
class <- c("Forest","Agriculture")
percent_1992 <- c(89.95, 10.05)
percent_2006 <- c(52.15, 47.85)
multitemporal <- data.frame(class, percent_1992, percent_2006)
multitemporal
View(multitemporal)

# Plotto il data frame
PL1 <- ggplot(multitemporal, aes(x=class, y=percent_1992, color=class)) + geom_bar(stat="identity", fill="black")
PL2 <- ggplot(multitemporal, aes(x=class, y=percent_2006, color=class)) + geom_bar(stat="identity", fill="white")
grid.arrange(PL1, PL2, nrow=1)

# Salvo in pdf il data frame
pdf("data_frame")
grid.arrange(PL1, PL2, nrow=1)
dev.off()
