---
title: "Campagne de recrutement synchornisée des enseignants-chercheurs"
author: "Julien Gossa"
date: "24/02/2020"
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
- [Campagne 2020](emplois-ec.2020.csv)
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
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Rentrée </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Section </th>
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
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:right;"> 56 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 1219 </td>
   <td style="text-align:right;"> 600 </td>
   <td style="text-align:left;"> 3.08%
32 ans </td>
   <td style="text-align:left;"> 2.13%
47 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 813 </td>
   <td style="text-align:right;"> 483 </td>
   <td style="text-align:left;"> 1.77%
56 ans </td>
   <td style="text-align:left;"> 2.34%
43 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 148 </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:left;"> 1.56%
64 ans </td>
   <td style="text-align:left;"> 1.35%
74 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 262 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:left;"> 5.10%
20 ans </td>
   <td style="text-align:left;"> 1.53%
66 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 1185 </td>
   <td style="text-align:right;"> 547 </td>
   <td style="text-align:left;"> 2.14%
47 ans </td>
   <td style="text-align:left;"> 2.03%
49 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 1627 </td>
   <td style="text-align:right;"> 484 </td>
   <td style="text-align:left;"> 4.03%
25 ans </td>
   <td style="text-align:left;"> 2.21%
45 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 531 </td>
   <td style="text-align:right;"> 240 </td>
   <td style="text-align:left;"> 3.37%
30 ans </td>
   <td style="text-align:left;"> 2.45%
41 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 189 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:left;"> 1.72%
58 ans </td>
   <td style="text-align:left;"> 3.70%
27 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 603 </td>
   <td style="text-align:right;"> 320 </td>
   <td style="text-align:left;"> 2.82%
36 ans </td>
   <td style="text-align:left;"> 3.81%
26 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:left;"> 2.88%
35 ans </td>
   <td style="text-align:left;"> 0.81%
123 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 1293 </td>
   <td style="text-align:right;"> 388 </td>
   <td style="text-align:left;"> 2.91%
34 ans </td>
   <td style="text-align:left;"> 1.78%
56 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 294 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:left;"> 2.84%
35 ans </td>
   <td style="text-align:left;"> 1.36%
74 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:left;"> 4.80%
21 ans </td>
   <td style="text-align:left;"> 3.30%
30 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 728 </td>
   <td style="text-align:right;"> 238 </td>
   <td style="text-align:left;"> 2.80%
36 ans </td>
   <td style="text-align:left;"> 1.65%
61 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 281 </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:left;"> 5.40%
19 ans </td>
   <td style="text-align:left;"> 1.07%
94 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 963 </td>
   <td style="text-align:right;"> 397 </td>
   <td style="text-align:left;"> 3.24%
31 ans </td>
   <td style="text-align:left;"> 1.87%
54 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 224 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:left;"> 3.91%
26 ans </td>
   <td style="text-align:left;"> 4.46%
22 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 514 </td>
   <td style="text-align:right;"> 204 </td>
   <td style="text-align:left;"> 3.76%
27 ans </td>
   <td style="text-align:left;"> 1.95%
51 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 627 </td>
   <td style="text-align:right;"> 246 </td>
   <td style="text-align:left;"> 2.52%
40 ans </td>
   <td style="text-align:left;"> 2.71%
37 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 133 </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:left;"> 2.45%
41 ans </td>
   <td style="text-align:left;"> 1.50%
66 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 489 </td>
   <td style="text-align:right;"> 256 </td>
   <td style="text-align:left;"> 1.61%
62 ans </td>
   <td style="text-align:left;"> 4.70%
21 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 663 </td>
   <td style="text-align:right;"> 392 </td>
   <td style="text-align:left;"> 2.37%
42 ans </td>
   <td style="text-align:left;"> 3.47%
29 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 587 </td>
   <td style="text-align:right;"> 265 </td>
   <td style="text-align:left;"> 2.70%
37 ans </td>
   <td style="text-align:left;"> 1.19%
84 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 164 </td>
   <td style="text-align:right;"> 99 </td>
   <td style="text-align:left;"> 2.28%
