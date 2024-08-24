#!/bin/bash
#===================================================================================
#
#	 FILE:	mdg62mid+svg.sh (dances+trios)
#
#	USAGE:	mdg62mid+svg.sh n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 n16 
#
#		where n1-n16 are any of the 6 possible outcomes of a toss of
#		one ordinary six-sided die, e.g., n1-n16 are 16 integers, not necessarily 
#		unique, chosen from the set {1, 2, 3, 4, 5, 6}; 
#		n1-n8 are for the bars of the dances while n9-n16 are for the bars of the trios
#
# DESCRIPTION:	Used for generating ABC, MIDI, and SVG files of a particular 
#		Musical Dice Game (MDG) dance + trio based on Gustav Gerlach's
#		"Schottische Taenze"
#
#      AUTHOR:	J.L.A. Uro (justineuro@gmail.com)
#     VERSION:	0.0.1
#     LICENSE:	Creative Commons Attribution 4.0 International License (CC-BY)
#     CREATED:	08.19.2024 13:39:09
#    REVISION:	08.22.2024 14:38:50
#==================================================================================

#----------------------------------------------------------------------------------
# declare the variables "diceS" and "measNR" as arrays
# diceS - array containing the 16 outcomes from input line
# measNR - array of all possible bar numbers (1 to 192) for a specific die outcome
#----------------------------------------------------------------------------------
declare -a diceS measNR
#----------------------------------------------------------------------------------
# input a 32-sequence of tosses based on the 16 given in the command line;
# each of the 16 1-die toss outcome is duplicated
#----------------------------------------------------------------------------------
diceS=( $1 $1 $2 $2 $3 $3 $4 $4 $5 $5 $6 $6 $7 $7 $8 $8 $9 $9 ${10} ${10} ${11} ${11} ${12} ${12} ${13} ${13} ${14} ${14} ${15} ${15} ${16} ${16} )

#----------------------------------------------------------------------------------
# input rule table to determine corresponding G/F measures for each toss outcome
#----------------------------------------------------------------------------------
## for dances
ruletab() {
	case $1 in
	1) measNR=( 65  14  29  17 108  96  37  50  41  35  92 139  49  90  11  59);;
	2) measNR=( 77 109   9  28  48  99  21   7   6  80   1  47 107  31 127  51);;
	3) measNR=( 15  87  55  95 144  74 104 120 130 100  71 150 111  69  72 102);;
	4) measNR=( 89  12  75   3  66 175  20  70 149  46 117  94  19  86 128  52);;
	5) measNR=( 40  98  36  10  78  44  33 136  39 110 143  30  58  67  22  91);;
	6) measNR=(  8  88 101  32  60   4 106  93 105  45 112  27  61 119 103 148);;
	esac
}

## for trios
ruletabT() {
	case $1 in
	1) measNR=( 13  85 126 180 125  68 177 192 187  63  24  97 145 185 137 176);;
	2) measNR=(165 113  23  76  82   2 154 190   5  84 161 182 174 116  54 124);;
	3) measNR=( 43  57 135 188  56  18 189 163  25  38 166 122 179 123 169  53);;
	4) measNR=(181 129 131 186 115 170  62 178 183 132 168 171  81 151 158  64);;
	5) measNR=(134  26 118 184 160 140 114  34  42 164 146  83 141 162  73 153);;
	6) measNR=( 79 191 121 155 138 156  16 173 133 167 142 172 147 159 152 157);;
	esac
}

#----------------------------------------------------------------------------------
# input notes
# declare variables "notesG" and "notesF" as arrays
# notesG - array that contains the possible treble clef notes per bar 
# notesF - array that contains the possible bass clef notes per bar
#----------------------------------------------------------------------------------
declare -a notesG notesF

