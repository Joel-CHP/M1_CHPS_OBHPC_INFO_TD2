#!/bin/bash
# shebang=sharp(#)bang(!) indique que ce fichier est un ensemble de commandes pour l'interpréteur /bin/bash

##### PREALABLES #####
# Installation de GCC et CLANG
# Installation de ICX par ""oneAPI base toolkit de Intel" (ICC faisant partie de oneAPI HPC toolkit qui n'est pas installé à ce jour)
# Création du script de définition de l'environnement : $ source /opt/intel/oneapi/setvars.sh intel64

# Tri processus selon la mémoire avec : $ top -o %MEM
# Tri processus selon le CPU avec : $ top -o %CPU
# Arrêt de tous processus coûteux avec : $ kill <PID>

##### DEBUT DU SCRIPT #####
# Selon $ cpupower frequency-info, la fréquence peut être choisie sur cet intervalle : nous voulons la valeur maximale : "4.60 HHz". 
# Nous avons le choix entre deux governors : nous prenons "performance" pour maximiser la fréquence à "4.60 HHz".
sudo cpupower -c all frequency-set -g performance

# Variable n (taille) et r (kernel repetitions)
n=50
r=500

# Compiler le Makefile dans /TD2/dgemm depuis /TD2
make -C dgemm

# Compiler le Makefile dans /TD2/dotprod depuis /TD2
make -C dotprod

# Compiler le Makefile dans /TD2/reduc depuis /TD2
make -C reduc

# Ajout successif des noms des optimisations (et passage à la ligne) dans le même csv 
echo -e "O0" >> optimisation_de_compilation.csv
echo -e "O1" >> optimisation_de_compilation.csv
echo -e "O2" >> optimisation_de_compilation.csv
echo -e "O3" >> optimisation_de_compilation.csv
echo -e "Os" >> optimisation_de_compilation.csv
echo -e "Og" >> optimisation_de_compilation.csv
echo -e "Ofast" >> optimisation_de_compilation.csv

# Ajout successif des noms des compilateurs (et passage à la ligne) dans le même csv 
echo -e "GCC" >> compilateurs.csv
echo -e "CLANG" >> compilateurs.csv
echo -e "ICX" >> compilateurs.csv

# DGEMM :
# Pinning du processus le 4ème coeur de calcul (-c 4)
# Redirection de la sortie standard dans un fichier .csv qui est créé (>)
# Création d'un fichier .csv de 1 ligne pour chaque version de calcul (grep)
# Suppression des fichiers .csv qui ont plusieurs lignes
taskset -c 4 dgemm/./dgemm_O0_gcc $n $r > dgemm_O0_gcc.csv
grep -i -w ijk dgemm_O0_gcc.csv > dgemm_O0_gcc_ijk.csv
grep -i -w ikj dgemm_O0_gcc.csv > dgemm_O0_gcc_ikj.csv
grep -i -w iex dgemm_O0_gcc.csv > dgemm_O0_gcc_iex.csv
grep -i -w unroll4 dgemm_O0_gcc.csv > dgemm_O0_gcc_unroll4.csv
grep -i -w unroll8 dgemm_O0_gcc.csv > dgemm_O0_gcc_unroll8.csv
grep -i -w cblas dgemm_O0_gcc.csv > dgemm_O0_gcc_cblas.csv
rm dgemm_O0_gcc.csv

taskset -c 4 dgemm/./dgemm_O1_gcc $n $r > dgemm_O1_gcc.csv
grep -i -w ijk dgemm_O1_gcc.csv > dgemm_O1_gcc_ijk.csv
grep -i -w ikj dgemm_O1_gcc.csv > dgemm_O1_gcc_ikj.csv
grep -i -w iex dgemm_O1_gcc.csv > dgemm_O1_gcc_iex.csv
grep -i -w unroll4 dgemm_O1_gcc.csv > dgemm_O1_gcc_unroll4.csv
grep -i -w unroll8 dgemm_O1_gcc.csv > dgemm_O1_gcc_unroll8.csv
grep -i -w cblas dgemm_O1_gcc.csv > dgemm_O1_gcc_cblas.csv
rm dgemm_O1_gcc.csv

taskset -c 4 dgemm/./dgemm_O2_gcc $n $r > dgemm_O2_gcc.csv
grep -i -w ijk dgemm_O2_gcc.csv > dgemm_O2_gcc_ijk.csv
grep -i -w ikj dgemm_O2_gcc.csv > dgemm_O2_gcc_ikj.csv
grep -i -w iex dgemm_O2_gcc.csv > dgemm_O2_gcc_iex.csv
grep -i -w unroll4 dgemm_O2_gcc.csv > dgemm_O2_gcc_unroll4.csv
grep -i -w unroll8 dgemm_O2_gcc.csv > dgemm_O2_gcc_unroll8.csv
grep -i -w cblas dgemm_O2_gcc.csv > dgemm_O2_gcc_cblas.csv
rm dgemm_O2_gcc.csv

taskset -c 4 dgemm/./dgemm_O3_gcc $n $r > dgemm_O3_gcc.csv
grep -i -w ijk dgemm_O3_gcc.csv > dgemm_O3_gcc_ijk.csv
grep -i -w ikj dgemm_O3_gcc.csv > dgemm_O3_gcc_ikj.csv
grep -i -w iex dgemm_O3_gcc.csv > dgemm_O3_gcc_iex.csv
grep -i -w unroll4 dgemm_O3_gcc.csv > dgemm_O3_gcc_unroll4.csv
grep -i -w unroll8 dgemm_O3_gcc.csv > dgemm_O3_gcc_unroll8.csv
grep -i -w cblas dgemm_O3_gcc.csv > dgemm_O3_gcc_cblas.csv
rm dgemm_O3_gcc.csv

taskset -c 4 dgemm/./dgemm_Os_gcc $n $r > dgemm_Os_gcc.csv
grep -i -w ijk dgemm_Os_gcc.csv > dgemm_Os_gcc_ijk.csv
grep -i -w ikj dgemm_Os_gcc.csv > dgemm_Os_gcc_ikj.csv
grep -i -w iex dgemm_Os_gcc.csv > dgemm_Os_gcc_iex.csv
grep -i -w unroll4 dgemm_Os_gcc.csv > dgemm_Os_gcc_unroll4.csv
grep -i -w unroll8 dgemm_Os_gcc.csv > dgemm_Os_gcc_unroll8.csv
grep -i -w cblas dgemm_Os_gcc.csv > dgemm_Os_gcc_cblas.csv
rm dgemm_Os_gcc.csv

