### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    ASSEMBLY_AND_OPERATION_INFORMATION.agc
## Purpose:     A log section of Zerlina 56, the final revision of
##              Don Eyles's offline development program for the variable 
##              guidance period servicer. It also includes a new P66 with LPD 
##              (Landing Point Designator) capability, based on an idea of John 
##              Young's. Neither of these advanced features were actually flown,
##              but Zerlina was also the birthplace of other big improvements to
##              Luminary including the terrain model and new (Luminary 1E)
##              analog display programs. Zerlina was branched off of Luminary 145,
##              and revision 56 includes all changes up to and including Luminary
##              183. It is therefore quite close to the Apollo 14 program,
##              Luminary 178, where not modified with new features.
## Reference:   pp. 2-27
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2017-07-28 MAS  Created from Luminary 210.
##              2017-08-12 MAS  Updated for Zerlina 56

## Page 2
# THIS LGC PROGRAM IS INTENDED FOR USE IN THE LM DURING THE MANNED LUNAR LANDING MISSION OR ANY SUBSET THEREOF.
# THE DETAILS OF IMPLEMENTATION ARE SPECIFIED IN REPORT R-567, AS AMENDED.


#                            GUIDANCE SYSTEM OPERATIONS PLAN
#                    FOR MANNED LM EARTH ORBITAL AND LUNAR MISSIONS
#                                 USING PROGRAM LUMINARY


# THIS PROGRAM AND R-567 HAVE BEEN PREPARED BY THE INSTRUMENTATION LABORATORY, MASSACHUSETTS INSTITUTE OF
# TECHNOLOGY  75 CAMBRIDGE PARKWAY, CAMBRIDGE, MASSACHUSETTS UNDER PROJECT55-238-70, SPONSORED BY THE MANNED
# SPACECRAFT CENTER OF THE NATIONAL AERONAUTICS AND SPACE ADMINISTRATION, CONTRACT NAS 9-4065.


# THIS PROGRAM IS A VERSION OF LUMINARY FOR DEVELOPING A NEW VARIABLE GUIDANCE PERIOD SERVICER.

# TABLE OF LOG CARDS

# ABSOLUTE ADDRESSES FOR UPDATE PROGRAM
# ASSEMBLY AND OPERATION INFORMATION
# TAGS FOR RELATIVE SETLOC AND BLANK BANK CARDS
# CONTROLLED CONSTANTS
# INPUT/OUTPUT CHANNEL BIT DESCRIPTIONS
# FLAGWORD ASSIGNMENTS
# SUBROUTINE CALLS


# TABLE OF SUBROUTINE LOG SECTIONS
#          ZERASE  
#                 ERASABLE ASSIGNMENTS
#          ZERLAID 
#                 INTERRUPT LEAD INS
#                 T4RUPT PROGRAM
#                 RCS FAILURE MONITOR
#                 DOWNLINK LISTS
#                 AGS INITIALIZATION
#                 FRESH START AND RESTART
#                 RESTART TABLES
#                 AOTMARK
#                 EXTENDED VERBS
#                 PINBALL NOUN TABLES
#                 LEM GEOMETRY
#                 IMU COMPENSATION PACKAGE
#                 R63
#                 ATTITUDE MANEUVER ROUTINE
#                 GIMBAL LOCK AVOIDANCE
#                 KALCMANU STEERING
#                 SYSTEM TEST STANDARD LEAD INS
#                 IMU PERFORMANCE TESTS 2
#                 IMU PERFORMANCE TESTS 4
## Page 3
#                 PINBALL GAMES BUTTONS AND LIGHTS
#                 R60,R62
#                 S-BAND ANTENNA FOR LM
#          ZLEMP20S
#                 RADAR LEADIN ROUTINES
#                 P20-P25
#          LEMP30S
#                 P30,P37
#                 P32-P35, P72-P75
#          KISSING
#                 GROUND TRACKING DETERMINATION PROGRAM - P21
#                 P34-P35, P74-P75
#                 R31
#                 P76
#                 R30
#          ZFLY
#                 BURN, BABY, BURN -- MASTER IGNITION ROUTINE
#                 P40-P47
#                 THE LUNAR LANDING
#                 THROTTLE CONTROL ROUTINES
#                 LUNAR LANDING GUIDANCE EQUATIONS
#                 P70-P71
#                 P12
#                 ASCENT GUIDANCE
#                 SERVICER
#                 LANDING ANALOG DISPLAYS
#                 FINDCDUW - GUIDAP INTERFACE
#          LEMP50S
#                 P51-P53
#                 LUNAR AND SOLAR EPHEMERIDES SUBROUTINES
#          SKIPPER
#                 DOWN-TELEMETRY PROGRAM
#                 INTER-BANK COMMUNICATION
#                 INTERPRETER
#                 FIXED-FIXED CONSTANT POOL
#                 INTERPRETIVE CONSTANTS
#                 SINGLE PRECISION SUBROUTINES
#                 EXECUTIVE
#                 WAITLIST
#                 LATITUDE LONGITUDE SUBROUTINES
#                 PLANETARY INERTIAL ORIENTATION
#                 MEASUREMENT INCORPORATION
#                 CONIC SUBROUTINES
#                 INTEGRATION INITIALIZATION
#                 ORBITAL INTEGRATION
#                 INFLIGHT ALIGNMENT ROUTINES
#                 POWERED FLIGHT SUBROUTINES
#                 TIME OF FREE FALL
#                 AGC BLOCK TWO SELF-CHECK
#                 PHASE TABLE MAINTENANCE
## Page 4
#                 RESTARTS ROUTINE
#                 IMU MODE SWITCHING ROUTINES
#                 KEYRUPT, UPRUPT
#                 DISPLAY INTERFACE ROUTINES
#                 SERVICE ROUTINES
#                 ALARM AND ABORT
#                 UPDATE PROGRAM
#                 RTB OP CODES
#          ZLMDAP1
#                 T6-RUPT PROGRAMS
#                 DAP INTERFACE SUBROUTINES
#                 DAPIDLER PROGRAM
#                 P-AXIS RCS AUTOPILOT
#                 Q,R-AXIS RCS AUTOPILOT
#                 TJET LAW
#                 KALMAN FILTER
#                 TRIM GIMBAL CONTROL SYSTEM
#                 AOSTASK AND AOSJOB
#                 SPS BACK-UP RCS CONTROL


#          SYMBOL TABLE LISTING
#          UNREFERENCED SYMBOL LISTING
#          ERASABLE & EQUALS CROSS-REFERENCE TABLE
#          SUMMARY OF SYMBOL TABLE LISTINGS
#          MEMORY TYPE & AVAILABLITY DISPLAY
#          COUNT TABLE
#          PARAGRAPHS GENERATED FOR THIS ASSEMBLY
#          OCTAL LISTING
#          OCCUPIED LOCATIONS TABLE
#          SUBROS CALLED & PROGRAM STATUS

## Page 5
#          VERB LIST FOR LUMINARY

# REGULAR VERBS