#----------------------------------------------------------------------------------
# define notesG, array of 192 possible treble clef bars 
#----------------------------------------------------------------------------------
notesG=( "d/e/f/d/ Bd" "a/^g/a/b/ c'd'" "[cg][^fc][Bg]2" "Gc/d/ e/f/g" "e3/d/BB" "^c/c/e/c/ Ac" "c[Ge][Ec]2" "cc/B/ AE" 
"Ba gf" "BGg2" "f/e/f/a/ dB" "[eg][Gc][ce]2" "[Ac]2[G^c]2" "e/d/^c/e/ d2" "[EG][FA]/[EG]/ [EG][Ec]" "g/a/=b/c'/ d'g" 
"e{^d}eE2" "d'/^c'/d'/e'/ f'a'" "d'abe'" "g/^f/f/e'/ e'/d'/c'/a/" "ed a/g/f/d/" "c'd'/_e'/ ge" "eB^ge" "c'_bge" 
"ec ge" "Ac ea" "ce ac'" "ed c2" "de/d/ Af" "ec' g2 & c4" "f/e/^d/e/ ce" "[Gce]2[GBd]z" 
"gB ^fA" "a[ca] [Aa]2" "c/d/e/c/ Aa" "af dc" "a/f/e/d/ c/g/B/d/" "f/e/f/g/ aa" "ef/e/ ^de & c4" "[EG][FA]/[EG]/ [Ec][ce]" 
"^G/A/B/G/ Ee" "a^g/a/ _ba" "A_B/=B/ (3cfA" "c'd bd" "Bd gb" "ceG2" "ceg2" "[^Gd][Ge] [A^f][B^g]" 
"b/c'/d'/b/ gf'" "c[Ec][Ec]2" "c[Ge][Ec]2" "cc'c2" "faf2" "bd'/b/ a^g & d2cB" "de/d/ dg & F2F2" "ae ^c'e'" 
"_Bc/e/ g2" "gd'/^d'/ e'g" "c/d/e/d/c2" "Ad/e/ f/g/a" "bf/b/ d'f'" "g^f/g/ _af/d/" "c'a f'a" "f[ca] [Af]2" 
"Ec/E/ Ge" "g/f/f/d'/ d'f" "c'd'/e'/ f'a" "d'c' _ba" "c'/_b/a/g/ af" "g[Bg][Bg]2" "de/d/ c'a" "af/d/ c/g/B/d/" 
"a/b/c'/d'/ e'^g" "d'c' ae" "ee/d/ ad" "a/^g/a/b/ c'2" "[Ec][Ec] [Fd][Ge] " "e/d/^c/d/ ad" "cA ae" "a/g/f/e/ fd" 
"c'/d'/e'/f'/ g'a" "{^a}b2 {a}be'" "a4" "(ceA)!dot!a" "d/^c/d/e/ fd & F2z2" "c'a bc'" "[EG][FA]/[EG]/ [EG][Ge]" "ee/d/ cA" 
"[cc'][gb]/[fa]/ [eg][fa]" "e'c' ge" "gBc2" "^f/g/a/f/ dc'" "be e'e" "gc ec'" "e/f/d/e/ c2 & GFE2" "a/g/^f/g/ c'e" 
"fac2" "[eg][ce][ec']2" "!turn!a3/b/ c'e & c4" "ec ag" "[GCg][Gc] [Acf][cfa]" "c[Ec][Ec]2" "bd'/b/ a^g" "g/f/e/d/ cB" 
"Ad ^c/d/e/d/" "^ge ae" "g/^f/g/^f/ ad" "a/^g/a/b/ c'a" "!turn!f3/g/a2 & A4" "ag ^fg & B4" "be'/d'/ c'a" "be ^d/e/=d/B/" 
"ec ae" "bd'/f'/ e'^g" "{a}_b2 {a}bg" "a3/g/ ff & ^c2d2" "fG/B/ da" "e3/f/ ed" "f'e' c'a" "A[CA][CA]2" 
"Af _A/f/G/g/" "d2z2" "af' c'a" "[Aa][ca] [Aa]2" "c'/f'/e'/f'/ g'/f'/e'/d'/" "ec c'g" "^c/d/f/a/ gB" "af dB" 
"(3{B}cef f2" "GA/G/ fd" "{^d}e2 {d}e^c" "af ca" "^GB e^g" "z4" "g^f/g/ a/g/=f/d/" "eEE2" 
"d^b/d'/ c'e & z[DG] z[G_B]" "a/_b/c'/d'/ bg" "ba g2" "_bc'/b/ af" "b/a/^g/^f/ eb" "{b}c'b/a/ c'b/a/" "ag fd & B4" "e/^d/e/^g/ be" 
"d'e'/f'/ f'g" "e'3/d'/ bc'" "dc' bd" "a[ca] [ca]2" "f/g/a/f/ dB" "d'/c'/b/a/ bg" "c'/e'/f'/g'/ a'a'" "bd'/f'/ e'^g" 
"ac'/b/ a2" "e/e'/c'/a/ ^g/e/b/g/" "(3egc a2" "g/a/_b/c'/ af" "aa'a2" "^c'/d'/e'/f'/ =c'e" "cb ac" "c'd'/c'/ be" 
"a^g/a/ be" "d'c' aa" "g{b}c' c'c" "f'2 d'a" "[cc']A/B/ c/c/c/d/" "a3/g/ ef" "a/b/c'/d'/ e'a" "a/g/^f/g/ ab" 
"g^f/g/ c'e" "af' c'a" "c'2z2" "^ge' c'a" "e'd'c'2" "c'3/_b/ aa & c2 cc" "f/e/e/c'/ c'e" "[Af][ca][Af]2" 
"g/^f/g/d'/ c'/_b/g/e/" "^ca A2" "c'b/c'/ e'/d'/_b/g/" "_b/a/^g/a/ f2" "{B}c2{B}c2" "c'b a2" "c/d/e/f/ g_b" "cB A2" 
" _bc'/d'/ c'f" "(3dfa a2" "{c}e{e}g {g}_b{_b}d'" "ce c'2" "(3a^g=g gf" "ac'a2" "g/f/e/g/f2" "f[ca][Af]2" )

