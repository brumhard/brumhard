#!/usr/bin/env bash

cows=(
    dragon
    stegosaurus
    turkey
    turtle
    # moose
    # tux
)

selected_cow=${cows[$RANDOM % ${#cows[@]}]}
cat <<EOT | cowsay -nf "$selected_cow"
Hello there!  
Welcome to my GitHub profile.
EOT
