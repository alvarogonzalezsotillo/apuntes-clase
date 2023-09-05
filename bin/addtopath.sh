#!/bin/sh


THISFILE="$0"
THISABSOLUTEFILE=$(readlink -f "$THISFILE")
THISABSOLUTEPATH=$(dirname "$THISABSOLUTEFILE")
echo Si se ejecuta con source, añade las utilidades al PATH \($THISABSOLUTEPATH\)
export PATH=$PATH:"$THISABSOLUTEPATH"