#----------------------------------------------------------------------------------
# define notesF, array 192 possible bass clef bars
#----------------------------------------------------------------------------------
notesF=( "z[B,F] [DF][B,F] & G,4" "A,[CE] D,[A,D]" "[G,D][A,D][G,D]2" "E,G, CE" "[K:C clef=treble] z[B,E] [DE][DE] & ^G,4" "z[EG] [^CG][^CG] & A,4" "[CE]CC,2" "A,,[A,C] [A,C][A,C]" 
"z[B,D] [B,D][B,D] & G,4" "[G,B,D][G,B,][G,B,]2" "F,[A,D] G,[DF]" "C,E C2" "[F,F]2[A,E]_E" "z[B,D][B,D][B,D] & G,4" "zCCC & C,4" "[K:C clef=treble] z[FG][FG][FG] & =B,4" 
"[E,^G,B,]{^D}EE,2" "z[B,D][B,D][B,D] & D,4" "[^F,CD]2[G,B,D][^G,B,D]" "z[A,C][A,C][^F,D] & D,4" "z[B,F]z[B,F] & G,2G,2" "[^F,A,C_E]2[G,C=E]2" "^G,[DE]B,[DE]" "G,[CE]_B,[CG]" 
"[K:C clef=bass] z[_B,C] [_B,C][_B,C] & C,4" "A,C EA" "z[CE] [CE][CE] & A,4" "[G,CE][G,B,D] [CE]2" "z[A,D]z[A,D] & F,2D,2" "C,E, [CE]G," "C,[CE] A,[CE]" "G,4" 
"E,[G,B,] B,,[^F,B,]" "[A,C][A,E] [A,C]2" "z[CE] [CE][CE] & A,4" "[F,A,D]2[^F,A,D]2" "F,[A,D] [G,CE][G,B,F]" "z[A,C] [A,C][A,C] & F,4" "C,G, [CE]G," "zC CC & C,4" 
"z[B,D] [B,D][B,D] & E,4" "[K:C clef=bass] z[^CE] [CG][CG] & A,4" "z[CF] [CF][CF] & F,4" "z[^F,C] zB, & D,2G,2" "z[B,D] [B,D][B,D] & G,4" "C,[CE] [CE][CE]" "C,[CE] [CE][CE]" "E,E [^DE][=DE]" 
"z[B,F] [B,D][B,D] & G,4" "[CE]G,C,2" "[CE]CC,2" "[CE][EG][CE]2" "[F,A,]C[F,A,]2" "zF ED & F,2E,E," "zB, B,B, & G,4" "z[^CG] [^CG][^CG] & A,4" 
"C,[CE] [CE][CE]" "[G,B,F]2[G,CE]2" "[G,CE][G,B,F][CE]2" "F,A, DF" "z[F,B,] [F,B,][F,B,] & D,4" "[_B,DG]2[B,DF]2" "A,[CF] F,[CF]" " [FA]CF,2" 
"z[G,C] [G,C][G,C] & C,4 " "z[B,D] [B,D][B,D] & G,4" "[G,_B,C]2[F,A,C]2" "zF zF & C2D2" "z[_B,E] z[A,C] & C,2F,2" "[G,B,]G,G,,2" "z[A,D] [A,D][A,D] & ^F,4" "F,[A,D] [G,CE][G,B,F]" 
"E,[CE] E,[B,D]" "z[CE] z[CE] & A,2A,2" "z[CD] [CD][CD] & F,4" "A,[CE] [CE][CE]" "C,C [B,C][_B,C]" "^F,[A,D] F,[CD]" "G,[CE] [CE][CE]" "D,[DF] [DF][DF]" 
"z[CE] [CE][CE] & G,4" "E,[^G,D] G,[DE]" "z[CE] [CE][CE] & A,4" "[K:C clef=bass] z[CE] [CE][CE] & A,4" "_B,,[_B,D] [B,D][B,D]" "[A,C][^F,A,D] [G,B,=F][A,CE]" "zC CC & C,4" "A,,[A,C] [A,C][A,C]" 
" zC CC & C,4" "C,[CE] [CE][CE]" "[G,DF][G,DF][CE]2" " z[CD] z[A,D] & A,2^F,2" "[E,^G,B,]2 EE," "C,[CE] [CE][CE]" "[G,C][G,B,][C,C]2" "C,[CE] [CE][CG]" 
" z[CF] [CF][CF] & F,4" " zC C2 & C,4" "E3 E & C3/B,/ A,C" "z[CE] [CE][CE] & C,4" "E,2F,F," "[CE]G, C,2" "z[A,B,D] [E,C][E,B,D] & F,4" "z[A,D] [E,A,E][E,^G,D] & F,4" 
"z[^F,C] [^F,C][^F,C] & D,4" "[E,B,D]2[E,A,C]2" "z[B,F] [B,F][B,F] & G,4" "z[CF] [CF][CF] & F,4" "C4 & A,3/G,/ F,2" "G,,G, [DF]G," "^G[B,E] A,[CE]" "z[^G,D] [G,D][G,D] & E,4" 
"A,,[CE] A,[CE]" "D,[A,B,] E,[B,D]" "C,[G,E] [G,E][_B,E]" "zE Dz & A,2 zD," "G,[B,F] G,[B,F]" "z[B,E] [B,E][B,E] & ^G,4" "z[A,C] [A,C][A,C] & E,4" "[A,C]E,A,,2" 
"[DF]2[CD][B,D]" "D,FD2" "z[CF] [CF][CF] & F,4" "[A,C]E,A,,2" "z[CF] z[DF] & A,2_B,2" "z[_B,E] [B,E][B,E] & G,4" "z[A,D] z[DF] & F,2G,2" "[F,CD]2 [G,B,D][G,DF]" 
"z[A,F] [A,F][A,F] & F,4" "z[B,D] [B,D][B,F] & G,4" "z[^CG] [^CG][EG] & A,4" "z[CF] [CF][CF] & F,4" "[K:C clef=bass] z[^G,D] [B,E][B,E] & E,4" "A,2CE & A,,2 C,E," "z[B,D] [B,F][B,F] & G,4" "[E,G,B,][E,G,B,][E,G,]2" 
"_B,2C2" "z[A,D] z[_B,D] & ^F,2G,2" "[G,B,D][^F,CD][G,B,D]2" "z[CE] z[A,C] & G,2F,2" "z[^G,D] [G,D][G,D] & E,4" "z[C_E] z[CE] & ^F,2=F,2" "G,,G, [DF]G," " z[B,E] z[DE] & ^G,2G,2" 
"[^G,B,F]2[=G,B,F]2" "z[B,E] [B,E][B,E] & ^G,4" "D,[A,F] E,[B,E]" "[A,C][A,E] [A,C]2" "z[B,D] [B,D][DF] & G,4" "z[CD] z[B,D] & ^F,2G,2" "z[CF] z[CF] & A,2F,2" "z[A,B,] z[B,D] & D,2E,2" 
"[A,C][E,^G,D][A,C]2" "E,[CE] [E,B,D][E,B,D]" "C,[CE] [CE][CE]" "z[G,C] z[A,C] & E,2F,2" "[A,C]E, A,,2" "[K:C clef=treble] [_B,DG][=B,D^G] [CFA][CG_B]" "E,[CE] F,[A,F]" "z[CE] z[DE] & A,2^G,2" 
" z[B,D] z[^G,DE] & F,2E,2" "A,[CE] F,[CD]" "[CEG]c cC" "D,[DF] [DF][DF]" "[A,,A,][CE] A,[CE]" "z[^CG] [^CG][^CG] & A,4" "z[CE] [CE][CE] & A,4" " z[B,F] [DF][DF] & G,4" 
"[G,B,F]2[G,CE][G,_B,C]" "F,[A,F] A,[CF]" "[CE]G[CE]2" "z[^G,E] z[CE] & E,2A,2" "GFE2 & C4" "z[CE] z[CF] & G,2F,2" " z[CE] z[CE] & G,2A,2" "FCF,2" 
"[K:C clef=treble] z[DG] z[G_B] & _B,2C2" "[K:C clef=treble] [A,A]2A,2" "[K:C clef=bass] z[CE] [CE][CE] & G,4" "z[CF] z[CF] & F,2A,2" "z[A,F] [A,F][A,F] & F,4" "[CE]D C2 & A,4" "[K:C clef=bass] z[CE] z[CE] & _B,2G,2" "EDC2 & A,4" 
"[G,CE]2[A,CF]2" "D,[DF] [DF][DF]" "[K:C clef=bass] z[CE] z[CE] & _B,2G,2" "C,[CE] [CE][CE]" "[K:C clef=treble] z[DFG] [DFG][DFG] & _B,4" "[A,C][A,E] [A,C]2" "D,[A,F] [A,F][A,F]" "[FA]CF,2" )

