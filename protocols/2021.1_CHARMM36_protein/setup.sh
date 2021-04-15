#!/bin/bash

INPUT_NAME="ALA5"
BOX_DIST="1.2"
ION_CONC="0.15"

echo -e "0\n0\n" | \
gmx pdb2gmx -f ${INPUT_NAME}.pdb \
	    -o ${INPUT_NAME}_processed.gro \
	    -ff charmm36-feb2021 \
	    -water tip3p \
	    -ter \
	    -ignh

gmx editconf -f ${INPUT_NAME}_processed.gro \
	     -o ${INPUT_NAME}_newbox.gro \
	     -bt dodecahedron \
	     -d ${BOX_DIST}

gmx solvate -cp ${INPUT_NAME}_newbox.gro \
	    -cs spc216.gro \
	    -p topol.top \
	    -o ${INPUT_NAME}_solv.gro

gmx grompp -f em.mdp \
	   -c ${INPUT_NAME}_solv.gro \
	   -p topol.top \
	   -o ions.tpr \
	   -maxwarn 1

echo -e "SOL\n" | \
gmx genion -s ions.tpr \
	   -p topol.top \
	   -o ${INPUT_NAME}_solv_ions.gro \
	   -pname NA \
	   -nname CL \
	   -conc ${ION_CONC} \
	   -neutral

gmx grompp -f em.mdp \
	   -c ${INPUT_NAME}_solv_ions.gro \
	   -p topol.top \
	   -o em.tpr

gmx mdrun -s em.tpr \
	  -o em.trr \
	  -c em.gro \
	  -e em.edr \
	  -g em.log \
	  -v

gmx grompp -f nvt.mdp \
	   -c em.gro \
	   -r em.gro \
	   -p topol.top \
	   -o nvt.tpr

gmx mdrun -s nvt.tpr \
	  -x nvt.xtc \
	  -cpo nvt.cpt \
	  -c nvt.gro \
	  -e nvt.edr \
	  -g nvt.log \
	  -update gpu \
	  -v

gmx grompp -f npt.mdp \
	   -c nvt.gro \
	   -r nvt.gro \
	   -p topol.top \
	   -t nvt.cpt \
	   -o npt.tpr

gmx mdrun -s npt.tpr \
	  -x npt.xtc \
	  -cpo npt.cpt \
	  -c npt.gro \
	  -e npt.edr \
	  -g npt.log \
	  -update gpu \
	  -v

gmx grompp -f md.mdp \
	   -c npt.gro \
	   -p topol.top \
	   -t npt.cpt \
	   -o md.tpr

gmx mdrun -s md.tpr \
	  -x md.xtc \
	  -cpo md.cpt \
	  -c md.gro \
	  -e md.edr \
	  -g md.log \
	  -update gpu \
	  -v

echo -e "Protein\nSystem\n" | \
gmx trjconv -f md.xtc \
	    -s md.tpr \
	    -o md_no_PBC.xtc \
	    -pbc mol \
	    -ur compact \
	    -center

echo -e "Protein\nSystem\n" | \
gmx trjconv -f md.gro \
	    -s md.tpr \
	    -o md_no_PBC.gro \
	    -pbc mol \
	    -ur compact \
	    -center
