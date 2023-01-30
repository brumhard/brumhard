#!/usr/bin/env bash

cows=(
    kitty
    dragon
    moose
    stegosaurus
    turkey
    turtle
    tux
)

selected_cow=${cows[$RANDOM % ${#cows[@]}]}
cat <<EOT | cowsay -nf "$selected_cow"
Hello there!  
Welcome to my GitHub profile.
EOT
