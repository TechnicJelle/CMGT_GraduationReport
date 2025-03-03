#!/usr/bin/env bash

# In Termux, execute with `source compile.sh`

typst compile report.typ --font-path ./Fonts/ --ignore-system-fonts --input "NAME=$TYPST_NAME"
