### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    ASSEMBLY_AND_OPERATION_INFORMATION.agc
## Purpose:     A section of Sundial E.
##              It is part of the reconstructed source code for the final
##              release of the Block II Command Module system test software. No
##              original listings of this program are available; instead, this
##              file was created via disassembly of dumps of Sundial core rope
##              modules and comparison with other AGC programs.
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2023-06-22 MAS  Created from Aurora 12.
##              2023-06-30 MAS  Updated for Sundial E.

# VERB INFORMATION.

#  REGULAR VERBS
# 01  DISPLAY OCTAL COMP 1 (R1)
# 02  DISPLAY OCTAL COMP 2 (R1)
# 03  DISPLAY OCTAL COMP 3 (R1)
# 04  DISPLAY OCTAL COMP 1,2 (R1,R2)
# 05  DISPLAY OCTAL COMP 1,2,3 (R1,R2,R3)
# 06  DECIMAL DISPLAY
# 07  DP DECIMAL DISPLAY (R1,R2)
# 10  SPARE
# 11  MONITOR OCT COMP 1 (R1)
# 12  MONITOR OCT COMP 2 (R1)
# 13  MONITOR OCT COMP 3 (R1)
# 14  MONITOR OCT COMP 1,2 (R1)
# 15  MONITOR OCT COMP 1,2,3 (R1,R2,R3)
# 16  MONITOR DECIMAL
# 17  MONITOR DP DECIMAL (R1,R2)
# 20  SPARE
# 21  LOAD COMP 1 (R1)
# 22  LOAD COMP 2 (R2)
# 23  LOAD COMP 3 (R3)
# 24  LOAD COMP 1,2 (R1,R2)
# 25  LOAD COMP 1,2,3 (R1,R2,R3)
# 26  SPARE
# 27  FIXED MEMORY DISPLAY 
# 30  REQUEST EXECUTIVE
# 31  REQUEST WAITLIST
# 32  C(R2) INTO R3, C(R1) INTO R2
# 33  PROCEED WITHOUT DATA
# 34  TERMINATE CURRENT TEST OR LOAD REQUEST
# 35  TEST LIGHTS
# 36  FRESH START
# 37  CHANGE MAJOR MODE
# END OF REGULAR VERBS

# EXTENDED VERBS
# 40  ZERO (USED WITH NOUNS 20 AND 55)
# 41  COARSE ALIGN (USED WITH NOUNS 20 AND 55)
# 42  FINE ALIGN IMU
# 43  LOAD IMU ATTITUDE ERROR METERS
# 44  ILLEGAL VERB
# 45  ILLEGAL VERB
# 46  ILLEGAL VERB
# 47  PERFORM CSM & SATURN TESTS
# 50  PLEASE PERFORM
# 51  PLEASE MARK
# 52  PERFORM PRELAUNCH ALIGNMENT OPTICAL VERIFICATION
# 53  ILLEGAL VERB
# 54  PULSE TORQUE GYROS
# 55  ALIGN TIME
# 56  PERFORM BANKSUM
# 57  PERFORM SYSTEM TEST
# 60  PREPARE FOR CGC STANDBY
# 61  RECOVERY FROM CGC STANDBY
# 62  SCAN CSM INBITS
# 63  ILLEGAL VERB
# 64  ILLEGAL VERB
# 65  ILLEGAL VERB
# 66  ILLEGAL VERB
# 67  ILLEGAL VERB
# 70  ILLEGAL VERB
# 71  ILLEGAL VERB
# 72  ILLEGAL VERB
# 73  ILLEGAL VERB
# 74  ILLEGAL VERB
# 75  ILLEGAL VERB
# 76  ILLEGAL VERB
# 77  ILLEGAL VERB

