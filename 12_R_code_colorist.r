# Questo è il dodicesimo script che useremo

# Carico il pacchetto colorist
library(colorist)
# Carico il pacchetto ggplot2
library(ggplot2)

# Utilizzo la funzione "data" per leggere il file di sistema
data("fiespa_occ")

met1 <- metrics_pull(fiespa_occ)

# Creo una nuova palette attraverso la funzione "palette_timecycle"
pal<- palette_timecycle(fiespa_occ)

# Creo un amappa multipla
map_multiples(met1, pal, ncol = 3, labels = names(fiespa_occ))

map_single(met1, pal, layer = 6)

p1_custom <- palette_timecycle(12, start_hue = 60)

map_multiples(met1, p1_custom, ncol = 4, labels = names(fiespa_occ))


met1_distill <- metrics_distill(fiespa_occ) # we can distill the information

map_single(met1_distill, pal)

map_single(met1_distill, p1_custom)

legend_timecycle(pal, origin_label = "1 jan")

data("fisher_ud")

m2 <- metrics_pull(fisher_ud)

pal2 <- palette_timeline(fisher_ud)

head(pal2)

map_multiples(m2, pal2, ncol = 3, labels = names(fisher_ud))

map_multiples(m2, pal2, ncol = 3, lambda_i = -12, labels = names(fisher_ud))

m2_distill<-metrics_distill(fisher_ud)

map_single(m2_distill,pal2,lambda_i = -10)

legend_timeline(pal2)
