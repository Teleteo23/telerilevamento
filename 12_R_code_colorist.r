# Questo è il dodicesimo script che useremo
# R_code_colorist.r

# Carico il pacchetto colorist
library(colorist)
# Carico il pacchetto ggplot2
library(ggplot2)

# Utilizzo la funzione "data" per leggere il file di sistema
data("fiespa_occ")

met1 <- metrics_pull(fiespa_occ)

# Creo una nuova palette attraverso la funzione "palette_timecycle"
pal<- palette_timecycle(fiespa_occ)

# Creo una mappa multipla
map_multiples(met1, pal, ncol = 3, labels = names(fiespa_occ))

# Estraggo una mappa singola
map_single(met1, pal, layer = 6)

# Manipolo le mappe cambiando i colori
p1_custom <- palette_timecycle(12, start_hue = 60)
map_multiples(met1, p1_custom, ncol = 4, labels = names(fiespa_occ))

# Metrica
met1_distill <- metrics_distill(fiespa_occ) # we can distill the information
map_single(met1_distill, pal)
map_single(met1_distill, p1_custom)
# le parti più colorate indicano hanno + alta specificità (la specie si trova lì in primavera/estate/inverno/ecc)
# le parti grigie sono meno specifiche: si può trovare la specie in qualsiasi periodo dell'anno

# Creo una legenda
legend_timecycle(pal, origin_label = "1 jan")

# Carico un nuovo dato e lo visualizzo
data("fisher_ud")
fisher_ud

# Creo la metrica e la visualizzo
m2 <- metrics_pull(fisher_ud)
m2

# Creo una nuova palette nel tempo non lineare e la visualizzo
pal2 <- palette_timeline(fisher_ud)
head(pal2)

# Creo una mappa multipla
map_multiples(m2, pal2, ncol = 3, labels = names(fisher_ud))
map_multiples(m2, pal2, ncol = 3, lambda_i = -12, labels = names(fisher_ud))

# Faccio la metrica e estraggo una mappa singola
m2_distill<-metrics_distill(fisher_ud)
map_single(m2_distill,pal2,lambda_i = -10)

# Creo una nuova legenda
legend_timeline(pal2)
