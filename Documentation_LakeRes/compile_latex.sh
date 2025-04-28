#!/bin/bash

# Script pour compiler un document LaTeX autant de fois que nécessaire
# pour résoudre les références croisées

# Chemin vers le fichier principal
MAIN_FILE="main.tex"

echo "Compilation initiale..."
pdflatex $MAIN_FILE

# Vérifie si bibtex est nécessaire
if grep -q "\\bibliography" $MAIN_FILE; then
    echo "Exécution de BibTeX..."
    bibtex ${MAIN_FILE%.tex}
fi

echo "Deuxième compilation..."
pdflatex $MAIN_FILE

echo "Troisième compilation pour s'assurer que toutes les références sont résolues..."
pdflatex $MAIN_FILE

echo "Compilation terminée!"