44 ans </td>
   <td style="text-align:left;"> 1.22%
82 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 823 </td>
   <td style="text-align:right;"> 498 </td>
   <td style="text-align:left;"> 1.59%
63 ans </td>
   <td style="text-align:left;"> 1.70%
59 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 1147 </td>
   <td style="text-align:right;"> 629 </td>
   <td style="text-align:left;"> 1.52%
66 ans </td>
   <td style="text-align:left;"> 2.18%
46 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 2403 </td>
   <td style="text-align:right;"> 968 </td>
   <td style="text-align:left;"> 1.90%
53 ans </td>
   <td style="text-align:left;"> 1.37%
73 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 858 </td>
   <td style="text-align:right;"> 490 </td>
   <td style="text-align:left;"> 0.52%
193 ans </td>
   <td style="text-align:left;"> 1.05%
95 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 221 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:left;"> 1.01%
99 ans </td>
   <td style="text-align:left;"> 0.90%
110 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 374 </td>
   <td style="text-align:right;"> 250 </td>
   <td style="text-align:left;"> 1.60%
62 ans </td>
   <td style="text-align:left;"> 0.80%
125 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 668 </td>
   <td style="text-align:right;"> 326 </td>
   <td style="text-align:left;"> 1.11%
90 ans </td>
   <td style="text-align:left;"> 1.80%
56 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 845 </td>
   <td style="text-align:right;"> 388 </td>
   <td style="text-align:left;"> 1.14%
88 ans </td>
   <td style="text-align:left;"> 0.71%
141 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 574 </td>
   <td style="text-align:right;"> 329 </td>
   <td style="text-align:left;"> 1.00%
100 ans </td>
   <td style="text-align:left;"> 1.05%
96 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 116 </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:left;"> 1.08%
92 ans </td>
   <td style="text-align:left;"> 3.45%
29 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 330 </td>
   <td style="text-align:right;"> 179 </td>
   <td style="text-align:left;"> 1.38%
73 ans </td>
   <td style="text-align:left;"> 2.12%
47 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 268 </td>
   <td style="text-align:right;"> 125 </td>
   <td style="text-align:left;"> 0.76%
131 ans </td>
   <td style="text-align:left;"> 1.49%
67 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 132 </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:left;"> 1.05%
96 ans </td>
   <td style="text-align:left;"> 1.52%
66 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 1607 </td>
   <td style="text-align:right;"> 784 </td>
   <td style="text-align:left;"> 2.26%
44 ans </td>
   <td style="text-align:left;"> 1.12%
89 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 61 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 1206 </td>
   <td style="text-align:right;"> 548 </td>
   <td style="text-align:left;"> 1.48%
67 ans </td>
   <td style="text-align:left;"> 1.16%
86 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 62 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 703 </td>
   <td style="text-align:right;"> 393 </td>
   <td style="text-align:left;"> 1.46%
68 ans </td>
   <td style="text-align:left;"> 1.00%
100 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 63 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 1117 </td>
   <td style="text-align:right;"> 571 </td>
   <td style="text-align:left;"> 1.24%
80 ans </td>
   <td style="text-align:left;"> 0.98%
102 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 64 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 773 </td>
   <td style="text-align:right;"> 296 </td>
   <td style="text-align:left;"> 1.96%
51 ans </td>
   <td style="text-align:left;"> 1.68%
59 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 65 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 752 </td>
   <td style="text-align:right;"> 274 </td>
   <td style="text-align:left;"> 1.66%
60 ans </td>
   <td style="text-align:left;"> 0.93%
107 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 66 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 544 </td>
   <td style="text-align:right;"> 197 </td>
   <td style="text-align:left;"> 0.67%
148 ans </td>
   <td style="text-align:left;"> 0.92%
109 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 67 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 499 </td>
   <td style="text-align:right;"> 195 </td>
   <td style="text-align:left;"> 2.02%
50 ans </td>
   <td style="text-align:left;"> 1.40%
71 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 68 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 344 </td>
   <td style="text-align:right;"> 153 </td>
   <td style="text-align:left;"> 1.21%
