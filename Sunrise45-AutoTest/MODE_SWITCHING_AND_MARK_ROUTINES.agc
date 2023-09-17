### FILE="Main.annotation"
## Copyright:	Public domain.
## Filename:	MODE_SWITCHING_AND_MARK_ROUTINES.agc
## Purpose:	A section of Sunrise 45.
##		It is part of the reconstructed source code for the penultimate
##		release of the Block I Command Module system test software. No
##		original listings of this program are available; instead, this
##		file was created via disassembly of dumps of Sunrise core rope
##		memory modules and comparison with the later Block I program
##		Solarium 55.
## Assembler:	yaYUL --block1
## Contact:	Ron Burkey <info@sandroid.org>.
## Website:	www.ibiblio.org/apollo/index.html
## Mod history:	2022-12-09 MAS	Initial reconstructed source.


#	THE FOLLOWING SET OF PROGRAMS ARE USED TO SELECTTHE VARIOUS MODES OF THE IMU AND OPTICS. THE FOLLOWING 
# MODES ARE POSSIBLE:
#
#	IMUZERO     ZEROS IMU CDUS.
#	IMUCOARS    COARSE ALIGNS IMU.
#	IMURECOR    RETURNS IMU FROM FINE ALIGN TO COARSE ALIGN
#	IMUFINE     PREPARES TO PULSE TORQUE THE GYROS.
#	IMUATTC     USE IMU FOR S/C ATTITUDE CONTROL.
#	IMUREENT    USE IMU FOR ROLL RE-ENTRY.
#	IMULOCK     LOCKS IMU CDUS.
#
#	IMUSTALL(*) IMU MODE IDLING AND ERROR CHECKING.



#	OPTZERO     ZERO OPTICS CDUS.
#	OPTCOARS    DUMMY OPTICS COARSE-ALIGN MODE.
#	OPTTRKON    OPTICS TRACKER ON.
#
#	SCTMARK     REQUEST N SCANNING TELESCOPE MARKS.
#	SXTMARK     REQUEST N SEXTANT MARKS.
#	MKRELEAS(**)RELEASE MARK SYSTEM.
#
#	OPTSTALL(*) OPTICS MODE-IDLING AND ERROR CHECKING.



#	OPTICS AND IMU MODE ROUTINES MAY BE USED CONCURRENTLY.
#
#	IN ADDITION, A ROUTINE WHICH INCREMENTS ANY DESIRED 2S COMPLEMENT ANGLE BY AN INPUT AMOUNT IS
# INCLUDED (CDUINC).



#	CALLING SEQUENCE IS AS FOLLOWS:
#
# L-1	CAF	NO.MARKS	(FOR SCTMARK AND SXTMARK ONLY).
# L	TC	BANKCALL
# L+1	CADR	(SUBRO)		ANY OF THE 14 MODE ROUTINES OR CDUINC.



#	(*)	THE STALL ROUTINES ARE CALLED TO TERMINATE ANY MODE REQUEST. THE REQUESTING JOB IS STALLED UNTIL
# THE MODE-SWITCHING IS COMPLETE (WITH VAC-AREA PROTECTED) AND RETURN IS TO L+2 IF UNSUCCESSFUL AND L+3 IF THE
# DESIRED MODE WAS SUCCESSFULLY ACHIEVED.
#
#	(**)	NO STALL ROUTINE NECESSARY IN CONJUNCTION WITH THIS REQUEST.

		BANK	1

KEYRUPT		CAF	MODEBANK
		XCH	BANKREG
		TC	KEYRUPTB

MODEBANK	CADR	KEYRUPTA

#	SPECIAL DP TIME COUNTER READING ROUTINE.

READTIME	INHINT			# ENTRY IF UNDER EXECUTIVE.
		CS	TIME2		# ENTRY IF IN INTERRUPT.
		TS	RUPTSTOR
		CS	TIME1
		TS	RUPTSTOR +1
		CCS	A		# IF MINOR PART ZERO, MAJOR PART COULD
		TC	Q
		CCS	A
		TC	Q
		CS	TIME2		# UP, SO READ IT AGIN.
		TS	RUPTSTOR
		TC	Q

READIN0		CAF	OCT40037
		MASK	IN0WORD
		AD	IN0
		TS	IN0WORD
		TC	Q
		TC	Q

OCT40037	OCT	40037
		
#	IMU ZEROING ROUTINE.

		BANK	10
		
IMUZERO		CCS	CDUIND
		TC	MODABORT
		TC	MODABORT
		TC	MODABORT
		CS	ONE		# DISABLE CDU DRIVE
		TS	CDUIND		#  BY SETTING CDUIND NEGATIVE.
		
		TC	SETKANDC	# GO TO SUBROUTINE TO SWITCH C RELAYS
		OCT	00051		#  = C(DESKSET)=COMP CONT+ZERO+FINE
		OCT	40011		#  = C SETTING FOR FINE + ZERO
		TC	ZLITON		# TURN ON ENCODER ZEROING LAMP
		
		CAF	40SECS		# SET A WAITLIST CALL FOR 40 SECONDS
		TC	WAITLIST	#  SO  THOSE SHAFTS WILL HAVE TIME TO GET
		CADR	IMUZEROD	# THERE.