taskset -c 4 dgemm/./dgemm_Og_gcc $n $r > dgemm_Og_gcc.csv
grep -i -w ijk dgemm_Og_gcc.csv > dgemm_Og_gcc_ijk.csv
grep -i -w ikj dgemm_Og_gcc.csv > dgemm_Og_gcc_ikj.csv
grep -i -w iex dgemm_Og_gcc.csv > dgemm_Og_gcc_iex.csv
grep -i -w unroll4 dgemm_Og_gcc.csv > dgemm_Og_gcc_unroll4.csv
grep -i -w unroll8 dgemm_Og_gcc.csv > dgemm_Og_gcc_unroll8.csv
grep -i -w cblas dgemm_Og_gcc.csv > dgemm_Og_gcc_cblas.csv
rm dgemm_Og_gcc.csv

taskset -c 4 dgemm/./dgemm_Ofast_gcc $n $r > dgemm_Ofast_gcc.csv
grep -i -w ijk dgemm_Ofast_gcc.csv > dgemm_Ofast_gcc_ijk.csv
grep -i -w ikj dgemm_Ofast_gcc.csv > dgemm_Ofast_gcc_ikj.csv
grep -i -w iex dgemm_Ofast_gcc.csv > dgemm_Ofast_gcc_iex.csv
grep -i -w unroll4 dgemm_Ofast_gcc.csv > dgemm_Ofast_gcc_unroll4.csv
grep -i -w unroll8 dgemm_Ofast_gcc.csv > dgemm_Ofast_gcc_unroll8.csv
grep -i -w cblas dgemm_Ofast_gcc.csv > dgemm_Ofast_gcc_cblas.csv
rm dgemm_Ofast_gcc.csv

taskset -c 4 dgemm/./dgemm_O0_clang $n $r > dgemm_O0_clang.csv
grep -i -w ijk dgemm_O0_clang.csv > dgemm_O0_clang_ijk.csv
grep -i -w ikj dgemm_O0_clang.csv > dgemm_O0_clang_ikj.csv
grep -i -w iex dgemm_O0_clang.csv > dgemm_O0_clang_iex.csv
grep -i -w unroll4 dgemm_O0_clang.csv > dgemm_O0_clang_unroll4.csv
grep -i -w unroll8 dgemm_O0_clang.csv > dgemm_O0_clang_unroll8.csv
grep -i -w cblas dgemm_O0_clang.csv > dgemm_O0_clang_cblas.csv
rm dgemm_O0_clang.csv

taskset -c 4 dgemm/./dgemm_O1_clang $n $r > dgemm_O1_clang.csv
grep -i -w ijk dgemm_O1_clang.csv > dgemm_O1_clang_ijk.csv
grep -i -w ikj dgemm_O1_clang.csv > dgemm_O1_clang_ikj.csv
grep -i -w iex dgemm_O1_clang.csv > dgemm_O1_clang_iex.csv
grep -i -w unroll4 dgemm_O1_clang.csv > dgemm_O1_clang_unroll4.csv
grep -i -w unroll8 dgemm_O1_clang.csv > dgemm_O1_clang_unroll8.csv
grep -i -w cblas dgemm_O1_clang.csv > dgemm_O1_clang_cblas.csv
rm dgemm_O1_clang.csv

taskset -c 4 dgemm/./dgemm_O2_clang $n $r > dgemm_O2_clang.csv
grep -i -w ijk dgemm_O2_clang.csv > dgemm_O2_clang_ijk.csv
grep -i -w ikj dgemm_O2_clang.csv > dgemm_O2_clang_ikj.csv
grep -i -w iex dgemm_O2_clang.csv > dgemm_O2_clang_iex.csv
grep -i -w unroll4 dgemm_O2_clang.csv > dgemm_O2_clang_unroll4.csv
grep -i -w unroll8 dgemm_O2_clang.csv > dgemm_O2_clang_unroll8.csv
grep -i -w cblas dgemm_O2_clang.csv > dgemm_O2_clang_cblas.csv
rm dgemm_O2_clang.csv

taskset -c 4 dgemm/./dgemm_O3_clang $n $r > dgemm_O3_clang.csv
grep -i -w ijk dgemm_O3_clang.csv > dgemm_O3_clang_ijk.csv
grep -i -w ikj dgemm_O3_clang.csv > dgemm_O3_clang_ikj.csv
grep -i -w iex dgemm_O3_clang.csv > dgemm_O3_clang_iex.csv
grep -i -w unroll4 dgemm_O3_clang.csv > dgemm_O3_clang_unroll4.csv
grep -i -w unroll8 dgemm_O3_clang.csv > dgemm_O3_clang_unroll8.csv
grep -i -w cblas dgemm_O3_clang.csv > dgemm_O3_clang_cblas.csv
rm dgemm_O3_clang.csv

taskset -c 4 dgemm/./dgemm_Os_clang $n $r > dgemm_Os_clang.csv
grep -i -w ijk dgemm_Os_clang.csv > dgemm_Os_clang_ijk.csv
grep -i -w ikj dgemm_Os_clang.csv > dgemm_Os_clang_ikj.csv
grep -i -w iex dgemm_Os_clang.csv > dgemm_Os_clang_iex.csv
grep -i -w unroll4 dgemm_Os_clang.csv > dgemm_Os_clang_unroll4.csv
grep -i -w unroll8 dgemm_Os_clang.csv > dgemm_Os_clang_unroll8.csv
grep -i -w cblas dgemm_Os_clang.csv > dgemm_Os_clang_cblas.csv
rm dgemm_Os_clang.csv