83 ans </td>
   <td style="text-align:left;"> 0.58%
172 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 69 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 287 </td>
   <td style="text-align:right;"> 118 </td>
   <td style="text-align:left;"> 1.48%
68 ans </td>
   <td style="text-align:left;"> 0.70%
144 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 70 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 504 </td>
   <td style="text-align:right;"> 173 </td>
   <td style="text-align:left;"> 5.17%
19 ans </td>
   <td style="text-align:left;"> 3.57%
28 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 71 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 613 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:left;"> 4.47%
22 ans </td>
   <td style="text-align:left;"> 0.82%
123 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 72 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> 1.14%
88 ans </td>
   <td style="text-align:left;"> 0.00%
Inf ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 73 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> 1.79%
56 ans </td>
   <td style="text-align:left;"> 5.88%
17 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 74 </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 642 </td>
   <td style="text-align:right;"> 166 </td>
   <td style="text-align:left;"> 4.46%
22 ans </td>
   <td style="text-align:left;"> 2.34%
43 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 76 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> 10.00%
10 ans </td>
   <td style="text-align:left;"> 0.00%
Inf ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 85 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 323 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:left;"> 1.62%
62 ans </td>
   <td style="text-align:left;"> 0.93%
108 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 86 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 389 </td>
   <td style="text-align:right;"> 180 </td>
   <td style="text-align:left;"> 2.28%
44 ans </td>
   <td style="text-align:left;"> 1.29%
78 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:left;"> 87 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 300 </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:left;"> 0.76%
132 ans </td>
   <td style="text-align:left;"> 1.00%
100 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 1219 </td>
   <td style="text-align:right;"> 600 </td>
   <td style="text-align:left;"> 2.75%
36 ans </td>
   <td style="text-align:left;"> 2.05%
49 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 813 </td>
   <td style="text-align:right;"> 483 </td>
   <td style="text-align:left;"> 3.24%
31 ans </td>
   <td style="text-align:left;"> 2.83%
35 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 148 </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:left;"> 2.33%
43 ans </td>
   <td style="text-align:left;"> 2.03%
49 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 262 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:left;"> 3.32%
30 ans </td>
   <td style="text-align:left;"> 0.38%
262 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 1185 </td>
   <td style="text-align:right;"> 547 </td>
   <td style="text-align:left;"> 2.54%
39 ans </td>
   <td style="text-align:left;"> 1.52%
66 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 1627 </td>
   <td style="text-align:right;"> 484 </td>
   <td style="text-align:left;"> 3.65%
27 ans </td>
   <td style="text-align:left;"> 2.15%
46 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 531 </td>
   <td style="text-align:right;"> 240 </td>
   <td style="text-align:left;"> 1.95%
51 ans </td>
   <td style="text-align:left;"> 3.39%
30 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 189 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:left;"> 2.41%
42 ans </td>
   <td style="text-align:left;"> 1.59%
63 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 603 </td>
   <td style="text-align:right;"> 320 </td>
   <td style="text-align:left;"> 2.28%
44 ans </td>
   <td style="text-align:left;"> 4.15%
24 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:left;"> 0.96%
104 ans </td>
   <td style="text-align:left;"> 3.25%
31 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 1293 </td>
   <td style="text-align:right;"> 388 </td>
   <td style="text-align:left;"> 3.03%
33 ans </td>
   <td style="text-align:left;"> 1.70%
59 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 294 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:left;"> 1.03%
97 ans </td>
   <td style="text-align:left;"> 0.00%
Inf ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:left;"> 1.60%
62 ans </td>
   <td style="text-align:left;"> 0.00%
Inf ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 728 </td>
   <td style="text-align:right;"> 238 </td>
   <td style="text-align:left;"> 2.07%
48 ans </td>
   <td style="text-align:left;"> 2.20%
46 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 281 </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:left;"> 4.37%
23 ans </td>
   <td style="text-align:left;"> 2.49%
40 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 963 </td>
   <td style="text-align:right;"> 397 </td>
   <td style="text-align:left;"> 3.90%
26 ans </td>
   <td style="text-align:left;"> 1.45%