MODEEXIT	RELINT			# GENERAL EXIT FROM MODE SWITCH PROGS
		TC	SWRETURN	#  WHICH LEAVES VIA SWCALL EXIT

MODABORT	TC	ALARM
		OCT	00301
		TC	ENDOFJOB
		
IMUZEROD	TC	ZEROICTR	# GO AND ZERO X, Y, AND Z COUNTERS

		TC	KCHECK		# SEE IF SYSTEM STILL FUNCTIONING OK.
		TC	MOREZERO

CKCDUFAL	MASK	BIT10
		CCS	A
		TC	GOODEND
		CS	CDUFBITS
		MASK	DSPTAB +11D
		AD	CDUFBITS
		TS	DSPTAB +11D
		TC	FAILEND

CDUFBITS	OCT	40040
30SECS		DEC	30. E2

# IMU COARSE ALIGN PROGRAM

IMUCOARS	TC	SETKANDC	# SET DESIRED C AND K RELAY SETTINGS.
		OCT	00042		#   COMPUTER CONTROL . COARSE ALIGN.
		OCT	40002		#   C RELAY COARSE ALIGN.
		
		TC	SETZLIT		# SERVICE THE ZERO ENCODER LAMP
		
		CAF	200MS		# SET WAITLIST CALL FOR 200 M.S. TO
		TC	WAITLIST	#  ACCOMMODATE CONTACT BOUNCE + T4RUPT LAG
		CADR	BEGINCOM
		TC	MODEEXIT
		
		
		
RECOARSD	CS	CDUX		# GOING BACK INTO COARSE ALIGN FROM FINE
		COM			# ALIGN. PUT CDU COUNTER VALUES INTO
		TS	THETAD		# DESIRED ANGLE REGISTERS AND ENABLE THE
		CS	CDUY		# T4RUPT CDU DRIVE.
		COM
		TS	THETAD +1
		CS	CDUZ
		COM
		TS	THETAD +2
		
BEGINCOM	CCS	WASKSET		# VERIFY CORRECTNESS OF PRESENT MODE.
		TC	STARTCRS
		TC	ENDIMU
		TC	STARTCRS
		TC	ENDIMU

STARTCRS	CAF	ZERO		# ENABLE CDU LOOP CLOSURE
		TS	CDUIND
		
		CAF	60SECS
		TC	WAITLIST	#  CDU LOOPS TO SETTLE
		CADR	COARSDON
		TC	TASKOVER

COARSDON	TC	ENDIMU
		CS	OLDERR
		MASK	BIT10
		CCS	A
		TC	GOODEND
		TC	FAILEND

200MS		DEC	0.2 E2
		

# IMU FINE ALIGN PROGRAM

IMURECOR	TC	SETKANDC	# GO INTO COARSE ALIGN FROM FINE ALIGN.
		OCT	00042		# (SEE REMARKS ON RECOARSD FOR FURTHER
		OCT	40002		#   DETAILS).
		CAF	200MS		# USUAL CONTACT CLOSURE AND SAMPLE TIME
		TC	WAITLIST
		CADR	RECOARSD
		TC	DISEXIT		# DISABLE GYRO ACTIVITY.
		
IMUFINE		TC	SETKANDC	# SET UP C RELAY PATTERN AND DESIRED K
		OCT	00050		#  DES K = COMPUTER CONTROL + FINE
		OCT	40010		#      C = FINE ALIGN
		
		CAF	90SECS		# SET WAITLIST CALL FOR 90 SEC. TO ALLOW
		TC	WAITLIST	#  GYROS TO RE-CENTER BEFORE IRIG PULSE
		CADR	IMUFINED	#  TORQUING
DISEXIT		CS	ONE		# DISABLE T4 IMU (CDU OR GYRO) ACTIVITY.
		TS	CDUIND
		TC	MODEEXIT

IMUFINED	TC	ENDIMU
		
		CAF	B12+10		# NO IMU FAILS, PLEASE.
		MASK	OLDERR
		CCS	A
		TC	FAILEND
		TC	GOODEND

90SECS		DEC	90. E2
B12+10		OCT	05000
		

# CDU LOCK PROGRAM

IMULOCK		TC	SETKANDC	# SET APPROPRIATE K AND C CONFIGS.
		OCT	00044
		OCT	40004
		
		CAF	200MS
		TC	WAITLIST	#  PLACE.
		CADR	IMULOCKD
		TC	DISEXIT
		
IMULOCKD	TC	ENDIMU
		TC	GOODEND
		

# IMU RE-ENTRY AND ATTITUDE CONTROL PROGRAMS

IMUREENT	TC	SETKANDC
		OCT	00140
		OCT	42000
		TC	ENABEXIT



IMUATTC		TC	SETKANDC
		OCT	00060
		OCT	41000
		
ENABEXIT	CAF	200MS
		TC	WAITLIST
		CADR	ENABLE
		TC	DISEXIT		# DISABLE POSSIBLE GYRO ACTIVITY.
		
