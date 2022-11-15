# Attribution du style histogrammes :
set style data histograms

# Délimiter les valeurs de l'axe y de 0 à la valeur maximale :
set yrange [0:*]

# Définition du format de sauvegarde de l'image :
set terminal png

# Indiquer le caractère de séparation des valeurs de la ligne :
set datafile separator ","




###### 1ERE PARTIE : Histogrammes comparant les différentes versions pour chaque compilateur #####
# Définition de l'étiquette de l'axe y :
set ylabel "Bandwidth (MiB/s)"

# Nommage du fichier de sauvegarde :
set output "dgemmijkdgemmikjiexcblas.png"

# Définition de plusieurs graphiques sur une même page
# Avec 2 rangs et 2 graphiques par rang
set multiplot layout 2,2

# Définition de l'étiquette de l'axe x :
set xlabel "Procédure dgemm ijk"

# Afficher la colonne 1 comme étiquettes des groupes de barres (xtics(1)):
# Afficher le titre des classes de barres en haut à droite (ti "gcc") :
plot 'dgemm_ijk.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang", '' using 4:xticlabels(1) ti "icx"

# Sortie de la définition de l'étiquette de l'axe x :
unset xlabel

set xlabel "Procédure dgemm ikj"
plot 'dgemm_ikj.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang", '' using 4:xticlabels(1) ti "icx"
unset xlabel

set xlabel "Procédure dgemm iex"
plot 'dgemm_iex.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang", '' using 4:xticlabels(1) ti "icx"
unset xlabel

set xlabel "Procédure dgemm cblas"
plot 'dgemm_cblas.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang", '' using 4:xticlabels(1) ti "icx"
unset xlabel

# Fin de la définition de plusieurs graphiques sur une même page
unset multiplot

# Fin de la définition de la sortie
unset output



set output "unroll4unroll8dotprodreduc.png"

set multiplot layout 2,2

set xlabel "Procédure dgemm unroll4"
plot 'dgemm_unroll4.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang", '' using 4:xticlabels(1) ti "icx"
unset xlabel

set xlabel "Procédure dgemm unroll8"
plot 'dgemm_unroll8.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang", '' using 4:xticlabels(1) ti "icx"
unset xlabel

set xlabel "Procédure dotprod"
plot 'dotprod.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang", '' using 4:xticlabels(1) ti "icx"
unset xlabel

set xlabel "Procédure reduc"
plot 'reduc.dat' using 2:xticlabels(1) ti "gcc", '' using 3:xticlabels(1) ti "clang", '' using 4:xticlabels(1) ti "icx"
unset xlabel

unset multiplot

unset output




###### 2EME PARTIE : Histogrammes comparant les comparant les versions par compilateur #####

set output "O0O1O2O3.png"

set multiplot layout 2,2

set xlabel "Optimisation O0"
plot 'dgemm_O0.dat' using 2:xticlabels(1) ti "ijk", '' using 3:xticlabels(1) ti "ikj", '' using 4:xticlabels(1) ti "iex", '' using 5:xticlabels(1) ti "unroll4", '' using 6:xticlabels(1) ti "unroll8", '' using 7:xticlabels(1) ti "cblas"
unset xlabel

set xlabel "Optimisation O1"
plot 'dgemm_O1.dat' using 2:xticlabels(1) ti "ijk", '' using 3:xticlabels(1) ti "ikj", '' using 4:xticlabels(1) ti "iex", '' using 5:xticlabels(1) ti "unroll4", '' using 6:xticlabels(1) ti "unroll8", '' using 7:xticlabels(1) ti "cblas"
unset xlabel

set xlabel "Optimisation O2"
plot 'dgemm_O2.dat' using 2:xticlabels(1) ti "ijk", '' using 3:xticlabels(1) ti "ikj", '' using 4:xticlabels(1) ti "iex", '' using 5:xticlabels(1) ti "unroll4", '' using 6:xticlabels(1) ti "unroll8", '' using 7:xticlabels(1) ti "cblas"
unset xlabel

set xlabel "Optimisation O3"
plot 'dgemm_O3.dat' using 2:xticlabels(1) ti "ijk", '' using 3:xticlabels(1) ti "ikj", '' using 4:xticlabels(1) ti "iex", '' using 5:xticlabels(1) ti "unroll4", '' using 6:xticlabels(1) ti "unroll8", '' using 7:xticlabels(1) ti "cblas"
unset xlabel

# Fin de la définition de plusieurs graphiques sur une même page
unset multiplot

# Fin de la définition de la sortie
unset output



set output "OsOgOfast.png"

set multiplot layout 2,2

set xlabel "Optimisation Os"
plot 'dgemm_Os.dat' using 2:xticlabels(1) ti "ijk", '' using 3:xticlabels(1) ti "ikj", '' using 4:xticlabels(1) ti "iex", '' using 5:xticlabels(1) ti "unroll4", '' using 6:xticlabels(1) ti "unroll8", '' using 7:xticlabels(1) ti "cblas"
unset xlabel

set xlabel "Optimisation Og"
plot 'dgemm_Og.dat' using 2:xticlabels(1) ti "ijk", '' using 3:xticlabels(1) ti "ikj", '' using 4:xticlabels(1) ti "iex", '' using 5:xticlabels(1) ti "unroll4", '' using 6:xticlabels(1) ti "unroll8", '' using 7:xticlabels(1) ti "cblas"
unset xlabel

set xlabel "Optimisation Ofast"
plot 'dgemm_Ofast.dat' using 2:xticlabels(1) ti "ijk", '' using 3:xticlabels(1) ti "ikj", '' using 4:xticlabels(1) ti "iex", '' using 5:xticlabels(1) ti "unroll4", '' using 6:xticlabels(1) ti "unroll8", '' using 7:xticlabels(1) ti "cblas"
unset xlabel

unset multiplot

unset output





##### Afficher un message et attendre un retour charriot :
pause -1 "Appuyer sur retour charriot pour terminer l'exécution du TD2 de OBHPC Info. 2 fichiers de type PNG sont générés pour la 1ère partie comparant les différentes versions pour chaque compilateur. 2 fichiers de type PNG sont générés pour la 2ème partie comparant les versions par compilateur."