69 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 224 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:left;"> 2.60%
38 ans </td>
   <td style="text-align:left;"> 4.02%
25 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 514 </td>
   <td style="text-align:right;"> 204 </td>
   <td style="text-align:left;"> 2.79%
36 ans </td>
   <td style="text-align:left;"> 3.70%
27 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 627 </td>
   <td style="text-align:right;"> 246 </td>
   <td style="text-align:left;"> 3.44%
29 ans </td>
   <td style="text-align:left;"> 2.07%
48 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 133 </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:left;"> 1.47%
68 ans </td>
   <td style="text-align:left;"> 3.01%
33 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 489 </td>
   <td style="text-align:right;"> 256 </td>
   <td style="text-align:left;"> 2.28%
44 ans </td>
   <td style="text-align:left;"> 1.84%
54 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 663 </td>
   <td style="text-align:right;"> 392 </td>
   <td style="text-align:left;"> 1.90%
53 ans </td>
   <td style="text-align:left;"> 2.87%
35 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 587 </td>
   <td style="text-align:right;"> 265 </td>
   <td style="text-align:left;"> 1.53%
66 ans </td>
   <td style="text-align:left;"> 1.36%
73 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 164 </td>
   <td style="text-align:right;"> 99 </td>
   <td style="text-align:left;"> 2.28%
44 ans </td>
   <td style="text-align:left;"> 1.83%
55 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 823 </td>
   <td style="text-align:right;"> 498 </td>
   <td style="text-align:left;"> 1.67%
60 ans </td>
   <td style="text-align:left;"> 1.82%
55 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 1147 </td>
   <td style="text-align:right;"> 629 </td>
   <td style="text-align:left;"> 2.25%
44 ans </td>
   <td style="text-align:left;"> 1.57%
64 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 2403 </td>
   <td style="text-align:right;"> 968 </td>
   <td style="text-align:left;"> 1.93%
52 ans </td>
   <td style="text-align:left;"> 1.62%
62 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 858 </td>
   <td style="text-align:right;"> 490 </td>
   <td style="text-align:left;"> 0.59%
168 ans </td>
   <td style="text-align:left;"> 2.56%
39 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 221 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:left;"> 1.01%
99 ans </td>
   <td style="text-align:left;"> 0.90%
110 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 374 </td>
   <td style="text-align:right;"> 250 </td>
   <td style="text-align:left;"> 0.48%
208 ans </td>
   <td style="text-align:left;"> 1.07%
94 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 668 </td>
   <td style="text-align:right;"> 326 </td>
   <td style="text-align:left;"> 1.51%
66 ans </td>
   <td style="text-align:left;"> 1.65%
61 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 845 </td>
   <td style="text-align:right;"> 388 </td>
   <td style="text-align:left;"> 0.73%
137 ans </td>
   <td style="text-align:left;"> 0.36%
282 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 574 </td>
   <td style="text-align:right;"> 329 </td>
   <td style="text-align:left;"> 0.33%
301 ans </td>
   <td style="text-align:left;"> 1.05%
96 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 116 </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:left;"> 2.16%
46 ans </td>
   <td style="text-align:left;"> 3.45%
29 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 330 </td>
   <td style="text-align:right;"> 179 </td>
   <td style="text-align:left;"> 1.77%
57 ans </td>
   <td style="text-align:left;"> 2.42%
41 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 268 </td>
   <td style="text-align:right;"> 125 </td>
   <td style="text-align:left;"> 0.00%
Inf ans </td>
   <td style="text-align:left;"> 0.75%
134 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 132 </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:left;"> 0.52%
191 ans </td>
   <td style="text-align:left;"> 0.76%
132 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 1607 </td>
   <td style="text-align:right;"> 784 </td>
   <td style="text-align:left;"> 2.13%
47 ans </td>
   <td style="text-align:left;"> 1.56%
64 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 61 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 1206 </td>
   <td style="text-align:right;"> 548 </td>
   <td style="text-align:left;"> 1.88%
53 ans </td>
   <td style="text-align:left;"> 1.66%