ENABLE		TC	ENDIMU
		
		CAF	ZERO		# ENABLE CDU LOOPS
		TS	CDUIND
		TC	GOODEND
					# NOTICE THAT NO INSPECTION OF CDU AND IMU
					# ERROR SIGNALS IS MADE SINCE IN THESE
					# MODES THE MAIN PROGRAM MUST CHECK THE
					# STATUS OF THESE SIGNALS PERIODICALLY.


#	SETZLIT SETS THE ZERO ENCODER LAMP ACCORDING TO THE DESIRED-MODE REGISTERS DESKSET AND DESOPSET.

SETZLIT		XCH	Q
		TS	ITEMP1
		
		CCS	DESKSET
		TC	+4		# COMPUTER COMMANDING-MAY BE ZEROING.
		TC	OPTZTEST	# NOT MANUAL ZERO.
TURNONZ		TC	ZLITON		# MANUAL ZEROING MODE.
		TC	ITEMP1
		
 +4		AD	ONE
		MASK	BIT1
		CCS	A
		TC	TURNONZ		# COMPUTER COMMANDING ZERO-ENCODER
		
OPTZTEST	CCS	DESOPSET
		TC	+3		# MAY BE COMMANDING OPTICS ZERO.
		TC	ZLITOFF		# NOT MANUAL ZERO-TURN LIGHT OFF.
		TC	TURNONZ		# MANUAL OPTICS
		
 +3		AD	ONE
		MASK	BIT12
		CCS	A
		TC	TURNONZ
		
ZLITOFF		CS	ZLITBITS	# TURN OFF ZERO ENCODER LAMP.
		MASK	DSPTAB +11D
		AD	BIT15
		TS	DSPTAB +11D
		TC	ITEMP1
		
ZLITON		CS	ZLITBITS	# TURN ON ZERO-ENCODER LAMP.
		MASK	DSPTAB +11D
		AD	ZLITBITS
		TS	DSPTAB +11D
		TC	Q
		
ZLITBITS	EQUALS	OCT40020	# CS CYR IN DMP.


#	SUBROUTINE USED BY MODE-SWITCHING PROGRAMS TO SET DESIRED K- AND C-RELAY SETTINGS.

SETKANDC	INHINT			# INHINT AND EXIT WITH INTERRUPT INHIBITED
		INDEX	Q
		CAF	0
		TS	DESKSET		# DESIRED K-RELAY SETTING AS READ IN IN3.
		
		CAF	OFFMASK		# SET C-RELAYS FOR ZERO ENCODER, COARSE
		MASK	DSPTAB +11D	#   ALIGN, FINE ALIGN, LOCK CDU, ROLL
		INDEX	Q		#   RE-ENTRY, AND ATTITUDE CONTROL LAMP.
		AD	1
		TS	DSPTAB +11D
		
		INDEX	Q
		TC	2		# RETURN TO CALLER IN INHINT.


#	SUBROUTINE TO ZERO IMU CDU COUNTERS.

ZEROICTR	CAF	ZERO		# USED BY AUTOMATIC AND MANUAL ZEROING
		TS	CDUX		#  ROUTINES.
		TS	CDUY
		TS	CDUZ
		TC	Q
		

#	WHEN A MODE-SWITCHING TASK IS DISPATCHED TO INDICATE THE END OF A MODE-SWITCH, ENDIMU (OR ENDOPT) IS
# CALLED TO WAKE UP ANY JOB IMUSTALL (OPTSTALL) MIGHT HAVE PUT TO SLEEP AND THEN CHECK WASKSET (WASOPSET) TO SEE
# THAT THE MODE-SWITCH WAS SUCCESSFUL.

ENDOPT		CAF	TWO
		AD	POSMAX
		TS	OVCTR		# SKIP WITH C(A) = 1.
		
ENDIMU		CAF	ZERO
		TS	RUPTREG2	# 0 FOR IMU, 1 FOR OPTICS.
		
		XCH	Q
		TS	RUPTREG1
		
		INDEX	RUPTREG2
		CCS	MODECADR	# SEE IF IMUSTALL (OPTSTALL) PUT A JOB
		TC	+2		# TO SLEEP.
		TC	ENDMODE		# +0 IF NOT.
		CAF	ONE		# SET PROPER MODECADR TO 1 TO INDICATE
		INDEX	RUPTREG2	# A JOB WAS AWAKENED.
		XCH	MODECADR
		TC	JOBWAKE
		
ENDMODE		INDEX	RUPTREG2	# CHECK PROPER *WAS* REGISTER TO SEE IF
		CCS	WASKSET		#  SWITCH WAS SUCCESSFUL.
		TC	RUPTREG1	# YES - RETURN FOR MORE CHECKING IF OK.
		TC	+2		# FAILED - STILL WAITING TO SWITCH.
		TC	RUPTREG1	# MANUAL INHIBIT.
		
FAILEND		INDEX	RUPTREG2	# COMES HERE TO SIGNAL ERROR RETURN FROM
		CCS	MODECADR	#  MODE STALL ROUTINES.
		TC	+2		# JOB WAS WAKENED EARLIER - EXIT W/O INCR.
		COM			# NO WAKE-UP - SET MODECADR TO -0 FOR FAIL
LVENDMOD	INDEX	RUPTREG2
		TS	MODECADR
		TC	TASKOVER
		
