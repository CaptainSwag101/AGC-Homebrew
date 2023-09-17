### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    GROUND_TRACKING_DETERMINATION_PROGRAM_-_P21.agc
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
## Reference:   pp. 649-652
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2017-07-28 MAS  Created from Luminary 210.
##              2017-08-24 MAS  Updated for Zerlina 56.

## Page 649
# GROUND TRACKING DETERMINATION PROGRAM P21
# PROGRAM DESCRIPTION
# MOD NO - 1
# MOD BY - N.M.NEVILLE
# FUNCTIONAL DECRIPTION-
#
# TO PROVIDE THE ASTRONAUT DETAILS OF THE LM OR CSM GROUND TRACK WITHOUT
# THE NEED FOR GROUND COMMUNICATION (REQUESTED BY DSKY).
# CALLING SEQUENCE -
#
# ASTRONAUT REQUEST THROUGH DSKY V37E21E
# SUBROUTINES CALLED-
#
# GOPERF4
# GOFLASH
# THISPREC
# OTHPREC
# LAT-LONG
# NORMAL EXIT MODES-
#
# ASTRONAUT REQUEST TROUGH DSKY TO TERMINATE PROGRAM V34E
# ALARM OR ABORT EXIT MODES-
#
# NONE
# OUTPUT -
#
# OCTAL DISPLAY OF OPTION CODE AND VEHICLE WHOSE GROUND TRACK IS TO BE
# COMPUTED
#          OPTION CODE  00002
#          THIS         00001
#          OTHER        00002
# DECIMAL DISPLAY OF TIME TO BE INTEGRATED TO HOURS , MINUTES , SECONDS
# DECIMAL DISPLAY OF LAT,LONG,ALT
# ERASABLE INITIALIZATION REQUIRED
#
# AX0      2DEC   4.652459653 E-5   RADIANS       %68-69 CONSTANTS"
#
# -AY0     2DEC   2.147535898 E-5   RADIANS
#
# AZ0      2DEC   .7753206164       REVOLUTIONS
# FOR LUNAR ORBITS 504LM VECTOR IS NEEDED
#
# 504LM    2DEC   -2.700340600 E-5  RADIANS
#
# 504LM _2 2DEC   -7.514128400 E-4  RADIANS     
#
# 504LM _4 2DEC   _2.553198641 E-4  RADIANS     
#
# NONE
# DEBRIS
## Page 650
#
# CENTRALS-A,Q,L
# OTHER-THOSE USED BY THE ABOVE LISTED SUBROUTINES
# SEE LEMPREC,LAT-LONG
                SBANK=  LOWSUPER        # FOR LOW 2CADR'S.

                BANK    33
                SETLOC  P20S
                BANK

                EBANK=  P21TIME
                COUNT*  $$/P21
PROG21          CAF     ONE
                TS      OPTION2         # ASSUMED VEHICLE IS LM , R2 = 00001
                CAF     BIT2            #  OPTION 2
                TC      BANKCALL
                CADR    GOPERF4
                TC      GOTOPOOH        # TERMINATE
                TC      +2              # PROCEED VALUE OF ASSUMED VEHICLE OK
                TC      -5              # R2 LOADED THROUGH DSKY
                CAF     ZERO            # INITIAL TIME = PRESENT TIME
                TS      DSPTEM1
                TS      DSPTEM1 +1
P21PROG1        CAF     V6N34           # LOAD DESIRED TIME OF LAT-LONG.
                TC      BANKCALL
                CADR    GOFLASH
                TC      GOTOPOOH        # TERM
                TC      +2              # PROCEED VALUES OK
                TC      -5              # TIME LOADED THROUGH DSKY
                TC      INTPRET
                DLOAD   BZE
                        DSPTEM1
                        P21PRTM
P21PROG2        STCALL  TDEC1           # INTEG TO TIME SPECIFIED IN TDEC1
                        INTSTALL
                BON     CLEAR
                        P21FLAG
                        P21CONT         # ON---RECYCLE USING BASE VECTOR
                        VINTFLAG        # OFF--1ST PASS CALL BASE VECTOR
                SLOAD   SR1
                        OPTION2
                BHIZ    SET
                        +2              # ZERO--THIS VEHICLE(LM)
                        VINTFLAG        # ONE--OTHER VEHICLE(CM)
                CLEAR   CLEAR
                        DIM0FLAG
                        INTYPFLG        # PRECISION
                CALL
                        INTEGRV         # CALCULATE
                GOTO                    # -AND
## Page 651
                        P21VSAVE        # -SAVE BASE VECTOR
P21CONT         VLOAD
                        P21BASER        # RECYCLE--INTEG FROM BASE VECTOR
                STOVL   RCV             # --POS
                        P21BASEV
                STODL   VCV             # --VEL
                        P21TIME
                STORE   TET             # --TIME
                CLEAR   CLEAR
                        DIM0FLAG
                        MOONFLAG
                SLOAD   BZE
                        P21ORIG
                        +3              # ZERO=EARTH
                SET                     # ---2=MOON
                        MOONFLAG
 +3             CALL
                        INTEGRVS
P21VSAVE        DLOAD                   # SAVE CURRENT BASE VECTOR
                        TAT
                STOVL   P21TIME         # --TIME
                        RATT1
                STOVL   P21BASER        # --POS B-29 OR B-27
                        VATT1
                STORE   P21BASEV        # --VEL B-07 OR B-05
                ABVAL   SL*
                        0,2
                STOVL   P21VEL          # VEL/ FOR N91 DISP
                        RATT
                UNIT    DOT
                        VATT            #  U(R).V
                DDV     ASIN            # U(R).U(V)
                        P21VEL
                STORE   P21GAM          # SIN-1 U(R).U(V) , -90 TO &90
                SXA,2   SLOAD
                        P21ORIG         # 0=EARTH
                        OPTION2
                SR1     BHIZ
                        +3
                GOTO
                        +4
 +3             BON
                        SURFFLAG
                        P21DSP
 +4             SET
                        P21FLAG
P21DSP          CLEAR   SLOAD           # GENERATE DISPLAY DATA
                        LUNAFLAG
                        X2
## Page 652
                BZE     SET
                        +2              # 0=EARTH
                        LUNAFLAG
                VLOAD
                        RATT
                STODL   ALPHAV
                        TAT
                CLEAR   CALL
                        ERADFLAG
                        LAT-LONG
                DMP                     # MPAC = ALT,METERS B-29
                        K.01
                STORE   P21ALT          # ALT/100 FOR N91 DISP
                EXIT
                CAF     V06N43          # DISPLAY LAT,LONG,ALT
                TC      BANKCALL        # LAT,LONG = 1/2 REVS B0
                CADR    GOFLASH         # ALT = KM  B14
                TC      GOTOPOOH        # TERM
                TC      GOTOPOOH
                TC      INTPRET         # V32E RECYCLE
                DLOAD   DAD
                        P21TIME
                        600SEC          # 600 SECONDS OR 10 MIN
                STORE   DSPTEM1
                RTB
                        P21PROG1
P21PRTM         RTB     GOTO
                        LOADTIME
                        P21PROG2
600SEC          2DEC    60000           # 10 MIN

V06N43          VN      00643
V6N34           VN      00634
K.01            2DEC    .01