#----------------------------------------------------------------------------------
# create cat-to-output-file function
#----------------------------------------------------------------------------------
catToFile(){
	cat >> $filen << EOT
$1
EOT
}

#----------------------------------------------------------------------------------
# create empty ABC file
# set header info: generic index number, filename
# Total MDGs: 2,821,109,907,456	= (6^4*6^4)(6^4*6^4))
# Unique MDGs: 
# meas#/same for tosses: 
#----------------------------------------------------------------------------------
fileInd=$1-$1-$2-$2-$3-$3-$4-$4-$5-$5-$6-$6-$7-$7-$8-$8 
fileInd2=$9-$9-${10}-${10}-${11}-${11}-${12}-${12}-${13}-${13}-${14}-${14}-${15}-${15}-${16}-${16}
filen="ggst-$fileInd-$fileInd2.abc"
dbNum=$(( ${diceS[0]} + (${diceS[1]}-1)*6 + (${diceS[2]}-1)*6**2 + (${diceS[3]}-1)*6**3 + (${diceS[4]}-1)*6**4 + (${diceS[5]}-1)*6**5 + (${diceS[6]}-1)*6**6 + (${diceS[7]}-1)*6**7 + (${diceS[8]}-1)*6**8 + (${diceS[9]}-1)*6**9 + (${diceS[10]}-1)*6**10 + (${diceS[11]}-1)*6**11 + (${diceS[12]}-1)*6**12 + (${diceS[13]}-1)*6**13 + (${diceS[14]}-1)*6**14 + (${diceS[15]}-1)*6**15 ))
#echo ${dbNum}
#echo "${diceS[0]} + (${diceS[1]}-1)*6 + (${diceS[2]}-1)*6**2 + (${diceS[3]}-1)*6**3 + (${diceS[4]}-1)*6**4 + (${diceS[5]}-1)*6**5 + (${diceS[6]}-1)*6**6 + (${diceS[7]}-1)*6**7 + (${diceS[8]}-1)*6**8 + (${diceS[9]}-1)*6**9 + (${diceS[10]}-1)*6**10 + (${diceS[11]}-1)*6**11 + (${diceS[12]}-1)*6**12 + (${diceS[13]}-1)*6**13 + (${diceS[14]}-1)*6**14 + (${diceS[15]}-1)*6**15"

