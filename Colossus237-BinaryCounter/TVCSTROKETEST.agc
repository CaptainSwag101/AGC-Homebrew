### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:	TVCSTROKETEST.agc
## Purpose:     Part of the source code for Colossus build 237.
##              This is for the Command Module's (CM) Apollo Guidance
##              Computer (AGC), for Apollo 8.
## Assembler:   yaYUL
## Contact:     Jim Lawton <jim DOT lawton AT gmail DOT com>
## Website:     www.ibiblio.org/apollo/index.html
## Page Scans:  www.ibiblio.org/apollo/ScansForConversion/Colossus237/
## Mod history: 2011-03-12 JL	Adapted from corresponding Colossus 249 file.
##		2017-01-01 RSB	Proofed comment text using octopus/ProoferComments,
##				and fixed errors found.

## Page 940
# NAME     STROKE TEST PACKAGE   (INCLUDING INITIALIZATION PACKAGE)
# ORIGINAL CODING BY OLSSON       LOG SECTION....STROKE TEST PACKAGE
# MOD BY ENGEL                    DATE....21 MARCH, 1967

# FUNCTIONAL DESCRIPTION....
#      STROKE TEST PACKAGE GENERATES A WAVEFORM DESIGNED TO EXCITE BENDING
#      STRKTSTI (STROKE TEST INITIALIZATION) IS CALLED AS A JOB BY VB68.
#               IT INITIALIZES ALL ERASABLES REQD FOR A STROKE TEST, AND
#      	        THEN TESTS FOR AN 80MS DAP. IF 80MS IT SETS STROKER = ESTROKER
#      	        FOR AN IMMEDIATE STROKE TEST, OTHERWISE IT MERELY ENABLES
#      	        A STROKE TEST BY SETTING STROKER TO -0. THE STROKE TEST
#      	        THEN AWAITS SWITCHOVER TO THE 80MS DAP WHEREUPON IT IS
#      	        ENABLED AFTER AN ADDITIONAL 4 SECOND DELAY TO AVOID
#      	        THE SWITCHOVER TRANSIENTS (SEE STRKCALL, STRKUP IN
#      	        TVCEXECUTIVE)
#      HACK (STROKE TEST) GENERATES THE WAVEFORM BY DUMPING PULSE BURSTS
#      	        OF PROPER SIGN AND IN PROPER SEQUENCE DIRECTLY INTO
#      	        TVCPITCH, WORKING IN CONJUNCITON WITH BOTH PITCH AND YAW
#      	        TVC DAPS, WITH INTERMEDIATE WAITLIST CALLS. NOTE, HOWEVER
#      	        THAT THE STROKE TEST IS PERFORMED ONLY IN THE PITCH AXIS.
#      	        AN EXAMPLE WAVEFORM IS GIVEN BELOW, TO DEMONSTRATE STROKE-
#      	        TEST PARAMETER SELECTION
#      RESTARTS CAUSE TEST TO BE TERMINATED. ANOTHER V68 REQD IF TEST
#      	        IS TO BE RE-RUN.
#      PULSE BURST SIZE IS PAD-LOADED (ESTROKER) SO THAT AMPLITUDE OF
#      	        WAVEFORM CAN BE CHANGED.  THERE ARE TEN PULSE BURSTS IN
#      	        THE HALF-AMPLITUDE OF THE FIRST FREQUENCY SET IN THE
#      	        STANDARD WAVEFORM.  AMPLITUDE IS 10(ESTROKER)(1/42.15),
#      	        NOMINALLY 50/42.15  =  1.185 DEG
# CALLING SEQUENCE....
#      EXTENDED VERB 68 SETS UP STRKTSTI JOB
#      PITCH AND YAW TVCDAPS, FINDING STROKER NON-ZERO, DO A  ..TC HACK..
#      AN INTERNALLY-GENERATED WAITLIST CALL ENTERS AT  ..HACKWLST..
# NORMAL EXIT MODES....
#      TC BUNKER  (..Q.. IF ENTRY FROM DAP, ..TCTSKOVR.. IF FROM WAITLIST)LIST
# SUBROUTINES CALLED....
#      WAITLIST
# ALARM OR ABORT EXIT MODES....
#      NONE
# ERASABLE INITIALIZATION REQUIRED....
#      ESTROKER (PAD-LOAD)
#      STROKER,  CADDY,  REVS,  CARD,  N
# OUTPUT....
#      STRKTSTI...INITIALIZATION FOR STROKE TEST
#      HACK, HACKWLST...PULSE BURSTS INTO TVCPITCH VIA..ADS..
#                       RESETS STROKER = +0 WHEN TEST COMPLETED
# DEBRIS....
#	N = CADDY = +0, CARD = -0, REVS = -1
#	BUNKER
#
## Page 941
# EXAMPLE STROKE TEST WAVE FORM, DEMONSTRATING PARAMETER SELECTION