# 00 NOT IN USE
# 01 DISPLAY OCTAL COMP 1 IN R1
# 02 DISPLAY OCTAL COMP 2 IN R1
# 03 DISPLAY OCTAL COMP 3 IN R1
# 04 DISPLAY OCTAL COMP 1,2 IN R1,R2
# 05 DISPLAY OCTAL COMP 1,2,3 IN R1,R2,R3
# 06 DISPLAY DECIMAL IN R1 OR R1,R2 OR R1,R2,R3
# 07 DISPLAY DP DECIMAL IN R1,R2 (TEST ONLY)
# 08
# 09
# 10
# 11 MONITOR OCTAL COMP 1 IN R1
# 12 MONITOR OCTAL COMP 2 IN R1
# 13 MONITOR OCTAL COMP 3 IN R1
# 14 MONITOR OCTAL COMP 1,2 IN R1,R2
# 15 MONITOR OCTAL COMP 1,2,3 IN R1,R2,R3
# 16 MONITOR DECIMAL IN R1 OR R1,R2 OR R1,R2,R3
# 17 MONITOR DP DECIMAL IN R1,R2 (TEST ONLY)
# 18
# 19
# 20
# 21 LOAD COMPONENT 1 INTO R1
# 22 LOAD COMPONENT 2 INTO R2
# 23 LOAD COMPONENT 3 INTO R3
# 24 LOAD COMPONENT 1,2 INTO R1,R2
# 25 LOAD COMPONENT 1,2,3 INTO R1,R2,R3
# 26
# 27 DISPLAY FIXED MEMORY
# 28
# 29
# 30 REQUEST EXECUTIVE
# 31 REQUEST WAITLIST
# 32 RECYCLE PROGRAM
# 33 PROCEED WITHOUT DSKY INPUTS
# 34 TERMINATE FUNCTION
# 35 TEST LIGHTS
# 36 REQUEST FRESH START
# 37 CHANGE PROGRAM (MAJOR MODE)
# 38
# 39

## Page 6
# EXTENDED VERBS

# 40 ZERO CDU-S
# 41 COARSE ALIGN CDU-S
# 42 FINE ALIGN IMU
# 43 LOAD IMU ATT ERROR METERS
# 44 TERMINATE RR CONTINUOUS DESIGNATE (V41N72 OPTION 2)
# 45
# 46
# 47 INITIALIZE AGS (R47)
# 48 REQUEST DAP DATA LOAD ROUTINE (R03)
# 49 REQUEST CREW DEFINED MANEUVER ROUTINE (R62)
# 50 PLEASE PERFORM
# 51
# 52 MARK X-RETICLE
# 53 MARK Y-RETICLE
# 54 MARK X OR Y-RETICLE
# 55 INCREMENT AGC TIME (DECIMAL)
# 56 TERMINATE TRACKING (P20 + P25)
# 57 PERMIT LANDING RADAR UPDATES
# 58 INHIBIT LANDING RADAR UPDATES
# 59 COMMAND LR TO POSITION 2.
# 60 DISPLAY VEHICLE ATTITUDE RATES ON FDAI ERROR NEEDLES.
# 61 DISPLAY DAP FOLLOWING ATTITUDE ERRORS.
# 62 DISPLAY TOTAL ATTITUDE ERRORS WITH RESPECT TO NOUN 22.
# 63 SAMPLE RADAR ONCE PER SECOND (R04).
# 64 REQUEST S-BAND ANTENNA ROUTINE (R05)
# 65 DISABLE U AND V JET FIRINGS DURING DPS BURNS.
# 66 VEHICLES ARE ATTACHED.  MOVE THIS VEHICLE STATE TO OTHER VEHICLE.
# 67 DISPLAY W MATRIX
# 68 DISABLE TERRAIN MODEL
# 69 CAUSE RESTART
# 70 UPDATE LIFTOFF TIME
# 71 UNIVERSAL UPDATE-BLOCK  ADR
# 72 UNIVERSAL UPDATE-SINGLE ADR
# 73 UPDATE AGC TIME (OCTAL)
# 74 INITIALIZE ERASABLE DUMP VIA DOWNLINK
# 75 ENABLE U AND V JET FIRINGS DURING DPS BURNS.
# 76 MINIMUM IMPULSE COMMAND MODE
# 77 RATE COMMAND AND ATTITUDE HOLD MODE
# 78 LR SPURIOUS RETURN TEST START (R77)
# 79 LR SPURIOUS RETURN TEST STOP
# 80 UPDATE LEM STATE VECTOR
# 81 UPDATE CSM STATE VECTOR
# 82 REQUEST ORBIT PARAM DISPLAY (R30)
# 83 REQUEST REND  PARAM DISPLAY (R31)
# 84
# 85 DISPLAY RR LOS AZ AND ELEV
# 86
# 87
## Page 7
# 88
# 89 REQUEST RENDEZVOUS FINAL ATTITUDE ROUTINE (R63)
# 90 REQUEST RENDEZVOUS OUT OF PLANE DISPLAY ROUTINE (R36)
# 91 DISPLAY BANK SUM
# 92 OPERATE IMU PERFORMANCE TEST (P07)
# 93 ENABLE W MATRIX INITIALIZATION
# 94
# 95 NO UPDATE OF EITHER STATE VECTOR (P20 OR P22)
# 96 INTERRUPT INTEGRATION AND GO TO POO
# 97 PERFORM ENGINE FAIL PROCEDURE
# 98
# 99 PLEASE ENABLE ENGINE

## Page 8
# IN THE FOLLOWING NOUN LIST THE :NO LOAD: RESTRICTION MEANS THE NOUN
# CONTAINS AT LEAST ONE COMPONENT WHICH CANNOT BE LOADED, I.E. OF
# SCALE TYPE L (MIN/SEC), PP (2 INTEGERS) OR TT (LANDING RADAR POSITION).
# IN THIS CASE VERBS 24 AND 25 ARE NOT ALLOWED, BUT VERBS 21, 22 OR 23
# MAY BE USED TO LOAD ANY OF THE NOUN:S COMPONENTS WHICH ARE NOT OF THE
# ABOVE SCALE TYPES.
# THE :DEC ONLY: RESTRICTION MEANS ONLY DECIMAL OPERATION IS ALLOWED ON
# EVERY COMPONENT IN THE NOUN. (NOTE THAT :NO LOAD: IMPLIES :DEC ONLY:.)

# NORMAL NOUNS                           COMPONENTS  SCALE AND DECIMAL POINT             RESTRICTIONS

