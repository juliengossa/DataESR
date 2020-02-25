---
title: "Campagne de recrutement synchornisée des enseignants-chercheurs"
author: "Julien Gossa"
date: "25/02/2020"
output: 
  html_document:
    keep_md: true

---



## Information globales

La campagne d'emplois synchronisée de recrutement des enseignants-chercheurs (EC) est la procédure principale de recrutement des EC titulaires. 

Les données sont les suivantes :

- [Galaxy](https://www.galaxie.enseignementsup-recherche.gouv.fr/ensup/ListesPostesPublies/Emplois_publies_TrieParCorps.html)
- [DataESR](https://data.enseignementsup-recherche.gouv.fr/explore/dataset/fr-esr-enseignants-titulaires-esr-public/information/) (seule la dernière année 2017-2018 est utilisée pour les effectifs de référence)

Des versions exploitables sont disponibles ici :

- [Campagne 2018](emplois-ec.2018.csv)
- [Campagne 2019](emplois-ec.2019.csv)
- [Campagne 2020](emplois-ec.2020.csv) (mise à jour le 25/02/2020 à 13h30)
- [Campagnes 2018-2020](emplois-ec.csv)
- [Effectifs 2017-2018](effectifs-ec.csv)
- [Campagne CNU](emplois-ec.cnu.csv)
- [Campagne Etablissements](emplois-ec.2020.csv)

### Nombre d'emplois

Les enseignants-chercheurs titulaires sont divisés en deux corps :

- MCF : Maitres de conférences, qui représente le premier poste titulaire ;
- PR : Professeur des universités.

![](emplois-ec_files/figure-html/global.emplois-1.png)<!-- -->

### Renouvellement

Le renouvellement est défini comme le rapport entre le nombre d'emplois de Maîtres de conférences et les effectifs d'enseignants-chercheurs :

<!-- $renouvellement = \frac{emplois \ MCF}{effectifs \ MCF + PR}$ -->
renouvellement = emplois_MCF / (effectifs_MCF + effectifs_PR)


Le renouvellement peut se lire en pourcents ou en année. Par exemple, un renouvellement de 0.05 peut se lire : « 5% des effectifs sont renouvelés » ou « Au rythme actuel, il faudra 20 ans pour renouveler les effectifs ».

_Attention_ : cette lecture suppose un effectif constant (hypothèse solide à l'heure actuelle). Si on considère une absence de départs (notamment à la retraite), la lecture devient « les effectifs seront augmenté de 5% » ou « Au rythme actuel, il faudra 20 ans pour doubler les effectifs ». La vérité est entre les deux.

![](emplois-ec_files/figure-html/global.renouvellement-1.png)<!-- -->

### Promotion

La promotion est définie comme le rapport entre le nombre d'emplois de Professeurs et les effectifs Maîtres de conférences :

<!-- $promotion = \frac{emplois \ PR}{effectifs \ MCF}$ -->
promotion = emplois_PR / effectifs_MCF

La promotion peut se lire en pourcents ou en année. Par exemple, une promotion de 0.05 peut se lire : « 5% des MCF vont obtenir une promotion PR » ou « Au rythme actuel, il faudra 20 ans pour promouvoir tous les MCF ».

![](emplois-ec_files/figure-html/global.promotion-1.png)<!-- -->



## CNU

### Nombre d'emplois

![](emplois-ec_files/figure-html/cnu.emplois-1.png)<!-- -->

### Renouvellement

_Attention_ : Les données 2018 et 2019 de la section 76 (Théologie Catholique) ont été filtrée pour améliorer la présentation des données (elle présente un renouvellement de 10% en 2018, mais sur un effectif non significatif)

![](emplois-ec_files/figure-html/cnu.renouvellement-1.png)<!-- -->

### Promotion

![](emplois-ec_files/figure-html/cnu.promotion-1.png)<!-- -->

### Tableau

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Section CNU </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Emplois MCF </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Emplois PR </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Effectif MCF </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Effectif PR </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Renouvellement </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Promotion </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;width: 1em; "> 1 </td>
   <td style="text-align:right;width: 1em; "> 53 </td>
   <td style="text-align:right;width: 1em; "> 30 </td>
   <td style="text-align:right;width: 1em; "> 1219 </td>
   <td style="text-align:right;width: 1em; "> 600 </td>
   <td style="text-align:left;"> 2.91%
34 ans </td>
   <td style="text-align:left;"> 2.46%
41 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 2 </td>
   <td style="text-align:right;width: 1em; "> 40 </td>
   <td style="text-align:right;width: 1em; "> 14 </td>
   <td style="text-align:right;width: 1em; "> 813 </td>
   <td style="text-align:right;width: 1em; "> 483 </td>
   <td style="text-align:left;"> 3.09%
32 ans </td>
   <td style="text-align:left;"> 1.72%
58 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 3 </td>
   <td style="text-align:right;width: 1em; "> 5 </td>
   <td style="text-align:right;width: 1em; "> 1 </td>
   <td style="text-align:right;width: 1em; "> 148 </td>
   <td style="text-align:right;width: 1em; "> 109 </td>
   <td style="text-align:left;"> 1.95%
51 ans </td>
   <td style="text-align:left;"> 0.68%
148 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 4 </td>
   <td style="text-align:right;width: 1em; "> 14 </td>
   <td style="text-align:right;width: 1em; "> 5 </td>
   <td style="text-align:right;width: 1em; "> 262 </td>
   <td style="text-align:right;width: 1em; "> 130 </td>
   <td style="text-align:left;"> 3.57%
28 ans </td>
   <td style="text-align:left;"> 1.91%
52 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 5 </td>
   <td style="text-align:right;width: 1em; "> 43 </td>
   <td style="text-align:right;width: 1em; "> 25 </td>
   <td style="text-align:right;width: 1em; "> 1185 </td>
   <td style="text-align:right;width: 1em; "> 547 </td>
   <td style="text-align:left;"> 2.48%
40 ans </td>
   <td style="text-align:left;"> 2.11%
47 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 6 </td>
   <td style="text-align:right;width: 1em; "> 79 </td>
   <td style="text-align:right;width: 1em; "> 20 </td>
   <td style="text-align:right;width: 1em; "> 1627 </td>
   <td style="text-align:right;width: 1em; "> 484 </td>
   <td style="text-align:left;"> 3.74%
27 ans </td>
   <td style="text-align:left;"> 1.23%
81 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 7 </td>
   <td style="text-align:right;width: 1em; "> 26 </td>
   <td style="text-align:right;width: 1em; "> 18 </td>
   <td style="text-align:right;width: 1em; "> 531 </td>
   <td style="text-align:right;width: 1em; "> 240 </td>
   <td style="text-align:left;"> 3.37%
30 ans </td>
   <td style="text-align:left;"> 3.39%
30 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 8 </td>
   <td style="text-align:right;width: 1em; "> 7 </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;width: 1em; "> 189 </td>
   <td style="text-align:right;width: 1em; "> 102 </td>
   <td style="text-align:left;"> 2.41%
42 ans </td>
   <td style="text-align:left;"> 2.12%
47 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 9 </td>
   <td style="text-align:right;width: 1em; "> 24 </td>
   <td style="text-align:right;width: 1em; "> 27 </td>
   <td style="text-align:right;width: 1em; "> 603 </td>
   <td style="text-align:right;width: 1em; "> 320 </td>
   <td style="text-align:left;"> 2.60%
38 ans </td>
   <td style="text-align:left;"> 4.48%
22 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 10 </td>
   <td style="text-align:right;width: 1em; "> 5 </td>
   <td style="text-align:right;width: 1em; "> 0 </td>
   <td style="text-align:right;width: 1em; "> 123 </td>
   <td style="text-align:right;width: 1em; "> 85 </td>
   <td style="text-align:left;"> 2.40%
42 ans </td>
   <td style="text-align:left;"> 0.00%
Inf ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 11 </td>
   <td style="text-align:right;width: 1em; "> 53 </td>
   <td style="text-align:right;width: 1em; "> 21 </td>
   <td style="text-align:right;width: 1em; "> 1293 </td>
   <td style="text-align:right;width: 1em; "> 388 </td>
   <td style="text-align:left;"> 3.15%
32 ans </td>
   <td style="text-align:left;"> 1.62%
62 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 12 </td>
   <td style="text-align:right;width: 1em; "> 6 </td>
   <td style="text-align:right;width: 1em; "> 2 </td>
   <td style="text-align:right;width: 1em; "> 294 </td>
   <td style="text-align:right;width: 1em; "> 93 </td>
   <td style="text-align:left;"> 1.55%
64 ans </td>
   <td style="text-align:left;"> 0.68%
147 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 13 </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;width: 1em; "> 2 </td>
   <td style="text-align:right;width: 1em; "> 91 </td>
   <td style="text-align:right;width: 1em; "> 34 </td>
   <td style="text-align:left;"> 3.20%
31 ans </td>
   <td style="text-align:left;"> 2.20%
46 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 14 </td>
   <td style="text-align:right;width: 1em; "> 18 </td>
   <td style="text-align:right;width: 1em; "> 13 </td>
   <td style="text-align:right;width: 1em; "> 728 </td>
   <td style="text-align:right;width: 1em; "> 238 </td>
   <td style="text-align:left;"> 1.86%
54 ans </td>
   <td style="text-align:left;"> 1.79%
56 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 15 </td>
   <td style="text-align:right;width: 1em; "> 15 </td>
   <td style="text-align:right;width: 1em; "> 12 </td>
   <td style="text-align:right;width: 1em; "> 281 </td>
   <td style="text-align:right;width: 1em; "> 108 </td>
   <td style="text-align:left;"> 3.86%
26 ans </td>
   <td style="text-align:left;"> 4.27%
23 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 16 </td>
   <td style="text-align:right;width: 1em; "> 45 </td>
   <td style="text-align:right;width: 1em; "> 18 </td>
   <td style="text-align:right;width: 1em; "> 963 </td>
   <td style="text-align:right;width: 1em; "> 397 </td>
   <td style="text-align:left;"> 3.31%
30 ans </td>
   <td style="text-align:left;"> 1.87%
54 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 17 </td>
   <td style="text-align:right;width: 1em; "> 18 </td>
   <td style="text-align:right;width: 1em; "> 12 </td>
   <td style="text-align:right;width: 1em; "> 224 </td>
   <td style="text-align:right;width: 1em; "> 160 </td>
   <td style="text-align:left;"> 4.69%
21 ans </td>
   <td style="text-align:left;"> 5.36%
19 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 18 </td>
   <td style="text-align:right;width: 1em; "> 28 </td>
   <td style="text-align:right;width: 1em; "> 12 </td>
   <td style="text-align:right;width: 1em; "> 514 </td>
   <td style="text-align:right;width: 1em; "> 204 </td>
   <td style="text-align:left;"> 3.90%
26 ans </td>
   <td style="text-align:left;"> 2.33%
43 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 19 </td>
   <td style="text-align:right;width: 1em; "> 26 </td>
   <td style="text-align:right;width: 1em; "> 14 </td>
   <td style="text-align:right;width: 1em; "> 627 </td>
   <td style="text-align:right;width: 1em; "> 246 </td>
   <td style="text-align:left;"> 2.98%
34 ans </td>
   <td style="text-align:left;"> 2.23%
45 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 20 </td>
   <td style="text-align:right;width: 1em; "> 5 </td>
   <td style="text-align:right;width: 1em; "> 5 </td>
   <td style="text-align:right;width: 1em; "> 133 </td>
   <td style="text-align:right;width: 1em; "> 71 </td>
   <td style="text-align:left;"> 2.45%
41 ans </td>
   <td style="text-align:left;"> 3.76%
27 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 21 </td>
   <td style="text-align:right;width: 1em; "> 13 </td>
   <td style="text-align:right;width: 1em; "> 13 </td>
   <td style="text-align:right;width: 1em; "> 489 </td>
   <td style="text-align:right;width: 1em; "> 256 </td>
   <td style="text-align:left;"> 1.74%
57 ans </td>
   <td style="text-align:left;"> 2.66%
38 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 22 </td>
   <td style="text-align:right;width: 1em; "> 33 </td>
   <td style="text-align:right;width: 1em; "> 21 </td>
   <td style="text-align:right;width: 1em; "> 663 </td>
   <td style="text-align:right;width: 1em; "> 392 </td>
   <td style="text-align:left;"> 3.13%
32 ans </td>
   <td style="text-align:left;"> 3.17%
32 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 23 </td>
   <td style="text-align:right;width: 1em; "> 24 </td>
   <td style="text-align:right;width: 1em; "> 12 </td>
   <td style="text-align:right;width: 1em; "> 587 </td>
   <td style="text-align:right;width: 1em; "> 265 </td>
   <td style="text-align:left;"> 2.82%
36 ans </td>
   <td style="text-align:left;"> 2.04%
49 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 24 </td>
   <td style="text-align:right;width: 1em; "> 2 </td>
   <td style="text-align:right;width: 1em; "> 2 </td>
   <td style="text-align:right;width: 1em; "> 164 </td>
   <td style="text-align:right;width: 1em; "> 99 </td>
   <td style="text-align:left;"> 0.76%
132 ans </td>
   <td style="text-align:left;"> 1.22%
82 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 25 </td>
   <td style="text-align:right;width: 1em; "> 25 </td>
   <td style="text-align:right;width: 1em; "> 9 </td>
   <td style="text-align:right;width: 1em; "> 823 </td>
   <td style="text-align:right;width: 1em; "> 498 </td>
   <td style="text-align:left;"> 1.89%
53 ans </td>
   <td style="text-align:left;"> 1.09%
91 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 26 </td>
   <td style="text-align:right;width: 1em; "> 41 </td>
   <td style="text-align:right;width: 1em; "> 20 </td>
   <td style="text-align:right;width: 1em; "> 1147 </td>
   <td style="text-align:right;width: 1em; "> 629 </td>
   <td style="text-align:left;"> 2.31%
43 ans </td>
   <td style="text-align:left;"> 1.74%
57 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 27 </td>
   <td style="text-align:right;width: 1em; "> 71 </td>
   <td style="text-align:right;width: 1em; "> 41 </td>
   <td style="text-align:right;width: 1em; "> 2403 </td>
   <td style="text-align:right;width: 1em; "> 968 </td>
   <td style="text-align:left;"> 2.11%
47 ans </td>
   <td style="text-align:left;"> 1.71%
59 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 28 </td>
   <td style="text-align:right;width: 1em; "> 15 </td>
   <td style="text-align:right;width: 1em; "> 19 </td>
   <td style="text-align:right;width: 1em; "> 858 </td>
   <td style="text-align:right;width: 1em; "> 490 </td>
   <td style="text-align:left;"> 1.11%
90 ans </td>
   <td style="text-align:left;"> 2.21%
45 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 29 </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;width: 1em; "> 6 </td>
   <td style="text-align:right;width: 1em; "> 221 </td>
   <td style="text-align:right;width: 1em; "> 175 </td>
   <td style="text-align:left;"> 1.01%
99 ans </td>
   <td style="text-align:left;"> 2.71%
37 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 30 </td>
   <td style="text-align:right;width: 1em; "> 3 </td>
   <td style="text-align:right;width: 1em; "> 3 </td>
   <td style="text-align:right;width: 1em; "> 374 </td>
   <td style="text-align:right;width: 1em; "> 250 </td>
   <td style="text-align:left;"> 0.48%
208 ans </td>
   <td style="text-align:left;"> 0.80%
125 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 31 </td>
   <td style="text-align:right;width: 1em; "> 12 </td>
   <td style="text-align:right;width: 1em; "> 13 </td>
   <td style="text-align:right;width: 1em; "> 668 </td>
   <td style="text-align:right;width: 1em; "> 326 </td>
   <td style="text-align:left;"> 1.21%
83 ans </td>
   <td style="text-align:left;"> 1.95%
51 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 32 </td>
   <td style="text-align:right;width: 1em; "> 9 </td>
   <td style="text-align:right;width: 1em; "> 5 </td>
   <td style="text-align:right;width: 1em; "> 845 </td>
   <td style="text-align:right;width: 1em; "> 388 </td>
   <td style="text-align:left;"> 0.73%
137 ans </td>
   <td style="text-align:left;"> 0.59%
169 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 33 </td>
   <td style="text-align:right;width: 1em; "> 10 </td>
   <td style="text-align:right;width: 1em; "> 6 </td>
   <td style="text-align:right;width: 1em; "> 574 </td>
   <td style="text-align:right;width: 1em; "> 329 </td>
   <td style="text-align:left;"> 1.11%
90 ans </td>
   <td style="text-align:left;"> 1.05%
96 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 34 </td>
   <td style="text-align:right;width: 1em; "> 0 </td>
   <td style="text-align:right;width: 1em; "> 1 </td>
   <td style="text-align:right;width: 1em; "> 116 </td>
   <td style="text-align:right;width: 1em; "> 69 </td>
   <td style="text-align:left;"> 0.00%
Inf ans </td>
   <td style="text-align:left;"> 0.86%
116 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 35 </td>
   <td style="text-align:right;width: 1em; "> 18 </td>
   <td style="text-align:right;width: 1em; "> 7 </td>
   <td style="text-align:right;width: 1em; "> 330 </td>
   <td style="text-align:right;width: 1em; "> 179 </td>
   <td style="text-align:left;"> 3.54%
28 ans </td>
   <td style="text-align:left;"> 2.12%
47 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 36 </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;width: 1em; "> 268 </td>
   <td style="text-align:right;width: 1em; "> 125 </td>
   <td style="text-align:left;"> 1.02%
98 ans </td>
   <td style="text-align:left;"> 1.49%
67 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 37 </td>
   <td style="text-align:right;width: 1em; "> 1 </td>
   <td style="text-align:right;width: 1em; "> 6 </td>
   <td style="text-align:right;width: 1em; "> 132 </td>
   <td style="text-align:right;width: 1em; "> 59 </td>
   <td style="text-align:left;"> 0.52%
191 ans </td>
   <td style="text-align:left;"> 4.55%
22 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 60 </td>
   <td style="text-align:right;width: 1em; "> 39 </td>
   <td style="text-align:right;width: 1em; "> 33 </td>
   <td style="text-align:right;width: 1em; "> 1607 </td>
   <td style="text-align:right;width: 1em; "> 784 </td>
   <td style="text-align:left;"> 1.63%
61 ans </td>
   <td style="text-align:left;"> 2.05%
49 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 61 </td>
   <td style="text-align:right;width: 1em; "> 33 </td>
   <td style="text-align:right;width: 1em; "> 16 </td>
   <td style="text-align:right;width: 1em; "> 1206 </td>
   <td style="text-align:right;width: 1em; "> 548 </td>
   <td style="text-align:left;"> 1.88%
53 ans </td>
   <td style="text-align:left;"> 1.33%
75 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 62 </td>
   <td style="text-align:right;width: 1em; "> 15 </td>
   <td style="text-align:right;width: 1em; "> 12 </td>
   <td style="text-align:right;width: 1em; "> 703 </td>
   <td style="text-align:right;width: 1em; "> 393 </td>
   <td style="text-align:left;"> 1.37%
73 ans </td>
   <td style="text-align:left;"> 1.71%
59 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 63 </td>
   <td style="text-align:right;width: 1em; "> 28 </td>
   <td style="text-align:right;width: 1em; "> 22 </td>
   <td style="text-align:right;width: 1em; "> 1117 </td>
   <td style="text-align:right;width: 1em; "> 571 </td>
   <td style="text-align:left;"> 1.66%
60 ans </td>
   <td style="text-align:left;"> 1.97%
51 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 64 </td>
   <td style="text-align:right;width: 1em; "> 24 </td>
   <td style="text-align:right;width: 1em; "> 13 </td>
   <td style="text-align:right;width: 1em; "> 773 </td>
   <td style="text-align:right;width: 1em; "> 296 </td>
   <td style="text-align:left;"> 2.25%
45 ans </td>
   <td style="text-align:left;"> 1.68%
59 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 65 </td>
   <td style="text-align:right;width: 1em; "> 21 </td>
   <td style="text-align:right;width: 1em; "> 10 </td>
   <td style="text-align:right;width: 1em; "> 752 </td>
   <td style="text-align:right;width: 1em; "> 274 </td>
   <td style="text-align:left;"> 2.05%
49 ans </td>
   <td style="text-align:left;"> 1.33%
75 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 66 </td>
   <td style="text-align:right;width: 1em; "> 6 </td>
   <td style="text-align:right;width: 1em; "> 2 </td>
   <td style="text-align:right;width: 1em; "> 544 </td>
   <td style="text-align:right;width: 1em; "> 197 </td>
   <td style="text-align:left;"> 0.81%
124 ans </td>
   <td style="text-align:left;"> 0.37%
272 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 67 </td>
   <td style="text-align:right;width: 1em; "> 12 </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;width: 1em; "> 499 </td>
   <td style="text-align:right;width: 1em; "> 195 </td>
   <td style="text-align:left;"> 1.73%
58 ans </td>
   <td style="text-align:left;"> 0.80%
125 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 68 </td>
   <td style="text-align:right;width: 1em; "> 1 </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;width: 1em; "> 344 </td>
   <td style="text-align:right;width: 1em; "> 153 </td>
   <td style="text-align:left;"> 0.20%
497 ans </td>
   <td style="text-align:left;"> 1.16%
86 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 69 </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;width: 1em; "> 3 </td>
   <td style="text-align:right;width: 1em; "> 287 </td>
   <td style="text-align:right;width: 1em; "> 118 </td>
   <td style="text-align:left;"> 0.99%
101 ans </td>
   <td style="text-align:left;"> 1.05%
96 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 70 </td>
   <td style="text-align:right;width: 1em; "> 30 </td>
   <td style="text-align:right;width: 1em; "> 17 </td>
   <td style="text-align:right;width: 1em; "> 504 </td>
   <td style="text-align:right;width: 1em; "> 173 </td>
   <td style="text-align:left;"> 4.43%
23 ans </td>
   <td style="text-align:left;"> 3.37%
30 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 71 </td>
   <td style="text-align:right;width: 1em; "> 28 </td>
   <td style="text-align:right;width: 1em; "> 9 </td>
   <td style="text-align:right;width: 1em; "> 613 </td>
   <td style="text-align:right;width: 1em; "> 170 </td>
   <td style="text-align:left;"> 3.58%
28 ans </td>
   <td style="text-align:left;"> 1.47%
68 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 72 </td>
   <td style="text-align:right;width: 1em; "> 2 </td>
   <td style="text-align:right;width: 1em; "> 1 </td>
   <td style="text-align:right;width: 1em; "> 66 </td>
   <td style="text-align:right;width: 1em; "> 22 </td>
   <td style="text-align:left;"> 2.27%
44 ans </td>
   <td style="text-align:left;"> 1.52%
66 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 73 </td>
   <td style="text-align:right;width: 1em; "> 1 </td>
   <td style="text-align:right;width: 1em; "> 2 </td>
   <td style="text-align:right;width: 1em; "> 34 </td>
   <td style="text-align:right;width: 1em; "> 22 </td>
   <td style="text-align:left;"> 1.79%
56 ans </td>
   <td style="text-align:left;"> 5.88%
17 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 74 </td>
   <td style="text-align:right;width: 1em; "> 40 </td>
   <td style="text-align:right;width: 1em; "> 13 </td>
   <td style="text-align:right;width: 1em; "> 642 </td>
   <td style="text-align:right;width: 1em; "> 166 </td>
   <td style="text-align:left;"> 4.95%
20 ans </td>
   <td style="text-align:left;"> 2.02%
49 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 85 </td>
   <td style="text-align:right;width: 1em; "> 3 </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;width: 1em; "> 323 </td>
   <td style="text-align:right;width: 1em; "> 110 </td>
   <td style="text-align:left;"> 0.69%
144 ans </td>
   <td style="text-align:left;"> 1.24%
81 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 86 </td>
   <td style="text-align:right;width: 1em; "> 17 </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;width: 1em; "> 389 </td>
   <td style="text-align:right;width: 1em; "> 180 </td>
   <td style="text-align:left;"> 2.99%
33 ans </td>
   <td style="text-align:left;"> 1.03%
97 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 87 </td>
   <td style="text-align:right;width: 1em; "> 11 </td>
   <td style="text-align:right;width: 1em; "> 6 </td>
   <td style="text-align:right;width: 1em; "> 300 </td>
   <td style="text-align:right;width: 1em; "> 95 </td>
   <td style="text-align:left;"> 2.78%
36 ans </td>
   <td style="text-align:left;"> 2.00%
50 ans </td>
  </tr>
</tbody>
</table>


