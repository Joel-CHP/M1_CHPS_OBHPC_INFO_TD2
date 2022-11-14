# Définition de l'étiquette de l'axe x :
set xlabel "Compilateurs et optimisations"
# Définition de l'étiquette de l'axe y :
set ylabel "Bandwidth"

# Attribuer le style histogrammes :
set style data histograms

# Délimiter les valeurs de l'axe y de 0 à la valeur maximale :
set yrange [0:*]

# Définition du format de sauvegarde de l'image :
set terminal png
# Nommage du fichier de sauvegarde :
set output "but.png"

# Indiquer le caractère de séparation des valeurs de la ligne :
set datafile separator ","

# 4 rangs et 2 graphiques par rang
set multiplot layout 4,2

# Afficher la colonne 1 comme étiquettes des groupes de barres (xtics(1)):
# Afficher le titre des classes de barres en haut à droite (ti "gcc") :
plot 'dgemm_ijk.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang"
plot 'dgemm_ikj.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang"
plot 'dgemm_iex.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang"
plot 'dgemm_unroll4.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang"
plot 'dgemm_unroll8.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang"
plot 'dgemm_cblas.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang"
plot 'dotprod.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang"
plot 'reduc.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang"

# Plusieurs graphiques sur une même page
unset multiplot

# Afficher un message et attendre un retour charriot :
pause -1 "Appuyer sur retour charriot pour terminer la création des graphiques du TD2 de OBHPC Info"


