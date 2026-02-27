#!/usr/bin/env bash

for f in f???[rv].jpg; do
 echo mv -- "$f" "${f/_03.jpg/.jpg}"
done
