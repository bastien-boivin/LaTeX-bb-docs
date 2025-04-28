#!/bin/bash
#==============================================================================
# SCRIPT DE COMPILATION LATEX INTELLIGENT
#==============================================================================
# Ce script détecte automatiquement les besoins en compilation (bibtex, etc.)
# et compile le document autant de fois que nécessaire
#==============================================================================

# Configuration
MAIN_FILE="${1:-main.tex}"  # Par défaut: main.tex, ou premier argument
OUT_DIR="build"             # Dossier de sortie pour les fichiers auxiliaires
CLEAN_MODE=0                # Mode nettoyage désactivé par défaut
SILENT_MODE=0               # Mode silencieux désactivé par défaut
WATCH_MODE=0                # Mode surveillance désactivé par défaut
VIEW_PDF=0                  # Mode visualisation du PDF désactivé par défaut

# Traitement des options
for arg in "$@"; do
  case $arg in
    -c|--clean)
      CLEAN_MODE=1
      shift
      ;;
    -s|--silent)
      SILENT_MODE=1
      shift
      ;;
    -w|--watch)
      WATCH_MODE=1
      shift
      ;;
    -v|--view)
      VIEW_PDF=1
      shift
      ;;
    -h|--help)
      echo "Usage: $0 [options] [main_file.tex]"
      echo "Options:"
      echo "  -c, --clean    Nettoie les fichiers temporaires avant compilation"
      echo "  -s, --silent   Mode silencieux (moins de messages)"
      echo "  -w, --watch    Mode surveillance (recompile quand les fichiers changent)"
      echo "  -v, --view     Ouvre le PDF après compilation"
      echo "  -h, --help     Affiche cette aide"
      exit 0
      ;;
  esac
done

# Créer le dossier de sortie s'il n'existe pas
mkdir -p "$OUT_DIR"

# Fonction de nettoyage
clean_files() {
  echo "Nettoyage des fichiers temporaires..."
  local EXTENSIONS=(
    "aux" "log" "toc" "out" "lof" "lot" "bbl" "blg" "fls" "fdb_latexmk"
    "synctex.gz" "listing" "nav" "snm" "vrb" "xdv" "mtc*" "maf" "ptc" "bcf" "run.xml"
  )
  
  for ext in "${EXTENSIONS[@]}"; do
    # Nettoyage dans le dossier racine
    find . -maxdepth 1 -name "*.$ext" -type f -delete
    # Nettoyage dans le dossier de sortie
    find "$OUT_DIR" -name "*.$ext" -type f -delete
  done
}

# Compiler le document
compile_document() {
  local COMPILE_CMD="pdflatex"
  local COMPILE_OPTS="-interaction=nonstopmode -output-directory=$OUT_DIR"
  
  if [ $SILENT_MODE -eq 1 ]; then
    COMPILE_OPTS="$COMPILE_OPTS -quiet"
  fi
  
  echo "Première compilation..."
  $COMPILE_CMD $COMPILE_OPTS "$MAIN_FILE"
  
  # Vérifier si bibtex est nécessaire
  if grep -q "\\\\bibliography" "$MAIN_FILE" || grep -q "\\\\addbibresource" "$MAIN_FILE"; then
    echo "Exécution de BibTeX..."
    cd "$OUT_DIR"
    bibtex "${MAIN_FILE%.tex}"
    cd ..
  fi
  
  echo "Deuxième compilation..."
  $COMPILE_CMD $COMPILE_OPTS "$MAIN_FILE"
  
  echo "Troisième compilation pour finaliser les références..."
  $COMPILE_CMD $COMPILE_OPTS "$MAIN_FILE"
  
  echo "Compilation terminée!"
  
  # Copier le PDF final dans le dossier racine pour plus de commodité
  cp "$OUT_DIR/${MAIN_FILE%.tex}.pdf" .
  
  # Ouvrir le PDF si demandé
  if [ $VIEW_PDF -eq 1 ]; then
    if command -v xdg-open &> /dev/null; then
      xdg-open "${MAIN_FILE%.tex}.pdf"
    elif command -v open &> /dev/null; then
      open "${MAIN_FILE%.tex}.pdf"
    else
      echo "Impossible d'ouvrir automatiquement le PDF. Veuillez l'ouvrir manuellement."
    fi
  fi
}

# Mode surveillance
watch_files() {
  echo "Mode surveillance activé. Appuyez sur Ctrl+C pour quitter."
  
  # Compilation initiale
  compile_document
  
  # Liste de tous les fichiers .tex à surveiller
  local FILES_TO_WATCH=$(find . -name "*.tex" | tr '\n' ' ')
  
  # Dernière modification
  local LAST_MODIFIED=$(date +%s)
  
  while true; do
    # Vérifier les modifications
    for file in $FILES_TO_WATCH; do
      if [ -f "$file" ]; then
        local FILE_MOD=$(stat -c %Y "$file" 2>/dev/null || stat -f %m "$file" 2>/dev/null)
        if [ "$FILE_MOD" -gt "$LAST_MODIFIED" ]; then
          echo "Modification détectée dans $file"
          LAST_MODIFIED=$(date +%s)
          compile_document
          break
        fi
      fi
    done
    
    # Attendre avant de revérifier
    sleep 1
  done
}

# Exécution principale
if [ $CLEAN_MODE -eq 1 ]; then
  clean_files
fi

if [ $WATCH_MODE -eq 1 ]; then
  watch_files
else
  compile_document
fi