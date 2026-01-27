#!/usr/bin/env bash

set -e

if [ "$#" -ne 3 ]; then
    echo "Usage:"
    echo "  $0 input.pdf output.pdf \"TEXT\"e"
    echo
    echo "Example:"
    echo "  $0 in.pdf out.pdf \"SECRET\""
    exit 1
fi

function haz_outlines(){
    local INPUT_PDF="$1"
    local OUTPUT_PDF="$2"
    gs -dNoOutputFonts -r720 -sDEVICE=pdfwrite -o "$OUTPUT_PDF" "$INPUT_PDF"    
}

function haz_overlay(){
    local TMPDIR="$1"
    local TEXFILE="$2"
    local TEXT="$3"
    
    local LATEX="
        \\textcolor[gray]{0.99}{$TEXT}
        \\clearpage
        \\textcolor[gray]{0.99}{
          Recuerda que las prácticas sirven para enfrentarse con garantías al examen, y que no sirve de nada
          una gran nota en las prácticas frente a una baja nota en el examen, porque el examen tiene bastante
          peso.
          Recuerda las implicaciones éticas e incluso legales de no realizar las prácticas que presentas como propias.
        }
        \\clearpage
    "
    
    cat > "$TEXFILE" <<EOF
    \\documentclass{article}
    \\usepackage{pdfpages}
    \\usepackage{xcolor}
    \\usepackage[paperwidth=\\pdfpagewidth,paperheight=\\pdfpageheight]{geometry}
    \\pagestyle{empty}

    \\begin{document}

      $LATEX  
      $LATEX  
      $LATEX  
      $LATEX  
      $LATEX  
      $LATEX  

    \\end{document}
EOF

    pdflatex -interaction=nonstopmode -output-directory "$TMPDIR" "$TEXFILE" > /dev/null
}


INPUT_PDF="$1"
OUTPUT_PDF="$2"
TEXT="$3"

TMPDIR="$(mktemp -d)"
TEXFILE="$TMPDIR/overlay.tex"
OVERLAY_PDF="$TMPDIR/overlay.pdf"
OUTLINE_PDF="$TMPDIR/outline.pdf"

haz_overlay "$TMPDIR" "$TEXFILE" "$TEXT" > /dev/null 2> /dev/null 
haz_outlines "$INPUT_PDF" "$OUTLINE_PDF" > /dev/null 2> /dev/null 
pdftk "$OUTLINE_PDF" multibackground "$OVERLAY_PDF" output "$OUTPUT_PDF" > /dev/null 2> /dev/null 
rm -rf "$TMPDIR"

echo "Done → $OUTPUT_PDF"
