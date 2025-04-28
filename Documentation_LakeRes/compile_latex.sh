#!/bin/bash

# Script pour compiler un document LaTeX autant de fois que nécessaire
# pour résoudre les références croisées

# Chemin vers le fichier principal
MAIN_FILE="main.tex"

echo "Nettoyage des fichiers temporaires..."
rm -f *.aux *.log *.toc *.out *.lof *.lot *.bbl *.blg *.fls *.fdb_latexmk *.synctex.gz *.listing

echo "Compilation initiale..."
pdflatex -interaction=nonstopmode $MAIN_FILE

# Vérifie si bibtex est nécessaire
if grep -q "\\bibliography" $MAIN_FILE; then
    echo "Exécution de BibTeX..."
    bibtex ${MAIN_FILE%.tex}
fi

echo "Deuxième compilation..."
pdflatex -interaction=nonstopmode $MAIN_FILE

echo "Troisième compilation pour s'assurer que toutes les références sont résolues..."
pdflatex -interaction=nonstopmode $MAIN_FILE

echo "Compilation terminée!"% sections/introduction.tex
\chapter{Introduction}

\section{Objectif de la thèse}
Cette thèse vise à développer des modèles hydrogéologiques avancés pour caractériser et prédire les flux d'eau souterraine dans le bassin rennais. Les objectifs principaux incluent l'intégration des données de terrain, la modélisation multi-échelle des écoulements, et l'évaluation de l'impact des changements climatiques sur les ressources en eau.

\section{Contexte scientifique}
La compréhension des flux hydrogéologiques est essentielle pour la gestion durable des ressources en eau. Dans le contexte du bassin rennais, les interactions entre eaux souterraines et eaux de surface sont particulièrement complexes en raison de la géologie hétérogène et des pressions anthropiques croissantes. Ce projet s'inscrit dans une démarche globale d'amélioration des connaissances scientifiques sur les systèmes aquifères fracturés.

\section{Exemples de code moderne}

Le code suivant montre un exemple simple de classe Python avec coloration syntaxique adaptée:

\begin{pythoncode}[Une petite classe Python]
class Compteur:
    def __init__(self, start=0):
        self.count = start        # <- 'self' est coloré
    def increment(self):
        self.count += 1
        print(f"Valeur : {self.count}")

# Usage
if __name__ == "__main__":
    c = Compteur()
    for _ in range(3):
        c.increment()
\end{pythoncode}

Ce code simple illustre l'utilisation d'une classe Python avec initialisation et méthode d'incrémentation. La colorisation syntaxique met en évidence les différents éléments du code pour une meilleure lisibilité.