#----------------------------------------------------------------------------------
# calculate the measure numbers for the current dice tosses; 
# from (6**8)(6**8) possibilities; 
#----------------------------------------------------------------------------------
currMeas=0
for measj in ${diceS[*]} ; do
	currMeas=`expr $currMeas + 1`
	if [ "$currMeas" -lt "17" ]; then
		ruletab $measj
		measPerm="$measPerm${measNR[$currMeas-1]}:"
	else
		ruletabT $measj
		measPerm="$measPerm${measNR[$currMeas-17]}:"
	fi
done
measPerm="$measPerm:"

#----------------------------------------------------------------------------------
# if output abc file already exists, then make a back-up copy
#----------------------------------------------------------------------------------
if [ -f $filen ]; then 
	mv $filen $filen."bak"
fi

#----------------------------------------------------------------------------------
# generate the header of the ABC file
#----------------------------------------------------------------------------------
catToFile "%%scale 0.65
%%pagewidth 21.082cm
%%bgcolor white
%%topspace 0
%%composerspace 0
%%leftmargin 0.254cm
%%rightmargin 0.254cm
%%barsperstaff	8 % number of measures per staff
%%equalbars true
X:$dbNum
T:${fileInd}-${fileInd2}
%%setfont-1 Courier-Bold 12
%%setfont-2 Courier-Bold 19
%%musicspace 0cm
T:\$1ggst::$measPerm\$0
T:\$1Perm. No.: $dbNum\$0
M:2/4
L:1/8
Q:1/4=70
%%staves [1 2]
V:1 clef=treble
V:2 clef=bass
K:C"

