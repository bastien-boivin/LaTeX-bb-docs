# Guide d'utilisation du template LaTeX Documentation_LakeRes

Ce guide vous explique comment utiliser et personnaliser le template LaTeX pour votre documentation.

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
│   └── commands.tex          # Commandes personnalisées
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
    └── bibliography/         # Bibliographie (à créer)
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

## 3. Personnalisation de base

### Informations générales

Modifiez les informations personnelles :

1. **Page de titre** : Ouvrez `content/frontmatter/titlepage.tex` et mettez à jour :
   - Le titre principal
   - Le sous-titre
   - Les informations d'auteur
   - Les informations d'encadrement

2. **En-têtes et pieds de page** : Dans `config/headers.tex`, personnalisez :
   ```latex
   \fancyhead[L]{\textcolor{gray}{Votre Nom}}
   \fancyhead[R]{\textcolor{gray}{Titre Court}}
   \fancyfoot[L]{\textcolor{gray}{Version}}
   \fancyfoot[R]{\textcolor{gray}{2025}}
   ```

### Adaptation visuelle

1. **Couleurs** : Modifiez les couleurs dans `config/colors.tex` pour changer :
   - Les couleurs de code
   - Les couleurs des callouts
   - Les couleurs générales du document

2. **Style des chapitres** : Personnalisez l'apparence des titres de chapitres dans `config/chapter-style.tex`

## 4. Utilisation des fonctionnalités

### Insertion de code

Pour insérer un bloc de code Python :
```latex
\begin{pythoncode}[Titre optionnel]
def hello_world():
    print("Hello, world!")
\end{pythoncode}
```

Pour du code en ligne : `\inlinecode{print("Hello")}`

### Utilisation des chemins de fichiers

```latex
\filepath{/chemin/vers/fichier.txt}       % Fichier simple
\folderpath{/chemin/vers/dossier/}        % Dossier avec icône
\urlpath{https://example.com}             % URL avec icône
```

### Création de callouts (boîtes d'information)

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

### Insertion de figures

Méthode standard :
```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.7\textwidth]{assets/figures/image.png}
    \caption{Description de l'image}
    \label{fig:image}
\end{figure}
```

Avec la commande simplifiée :
```latex
\centeredfigure[0.6]{assets/figures/image.png}{Description de l'image}
```

Pour deux figures côte à côte :
```latex
\twofigures{image1.png}{Légende 1}{image2.png}{Légende 2}{Légende générale}
```

### Création de tableaux

Avec l'environnement amélioré :
```latex
\begin{nicetable}{Titre du tableau}{tab:identifiant}{lcc}
    \tableheader{Colonne 1} & \tableheader{Colonne 2} & \tableheader{Colonne 3} \\
    \midrule
    Donnée 1 & 123 & 456 \\
    Donnée 2 & 789 & 012 \\
\end{nicetable}
```

### Références simplifiées

```latex
\figref{image}          % Référence à Figure X
\tabref{tableau}        % Référence à Tableau X
\eqref{equation}        % Référence à Équation X
\secref{section}        % Référence à Section X
```

## 5. Ajout de nouveaux chapitres

1. Créez un nouveau fichier dans `content/chapters/`, par exemple `chapitre1.tex`
2. Commencez-le par :
   ```latex
   \chapter{Titre du chapitre}
   \minitoc  % Mini table des matières
   \newpage
   
   \section{Première section}
   Contenu...
   ```
3. Ajoutez-le dans `main.tex` :
   ```latex
   \input{content/chapters/chapitre1.tex}
   ```

## 6. Dépannage courant

### Problèmes de compilation

- **Erreurs de référence non résolue** : Compilez plusieurs fois avec `./compile.sh`
- **Figures non trouvées** : Vérifiez les chemins relatifs dans vos références à des images
- **Packages manquants** : Installez les packages manquants avec votre gestionnaire LaTeX

### Nettoyage des fichiers temporaires

```bash
./compile.sh --clean
```

## 7. Conseils avancés

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

### Mode de surveillance pendant l'édition

Pour recompiler automatiquement à chaque changement :

```bash
./compile.sh --watch --view
```