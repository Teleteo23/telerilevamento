# Questo è il tredicesimo script che useremo a lezione

library(raster)
# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Windows

# Faremo una serie di funzioni

cheer_me <- function(your_name) {
cheer_string <- paste("Hello", your_name, sep = " ")
print(cheer_string)
}   

cheer_me("matteo")


cheer_me_n_times <- function(your_name, n) {
cheer_string <- paste("Hello", your_name, sep = " ")

for(i in seq(1, n)) {
print(cheer_string)
}
}

cheer_me_n_times("matteo", 5)

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