taskset -c 4 dgemm/./dgemm_Og_clang $n $r > dgemm_Og_clang.csv
grep -i -w ijk dgemm_Og_clang.csv > dgemm_Og_clang_ijk.csv
grep -i -w ikj dgemm_Og_clang.csv > dgemm_Og_clang_ikj.csv
grep -i -w iex dgemm_Og_clang.csv > dgemm_Og_clang_iex.csv
grep -i -w unroll4 dgemm_Og_clang.csv > dgemm_Og_clang_unroll4.csv
grep -i -w unroll8 dgemm_Og_clang.csv > dgemm_Og_clang_unroll8.csv
grep -i -w cblas dgemm_Og_clang.csv > dgemm_Og_clang_cblas.csv
rm dgemm_Og_clang.csv

taskset -c 4 dgemm/./dgemm_Ofast_clang $n $r > dgemm_Ofast_clang.csv
grep -i -w ijk dgemm_Ofast_clang.csv > dgemm_Ofast_clang_ijk.csv
grep -i -w ikj dgemm_Ofast_clang.csv > dgemm_Ofast_clang_ikj.csv
grep -i -w iex dgemm_Ofast_clang.csv > dgemm_Ofast_clang_iex.csv
grep -i -w unroll4 dgemm_Ofast_clang.csv > dgemm_Ofast_clang_unroll4.csv
grep -i -w unroll8 dgemm_Ofast_clang.csv > dgemm_Ofast_clang_unroll8.csv
grep -i -w cblas dgemm_Ofast_clang.csv > dgemm_Ofast_clang_cblas.csv
rm dgemm_Ofast_clang.csv

taskset -c 4 dgemm/./dgemm_O0_icx $n $r > dgemm_O0_icx.csv
grep -i -w ijk dgemm_O0_icx.csv > dgemm_O0_icx_ijk.csv
grep -i -w ikj dgemm_O0_icx.csv > dgemm_O0_icx_ikj.csv
grep -i -w iex dgemm_O0_icx.csv > dgemm_O0_icx_iex.csv
grep -i -w unroll4 dgemm_O0_icx.csv > dgemm_O0_icx_unroll4.csv
grep -i -w unroll8 dgemm_O0_icx.csv > dgemm_O0_icx_unroll8.csv
grep -i -w cblas dgemm_O0_icx.csv > dgemm_O0_icx_cblas.csv
rm dgemm_O0_icx.csv

taskset -c 4 dgemm/./dgemm_O1_icx $n $r > dgemm_O1_icx.csv
grep -i -w ijk dgemm_O1_icx.csv > dgemm_O1_icx_ijk.csv
grep -i -w ikj dgemm_O1_icx.csv > dgemm_O1_icx_ikj.csv
grep -i -w iex dgemm_O1_icx.csv > dgemm_O1_icx_iex.csv
grep -i -w unroll4 dgemm_O1_icx.csv > dgemm_O1_icx_unroll4.csv
grep -i -w unroll8 dgemm_O1_icx.csv > dgemm_O1_icx_unroll8.csv
grep -i -w cblas dgemm_O1_icx.csv > dgemm_O1_icx_cblas.csv
rm dgemm_O1_icx.csv

taskset -c 4 dgemm/./dgemm_O2_icx $n $r > dgemm_O2_icx.csv
grep -i -w ijk dgemm_O2_icx.csv > dgemm_O2_icx_ijk.csv
grep -i -w ikj dgemm_O2_icx.csv > dgemm_O2_icx_ikj.csv
grep -i -w iex dgemm_O2_icx.csv > dgemm_O2_icx_iex.csv
grep -i -w unroll4 dgemm_O2_icx.csv > dgemm_O2_icx_unroll4.csv
grep -i -w unroll8 dgemm_O2_icx.csv > dgemm_O2_icx_unroll8.csv
grep -i -w cblas dgemm_O2_icx.csv > dgemm_O2_icx_cblas.csv
rm dgemm_O2_icx.csv

taskset -c 4 dgemm/./dgemm_O3_icx $n $r > dgemm_O3_icx.csv
grep -i -w ijk dgemm_O3_icx.csv > dgemm_O3_icx_ijk.csv
grep -i -w ikj dgemm_O3_icx.csv > dgemm_O3_icx_ikj.csv
grep -i -w iex dgemm_O3_icx.csv > dgemm_O3_icx_iex.csv
grep -i -w unroll4 dgemm_O3_icx.csv > dgemm_O3_icx_unroll4.csv
grep -i -w unroll8 dgemm_O3_icx.csv > dgemm_O3_icx_unroll8.csv
grep -i -w cblas dgemm_O3_icx.csv > dgemm_O3_icx_cblas.csv
rm dgemm_O3_icx.csv

taskset -c 4 dgemm/./dgemm_Os_icx $n $r > dgemm_Os_icx.csv
grep -i -w ijk dgemm_Os_icx.csv > dgemm_Os_icx_ijk.csv
grep -i -w ikj dgemm_Os_icx.csv > dgemm_Os_icx_ikj.csv
grep -i -w iex dgemm_Os_icx.csv > dgemm_Os_icx_iex.csv
grep -i -w unroll4 dgemm_Os_icx.csv > dgemm_Os_icx_unroll4.csv
grep -i -w unroll8 dgemm_Os_icx.csv > dgemm_Os_icx_unroll8.csv
grep -i -w cblas dgemm_Os_icx.csv > dgemm_Os_icx_cblas.csv
rm dgemm_Os_icx.csv

taskset -c 4 dgemm/./dgemm_Og_icx $n $r > dgemm_Og_icx.csv
grep -i -w ijk dgemm_Og_icx.csv > dgemm_Og_icx_ijk.csv
grep -i -w ikj dgemm_Og_icx.csv > dgemm_Og_icx_ikj.csv
grep -i -w iex dgemm_Og_icx.csv > dgemm_Og_icx_iex.csv
grep -i -w unroll4 dgemm_Og_icx.csv > dgemm_Og_icx_unroll4.csv
grep -i -w unroll8 dgemm_Og_icx.csv > dgemm_Og_icx_unroll8.csv
grep -i -w cblas dgemm_Og_icx.csv > dgemm_Og_icx_cblas.csv
rm dgemm_Og_icx.csv