GOODEND		INDEX	RUPTREG2	# COMES HERE TO SIGNAL A SUCCESSFUL SWITCH
		CCS	MODECADR
		TC	BUMPJOB		# JOB WAS AWAKENED - INCREMENT LOC.
		CS	ONE		# NO WAKE - SET MODECADR TO -1 TO INDICATE
		TC	LVENDMOD	#  SUCCESS.
		
BUMPJOB		INDEX	LOCCTR		# ARRIVES WITH C(A) = 0. LOCCTR SET TO
		XCH	LOC		#  AWAKENED JOB REGISTERS.
		AD	MINUS1		# LOC IS NEGATIVE FOR BASIC JOBS.
		INDEX	LOCCTR
		XCH	LOC
		TC	LVENDMOD	# SET MODECADR TO +0 AND EXIT.

#	THE FOLLOWING ROUTINE INCREMENTS IN 2S COMPLEMENT THE REGISTER WHOSE ADDRESS IS IN ADDRWD BY THE
# QUANTITY FOUND IN TEM2.  THIS MAY BE USED TO INCREMENT DESIRED IMU AND OPTICS CDU ANGLES OR ANY OTHER 2S
# COMPLEMENT (+0 UNEQUAL TO -0) QUANTITY.

CDUINC		INDEX	BUF
		CCS	0		# THE 16TH BIT OF A WILL BE USED TO
		AD	ONE		# ACHIEVE THE REQUIRED 32,768 DISTINCT
		TC	+4		# STATES.
		
		AD	ONE
		AD	ONE		# A MAY HAVE OVERFLOW PRESENT HERE.
		COM			# DESIRED -1 IF DESIRED WAS NEGATIVE.
		
 +4		AD	TEM2		# AND MAYBE OVERFLOW SOME MORE.
		CCS	A		# BACK TO 2S COMPLEMENT.
		AD	ONE		#   NOTE THAT CCS TREATS A AS A 16 BIT NO.
		TC	+2
		COM
		TS	Q		# REVERTS -0 TO +0.
		TC	+4		# NO OVERFLOW - PLANT NEW DESIRED.
		
		INDEX	A		# OVERFLOW - SIMULATE UN-CORRECTED SIGN.
		CAF	LIMITS +1	# 37777 FOR NEGATIVE - 40000 IF PLUS.
		AD	Q		# OVERFLOW-CORRECTED DIFFERENCE.
		
 +4		INDEX	BUF
		TS	0		# NEW ANGLE.
		
		TC	SWRETURN	# RETURN TO CALLER.


REJEND		TC	ENDOPT
		TC	GOODEND
		TC	ENDOFJOB
		

#	WHEN A JOB WHICH REQUESTED A MODE SWITCH MUST IDLE UNTIL THE SWITCH IS COMPLETE, IT COMES TO IMUSTALL
# (OR OPTSTALL) TO WAIT FOR THE COMPLETION AND TO DO ERROR CHECKING. RETURN IS TO THE LOCATION IMMEDIATELY FOLLOW-
# ING THE CALLING SEQUENCE IF THE SWITCH WAS UNSUCCESSFUL, AND THE NEXT LOCATION IF IT WAS SUCCESSFUL. ANY
# IDLING IS DONE BY PUTTING THE JOB TO SLEEP, SO THAT A VAC AREA (IF USED) WOULD BE PRESERVED.

OPTSTALL	CAF	ONE		# 0 FOR IMU AND 1 FOR OPTICS AS USUAL.
		TC	+2
		
IMUSTALL	CAF	ZERO
		INHINT			# ONE SUB-SYSTEM AT A TIME ONLY.
		TS	RUPTREG2
		INDEX	A
		CCS	MODECADR	# SEE IF MODE SWITCH IS COMPLETE.
		TC	MODABORT	# VERY ILL IF SOMEONE ALREADY WAITING.
		TC	MODESLP		# MODE SWITCH INCOMPLETE - PUT JOB TO REST
		TC	MODEGOOD	# -1 INDICATES A SUCCESSFULLY COMPLETED SW
		
MG2		INDEX	RUPTREG2	# -0 MEANS FINISHED BUT FAILED.
		TS	MODECADR	# RESET TO +0.
		TC	MODEEXIT	# RELINT AND RETURN VIA SWCALL.
		
MODEGOOD	CCS	A		# SEE THAT MODECADR WAS INDEED -1.
		TC	MODABORT	# VERY ILL IF SOMEONE ALREADY WAITING.
		XCH	TEMQS		# INCREMENT RETURN TO INDICATE SUCCESS.
		AD	ONE
		XCH	TEMQS		# BRING +0 BACK
		TC	MG2		# TO RESET MODECADR AND EXIT.
		
MODESLP		TC	MAKECADR	# MAKE CADR FROM SWCALL RETUN ADDRESS.
		XCH	ADDRWD
		INDEX	RUPTREG2
		TS	MODECADR
		TC	JOBSLEEP
		
ENDSTALL	EQUALS


IMUPULSE	CAF	ZERO
		TS	MPAC +2
		TC	MAKECADR
		XCH	ADDRWD
		TS	BUF

		CAF	FOUR
