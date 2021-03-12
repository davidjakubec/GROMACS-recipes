# GROMACS-recipes

## About

GROMACS-recipes is an **unofficial** collection of instructions for using the molecular dynamics (MD) simulation package [GROMACS](http://www.gromacs.org/). The goal is to collect validated protocols for setting up and running the various kinds of MD simulations offered by the software. The contents of this repository are not intended to serve as an introduction to GROMACS or to MD simulations in general.

Unless stated otherwise, GROMACS versions **2020.3** and **2021.1** are used throughout the examples provided, although the protocols should work with other reasonably recent versions of the software as well.

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
for GROMACS 2020.3, and
```
-DCMAKE_C_COMPILER=/usr/bin/gcc-8 \
-DCMAKE_CXX_COMPILER=/usr/bin/g++-8 \
-DCMAKE_INSTALL_PREFIX=/home/david/Programs/gromacs-2021.1 \
-DGMX_BUILD_OWN_FFTW=ON \
-DGMX_GPU=CUDA \
-DGMXAPI=OFF \
-DREGRESSIONTEST_DOWNLOAD=ON
```
for GROMACS 2021.1. Check the output of `cmake` carefully and make adjustments if needed. Don't forget to run the tests after building the software.

## Post-installation

The force fields (FFs) bundled with GROMACS are quite ancient. If comparison with previous works (utilizing these FFs) is not your primary goal, more recent FFs should be downloaded, installed, and used. Good choices include the [CHARMM36](https://mackerell.umaryland.edu/charmm_ff.shtml#gromacs) or the [ff14SB/OL15](https://fch.upol.cz/ff_ol/gromacs.php) FFs; other FFs are available as volunteer contributions on the [GROMACS website](http://www.gromacs.org/Downloads_of_outdated_releases/User_contributions/Force_fields).

## Running MD simulations

Instructions for running various kinds of MD simulations can be found in `protocols/`. Protocol names have the form `version_FF_system[_modification]`, where `version` is the GROMACS version used, `FF` is the name of the FF used, `system` is the type of biological system simulated (*e.g.*, protein, DNA, lipid, ...), and `modification` is an optional alteration of the base protocol (for the given GROMACS version, FF, and system type). It is expected that the required FF files are installed on the system when using the respective protocols.