taskset -c 4 dgemm/./dgemm_Ofast_icx $n $r > dgemm_Ofast_icx.csv
grep -i -w ijk dgemm_Ofast_icx.csv > dgemm_Ofast_icx_ijk.csv
grep -i -w ikj dgemm_Ofast_icx.csv > dgemm_Ofast_icx_ikj.csv
grep -i -w iex dgemm_Ofast_icx.csv > dgemm_Ofast_icx_iex.csv
grep -i -w unroll4 dgemm_Ofast_icx.csv > dgemm_Ofast_icx_unroll4.csv
grep -i -w unroll8 dgemm_Ofast_icx.csv > dgemm_Ofast_icx_unroll8.csv
grep -i -w cblas dgemm_Ofast_icx.csv > dgemm_Ofast_icx_cblas.csv
rm dgemm_Ofast_icx.csv

# DOTPROD :
taskset -c 4 dotprod/./dotprod_O0_gcc $n $r > dotprod_O0_gcc.csv
grep -i -w base dotprod_O0_gcc.csv > dotprod_O0_gcc_base.csv
taskset -c 4 dotprod/./dotprod_O1_gcc $n $r > dotprod_O1_gcc.csv
grep -i -w base dotprod_O1_gcc.csv > dotprod_O1_gcc_base.csv
taskset -c 4 dotprod/./dotprod_O2_gcc $n $r > dotprod_O2_gcc.csv
grep -i -w base dotprod_O2_gcc.csv > dotprod_O2_gcc_base.csv
taskset -c 4 dotprod/./dotprod_O3_gcc $n $r > dotprod_O3_gcc.csv
grep -i -w base dotprod_O3_gcc.csv > dotprod_O3_gcc_base.csv
taskset -c 4 dotprod/./dotprod_Os_gcc $n $r > dotprod_Os_gcc.csv
grep -i -w base dotprod_Os_gcc.csv > dotprod_Os_gcc_base.csv
taskset -c 4 dotprod/./dotprod_Og_gcc $n $r > dotprod_Og_gcc.csv
grep -i -w base dotprod_Og_gcc.csv > dotprod_Og_gcc_base.csv
taskset -c 4 dotprod/./dotprod_Ofast_gcc $n $r > dotprod_Ofast_gcc.csv
grep -i -w base dotprod_Ofast_gcc.csv > dotprod_Ofast_gcc_base.csv

taskset -c 4 dotprod/./dotprod_O0_clang $n $r > dotprod_O0_clang.csv
grep -i -w base dotprod_O0_clang.csv > dotprod_O0_clang_base.csv
taskset -c 4 dotprod/./dotprod_O1_clang $n $r > dotprod_O1_clang.csv
grep -i -w base dotprod_O1_clang.csv > dotprod_O1_clang_base.csv
taskset -c 4 dotprod/./dotprod_O2_clang $n $r > dotprod_O2_clang.csv
grep -i -w base dotprod_O2_clang.csv > dotprod_O2_clang_base.csv
taskset -c 4 dotprod/./dotprod_O3_clang $n $r > dotprod_O3_clang.csv
grep -i -w base dotprod_O3_clang.csv > dotprod_O3_clang_base.csv
taskset -c 4 dotprod/./dotprod_Os_clang $n $r > dotprod_Os_clang.csv
grep -i -w base dotprod_Os_clang.csv > dotprod_Os_clang_base.csv
taskset -c 4 dotprod/./dotprod_Og_clang $n $r > dotprod_Og_clang.csv
grep -i -w base dotprod_Og_clang.csv > dotprod_Og_clang_base.csv
taskset -c 4 dotprod/./dotprod_Ofast_clang $n $r > dotprod_Ofast_clang.csv
grep -i -w base dotprod_Ofast_clang.csv > dotprod_Ofast_clang_base.csv

taskset -c 4 dotprod/./dotprod_O0_icx $n $r > dotprod_O0_icx.csv
grep -i -w base dotprod_O0_icx.csv > dotprod_O0_icx_base.csv
taskset -c 4 dotprod/./dotprod_O1_icx $n $r > dotprod_O1_icx.csv
grep -i -w base dotprod_O1_icx.csv > dotprod_O1_icx_base.csv
taskset -c 4 dotprod/./dotprod_O2_icx $n $r > dotprod_O2_icx.csv
grep -i -w base dotprod_O2_icx.csv > dotprod_O2_icx_base.csv
taskset -c 4 dotprod/./dotprod_O3_icx $n $r > dotprod_O3_icx.csv
grep -i -w base dotprod_O3_icx.csv > dotprod_O3_icx_base.csv
taskset -c 4 dotprod/./dotprod_Os_icx $n $r > dotprod_Os_icx.csv
grep -i -w base dotprod_Os_icx.csv > dotprod_Os_icx_base.csv
taskset -c 4 dotprod/./dotprod_Og_icx $n $r > dotprod_Og_icx.csv
grep -i -w base dotprod_Og_icx.csv > dotprod_Og_icx_base.csv
taskset -c 4 dotprod/./dotprod_Ofast_icx $n $r > dotprod_Ofast_icx.csv
grep -i -w base dotprod_Ofast_icx.csv > dotprod_Ofast_icx_base.csv

# REDUC :
taskset -c 4 reduc/./reduc_O0_gcc $n $r > reduc_O0_gcc.csv
grep -i -w base reduc_O0_gcc.csv > reduc_O0_gcc_base.csv
taskset -c 4 reduc/./reduc_O1_gcc $n $r > reduc_O1_gcc.csv
grep -i -w base reduc_O1_gcc.csv > reduc_O1_gcc_base.csv
taskset -c 4 reduc/./reduc_O2_gcc $n $r > reduc_O2_gcc.csv
grep -i -w base reduc_O2_gcc.csv > reduc_O2_gcc_base.csv
taskset -c 4 reduc/./reduc_O3_gcc $n $r > reduc_O3_gcc.csv
grep -i -w base reduc_O3_gcc.csv > reduc_O3_gcc_base.csv
taskset -c 4 reduc/./reduc_Os_gcc $n $r > reduc_Os_gcc.csv
grep -i -w base reduc_Os_gcc.csv > reduc_Os_gcc_base.csv
taskset -c 4 reduc/./reduc_Og_gcc $n $r > reduc_Og_gcc.csv
grep -i -w base reduc_Og_gcc.csv > reduc_Og_gcc_base.csv
taskset -c 4 reduc/./reduc_Ofast_gcc $n $r > reduc_Ofast_gcc.csv
grep -i -w base reduc_Ofast_gcc.csv > reduc_Ofast_gcc_base.csv