PULSLOOP	TS	BUF +1
		INDEX	A
		XCH	GYROD +1
		TS	MPAC +1
		INDEX	BUF +1
		XCH	GYROD
		TS	MPAC

		TC	BANKCALL
		CADR	TPAGREE

		CCS	A
		TC	+1
		CAF	FOUR
		AD	MINUS2
		AD	MPAC +1
		AD	MPAC

		INDEX	BUF +1
		TS	GYROD +1

		CAF	ZERO
		AD	MPAC
		INDEX	BUF +1
		XCH	GYROD

		CS	ONE
		AD	BUF +1
		CCS	A
		TC	PULSLOOP
FULLDT		DEC	5.13 E2
		CS	THREE		# INITIALIZE CDUIND TO START GYRO TASKS
		TS	CDUIND		# AT Y GYRO (ORDER IS YZX).

		INHINT
		CAF	ONE
		TC	WAITLIST
		CADR	DOGYRO
		RELINT

		XCH	BUF
		TC	BANKJUMP

#	WAITLIST TASKS TO SEND OUT DP PULSE TRAINS TO THE GYROS.

TWEAKGY		TC	SETUPSUB	# FINISHED WITH POSITIVE TRAINS TO A GYRO.
		CS	TWO		#  SEND OUT 2- TO LEAVE GYRO IN - STATE.
		TC	OUT2SUB
		
GYROADV		CS	CDUIND		# ADVANCE TO THE NEXT GYRO IN ORDER YZX.
		MASK	LOW7		# BIT14 IS 1 IF 2+ PULSES HAD BEEN SENT
		INDEX	A		#  BEFORE A NEGATIVE COMMAND.
		TC	-1
		TC	IMUFINED
		CAF	SIX
		AD	NEG2		# (CAME HERE FROM TC WITH C(A)=4.)
		COM
		TS	CDUIND

DOGYRO		TC	SETUPSUB	# SERVICE GYRO WHOSE *NUMBER* IS IN CDUIND
		INDEX	RUPTREG3
		CCS	GYROD -4	# MAJOR PART IS POSMAX COUNT.
		TC	DOPOSMAX	# PUT OUT POSMAX.
		TC	DOMINOR
		TC	DONEGMAX

DOMINOR		INDEX	RUPTREG3	# SEND OUT REMAINDER OF COMMAND.
		CCS	GYROD -3
		TC	POSGOUT
		TC	TWEAKGY +1	# FINISHED WITH LONG . PULSE TRAIN.
		TC	NEGGOUT
		TC	GYROADV		# DONE WITH LONG - TRAIN OR ZERO INPUT.

DOPOSMAX	INDEX	RUPTREG3	# PUT AWAY DECREMENTED POSMAX COUNT.
		TS	GYROD -4
		CAF	POSMAX
DOMAX		TC	OUT2SUB
		CAF	FULLDT

GYROWAIT	TC	WAITLIST
		CADR	DOGYRO
		TC	TASKOVER

DONEGMAX	COM
		INDEX	RUPTREG3
		TS	GYROD -4	# DECREMENTED POSMAX (NEGMAX) COUNT.
		CS	CDUIND		# SEE IF 2+ PULSES HAVE BEEN PUT OUT YET,
		MASK	NEG1/2		#  LEAVING WORD THAT THEY WILL BE OUT
		AD	BIT14		#  BY TASKOVER TIME.
		COM
		XCH	CDUIND
		MASK	BIT14
		CCS	A
		TC	+2
		TC	NEGMAX2		# ALREADY OUT.
		
		CAF	TWO		# NOT OUT YET - DO SO.
		TC	OUT2SUB
		CAF	TWO		# WAIT FOR THEM TO GET OUT BEFORE DELIVER-
		CCS	A		#  ING THE REAL COMMAND.
		TC	-1
		
NEGMAX2		CS	POSMAX
		TC	DOMAX
		
POSGOUT		AD	ONE		# FRACTIONAL POSITIVE COMMAND.
		TS	OVCTR
		TC	OUT2SUB		# DELIVER COMMAND.
		TC	GETDT		# GET TIME TO END OF PULSE TRAIN.
		XCH	LPRUPT		# (ANSWER LEFT IN LPRUPT).
		TC	WAITLIST
		CADR	TWEAKGY		# SUPPLY 2- PULSES AT END.
		TC	TASKOVER
		
NEGGOUT		AD	ONE		# FRACTIONAL NEGATIVE COMMAND.
		TS	OVCTR
		CS	CDUIND		# SEE IF 2+ PULSES ALREADY OUT.
		MASK	BIT14
		CCS	A
		TC	NEGGOUT2
		
		CAF	TWO
		TC	OUT2SUB
		
NEGGOUT2	TC	GETDT
		CS	OVCTR		# DELIVER COMMAND.
		TC	OUT2SUB
		XCH	LPRUPT		# GET WAITLIST DT LEFT BY  GETDT  .
		TC	WAITLIST
		CADR	GYROADV
		TC	TASKOVER

#	SUBROUTINES USED BY TASKS.