# 00  NOT IN USE
# 01  SPECIFY MACHINE ADDRESS (FRACTIONAL)   3COMP   .XXXXX FOR EACH
# 02  SPECIFY MACHINE ADDRESS (WHOLE)        3COMP   XXXXX. FOR EACH
# 03  SPECIFY MACHINE ADDRESS (DEGREES)      3COMP   XXX.XX DEG FOR EACH
# 04  ANGULAR ERROR/DIFFERENCE               1COMP   XXX.XX DEG
# 05  ANGULAR ERROR/DIFFERENCE               1COMP   XXX.XX DEG
# 06  OPTION CODE                            3COMP   OCTAL ONLY FOR EACH
# LOADING NOUN 07 WILL SET OR RESET SELECTED BITS IN ANY ERASABLE REGISTER
# 07  ECADR OF WORD TO BE MODIFIED           3COMP   OCTAL ONLY FOR EACH
#     ONES FOR BITS TO BE MODIFIED
#     1 TO SET OR 0 TO RESET SELECTED BITS
# 08  ALARM DATA                             3COMP   OCTAL ONLY FOR EACH
# 09  ALARM CODES                            3COMP   OCTAL ONLY FOR EACH
# 10  CHANNEL TO BE SPECIFIED                1COMP   OCTAL ONLY
# 11  TIG OF CSI                             3COMP   00XXX. HRS                          DEC ONLY
#                                                    000XX. MIN                          MUST LOAD 3 COMPS
#                                                    0XX.XX SEC
# 12  OPTION CODE                            2COMP   OCTAL ONLY FOR EACH
#      (USED BY EXTENDED VERBS ONLY)
# 13  TIG OF CDH                             3COMP   00XXX. HRS                          DEC ONLY
#                                                    000XX. MIN                          MUST LOAD 3 COMPS
#                                                    0XX.XX SEC
# 14  CHECKLIST                              3COMP   XXXXX. FOR EACH
#      (USED BY EXTENDED VERBS ONLY)
#      (NOUN 25 IS PASTED AFTER DISPLAY)
# 15  INCREMENT MACHINE ADDRESS              1COMP   OCTAL ONLY
# 16  TIME OF EVENT                          3COMP   00XXX. HRS                          DEC ONLY
#      (USED BY EXTENDED VERBS ONLY)                 000XX. MIN                          MUST LOAD 3 COMPS
#                                                    0XX.XX SEC
# 17  SPARE
# 18  AUTO MANEUVER BALL ANGLES              3COMP   XXX.XX DEG FOR EACH
# 19  SPARE
# 20  ICDU ANGLES                            3COMP   XXX.XX DEG FOR EACH
# 21  PIPAS                                  3COMP   XXXXX. PULSES FOR EACH
# 22  NEW ICDU ANGLES                        3COMP   XXX.XX DEG FOR EACH
# 23  SPARE
# 24  DELTA TIME FOR AGC CLOCK               3COMP   00XXX. HRS                          DEC ONLY
#                                                    000XX. MIN                          MUST LOAD 3 COMPS
#                                                    0XX.XX SEC
## Page 9
# 25  CHECKLIST                              3COMP   XXXXX. FOR EACH
#      (USED WITH PLEASE PERFORM ONLY)
# 26  PRIORITY/DELAY, ADRES, BBCON           3COMP   OCTAL ONLY FOR EACH
# 27  SELF TEST ON/OFF SWITCH                1COMP   XXXXX.
# 28  SPARE
# 29  SPARE
# 30  SPARE
# 31  SPARE
# 32  TIME FROM PERIGEE                      3COMP   00XXX. HRS                          DEC ONLY
#                                                    000XX. MIN                          MUST LOAD 3 COMPS
#                                                    0XX.XX SEC
# 33  TIME OF IGNITION                       3COMP   00XXX. HRS                          DEC ONLY
#                                                    000XX. MIN                          MUST LOAD 3 COMPS
#                                                    0XX.XX SEC
# 34  TIME OF EVENT                          3COMP   00XXX. HRS                          DEC ONLY
#                                                    000XX. MIN                          MUST LOAD 3 COMPS
#                                                    0XX.XX SEC
# 35  TIME FROM EVENT                        3COMP   00XXX. HRS                          DEC ONLY
#                                                    000XX. MIN                          MUST LOAD 3 COMPS
#                                                    0XX.XX SEC
# 36  TIME OF AGC CLOCK                      3COMP   00XXX. HRS                          DEC ONLY
#                                                    000XX. MIN                          MUST LOAD 3 COMPS
#                                                    0XX.XX SEC
# 37  TIG OF TPI                             3COMP   00XXX. HRS                          DEC ONLY
#                                                    000XX. MIN                          MUST LOAD 3 COMPS
#                                                    0XX.XX SEC
# 38  TIME OF STATE BEING INTEGRATED         3COMP   00XXX. HRS                          DEC ONLY
#                                                    000XX. MIN                          MUST LOAD 3 COMPS
#                                                    0XX.XX SEC
# 39  SPARE

## Page 10
# MIXED NOUNS                            COMPONENTS  SCALE AND DECIMAL POINT             RESTRICTIONS