# NORMAL NOUNS                                       SCALE AND DECIMAL POINT
# 00  NOT IN USE
# 01  SPECIFY MACHINE ADDRESS (FRACTIONAL)           (.XXXXX)
# 02  SPECIFY MACHINE ADDRESS (WHOLE)                (XXXXX.)
# 03  SPECIFY MACHINE ADDRESS (DEGREES)              (XXX.XXDEGREES)
# 04  SPECIFY MACHINE ADDRESS (HOURS)                (XXX.XXHOURS)
# 05  SPECIFY MACHINE ADDRESS (SECONDS)              (XXX.XXSECONDS)
# 06  SPECIFY MACHINE ADDRESS (GYRO DEGREES)         (XX.XXXDEGREES)
# 07  SPECIFY MACHINE ADDRESS (Y OPT DEGREES)        (XX.XXXDEGREES)
# 10  CHANNEL TO BE SPECIFIED
# 11  SPARE
# 12  SPARE
# 13  SPARE
# 14  SPARE
# 15  INCREMENT MACHINE ADDRESS                      (OCTAL ONLY)
# 16  TIME SECONDS                                   (XXX.XXSECONDS)
# 17  TIME HOURS                                     (XXX.XXHOURS)
# 20  ICDU                                           (XXX.XXDEGREES)
# 21  PIPAS                                          (XXXXX.PULSES)
# 22  NEW ANGLES I                                   (XXX.XXDEGREES)
# 23  DELTA ANGLES I                                 (XXX.XXDEGREES)
# 24  DELTA TIME (SECONDS)                           (XXX.XXSECONDS)
# 25  CHECKLIST                                      (XXXXX.)
# 26  PRIO/DELAY, ADRES, BBCON                       (OCTAL ONLY)
# 27  SELF TEST ON/OFF SWITCH                        (XXXXX.)
# 30  STAR NUMBERS                                   (XXXXX.)
# 31  FAILREG, SFAIL, ERCOUNT                        (OCTAL ONLY)
# 32  DECISION TIME (MIDCOURSE)                      (XXX.XXHOURS (INTERNAL UNITS = WEEKS))
# 33  EPHEMERIS TIME (MIDCOURSE)                     (XXX.XXHOURS (INTERNAL UNITS = WEEKS))
# 34  MEASURED QUANTITY (MIDCOURSE)                  (XXXX.XKILOMETERS)
# 35  INBIT MESSAGE                                  (OCTAL ONLY)
# 36  LANDMARK DATA 1                                (OCTAL ONLY)
# 37  LANDMARK DATA 2                                (OCTAL ONLY)
# 40  SPARE
# 41  SPARE
# 42  SPARE
# 43  SPARE
# 44  SPARE
# 45  SPARE
# 46  SPARE
# 47  SPARE
# 50  SPARE
# 51  SPARE
# 52  GYRO BIAS DRIFT                                (.BBXXXXXMILLIRAD/SEC)
# 53  GYRO INPUT AXIS ACCELERATION DRIFT             (.BBXXXXX(MILLIRAD/SEC)/(CM/SEC SEC))
# 54  GYRO SPIN AXIS ACCELERATION DRIFT              (.BBXXXXX(MILLIRAD/SEC)/(CM/SEC SEC))
# END OF NORMAL NOUNS

# MIXED NOUNS                                        SCALE AND DECIMAL POINT
# 55  OCDU                                           (XXX.XXDEG, XX.XXXDEG)
# 56  UNCALLED MARK DATA (OCDU & TIME(SECONDS))      (XXX.XXDEG, XX.XXXDEG, XXX.XXSEC)
# 57  NEW ANGLES OCDU                                (XXX.XXDEG, XX.XXXDEG)
# 60  DELTA GYRO ANGLES FOR PRELAUNCH                (XX.XXXDEG  FOR EACH)
#     OPTICAL VERIFICATION
# 61  TARGET AZIMUTH AND ELEVATION                   (XXX.XXDEG, XX.XXXDEG)
# 62  ICDUZ AND TIME                                 (XXX.XXDEG, XXX.XXSEC)
# 63  OCDUX AND TIME                                 (XXX.XXDEG, XXX.XXSEC)
# 64  OCDUY AND TIME                                 (XX.XXXDEG, XXX.XXSEC)
# 65  SAMPLED TIME (HOURS AND SECONDS)               (XXX.XXHOURS, XXX.XXSEC)
#         (FETCHED IN INTERRUPT)
# 66  SYSTEM TEST RESULTS                            (XXXXX., .XXXXX, XXXXX.)
# 67  DELTA GYRO ANGLES                              (XX.XXXDEG  FOR EACH)
# 70  PIPA BIAS                                      (X.XXXXCM/SEC SEC  FOR EACH)
# 71  PIPA SCALE FACTOR ERROR                        (XXXXX.PARTS/MILLION  FOR EACH)
# 72  DELTA POSITION                                 (XXXX.XKILOMETERS  FOR EACH)
# 73  DELTA VELOCITY                                 (XXXX.XMETERS/SEC  FOR EACH)
# 74  MEASUREMENT DATA (MIDCOURSE)                   (XXX.XXHOURS (INTERNAL UNITS=WEEKS), XXXX.XKILOMETERS, XXXXX.
# 75  MEASUREMENT DEVIATIONS (MIDCOURSE)             (XXXX.XKILOMETERS, XXXX.XMETERS/SEC, XXXX.XKILOMETERS)
# 76  POSITION VECTOR                                (XXXX.XKILOMETERS  FOR EACH)
# 77  VELOCITY VECTOR                                (XXXX.XMETERS/SEC  FOR EACH)

