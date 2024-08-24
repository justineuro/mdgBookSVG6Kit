#!/bin/bash
#===================================================================================
#
#	 FILE:	mdg62midRndN+svg.sh
#
#	USAGE:	mdg62midRndN+svg.sh <num>
#
#		where <num> is the number of random MDG minuets to be generated, e.g., 20.
#		*** NOTE:  This script has to be in the same directory as mdg62mid+svg.sh. ***
#
# DESCRIPTION:	Used for generating <num> ABC files, each a Musical Dice Game (MDG)
#		dance + trio based on Gustav Gerlach's "Schottische Taenze"
#
#      AUTHOR:	J.L.A. Uro (justineuro@gmail.com)
#     VERSION:	0.0.0
#     LICENSE:	Creative Commons Attribution 4.0 International License (CC-BY)
#     CREATED:	2024/08/21 19:36:26
#    REVISION:	
#==================================================================================

#----------------------------------------------------------------------------------
# define the function genS() that randomly chooses an integer from 1 to 6, inclusive
#----------------------------------------------------------------------------------
genS() { # RANDOM randomly generates an integer from 0 to 32765
	rnd=32766
	until [ $rnd -lt 32766 ]
	do
		rnd=$[RANDOM]
		if [ $rnd -lt 32766 ]; then echo $[rnd%6+1]; fi
	done
}

#----------------------------------------------------------------------------------
# declare the variables "diceS" as an array
# diceS - array containing the 16 outcomes from input line
#----------------------------------------------------------------------------------
declare -a diceS

#----------------------------------------------------------------------------------
# generate the <num> random minuets
#----------------------------------------------------------------------------------
i=1
while [ $i -le $1 ]; do

#----------------------------------------------------------------------------------
# generate the random 16-sequence of outcomes of the 32 throws of a dice for 
# the dance and trio
#----------------------------------------------------------------------------------
	for j in {0..15}; do
		diceS[$j]=`genS`
	done
	
#----------------------------------------------------------------------------------
# generate a dance and trio in ABC notation and corresponding MIDI and svg for the current 
# diceS using mdg62mid+svg.sh
#----------------------------------------------------------------------------------
	./mdg62mid+svg.sh ${diceS[*]}
	i=`expr $i + 1`
done
#
##
####
