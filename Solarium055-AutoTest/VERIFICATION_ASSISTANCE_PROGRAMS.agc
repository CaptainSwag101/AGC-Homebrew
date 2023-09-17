### FILE="Main.annotation"
## Copyright:	Public domain.
## Filename:	VERIFICATION_ASSISTANCE_PROGRAMS.agc
## Purpose:	Part of the source code for Solarium build 55. This
##		is for the Command Module's (CM) Apollo Guidance
##		Computer (AGC), for Apollo 6.
## Assembler:	yaYUL --block1
## Contact:	Jim Lawton <jim DOT lawton AT gmail DOT com>
## Website:	www.ibiblio.org/apollo/index.html
## Page Scans:	www.ibiblio.org/apollo/ScansForConversion/Solarium055/
## Mod history:	2009-09-21 JL	Created.
##		2016-08-20 RSB	Typo.
## 		2016-12-28 RSB	Proofed comment text using octopus/ProoferComments,
##				and fixed errors found.

## Page 754

#	WAITLIST EXERCISE PROGRAM. TIMES ARE GIVEN IN THE FORM NN + NN/32 + YY, WHERE THE NS REFER TO TIME
# SINCE THE BEGINNING OF THE TEST, AND YS ADDITIONAL MCT.

		BANK	13
WLTEST		XCH	IN2
		CCS	IN2		# GET IN PHASE WITH T3 INCREMENTS.
		TC	+2
		TC	-2

		CCS	IN2
		TC	-1
		TS	OUTCR1		# TO INITIALIZE.

#	THE FIRST TASK IS ENTERED INTO SLOT 1 WITH A T3 INCREMENT BETWEEN THE TWO T3 REFERENCES. CALL AT
# 10 +00/32 -25. SPECIFY WAIT TO 30/32.

		TC	OUTCR1WT
		DEC	29

		TC	OUTCR1WT	# GO WAIT FOR THIS AND SPECIFY RESET TO
		DEC	42		# 20 +8/32.

#	AT 30/32 +16, WAIT 12 MCT BEFORE ENTERING TASK 1.

		CAF	ZERO		# TUNING CONSTANT.
		CCS	A
		TC	-1
		CAF	ONE		# TASK ENTRY WITH T3 INC BETWEEN TWO T3
		TC	WAITLIST	# REFERENCES.
		CADR	NOPLWAIT +2	# TASK IN HIGH SWITCHED BANK.

		TC	OUTCR1WT	# WAIT FOR 20 +8/32. CALL FOR RESET TO
		DEC	23		# 20 +31/32.

		CAF	ONE		# AT 20 +8/32 + 16, ENTER TASK 2 DUE AT
		TC	WAITLIST	# 30.
		CADR	QTSK2

## Page 755

#	WAIT FOR 20 +31/32 +16 AND AT THAT TIME WAIT FOR T3 TO OVERFLOW BEFORE ENTERING TASK 3. REQUIRES RESET
# TO 30 +10/32.

		TC	OUTCR1WT
		DEC	11
		CCS	TIME3
		TC	-1
		CAF	ONE		# ENTER TASK 3 AFTER T3 OVF.
		TC	WAITLIST
		CADR	QTSK3

		TC	OUTCR1WT	# TASK 3 IS DUE AT 40. WAIT FOR 30 +10/32
		DEC	53		# CALLING FOR RESET TO 40 +31/32.

#	AT 30 +10/32 +16, ENTER TASKS 4 AND 5 DUE SAME RUPT AT 50. THEY WILL BE INHIBITED FOR 6 MS SO THAT T3
# WILL TICK WHILE IT IS BEING RESET IN THE DISPATCH OF 5.

		CAF	TWO		# ENTERED INTO SLOTS 2 AND 3.
		TC	WAITLIST
		CADR	QTSK4
		CAF	TWO
		TC	WAITLIST
		CADR	TCTSKOVR	# TASK IN FIXED-FIXED.

		TC	OUTCR1WT	# WAIT FOR 40 +31/32 +16, CALLING FOR
		DEC	19		# RESET TO 50 +18/32.

		TC	OUTCR1WT +1	# AT 40 +31/32 +16, INHIBIT UNTIL
		DEC	24		# 50 +18/32 +16 AND RESET TO 60 +10/32.

		TC	OUTCR1WT	# AT 50 +18/32 +16, WAIT UNTIL 60 10/32,
		DEC	21		# RESETTING TO 60 +31/32.

## Page 756

#	AT 60 +10/32 +16, ENTER TASKS 6 AND 7 DUE AT 70 AND 8 DUE AT 80. T3 WILL INCREMENT DURING TASK 7
# DISPATCH, MAKING TASK 8 DUE THAT INTERRUPT. 

		CAF	ONE
		TC	WAITLIST	# ENTER TWO TASKS DUE SAME T3 RUPT AND
		CADR	QTSK6		# ANOTHER DUE THE FOLLOWING RUPT.
		CAF	ONE
		TC	WAITLIST
		CADR	QTSK7
		CAF	TWO		# A T3 INC WILL OCCUR WHILE TASK 7 IS
		TC	WAITLIST	# SETTING T3 FOR THIS TASK AND CAUSE IT TO
		CADR	QTSK8		# BE THE THIRD TASK DUE THAT RUPT.

		TC	OUTCR1WT	# WAIT UNTIL 60 +31/32 +16, INHINTING
		DEC	19		# 70 +18/32 +16.
		TC	OUTCR1WT +1
		DEC	1

		CAF	FIVE		# SYSTEMMATICALLY ENTER TASKS IN ALL 6
		TS	MPAC		# SLOTS.

QTSKLOOP	RELINT
		INHINT
		CS	MPAC
		AD	SEVEN
		TC	WAITLIST
		CADR	QTSK10
		CCS	MPAC
		TC	QTSKLOOP -1

QENDTEST	TC

## Page 757

#	THE FOLLOWING SUBROUTINE USES OUTCR1 AS A FINE TIMER DURING THE WAITLIST TEST.

OUTCR1WT	RELINT
		XCH	Q
		TS	MPAC
		INDEX	A
		CS	0		# NUMBER OF THIRTY-SECONDS OF 10MS TO WAIT
		AD	HALF
		AD	HALF
		TS	MPAC +1		# NEW OUTCR SETTING.

		CCS	OUTCR1
		TC	-1

OUTCR1W2	XCH	MPAC +1
		TS	OUTCR1
		CAF	1WTCODE
		TS	OUT2
		INHINT
		INDEX	MPAC
		TC	1

1WTCODE		OCT	26000

## Page 758

# 	TASKS FOR WAITLIST TESTER.

QTSK2		TC	TASKOVER
QTSK3		TC	TASKOVER
QTSK4		CAF	QTSK4DEL	# WAIT SO THAT T3 WILL TICK DURING DISPTCH
		CCS	A
		TC	-1
		TC	TASKOVER

QTSK6		CAF	QTSK6DEL
		TC	QTSK4 +1

QTSK7		TC	TASKOVER
QTSK8		TC	TASKOVER
QTSK10		TC	TASKOVER

QTSK4DEL	DEC	77		# TUNING CONSTANTS.
QTSK6DEL	DEC	78