# TABLE OF ERROR CODES

# OPTICS SUB-SYSTEM

# 00105    MARK BUTTONS NOT AVAILABLE
# 00110    NO MARK SINCE LAST MARK REJECT
# 00112    MARK NOT BEING ACCEPTED
# 00113    NO INBITS
# 00114    MARK MADE BUT NOT DESIRED
# 00115    OPTICS TORQUE REQUEST WITH SWITCH NOT AT CGC
# 00116    OPTICS SWITCH ALTERED BEFORE 15 SEC. ZERO TIME ELAPSED
# 00117    OPTICS TORQUE REQUEST WITH OPTICS NOT AVAILABLE (OPTIND = -0)
# 00120    OPTICS TORQUE REQUEST WITH OPTICS NOT ZEROED

# IMU SUB-SYSTEM

# 00207    ISS TURN-ON REQUEST NOT PRESENT FOR 90 SEC.
# 00210    IMU NOT OPERATING
# 00211    COARSE ALIGN ERROR
# 00212    PIPA FAIL BUT PIPA IS NOT BEING USED
# 00213    IMU NOT OPERATING WITH TURN-ON REQUEST
# 00214    PROGRAM USING IMU WHEN TURNED OFF

# PROCEDURAL DIFFICULTY

# 00401    DESIRED GIMBAL ANGLES YIELD GIMBAL LOCK
# 00402    STAR OUT OF FIELD OF VIEW
# 00403    STAR OUT OF FIELD OF VIEW

# COMPUTER HARDWARE MALFUNCTIONS

# 01102    AGC SELF TEST ERROR
# 01103    UNUSED CCS BRANCH EXECUTED . ABORT
# 01105    DOWNLINK TOO FAST
# 01106    UPLINK TOO FAST
# 01107    PHASE TABLE DISAGREEMENT. DOFSTART

# LIST OVERFLOWS ( ALL ABORTS )

# 01201    EXECUTIVE OVERFLOW-NO VAC AREAS
# 01202    EXECUTIVE OVERFLOW-NO CORE SETS
# 01203    WAITLIST OVERFLOW-TOO MANY TASKS
# 01206    KEYBOARD AND DISPLAY WAITING LINE OVERFLOW
# 01207    NO VAC AREA FOR MARKS
# 01210    TWO PROGRAMS USING DEVICE AT SAME TIME

# INTERPRETER ERRORS

# 01301    ARCSIN-ARCCOS INPUT ANGLE TOO LARGE. ABORT
# 01302    SQRT CALLED WITH NEGATIVE ARGUMENT . ABORT

# DISPLAY ALARMS

# 01401    TESTIDX TOO LARGE IN CSM & SATURN TEST. ENDTEST
# 01402    AN ILLEGAL QUANTITY LOADED IN THE JET OR ENGINE TASK ERASABLE TABLE.
#          ENDTEST.
# 01403    AN ILLEGAL QUANTITY LOADED IN THE SPS OR SATURN STEERING TASK
#          ERASABLE TABLE. ENDTEST.
# 01404    CSM & SATURN TEST PLEASE PERFORM TASK 401, 402, OR 403 FAILED. ENDTEST
# 01405    ICDUS BUSY DURING SATURN STEERING TEST. ENDTEST
# 01411    A)    OPCHK. IMU IS NOT ON, IN IMU OPERATIONAL CHECK.
#          B)    ERRMASK. CDU DOES NOT AGREE WITH COMMAND IN IMU OP CHECK
#          C)    STILLOOK. FIRST CDU PULSE WAS MISSED IN IRIG SF TEST.
#          D)    STOPTEST. LAST CDU PULSE WAS MISSED OR GYRO TORQUE LOOP OUT OF
#                LIMITS IN IRIG SF TEST

# KEYBOARD AND DISPLAY PROGRAM

# 01501    KEYBOARD AND DISPLAY ALARM DURING INTERNAL USE(NVSUB).ABORT

# SYSTEM TEST ALARMS

# 01600    DRIFT TEST MISSED IN TIME STEP
# 01601    DRIFT TEST INTEGRATION OVERFLOW
# 01602    DRIFT TEST ERROR IN GYRO TORQUEING. ENDTEST

