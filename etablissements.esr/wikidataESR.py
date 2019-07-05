import plotly.plotly as py
import plotly.graph_objs as go
import matplotlib.pyplot as plt

import networkx as nx
import pygraphviz as gv
from networkx.drawing.nx_agraph import graphviz_layout

import re

import json
from wikidata.client import Client

client = Client()

instance_of_cache = { 'Q15974764' : 'ComUE', 'Q15911314' : 'Association' }


def getClaims(entity, prop):
    claims = []
    try:
        for claim in entity.attributes['claims'][prop]:
            claims.append(claim['mainsnak']['datavalue']['value']['id'])
    except:
        pass
    return(claims)

def getSubClaims(entity, prop, depth):
    subClaims = {}
    for claim in getClaims(entity, prop):
        subClaims[claim] = getEtablissement(claim, depth)
    return subClaims


def getInstance_of(entity):
    try:
        instance_of_id = entity.attributes['claims']['P31'][0]['mainsnak']['datavalue']['value']['id']
    except KeyError:
        return("NA")

    if instance_of_id not in instance_of_cache:
        instance_of_entity = client.get(instance_of_id, load=True)
        try:
            instance_of_cache[instance_of_id] = instance_of_entity.attributes['aliases']['fr'][0]['value']
        except KeyError:
            instance_of_cache[instance_of_id] = instance_of_entity.attributes['labels']['fr']['value']

    return instance_of_cache[instance_of_id]


def getLabelAlias(entity):

    try:
        label = entity.attributes['labels']['fr']['value']
    except KeyError:
        label = entity.attributes['labels']['en']['value']

    alias = label
    for l in entity.attributes['aliases']:
        if l != 'jp':
            for a in entity.attributes['aliases'][l]:
                if len(a['value']) < len(alias):
                    alias = a['value']

    if len(alias) > 30:
        alias = ''.join([x[0] for x in re.split('-| ', label)])

    return label,alias


def getEtablissement(entity_id) :

    print("get "+entity_id)

    entity = client.get(entity_id, load=True)

    label,alias = getLabelAlias(entity)

    try:
        inception = entity.attributes['claims']['P571'][0]['mainsnak']['datavalue']['value']['time']
    except:
        inception = "NA"
    try:
        demolished = entity.attributes['claims']['P576'][0]['mainsnak']['datavalue']['value']['time']
    except:
        demolished = "NA"


    etablissement = {
        'label': label,
        'alias': alias,
        'instance_of': getInstance_of(entity),
        'inception': inception,
        'demolished': demolished,
        'has_part': getClaims(entity, 'P527'),
        'part_of': getClaims(entity, 'P361'),
        'subsidiary': getClaims(entity, 'P355'),
        'parent_organization': getClaims(entity, 'P749'),
        'replaces': getClaims(entity, 'P1365'),
        'replaced_by': getClaims(entity, 'P1366')
        }

    return(etablissement)

def getAllInfos(etablissements_id):

    etablissements = {}

    for etablissement_id in etablissements_id:
        etablissements[etablissement_id] = getEtablissement(etablissement_id,2)

        # i = 0
        # while i < len(etablissements_id) and i<10:
        # etablissement_id = etablissements_id[i]
        # print(etablissement_id)
        # etab = getEtablissement(etablissement_id)
        # etablissements[etablissement_id] = etab
        #
        # for newetab_id in (etab['has_part'] + etab['part_of'] + etab['subsidiary'] + etab['parent_organization'] + etab['replaces'] + etab['replaced_by']):
        #     if newetab_id not in etablissements_id:
        #         etablissements_id.append(newetab_id)
        #
        # print(len(etablissements_id))
        # i=i+1




def followsProperties(etablissement_id, props, depth=-1):

    etab = getEtablissement(etablissement_id)

    if depth != 0:
        for prop in props:
            sub_etab = {}
            for id in etab[prop]:
                sub_etab[id] = followsProperties(id, props, depth-1)
            etab[prop] = sub_etab

    return etab

instance_of_colors = {
     "Association":"red",
     "ComUE":"red",
     "site":"yellow",
     "Grands établissements":"orange",
     "institut de recherche":"blue",
     "institut":"blue",
     "centre de recherche":"blue",
     "observatoire astronomique":"blue",
     "Normale Sup":"blue",
     "UMR":"blue",
     "UPR":"blue",
     "Conseil des études et de la vie universitaire":"green",
     "établissement scolaire":"green",
     "institution éducative":"green",
     "Grande ecole":"green",
     "école d'ingénieurs":"green",
     "école de gestion et de commerce":"green",
     "FRE":"green",
     "clinique":"white",
     "chapelles":"white",
     "portail internet":"grey",
     "revue électronique":"grey",
     "E-zine":"grey",
     "plateforme":"grey"
}

properties_color = {
    "has_part":"blue",
    "subsidiary":"red"
}

aliasOrlabel='alias'
def HierarchyGraph(etablissement, properties, G=nx.DiGraph(), nodes_color=[], edges_color=[], profondeur=0):
    if (profondeur == 0):
        G.add_node(etablissement[aliasOrlabel])
        nodes_color = [instance_of_colors[etablissement['instance_of']]]

    for prop in properties:
        for e in etablissement[prop]:
            G.add_node(etablissement[prop][e][aliasOrlabel])
            nodes_color.append(instance_of_colors[etablissement[prop][e]['instance_of']])
            #print("color : "+etablissement[prop][e]['alias']+" : "+instance_of_colors[etablissement[prop][e]['instance_of']])
            etablissement[aliasOrlabel], etablissement[prop][e][aliasOrlabel]
            if (etablissement[aliasOrlabel], etablissement[prop][e][aliasOrlabel]) not in G.edges():
                G.add_edge(etablissement[aliasOrlabel], etablissement[prop][e][aliasOrlabel])
                edges_color.append(properties_color[prop])
            HierarchyGraph(etablissement[prop][e],properties,G, nodes_color, edges_color, profondeur+1)
    return G,nodes_color,edges_color

etablissements_id = ['Q61716142', 'Q10176', 'Q61718100']

comue = followsProperties('Q61718100', ['has_part','subsidiary'])

G,nodes_color,edges_color = HierarchyGraph(comue,['has_part','subsidiary'])

pos = graphviz_layout(G, prog='twopi') #, root=comue['label'])
nx.draw(G,pos,with_labels=True,node_color=nodes_color,edge_color=edges_color)
plt.show()

#print(json.dumps(comue, indent=4, sort_keys=True, ensure_ascii=False))