60 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 62 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 703 </td>
   <td style="text-align:right;"> 393 </td>
   <td style="text-align:left;"> 0.91%
110 ans </td>
   <td style="text-align:left;"> 1.14%
88 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 63 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 1117 </td>
   <td style="text-align:right;"> 571 </td>
   <td style="text-align:left;"> 1.18%
84 ans </td>
   <td style="text-align:left;"> 1.16%
86 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 64 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 773 </td>
   <td style="text-align:right;"> 296 </td>
   <td style="text-align:left;"> 1.96%
51 ans </td>
   <td style="text-align:left;"> 1.55%
64 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 65 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 752 </td>
   <td style="text-align:right;"> 274 </td>
   <td style="text-align:left;"> 1.27%
79 ans </td>
   <td style="text-align:left;"> 0.66%
150 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 66 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 544 </td>
   <td style="text-align:right;"> 197 </td>
   <td style="text-align:left;"> 0.54%
185 ans </td>
   <td style="text-align:left;"> 1.10%
91 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 67 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 499 </td>
   <td style="text-align:right;"> 195 </td>
   <td style="text-align:left;"> 1.15%
87 ans </td>
   <td style="text-align:left;"> 0.60%
166 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 68 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 344 </td>
   <td style="text-align:right;"> 153 </td>
   <td style="text-align:left;"> 0.80%
124 ans </td>
   <td style="text-align:left;"> 0.87%
115 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 69 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 287 </td>
   <td style="text-align:right;"> 118 </td>
   <td style="text-align:left;"> 1.98%
51 ans </td>
   <td style="text-align:left;"> 1.39%
72 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 70 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 504 </td>
   <td style="text-align:right;"> 173 </td>
   <td style="text-align:left;"> 5.02%
20 ans </td>
   <td style="text-align:left;"> 2.98%
34 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 71 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 613 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:left;"> 3.19%
31 ans </td>
   <td style="text-align:left;"> 1.47%
68 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 72 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> 1.14%
88 ans </td>
   <td style="text-align:left;"> 1.52%
66 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 73 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> 3.57%
28 ans </td>
   <td style="text-align:left;"> 2.94%
34 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 74 </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 642 </td>
   <td style="text-align:right;"> 166 </td>
   <td style="text-align:left;"> 5.69%
18 ans </td>
   <td style="text-align:left;"> 1.09%
92 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 76 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> 0.00%
Inf ans </td>
   <td style="text-align:left;"> 5.88%
17 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 85 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 323 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:left;"> 3.00%
33 ans </td>
   <td style="text-align:left;"> 1.24%
81 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 86 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 389 </td>
   <td style="text-align:right;"> 180 </td>
   <td style="text-align:left;"> 1.58%
63 ans </td>
   <td style="text-align:left;"> 1.80%
56 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> 87 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 300 </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:left;"> 0.25%
395 ans </td>
   <td style="text-align:left;"> 1.00%
100 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 1219 </td>
   <td style="text-align:right;"> 600 </td>
   <td style="text-align:left;"> 1.70%
59 ans </td>
   <td style="text-align:left;"> 1.31%
76 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 813 </td>
   <td style="text-align:right;"> 483 </td>
   <td style="text-align:left;"> 1.77%
56 ans </td>
   <td style="text-align:left;"> 0.98%
102 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 148 </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:left;"> 1.56%
64 ans </td>
   <td style="text-align:left;"> 0.68%
148 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 262 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:left;"> 2.55%
39 ans </td>
   <td style="text-align:left;"> 1.53%
66 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 1185 </td>
   <td style="text-align:right;"> 547 </td>
   <td style="text-align:left;"> 1.67%
60 ans </td>
   <td style="text-align:left;"> 1.35%
74 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1627 </td>
   <td style="text-align:right;"> 484 </td>
   <td style="text-align:left;"> 1.94%
51 ans </td>
   <td style="text-align:left;"> 0.61%
163 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 531 </td>
   <td style="text-align:right;"> 240 </td>
   <td style="text-align:left;"> 1.95%
51 ans </td>
   <td style="text-align:left;"> 2.64%