taskset -c 4 reduc/./reduc_O0_clang $n $r > reduc_O0_clang.csv
grep -i -w base reduc_O0_clang.csv > reduc_O0_clang_base.csv
taskset -c 4 reduc/./reduc_O1_clang $n $r > reduc_O1_clang.csv
grep -i -w base reduc_O1_clang.csv > reduc_O1_clang_base.csv
taskset -c 4 reduc/./reduc_O2_clang $n $r > reduc_O2_clang.csv
grep -i -w base reduc_O2_clang.csv > reduc_O2_clang_base.csv
taskset -c 4 reduc/./reduc_O3_clang $n $r > reduc_O3_clang.csv
grep -i -w base reduc_O3_clang.csv > reduc_O3_clang_base.csv
taskset -c 4 reduc/./reduc_Os_clang $n $r > reduc_Os_clang.csv
grep -i -w base reduc_Os_clang.csv > reduc_Os_clang_base.csv
taskset -c 4 reduc/./reduc_Og_clang $n $r > reduc_Og_clang.csv
grep -i -w base reduc_Og_clang.csv > reduc_Og_clang_base.csv
taskset -c 4 reduc/./reduc_Ofast_clang $n $r > reduc_Ofast_clang.csv
grep -i -w base reduc_Ofast_clang.csv > reduc_Ofast_clang_base.csv

taskset -c 4 reduc/./reduc_O0_icx $n $r > reduc_O0_icx.csv
grep -i -w base reduc_O0_icx.csv > reduc_O0_icx_base.csv
taskset -c 4 reduc/./reduc_O1_icx $n $r > reduc_O1_icx.csv
grep -i -w base reduc_O1_icx.csv > reduc_O1_icx_base.csv
taskset -c 4 reduc/./reduc_O2_icx $n $r > reduc_O2_icx.csv
grep -i -w base reduc_O2_icx.csv > reduc_O2_icx_base.csv
taskset -c 4 reduc/./reduc_O3_icx $n $r > reduc_O3_icx.csv
grep -i -w base reduc_O3_icx.csv > reduc_O3_icx_base.csv
taskset -c 4 reduc/./reduc_Os_icx $n $r > reduc_Os_icx.csv
grep -i -w base reduc_Os_icx.csv > reduc_Os_icx_base.csv
taskset -c 4 reduc/./reduc_Og_icx $n $r > reduc_Og_icx.csv
grep -i -w base reduc_Og_icx.csv > reduc_Og_icx_base.csv
taskset -c 4 reduc/./reduc_Ofast_icx $n $r > reduc_Ofast_icx.csv
grep -i -w base reduc_Ofast_icx.csv > reduc_Ofast_icx_base.csv

#Extraction (avec séparateur ";") du champs (bandwidth) des csv vers un csv dédié à la version de calcul et au compilateur
awk -F";" '{print $11}' dgemm_O0_gcc_ijk.csv dgemm_O1_gcc_ijk.csv dgemm_O2_gcc_ijk.csv dgemm_O3_gcc_ijk.csv dgemm_Os_gcc_ijk.csv dgemm_Og_gcc_ijk.csv dgemm_Ofast_gcc_ijk.csv > dgemm_ijk_gcc.csv
awk -F";" '{print $11}' dgemm_O0_gcc_ikj.csv dgemm_O1_gcc_ikj.csv dgemm_O2_gcc_ikj.csv dgemm_O3_gcc_ikj.csv dgemm_Os_gcc_ikj.csv dgemm_Og_gcc_ikj.csv dgemm_Ofast_gcc_ikj.csv > dgemm_ikj_gcc.csv
awk -F";" '{print $11}' dgemm_O0_gcc_iex.csv dgemm_O1_gcc_iex.csv dgemm_O2_gcc_iex.csv dgemm_O3_gcc_iex.csv dgemm_Os_gcc_iex.csv dgemm_Og_gcc_iex.csv dgemm_Ofast_gcc_iex.csv > dgemm_iex_gcc.csv
awk -F";" '{print $11}' dgemm_O0_gcc_unroll4.csv dgemm_O1_gcc_unroll4.csv dgemm_O2_gcc_unroll4.csv dgemm_O3_gcc_unroll4.csv dgemm_Os_gcc_unroll4.csv dgemm_Og_gcc_unroll4.csv dgemm_Ofast_gcc_unroll4.csv > dgemm_unroll4_gcc.csv
awk -F";" '{print $11}' dgemm_O0_gcc_unroll8.csv dgemm_O1_gcc_unroll8.csv dgemm_O2_gcc_unroll8.csv dgemm_O3_gcc_unroll8.csv dgemm_Os_gcc_unroll8.csv dgemm_Og_gcc_unroll8.csv dgemm_Ofast_gcc_unroll8.csv > dgemm_unroll8_gcc.csv
awk -F";" '{print $11}' dgemm_O0_gcc_cblas.csv dgemm_O1_gcc_cblas.csv dgemm_O2_gcc_cblas.csv dgemm_O3_gcc_cblas.csv dgemm_Os_gcc_cblas.csv dgemm_Og_gcc_cblas.csv dgemm_Ofast_gcc_cblas.csv > dgemm_cblas_gcc.csv
awk -F";" '{print $12}' dotprod_O0_gcc_base.csv dotprod_O1_gcc_base.csv dotprod_O2_gcc_base.csv dotprod_O3_gcc_base.csv dotprod_Os_gcc_base.csv dotprod_Og_gcc_base.csv dotprod_Ofast_gcc_base.csv > dotprod_gcc_base.csv
awk -F";" '{print $12}' reduc_O0_gcc_base.csv reduc_O1_gcc_base.csv reduc_O2_gcc_base.csv reduc_O3_gcc_base.csv reduc_Os_gcc_base.csv reduc_Og_gcc_base.csv reduc_Ofast_gcc_base.csv > reduc_gcc_base.csv