#----------------------------------------------------------------------------------
# write the notes of the ABC file
#----------------------------------------------------------------------------------
currMeas=0
for measj in ${diceS[*]} ; do
	currMeas=`expr $currMeas + 1`
	if [ "$currMeas" -lt "17" ]; then 
		ruletab $measj
		measN=${measNR[$currMeas-1]}
		phrG=${notesG[$measN-1]}
		phrF=${notesF[$measN-1]}
	else
		ruletabT $measj
		measN=${measNR[$currMeas-17]}
		phrG=${notesG[$measN-1]}
		phrF=${notesF[$measN-1]}
	fi
	if [ "${currMeas}" == "1" ]; then
		catToFile "%1
%%text \$2Dance \$0
%%vskip 0.25cm 
[V:1]|: $phrG |\\
[V:2]|: $phrF |\\"
		continue
	elif [ "$currMeas" == "8" ] || [ "$currMeas" == "24" ]; then
		catToFile "%8, 24 returns
[V:1] $phrG :|
[V:2] $phrF :|"
		if [ "$currMeas" == "24" ]; then prevMeas=$measN; fi
		continue
	elif [ "$currMeas" == "9" ]; then 
		catToFile "%9 with return
[V:1]|: $phrG |\\
[V:2]|: $phrF |\\"
	continue
	elif [ "$currMeas" == "16" ]; then
		catToFile "%16 return, Fine
