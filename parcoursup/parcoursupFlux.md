---
title: "ParcoursupFlux"
author: "Julien Gossa"
date: "22/10/2019"
output:
  html_document: 
    keep_md: true
  word_document: default
  pdf_document: default
---






## Situation actuelle

Les flux de néo-bacheliers admis dans le supérieur public peuvent se modéliser ainsi :

![](parcoursupFlux_files/figure-html/flux.actuel-1.png)<!-- -->


L'un des problèmes actuel du supérieur public est la saturation des Licences, ainsi que leur taux de réussite.

![](parcoursupFlux_files/figure-html/flux.actuel.L-1.png)<!-- -->



## Comment améliorer les taux de réussite en Licence à moyens constants ?

Les universités sont formelles : le problèmes des Licences est le taux de réussite des bacs pros. C'est pourquoi ce public est évincé des filières en tension. 

Cette éviction est d'ailleurs le seul levier sûr d'augmentation de la réussite en Licence, [comme cela a été montré en STAPS](http://blog.educpros.fr/julien-gossa/2019/08/10/bilan-2018-2019-i-parcoursup-annee-2/), par exemple.

Les filières les plus adaptées aux bacs pros sont les BTS. On va donc détourner les bacs pros qui allaient en Licence vers les BTS :


![](parcoursupFlux_files/figure-html/flux.bts-1.png)<!-- -->

Problème : ce détournement augmente les effectifs en BTS... Or les BTS sont déjà saturés, et on ne souhaite pas ajouter de nouveaux moyens. 

Il faut donc faire de la place. Les bacs généraux sont difficile à gérer, car ils ne font pas l'objet de quotas. On va donc plutôt détourner les flux de bacs technos allant en BTS.

Le taux de réussite des bacs technos dans le supérieur est très bas également : les détourner vers les Licences/PACES/CPGE ne présentera aucun gain de réussite. Leur meilleur taux de réussite est en DUT :

![](parcoursupFlux_files/figure-html/flux.dut-1.png)<!-- -->

Maintenant, le problème se situe au niveau du DUT, qui doit absorber 10 milliers de bac technos auparavant en BTS. L'éviction va se faire au niveau des bacs généraux, qui seront ventilés pour 1/3 vers les CPGE (ce qui comble la baisse des effectifs des 3 dernières années) et 2/3 vers les Licences et PACES.

![](parcoursupFlux_files/figure-html/flux.aprèsdut-1.png)<!-- -->

Au final, on obtient les flux suivants :

![](parcoursupFlux_files/figure-html/flux.final-1.png)<!-- -->


Ainsi, on aura :

- abaissé la pression sur les Licences ;
- enrayé la crise du recrutement en CPGE ;
- augmenté les taux de réussite des bacs pros et des Licences ;

le tout à moyens constants. 

Cependant, cette manœuvre présente deux désavantages majeurs : 

- l'abaissement de la mixité, notamment en BTS ;
- l'abaissement des exigences pédagogiques, et donc de la qualité des diplômes BTS et DUT. 

Détail amusant, cela conduit environ à 50% de bac technologiques en DUT, ce qui est le quota envisagé dans l'Arrêté. 

## Les quotas de DUT




Faisons un focus sur le DUT. En regardant les mentions des néo-bacheliers admis, ses flux de recrutement en 2018 peuvent se modéliser ainsi (M : avec mention, S : sans mention) :


![](parcoursupFlux_files/figure-html/dut.actuel-1.png)<!-- -->

<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Bac </th>
   <th style="text-align:right;"> Effectif </th>
   <th style="text-align:left;"> part </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> GénéralM </td>
   <td style="text-align:right;"> 19.357 </td>
   <td style="text-align:left;"> 39.8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> GénéralS </td>
   <td style="text-align:right;"> 12.150 </td>
   <td style="text-align:left;"> 25.0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TechnoM </td>
   <td style="text-align:right;"> 12.492 </td>
   <td style="text-align:left;"> 25.7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TechnoS </td>
   <td style="text-align:right;"> 3.966 </td>
   <td style="text-align:left;"> 8.1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ProM </td>
   <td style="text-align:right;"> 0.620 </td>
   <td style="text-align:left;"> 1.3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ProS </td>
   <td style="text-align:right;"> 0.081 </td>
   <td style="text-align:left;"> 0.2% </td>
  </tr>
</tbody>
</table>

Faire passer le quota de bacheliers technologiques à 50% implique d'augmenter d'au moins 7000 les admis de ce public : 

- cette augmentation devraient se faire essentiellement sur les bacheliers technologiques avec mention (TechnoM) auparavant en BTS ;
- pour leur faire de la place, avec les classements actuels, l'éviction se fera sur les bacheliers généraux sans mention (GénéralS) ;
- ces évincés se répartiraient entre CPGE, Licences et PACES.


![](parcoursupFlux_files/figure-html/dut.flux-1.png)<!-- -->

Au final, on obtient donc ce recrutement en DUT :

![](parcoursupFlux_files/figure-html/dut.futur-1.png)<!-- -->

<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Bac </th>
   <th style="text-align:right;"> Effectif </th>
   <th style="text-align:left;"> part </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> GénéralM </td>
   <td style="text-align:right;"> 19.357 </td>
   <td style="text-align:left;"> 39.7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> GénéralS </td>
   <td style="text-align:right;"> 5.200 </td>
   <td style="text-align:left;"> 10.7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TechnoM </td>
   <td style="text-align:right;"> 19.492 </td>
   <td style="text-align:left;"> 40.0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TechnoS </td>
   <td style="text-align:right;"> 3.966 </td>
   <td style="text-align:left;"> 8.1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ProM </td>
   <td style="text-align:right;"> 0.620 </td>
   <td style="text-align:left;"> 1.3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ProS </td>
   <td style="text-align:right;"> 0.081 </td>
   <td style="text-align:left;"> 0.2% </td>
  </tr>
</tbody>
</table>

On observe ainsi un abaissement de la mixité des publics, désormais polarisés entre bacheliers généraux avec mention et bacheliers technologiques avec mention.


