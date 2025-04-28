# Guide d'utilisation du template LaTeX Documentation_LakeRes

Ce guide vous explique comment utiliser et personnaliser le template LaTeX pour un rapport.

## 1. Structure des fichiers

Le template est organisé de façon modulaire pour faciliter la maintenance et la personnalisation :

```
Documentation_LakeRes/
├── main.tex                  # Fichier principal (squelette simplifié)
├── compile.sh                # Script de compilation intelligent
├── config/                   # Dossier de configuration
│   ├── packages.tex          # Packages nécessaires
│   ├── layout.tex            # Mise en page et marges
│   ├── colors.tex            # Définition des couleurs
│   ├── chapter-style.tex     # Style des chapitres
│   ├── headers.tex           # En-têtes et pieds de page
│   ├── code-style.tex        # Configuration pour le code
│   ├── callouts.tex          # Boîtes d'information
│   ├── figures.tex           # Configuration des figures
│   ├── commands.tex          # Commandes personnalisées
│   └── bibliography.tex      # Configuration de la bibliographie
├── content/                  # Contenu du document
│   ├── frontmatter/          # Pages préliminaires
│   │   ├── titlepage.tex     # Page de garde
│   │   └── abstract.tex      # Résumé (à créer)
│   ├── chapters/             # Chapitres du document
│   │   ├── introduction.tex  # Introduction
│   │   └── ...               # Autres chapitres
│   └── backmatter/           # Pages finales
│       └── ...               # Conclusion, annexes
└── assets/                   # Ressources
    ├── figures/              # Figures et images
    │   └── logos/            # Logos
    └── bibliography/         # Bibliographie
        └── references.bib    # Fichier BibTeX contenant les références
```

## 2. Démarrage rapide

### Installation

1. Clonez ou copiez l'ensemble du dossier `Documentation_LakeRes/`
2. Assurez-vous d'avoir une distribution LaTeX complète installée (TeX Live ou MiKTeX)
3. Rendez le script de compilation exécutable :
   ```bash
   chmod +x compile.sh
   ```

### Première compilation

```bash
./compile.sh
```

Pour des options supplémentaires :
```bash
./compile.sh --help
```

Pour compiler en mode surveillance (recompilation automatique à chaque changement) :
```bash
./compile.sh --watch --view
```

## 3. Personnalisation de base

### Informations générales

Modifiez les informations personnelles :

1. **Page de titre** : Ouvrez `content/frontmatter/titlepage.tex` et mettez à jour :
   - Le titre principal
   - Le sous-titre
   - Les informations d'auteur
   - Les informations d'encadrement

2. **En-têtes et pieds de page** : Dans `main.tex`, personnalisez les commandes suivantes :
   ```latex
   % Définition des informations du document (utile pour les en-têtes)
   \newcommand{\docTitle}{Documentation Scientifique}
   \newcommand{\docAuthor}{Nom}
   \newcommand{\docVersion}{Version 1.0}
   \newcommand{\docYear}{2025}
   ```

### Adaptation visuelle

1. **Couleurs** : Modifiez les couleurs dans `config/colors.tex` pour changer :
   - Les couleurs de code
   - Les couleurs des callouts
   - Les couleurs générales du document

2. **Style des chapitres** : Personnalisez l'apparence des titres de chapitres dans `config/chapter-style.tex`

## 4. Gestion des figures et tableaux

### Insertion de figures

Plusieurs méthodes sont disponibles pour insérer des figures :