GETDT		XCH	LP		# COMPUTE NUMBER OF 10 MS TICKS IT WILL
		TS	LPRUPT		#  TAKE THE PULSE TRAIN WHOSE MAGNITUDE IS
		CAF	BIT10		#  IN OVCTR TO BE DELIVERED AT A RATE OF
		EXTEND			#  3200 PPS.
		MP	OVCTR
		AD	TWO		# INTERRUPT AND ROUND-OFF UNCERTAINTIES.
		XCH	LPRUPT		# LEAVE ANSWER IN LPRUPT.
		EXTEND
		MP	ONE
		TC	Q
		
		
		
SETUPSUB	CAF	ZERO		# SETS UP MISCELLANEOUS REGISTERS.
		TS	RUPTREG2	# USED BY OUT2SUB.
		CS	CDUIND
		MASK	LOW7		# KILL 2+ BIT.
		TS	RUPTREG1
		DOUBLE
		TS	RUPTREG3	# USED FOR INDEXING GYROD SET.
		TC	Q
		

MOREZERO	TC	SETKANDC +1	# CALL FOR 10 SECONDS OF FINE ALIGN TO
		OCT	00050		#  ALLOW CDUS TO GO AT LEAST 90 DEGREES
		OCT	40010		#  OF THE WAY HOME UNLESS THE PLATFORM IS
		CAF	10SECS		#  SITTING AT ANY FALSE NULLS.
		TC	WAITLIST
		CADR	ZEROATTC	# WE WILL GO INTO ATTITUTE CONTROL NEXT.
		TC	TASKOVER
		
ZEROATTC	TC	KCHECK		# USUAL SYSTEM CHECK.
		TC	SETKANDC +1	# COMMAND ATTITUDE CONTROL (WITHOUT ATTC
		OCT	00060		#  LAMP LIT) SO THAT WE CAN DRIVE THE CDUS
		OCT	41000		# (LIGHT ON AFTER ALL) AWAY FROM FALSE NUL
		CAF	200MS
		TC	WAITLIST
		CADR	ZERODRVE	# WAIT FOR MODE SWITCH BEFORE ENABLING CDU
		TC	TASKOVER	#  DRIVE IN T4RUPT.

ZERODRVE	TC	KCHECK		# VERIFY SWITCH TO ATTITUDE CONTROL.
		TC	BLIVOT		# WE WILL DRIVE THE CDUS TOWARD 45 DEGREES
		TS	THETAD		#  FOR 2SECS (ABOUT 10 DEGREES OF MOVEMENT
		TS	THETAD +1	#  AT MOST). THIS WILL DRIVE ANY CDUS OFF
		TS	THETAD +2	#  FALSE NULLS WITHOUT MOVING THE PLATFORM
		CAF	ZERO
		TS	CDUIND		# CDU LOOPS ARE NOW ENABLED.
		CAF	2SECS
		TC	WAITLIST
		CADR	REZFINE		# GO BACK TO FINE ALIGN WHEN DONE.
		TC	TASKOVER
		
REZFINE		TC	KCHECK		# VERIFY MODE SWITCH AS USUAL.
		TC	SETKANDC +1	# CALL FOR 20 SECONDS OF FINE ALIGN TO
		OCT	00050		#  ALLOW ENOUGH TIME FOR THE CDUS TO FIND
		OCT	40010		#  THE GIMBALS.
		CS	ONE
		TS	CDUIND		# CDU LOOPS NOW DISABLED.
		CAF	20SECS
		TC	WAITLIST
		CADR	IMUFINED	# CHECK FORPRESENCE OF IMU OR CDU FAILS.
		TC	BLIVOT2



KCHECK		CCS	WASKSET		# RETURN TO CALLER IF SYSTEM OK - SET UP
		TC	Q		#  ERROR RETURN AT ENDIMU OTHERWISE.
		TC	ENDIMU
		TC	Q
		TC	ENDIMU
		
40SECS		DEC	40.00 E2	# TIME FOR IMUCDU ZERO ENCODER.
20SECS		DEC	20.00 E2
10SECS		DEC	10.00 E2
2SECS		DEC	2.00 E2
60SECS		DEC	60.00 E2	# TIME FOR IMUCDU COARSE ALIGN.


#	MARK REQUESTING ROUTINES.

		SETLOC	12000

KEYRUPTB	TC	KEYRUPTA	# STANDARD LOC, DONT MOVE

SXTMARK		TC	MARKCOM
		OCT	10000

SCTMARK		TC	MARKCOM
		OCT	00000

MARKCOM		INHINT
		TS	RUPTREG1	# NUMBER OF MARKS REQUESTED.

		INDEX	Q
		CAF	0
		TS	RUPTREG2
		
		CCS	MARKSTAT	# SEE IF MARK BUTTON ALREADY SNATCHED.
		TC	+2		# YES - ALARM AND END THE STRAY JOB.
		TC	MARKOK		# +0 INDICATES AVAILABLE.
		
		TC	ALARM
		OCT	00105
		TC	ENDOFJOB
		
MARKOK		CCS	VAC1USE		# FIND A VAC AREA TO STORE THE MARKS IN.
		TC	MKVACFND
		CCS	VAC2USE
		TC	MKVACFND
		CCS	VAC3USE
		TC	MKVACFND
		CCS	VAC4USE
		TC	MKVACFND
		CCS	VAC5USE
		TC	MKVACFND
		
		TC	ABORT		# VAC AREAS ALL OCCUPIED - ABORT.
		OCT	00104
		