awk -F";" '{print $11}' dgemm_O0_clang_ijk.csv dgemm_O1_clang_ijk.csv dgemm_O2_clang_ijk.csv dgemm_O3_clang_ijk.csv dgemm_Os_clang_ijk.csv dgemm_Og_clang_ijk.csv dgemm_Ofast_clang_ijk.csv > dgemm_ijk_clang.csv
awk -F";" '{print $11}' dgemm_O0_clang_ikj.csv dgemm_O1_clang_ikj.csv dgemm_O2_clang_ikj.csv dgemm_O3_clang_ikj.csv dgemm_Os_clang_ikj.csv dgemm_Og_clang_ikj.csv dgemm_Ofast_clang_ikj.csv > dgemm_ikj_clang.csv
awk -F";" '{print $11}' dgemm_O0_clang_iex.csv dgemm_O1_clang_iex.csv dgemm_O2_clang_iex.csv dgemm_O3_clang_iex.csv dgemm_Os_clang_iex.csv dgemm_Og_clang_iex.csv dgemm_Ofast_clang_iex.csv > dgemm_iex_clang.csv
awk -F";" '{print $11}' dgemm_O0_clang_unroll4.csv dgemm_O1_clang_unroll4.csv dgemm_O2_clang_unroll4.csv dgemm_O3_clang_unroll4.csv dgemm_Os_clang_unroll4.csv dgemm_Og_clang_unroll4.csv dgemm_Ofast_clang_unroll4.csv > dgemm_unroll4_clang.csv
awk -F";" '{print $11}' dgemm_O0_clang_unroll8.csv dgemm_O1_clang_unroll8.csv dgemm_O2_clang_unroll8.csv dgemm_O3_clang_unroll8.csv dgemm_Os_clang_unroll8.csv dgemm_Og_clang_unroll8.csv dgemm_Ofast_clang_unroll8.csv > dgemm_unroll8_clang.csv
awk -F";" '{print $11}' dgemm_O0_clang_cblas.csv dgemm_O1_clang_cblas.csv dgemm_O2_clang_cblas.csv dgemm_O3_clang_cblas.csv dgemm_Os_clang_cblas.csv dgemm_Og_clang_cblas.csv dgemm_Ofast_clang_cblas.csv > dgemm_cblas_clang.csv
awk -F";" '{print $12}' dotprod_O0_clang_base.csv dotprod_O1_clang_base.csv dotprod_O2_clang_base.csv dotprod_O3_clang_base.csv dotprod_Os_clang_base.csv dotprod_Og_clang_base.csv dotprod_Ofast_clang_base.csv > dotprod_clang_base.csv
awk -F";" '{print $12}' reduc_O0_clang_base.csv reduc_O1_clang_base.csv reduc_O2_clang_base.csv reduc_O3_clang_base.csv reduc_Os_clang_base.csv reduc_Og_clang_base.csv reduc_Ofast_clang_base.csv > reduc_clang_base.csv

awk -F";" '{print $11}' dgemm_O0_icx_ijk.csv dgemm_O1_icx_ijk.csv dgemm_O2_icx_ijk.csv dgemm_O3_icx_ijk.csv dgemm_Os_icx_ijk.csv dgemm_Og_icx_ijk.csv dgemm_Ofast_icx_ijk.csv > dgemm_ijk_icx.csv
awk -F";" '{print $11}' dgemm_O0_icx_ikj.csv dgemm_O1_icx_ikj.csv dgemm_O2_icx_ikj.csv dgemm_O3_icx_ikj.csv dgemm_Os_icx_ikj.csv dgemm_Og_icx_ikj.csv dgemm_Ofast_icx_ikj.csv > dgemm_ikj_icx.csv
awk -F";" '{print $11}' dgemm_O0_icx_iex.csv dgemm_O1_icx_iex.csv dgemm_O2_icx_iex.csv dgemm_O3_icx_iex.csv dgemm_Os_icx_iex.csv dgemm_Og_icx_iex.csv dgemm_Ofast_icx_iex.csv > dgemm_iex_icx.csv
awk -F";" '{print $11}' dgemm_O0_icx_unroll4.csv dgemm_O1_icx_unroll4.csv dgemm_O2_icx_unroll4.csv dgemm_O3_icx_unroll4.csv dgemm_Os_icx_unroll4.csv dgemm_Og_icx_unroll4.csv dgemm_Ofast_icx_unroll4.csv > dgemm_unroll4_icx.csv
awk -F";" '{print $11}' dgemm_O0_icx_unroll8.csv dgemm_O1_icx_unroll8.csv dgemm_O2_icx_unroll8.csv dgemm_O3_icx_unroll8.csv dgemm_Os_icx_unroll8.csv dgemm_Og_icx_unroll8.csv dgemm_Ofast_icx_unroll8.csv > dgemm_unroll8_icx.csv
awk -F";" '{print $11}' dgemm_O0_icx_cblas.csv dgemm_O1_icx_cblas.csv dgemm_O2_icx_cblas.csv dgemm_O3_icx_cblas.csv dgemm_Os_icx_cblas.csv dgemm_Og_icx_cblas.csv dgemm_Ofast_icx_cblas.csv > dgemm_cblas_icx.csv
awk -F";" '{print $12}' dotprod_O0_icx_base.csv dotprod_O1_icx_base.csv dotprod_O2_icx_base.csv dotprod_O3_icx_base.csv dotprod_Os_icx_base.csv dotprod_Og_icx_base.csv dotprod_Ofast_icx_base.csv > dotprod_icx_base.csv
awk -F";" '{print $12}' reduc_O0_icx_base.csv reduc_O1_icx_base.csv reduc_O2_icx_base.csv reduc_O3_icx_base.csv reduc_Os_icx_base.csv reduc_Og_icx_base.csv reduc_Ofast_icx_base.csv > reduc_icx_base.csv

