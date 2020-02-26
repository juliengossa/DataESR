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
- [Campagne 2020](emplois-ec.2020.csv) (mise à jour le 26/02/2020 à 16h)
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



## Section CNU

_Attention_ : Ces résultats ne tiennent pas compte des 126 postes sur plusieurs sections. Seule la première est prise en compte.



### Nombre d'emplois

![](emplois-ec_files/figure-html/discpline.emplois-1.png)<!-- -->

![](emplois-ec_files/figure-html/groupe.emplois-1.png)<!-- -->


![](emplois-ec_files/figure-html/cnu.emplois-1.png)<!-- -->

### Renouvellement

_Attention_ : Les données 2018 et 2019 de la section 76 (Théologie Catholique) ont été filtrée pour améliorer la présentation des données (elle présente un renouvellement de 10% en 2018, mais sur un effectif non significatif)

![](emplois-ec_files/figure-html/discpline.renouvellement-1.png)<!-- -->

![](emplois-ec_files/figure-html/groupe.renouvellement-1.png)<!-- -->

![](emplois-ec_files/figure-html/cnu.renouvellement-1.png)<!-- -->


### Promotion

![](emplois-ec_files/figure-html/discipline.promotion-1.png)<!-- -->


![](emplois-ec_files/figure-html/groupe.promotion-1.png)<!-- -->

![](emplois-ec_files/figure-html/cnu.promotion-1.png)<!-- -->