# 40  TIME FROM IGNITION/CUTOFF              3COMP   XXBXX  MIN/SEC                      NO LOAD, DEC ONLY
#     VG,                                            XXXX.X FT/SEC
#     DELTA V (ACCUMULATED)                          XXXX.X FT/SEC
# 41  TARGET  AZIMUTH,                       2COMP   XXX.XX DEG                          (FOR SYSTEM TEST)
#             ELEVATION                              XX.XXX DEG
# 42  APOGEE,                                3COMP   XXXX.X NAUT MI                      DEC ONLY
#     PERIGEE,                                       XXXX.X NAUT MI
#     DELTA V (REQUIRED)                             XXXX.X FT/SEC
# 43  LATITUDE,                              3COMP   XXX.XX DEG                          DEC ONLY
#     LONGITUDE,                                     XXX.XX DEG
#     ALTITUDE                                       XXXX.X NAUT MI
# 44  APOGEE,                                3COMP   XXXX.X NAUT MI                      NO LOAD, DEC ONLY
#     PERIGEE,                                       XXXX.X NAUT MI
#     TFF                                            XXBXX  MIN/SEC
# 45  MARKS,                                 3COMP   XXXXX.                              NO LOAD, DEC ONLY
#     TFI OF NEXT BURN                               XXBXX  MIN/SEC
#     MGA                                            XXX.XX DEG
# 46  AUTOPILOT CONFIGURATION                1COMP   OCTAL ONLY
# 47  LEM WEIGHT,                            2COMP   XXXXX. LBS                          DEC ONLY
#     CSM WEIGHT                                     XXXXX. LBS
# 48  GIMBAL PITCH TRIM,                     2COMP   XXX.XX DEG                          DEC ONLY
#     GIMBAL ROLL TRIM                               XXX.XX DEG
# 49  DELTA R,                               3COMP   XXXX.X NAUT MI                      DEC ONLY
#     DELTA V,                                       XXXX.X FT/SEC
#     RADAR DATA SOURCE CODE                         XXXXX.
# 50  SPARE
# 51  S-BAND ANTENNA ANGLES PITCH            2COMP   XXX.XX DEG                          DEC ONLY
#                           YAW                      XXX.XX DEG
# 52  CENTRAL ANGLE OF ACTIVE VEHICLE        1COMP   XXX.XX DEG
# 53  SPARE
# 54  RANGE,                                 3COMP   XXX.XX NAUT MI                      DEC ONLY
#     RANGE RATE,                                    XXXX.X FT/SEC
#     THETA                                          XXX.XX DEG
# 55  NO. OF APSIDAL CROSSINGS               3COMP   XXXXX.                              DEC ONLY
#     ELEVATION ANGLE                                XXX.XX DEG
#     CENTRAL ANGLE OF PASSIVE VEHICLE               XXX.XX DEG
# 56  RR LOS AZIMUTH                         2COMP   XXX.XX DEG
#            ELEVATION                               XXX.XX DEG
# 57  SPARE
# 58  PERIGEE ALT (POST TPI)                 3COMP   XXXX.X NAUT MI                      DEC ONLY
#     DELTA V TPI                                    XXXX.X FT/SEC
#     DELTA V TPF                                    XXXX.X FT/SEC
# 59  DELTA VELOCITY LOS                     3COMP   XXXX.X FT/SEC FOR EA.               DEC ONLY
# 60  FORWARD VELOCITY - LPD ANGLE           3COMP   XXBXX                                       NO LOAD, DEC ONLY
#     ALTITUDE RATE                                  XXXX.X FT/SEC
#     COMPUTED ALTITUDE                              XXXXX. FEET
# 61  TIME TO GO IN BRAKING PHASE            3COMP   XXBXX  MIN/SEC                      NO LOAD, DEC ONLY
#     TIME FROM IGNITION                             XXBXX  MIN/SEC
## Page 11
#     CROSS RANGE DISTANCE                           XXXX.X NAUT MI
# 62  ABSOLUTE VALUE OF VELOCITY             3COMP   XXXX.X FT/SEC                       NO LOAD, DEC ONLY
#     TIME FROM IGNITION                             XXBXX  MIN/SEC
#     DELTA V (ACCUMULATED)                          XXXX.X FT/SEC
# 63  ABSOLUTE VALUE OF VELOCITY             3COMP   XXXX.X FT/SEC                       DEC ONLY
#     ALTITUDE RATE                                  XXXX.X FT/SEC
#     COMPUTED ALTITUDE                              XXXXX. FEET
# 64  TIME LEFT FOR REDESIGNATION- LPD ANGLE 3COMP   XXBXX                               NO LOAD, DEC ONLY
#     ALTITUDE RATE                                  XXXX.X FT/SEC
#     COMPUTED ALTITUDE                              XXXXX. FEET
# 65  SAMPLED AGC TIME                       3COMP   00XXX. HRS                          DEC ONLY
#      (FETCHED IN INTERRUPT)                        000XX. MIN                          MUST LOAD 3 COMPS
#                                                    0XX.XX SEC
# 66  LR RANGE                               2COMP   XXXXX. FEET                         NO LOAD, DEC ONLY
#        POSITION                                    +0000X
# 67  LRVX                                   3COMP   XXXXX. FT/SEC
#     LRVY                                           XXXXX. FT/SEC
#     LRVZ                                           XXXXX. FT/SEC
# 68  SLANT RANGE TO LANDING SITE            3COMP   XXXX.X NAUT MI                      NO LOAD, DEC ONLY
#     TIME TO GO IN BRAKING PHASE                    XXBXX  MIN/SEC
#     LR ALTITUDE - COMPUTED ALTITUDE                XXXXX. FEET
# 69  LANDING SITE CORRECTION, Z-COMPONENT   3COMP   XXXXX. FEET                         DEC ONLY
#     LANDING SITE CORRECTION, Y-COMPONENT           XXXXX. FEET
#     LANDING SITE CORRECTION, X-COMPONENT           XXXXX. FEET
# 70  AOT DETENT CODE/STAR CODE              3COMP   OCTAL ONLY FOR EACH
# 71  AOT DETENT CODE/STAR CODE              3COMP   OCTAL ONLY FOR EACH
# 72  RR  360 - TRUNNION ANGLE               2COMP   XXX.XX DEG
#         SHAFT ANGLE                                XXX.XX DEG
# 73  NEW RR  360 - TRUNNION ANGLE           2COMP   XXX.XX DEG
#             SHAFT ANGLE                            XXX.XX DEG
# 74  TIME FROM IGNITION                     3COMP   XXBXX  MIN/SEC                      NO LOAD, DEC ONLY
#     YAW AFTER VEHICLE RISE                         XXX.XX DEG
#     PITCH AFTER VEHICLE RISE                       XXX.XX DEG
# 75  DELTA ALTITUDE CDH                     3COMP   XXXX.X NAUT MI                      NO LOAD, DEC ONLY
#     DELTA TIME (CDH-CSI OR TPI-CDH)                XXBXX  MIN/SEC
#     DELTA TIME (TPI-CDH OR TPI-NOMTPI)             XXBXX  MIN/SEC
# 76  DESIRED HORIZONTAL VELOCITY            3COMP   XXXX.X FT/SEC                       DEC ONLY
#     DESIRED RADIAL VELOCITY                        XXXX.X FT/SEC
#     CROSS-RANGE DISTANCE                           XXXX.X NAUT MI
# 77  TIME TO ENGINE CUTOFF                  2COMP   XXBXX  MIN/SEC                      NO LOAD, DEC ONLY
#     VELOCITY NORMAL TO CSM PLANE                   XXXX.X FT/SEC 
# 78  RR RANGE                               3COMP   XXX.XX NAUT MI                      NO LOAD, DEC ONLY
#        RANGE RATE                                  XXXX.X FT/SEC
#     TIME FROM  IGNITION                            XXBXX  MIN/SEC
# 79  CURSOR ANGLE                           3COMP   XXX.XX DEG                          DEC ONLY
#     SPIRAL ANGLE                                   XXX.XX DEG
#     POSITION CODE                                  XXXXX.
# 80  DATA INDICATOR,                        2COMP   XXXXX.
#     OMEGA                                          XXX.XX DEG
# 81  DELTA V (LV)                           3COMP   XXXX.X FT/SEC FOR EACH              DEC ONLY
## Page 12
# 82  DELTA V (LV)                           3COMP   XXXX.X FT/SEC FOR EACH              DEC ONLY
# 83  DELTA V (BODY)                         3COMP   XXXX.X FT/SEC FOR EACH              DEC ONLY
# 84  DELTA V (OTHER VEHICLE)                3COMP   XXXX.X FT/SEC FOR EACH              DEC ONLY
# 85  VG (BODY)                              3COMP   XXXX.X FT/SEC FOR EACH              DEC ONLY
# 86  VG (LV)                                3COMP   XXXX.X FT/SEC FOR EACH              DEC ONLY
# 87  BACKUP OPTICS LOS AZIMUTH              2COMP   XXX.XX DEG
#                      ELEVATION                     XXX.XX DEG
# 88  HALF UNIT SUN OR PLANET VECTOR         3COMP   .XXXXX FOR EACH                     DEC ONLY
# 89  LANDMARK LATITUDE                      3COMP   XX.XXX DEG                          DEC ONLY
#              LONGITUDE/2                           XX.XXX DEC
#              ALTITUDE                              XXX.XX NAUT MI
# 90  Y                                      3COMP   XXX.XX NM                           DEC ONLY
#     Y DOT                                          XXXX.X FPS
#     PSI                                            XXX.XX DEG
# 91  ALTITUDE                               3COMP   XXXXXB. NAUT MI
#     VELOCITY                                       XXXXX.  FT/SEC
#     FLIGHT PATH ANGLE                              XXX.XX  DEG
# 92  PCT FTP(10,5KLB) AT PRESENT THRUST     3COMP   XXXXX.
#     ALTITUDE RATE                                  XXXX.X FT/SEC
#     COMPUTED ALTITUDE                              XXXXX.FEET
# 93  DELTA GYRO ANGLES                      3COMP   XX.XXX DEG FOR EACH
# 94  SPARE
# 95  SPARE
# 96  SPARE
# 97  SYSTEM TEST INPUTS                     3COMP   XXXXX. FOR EACH
# 98  SYSTEM TEST RESULTS AND INPUTS         3COMP   XXXXX.
#                                                    .XXXXX
#                                                    XXXXX.
# 99  RMS IN POSITION                        3COMP   XXXXX.FT                            DEC ONLY
#     RMS IN VELOCITY                                XXXX.X FT/SEC
#     RMS IN BIAS                                    XX.XXX RADIANS

