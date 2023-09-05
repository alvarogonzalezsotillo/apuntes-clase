for fichero in $*
do
    echo $fichero
    
    ficherosinextension=${fichero%.*}
    echo $ficherosinextension
    dirname "$fichero"
    inkscape --export-area-drawing --export-pdf="$ficherosinextension.pdf" "$fichero"
    cp "$ficherosinextension.pdf" "$fichero.pdf"
done