# NOTE....THIS IS NOT THE OFFICIAL WAVEFORM....


#            **              **
#            **              **
#            **              **           EXAMPLE WAVEFORM (EACH * REPRESENTS
#           *  *            *  *               85.41 ARCSEC OF ACTUATOR CMND)
#           *  *            *  *
#           *  *            *  *
#          *    *          *    *          **      **      **      **      **
#          *    *          *    *          **      **      **      **      **
#          *    *          *    *          **      **      **      **      **
#         *      *        *      *        *  *    *  *    *  *    *  *    *  *    **  **  **  **  **
#         *      *        *      *        *  *    *  *    *  *    *  *    *  *    **  **  **  **  **
#         *      *        *      *        *  *    *  *    *  *    *  *    *  *    **  **  **  **  **
#     -----------------------------------------------------------------------------------------------------
#                 *      *        *      *    *  *    *  *    *  *    *  *    *  *  **  **  **  **  **
#                 *      *        *      *    *  *    *  *    *  *    *  *    *  *  **  **  **  **  **
#                 *      *        *      *    *  *    *  *    *  *    *  *    *  *  **  **  **  **  **
#                  *    *          *    *      **      **      **      **      **
#                  *    *          *    *      **      **      **      **      **
#                  *    *          *    *      **      **      **      **      **
#                   *  *            *  *
#                   *  *            *  *
#                   *  *            *  *
#                    **              **
#                    **              **
#                    **              **


# FOR THIS (UNOFFICIAL, EXAMPLE) WAVEFORM, THE REQUIRED PARAMETERS ARE AS FOLLOWS....

#      FCARD    = +3    (NUMBER OF SETS)
#      ESTROKER = +3    (PULSE BURST SIZE, SC.AT 85.41 ARCSEC/BIT)

#      SET1..
#      	   FREVS  = +3  (NUMBER REVERSALS MINUS 1)
#      	   FCADDY = +4  (NUMBER OF PULSE BURSTS IN 1/2 AMPLITUDE)
#      SET2..
#      	   FCARD1 = +9  (NUMBER REVERSALS MINUS 1)
#      	   FCARD4 = +2  (NUMBER OF PULSE BURSTS IN 1/2 AMPLITUDE)
#      SET3..
#      	   FCARD2 = +9  (NUMBER REVERSALS MINUS 1)
#      	   FCARD5 = +1  (NUMBER OF PULSE BURSTS IN 1/2 AMPLITUDE)
#      SET4..
#      	   FCARD3 = +0  (NUMBER REVERSALS MINUS 1)
#      	   FCARD6 = +0  (NUMBER OF PULSE BURSTS IN 1/2 AMPLITUDE)

## Page 942
# STROKE TEST INITIALIZATION PACKAGE  (AS A JOB, FROM VERB 68)

		BANK	17
		SETLOC	DAPS2
		BANK

		COUNT*	$$/STRK
		EBANK=	CADDY

STRKTSTI	TCR	TSTINIT		# STROKE TEST INITIALIZATION PKG  (CALLED
#					       AS A JOB BY VERB68)

TVCDTCHK	INHINT			# STROKE TEST PERMITTED ONLY WITH 80MS DAP
		CAE	T5TVCDT		#      CHECK CURRENT TIMING
		TS	L
		CAF	OCT37774	#      LOOK FOR 80MS (T5)
		EXTEND
		RXOR	LCHAN		# +0 IF 80MS
		CCS	A
		TCF	+4		#      NOT 80MS

		CAE	ESTROKER	#      80MS. OK, SET STROKER FOR TEST
		TS	STROKER
		TCF	+3

		CS	ZERO		#      ENABLE, BUT DO NOT ACTIVATE STROKE
		TS	STROKER		#           TEST, AWAITING SWITCHOVER
#					            TO MOD0R (MOD80)
		TCF	ENDOFJOB