### Tableau

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Section CNU </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Emplois MCF </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Emplois PR </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Effectif MCF </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Effectif PR </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Renouvellement </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Promotion </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;width: 1em; "> 1 </td>
   <td style="text-align:left;width: 1em; "> 1-Droit privé et sciences criminelles </td>
   <td style="text-align:left;width: 1em; "> Droit et science politique </td>
   <td style="text-align:left;width: 1em; "> Droit, économie et gestion </td>
   <td style="text-align:right;width: 1em; "> 53 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 1219 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 2 </td>
   <td style="text-align:left;width: 1em; "> 2-Droit public </td>
   <td style="text-align:left;width: 1em; "> Droit et science politique </td>
   <td style="text-align:left;width: 1em; "> Droit, économie et gestion </td>
   <td style="text-align:right;width: 1em; "> 40 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 813 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 3 </td>
   <td style="text-align:left;width: 1em; "> 3-Histoire du droit et des institutions </td>
   <td style="text-align:left;width: 1em; "> Droit et science politique </td>
   <td style="text-align:left;width: 1em; "> Droit, économie et gestion </td>
   <td style="text-align:right;width: 1em; "> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 148 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 4 </td>
   <td style="text-align:left;width: 1em; "> 4-Science politique </td>
   <td style="text-align:left;width: 1em; "> Droit et science politique </td>
   <td style="text-align:left;width: 1em; "> Droit, économie et gestion </td>
   <td style="text-align:right;width: 1em; "> 15 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 262 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 5 </td>
   <td style="text-align:left;width: 1em; "> 5-Sciences économiques </td>
   <td style="text-align:left;width: 1em; "> Sciences économiques et de gestion </td>
   <td style="text-align:left;width: 1em; "> Droit, économie et gestion </td>
   <td style="text-align:right;width: 1em; "> 43 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 1185 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 6 </td>
   <td style="text-align:left;width: 1em; "> 6-Sciences de gestion </td>
   <td style="text-align:left;width: 1em; "> Sciences économiques et de gestion </td>
   <td style="text-align:left;width: 1em; "> Droit, économie et gestion </td>
   <td style="text-align:right;width: 1em; "> 79 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 1627 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 7 </td>
   <td style="text-align:left;width: 1em; "> 7-Sciences du langage : linguistique et phonétique générales </td>
   <td style="text-align:left;width: 1em; "> Langues et littératures </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 26 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 531 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 8 </td>
   <td style="text-align:left;width: 1em; "> 8-Langues et littératures anciennes </td>
   <td style="text-align:left;width: 1em; "> Langues et littératures </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 7 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 189 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 9 </td>
   <td style="text-align:left;width: 1em; "> 9-Langue et littérature française </td>
   <td style="text-align:left;width: 1em; "> Langues et littératures </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 24 </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 603 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 10 </td>
   <td style="text-align:left;width: 1em; "> 10-Littératures comparées </td>
   <td style="text-align:left;width: 1em; "> Langues et littératures </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 5 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 123 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 11 </td>
   <td style="text-align:left;width: 1em; "> 11-Langues et littératures anglaises et anglo-saxonnes </td>
   <td style="text-align:left;width: 1em; "> Langues et littératures </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 53 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 1293 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 12 </td>
   <td style="text-align:left;width: 1em; "> 12-Langues et littératures germaniques et scandinaves </td>
   <td style="text-align:left;width: 1em; "> Langues et littératures </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 6 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 294 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 13 </td>
   <td style="text-align:left;width: 1em; "> 13-Langues et littératures slaves </td>
   <td style="text-align:left;width: 1em; "> Langues et littératures </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 91 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 14 </td>
   <td style="text-align:left;width: 1em; "> 14-Langues et littératures romanes : espagnol, italien, portugais, autres langues romanes </td>
   <td style="text-align:left;width: 1em; "> Langues et littératures </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 18 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 728 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 15 </td>
   <td style="text-align:left;width: 1em; "> 15-Langues et littératures arabes, chinoises, japonaises, hébraique, d'autres domaines linguistiques </td>
   <td style="text-align:left;width: 1em; "> Langues et littératures </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 15 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 281 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 16 </td>
   <td style="text-align:left;width: 1em; "> 16-Psychologie, psychologie clinique, psychologie sociale </td>
   <td style="text-align:left;width: 1em; "> Sciences humaines </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 46 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 963 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 17 </td>
   <td style="text-align:left;width: 1em; "> 17-Philosophie </td>
   <td style="text-align:left;width: 1em; "> Sciences humaines </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 18 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 224 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 18 </td>
   <td style="text-align:left;width: 1em; "> 18-Architecture (ses théories et ses pratiques), arts appliqués, arts plastiques, arts du spectacle, épistémologie des enseignements artistiques, esthétique, musicologie, musique, sciences de l'art </td>
   <td style="text-align:left;width: 1em; "> Sciences humaines </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 29 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 514 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 19 </td>
   <td style="text-align:left;width: 1em; "> 19-Sociologie, démographie </td>
   <td style="text-align:left;width: 1em; "> Sciences humaines </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 26 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 627 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 20 </td>
   <td style="text-align:left;width: 1em; "> 20-Ethnologie, préhistoire, anthropologie biologique </td>
   <td style="text-align:left;width: 1em; "> Sciences humaines </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 5 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 133 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 21 </td>
   <td style="text-align:left;width: 1em; "> 21-Histoire, civilisations, archéologie et art des mondes anciens et médiévaux </td>
   <td style="text-align:left;width: 1em; "> Sciences humaines </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 14 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 489 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 22 </td>
   <td style="text-align:left;width: 1em; "> 22-Histoire et civilisations : histoire des mondes modernes, histoire du monde contemporain , de l'art , de la musique </td>
   <td style="text-align:left;width: 1em; "> Sciences humaines </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 32 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 663 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 23 </td>
   <td style="text-align:left;width: 1em; "> 23-Géographie physique, humaine, économique et régionale </td>
   <td style="text-align:left;width: 1em; "> Sciences humaines </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 24 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 587 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 24 </td>
   <td style="text-align:left;width: 1em; "> 24-Aménagement de l'espace, urbanisme </td>
   <td style="text-align:left;width: 1em; "> Sciences humaines </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 164 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 25 </td>
   <td style="text-align:left;width: 1em; "> 25-Mathématiques </td>
   <td style="text-align:left;width: 1em; "> Mathématiques et informatique </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 25 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 823 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 26 </td>
   <td style="text-align:left;width: 1em; "> 26-Mathématiques appliquées et applications des mathématiques </td>
   <td style="text-align:left;width: 1em; "> Mathématiques et informatique </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 41 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 1147 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 27 </td>
   <td style="text-align:left;width: 1em; "> 27-Informatique </td>
   <td style="text-align:left;width: 1em; "> Mathématiques et informatique </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 71 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 2403 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 28 </td>
   <td style="text-align:left;width: 1em; "> 28-Milieux denses et matériaux </td>
   <td style="text-align:left;width: 1em; "> Physique </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 15 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 858 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 29 </td>
   <td style="text-align:left;width: 1em; "> 29-Constituants élémentaires </td>
   <td style="text-align:left;width: 1em; "> Physique </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 221 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 30 </td>
   <td style="text-align:left;width: 1em; "> 30-Milieux dilués et optique </td>
   <td style="text-align:left;width: 1em; "> Physique </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 374 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 31 </td>
   <td style="text-align:left;width: 1em; "> 31-Chimie théorique, physique, analytique </td>
   <td style="text-align:left;width: 1em; "> Chimie </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 12 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 668 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 32 </td>
   <td style="text-align:left;width: 1em; "> 32-Chimie organique, minérale, industrielle </td>
   <td style="text-align:left;width: 1em; "> Chimie </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 9 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 845 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 33 </td>
   <td style="text-align:left;width: 1em; "> 33-Chimie des matériaux </td>
   <td style="text-align:left;width: 1em; "> Chimie </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 10 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 574 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 34 </td>
   <td style="text-align:left;width: 1em; "> 34-Astronomie, astrophysique </td>
   <td style="text-align:left;width: 1em; "> Sciences de la terre </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 116 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 35 </td>
   <td style="text-align:left;width: 1em; "> 35-Structure et évolution de la terre et des autres planètes </td>
   <td style="text-align:left;width: 1em; "> Sciences de la terre </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 18 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 330 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 36 </td>
   <td style="text-align:left;width: 1em; "> 36-Terre solide : géodynamique des enveloppes supérieure, paléo-biosphère </td>
   <td style="text-align:left;width: 1em; "> Sciences de la terre </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 268 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 37 </td>
   <td style="text-align:left;width: 1em; "> 37-Météorologie, océanographie physique de l'environnement </td>
   <td style="text-align:left;width: 1em; "> Sciences de la terre </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 132 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 60 </td>
   <td style="text-align:left;width: 1em; "> 60-Mécanique, génie mécanique, génie civil </td>
   <td style="text-align:left;width: 1em; "> Mécanique, génie informatique, énergétique, génie électrique </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 39 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 1607 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 61 </td>
   <td style="text-align:left;width: 1em; "> 61-Génie informatique, automatique et traitement du signal </td>
   <td style="text-align:left;width: 1em; "> Mécanique, génie informatique, énergétique, génie électrique </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 33 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 1206 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 62 </td>
   <td style="text-align:left;width: 1em; "> 62-Energétique, génie des procédés </td>
   <td style="text-align:left;width: 1em; "> Mécanique, génie informatique, énergétique, génie électrique </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 15 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 703 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 63 </td>
   <td style="text-align:left;width: 1em; "> 63-Génie électrique, électronique, photonique et systèmes </td>
   <td style="text-align:left;width: 1em; "> Mécanique, génie informatique, énergétique, génie électrique </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 28 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 1117 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 64 </td>
   <td style="text-align:left;width: 1em; "> 64-Biochimie et biologie moléculaire </td>
   <td style="text-align:left;width: 1em; "> Biologie et biochimie, neurosciences </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 24 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 773 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 65 </td>
   <td style="text-align:left;width: 1em; "> 65-Biologie cellulaire </td>
   <td style="text-align:left;width: 1em; "> Biologie et biochimie, neurosciences </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 21 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 752 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 66 </td>
   <td style="text-align:left;width: 1em; "> 66-Physiologie </td>
   <td style="text-align:left;width: 1em; "> Biologie et biochimie, neurosciences </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 6 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 544 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 67 </td>
   <td style="text-align:left;width: 1em; "> 67-Biologie des populations et écologie </td>
   <td style="text-align:left;width: 1em; "> Biologie et biochimie, neurosciences </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 12 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 499 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 68 </td>
   <td style="text-align:left;width: 1em; "> 68-Biologie des organismes </td>
   <td style="text-align:left;width: 1em; "> Biologie et biochimie, neurosciences </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 344 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 69 </td>
   <td style="text-align:left;width: 1em; "> 69-Neurosciences </td>
   <td style="text-align:left;width: 1em; "> Biologie et biochimie, neurosciences </td>
   <td style="text-align:left;width: 1em; "> Sciences </td>
   <td style="text-align:right;width: 1em; "> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 287 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 70 </td>
   <td style="text-align:left;width: 1em; "> 70-Sciences de l'éducation </td>
   <td style="text-align:left;width: 1em; "> Groupe pluridisciplinaire </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 30 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 504 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 71 </td>
   <td style="text-align:left;width: 1em; "> 71-Sciences de l'information et de la communication </td>
   <td style="text-align:left;width: 1em; "> Groupe pluridisciplinaire </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 28 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 613 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 72 </td>
   <td style="text-align:left;width: 1em; "> 72-Epistémologie, histoire des sciences et des techniques </td>
   <td style="text-align:left;width: 1em; "> Groupe pluridisciplinaire </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 66 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 73 </td>
   <td style="text-align:left;width: 1em; "> 73-Cultures et langues régionales </td>
   <td style="text-align:left;width: 1em; "> Groupe pluridisciplinaire </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 34 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 74 </td>
   <td style="text-align:left;width: 1em; "> 74-Sciences et techniques des activités physiques et sportives </td>
   <td style="text-align:left;width: 1em; "> Groupe pluridisciplinaire </td>
   <td style="text-align:left;width: 1em; "> Lettres et sciences humaines </td>
   <td style="text-align:right;width: 1em; "> 40 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 642 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 85 </td>
   <td style="text-align:left;width: 1em; "> 85-Sciences physico-chimiques et ingénierie appliquée à la santé </td>
   <td style="text-align:left;width: 1em; "> Pharmacie(mono-appartenants) </td>
   <td style="text-align:left;width: 1em; "> Pharmacie </td>
   <td style="text-align:right;width: 1em; "> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 323 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 86 </td>
   <td style="text-align:left;width: 1em; "> 86-Sciences du médicament et des autres produits de santé </td>
   <td style="text-align:left;width: 1em; "> Pharmacie(mono-appartenants) </td>
   <td style="text-align:left;width: 1em; "> Pharmacie </td>
   <td style="text-align:right;width: 1em; "> 17 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 389 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 1em; "> 87 </td>
   <td style="text-align:left;width: 1em; "> 87-Sciences biologiques, fondamentales et cliniques </td>
   <td style="text-align:left;width: 1em; "> Pharmacie(mono-appartenants) </td>
   <td style="text-align:left;width: 1em; "> Pharmacie </td>
   <td style="text-align:right;width: 1em; "> 11 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 300 </td>
  </tr>
</tbody>
</table>