38 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 189 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:left;"> 1.72%
58 ans </td>
   <td style="text-align:left;"> 1.06%
94 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 603 </td>
   <td style="text-align:right;"> 320 </td>
   <td style="text-align:left;"> 1.41%
71 ans </td>
   <td style="text-align:left;"> 3.32%
30 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:left;"> 0.96%
104 ans </td>
   <td style="text-align:left;"> 0.00%
Inf ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 1293 </td>
   <td style="text-align:right;"> 388 </td>
   <td style="text-align:left;"> 2.08%
48 ans </td>
   <td style="text-align:left;"> 1.01%
99 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 294 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:left;"> 1.29%
77 ans </td>
   <td style="text-align:left;"> 0.68%
147 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:left;"> 1.60%
62 ans </td>
   <td style="text-align:left;"> 2.20%
46 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 728 </td>
   <td style="text-align:right;"> 238 </td>
   <td style="text-align:left;"> 0.93%
107 ans </td>
   <td style="text-align:left;"> 0.82%
121 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 281 </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:left;"> 2.31%
43 ans </td>
   <td style="text-align:left;"> 3.91%
26 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 963 </td>
   <td style="text-align:right;"> 397 </td>
   <td style="text-align:left;"> 1.76%
57 ans </td>
   <td style="text-align:left;"> 1.04%
96 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 224 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:left;"> 4.17%
24 ans </td>
   <td style="text-align:left;"> 3.57%
28 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 514 </td>
   <td style="text-align:right;"> 204 </td>
   <td style="text-align:left;"> 1.81%
55 ans </td>
   <td style="text-align:left;"> 1.36%
73 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 627 </td>
   <td style="text-align:right;"> 246 </td>
   <td style="text-align:left;"> 1.83%
55 ans </td>
   <td style="text-align:left;"> 1.28%
78 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 133 </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:left;"> 1.96%
51 ans </td>
   <td style="text-align:left;"> 3.01%
33 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 489 </td>
   <td style="text-align:right;"> 256 </td>
   <td style="text-align:left;"> 1.48%
68 ans </td>
   <td style="text-align:left;"> 2.04%
49 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 663 </td>
   <td style="text-align:right;"> 392 </td>
   <td style="text-align:left;"> 1.99%
50 ans </td>
   <td style="text-align:left;"> 2.26%
44 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 587 </td>
   <td style="text-align:right;"> 265 </td>
   <td style="text-align:left;"> 2.11%
47 ans </td>
   <td style="text-align:left;"> 1.02%
98 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 164 </td>
   <td style="text-align:right;"> 99 </td>
   <td style="text-align:left;"> 0.76%
132 ans </td>
   <td style="text-align:left;"> 0.61%
164 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 823 </td>
   <td style="text-align:right;"> 498 </td>
   <td style="text-align:left;"> 1.14%
88 ans </td>
   <td style="text-align:left;"> 0.61%
165 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 1147 </td>
   <td style="text-align:right;"> 629 </td>
   <td style="text-align:left;"> 1.35%
74 ans </td>
   <td style="text-align:left;"> 0.96%
104 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 2403 </td>
   <td style="text-align:right;"> 968 </td>
   <td style="text-align:left;"> 1.07%
94 ans </td>
   <td style="text-align:left;"> 0.62%
160 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 858 </td>
   <td style="text-align:right;"> 490 </td>
   <td style="text-align:left;"> 0.82%
123 ans </td>
   <td style="text-align:left;"> 1.63%
61 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 221 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:left;"> 1.01%
99 ans </td>
   <td style="text-align:left;"> 1.81%
55 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 374 </td>
   <td style="text-align:right;"> 250 </td>
   <td style="text-align:left;"> 0.32%
312 ans </td>
   <td style="text-align:left;"> 0.27%
374 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 668 </td>
   <td style="text-align:right;"> 326 </td>
   <td style="text-align:left;"> 0.70%
142 ans </td>
   <td style="text-align:left;"> 1.20%
84 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 845 </td>
   <td style="text-align:right;"> 388 </td>
   <td style="text-align:left;"> 0.32%
308 ans </td>
   <td style="text-align:left;"> 0.24%
