# Dossier /tools

## À propos de ce README

Ce fichier README a été initialement généré avec l’assistance d’une intelligence artificielle (ChatGPT).

- Modèle : GPT-5.2 (OpenAI)
- Date de génération initiale : 2026
- Rôle de l’IA : aide à la structuration et à la documentation technique

Le contenu a vocation à être relu, adapté et amendé par le responsable scientifique du projet.

---

## Contenu du dossier

Ce dossier regroupe les **outils externes** et ressources techniques nécessaires au projet, sans relever directement des sources éditoriales.

On peut y placer, par exemple :
- une copie locale de **Saxon** (jar) ou d’autres exécutables utilisés pour les transformations ;
- des binaires, wrappers, scripts d’installation ;
- des modèles (templates) de génération (ODT/HTML) ou ressources techniques réutilisées ;
- des dépendances “vendored” quand on veut éviter de dépendre d’un téléchargement externe.

---

## Règles de gestion

- Les contenus de `/tools` sont des **dépendances** ou **auxiliaires techniques** : ils ne doivent pas être confondus avec les sources XML.
- Les fichiers volumineux ou distribués ailleurs (archives, installers) peuvent être évités si leur taille dépasse les limites raisonnables de Git.
- Chaque outil ajouté devrait idéalement être accompagné d’une courte note (nom, version, provenance/licence, usage).

---

## Organisation des scripts et outils

Dans ce projet, il n’existe **qu’un seul dossier `tools/`**.

Ce dossier regroupe à la fois :
- les **scripts du projet** (Python, Perl, etc.) écrits spécifiquement pour la chaîne éditoriale ;
- les **outils ou dépendances externes** nécessaires à leur exécution (ex. Saxon, ressources techniques).

Cette fusion est volontaire et vise à simplifier l’arborescence tout en conservant une séparation claire entre :
- **sources éditoriales** (`/tei`, `/data`) ;
- **outillage technique** (`/tools`) ;
- **produits dérivés** (`/docs`, `/work`).

Les scripts présents dans `/tools` sont conçus pour être exécutés localement et ne sont jamais utilisés directement côté site web.

---

## Liste des outils archivés dans le dossier
- `rename.sh` : script de renommage utilisé pour nommer les prises de vue selon le folio
- `transform.py` :
