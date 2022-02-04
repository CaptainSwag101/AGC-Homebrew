### FILE="Main.annotation"
## Copyright:	Public domain.
## Filename:	AUTOMATIC_MANEUVERS.agc
## Purpose:	Part of the source code for Colossus build 237.  
##		This is for the Command Module's (CM) Apollo Guidance
##		Computer (AGC), for Apollo 8.
## Assembler:	yaYUL
## Contact:	Onno Hommes <ohommes@alumni.cmu.edu>
## Website:	www.ibiblio.org/apollo/index.html
## Page Scans:	www.ibiblio.org/apollo/ScansForConversion/Colossus237/
## Mod history:	2010-06-01 OH	Adapted from corresponding Colossus 249 file.
##		2010-12-04 JL	Remove Colossus 249 header comments. Change to double-has page numbers.
##		2011-02-11 JL	Minor fixes.
##		2017-01-01 RSB	Proofed comment text using octopus/ProoferComments,
##				and fixed errors found.

## Page 993
		BANK	21
		SETLOC	DAPS3
		BANK

		COUNT	21/DAPAM

		EBANK=	KMPAC
AHFNOROT	EXTEND
		READ	CHAN31
		MASK	BIT14
		EXTEND
		BZMF	FREECONT
		CA	RCSFLAGS	# SEE IF RATE FILTER HAS BEEN INITIALIZED
		MASK	BIT14
		CCS	A		# IF SO, PROCEED WITH ATTITUDE CONTROL
		TCF	REINIT		# IF NOT, RECYCLE TO INITIALIZE FILTER
#					  AUTOMATIC CONTROL YET
		EXTEND
		READ	CHAN31
		MASK	BIT13
		EXTEND
		BZMF	HOLDFUNC


AUTOCONT	CA	HOLDFLAG	# IF HOLDFLAG IS +, GO TO GRABANG.
		EXTEND			# OTHERWISE, GO TO ATTHOLD.
		BZMF	ATTHOLD
		TCF	GRABANG

#         MINIMUM IMPULSE CONTROL

FREECONT	CAF	ONE
		TS	HOLDFLAG	# RESET HOLDFLAG
#					  INHIBIT AUTOMATIC STEERING
		EXTEND
		READ	CHAN32
		TS	L
		COM
		MASK	MANROT
		MASK	CHANTEMP
		LXCH	CHANTEMP
		TC	STICKCHK
		INDEX	RMANNDX
		CA	MINTAU		# MINTAU  +0
		TS	TAU		#            +1   +14MS MINIMUM IMPULSE
		INDEX	PMANNDX		#            +2   -14MS TIME
		CA	MINTAU		#            +3   +0
		TS	TAU1
		INDEX	YMANNDX
		CA	MINTAU
## Page 994
		TS	TAU2
		TCF	T6PROGM


MINTAU		DEC	0
		DEC	23		# = 14MS
		DEC	-23		# = -14MS
		DEC	0

## Page 995
#       CALCULATION OF ATTITUDE ERRORS-

#          -    *     -      -          -
#          AK = AMGB (CDUX - THETADX) + BIAS

# IE       *AK *   * 1   SIN(PSI)            0     ** CDUX - THETADX *    *BIAS *
#          *   *   *                               **                *    *     *
#          *AK1* = * 0   COS(PSI)COS(PHI)  SIN(PHI)** CDUY - THETADY *  + *BIAS1*
#          *   *   *                               **                *    *     *
#          *AK2*   * 0  -COS(PSI)SIN(PHI)  COS(PHI)** CDUZ - THETADZ *    *BIAS2*


#       THE BIASES ARE ADDED ONLY WHILE PERFORMING AUTOMATIC MANEUVERS (ESP KALCMANU) TO PROVIDE ADDITIONAL LEAD
# AND PREVENT OVERSHOOT WHEN STARTING AN AUTOMATIC MANEUVER. NORMALLY THE REQUIRED LEAD IS ONLY 1-2 DEGREES.
# BUT DURING HIGH RATE MANEUVERS IT CAN BE AS MUCH AS 7 DEGREES. THE BIASES ARE COMPUTED BY KALCMANU AND REMAIN
# FIXED UNTIL THE MANEUVER IS COMPLETED AT WHICH TIME THEY ARE RESET TO ZERO.