## Page 13
# REGISTERS AND SCALING  FOR NORMAL NOUNS

# NOUN            REGISTER        SCALE TYPE

# 00       NOT IN USE
# 01       SPECIFY ADDRESS        B
# 02       SPECIFY ADDRESS        C
# 03       SPECIFY ADDRESS        D
# 04              DSPTEM1         H
# 05              DSPTEM1         H
# 06              OPTION1         A
# 07              XREG            A
# 08              ALMCADR         A
# 09              FAILREG         A
# 10       SPECIFY CHANNEL        A
# 11              TCSI            K
# 12              OPTIONX         A
# 13              TCDH            K
# 14              DSPTEMX         C
# 15       INCREMENT ADDRESS      A
# 16              DSPTEMX         K
# 17       SPARE
# 18              FDAIX           D
# 19       SPARE
# 20              CDUX            D
# 21              PIPAX           C
# 22              THETAD          D
# 23       SPARE
# 24              DSPTEM2 +1      K
# 25              DSPTEM1         C
# 26              DSPTEM1         A
# 27              SMODE           C
# 28       SPARE
# 29       SPARE
# 30       SPARE
# 31       SPARE
# 32              -TPER           K
# 33              TIG             K
# 34              DSPTEM1         K
# 35              TTOGO           K
# 36              TIME2           K
# 37              TTPI            K
# 38              TET             K
# 39       SPARE

## Page 14
# REGISTERS AND SCALING FOR MIXED NOUNS

# NOUN     COMP   REGISTER        SCALE TYPE

# 40       1      TTOGO           L
#          2      VGDISP          S
#          3      DVTOTAL         S
# 41       1      DSPTEM1         D
#          2      DSPTEM1 +1      E
# 42       1      HAPO            Q
#          2      HPER            Q
#          3      VGDISP          S
# 43       1      LAT             H
#          2      LONG            H
#          3      ALT             Q
# 44       1      HAPOX           Q
#          2      HPERX           Q
#          3      TFF             L
# 45       1      TRKMKCNT        C
#          2      TTOGO           L
#          3      +MGA            H
# 46       1      DAPDATR1        A
# 47       1      LEMMASS         KK
#          2      CSMMASS         KK
# 48       1      PITTIME         NN
#          2      ROLLTIME        NN
# 49       1      R22DISP         Q
#          2      R22DISP +2      S
#          3      WHCHREAD        C
# 50       SPARE
# 51       1      ALPHASB         H
#          2      BETASB          H
# 52       1      ACTCENT         H
# 53       SPARE
# 54       1      RANGE           JJ
#          2      RRATE           S
#          3      RTHETA          H
# 55       1      NN              C
#          2      ELEV            H
#          3      CENTANG         H
# 56       1      RR-AZ           H
#          2      RR-ELEV         H
# 57       SPARE
# 58       1      POSTTPI         Q
#          2      DELVTPI         S
#          3      DELVTPF         S
# 59       1      DVLOS           S
#          2      DVLOS +2        S
#          3      DVLOS +4        S
# 60       1      FORVEL          ZZ
## Page 15
#          2      HDOTDISP        S
#          3      ALTITUDE        BBB
# 61       1      TTFDISP         L
#          2      TTOGO           L
#          3      OUTOFPLN        QQ
# 62       1      ABVEL           S
#          2      TTOGO           L
#          3      DVTOTAL         S
# 63       1      ABVEL           S
#          2      HDOTDISP        S
#          3      HCALC1          RR
# 64       1      FUNNYDSP        PP
#          2      HDOTDISP        S
#          3      HCALC           RR
# 65       1      SAMPTIME        K
#          2      SAMPTIME        K
#          3      SAMPTIME        K
# 66       1      RSTACK +6       W
#          2      CHANNEL  33     TT
# 67       1      RSTACK          X
#          2      RSTACK +2       Y
#          3      RSTACK +4       Z
# 68       1      RANGEDSP        QQ
#          2      TTFDISP         L
#          3      DELTAH          RR
# 69       1      DLANDZ          RR
#          2      DLANDY          RR
#          3      DLANDX          RR
# 70       1      AOTCODE         A
#          2      AOTCODE +1      A
#          3      AOTCODE +2      A
# 71       1      AOTCODE         A
#          2      AOTCODE +1      A
#          3      AOTCODE +2      A
# 72       1      CDUT            WW
#          2      CDUS            D
# 73       1      TANG            WW
#          2      TANG +1         D
# 74       1      TTOGO           L
#          2      YAW             H
#          3      PITCH           H
# 75       1      DIFFALT         Q
#          2      T1TOT2          L
#          3      T2TOT3          L
# 76       1      ZDOTD           S
#          2      RDOTD           S
#          3      XRANGE          Q
# 77       1      TTOGO           L
#          2      YDOT            S
# 78       1      DNRRANGE        U
## Page 16
#          2      DNRRDOT         V
#          3      TTOTIG          L
# 79       1      CURSOR          D
#          2      SPIRAL          D
#          3      POSCODE         C
# 80       1      DATAGOOD        C
#          2      OMEGAD          H
# 81       1      DELVLVC         S
#          2      DELVLVC +2      S
#          3      DELVLVC +4      S
# 82       1      DELVLVC         S
#          2      DELVLVC +2      S
#          3      DELVLVC +4      S
# 83       1      DELVIMU         S
#          2      DELVIMU +2      S
#          3      DELVIMU +4      S
# 84       1      DELVOV          S
#          2      DELVOV +2       S
#          3      DELVOV +4       S
# 85       1      VGBODY          S
#          2      VGBODY +2       S
#          3      VGBODY +4       S
# 86       1      DELVLVC         S
#          2      DELVLVC +2      S
#          3      DELVLVC +4      S
# 87       1      AZ              D
#          2      EL              D
# 88       1      STARAD          B
#          2      STARAD +2       B
#          3      STARAD +4       B
# 89       1      LANDLAT         G
#          2      LANDLONG        G
#          3      LANDALT         JJ
# 90       1      RANGE           JJ
#          2      RRATE           S
#          3      RTHETA          H
# 91       1      P21ALT          Q (MEMORY/100 TO DIPLAY TENS N.M.)
#          2      P21VEL          P
#          3      P21GAM          H
# 92       1      THRDISP         C
#          2      HDOTDISP        S
#          3      HCALC1          RR
# 93       1      OGC             G
#          2      OGC +2          G
#          3      OGC +4          G
# 94       SPARE
# 95       SPARE
# 96       SPARE
# 97       1      DSPTEM1         C
#          2      DSPTEM1 +1      C
## Page 17
#          3      DSPTEM1 +2      C
# 98       1      DSPTEM2         C
#          2      DSPTEM2 +1      B
#          3      DSPTEM2 +2      C
# 99       1      WWPOS           XX
#          2      WWVEL           YY
#          3      WWBIAS          AAA

