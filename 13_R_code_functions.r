# Questo è il tredicesimo script che useremo a lezione
# R_code_functions.r

library(raster)
# Setto la cartella dei dati di lavoro (scelgo un percorso molto breve)
setwd("C:/lab/") # Windows

# Faremo una serie di funzioni

# Funzione 1
# Creo una funzione che, una volta chiamata, "saluta" il nome inserito
cheer_me <- function(your_name) {
cheer_string <- paste("Hello", your_name, sep = " ")
print(cheer_string)
}   

cheer_me("matteo")

# Funzione 2
# Creo una funzione che, una volta chiamata, "saluta" il nome inserito n volte, dove "n" lo scelgo io
cheer_me_n_times <- function(your_name, n) {
cheer_string <- paste("Hello", your_name, sep = " ")

for(i in seq(1, n)) {
print(cheer_string)
}
}

cheer_me_n_times("matteo", 5)


# Funzione 3
# Creo una funzione che, risciamata un'immagine dalla cartella di lavoro, posso scegliere se plottarla con una palette creata da me o lasciare quella di default
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