#### Méthode standard

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.7\textwidth]{assets/figures/image.png}
    \caption{Description de l'image}
    \label{fig:image}
\end{figure}
```

#### Avec la commande simplifiée

```latex
\centeredfigure[0.6]{assets/figures/image.png}{Description de l'image}
```

Cette commande crée automatiquement un label basé sur le nom du fichier (ex: `fig:image.png`).

#### Pour deux figures côte à côte

```latex
\twofigures{image1.png}{Légende 1}{image2.png}{Légende 2}{Légende générale}
```

Cela génère également des labels automatiques : `fig:image1.png`, `fig:image2.png` et `fig:image1.png-image2.png`.

#### Pour trois figures côte à côte

```latex
\threefigures{image1.png}{Légende 1}{image2.png}{Légende 2}{image3.png}{Légende 3}{Légende générale}
```

### Création de tableaux

#### Avec l'environnement amélioré

```latex
\begin{nicetable}{Titre du tableau}{tab:identifiant}{lcc}
    \tableheader{Colonne 1} & \tableheader{Colonne 2} & \tableheader{Colonne 3} \\
    \midrule
    Donnée 1 & 123 & 456 \\
    Donnée 2 & 789 & 012 \\
\end{nicetable}
```

#### Avec le package siunitx pour aligner les nombres

```latex
\begin{table}[htbp]
  \centering
  \caption{Exemple avec nombres alignés}
  \label{tab:exemple-nombres}
  \begin{tabular}{l S[table-format=2.1] S[table-format=3.2]}
    \toprule
    {Paramètre} & {Valeur 1} & {Valeur 2} \\
    \midrule
    Alpha & 10.5 & 105.00 \\
    Beta & 20.7 & 207.50 \\
    \bottomrule
  \end{tabular}
\end{table}
```

## 5. Système de références et citations

### Références aux éléments du document

Le template propose des commandes simplifiées pour référencer les différents éléments :

```latex
\figref{image}          % Référence à Figure X
\tabref{tableau}        % Référence à Tableau X
\eqref{equation}        % Référence à Équation X
\secref{section}        % Référence à Section X
```

Exemple d'utilisation :
```latex
Comme montré dans \figref{logo_rennes}, le processus hydrologique...
Les résultats de conductivité sont présentés dans \tabref{conductivite}.
Voir \secref{exemples-de-figures} pour plus de détails sur les visualisations.
```

### Gestion de la bibliographie

Le template utilise BibLaTeX pour gérer les références bibliographiques.

#### Ajouter des références au fichier BibTeX

Toutes les références doivent être ajoutées au fichier `assets/bibliography/references.bib` dans le format BibTeX approprié. Exemple :

```bibtex
@article{Aquilina2012,
  author  = {Aquilina, Luc and Vergnaud-Ayraud, Virginie and Labasque, Thierry and Bour, Olivier},
  title   = {Nitrate dynamics in agricultural catchments},
  journal = {Science of The Total Environment},
  year    = {2012},
  volume  = {435-436},
  pages   = {167--178},
  doi     = {10.1016/j.scitotenv.2012.06.028}
}

@book{Bear2018,
  author    = {Bear, Jacob and Cheng, Alexander H.-D.},
  title     = {Modeling Groundwater Flow and Contaminant Transport},
  publisher = {Springer},
  year      = {2018},
  address   = {Cham},
  edition   = {2}
}
```

#### Citer des références dans le texte

Plusieurs méthodes de citation sont disponibles :

```latex
% Citation simple entre parenthèses
\parencite{Aquilina2012}  % Résultat : (Aquilina, 2012)

% Citation intégrée dans le texte
\textcite{Bear2018} a démontré que...  % Résultat : Bear (2018) a démontré que...

% Citations multiples
\parencite{Aquilina2012,Bear2018,Roques2013}  % Résultat : (Aquilina, 2012; Bear, 2018; Roques, 2013)

% Citation avec page
\parencite[p.~167]{Marsily1986}  % Résultat : (Marsily, 1986, p. 167)
```

#### Génération de la bibliographie

La bibliographie est générée automatiquement à partir des références citées dans le document. Dans `main.tex`, la section suivante génère la bibliographie :

```latex
\clearpage
\printbibliography[heading=bibliography, title=Références bibliographiques]
```

## 6. Insertion de code et formules

### Insertion de code

#### Bloc de code Python

```latex
\begin{pythoncode}[Titre optionnel]
def hello_world():
    print("Hello, world!")
\end{pythoncode}
```

#### Code en ligne

```latex
\inlinecode{print("Hello")}
```

### Chemins de fichiers stylisés

```latex
\filepath{/chemin/vers/fichier.txt}       % Fichier simple
\folderpath{/chemin/vers/dossier/}        % Dossier avec icône
\urlpath{https://example.com}             % URL avec icône
```

### Équations et formules

#### Équation simple

```latex
\begin{equation}
E = mc^2
\end{equation}
```

#### Équation avec label pour référence

```latex
\begin{equation}
\label{eq:einstein}
E = mc^2
\end{equation}

Selon l'équation \eqref{einstein}, l'énergie est proportionnelle à la masse.
```

#### Symboles mathématiques prédéfinis

Le template définit des commandes pour certains symboles couramment utilisés en hydrogéologie :

```latex
\porosity      % Porosité (symbole phi)
\permeability  % Perméabilité (symbole K)
\conductivity  % Conductivité (symbole sigma)
```

## 7. Boîtes d'information (Callouts)

Le template propose plusieurs types de boîtes d'information pour mettre en évidence des contenus importants :

```latex
\begin{InfoBox}
Ceci est une information importante.
\end{InfoBox}

\begin{TipBox}
Voici une astuce utile.
\end{TipBox}

\begin{WarningBox}
Attention à ce point particulier.
\end{WarningBox}

\begin{ImportantBox}
Ce point est crucial.
\end{ImportantBox}
```

## 8. Ajout de nouveaux chapitres

1. Créez un nouveau fichier dans `content/chapters/`, par exemple `chapitre1.tex`
2. Commencez-le par :
   ```latex
   \chapter{Titre du chapitre}
   \minitoc  % Mini table des matières
   \newpage
   
   \section{Première section}
   \label{sec:premiere-section}  % Important pour les références
   Contenu...
   
   \subsection{Sous-section}
   \label{sec:sous-section}
   Contenu...
   ```
3. Ajoutez-le dans `main.tex` :
   ```latex
   \input{content/chapters/chapitre1.tex}
   ```

## 9. Dépannage courant

### Problèmes de compilation

- **Erreurs de référence non résolue** : Compilez plusieurs fois avec `./compile.sh`
- **Figures non trouvées** : Vérifiez les chemins relatifs des références aux images
- **Bibliographie non mise à jour** : Assurez-vous que biber est installé et exécuté (le script compile.sh s'en charge)
- **Page vide à la fin** : Si gênant, modifiez l'option de classe en `\documentclass[12pt,a4paper,openany]{report}`
- **Double entrée dans la table des matières** : Utilisez l'option `notoc` dans `\printbibliography`

### Nettoyage des fichiers temporaires

```bash
./compile.sh --clean
```

## 10. Conseils avancés

### Ajout d'un style de code pour un nouveau langage

Dans `config/code-style.tex`, ajoutez :

```latex
\lstdefinestyle{ccode}{%
  language=C,
  % autres paramètres similaires à githubdark
}

\tcbset{
  clisting/.style={%
    % paramètres similaires à pythonlisting
  }
}

\newtcblisting{ccode}[1][]{clisting,title=#1}
```

### Personnalisation des callouts

Pour ajouter un nouveau type de callout, dans `config/callouts.tex` :

```latex
\definecolor{notePurple}{HTML}{9F7AEA}  % Définir dans colors.tex
\newtcolorbox{NoteBox}{%
  callout,
  borderline west={3pt}{3pt}{notePurple},
  overlay unbroken and first={
    \node[anchor=north west, inner sep=0pt, text=notePurple] 
      at ([xshift=7pt, yshift=-5pt]frame.north west) {\faBook};
  }
}
```

### Unités avec siunitx

Le template définit des commandes pour les unités courantes :

```latex
\ms       % Mètres par seconde
\cms      % Centimètres par seconde
\m        % Mètre
\cm       % Centimètre
\mm       % Millimètre
\km       % Kilomètre
\sqkm     % Kilomètre carré
\cubicm   % Mètre cube
```

Exemple d'utilisation :
```latex
La vitesse d'écoulement est de 2,5\ms dans les zones fracturées.
```