## Page 18
# NOUN SCALES AND FORMATS

# -SCALE TYPE-                        PRECISION
# UNITS                DECIMAL FORMAT        -- AGC FORMAT
# ------------         --------------        -- ----------

# -A-
# OCTAL                XXXXX                 SP OCTAL

# -B-                                                    -14
# FRACTIONAL           .XXXXX                SP BIT 1 = 2    UNITS
#                      (MAX .99996)

# -C-
# WHOLE                XXXXX.                SP BIT 1 = 1 UNIT
#                      (MAX 16383.)

# -D-                                                        15
# CDU DEGREES          XXX.XX DEGREES        SP BIT 1 = 360/2   DEGREES
#                      (MAX 359.99)             (USES 15 BITS FOR MAGNI-
#                                                TUDE AND 2-S COMP.)

# -E-                                                       14
# ELEVATION DEGREES    XX.XXX DEGREES        SP BIT 1 = 90/2   DEGREES
#                      (MAX 89.999)

# -F-                                                        14
# DEGREES (180)        XXX.XX DEGREES        SP BIT 1 = 180/2   DEGREES
#                      (MAX 179.99)

# -G-
# DP DEGREES(90)       XX.XXX DEGREES        DP BIT 1 OF LOW REGISTER =
#                                                    28
#                                               360/2   DEGREES

# -H-
# DP DEGREES (360)     XXX.XX DEGREES        DP BIT 1 OF LOW REGISTER =
#                                                    28
#                      (MAX 359.99)             360/2   DEGREES

## Page 19
# -K-
# TIME (HR, MIN, SEC)  00XXX. HR             DP BIT 1 OF LOW REGISTER =
#                      000XX. MIN                 -2
#                      0XX.XX SEC               10   SEC
#                      (DECIMAL ONLY.
#                      MAX MIN COMP=59
#                      MAX SEC COMP=59.99
#                      MAX CAPACITY=745 HRS
#                                    39 MINS
#                                    14.55 SECS.
#                      WHEN LOADING, ALL 3
#                      COMPONENTS MUST BE
#                      SUPPLIED.)

# -L-
# TIME (MIN/SEC)       XXBXX MIN/SEC         DP BIT 1 OF LOW REGISTER =
#                      (B IS A BLANK              -2
#                      POSITION, DECIMAL        10   SEC
#                      ONLY, DISPLAY OR
#                      MONITOR ONLY. CANNOT
#                      BE LOADED.
#                      MAX MIN COMP=59
#                      MAX SEC COMP=59
#                      VALUES GREATER THAN
#                      59 MIN 59 SEC
#                      ARE DISPLAYED AS
#                      59 MIN 59 SEC.)

# -M-                                                     -2
# TIME (SEC)           XXX.XX SEC            SP BIT 1 = 10   SEC
#                      (MAX 163.83)

# -N-
# TIME(SEC) DP         XXX.XX SEC            DP BIT 1 OF LOW REGISTER =
#                                                 -2
#                                               10   SEC

# -P-
# VELOCITY 2           XXXXX. FEET/SEC       DP BIT 1 OF HIGH REGISTER =
#                      (MAX 41994.)              -7
#                                               2   METERS/CENTI-SEC

# -Q-
# POSITION 4           XXXX.X NAUTICAL MILES DP BIT 1 OF LOW REGISTER =
#                                               2 METERS

# -S-
# VELOCITY 3           XXXX.X FT/SEC         DP BIT 1 OF HIGH REGISTER =
#                                                -7
#                                               2   METERS/CENTI-SEC

## Page 20
# -T-                                                     -2
# G                    XXX.XX G              SP BIT 1 = 10   G
#                      (MAX 163.83)

# -U-
# RENDEZVOUS           XXX.XX NAUT MI        SP USES 15 BITS FOR UNSIGNED
# RADAR RANGE          (DECIMAL ONLY.           MAGNITUDE.
#                      DISPLAY OR MONITOR       BIT 1 = 9.38 FEET
#                      ONLY. CANNOT BE
#                      LOADED.)

# -V-
# RENDEZVOUS           XXXX.X FEET/SEC       SP USES 15 BITS FOR UNSIGNED
# RADAR RANGE RATE     (DECIMAL ONLY.           MAGNITUDE.
#                      DISPLAY OR MONITOR       BIT 1 = -.6278 FEET/SEC
#                      ONLY. CANNOT BE
#                      LOADED.
#                      BIAS OF 17000 COUNTS
#                      SUBTRACTED BEFORE
#                      DISPLAY.)

# -W-
# LANDING RADAR        XXXXX. FEET           DP LOW ORDER BIT OF LOW ORDER
# ALTITUDE                                      WORD = 1.079 FEET

# -X-
# LANDING RADAR        XXXXX. FEET/SEC       DP LOW ORDER BIT OF LOW ORDER
# VELX                                          WORD = -.6440 FEET/SEC

# -Y-
# LANDING RADAR        XXXXX. FEET/SEC       DP LOW ORDER BIT OF LOW ORDER
# VELY                                          WORD = 1.212  FEET/SEC

# -Z-
# LANDING RADAR        XXXXX. FEET/SEC       DP LOW ORDER BIT OF LOW ORDER
# VELZ                                          WORD = .8668  FEET/SEC

# -AA-
# INITIAL/FINAL        XXXXX. FEET           DP LOW ORDER BIT OF LOW ORDER
# ALTITUDE                                      WORD = 2.345 FEET

# -BB-
# ALTITUDE RATE        XXXXX. FEET/SEC       SP LOW ORDER BIT = .5
#                      (MAX 08191.)             FEET/SEC

# -CC-
# FORWARD/LATERAL      XXXX.X FEET/SEC       SP LOW ORDER BIT = .5571
# VELOCITY             (MAX 09126.)             FEET/SEC

# -DD-
## Page 21
# ROTATIONAL HAND      XXXXX. DEG/SEC        SP FRACTIONAL PART OF PI RAD
# CONTROLLER ANGULAR   (MAX 00044.)                                4  SEC
# RATES

# -EE-
# OPTICAL TRACKER      XXX.XX DEG.           DP LOW ORDER BIT OF LOW ORDER
# AZIMUTH ANGLE                                             15
#                                               WORD = 360/2   DEGREES

# -JJ-
# POSITION5            XXX.XX NAUT MI        DP BIT 1 OF LOW REGISTER =
#                                               2 METERS

# -KK-                                                              16
# WEIGHT2              XXXXX. LBS            SP FRACTIONAL PART OF 2   KG

# -NN-
# TRIM DEGREES 2       XXX.XX DEG            SP BIT 1=.01SEC(TIME)
#                      (MAX 032.76)

# -PP-
# 2 INTEGERS           +XXBYY                DP BIT 1 OF HIGH REGISTER =
#                      (B IS A BLANK             1 UNIT OF XX
#                      POSITION. DECIMAL        BIT 1 OF LOW REGISTER =
#                      ONLY, DISPLAY OR          1 UNIT OF YY
#                      MONITOR ONLY. CANNOT     (EACH REGISTER MUST
#                      BE LOADED.)              CONTAIN A POSITIVE INTEGER
#                      (MAX 99B99)               LESS THAN 100)