TSTINIT		CS	FCADDY		# NORMAL ENTRY FROM STRKTSTI
		TS	CADDY
		TS	N		#      NOTE SGN CHNG FCADDY(+) TO CADDY(-)

		CAF	FREVS
		TS	REVS

		CS	FCARD		#      NOTE SGN CHNG FCARD(+) TO CARD(-)
		TS	CARD

		TC	Q		# RETURN TO STRKTSTI+1  (OR CHKSTRK+2OR+4)

## Page 943
# THE OFFICIAL STROKE TEST WAVEFORM (3 JAN, 1967) CONSISTS OF FOUR STROKE SETS, AS FOLLOWS....

#      SET 1...10 BURSTS IN 1/2 AMP,   4 REVERSALS
#      SET 2... 6 BURSTS IN 1/2 AMP,   6 REVERSALS
#      SET 3... 5 BURSTS IN 1/2 AMP,  10 REVERSALS
#      SET 4... 4 BURSTS IN 1/2 AMP,  14 REVERSALS
# THE PULSE BURST SIZE (ESTROKER) IS PAD-LOADED (5 BITS AS OF 3JAN,1967)
# THE REMAINING WAVEFORM-GENERATING PARAMETERS ARE AS FOLLOWS....

FCADDY		DEC	10		# NO. PULSE BURSTS IN 1/2 AMP, SET1..(+10)
FREVS		DEC	3		# NO. REVERSALS MINUS 1, SET1........(  3)

FCARD		DEC	4		# NO. STROKE SETS....................(+ 4)

FCARD1		DEC	5		# NO. REVERSALS MINUS 1, SET2........(  5)

FCARD2		DEC	9		# 			    3........(  9)
FCARD3		DEC	13		#                           4........( 13)

FCARD4		DEC	6		# NO. PULSE BURSTS IN 1/2 AMP, SET2..(+ 6)
FCARD5		DEC	5		#                              SET3..(+ 5)
FCARD6		DEC	4		#                              SET4..(+ 4)

20MS		=	BIT2


# STROKE TEST PACKAGE PROPER....

		EBANK=	BUNKER

HACK		EXTEND			# ENTRY (IN T5 RUPT) FROM TVCDAPS
		QXCH	BUNKER		# SAVE Q FOR DAP RETURN

		CAF	20MS		# 2DAPSX2(PASSES/DAP)X2(CS/PASS)=8CS=TVCDT
		TC	WAITLIST
		EBANK=	BUNKER
		2CADR	HACKWLST
		TCF	+3

HACKWLST	CAF	TCTSKOVR	# ENTRY FROM WAITLIST
		TS	BUNKER		# BUNKER IS TC TASKOVER

		CA	STROKER		# STROKE
		ADS	TVCPITCH

		CAF	BIT11		# RELEASE THE ERROR COUNTERS
		EXTEND
		WOR	CHAN14
		INCR	CADDY		# COUNT DOWN THE NO. BURSTS, THIS SLOPE
## Page 944
		CS	CADDY
		EXTEND
		BZMF	+2
		TC	BUNKER		# EXIT, WHILE ON A SLOPE


		CCS	REVS
		TCF	REVUP		# POSITIVE REVS
		TCF	REVUP +4	# FINAL REVERSAL, THIS SET

		INCR	CARD		# NEGATIVE REVS SET LAST PASS, READY FOR
		CS	CARD		#      THE NEXT SET. CHECK IF NO MORE SETS
		EXTEND
		BZF	STROKILL	# ALL SETS COMPLETED

		INDEX	CARD
		CAF	FCARD +4	# PICK UP NO. REVERSALS (-), NEXT SET
		TS	REVS		# REINITIALIZE
		INDEX	CARD
		CS	FCARD +7	# PICK UP NO. BURSTS IN 1/2AMP, NEXT SET
		TS	N		# REINITIALIZE
		TS	CADDY
		TC	BUNKER		# EXIT, AT END OF SET


STROKILL	TS	STROKER		# RESET (TO +0) TO END TEST
		TC	BUNKER		# EXIT, STROKE TEST FINIS


REVUP		TS	REVS		# ALL REVERSALS EXCEPT LAST OF SET
		CA	N
		DOUBLE			# 2 X 1/2AMP
		TCF	+4

  +4		CS	ONE		# FINAL REVERSAL, THIS SET
		TS	REVS		# PREPARE TO BRANCH TO NEW BURST
		CA	N		# JUST RETURN TO ZERO, FINAL SLOPE OF SET
		TS	CADDY		# CADUP

		CS	STROKER		# CHANGE SIGN OF SLOPE
		TS	STROKER
		TC	BUNKER		# EXIT AT A REVERSAL (SLOPE CHANGE)