ATTHOLD		CA	CDUX
		EXTEND
		MSU	THETADX
		TS	ERRORX
		CA	CDUY
		EXTEND
		MSU	THETADY
		TS	T5TEMP
		EXTEND
		MP	AMGB1
		ADS	ERRORX
		CA	T5TEMP
		EXTEND
		MP	AMGB4
		TS	ERRORY
		CA	T5TEMP
		EXTEND
		MP	AMGB7
		TS	ERRORZ
		CA	CDUZ
		EXTEND
		MSU	THETADZ
		TS	T5TEMP
		EXTEND
		MP	AMGB5
		ADS	ERRORY
		CA	T5TEMP
		EXTEND
		MP	AMGB8
		ADS	ERRORZ
		CS	HOLDFLAG
		EXTEND
## Page 996
		BZMF	JETS
		CA	BIAS		# AD BIASES ONLY IF PERFORMING AUTOMATIC
		ADS	ERRORX
		CA	BIAS1
		ADS	ERRORY
		CA	BIAS2
		ADS	ERRORZ
		TCF	JETS


HOLDFUNC	CCS	HOLDFLAG
		TCF	+3
		TCF	ATTHOLD
		TCF	+1
GRABANG		CAF	ZERO		# ZERO WBODYS AND BIASES
		TS	WBODY
		TS	WBODY +1
		TS	WBODY1
		TS	WBODY1 +1
		TS	WBODY2
		TS	WBODY2 +1
		TS	BIAS
		TS	BIAS1
		TS	BIAS2

		CA	RCSFLAGS
		MASK	OCT16000
		EXTEND			# IS RATE DAMPING COMPLETED
		BZF	ENDDAMP		# IF SO, GO TO ENDDAMP
		CAF	ZERO		# OTHERWISE, ZERO ERRORS
		TS	ERRORX
		TS	ERRORY
		TS	ERRORZ
		TCF	JETS

ENDDAMP		TS	HOLDFLAG	# SET HOLDFLAG +0
		EXTEND
		DCA	CDUX		# PICK UP CDU ANGLES FOR ATTITUDE HOLD
		DXCH	THETADX		# REFERENCES
		CA	CDUZ
		TS	THETADZ
		TCF	ATTHOLD

## Page 997
# JET SWITCHING LOGIC AND CALCULATION OF REQUIRED ROTATION COMMANDS

# DETERMINE THE LOCATION OF THE RATE ERROR AND THE ATTITUDE ERROR RELATIVE TO THE SWITCHING LOGIC IN THE PHASE
# PLANE.
# COMPUTE THE CHANGE IN RATE CORRESPONDING TO THE ATTITUDE ERROR NECESSARY TO DRIVE THE THE S/C INTO THE
# APPROPRIATE DEADZONE.


#                                     .
#   R22                          RATE . ERROR
#        WL+H                         .
# *********************************   .                                   ***** SWITCH LINES ENCLOSING DEADZONES
#   R23  WL                        *  .
# --------------------------------- * .                                   ----- DESIRED RATE LINES
#   R23  WL-H       -                *.
# ****************** -                .                                   R20, R21, R22, ETC  REGIONS IN PHASE
#                   * -               .* R18      R20       R21           PLANE FOF COMPUTING DESIRED RESPONSE
#                    *                . *
#                     *-              .  *
#   R22             R24*-     R23     .   *
#                       *-            .    *
#                        *            .     *
#                         + -ADB      .      * AF              ATTITUDE
# .........................+--+---------------+--+........................
#                           AF *      .     +ADB  +             ERROR
#                               *     .            *
#                                *    .            -*
#                                 *   .             -*
#                                  *  .              -*
#                                   * .                *
#                                    *.               - *
#                                     .                - *****************
#                                     .*                -
#                                     . * --------------------------------
#                                     .  *
#                                     .   ********************************
#                                     .

#                     FIG. 1   PHASE PLANE SWITCHING LOGIC


#         CONSTANTS FOR JET SWITCHING LOGIC

WLH/SLOP	DEC	.00463		# = WL+H/SLOPE = .83333 DEG       $180
WL-H/SLP	DEC	.00277		# = WL-H/SLOPE = .5 DEG           $180
WLH		2DEC	.0011111111	# = WL+H = 0.5 DEG/SEC            $450
WLMH		2DEC	.0006666666	# = WL-H = 0.3 DEG/SEC            $450
WL		2DEC	.0008888888	# = WL   = 0.4 DEG/SEC            $450

