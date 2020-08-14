# GROMACS-recipes

## About

GROMACS-recipes is an **unofficial** collection of instructions for using the molecular dynamics (MD) simulation package [GROMACS](http://www.gromacs.org/). The goal is to collect validated protocols for setting up and running the various kinds of MD simulations offered by the software. The contents of this repository are not intended to serve as an introduction to GROMACS or to MD simulations in general.

Unless stated otherwise, GROMACS version **2020.3** is used throughout the examples provided, although the protocols should work with other reasonably recent versions of the software as well.

## Installation

If performance is of any concern to you, consider building GROMACS from source. Follow the [installation guide](http://manual.gromacs.org/documentation/current/install-guide/index.html) to understand your options and select the most appropriate settings for your machine. The options I usually pass to `cmake` are
```
-DCMAKE_C_COMPILER=/usr/bin/gcc-8 \
-DCMAKE_CXX_COMPILER=/usr/bin/g++-8 \
-DCMAKE_INSTALL_PREFIX=/home/david/Programs/gromacs-2020.3 \
-DGMX_BUILD_OWN_FFTW=ON \
-DGMX_GPU=ON \
-DREGRESSIONTEST_DOWNLOAD=ON
```
Check the output of `cmake` carefully and make adjustments if needed. Don't forget to run the tests after building the software.