#(DGEMM) Extraction (avec séparateur ";") du champs (bandwidth) des csv vers un csv dédié à la version de calcul et à l'optimisation de compilation
awk -F";" '{print $11}' dgemm_O0_gcc_ijk.csv dgemm_O0_clang_ijk.csv dgemm_O0_icx_ijk.csv > dgemm_O0_ijk.csv
awk -F";" '{print $11}' dgemm_O0_gcc_ikj.csv dgemm_O0_clang_ikj.csv dgemm_O0_icx_ikj.csv > dgemm_O0_ikj.csv
awk -F";" '{print $11}' dgemm_O0_gcc_iex.csv dgemm_O0_clang_iex.csv dgemm_O0_icx_iex.csv > dgemm_O0_iex.csv
awk -F";" '{print $11}' dgemm_O0_gcc_unroll4.csv dgemm_O0_clang_unroll4.csv dgemm_O0_icx_unroll4.csv > dgemm_O0_unroll4.csv
awk -F";" '{print $11}' dgemm_O0_gcc_unroll8.csv dgemm_O0_clang_unroll8.csv dgemm_O0_icx_unroll8.csv > dgemm_O0_unroll8.csv
awk -F";" '{print $11}' dgemm_O0_gcc_cblas.csv dgemm_O0_clang_cblas.csv dgemm_O0_icx_cblas.csv > dgemm_O0_cblas.csv

awk -F";" '{print $11}' dgemm_O1_gcc_ijk.csv dgemm_O1_clang_ijk.csv dgemm_O1_icx_ijk.csv > dgemm_O1_ijk.csv
awk -F";" '{print $11}' dgemm_O1_gcc_ikj.csv dgemm_O1_clang_ikj.csv dgemm_O1_icx_ikj.csv > dgemm_O1_ikj.csv
awk -F";" '{print $11}' dgemm_O1_gcc_iex.csv dgemm_O1_clang_iex.csv dgemm_O1_icx_iex.csv > dgemm_O1_iex.csv
awk -F";" '{print $11}' dgemm_O1_gcc_unroll4.csv dgemm_O1_clang_unroll4.csv dgemm_O1_icx_unroll4.csv > dgemm_O1_unroll4.csv
awk -F";" '{print $11}' dgemm_O1_gcc_unroll8.csv dgemm_O1_clang_unroll8.csv dgemm_O1_icx_unroll8.csv > dgemm_O1_unroll8.csv
awk -F";" '{print $11}' dgemm_O1_gcc_cblas.csv dgemm_O1_clang_cblas.csv dgemm_O1_icx_cblas.csv > dgemm_O1_cblas.csv

awk -F";" '{print $11}' dgemm_O2_gcc_ijk.csv dgemm_O2_clang_ijk.csv dgemm_O2_icx_ijk.csv > dgemm_O2_ijk.csv
awk -F";" '{print $11}' dgemm_O2_gcc_ikj.csv dgemm_O2_clang_ikj.csv dgemm_O2_icx_ikj.csv > dgemm_O2_ikj.csv
awk -F";" '{print $11}' dgemm_O2_gcc_iex.csv dgemm_O2_clang_iex.csv dgemm_O2_icx_iex.csv > dgemm_O2_iex.csv
awk -F";" '{print $11}' dgemm_O2_gcc_unroll4.csv dgemm_O2_clang_unroll4.csv dgemm_O2_icx_unroll4.csv > dgemm_O2_unroll4.csv
awk -F";" '{print $11}' dgemm_O2_gcc_unroll8.csv dgemm_O2_clang_unroll8.csv dgemm_O2_icx_unroll8.csv > dgemm_O2_unroll8.csv
awk -F";" '{print $11}' dgemm_O2_gcc_cblas.csv dgemm_O2_clang_cblas.csv dgemm_O2_icx_cblas.csv > dgemm_O2_cblas.csv

awk -F";" '{print $11}' dgemm_O3_gcc_ijk.csv dgemm_O3_clang_ijk.csv dgemm_O3_icx_ijk.csv > dgemm_O3_ijk.csv
awk -F";" '{print $11}' dgemm_O3_gcc_ikj.csv dgemm_O3_clang_ikj.csv dgemm_O3_icx_ikj.csv > dgemm_O3_ikj.csv
awk -F";" '{print $11}' dgemm_O3_gcc_iex.csv dgemm_O3_clang_iex.csv dgemm_O3_icx_iex.csv > dgemm_O3_iex.csv
awk -F";" '{print $11}' dgemm_O3_gcc_unroll4.csv dgemm_O3_clang_unroll4.csv dgemm_O3_icx_unroll4.csv > dgemm_O3_unroll4.csv
awk -F";" '{print $11}' dgemm_O3_gcc_unroll8.csv dgemm_O3_clang_unroll8.csv dgemm_O3_icx_unroll8.csv > dgemm_O3_unroll8.csv
awk -F";" '{print $11}' dgemm_O3_gcc_cblas.csv dgemm_O3_clang_cblas.csv dgemm_O3_icx_cblas.csv > dgemm_O3_cblas.csv

awk -F";" '{print $11}' dgemm_Os_gcc_ijk.csv dgemm_Os_clang_ijk.csv dgemm_Os_icx_ijk.csv > dgemm_Os_ijk.csv
awk -F";" '{print $11}' dgemm_Os_gcc_ikj.csv dgemm_Os_clang_ikj.csv dgemm_Os_icx_ikj.csv > dgemm_Os_ikj.csv
awk -F";" '{print $11}' dgemm_Os_gcc_iex.csv dgemm_Os_clang_iex.csv dgemm_Os_icx_iex.csv > dgemm_Os_iex.csv
awk -F";" '{print $11}' dgemm_Os_gcc_unroll4.csv dgemm_Os_clang_unroll4.csv dgemm_Os_icx_unroll4.csv > dgemm_Os_unroll4.csv
awk -F";" '{print $11}' dgemm_Os_gcc_unroll8.csv dgemm_Os_clang_unroll8.csv dgemm_Os_icx_unroll8.csv > dgemm_Os_unroll8.csv
awk -F";" '{print $11}' dgemm_Os_gcc_cblas.csv dgemm_Os_clang_cblas.csv dgemm_Os_icx_cblas.csv > dgemm_Os_cblas.csv

