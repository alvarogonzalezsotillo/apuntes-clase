#!/bin/sh
html_files(){
    find . | grep -e html$ -e pdf$ | grep -v media | grep par | sort
}

to_link(){
    local FILE="$1"
    echo '<a href="'$FILE'">'$FILE'</a>'
}

links(){

    for file in $(html_files)
    do
        echo '<p>'
        to_link "$file"
        echo '</p>'
    done;
}

links > index.html