[V:1] \"_\u2800\\u2800\\u2800\u2800\\u2800Fine\"$phrG :|
[V:2] $phrF :|"
		# create an abc file (filento_dance) for the dance without repeats; 
		# to be played after the trio 
		filento_dance=${filen/.abc/}-to16.abc
		cp $filen  ${filento_dance}
		# remove repeat signs
		sed -i 's/|:/|/g' ${filento_dance}
		sed -i 's/:|/|/g' ${filento_dance}
		continue
	elif [ "$currMeas" == "25" ]; then
		if [ "$prevMeas" == "190" ] || [ "$prevMeas" == "34" ]; then
		catToFile "%25 without [K:C clef=bass]
[V:1]|: $phrG |\\
[V:2]|: ${phrF/\[K:C clef=bass\] /} |\\"
		else
		catToFile "%25 with [K:C clef=bass]
[V:1]|: $phrG |\\
[V:2]|: $phrF |\\"		
		fi
		continue
	elif [ "$currMeas" == "17" ]; then
		catToFile "%17 tempo change 70 -> 80
%%text \$2Trio \$0
%%vskip 0.25cm 
[V:1]|: [Q:1/4=80] $phrG |\\
[V:2]|: [Q:1/4=80] $phrF |\\"
	elif [ "$currMeas" == "32" ]; then
		catToFile "%32
[V:1] \"_D.C. al Fine\\n(no repeats)\"$phrG :|]
[V:2] $phrF :|]"
		continue
	else
		catToFile "%$currMeas 2-7,10-15,18-23,26-31
[V:1] $phrG |\\
[V:2] $phrF |\\"
	fi
done

#----------------------------------------------------------------------------------
# create SVG
#----------------------------------------------------------------------------------
abcm2ps ./$filen -O ./"ggst-$fileInd-$fileInd2.svg" -g 

#----------------------------------------------------------------------------------
# express turn symbol, if needed, then create midi
#----------------------------------------------------------------------------------
# change turns to detailed notes when 99 or 109 is used from table;
# occurs when die toss is 2 for bar 2 or bar 6
filenIn=$filen
if [ "${diceS[1]}" == "2" ] || [ "${diceS[5]}" == "2" ]; then
	if [ "${diceS[1]}" == "2" ]; then
		sed -i.TURN 's/!turn!f3\//g3\/8f3\/8e3\/8f3\/8/g' ./$filenIn
	fi
	if [ "${diceS[5]}" == "2" ]; then
		sed -i.TURN 's/!turn!a3\//b3\/8a3\/8g3\/8a3\/8/g' ./$filenIn
	fi
fi
filen=$filenIn

# create MIDI
## remove final end bar
sed -i 's/:|\]/:|/' $filen 
## change tempo from 80 to 80
catToFile "% change back tempo to 1/4=70 in filen
[V:1][Q:1/4=70]
[V:2][Q:1/4=70]"
## add the dance temp file to to filen
sed -n '24,73p' ${filento_dance} >> $filen 
## abc to midi
abc2midi ./$filen -quiet -silent -o ./"ggst-$fileInd-$fileInd2.mid"
## delete the dance temp file
rm ${filento_dance} 
#
##
###
