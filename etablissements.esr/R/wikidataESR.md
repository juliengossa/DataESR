Tenter d’y voir clair dans l’ESR : modélisation les établissements dans
WikiData et exploitation des données avec WikiDataESR.
================
Julien Gossa, Bastien Tagliana, Pierre Zoschke
20/07/2019

Les réformes successives touchant l’organisation de l’enseignement
supérieur et de la recherche (ESR) depuis une quinzaine d’années ont
profondément modifié le paysage universitaire français. Aujourd’hui, les
transformations institutionelles sont si nombreuses et si rapides, qu’il
est devenu impossible de connaitre la structure actuelle des
établissements de l’ESR.

Il existe trois sources principales d’informations sur les
établissements de l’ESR français :

  - [data.gouv.fr](https://www.data.gouv.fr/fr/) : le portail des
    données publiques du gouvernement français ;
  - [\#DataESR](https://data.esr.gouv.fr/FR/) : le portail des données
    publiques du ministère de l’enseignement supérieur, de la recherche
    et de l’innovation ;
  - [WikiData](https://www.wikidata.org/wiki/Wikidata:Main_Page) : une
    base de connaissances libre et gratuite, dans la famille WikiMédia,
    qui compte notamment WikiPédia.

Les deux premières sources ne sont pas communautaires, et proposent
essentiellement des jeux de données brutes. En revanche, WikiData permet
l’édition collaborative, plus adaptée au rythme actuel des
transformations. Il permet également de structurer les données grace à
un très large choix de relations. La contrepartie de ces deux avantages
est la difficulté à uniformiser les données, passage indispensable à
leur exploitation.

C’est pourquoi ce document est un guide visant l’harmonisation des
informations sur l’organisation de l’enseignement supérieur français
disponibles publiquement sur la base de donnée collaborative WikiData.

La première partie présente une proposition de modélisation des
différentes relations entre établissements de l’ESR grâce aux relations
WikiData. La seconde partie présente
[WikiDataESR](https://github.com/juliengossa/DataESR/tree/master/etablissements.esr/wikidataESR),
une librairie [R](https://www.r-project.org/) conçue pour exploiter ces
données. Enfin, une troisième partie disserte sur les transformation des
établissements de l’ESR.

## Proposition de modélisation

Le principe de la modélisation des informations dans WikiData est
relativement simple :

  - chaque établissement de l’ESR, passé, présent ou futur, doit faire
    l’objet d’un **élément** (*item*) unique ;
  - chaque élément dispose de plusieurs **propriétés** (*properties*),
    dont la **valeur** (*value*) est l’information ;
  - le cas échéant, les propriétés peuvent avoir un **qualificatif**
    (*qualifier*) précisant cette information.

Pour l’utilisation particulière de WikiData, on pourra se reporter à
cette
[introduction](https://www.wikidata.org/wiki/Wikidata:Introduction/fr).

### Entête des éléments

Les éléments présentent quatre informations indispensables :

  - un **identifiant** unique, attribué automatiquement, qu’on retrouve
    dans l’URL de la page ;
  - un **libellé** (*label*) unique, ou nom principal ;
  - une **description** (*description*) ;
  - autant d’**alias** que nécessaire, ou noms alternatifs.

Par exemple, pour l’[UCA](https://www.wikidata.org/wiki/Q19370961) :

  - Q19370961
    [www.wikidata.org/wiki/Q19370961](https://www.wikidata.org/wiki/Q19370961)
  - Université Côte d’Azur
  - communauté d’universités et établissements (ComUE) créée en 2015 à
    Nice, dans la région Provence-Alpes-Côte d’Azur
  - Comue Université Côte d’Azur ; Comue UCA

### Propriétés

Les propriétés permettent de modéliser les relations entre les
établissements de l’ESR. La proposition suivante permet d’harmoniser
les informations
:

| id                                                    | libellé.wikidata     | libellé.ESR   | note                                                                                                         | qualificatif                                                                                                            |
| :---------------------------------------------------- | :------------------- | :------------ | :----------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------- |
| [P31](https://www.wikidata.org/wiki/Property:P31)     | nature de l’élément  | nature        | voir la liste en annexe                                                                                      |                                                                                                                         |
| [P3202](https://www.wikidata.org/wiki/Property:P3202) | code UAI             |               | permet de faire le lien avec les autres bases de données                                                     |                                                                                                                         |
| [P571](https://www.wikidata.org/wiki/Property:P571)   | date de fondation    | fondation     |                                                                                                              |                                                                                                                         |
| [P576](https://www.wikidata.org/wiki/Property:P576)   | date de dissolution  | dissolution   |                                                                                                              |                                                                                                                         |
| [P527](https://www.wikidata.org/wiki/Property:P527)   | comprend             | associé       | lien de subordination horizontal : avec une moindre hiérachie, avec une indépendance politique et financière | [date de début](https://www.wikidata.org/wiki/Property:P580) [date de fin](https://www.wikidata.org/wiki/Property:P582) |
| [P361](https://www.wikidata.org/wiki/Property:P361)   | partie de            | associé de    | inverse de associé                                                                                           | [date de début](https://www.wikidata.org/wiki/Property:P580) [date de fin](https://www.wikidata.org/wiki/Property:P582) |
| [P355](https://www.wikidata.org/wiki/Property:P355)   | organisation filiale | composante    | lien de subordination vertical: avec hiérarchie et dépendance politique ou financière accrue                 | [date de début](https://www.wikidata.org/wiki/Property:P580) [date de fin](https://www.wikidata.org/wiki/Property:P582) |
| [P749](https://www.wikidata.org/wiki/Property:P749)   | organisation mère    | composante de | inverse de composante                                                                                        | [date de début](https://www.wikidata.org/wiki/Property:P580) [date de fin](https://www.wikidata.org/wiki/Property:P582) |
| [P1365](https://www.wikidata.org/wiki/Property:P1365) | remplace             | prédécesseur  | marque un changement de statut                                                                               | [date](https://www.wikidata.org/wiki/Property:P585)                                                                     |
| [P1366](https://www.wikidata.org/wiki/Property:P1366) | remplacé par         | successeur    | inverse de prédécesseur                                                                                      |                                                                                                                         |
| [P807](https://www.wikidata.org/wiki/Property:P807)   | séparé de            |               | marque une séparation                                                                                        | [date](https://www.wikidata.org/wiki/Property:P585)                                                                     |
| [P1416](https://www.wikidata.org/wiki/Property:P1416) | affilié à            |               | pour les tutelles (CNRS, etc.)                                                                               | [date de début](https://www.wikidata.org/wiki/Property:P580) [date de fin](https://www.wikidata.org/wiki/Property:P582) |
| [P463](https://www.wikidata.org/wiki/Property:P463)   | membre de            |               | pour les adhésions aux diverses associations                                                                 | [date de début](https://www.wikidata.org/wiki/Property:P580) [date de fin](https://www.wikidata.org/wiki/Property:P582) |
| [P1830](https://www.wikidata.org/wiki/Property:P1830) | propriétaire de      |               | pour les équipements de recherche par exemple                                                                | [date de début](https://www.wikidata.org/wiki/Property:P580) [date de fin](https://www.wikidata.org/wiki/Property:P582) |
| [P1344](https://www.wikidata.org/wiki/Property:P1344) | participant à        |               | pour les projets par exemple                                                                                 | [date de début](https://www.wikidata.org/wiki/Property:P580) [date de fin](https://www.wikidata.org/wiki/Property:P582) |

### Erreurs fréquentes

Afin d’harmoniser au mieux les informations, il est utile d’éviter
plusieurs erreurs fréquentes.

  - Utiliser un seul élément pour représenter plusieurs établissements.

Il est recommandé d’utiliser autant d’éléments que de nécessaires, sans
tenter de réutiliser ceux qui existent. Cela vaut aussi bien pour les
établissements composites (regroupements) que pour les établissements
qui changent de statuts au cours du temps.

  - Utiliser une nature inappropriée.

Il existe de très nombreuses natures d’établissement de l’ESR, ou qui
s’en approchent. Il est recommandé d’éviter d’utiliser des natures
génériques (“centre de recherche”), et de stipuler la nature la plus
précise possible de l’établissement (“UMR”). Dans l’idéal, la nature se
confond avec la forme juridique. Stipuler plusieurs nature doit être
réservé au cas où l’établissement a effectivement une nature composite.

Une liste de natures recommandées et déconseillées est donnée en annexe.

  - Utiliser une propriété innapropriée.

Les organisations des regroupements de l’ESR étant particulièrement
complexes, il est indispensable d’utiliser les propriétés les mieux
adaptées, notamment pour différencier les membres pleinement intégrés
(appelés ici “composante”) des membres seulement associés.

De plus, même si les tutelles (EPST, EPCA, EPIC…) sont membres des
regroupements, il est recommandé de les déclarer sous forme
d’affiliation pour les différencier des établissements composantes ou
associés.

Enfin, les adhésions aux diverses associations (CPU, CURIF, LERU,
COUPERIN…) doivent être déclarées avec “membre de”, toujours pour les
différencier des autres types de relations.

## Annexes

### Liste des natures recommandées

Les natures d’établissement peuvent être hiérarchisés en différents
niveaux :

  - 1 international : organisations internationales ;
  - 2 national : institutions nationales (p. ex. : CNRS) ;
  - 3 régional/regroupement : institutions régionales (p. ex. : COMUEs)
    ;
  - 4 institutions/université : institutions locales (p. ex. :
    universités) ;
  - 5 intermédiaire : institutions locales de moindre taille (p. ex. :
    école indépendante), ou premier sous-niveau des institutions
    (p. ex. : collégium)
  - 6 terrain : sous-partie d’une institution (p. ex. :
UFR/UMR)

| wikidata.id                                          | libellé                     | niveau | note                          | wikipedia                                                                                                                    |
| :--------------------------------------------------- | :-------------------------- | -----: | :---------------------------- | :--------------------------------------------------------------------------------------------------------------------------- |
| [Q13582798](https://www.wikidata.org/wiki/Q13582798) | EPST                        |      2 |                               | [ref](https://fr.wikipedia.org/wiki/%C3%89tablissement_public_%C3%A0_caract%C3%A8re_scientifique_et_technologique)           |
| [Q3244038](https://www.wikidata.org/wiki/Q3244038)   | EPCA                        |      2 |                               | [ref](https://fr.wikipedia.org/wiki/%C3%89tablissement_public_%C3%A0_caract%C3%A8re_administratif_en_France)                 |
| [Q3591583](https://www.wikidata.org/wiki/Q3591583)   | EPIC                        |      2 |                               | [ref](https://fr.wikipedia.org/wiki/%C3%89tablissement_public_%C3%A0_caract%C3%A8re_industriel_et_commercial_en_France)      |
| [Q61612084](https://www.wikidata.org/wiki/Q61612084) | PRES                        |      3 |                               | [ref](https://fr.wikipedia.org/wiki/Regroupement_universitaire)                                                              |
| [Q15974764](https://www.wikidata.org/wiki/Q15974764) | COMUE                       |      3 |                               | [ref](https://fr.wikipedia.org/wiki/Communaut%C3%A9_d%27universit%C3%A9s_et_%C3%A9tablissements)                             |
| [Q65963615](https://www.wikidata.org/wiki/Q65963615) | EPE                         |      3 |                               | [ref](https://fr.wikipedia.org/wiki/Regroupement_universitaire)                                                              |
| [Q3412198](https://www.wikidata.org/wiki/Q3412198)   | Regroupement universitaire  |      3 | Pour les autres regroupements | [ref](https://fr.wikipedia.org/wiki/Regroupement_universitaire)                                                              |
| [Q2822246](https://www.wikidata.org/wiki/Q2822246)   | Académie                    |      3 |                               | [ref](https://fr.wikipedia.org/wiki/Acad%C3%A9mie_\(%C3%A9ducation_en_France\))                                              |
| [Q3551775](https://www.wikidata.org/wiki/Q3551775)   | Université (EPSCP)          |      4 |                               | [ref](https://fr.wikipedia.org/wiki/%C3%89tablissement_public_%C3%A0_caract%C3%A8re_scientifique,_culturel_et_professionnel) |
| [Q1542938](https://www.wikidata.org/wiki/Q1542938)   | Grand Établissement         |      4 |                               | [ref](https://fr.wikipedia.org/wiki/Grand_%C3%A9tablissement)                                                                |
| [Q3591586](https://www.wikidata.org/wiki/Q3591586)   | EPSCP                       |      4 |                               | [ref](https://fr.wikipedia.org/wiki/%C3%89tablissement_public_%C3%A0_caract%C3%A8re_scientifique,_culturel_et_professionnel) |
| [Q135436](https://www.wikidata.org/wiki/Q135436)     | École normale supérieure    |      4 |                               | [ref](https://fr.wikipedia.org/wiki/%C3%89cole_normale_sup%C3%A9rieure_\(France\))                                           |
| [Q1059324](https://www.wikidata.org/wiki/Q1059324)   | CHU                         |      5 |                               | [ref](https://fr.wikipedia.org/wiki/Centre_hospitalier_universitaire)                                                        |
| [Q3152659](https://www.wikidata.org/wiki/Q3152659)   | IUT                         |      5 |                               | [ref](https://fr.wikipedia.org/wiki/Institut_universitaire_de_technologie)                                                   |
| [Q1475041](https://www.wikidata.org/wiki/Q1475041)   | IEP                         |      5 |                               | [ref](https://fr.wikipedia.org/wiki/Institut_d%27%C3%A9tudes_politiques)                                                     |
| [Q3578562](https://www.wikidata.org/wiki/Q3578562)   | ESPÉ                        |      5 |                               | [ref](https://fr.wikipedia.org/wiki/%C3%89cole_sup%C3%A9rieure_du_professorat_et_de_l%27%C3%A9ducation)                      |
| [Q184644](https://www.wikidata.org/wiki/Q184644)     | école supérieure de musique |      5 |                               | [ref](https://fr.wikipedia.org/wiki/%C3%89cole_sup%C3%A9rieure_de_musique)                                                   |
| [Q1143635](https://www.wikidata.org/wiki/Q1143635)   | école de commerce           |      5 |                               | [ref](https://fr.wikipedia.org/wiki/%C3%89cole_de_commerce)                                                                  |
| [Q479716](https://www.wikidata.org/wiki/Q479716)     | presse universitaire        |      5 |                               |                                                                                                                              |
| [Q3550864](https://www.wikidata.org/wiki/Q3550864)   | UMR                         |      6 |                               | [ref](https://fr.wikipedia.org/wiki/Unit%C3%A9_mixte_de_recherche)                                                           |
| [Q43371084](https://www.wikidata.org/wiki/Q43371084) | UPR                         |      6 |                               | [ref](https://fr.wikipedia.org/wiki/Centre_national_de_la_recherche_scientifique)                                            |
| [Q3550863](https://www.wikidata.org/wiki/Q3550863)   | UMS                         |      6 |                               | [ref](https://fr.wikipedia.org/wiki/Unit%C3%A9_mixte_de_service)                                                             |
| [Q43371093](https://www.wikidata.org/wiki/Q43371093) | FRE                         |      6 |                               | [ref](https://fr.wikipedia.org/wiki/Centre_national_de_la_recherche_scientifique)                                            |
| [Q3550804](https://www.wikidata.org/wiki/Q3550804)   | UFR                         |      6 |                               | [ref](https://fr.wikipedia.org/wiki/Unit%C3%A9_de_formation_et_de_recherche)                                                 |
| [Q13220391](https://www.wikidata.org/wiki/Q13220391) | école doctorale             |      6 |                               |                                                                                                                              |
| [Q57314035](https://www.wikidata.org/wiki/Q57314035) | faculté de médecine         |      6 |                               |                                                                                                                              |
| [Q1254933](https://www.wikidata.org/wiki/Q1254933)   | observatoire astronomique   |      6 |                               |                                                                                                                              |
| [Q180958](https://www.wikidata.org/wiki/Q180958)     | composante                  |      6 | A défaut de plus précis       | [ref](https://fr.wikipedia.org/wiki/Universit%C3%A9_en_France#Composantes)                                                   |

### Liste des natures déconseillées

La plupart des natures dans cette liste sont déconseillées parce que des
natures plus précises
existent.

|    | wikidata.id                                          | libellé                           | niveau | note                                   | wikipedia                                                    |
| -- | :--------------------------------------------------- | :-------------------------------- | -----: | :------------------------------------- | :----------------------------------------------------------- |
| 30 | [Q2659904](https://www.wikidata.org/wiki/Q2659904)   | organisation gouvernementale      |      1 |                                        |                                                              |
| 31 | [Q327333](https://www.wikidata.org/wiki/Q327333)     | agence publique                   |      1 |                                        |                                                              |
| 32 | [Q43229](https://www.wikidata.org/wiki/Q43229)       | organisation                      |      3 |                                        |                                                              |
| 33 | [Q15911314](https://www.wikidata.org/wiki/Q15911314) | association                       |      3 |                                        |                                                              |
| 34 | [Q13226383](https://www.wikidata.org/wiki/Q13226383) | site                              |      3 |                                        |                                                              |
| 35 | [Q3578166](https://www.wikidata.org/wiki/Q3578166)   | École nationale supérieure        |      4 | Confusion avec les ENS                 |                                                              |
| 36 | [Q15343039](https://www.wikidata.org/wiki/Q15343039) | établissement public              |      4 |                                        |                                                              |
| 37 | [Q270791](https://www.wikidata.org/wiki/Q270791)     | entreprise d’État                 |      4 |                                        |                                                              |
| 38 | [Q902104](https://www.wikidata.org/wiki/Q902104)     | université privée                 |      4 |                                        |                                                              |
| 39 | [Q1371037](https://www.wikidata.org/wiki/Q1371037)   | institut de technologie           |      4 |                                        | [ref](https://fr.wikipedia.org/wiki/Institut_de_technologie) |
| 40 | [Q1663017](https://www.wikidata.org/wiki/Q1663017)   | école d’ingé                      |      4 |                                        |                                                              |
| 41 | [Q16917](https://www.wikidata.org/wiki/Q16917)       | hôpital                           |      4 | Préférer CHU                           |                                                              |
| 42 | [Q2945655](https://www.wikidata.org/wiki/Q2945655)   | CH                                |      4 | Préférer CHU                           |                                                              |
| 43 | [Q3918](https://www.wikidata.org/wiki/Q3918)         | université                        |      4 |                                        |                                                              |
| 44 | [Q847027](https://www.wikidata.org/wiki/Q847027)     | Grande ecole                      |      4 | Réserver aux écoles non contemporaines | [ref](https://fr.wikipedia.org/wiki/Grande_%C3%A9cole)       |
| 45 | [Q875538](https://www.wikidata.org/wiki/Q875538)     | université publique               |      4 |                                        |                                                              |
| 46 | [Q2385804](https://www.wikidata.org/wiki/Q2385804)   | institution éducative             |      5 |                                        |                                                              |
| 47 | [Q189004](https://www.wikidata.org/wiki/Q189004)     | Collége                           |      5 |                                        |                                                              |
| 48 | [Q4287745](https://www.wikidata.org/wiki/Q4287745)   | organisation de santé             |      5 |                                        |                                                              |
| 49 | [Q3914](https://www.wikidata.org/wiki/Q3914)         | école                             |      6 |                                        |                                                              |
| 50 | [Q483242](https://www.wikidata.org/wiki/Q483242)     | laboratoire                       |      6 |                                        |                                                              |
| 51 | [Q31855](https://www.wikidata.org/wiki/Q31855)       | institut de recherche             |      6 |                                        |                                                              |
| 52 | [Q1664720](https://www.wikidata.org/wiki/Q1664720)   | institut                          |      6 |                                        |                                                              |
| 53 | [Q7315155](https://www.wikidata.org/wiki/Q7315155)   | centre de recherche               |      6 |                                        |                                                              |
| 54 | [Q4671277](https://www.wikidata.org/wiki/Q4671277)   | institut universitaire            |      6 |                                        |                                                              |
| 55 | [Q38723](https://www.wikidata.org/wiki/Q38723)       | institut d’enseignement supérieur |      6 |                                        |                                                              |
| 56 | [Q3356144](https://www.wikidata.org/wiki/Q3356144)   | ODAC                              |      6 |                                        |                                                              |
| 57 | [Q28863779](https://www.wikidata.org/wiki/Q28863779) | centre de recherche               |      6 |                                        |                                                              |

![](wikidataESR_files/figure-gfm/pressure-1.png)<!-- -->