## Page 998
SLOPE2		DEC	.32		# = 0.8 DEG/SEC/DEG               $450/180
JETS		CA	ADB
		AD	FOUR		# AF = FLAT REGION = .044 DEG
		TS	T5TEMP		# ADB+AF
		CAF	TWO
JLOOP		TS	SPNDX
		DOUBLE
		TS	DPNDX
		EXTEND
		INDEX	A
		DCA	ADOT
		DXCH	EDOT
		CA	HOLDFLAG	# HOLDFLAG = +0 MEANS THAT DAP IS IN
		EXTEND			# ATTITUDE HOLD AND RATE DAMPING IS OVER.
		BZF	INHOLD		# IF THIS IS THE CASE, BYPASS ADDITION
#					  OF WBODY AND GO TO INHOLD
		EXTEND
		INDEX	DPNDX
		DCS	WBODY
		DAS	EDOT		# = ADOT-WBODY
INHOLD		INDEX	SPNDX
		CA	ERRORX
		TS	AERR		# AERR = BIAS + AK

		CCS	EDOT
		TCF	POSVEL
		TCF	SIGNCK1
		TCF	NEGVEL
SIGNCK1		CCS	EDOT +1
		TCF	POSVEL
		TCF	POSVEL
		TCF	NEGVEL
		TCF	NEGVEL
POSVEL		EXTEND
		DCA	EDOT
		DXCH	EDOTVEL
		CA	T5TEMP
		TS	ADBVEL		# +(ADB+AF)
		CA	AERR
		TS	AERRVEL
		TC	J6.
NEGVEL		EXTEND
		DCS	EDOT
		DXCH	EDOTVEL
		CS	T5TEMP
		TS	ADBVEL		# -(ADB+AF)
		CS	AERR
		TS	AERRVEL

J6.		EXTEND
## Page 999
		SU	ADB
		AD	WLH/SLOP
		EXTEND
		BZMF	J8

		CS	T5TEMP		# (ADB+AF)
		AD	AERRVEL
		EXTEND
		BZMF	+2
		TCF	J7
		EXTEND
		DCS	EDOTVEL
		EXTEND
		DV	SLOPE
		EXTEND
		SU	AERRVEL
		AD	ADB
		EXTEND
		BZMF	J18
		TCF	J23

J7		CS	WL-H/SLP
		EXTEND
		SU	T5TEMP		# (ADB+AF)
		AD	AERRVEL
		EXTEND
		BZMF	J20
		TCF	J21

J8		EXTEND
		DCS	WLH
		DXCH	WTEMP
		EXTEND
		DCA	EDOTVEL
		DAS	WTEMP
		CCS	WTEMP
		TCF	J22
		TCF	SIGNCK2
		TCF	NJ22
SIGNCK2		CCS	WTEMP +1
		TCF	J22
		TCF	J22
		TCF	NJ22

NJ22		EXTEND
		DCA	EDOTVEL
		EXTEND
		DV	SLOPE
		AD	T5TEMP		# (ADB+AF)
		AD	AERRVEL
## Page 1000
		CCS	A
		TCF	J23
		TCF	J23
		TCF	+2
		TCF	J23

		EXTEND
		DCS	WLMH		# WL - H
		DXCH	WTEMP
		EXTEND
		DCA	EDOTVEL
		DAS	WTEMP
		CCS	WTEMP
		TCF	J23
		TCF	SIGNCK3
		TCF	NJ23
SIGNCK3		CCS	WTEMP +1
		TCF	J23
		TCF	J23
		TCF	NJ23

NJ23		CA	AERRVEL
		AD	T5TEMP		# (ADB+AF)
		AD	WL-H/SLP
		CCS	A
		TCF	J24
		TCF	J24
		TCF	J22
		TCF	J22

J18		EXTEND
		DCS	EDOT
		DXCH	KMPAC
		TCF	JTIME

J20		CS	AERR
		AD	ADBVEL
		EXTEND
		MP	SLOPE2		#  (HYSTERESIS SLOPE)
		DXCH	KMPAC
		EXTEND
		DCS	EDOT
		DAS	KMPAC
		TCF	JTIME