awk -F";" '{print $11}' dgemm_Og_gcc_ijk.csv dgemm_Og_clang_ijk.csv dgemm_Og_icx_ijk.csv > dgemm_Og_ijk.csv
awk -F";" '{print $11}' dgemm_Og_gcc_ikj.csv dgemm_Og_clang_ikj.csv dgemm_Og_icx_ikj.csv > dgemm_Og_ikj.csv
awk -F";" '{print $11}' dgemm_Og_gcc_iex.csv dgemm_Og_clang_iex.csv dgemm_Og_icx_iex.csv > dgemm_Og_iex.csv
awk -F";" '{print $11}' dgemm_Og_gcc_unroll4.csv dgemm_Og_clang_unroll4.csv dgemm_Og_icx_unroll4.csv > dgemm_Og_unroll4.csv
awk -F";" '{print $11}' dgemm_Og_gcc_unroll8.csv dgemm_Og_clang_unroll8.csv dgemm_Og_icx_unroll8.csv > dgemm_Og_unroll8.csv
awk -F";" '{print $11}' dgemm_Og_gcc_cblas.csv dgemm_Og_clang_cblas.csv dgemm_Og_icx_cblas.csv > dgemm_Og_cblas.csv

awk -F";" '{print $11}' dgemm_Ofast_gcc_ijk.csv dgemm_Ofast_clang_ijk.csv dgemm_Ofast_icx_ijk.csv > dgemm_Ofast_ijk.csv
awk -F";" '{print $11}' dgemm_Ofast_gcc_ikj.csv dgemm_Ofast_clang_ikj.csv dgemm_Ofast_icx_ikj.csv > dgemm_Ofast_ikj.csv
awk -F";" '{print $11}' dgemm_Ofast_gcc_iex.csv dgemm_Ofast_clang_iex.csv dgemm_Ofast_icx_iex.csv > dgemm_Ofast_iex.csv
awk -F";" '{print $11}' dgemm_Ofast_gcc_unroll4.csv dgemm_Ofast_clang_unroll4.csv dgemm_Ofast_icx_unroll4.csv > dgemm_Ofast_unroll4.csv
awk -F";" '{print $11}' dgemm_Ofast_gcc_unroll8.csv dgemm_Ofast_clang_unroll8.csv dgemm_Ofast_icx_unroll8.csv > dgemm_Ofast_unroll8.csv
awk -F";" '{print $11}' dgemm_Ofast_gcc_cblas.csv dgemm_Ofast_clang_cblas.csv dgemm_Ofast_icx_cblas.csv > dgemm_Ofast_cblas.csv

#Fusion des csv pour un csv dédié à la version de calcul organisé pour être entré dans gnuplot avec séparateur ","
paste -d, optimisation_de_compilation.csv dgemm_ijk_gcc.csv dgemm_ijk_clang.csv dgemm_ijk_icx.csv > dgemm_ijk.dat
paste -d, optimisation_de_compilation.csv dgemm_ikj_gcc.csv dgemm_ikj_clang.csv dgemm_ikj_icx.csv > dgemm_ikj.dat
paste -d, optimisation_de_compilation.csv dgemm_iex_gcc.csv dgemm_iex_clang.csv dgemm_iex_icx.csv > dgemm_iex.dat
paste -d, optimisation_de_compilation.csv dgemm_unroll4_gcc.csv dgemm_unroll4_clang.csv dgemm_unroll4_icx.csv > dgemm_unroll4.dat
paste -d, optimisation_de_compilation.csv dgemm_unroll8_gcc.csv dgemm_unroll8_clang.csv dgemm_unroll8_icx.csv > dgemm_unroll8.dat
paste -d, optimisation_de_compilation.csv dgemm_cblas_gcc.csv dgemm_cblas_clang.csv dgemm_cblas_icx.csv > dgemm_cblas.dat
paste -d, optimisation_de_compilation.csv dotprod_gcc_base.csv dotprod_clang_base.csv dotprod_icx_base.csv > dotprod.dat
paste -d, optimisation_de_compilation.csv reduc_gcc_base.csv reduc_clang_base.csv reduc_icx_base.csv > reduc.dat
rm optimisation_de_compilation.csv

#Fusion des csv pour un csv dédié à l'optimisation de compilation organisé pour être entré dans gnuplot avec séparateur ","
paste -d, compilateurs.csv dgemm_O0_ijk.csv dgemm_O0_ikj.csv dgemm_O0_iex.csv dgemm_O0_unroll4.csv dgemm_O0_unroll8.csv dgemm_O0_cblas.csv > dgemm_O0.dat
paste -d, compilateurs.csv dgemm_O1_ijk.csv dgemm_O1_ikj.csv dgemm_O1_iex.csv dgemm_O1_unroll4.csv dgemm_O1_unroll8.csv dgemm_O1_cblas.csv > dgemm_O1.dat
paste -d, compilateurs.csv dgemm_O2_ijk.csv dgemm_O2_ikj.csv dgemm_O2_iex.csv dgemm_O2_unroll4.csv dgemm_O2_unroll8.csv dgemm_O2_cblas.csv > dgemm_O2.dat
paste -d, compilateurs.csv dgemm_O3_ijk.csv dgemm_O3_ikj.csv dgemm_O3_iex.csv dgemm_O3_unroll4.csv dgemm_O3_unroll8.csv dgemm_O3_cblas.csv > dgemm_O3.dat
paste -d, compilateurs.csv dgemm_Os_ijk.csv dgemm_Os_ikj.csv dgemm_Os_iex.csv dgemm_Os_unroll4.csv dgemm_Os_unroll8.csv dgemm_Os_cblas.csv > dgemm_Os.dat
paste -d, compilateurs.csv dgemm_Og_ijk.csv dgemm_Og_ikj.csv dgemm_Og_iex.csv dgemm_Og_unroll4.csv dgemm_Og_unroll8.csv dgemm_Og_cblas.csv > dgemm_Og.dat
paste -d, compilateurs.csv dgemm_Ofast_ijk.csv dgemm_Ofast_ikj.csv dgemm_Ofast_iex.csv dgemm_Ofast_unroll4.csv dgemm_Ofast_unroll8.csv dgemm_Ofast_cblas.csv > dgemm_Ofast.dat
rm compilateurs.csv

# Exécution du script gnuplot
gnuplot gnuplot.gp

# Supprimer les exécutables dans /TD2/dgemm depuis /TD2, selon règle clean du Makefile
make clean -C dgemm

# Supprimer les exécutables dans /TD2/dgemm depuis /TD2, selon règle clean du Makefile
make clean -C dotprod

# Supprimer les exécutables dans /TD2/dgemm depuis /TD2, selon règle clean du Makefile
make clean -C reduc