MKVACFND	AD	TWO		# ADDRESS OF VAC.
		TS	MARKSTAT
		INDEX	A
		TS	QPRET		# USED TO SHOW NEXT AVAILABLE MARK SLOT.
		
		CAF	ZERO		# SHOW VACAREA IS OCCUPIED.
		INDEX	MARKSTAT
		TS	0 -1

		CAF	BIT13
		EXTEND
		MP	RUPTREG2
		XCH	RUPTREG1
		
		EXTEND			# PLACE DESIRED NUMBER OF MARKS IN 12 - 14
		MP	BIT12
		XCH	LP
		AD	RUPTREG1
		AD	MARKSTAT	# JUST CONTAINS LOW 9 BITS OF VAC ADDRESS.
		TS	MARKSTAT

		CCS	DESOPSET
		TC	SETSXTON
		TC	MARKEXIT
		TC	MARKEXIT

SETSXTON	CS	BIT13
		MASK	DESOPSET
		AD	RUPTREG2
		TS	DESOPSET
		
MARKEXIT	CAF	MARKPRIO
		TC	NOVAC
		CADR	MKPASTE
		RELINT
		TC	SWRETURN

MARKPRIO	OCT	27000

MKPASTE		CAF	VB51		# ASSUME USING PROGRAM HAS GRABBED DSP.
		TC	NVSUB
		TC	PRENVBSY
		TC	BANKCALL
		CADR	FLASHON
		TC	ENDOFJOB

VB51		OCT	5100

#	MARK SYSTEM RELEASING ROUTINE.

MKRELEAS	CAF	ZERO		# SHOW MARK SYSTEM NOW AVAILABLE.
		XCH	MARKSTAT
		CCS	A
		INDEX	A
		TS	0
		
		TC	SWRETURN
		

#	KEYRUPT LEAD-IN AND MARK/MARK ACCEPT PROGRAMS.

KEYRUPTA	TS	BANKRUPT
MARK		CS	OPTY		# PRECISION OPTICS DRIVE - GATHER DATA
		TS	RUPTSTOR +5	# IMMEDIATELY AND THEN TRANSFER TO VAC.
		
		CS	OPTX		# SHAFT OPTICS ENCODER.
		TS	RUPTSTOR +3
		
		CS	CDUY		# READ INNER-MIDDLE-OUTER IMUCDUS.
		TS	RUPTSTOR +2
		
		CS	CDUZ
		TS	RUPTSTOR +4
		
		CS	CDUX
		TS	RUPTSTOR +6
		
		TC	READTIME +1	# SPECIAL DP TIME COUNTER-READING ROUTINE.
		
		CCS	IN0		# SEE IF KEYCODE OR MARK.
		AD	ONE
		TC	KEYCALL
		TC	+4		# IN0 SHOULD NEVER CONTAIN -0.

		CCS	A
		AD	ONE
		TC	KEYCALL
		
		XCH	IN3		# NOW FIND OUT IF IT WAS A MARK-REJECT.
		XCH	IN3
		MASK	BIT12		# OPT ZERO/MARK REJECT BIT.
		CCS	A
		TC	MKACCEPT

		CCS	MARKSTAT	# SEE IF MARKS BEING CALLED FOR.
		TC	MARK2
		
		XCH	RUPTSTOR +3	# STORE IN OBTAINED MPAC COMPLEMENTED.
		TS	RUPTREG1	# OPTICS ANGLES AND MINOR PART OF TIME.
		XCH	RUPTSTOR +5	# -OPTX, -OPTY, AND -TIME1.
		TS	RUPTREG2
		XCH	RUPTSTOR +1
		TS	RUPTREG3
		
		CAF	MKDSPRIO	# CALL SPECIAL DISPLAY JOB
		TC	NOVAC
		CADR	MARKDISP
		
		XCH	RUPTREG1	# PLANT INFORMATION IN MPAC OF REGISTER
		INDEX	LOCCTR		# SET.
		TS	MPAC
		XCH	RUPTREG2
		INDEX	LOCCTR
		TS	MPAC +1
		XCH	RUPTREG3
		INDEX	LOCCTR
		TS	MPAC +2
		
		TC	RESUME
		

MARK2		TS	RUPTREG2	# SEE IF ANY MORE MARKS CALLED FOR.
		AD	BIT12BAR
		CCS	A
		TC	+3
BIT12BAR	OCT	-4000
		TC	BADMARK

		CAF	BIT13
		MASK	WASOPSET
		CCS	A
		CAF	BIT11
		AD	MARKSTAT
		MASK	BIT11
		CCS	A
		TC	+2
		TC	MARK3

		CCS	WASOPSET
		TC	BADMARK
		TC	BADMARK
		TC	MARK3
		
BADMARK		TC	ALARM
		OCT	00106
		TC	RESUME		# NO FURTHER ACTION HERE.
		
MARK3		CS	BIT10		# SET BIT 10 = 1 TO ENABLE MARK
		MASK	MARKSTAT	# REJECT.
		AD	BIT10
		TS	MARKSTAT
		
		MASK	LOW9		# SET UP REGISTER TRANSFER LOOP.
		INDEX	A
		CS	QPRET		# PICK UP MARK SLOT-POINTER.
		COM
		AD	SIX
		TS	RUPTREG1
		CAF	SIX		# LOOP SEVEN TIMES.