# -QQ-
# POSITION7            XXXX.X NAUT MI        DP BIT 1 OF LOW REGISTER =
#                      (MAX 9058.9)              -4
#                                               2   METERS

# -RR-
# COMPUTED ALTITUDE    XXXXX. FEET           DP BIT 1 OF LOW REGISTER =
#                                                -4
#                                               2   METERS

# -SS-
# DP DEGREES           XXXX.X DEGREES        DP BIT 1 OF HIGH REGISTER =
#                                               1 DEGREE

# -TT-
# LANDING RADAR        +0000X                CHANNEL 33,BIT 6=NOT POSIT. 1
# POSITION             (DECIMAL ONLY.        CHANNEL 33,BIT 7=NOT POSIT. 2
#                      DISPLAY OR MONITOR    X = 1 FOR LR POSITION 1
#                      ONLY. CANNOT BE       X = 2 FOR LR POSITION 2
#                      LOADED.)

# -WW-								    15
## Page 22
# 360-CDU DEGREES      XXX.XX DEGREES        SP BIT 1 = 360 - (360/2  )
#                      (MAX 359.99)             DEGREES
#                                               (USES 15 BITS FOR MAGNI-
#                                                TUDE AND 2-S COMP.)

# -XX-
# POSITION 9           XXXXX. FEET           DP BIT 1 OF LOW REGISTER =
#                                                -9
#                                               2   METERS

# -YY-
# VELOCITY 4           XXXX.X FEET/SEC       DP FRACTIONAL PART OF
#                      (MAX 328.0)              METERS/CENTI-SEC

# -ZZ-
# VELOCITY5            XXXX.X FT/SEC         DP BIT 1 OF HIGH REGISTER =
#                                                -9
#                                               2   METERS/CENTI-SEC

# -AAA-
# RADIANS              XX.XXX RADIANS        DP BIT 1 OF HIGH REGISTER =
#                      (MAX 31.999)              -9
#                                               2   RADIANS

# -BBB-
# COMPUTED ALTITUDE 2  XXXXX. FEET           DP BIT 1 OF HIGH REGISTER =
#                                               2 METERS

# THAT-S ALL ON THE NOUNS.

## Page 23
#          ALARM CODES FOR LUMINARY

# *9       *18                                       *60   COLUMN

# CODE   * TYPE                                      SET BY

# 00107    MORE THAN 5 MARK PAIRS                    AOTMARK
# 00111    MARK MISSING                              AOTMARK
# 00112    MARK OR MARK REJECT NOT BEING ACCEPTED    AOTMARK
# 00113    NO INBITS                                 AOTMARK
# 00114    MARK MADE BUT NOT DESIRED                 AOTMARK
# 00115    NO MARKS IN LAST PAIR TO REJECT           AOTMARK
# 00206    ZERO ENCODE NOT ALLOWED WITH COARSE ALIGN IMU MODE SWITCHING
# 00206     + GIMBAL LOCK.
# 00207    ISS TURNON REQUEST NOT PRESENT FOR 90 SEC T4RUPT
# 00210    IMU NOT OPERATING                         IMU MODE SWITCH, IMU-2, R02, P51, P57
# 00211    COARSE ALIGN ERROR                        IMU MODE SWITCH
# 00212    PIPA FAIL BUT PIPA IS NOT BEING USED      IMU MODE SWITCH,T4RPT
# 00213    IMU NOT OPERATING WITH TURN-ON REQUEST    T4RUPT
# 00214    PROGRAM USING IMU WHEN TURNED OFF         T4RUPT
# 00217    BAD RETURN FROM IMUSTALL                  P51,P52,P57
# 00220    IMU NOT ALIGNED - NO REFSMMAT             R02,R47
# 00401    DESIRED GIMBAL ANGLE YIELDS GIMBAL LOCK   INF ALIGN, IMU-2,
#                                                    FINDCDUW
# 00402    FINDCDUW NOT CONTROLLING ATTITUDE         FINDCDUW
# 00404    TWO STARS NOT AVAILABLE IN ANY DETENT     R59, LUNAR SURFACE
# 00405    TWO STARS NOT AVAILABLE                   P52
# 00421    W-MATRIX OVERFLOW                         INTEGRV
# 00501  P RADAR ANTENNA OUT OF LIMITS               R23
# 00502    BAD RADAR GIMBAL ANGLE INPUT              V41N72
# 00503  P RADAR ANTENNA DESIGNATE FAIL              R21, NON-P IN V41N72
# 00510    RADAR AUTO DESCRETE NOT PRESENT           R25
# 00511    LR ANTENNA MOVED AND NOT REPOSITIONED     SERVICER
# 00514  P RR GOES OUT OF AUTO MODE WHILE IN USE     P20
# 00515    RR CDU FAIL DISCRETE PRESENT              R25
# 00520    RADAR RUPT NOT EXPECTED AT THIS TIME      RADAR READ
# 00522    LANDING RADAR POSITION CHANGE             R04
# 00523    LR ANTENNA DIDN'T ACHIEVE POSITION 2      V59                  IN V60)
# 00525  P DELTA THETA GREATER THAN 3 DEGREES        R22
# 00526    RANGE GREATER THAN 400 NAUTICAL MILES     P20
# 00527  P LOS NOT IN MODE II COVERAGE WHILE ON      R21,R24
#          LUNAR SURFACE
#          OR VEHICLE MANEUVER REQUIRED              R24 (20)
# 00530  P LOS NOT IN MODE2 COVERAGE                 R21
#          ON LUNAR SURFACE AFTER 600 SECS.
# 00555    SERVICER LOOP EXCEEDED 4 SECONDS          SERVICER
# 00600    IMAGINARY ROOTS ON FIRST ITERATION        P32, P72
# 00601    PERIGEE ALTITUDE CSI LT PMIN1             P32,P72,
# 00602    PERIGEE ALTITUDE CDH LT PMIN2             P32,P72,
# 00603    CSI TO CDH TIME LT TMIN12                 P32,P72,P33,P73
## Page 24
# 00604    CDH TO TPI TIME LT TMIN23                 P32,P72,
# OR COMPUTED CDH TIME GREATER THAN INPUT TP1 TIME
# 00605    NUMBER OF ITERATIONS EXCEEDS LOOP MAXIMUM P32, P72
# 00606    DV EXCEEDS MAXIMUM                        P32,P72,
# 00611    NO TIG FOR GIVEN ELEV ANGLE               P34,P74
# 00701    ILLEGAL OPTION CODE SELECTED              P57
# 00777    PIPA FAIL CAUSED THE ISS WARNING          T4RUPT
# 01102    AGC SELF TEST ERROR                       SELF CHECK
# 01105    DOWNLINK TOO FAST                         T4RUPT
# 01106    UPLINK TOO FAST                           T4RUPT
# 01107    PHASE TABLE FAILURE.  ASSUME              RESTART
#          ERASABLE MEMORY IS SUSPECT.               RESTART
# 01301    ARCSIN-ARCCOS ARGUMENT TOO LARGE          INTERPRETER
# 01406    BAD RETURN FROM ROOTPSRS                  DESCENT GUIDANCE EQS.
# 01407    VG INCREASING (DELTA-V ACCUMULATED        S40.8
#          .GT. 90 DEGREES AWAY FROM DESIRED THRUST  S40.8
#          VECTOR.)                                  S40.8
# 01410    UNINTENTIONAL OVERFLOW IN GUIDANCE        DESCENT GUIDANCE EQS.
# 01412    DESCENT IGNALG NOT CONVERGING             P63
# 01520    V37 REQUEST NOT PERMITTED AT THIS TIME    V37
# 01600    OVERFLOW IN DRIFT TEST                    IMU 4
# 01601    BAD IMU TORQUE                            OPT PRE ALIGN CALIB
# 01601                                              IMU 4 (LEM)
# 01703    IGNITION TIME SLIPPED                     MIDTOAVE
# 01706    INCORRECT PROGRAM REQUESTED FOR VEHICLE
#          CONFIGURATION                             P40, P42
# 02001    JET FAILURES HAVE DISABLED Y-Z TRANS.     DAP
# 02002    JET FAILURES HAVE DISABLED X TRANSLATION  DAP
# 02003    JET FAILURES HAVE DISABLED P-ROTATION     DAP
# 02004    JET FAILURES HAVE DISABLED U-V ROTATION   DAP
# 03777    ICDU FAIL CAUSED THE ISS WARNING          T4RUPT
# 04777    ICDU , PIPA FAILS CAUSED THE ISS WARNING  T4RUPT
# 07777    IMU FAIL CAUSED THE ISS WARNING           T4RUPT
# 10777    IMU , PIPA FAILS CAUSED THE ISS WARNING   T4RUPT
# 13777    IMU , ICDU  FAILS CAUSED THE ISS WARNING  T4RUPT
# 14777    IMU,ICDU,PIPA FAILS CAUSED ISS WARNING    T4RUPT

