#!/usr/bin/env bash
sudo apt-get -qqy update
sudo apt-get -qqy install \
	fakeroot debhelper locales \
        libffi-dev \
        liblapack3 liblapack-dev
