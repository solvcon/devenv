#!/usr/bin/env bash
sudo apt-get -qqy update
sudo apt-get -qqy install \
        fakeroot debhelper locales \
        libffi-dev \
        liblapack3 liblapack-dev

# for sphinx's latex engine
sudo apt-get install -qqy texlive-latex-base texlive-latex-recommended latexmk
sudo apt-get install -qqy ghostscript imagemagick