J21		CCS	EDOT
		TCF	JP
		TCF	SIGNCK4
		TCF	JN
SIGNCK4		CCS	EDOT +1
## Page 1001
		TCF	JP
		TCF	JP
		TCF	JN
JN		EXTEND
		DCS	EDOT
		DXCH	KMPAC
		EXTEND
		DCA	WL
		DAS	KMPAC
		TCF	JTIME

JP		EXTEND
		DCS	EDOT
		DXCH	KMPAC
		EXTEND
		DCS	WL
		DAS	KMPAC
		TCF	JTIME

J22		CCS	EDOT
		TCF	JN
		TCF	SIGNCK5
		TCF	JP
SIGNCK5		CCS	EDOT +1
		TCF	JN
		TCF	JN
		TCF	JP
		TCF	JP

J23		INDEX	SPNDX
		CS	BIT13		# RESET RATE DAMPING FLAG
		MASK	RCSFLAGS	# BIT13 FOR ROLL  (SPNDX = 0)
		TS	RCSFLAGS	# BIT12 FOR PITCH (SPNDX = 1)
#					  BIT11 FOR YAW   (SPNDX = 2)

		INDEX	SPNDX
		CAF	OCT01400	# IS THERE TO BE A FORCED FIRING ON THIS
		MASK	RCSFLAGS	# AXIS
		EXTEND
		BZF	DOJET +2	# NO, GO TO DOJET +2 AND DO NOTHING

		TCF	J18		# YES, GO TO J18 AND FORCE A FIRING

J24		CS	AERR
		EXTEND
		SU	ADBVEL
		EXTEND
		MP	SLOPE2		#  (HYSTERESIS SLOPE)
		DXCH	KMPAC
		EXTEND
## Page 1002
		DCS	EDOT
		DAS	KMPAC

## Page 1003
#      COMPUTE THE JET ON TIME NECESSARY TO ACCOMPLISH THE DESIRED CHANGE IN RATE, IE

#          T  = J/M(DELTA W)
#           J

#    DELTA W = DESIRED CHANGE IN S/C ANGULAR RATE AS DETERMINED BY THE
#              SWITCHING LOGIC,  AT THIS POINT STORED IN KMPAC.

#        J/M = S/C INERTIA TO TORQUE 9ATIO  SCALED BY
#                (57.3/450)(B24/1600)(1/.8)
#              FOR 1 JET OPERATION  (M = 700 FT-LB).
#              IE  J/M = J(SLUG-FTFT) X 0.00000085601606

#              THE CORRESPONDING COMPUTER VARIABLES ESTABLISHED BY
#              KEYBOARD ENTRY ARE
#                 J/M (ROLL)
#                 J/M1 (PITCH)
#                 J/M2 (YAW)

#         T  = JET ON-TIME     SCALED 16384/1600 SEC
#          J

#              THE COMPUTER VARIABLES ARE
#                 TAU  (ROLL)
#                 TAU1 (PITCH)
#                 TAU2 (YAW)


JTIME		INDEX	SPNDX		# PICK UP S/C INERTIA/TORQUE RATIO
		CA	J/M		# SCALED (57.3/450)(B24/1600)
		TC	SMALLMP		# FOR 1-JET OPERATION
		CA	BIT11
		TC	SMALLMP
		CCS	KMPAC
		TCF	+4
		TCF	TAUNORM
		TCF	+4
		TCF	TAUNORM
		CA	POSMAX
		TCF	DOJET
		CA	NEGMAX
		TCF	DOJET

TAUNORM		CA	KMPAC +1
DOJET		INDEX	SPNDX
		TS	TAU
		CCS	SPNDX
		TCF	JLOOP
		TCF	T6PROG

## Page 1004
ZEROCMDS	CAF	ZERO
		TS	TAU
		TS	TAU1
		TS	TAU2
T6PROG		EXTEND			# WHEN THE ROTATION COMMANDS (TAUS)
		DCA	JETADDR		# HAVE BEEN DETERMINED
		DXCH	T5LOC		# RESET T5LOC FOR PHASE3
		TCF	RESUME

		EBANK=	KMPAC
JETADDR		2CADR	JETSLECT