422 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 574 </td>
   <td style="text-align:right;"> 329 </td>
   <td style="text-align:left;"> 0.55%
181 ans </td>
   <td style="text-align:left;"> 0.52%
191 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 116 </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:left;"> 0.00%
Inf ans </td>
   <td style="text-align:left;"> 0.86%
116 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 330 </td>
   <td style="text-align:right;"> 179 </td>
   <td style="text-align:left;"> 2.16%
46 ans </td>
   <td style="text-align:left;"> 1.52%
66 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 268 </td>
   <td style="text-align:right;"> 125 </td>
   <td style="text-align:left;"> 0.76%
131 ans </td>
   <td style="text-align:left;"> 1.49%
67 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 132 </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:left;"> 0.52%
191 ans </td>
   <td style="text-align:left;"> 3.03%
33 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 1607 </td>
   <td style="text-align:right;"> 784 </td>
   <td style="text-align:left;"> 1.05%
96 ans </td>
   <td style="text-align:left;"> 1.24%
80 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 61 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1206 </td>
   <td style="text-align:right;"> 548 </td>
   <td style="text-align:left;"> 1.14%
88 ans </td>
   <td style="text-align:left;"> 0.83%
121 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 62 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 703 </td>
   <td style="text-align:right;"> 393 </td>
   <td style="text-align:left;"> 0.73%
137 ans </td>
   <td style="text-align:left;"> 1.28%
78 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 63 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 1117 </td>
   <td style="text-align:right;"> 571 </td>
   <td style="text-align:left;"> 1.01%
99 ans </td>
   <td style="text-align:left;"> 0.98%
102 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 64 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 773 </td>
   <td style="text-align:right;"> 296 </td>
   <td style="text-align:left;"> 1.31%
76 ans </td>
   <td style="text-align:left;"> 1.03%
97 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 65 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 752 </td>
   <td style="text-align:right;"> 274 </td>
   <td style="text-align:left;"> 1.17%
86 ans </td>
   <td style="text-align:left;"> 0.66%
150 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 66 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 544 </td>
   <td style="text-align:right;"> 197 </td>
   <td style="text-align:left;"> 0.27%
370 ans </td>
   <td style="text-align:left;"> 0.37%
272 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 67 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 499 </td>
   <td style="text-align:right;"> 195 </td>
   <td style="text-align:left;"> 0.86%
116 ans </td>
   <td style="text-align:left;"> 0.80%
125 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 68 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 344 </td>
   <td style="text-align:right;"> 153 </td>
   <td style="text-align:left;"> 0.20%
497 ans </td>
   <td style="text-align:left;"> 0.87%
115 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 69 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 287 </td>
   <td style="text-align:right;"> 118 </td>
   <td style="text-align:left;"> 0.74%
135 ans </td>
   <td style="text-align:left;"> 0.70%
144 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 70 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 504 </td>
   <td style="text-align:right;"> 173 </td>
   <td style="text-align:left;"> 2.81%
36 ans </td>
   <td style="text-align:left;"> 1.98%
50 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 71 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 613 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:left;"> 1.92%
52 ans </td>
   <td style="text-align:left;"> 0.98%
102 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 72 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> 2.27%
44 ans </td>
   <td style="text-align:left;"> 0.00%
Inf ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 73 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> 0.00%
Inf ans </td>
   <td style="text-align:left;"> 2.94%
34 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 74 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 642 </td>
   <td style="text-align:right;"> 166 </td>
   <td style="text-align:left;"> 2.72%
37 ans </td>
   <td style="text-align:left;"> 0.47%
214 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 85 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 323 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:left;"> 0.46%
216 ans </td>
   <td style="text-align:left;"> 0.31%
323 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 86 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 389 </td>
   <td style="text-align:right;"> 180 </td>
   <td style="text-align:left;"> 0.88%
114 ans </td>
   <td style="text-align:left;"> 0.77%
130 ans </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> 87 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 300 </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:left;"> 1.52%
66 ans </td>
   <td style="text-align:left;"> 1.00%
100 ans </td>
  </tr>
</tbody>
</table>