# THE FOLLOWING CODES INDICATE THE MORE SERIOUS POODOO ABORTS THAT RESULT
# IN THE PROGRAM GOING TO ROO.

# 20105    AOTMARK SYSTEM IN USE                     AOTMARK
# 20430    ACCELERATION OVERFLOW IN INTEGRATION      ORBITAL INTEGRATION
# 20607    NO SOLN FROM TIME-THETA OR TIME-RADIUS    TIMETHET, TIMERAD
# 21103    UNUSED CCS BRANCH EXECUTED                ABORT
# 21204    WAITLIST, VARDELAY, FIXDELAY, OR LONGCALL   WAITLIST ROUTINES
#            CALLED WITH ZERO OR NEGATIVE DELTA-TIME
# 21302    SQRT CALLED WITH NEGATIVE ARGUMENT        INTERPRETER
# 21406    BAD RETURN FROM ROOTPSRS                  IGNITION ALGORITHMN
# 21501    KEYBOARD AND DISPLAY ALARM DURING         PINBALL
#            INTERNAL USE(NVSUB).ABORT
## Page 25
# THE FOLLOWING CODES INDICATE A BAILOUT ABORT THAT RESULTS IN A SOFTWARE
# RESTART
# 31104    DELAY ROUTINE BUSY                        EXEC
# 31201    EXECUTIVE OVERFLOW-NO VAC AREAS           EXEC
# 31202    EXECUTIVE OVERFLOW-NO CORE SETS           EXEC
# 31203    WAITLIST OVERFLOW-TOO MANY TASKS          WAITLIST
# 31206    SECOND JOB ATTEMPTS TO GO TO SLEEP VIA    PINBALL
#            KEYBOARD AND DISPLAY PROGRAM
# 31207    NO VAC AREAS FOR MARKS                    AOTMARK
# 31210    TWO PROGRAMS USING DEVICE AT SAME TIME    MODE SWITCHING
# 31211    ILLEGAL INTERRUPT OF EXTENDED VERB        AOTMARK
# 31502    TWO PRIO DISPLAYS WAITING                 DSP INTRFCE
# 32000    DAP STILL IN PROGRESS AT NEXT TIME5 RUPT  DAP

## Page 26
#          CHECKLIST CODES FOR LUMINARY

# *9      *17      *26                                                    *9   COLUMN

# R1CODE          ACTION TO BE EFFECTED                                   PROGRAM

# 00013   KEY IN   NORMAL OR GYRO TORQUE COARSE ALIGN                     P52
# 00014   PROCEED  DO IMU FINE ALIGN ROUTINE                              P51,P63,P57
# 00014   ENTER    DO LANDING SITE  DETERMINATION(N89DISP)                P57OPTION2
# 00015   PERFORM  CELESTIAL BODY ACQUISITION                             R51,P51
# 00062   SWITCH   AGC POWER DOWN                                         P06
# 00201   SWITCH   RR MODE TO AUTOMATIC                                   P20,P22,R04
# 00203    SWITCH  GUID CONTROL TO GNC, MODE TO AUTO...                   P12,P42,P71
#                  ALSO THR CONT TO AUTO                                  P40,P63,P70
# 00205   PERFORM  MANUAL ACQUISITION OF RR                               R23
# 00500   SWITCH   LR ANTENNA TO POSITION 1                               P63

#                    SWITCH DENOTES CHANGE POSITION OF A CONSOLE SWITCH
#                    PERFORM DENOTES START OR END OF A TASK
#                    KEY IN DENOTES KEY IN OF DATA THRU THE DSKY

## Page 27
#         OPTION CODES FOR LUMINARY

# THE SPECIFIED OPTION CODES WILL BE FLASHED IN COMPONENT R1 IN
# CONJUNCTION WITH V04N06 OR V04N12 (FOR EXTENDED VERBS) TO REQUEST THE
# ASTRONAUT TO LOAD INTO COMPONENT R2 THE OPTION HE DESIRES.

# *9      *17                                *52                            *11           *25   COLUMN

# OPTION
# CODE    PURPOSE                            INPUT FOR COMPONENT 2          PROGRAM(S)    APPLICABILITY

# 00001   SPECIFY IMU ORIENTATION            1=PREF 2=NOM 3=REFSMMAT        P52           ALL
#                                            4=LAND SITE
# 00002   SPECIFY VEHICLE                    1=THIS 2=OTHER                 P21,R30       ALL
# 00003   SPECIFY TRACKING ATTITUDE          1=PREFERRED 2=OTHER            R63           ALL
# 00004   SPECIFY RADAR                      1=RR 2=LR                      R04           SUNDANCE + LUMINARY
# 00005   SPECIFY SOR PHASE                  1=FIRST 2=SECOND               P38           COLOSSUS + LUMINARY
# 00006   SPECIFY RR COARSE ALIGN OPTION     1=LOCKON 2=CONTINUOUS DESIG.   V41N72        SUNDANCE + LUMINARY
# 00010   SPECIFY ALIGNMENT MODE             0=ANY TIME 1=REFSMMAT +G       P57           LUMINARY
#                                            2=TWO BODIES 3=ONE BODY + G
# 00012   SPECIFY CSM ORBIT OPTION           1=NO ORBIT CHANGE 2=CHANGE     P22           LUMINARY
#                                            ORBIT TO PASS OVER LM