READLOOP	TS	RUPTREG2
		INDEX	A
		CS	RUPTSTOR
		INDEX	RUPTREG1
		TS	0
		CCS	RUPTREG1	# ADDRESS NEXT LOCATION IN VAC.
		TS	RUPTREG1
		CCS	RUPTREG2
		TC	READLOOP
		
		TC	RESUME		# DONE.
		

MKACCEPT	CCS	MARKSTAT	# SEE IF MARKS BEING ACCEPTED.
		TC	ACCEPT2
		TC	ALARM		# CURSE IF NOT.
		OCT	00107
		TC	TASKOVER	# (UNTIL MK ACCEPT BUTTON AVAILABLE).
		
ACCEPT2		CS	BIT10		# SEE IF MARK HAD BEEN MADE SINCE LAST
		MASK	MARKSTAT	# MARK REJECT, AND SET BIT 10 TO ZERO TO
		XCH	MARKSTAT	# SHOW MARK REJECT.
		MASK	BIT10
		CCS	A
		TC	ACCEPT3
		
		TC	ALARM		# DONT ACCEPT TWO MARK REJECTS TOGETHER.
		OCT	00110
		TC	TASKOVER	# (UNTIL MK REJECT BUTTON AVAILABLE).
		
ACCEPT3		CAF	LOW9		# DECREMENT POINTER TO REJECT MARK.
		MASK	MARKSTAT
		TS	ITEMP1
		INDEX	A
		XCH	QPRET
		AD	SEVEN
		INDEX	ITEMP1
		TS	QPRET		# NEW POINTER.
		
		CS	BIT12		# INCREMENT MARKS-TO-BE-ACCEPTED FIELD
		AD	MARKSTAT	# AND IF FIELD IS NOW NON-ZERO, CHANGE
		TS	MARKSTAT	# DSKY TO VERB 51 FLASHING TO INDICATE
		MASK	HI4		# MORE MARKS REQUIRED.
		CCS	A
		TC	TASKOVER	# (UNTIL BUTTON AVAIL.)
		CAF	LOW9
		MASK	MARKSTAT
		TS	MARKSTAT

		CAF	MARKPRIO
		TC	NOVAC
		CADR	MKFLSHOF

		TC	POSTJUMP
		CADR	REJEND

MKFLSHOF	TC	BANKCALL
		CADR	FLASHOFF
		TC	ENDOFJOB
		
MARKDISP	TC	GRABDSP		# SPECIAL JOB TO DISPLAY UNCALLED-FOR MARK
		TC	PREGBSY
		
REMKDSP		CS	MPAC		# THE MPAC REGISTERS CONTIN -OPTX, -OPTY,
		TS	DSPTEM1
		CS	MPAC +1
		TS	DSPTEM1 +1
		CS	MPAC +2
		TS	DSPTEM2
		CAF	ZERO
		TS	DSPTEM1 +2
		
		CAF	MKDSPCOD	# NOUN-VERB FOR MARK DISPLAY.
		TC	NVSUB
		TC	MKDSPBSY	# IF BUSY.
		
		TC	ENDMKDSP

MKDSPBSY	CAF	LREMKDSP	# TAKE DATA OUT OF MPAC WHEN RE-AWAKENED.
		TC	NVSUBUSY
		
MKDSPCOD	OCT	00656
MKDSPRIO	OCT	15000
LREMKDSP	CADR	REMKDSP

KEYCALL		TC	POSTJUMP	# GO TO KEYBOARD/DISPLAY BANK WITH A
		CADR	KEYRUPTC	# GO THRU STANDARD LOC.
		
HI4		OCT	74000
OCT37740	OCT	37740

ENDMARK		EQUALS

		BANK	10
CDUFAIL2	CS	BIT6		# TURN ON FAIL LIGHT ONLY IF IN FINE ALIGN
		MASK	WASKSET
		AD	-BIT4
		CCS	A
		TC	ERRSCAN3
-BIT4		OCT	-10
		TC	ERRSCAN3
		TC	CDUFAIL3	# TURN ON THE LIGHT.

		SETLOC	21740

BLIVOT		XCH	THETAD
		TS	1650
		XCH	THETAD +1
		TS	1651
		XCH	THETAD +2
		TS	1652
		CAF	POS1/2
		TC	ZERODRVE +2

BLIVOT2		XCH	1650
		TS	THETAD
		XCH	1651
		TS	THETAD +1
		XCH	1652
		TS	THETAD +2
		TC	TASKOVER

BLIVOT3		CS	OPTY		# IF THE DIFFERENCE OVERFLOWS, THE ERROR
		AD	DESOPTX +1	#  ERROR SIGNAL IS GREATER THAN 16383, SO
		TS	Q		#  JUST THROW IN POSMAX WITH THE RIGHT 
		TC	+3		#  SIGN AND CALL IT A DAY. OTHERWISE FOLL-
		
		INDEX	A		#  THE USUAL PROCEDURES.
		CS	LIMITS
		TC	OPTOUT
