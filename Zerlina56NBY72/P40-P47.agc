### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    P40-P47.agc
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
## Reference:   pp. 738-770
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2017-07-28 MAS  Created from Luminary 210.
##              2017-08-16 RSB  Fixed comment typo identified in AP11ROPE.
##              2017-08-26 MAS  Updated for Zerlina 56.
##              2021-05-30 ABS  TGDCALC -> TGOCALC

## Page 738
# PROGRAM DESCRIPTION  P40BOTH    DECEMBER 22, 1966
# MOD 03 BY PETER ADLER           MARCH 3, 1967
# CALLED VIA JOB FROM V37E

# FUNCTIONAL DESCRIPTION

#          1)  TO COMPUTE A PREFERRED IMU ORIENTATION AND A PREFERRED VEHICLE ATTITUDE FOR A LM DPS
#              THRUSTING MANEUVER.

## (There is no item #2 in the original program listing.)

#          3)  TO DO THE VEHICLE MANEUVER TO THE THRUSTING ATTITUDE.

#          4)  TO CONTROL THE PGNCS DURING COUNTDOWN, IGNITION, THRUSTING, AND THRUST TERMINATION OF A
#              PGNCS CONTROLLED DPS MANEUVER.

#          5)  IN POSTBURN--ZERO RENDEZVOUS COUNTER, MAINTAIN VG CALCULATIONS FOR POSSIBLE RCS MANEUVER,
#                           SET MAXIMUM DEADBAND IN DAP, RESET STEERLAW CSTEER TO ZERO.

#          NOTE:  P42, WHICH IS IN THIS LOG SECTION, DOES THE SAME FOR AN APS BURN, AND P41 DOES 1-3 FOR
#                 RCS PLUS DISPLAYS PARAMETERS FOR MANUAL CONTROL.

# SUBROUTINES USED

#          R02      IMU STATUS CHECK
#          S40.1    COMPUTATION OF THRUST DIRECTION
#          S40.13   LENGTH OF BURN
#          S40.2,3  PREFERRED IMU ORIENATTION
#          S40.8    X PRODUCT STEERING
#          S40.9    LAMBERT VTOGAIN
#          R60LEM   ATTITUDE MANEUVER
#          LEMPREC  EXTRAPOLATE STATE VECTOR
#          PREREAD  AVERAGE G, SERVICER
#          ALLCOAST DAP COASTING INITIALIZATION
#          CLOKTASK ERGO CLOCKJOB--COUNT DOWN
#          PHASCHNG, INTPRET, FLAGUP, FLAGDOWN, WAITLIST, LONGCALL, GOFLASH, GOFLASHR, GOPERF1, ALARM,
#          PRIOLARM, GOTOPOOH, ENDOFJOB, BANKCALL, SETMAXDB, SETMINDB, CHECKMM, FLATOUT, OUTFLAT,
#          KILLTASK, SGNAGREE, TPAGREE, ETC.

# RESTARTS VIA GROUP 4

# DISPLAYS

#          V50N25  203 A/P TO PGNCS, AUTO THROTTLE MODE, AUTO ATTITUDE CONTROL
#          V06N40  TTI, VG, DELTAVM (DISPLAYED ONCE/SECOND BY CLOKTASK)
#          V50N99  PLEASE PERFORM ENGINE ON ENABLE
#          V06N40  TG (TIME TO GO TO CUTOFF), VG, DELTAVM--ONCE/SECOND
#          V16N40  FINAL VALUES OF TG, VG, DELTAVM
#          V16N85  COMP OF VG (BODY AXES) FOR POSS. RCS MANUAL MANEUVER
#          V05N09  POSSIBLE ALARMS
#          V50N07  PLEASE SELECT P00

## Page 739
#          VIA R30
#
#          V06N44  HAPO, PERI, TFF
#          V06N35  TIME TO PERIGEE, HMS

# ALARM OR ABORT EXIT MODES

#          PROGRAM ALARM, FLASHING DISPLAY OF ALARM CODE 1706 IF P40 SELECTED WITH DESCENT UNIT STAGED.
#          V34E (TERMINATE) IS THE ONLY RESPONSE ACCEPTED. TC GOTOPOOH.

#          PROGRAM ALARM, FLASH CODE 1703:  TIG LESS THAN 45 SECS AWAY.  V34E=  GOTOPOOH OR V33E=  SLIP
#          TIG BY 45 SECS.

# ERASABLE INITIALIZATION
# DEBRIS
# OUTPUT

#          SEE SUBROUTINES E.G.:  S40.1, S40.2,3, S40.13, S40.8, S40.9, TRIMGIMB
#          XDELVFLG = 1 FOR EXT DELV COMPUTATION
#                   = 0 FOR AIMPT (LAMBERT) COMP

                COUNT*  $$/P40
                EBANK=  WHICH

                BANK    36
                SETLOC  P40S
                BANK

P40LM           TC      PHASCHNG
                OCT     04024

                CAF     P40ADRES        # INITIALIZATION FOR BURNBABY.
                TS      WHICH

                CA      FLGWRD10
                MASK    APSFLBIT
                CCS     A
                TCF     P40ALM
                TC      BANKCALL        # GO DO IMU STATUS CHECK ROUTINE.
                CADR    R02BOTH

                CS      DAPBOOLS        # INITIALIZE DVMON
                MASK    CSMDOCKD
                CCS     A
                CAF     THRESH1
                AD      THRESH3
                TS      DVTHRUSH
                CAF     FOUR
                TS      DVCNTR
## Page 740
                TC      INTPRET         # LOAD CONSTANTS FOR DPS BURN
                VLOAD   CLEAR           # LOAD F, MDOT, TDECAY
                        FDPS
                        NOTHROTL
                STORE   F
                SLOAD
                        DPSVEX
P40IN           DCOMP   SR1
                STCALL  VEX             # LOAD EXHAUST VELOCITY FOR TGO COMP.
                        S40.1           # COMPUTES UT AND VGTIG
                CALL
                        S40.2,3         # COMPUTES PREFERRED IMU ORIENTATION
                EXIT

                INHINT
                TC      IBNKCALL
                CADR    PFLITEDB        # ZERO ATTITUDE ERRORS, SET DB TO ONE DEG.

                TC      P40SXT4

#                                              ***********************
                TCF     BURNBABY
#                                              ***********************

P40SXT4         EXTEND
                QXCH    P40/RET
P41MANU         RELINT

                TC      DOWNFLAG        # CLEAR 3AXISFLG -- R60 WILL USE VECPOINT.
                ADRES   3AXISFLG

                TC      BANKCALL
                CADR    R60LEM          # DO ATTITUDE MANEUVER ROUTINE
                TC      P40/RET


                EBANK=  TRKMKCNT
POSTBURN        CA      Z
                TS      DISPDEX
                EXTEND
                DCA     ACADN85
                DXCH    AVEGEXIT
                CAF     V16N40
                TC      BANKCALL
                CADR    GOFLASHR
                TC      TERM40
                TCF     TIGNOW
                TC      POSTBURN

## Page 741
P40PHS1         TC      PHASCHNG
                OCT     00014
                TCF     ENDOFJOB

TIGNOW          INHINT
                TC      IBNKCALL
                CADR    ZATTEROR
                TC      IBNKCALL
                CADR    SETMINDB
                RELINT
                CAF     V16N85B
                TC      BANKCALL
                CADR    REFLASHR
                TC      TERM40
                TCF     TERM40
                TC      -5

                TCF     P40PHS1

TERM40          EXTEND
                DCA     SERVCADR
                DXCH    AVEGEXIT
                CAF     ZERO
                TS      TRKMKCNT        #      ZERO RENDZVS CNTERS
                CA      Z
                TS      DISPDEX
                INHINT
                TC      IBNKCALL
                CADR    RESTORDB
                RELINT
                TC      GOTOPOOH

                EBANK=  WHICH
                COUNT*  $$/P41
P41LM           CAF     P41ADRES        # INITIALIZATION FOR BURNBABY
                TS      WHICH

                TC      BANKCALL
                CADR    R02BOTH

                CA      ZERO            # ZERO DVTOTAL FOR NOUN 40 DISPLAY
                TS      DVTOTAL
                TS      DVTOTAL +1
                CAF     PRIO5
                TS      DISPDEX         # FOR SAFETY
                TC      FINDVAC
                EBANK=  VGPREV
                2CADR   DYNMDISP
                
                TC      2PHSCHNG
## Page 742
                OCT     00116           # GROUP 6 RESTART AT FKP5RST, PRIO 17
                OCT     04024           # GROUP 4 RESTART HERE, PRIO 13
                
                TC      INTPRET         # BOTH LM
                BON     DLOAD           # IF NJETSFLAG IS SET, LOAD 2 JET F
                        NJETSFLG
                        P41FJET1
                        FRCS4           # IF NJETSFLAG IS CLEAR, LOAD 4 JET F

P41FJET         STCALL  F
                        P41IN
                        
P41FJET1        DLOAD
                        FRCS2
                STORE   F

P41IN           CALL
                        S40.1           # BOTH
P41NORM         CALL
                        S40.2,3         # CALCULATE PREFERRED IMU ORIENTATION AND
                EXIT                    # SET PFRATFLG.

                INHINT
                TC      IBNKCALL
                CADR    ZATTEROR        # ZERO ATTITUDE ERRORS
                TC      IBNKCALL
                CADR    SETMINDB        # SET 0.3 DEGREE DEADBAND
                TC      P40SXT4

                TC      INTPRET
                VLOAD   CALL            # TRANSFORM VELOCITY-TO-BE-GAINED AT TIG
                        VGTIG           # FROM REFERENCE COORDINATES TO LM BODY-
                        S41.1           # AXIS COORDINATES FOR V16N85 DISPLAY.
                STORE   VGBODY          # (SCALED AT 2 (+7) METERS/CENTISECOND)
                EXIT

                CAF     V16N85B
                TC      BANKCALL
                CADR    GODSPRET


                TC      2PHSCHNG
                OCT     00076           # GROUP 6 RESTARTS AT REDO6.7
                OCT     04024           # GROUP 4 RESTARTS HERE

#                                              ***********************
                TCF     B*RNB*B*
#                                              ***********************

## Page 743
BLNKWAIT        CAF     1SEC
                TC      BANKCALL
                CADR    DELAYJOB

REDO6.7         CA      DISPDEX         # ON A RESTART, DO NOT PUT UP DISPLAY IF
                AD      TWO             # BLANKING (BETWEEN TIG-35 AND TIG-30)
#                                              ***********************

                EXTEND
                BZF     BLNKWAIT

                CAF     V16N85B
                TC      BANKCALL
                CADR    GODSPRET

FKP5RST         CAF     PRIO5
                TC      PRIOCHNG

DYNMDISP        CA      DISPDEX         # A NON-POSITIVE DISPDEX INDICATES PAST
                EXTEND                  # TIG-35, SO SERVICER WILL BE DOING THE
                BZMF    ENDOFJOB        # UPDATING OF NOUN 85. STOP DYNMDISP.
                EXTEND
                DCS     TIG
                DXCH    TTOGO           # UPDATE TFI DISPLAY (NOUN 40)
                EXTEND
                DCA     TIME2
                DAS     TTOGO
                TC      INTPRET
                VLOAD   CALL
                        VGPREV
                        S41.1           # CONVERT VG FROM REF TO BODY
                STORE   VGBODY
                EXIT
                CAF     1SEC
                TC      BANKCALL
                CADR    DELAYJOB
                TCF     DYNMDISP        # RECYCLE ONCE A SECOND


                COUNT   $$/P41
                BANK    32
                SETLOC  P40S4
                BANK

CALCN85         TC      INTPRET
                CALL
                        UPDATEVG
                VLOAD   CALL
                        VGPREV
## Page 744
                        S41.1
                STORE   VGBODY
                EXIT
                TC      POSTJUMP
                CADR    SERVEXIT

                BANK    36
                SETLOC  P40S
                BANK
                
                COUNT*  $$/P42
                EBANK=  WHICH

P42LM           TC      PHASCHNG
                OCT     04024

                CAF     P42ADRES        # INITIALIZATION FOR BURNBABY.
                TS      WHICH

                CS      FLGWRD10
                MASK    APSFLBIT
                CCS     A
                TC      P40ALM
P42STAGE        TC      BANKCALL
                CADR    R02BOTH
                CAF     THRESH2         # INITIALIZE DVMON
                TS      DVTHRUSH
                CAF     FOUR
                TS      DVCNTR

                TC      INTPRET
                SET     VLOAD           # LOAD FAPS, MDOTAPS, AND ATDECAY INTO
                        AVFLAG          # F, MDOT, AND TDECAY BY VECTOR LOAD.
                        FAPS
                STORE   F
                SLOAD   GOTO
                        APSVEX
                        P40IN

                EBANK=  WHICH

                COUNT*  $$/P47
P47LM           TC      BANKCALL
                CADR    R02BOTH
                TC      INTPRET
                CALRB
                        MIDTOAV2

                CA      MPAC +1
                TC      TWIDDLE
## Page 745
                ADRES   STARTP47

                TCF     ENDOFJOB

STARTP47        TC      PHASCHNG
                OCT     05014
                OCT     77777

                EXTEND
                DCA     ACADN83
                DXCH    AVEGEXIT
                CAF     PRIO20
                TC      FINDVAC
                EBANK=  DELVIMU
                2CADR   P47BODY

                TCF     REDO4.2         # CHECKS PHASE 5 AND GOES TO PREREAD
                                        # SEE TIG-30 IN BURNBABY.

CALCN83         TC      INTPRET
                VLOAD   VAD
                        DELVCTL
                        DELVREF
                STORE   DELVSIN         # TEMP STORAGE FOR RESTARTS
                CALL
                        S41.1
                STORE   DELVIMU
                EXIT
                TC      SERVCHNG
                TC      INTPRET
                VLOAD
                        DELVSIN
                STORE   DELVCTL
                EXIT

                TC      POSTJUMP
                CADR    SERVEXIT

P47BOD          CAF     V1683
                TC      BANKCALL
                CADR    GOFLASHR
                TC      GOTOPOOH
                TC      GOTOPOOH

                TCF     P47BODY

                TCF     P40PHS1

P47BODY         TC      INTPRET
                VLOAD
## Page 746
                        HI6ZEROS
                STORE   DELVIMU
                STORE   DELVCTL
                EXIT
                TC      P47BOD

                COUNT*  $$/P40
IMPLBURN        CA      TGO +1
                TC      GETDT
                TC      TWIDDLE
                ADRES   ENGOFTSK
                TC      DOWNFLAG        # TURN OFF IGNFLAG
                ADRES   IGNFLAG
                TC      DOWNFLAG        # TURN OFF ASTNFLG
                ADRES   ASTNFLAG
                TC      DOWNFLAG        # TURN OFF IMPULSW
                ADRES   IMPULSW
                TC      PHASCHNG        # RESTART PROTECT ENGOFTSK (ENGINOFF)
                OCT     40114

                TC      FIXDELAY        # WAIT HALF A SECOND
                DEC     50

                TC      NOULLAGE        # TURN OFF ULLAGE

                TC      TASKOVER

ENGOFTSK        TC      IBNKCALL        # THIS CODING ALLOWS ENGINOFF ET AL TO BE
                CADR    ENGINOFF        # USED BOTH BY WAITLIST AND BY TC IBNKCALL
                TC      TASKOVER

ENGINOFF        CAF     PRIO12          # MUST BE LOWER PRIO THAN CLOCKJOB
                TC      FINDVAC
                EBANK=  TRKMKCNT
                2CADR   POSTBURN


ENGINOF2        CAF     BIT1
                TC      WAITLIST
                EBANK=  OMEGAQ
                2CADR   COASTSET

ENGINOF1        CS      FLAGWRD7        # SET THE IDLE BIT.
                MASK    IDLEFBIT
                ADS     FLAGWRD7

                TC      NOULLAGE

ENGINOF4        EXTEND
                DCA     TIME2
## Page 747
                DXCH    TEVENT

ENGINOF3        CS      ENGONBIT        # INSURE ENGONFLG IS CLEAR.
                MASK    FLAGWRD5
                TS      FLAGWRD5
                CS      PRIO30          # ENGINOF3 IS USED AS A PRE-ENGINE ARM
                EXTEND                  # SUBROUTINE.
                RAND    DSALMOUT
                AD      PRIO20          # TURN OFF THE ENGINE - DPS OR APS
                EXTEND
                WRITE   DSALMOUT

                CS      DAPBOOLS        # TURN OFF TRIM GIMBAL
                MASK    USEQRJTS
                ADS     DAPBOOLS

                CS      HIRTHROT        # ZERO AUTO-THROTTLE WHENEVER THE ENGINE
                TS      THRUST          # IS TURNED OFF.
                CAF     BIT4            # THE HARDWARE DOES SO ONLY WHEN THE
                EXTEND                  # ENGINE IS DISARMED.
                WOR     CHAN14

                TC      ISWRETRN
COASTSET        TC      IBNKCALL        # DO DAP COASTING INITIALIZATION
                CADR    ALLCOAST
                TC      TASKOVER

                EBANK=  OMEGAQ
UPDATEVG        STQ     CALL
                        QTEMP1
                        S40.8           # X-PRODUCT STEERING
S40RET          BON     BON             # WILL RETURN HERE FROM S40.8
                        XDELVFLG
                        QTEMP1
                        NORMSW
                        180SETUP
                DLOAD   DSU
                        PIPTIME
                        TIGSAVE
                DSU     BMN
                        TNEWA
                        GETRANS
                DLOAD   DAD
                        TIGSAVE
                        TNEWA
                STORE   TIGSAVEP
180SETUP        EXIT
                CCS     PHASE2
                TCF     NO.9
                CAF     PRIO10
## Page 748
                INHINT
                TC      FINDVAC
                EBANK=  VG
                2CADR   S40.9           # LAMBERT VTOGAIN

                TC      2PHSCHNG
                OCT     00172           # 2.17SPOT FOR S40.9
                OCT     04025
ENDSTEER        TC      INTPRET
                DLOAD
                        TIGSAVEP
                STOVL   TIGSAVE
                        RN
                STOVL   RINIT
                        VN
                STORE   VINIT
GETRANS         DLOAD   DSU
                        TPASS4
                        PIPTIME
                STCALL  DELLT4
                        QTEMP1

NO.9            TC      INTPRET
                GOTO
                        QTEMP1
STEERING        TC      INTPRET

                CALL
                        UPDATEVG
                EXIT

                EBANK=  DVCNTR
NSTEER          INHINT
                CA      EBANK7
                TS      EBANK
                CS      FLAGWRD2        # CHECK IMPULSE SWITCH.  IT IS SET EITHER
                MASK    IMPULBIT        # BY S40.13 IF TBURN<6 SECS OR BY S40.8 IF
                CCS     A               # STEERING IS ALMOST DONE.

                TCF     +5              # IMPULSW = 0    EXIT
                CS      FLAGWRD7        # IMPULSW = 1    WHY?  CHECK IDLEFLAG
                MASK    IDLEFBIT        #     (IDLEFLAG = 0 --> DVMON ON)
                CCS     A
                TCF     +3              # DVMON ON-->THRUSTING-->IMPULSW VIA S40.8
GOPIPCYC        TC      POSTJUMP        # DVMON OFF-->IMPULSW ON VIA S40.13-->EXIT
                CADR    PIPCYCLE

                TC      IBNKCALL
                CADR    STOPRATE

## Page 749
                TC      DOWNFLAG        # TURN OFF IMPULSW
                ADRES   IMPULSW

                TC      UPFLAG
                ADRES   IDLEFLAG        # TURN OFF DVMON

                INHINT
                EXTEND
                DCA     TIG
                DXCH    MPAC
                EXTEND
                DCS     TIME2
                DAS     MPAC
                TC      TPAGREE
                CAE     MPAC +1
                TC      GETDT
                TC      TWIDDLE
                ADRES   ENGOFTSK
                TC      2PHSCHNG
                OCT     40114           # ENGOFTSK (ENGINOFF)
                OCT     04025
                TCF     GOPIPCYC

GETDT           CCS     A
                TCF     +3
                TCF     +2
                CAF     ZERO
                AD      ONE
                XCH     L
                CAF     ZERO
                DXCH    TGO
                CA      TGO +1
                TC      Q


# ************************************************************************

5SECDP          OCT     00000           # DON'T MOVE FROM JUST BEFORE 5SEC
5SEC            DEC     500
V16N40          VN      1640
V16N85B         VN      1685
V1683           VN      1683
SEC01           =       1SEC
ACADN85         =       P41TABLE +2

                EBANK=  DELVIMU
ACADN83         2CADR   CALCN83

# *************************************************

## Page 750
# PROGRAM DESCRIPTION S40.1       DATE15NOV66
# MOD N02         LOG SECTION  P40-P47
# MOD BY ZELDIN AND ADAPTED BY TALAYCO
# FUNCTIONAL DESCRIPTION
#          COMPUTE INITIAL THRUST DIRECTION(UT) AND INITIAL VALUE OF VG
#          VECTOR(VGTIG).
# CALLING SEQUENCE
#        L CALL
#      L+1        S40.1
# NORMAL EXIT MODE
#          AT L+2 OF CALLING SEQUENCE (GOTO L+2)  NORMAL RETURN OR
#          ERROR RETURN IF NOSOFLAG =1
# SUBROUTINES CALLED
#          LEMPREC
#          INITVEL
#          CALCGRAV
#          MIDGIM
# ALARM OR ABORT EXIT MODES
#      L+2 OF CALLING SEQUENCE,UNSOLVABLE CONIC IF NOSOFLAG=1
# ERASABLE INITIALIZATION REQUIRED
#                 WEIGHT/G  ANTICIPATED VEHICLE MASS         DP  B16KGM
#          XDELVFLG       1=DELTA-V MANEUVER,0=AIMPT STEER
#           F         THRUST FOR ENGINE USED
#       IF DELTA-V MANEUVER
#          DELVSIN   SPECIFIED DELTA-V REQUIRED IN
#                    INERTIAL COORDS. OF ACTIVE VEHICLE
#                    AT TIME OF IGNITION                 VECTOR B7M/CS
#          DELVSAB   MAG. OF DELVSIN                     DP     B7M/CS
#          RTIG      POSITION AT TIME OF IGNITION       VECTOR B29M
#          VTIG      VELOCITY AT TIME OF IGNITION       VECTOR B7M/CS
#       IF AIMPT STEER
#          TIG       TIME OF IGNITION                    DP     B28CS
#          RTARG     POSITION TARGET TIME               VECTOR B29M
#          CSTEER    C FOR STEER LAW                     DP     B2
#          DLTARG    TARGET TIME-IGNITION TIME          DP     B28CS
# OUTPUT
#       UT           DESIRED THRUST DIRECTION            VECT. B2M/(CS.CS)
#       VGTIG        INITIAL VALUE OF VELOCITY
#                    TO BE GAINED (INERT. COORD.)        VECTOR B7M/CS
#       DELVLVC      VGTIG IN LOC. VERT. COORDS.                B7M/CS
#          BDT   V REQUIRED AT TIG -V REQUIRED AT (TIG-2SEC)
#          -GDT  FOR S40.13                                   VECT  B7M/CS
#       RTIG         CALC IN S40.1B(AIMPT) FOR S40.2,3  VECTOR B29M
#                    POSITION AT TIME OF IGNITION
# DEBRIS      QTEMP1
#       MPAC, QPRET
#       PUSHLIST
                BANK    14
                SETLOC  P40S1
                BANK
                
## Page 751
                COUNT*  $$/S40.1
S40.1           STQ     DLOAD
                        QTEMP
                        TIG
                STORE   TIGSAVE
DELVTEST        BOFF
                        XDELVFLG
                        S40.1B
CALCTHET        SETPD   VLOAD
                        0
                        VTIG
                STORE   VINIT
                VXV     UNIT
                        RTIG
                STOVL   UT              # UP IN UT
                        RTIG
                STORE   RINIT
                VSQ     PDDL
                        36D
                DMP     DDV
                        THETACON
                DMP     DMP
                        DELVSAB
                        WEIGHT/G
                DDV
                        F
                STOVL   14D
                        DELVSIN

                DOT     VXSC
                        UT
                        UT
                VSL2    PUSH            # (DELTAV.UP)UP SCALED AT 2(+7) P.D.L. 0
                BVSU    PDDL            # DELTA VP SCALED AT 2(+7) P.D.L. 6
                        DELVSIN
                        14D
                SIN     PDVL
                        6D
                VXV     UNIT
                        UT
                VXSC    STADR
                STOVL   VGTIG           # UNIT(VPXUP)SIN(THETAT/2) IN VGTIG.
                UNIT    PDDL            # UNIT(DELTA VP) IN P.D.L. 6
                        14D
                COS     VXSC
                VAD     VXSC
                        VGTIG
                        36D
                VSL2    VAD
                STADR
## Page 752
                STORE   VGTIG           # VG IGNITION SCALED AT 2(+7)M/CS

                UNIT
                STOVL   UT              # THRUST DIRECTION SCALED AT 2(+1)
                        VGTIG
                PUSH    CALL
                        GET.LVC         # VGTIG IN LV COOR AT 2(+7) M/CS IN DELVLVC
                GOTO
                        QTEMP
S40.1B          DLOAD
                        TIG
                STORE   TDEC1
                BDSU
                        TPASS4
                STCALL  DELLT4          # INTERCEPT TIME - TIG.
                        LEMPREC
                VLOAD   SETPD           # LOAD STATE VECTOR AT TIG FOR INITVEL.
                        RATT
                        0
                STORE   RTIG
                STORE   RINIT
                UNIT
                STOVL   UNIT/R/
                        VATT
                STORE   VTIG
                STORE   VINIT
                DLOAD   PDDL            # NUMIT = 0
                        ZEROVECS
                        EPS1
                BOFF    DAD
                        NORMSW
                        SMALLEPS
                        EPS2            # EPSILON4 = 10 DEGREES OR 45 DEGREES.
SMALLEPS        PUSH    SXA,1
                        RTX1
                SXA,2   CALL
                        RTX2
                        INITVEL
                VLOAD   PUSH
                        DELVEET3        # VGTIG = VR - VN.
                STORE   VGTIG
                UNIT                    # UT = UNIT (VGTIG)
                STODL   UT
                        36D
                STCALL  VGDISP          # CONVERT VGTIG (IN PUSHLIST ) TO LOCAL
                        GET.LVC         # VERTICAL COORDINATES.
                GOTO
                        QTEMP

EPS1            2DEC*   2.777777778 E-2*        # 10 DEGREES AT 1 REVOLUTION.

## Page 753
EPS2            2DEC*   9.722222222 E-2*        # 35 DEGREES AT 1 REVOLUTION.

THETACON        2DEC    .31830989 B-8

## Page 754
# SUBROUTINE NAME: S40.2,3        MOD. NO. 3 DATE: APRIL 4, 1967

# MODIFICATION BY: JONATHAN D. ADDELSTON (ADAMS ASSOCIATES)

# MOD. NO. 4:  JULY 18, 1967:  PETER ADLER (MIT/IL)

# MOD. NO. 5:  OCTOBER 18, 1967:  PETER ADLER (MIT/IL)

# ORIGINALLY BY: SAYDEAN ZELDIN (MIT INSTRUMENTATION LAB) AND RICHARD TALAYCO (SYSTEM DEVELOPMENT CORP)

# S40.2,3 COMPUTES "POINTVSM" WHICH IS THE HALF-UNIT DESIRED THRUST VECTOR IN STABLE-MEMBER COORDINATES FROM "UT"
# WHICH IS THE SAME VECTOR IN REFERENCE COORDINATES.  IT DETERMINES THE CORRECT VALUES FOR "SCAXIS" USING THE +X
# AXIS FOR DPS, APS, AND RCS BURNS.  THE "WINGS-LEVEL HEADS-UP" LM ORIENTATION IS THEN COMPUTED IN REFERENCE
# COORDINATES.  THESE VECTORS ALSO DEFINE THE "PREFERRED IMU ORIENTATION".  UPON COMPLETION OF THIS CALCULATION,
# THE "PREFERRED ATTITUDE COMPUTED" FLAG IS SET (PFRATFLG).


# CALLING SEQUENCE:
#                                         L        CALL                   INTERPRETIVE CALL.
#                                         L +1            S40.2,3
#                                         L +2    (RETURN)                GIMBAL ANGLE VECTOR IN MPAC.

# SUBROUTINES CALLED:  NONE.

# NORMAL RETURN:  L +2 (SEE CALLING SEQUENCE ABOVE).

# ALARM/ABORT MODES:  NONE.

# INPUT:

#          1. REFSMMAT            MATRIX FROM REFERENCE TO STABLE-MEMBER COORDINATES SCALED AT 2.
#          2. UT                  HALF-UNIT DESIRED THRUST DIRECTION.
#          3. RTIG                POSITION AT TIG IN REFERENCE COORDINATES.
#
# OUTPUT:

#          1. : XSCREF :          WINGS-LEVEL HEADS-UP LM ORIENTATION
#             : YSCREF :          IN REFERENCE COORDINATES
#             : ZSCREF :          (PREFERRED IMU ORIENTATION).
#          2. POINTVSM            DESIRED THRUST DIRECTION IN STABLE-MEMBER COORDINATES.
#          3. SCAXIS              HALF-UNIT OF AXIS TO ALIGN IN STABLE-MEMBER COORDINATES.
#          4. PFRATFLG            INTERPRETIVE FLAG.  ON:  PREFERRED ORIENTATION COMPUTED; OFF:  NOT COMPUTED.

# DEBRIS:  NONE.

## Page 755
                COUNT*  $$/S40.2
S40.2,3         VLOAD                   # UT: DESIRED THRUST DIRECTION (HALF-UNIT)
                        UT              # (PUT INTO TOP OF PUSH-DOWN-LIST.)
                MXV     VSL1            # TRANSFORM THRUST DIRECTION TO STABLE-
                        REFSMMAT        # MEMBER FROM REFERENCE COORDS (RESCALE).
                STOVL   POINTVSM        # SAVE FOR "VECPOINT" ROUTINE (LEMMANU).
                        UNITX           # SCAXIS SET TO +X, FOR P40 AND P42 AND
                STOVL   SCAXIS          # FOR P41 IF RCS NOT -X,+Y,-Y,+Z,-Z.
                
                        UT              # ASSUME +X BURN ALWAYS, EVEN FOR RCS.
PLUSX           STORE   XSCREF          # XSCREF = UT (DESIRED THRUST DIRECTION.)
                VXV     UNIT            # RTIG = POSITION AT TIME-OF-IGNITION.
                        RTIG            # YSCREF = UNIT(UT X RTIG)
                PDDL    BHIZ
                        36D             # TEST MAGNITUDE OF UT X RTIG
                        FIXY            # IF SMALL, USE UT X VTIG AS YSC
STORY           VLOAD   STADR
                STORE   YSCREF
                VXV     VSL1            # COMPUTE (YSCREF X XSCREF),BUT FOR A
                        XSCREF          # RIGHT HANDED SYSTEM, NEED (X CROSS Y).
                VCOMP                   # ZSCREF = - (YSCREF X XSCREF)
                STORE   ZSCREF          #        = + (XSCREF X YSCREF)

                SET     RVQ
                        PFRATFLG
FIXY            VLOAD   VXV             # IN THIS CASE,
                        XSCREF          # YSCREF = UNIT(XSCREF X VTIG)
                        VTIG
                UNIT    PUSH
                GOTO
                        STORY

## Page 756
# SUBROUTINE S40.8

# MODIFIED APRIL 3, 1968  BY  PETER ADLER   MIT/IL

# DESCRIPTION

#      S40.8 UPDATES THE VELOCITY-TO-BE-GAINED VECTOR, VG, (AND FOR LAMBERT TARGETTED BURNS ALSO EXTRAPOLATES VG
# USING THE BDT VECTOR)  COMPUTES THE TIME FOR ISSUING THE ENGINE OFF COMMAND, TGO, AND CALLS THE ROUTINE
# "FINDCDUW", WHICH GENERATES THE STEERING COMMANDS FOR THE DAP.

# CALLING SEQUENCE

# L-1      CALL
# L               S40.8
# L+1                      INTERPRETIVE RETURN

# ALARM

#      IF VG . DELVREF IS NEGATIVE (VG AND DELVREF OVER 90 DEGREES APART), BYPASS TGO AND STEERING COMPUTATIONS
# AND SET ALARM 1407.  RETURN TO CALLER NORMALLY.

# INPUT AND INITIALIZATION

# VGPREV          REFERENCE       2(7) M/CS
# DELVREF         REFERENCE       2(7) M/CS
# BDT             REFERENCE       2(7) M/CS
# TDECAY          TAIL-OFF TIME   2(28)  CS
# XDELVFLG        1 = EXTERNAL DELTA-V;  0 = LAMBERT (AIMPOINT)
# STEERSW         1 = DO STEERING AND TGO COMPUTATIONS; 0 = VG UPDATE ONLY
# FIRSTFLG        1 = GONE TO LAMBERT AT LEAST ONCE;  0 = HAVEN'T GONE TO LAMBERT YET

# NOTE:  VGTIG EQUALS VGPREV

# OUTPUT

# STEERSW         SEE INPUT
# IMPULSW         1 = ENGINE OFF IN TGO CENTISECONDS;  0 = CONTINUE BURN
# TGO             TIME TO CUT-OFF 2(28)   CS
# SEE FINDCDUW FOR STEERING OUTPUTS.

# SUBROUTINE CALLED

#      FINDCDUW

# DEBRIS

#      MPACS, PUSHLIST

                COUNT*  $$/S40.8
## Page 757
S40.8           BOF                     # GENERATE VR IF NOT EXTERNAL DELTA-V BURN
                        XDELVFLG
                        RASTEER1
                VLOAD   VSU
                        VGPREV
                        DELVREF
VGAIN*          STORE   VG              # VELOCITY TO BE GAINED SCALED AT (7)M/CS
                MXV     VSL1
                        REFSMMAT
                STORE   UNFC/2
BDTOK           VLOAD   ABVAL
                        VG
                STORE   VGDISP
                EXIT
                TC      SERVCHNG
                TC      INTPRET
TGOCALC         SETPD   VLOAD
                        0
                        VG
                STOVL   VGPREV
                        DELVREF
                BOFF    VCOMP
                        STEERSW
                        S40RET          # LOCATION FOLLOWING CALL TO S40.8
                UNIT
                DOT     PUSH
                        VG
                BPL     DDV
                        ALARMIT         # DELV IS MORE THAN 90 DEGREES FROM VG.
                        VEX
                DAD     DMP
                        DPHALF
                SR      DDV
                        10D
                        36D
                DMP     DAD
                        -FOURDT
                        TDECAY
                STORE   TGO
                DAD
                        PIPTIME
                STODL   TIG
                        TGO
                DSU     BPL
                        FOURSECS        # 400 CS
                        GOFIND          # CALL TO FINDCDUW -2
                SET     CLRGO
                        IMPULSW
                        STEERSW
                        S40RET          # LOCATION FOLLOWING CALL TO S40.8

## Page 758
                BANK    24
                SETLOC  S40BNK
                BANK
                
ALARMIT         EXIT
                TC      ALARM
                OCT     01407           # SKIP TGO COMPUTATION BUT CALL FINDCDUW.
                TC      INTPRET
GOFIND          CALL            
                        FINDCDUW -2
                GOTO
                        S40RET          # LOCATION FOLLOWING CALL TO S40.8
                        
                BANK    27
                SETLOC  P40S1
                BANK

-FOURDT         2DEC    -800 B-18       # -4 (200 CS.)  B (-18)

FOURSECS        2DEC    400             # 400 CS SCALED AT 2(+28) CS

2VEXHUST        =       VEX

## Page 759
# NAME     S40.13 - TIMEBURN
# FUNCTION        (1) DETERMINE WHETHER A GIVEN COMBINATION OF VELOCITY TO
#                 BE GAINED AND ENGINE CHOICE RESULT IN A BURN TIME
#                 SUFFICIENT TO ALLOW STEERING AT THE VEHICLE DURING THE
#                 BURN
#                 (2) THE MAGNITUDE OF THE RESULTING BURN TIME -- IF IT
#                 IS SHORT --  AND THE ASSOCIATED TIME OF THE ENGINE OFF
#                 SIGNAL
# CALLING SEQUENCE  VIA FINDVAC AS A NEW JOB
# INPUT           VGTIG VELOCITY TO BE GAINED VECTOR (METERS/CS) AT +7
#                 WEIGHT/G MASS OF VEHICLE IN KGM AT +16
#                 F  APS ENGINE THRUST IN M.NEWTONS AT +7
#                 AND ALSO FOR RCS ENGINE
#                 MDOT RATE OF DECREASE OF VEHICLE MASS DURING ENGINE
#                 BURN IN KILOGRAMS/CS  AT +3 . THIS SCALING MAY
#                 REQUIRE MODIFICATION FOR SATURN BURNS.
#          ENG1FLAG     SWITCH TO DECIDE WHETHER APS OR DPS ENGINE IS USED
#                  =0   DPS
#                  =1   APS
# OUTPUT          IMPULSW  ZERO FOR STEERING
#                          ONE FOR ATTITUDE HOLD
#                 NOTHROTL  ZERO FOR THROTTLING
#                           ONE  TO INHIBIT THROTTLING
#                 TGO  TIME TO BURN IN CS
#          THE QUANTITY M.NEWTON = 10000 NEWTONS WILL BE USED TO EXPRESS
#                 FORCE

                EBANK=  TGO
                COUNT*  $$/40.13
S40.13          TC      INTPRET
                SETPD   CLEAR
                        00D
                        IMPULSW         # ASSUME NO STEERING UNTIL FOUND OTHERWISE
                VLOAD   ABVAL
                        VGTIG           # VELOCITY TO BE GAINED AT +7
                PDDL    DMP             # 00D = MAG OF VGTIG AT +7
                        6.5SECS         # CORRECT VG FOR 6.5 SECONDS OF ULLAGE
                        FRCS4           # ASSUME 4 JET ULLAGE
                DDV     SL1             # SCALE
                        WEIGHT/G
                BDSU    PUSH
                BOFF    SET
                        APSFLAG
                        S40.13D         # FOR DPS ENGINE
                        NOTHROTL
                DLOAD   DDV             # 00D = MAG OF VGTIG CORRECTED
                        K1VAL           # M.NEWTONS-CS AT +24
                        WEIGHT/G
                BDSU    BMN
## Page 760
                        00D
                        S40.131         # TGO LESS THAN 100 CS
                PDDL    DMP             # 02D = TEMP1 AT +7
                        MDOT

# MDOT REPRESENTS THE RATE OF DECREASE OF VEHICLE MASS DURING ENGINE
# BURN IN KILOGRAMS/CS .  WHEN  SATURN IS USED , THE SCALING MAY
# REQUIRE ADJUSTMENT

                        3.5SEC          # 350 CS AT +14
                BDSU    PDDL
                        WEIGHT/G
                        F
                DMP     SR2             # SCALE
                        5SECS
                DDV     PUSH            # 04D = TEMP2
                BDSU    BPL
                        02D
                        S40.13D
                DLOAD   BDDV
                DMP     DAD
                        5SECS
                        1SEC2D          # 100 CS AT +14
                GOTO
                        S40.132
S40.131         DLOAD   DMP
                        WEIGHT/G
                SR1     PUSH
                DAD     DDV
                        K2VAL           # M.NEWTON CS AT +24
                        K3VAL           # M.NEWTON CS AT +10
S40.132         SET     EXIT
                        IMPULSW
S40.132*        TC      TPAGREE
                CA      MPAC
                XCH     L
                CA      ZERO
                DXCH    TGO
                TCF     S40.134

S40.13D         DLOAD   DMP             # FOR DPS ENGINE
                        00D
                        WEIGHT/G
                PUSH    BON
                        APSFLAG
                        APSTGO
                DDV     CLEAR
                        S40.136
                        NOTHROTL
                BOV     PUSH
## Page 761
                        S40.130V
S40.137         DSU     BPL
                        6SEC            # 600.0 CS AT +14
                        S40.138
                DAD     GOTO
                        6SEC
                        S40.132
S40.133         EXIT
S40.134         TC      PHASCHNG
                OCT     00003
                TC      ENDOFJOB
S40.130V        DLOAD   SR4             # RECOMPUTE TGO IN TIME2 UNITS
                DDV
                        S40.136_        # S40.136 SHIFTED LEFT 10
                STORE   TGO
                EXIT
                TCF     S40.134         # REJOIN COMMON CODING FOR RESTART PROTECT

S40.138         DSU     BPL
                        89SECS
                        STORETGO
                SET
                        NOTHROTL
STORETGO        DLOAD                   # LOAD TGO AT 2(14)
                EXIT
                TCF     S40.132*

APSTGO          DDV     SL2
                        FAPS
                GOTO
                        STORETGO +1
1SEC2D          2DEC    100.0 B-14      # 100.0 CS AT +14

3.5SEC          2DEC    350.0 B-13      # 350 CS AT +13

5SECS           2DEC    500.0 B-14      # 500.0 CS AT +14

6SEC            2DEC    600.0 B-14      # 600.0 CS AT +14

89SECS          2DEC    8900.0 B-14

6.5SECS         2DEC    650. B-17       # ASSUME 6.5 SECONDS OF ULLAGE

# FUNCTION    (1) GENERATES REQUIRED VELOCITY AND VELOCITY-TO-BE-GAINED
#             VECTORS FOR USE DURING AIMPOINT MANEUVERS EVERY TWO
#             COMPUTATION CYCLES (4 SECONDS).
#             (2) UPDATES THE B VECTOR WHICH IS USED IN THE FINAL
#             CALCULATION OF EXTRAPOLATING THE VELOCITY-TO-BE-GAINED
#             THROUGH ONE 2-SECOND INTERVAL INTO THE FUTURE.
# CALLING SEQ VIA FINDVAC AS NEW JOB.
## Page 762
# INPUT       RN       - ACTIVE VEHICLE RADIUS VECTOR IN METERS AT +29.
#             VN       - ACTIVE VEHICLE VELOCITY VECTOR IN METERS/CS AT +7
#             VRPREV   - LAST COMPUTED VELOCITY REQUIRED VECTOR IN
#                        METERS/CS AT +7.
#             TIG      - TIME OF IGNITION IN CS AT +28.
#             DLTARG   - COMPUTATION CYCLE INTERVAL = 200 CS AT +28.
#             PIPTIME  - TIME OF RN AND VN IN CS AT +28.
#             GDT/2    - HALF OF VELOCITY GAINED IN DELTA T TIME DUE TO
#                        ACCERERATION OF GRAVITY IN METERS/CS AT +7.
#             DELVREF  - CHANGE IN VELOCITY DURING LAST 2 SEC IN
#                        METERS/CS AT +7.
# OUTPUT      VGPREV   - VELOCITY TO BE GAINED VECTOR IN METERS/CS AT +7.
#             VGDISP   - MAG OF VGPREV FOR DISPLAY PURPOSES.
#             VRPREV   - VELOCITY REQUIRED VECTOR IN METERS/CS AT +7.
#             BDT      - B VECTOR IN METERS/CS AT +7.
# SUBROUTINES USED  -  INITVEL
                EBANK=  VGPREV
                COUNT*  $$/S40.9
S40.9           TC      INTPRET
                SETPD
                        00D
                SET     DLOAD
                        AVFLAG          # SET AVFLAG FOR LEM ACTIVE
                        HI6ZEROS
                PDDL
                        EPS1
                BOFF    DAD             # EPSILON4 = 10 OR 45 DEGREES.
                        NORMSW
                        EPSSMALL
                        EPS2
EPSSMALL        PUSH    CALL
                        HAVEGUES
ENDS40.9        EXIT
                TC      PHASCHNG
                OCT     2
                TCF     ENDOFJOB


RASTEER1        VLOAD   ABVAL
                        RN
                LXC,2   SL*
                        RTX2
                        0,2
                STOVL   RMAG
                        RTARG
                VSU     RTB
                        RN
                        NORMUNX1
                STODL   IC
                        36D             # C(36D) = ABVAL(C)
## Page 763
                XAD,2   SL*
                        X1
                        0,2
                STORE   30D
                NORM    DMP
                        X2
                        RMAG
                NORM    XAD,2
                        X1
                        X1
                SXA,2
                        MUSCALE
                STODL   R1C             #                         2(+58 -X)
                        30D
                SR1     PDDL
                        RMAG
                SR1     PDDL
                        RTMAG
                SR1     DAD
                DAD     STADR
                STORE   SS              # SS = (R1 + R2 +C )/2
                DSU     DMP
                        30D
                        MU/A
                BDSU
                        MUASTEER
                PDDL    DSU
                        SS
                        RMAG
                NORM    SR1
                        X1      
                DDV     DMP
                        R1C
                XSU,2   SL*
                        X1
                        1,2
                LXA,2           
                        MUSCALE         
                SQRT    SIGN
                        GEOMSGN
                STORE   32D             # + OR - A
                DLOAD   DMP
                        SS
                        MU/A            
                BDSU    
                        MUASTEER
                PDDL    DSU
                        SS
                        RTMAG
                NORM    SR1
## Page 764
                        X1              
                DDV     DMP
                        R1C
                XSU,2   SL*
                        X1
                        1,2
                SQRT    PDDL            # -B (NO SIGN)
                        SS
                DSU     DDV
                        30D
                        SS
                SQRT    PUSH
                SR1     ASIN
                DMP     PDDL
                        2PI+3
                PDDL    DDV
                        30D
                        SS
                BOV     
                        +1
                SQRT    DMP
                SR3     BDSU
                SIGN    PDDL
                        GEOMSGN         
                        2PI+3
                SR2     DSU
                DMP     PDDL
                        SS
                        SS      
                SR3     SQRT
                DMP
                PDDL    SL3
                        MUASTEER
                SQRT    BDDV
                DSU     DAD     
                        TPASS4  
                        PIPTIME
                STODL   30D
                SIGN                    
                        30D             # B WITH SIGN
                STORE   30D
                BON     VLOAD
                        NORMSW
                        180MESS
                        IC
                VSU     UNIT
                        UNIT/R/
                VXSC    PDVL
                        30D
                        IC
## Page 765
                VAD     UNIT
                        UNIT/R/
GETVRVG1        VXSC    VAD
                        32D
GETVRVG2        LXC,2   VSR*
                        RTX2
                        0 -1,2
                STORE   VIPRIME
                GOTO
                        ASTREND -2
180MESS         VLOAD   DOT
                        IC
                        UNIT/R/
                BMN     VLOAD
                        NEGPROD
                        IC
                VSR1    PDVL
                        UNIT/R/
                VSR1    VAD
                UNIT
                PUSH    VCOMP           # FOR A
                VXV     SIGN
                        UN
                        GEOMSGN
                UNIT    VXSC
                        30D
                PDVL                    # UNIT(IC-IR)     +-B
                GOTO
                        GETVRVG1
NEGPROD         VLOAD   VSR1
                        UNIT/R/
                PDVL    VSR1
                        IC
                VSU     UNIT
                PUSH
                VXV     SIGN
                        UN              # FOR B
                        GEOMSGN
                UNIT    VXSC
                        32D
                PDVL
                VXSC    VAD
                        30D
                GOTO
                        GETVRVG2
                VSU
                        VN1
ASTREND         STORE   DELVEET3
FIRSTTME        SLOAD   BZE
                        RTX2
## Page 766
                        GETGOBL
                VLOAD   GOTO            # NO OBLATENESS COMP IF IN MOON SPHERE
                        DELVEET3
                        NOGOBL
GETGOBL         VLOAD   UNIT            # CALCULATE OBLATENESS TERM.
                        RN
                DLOAD   DSU
                        PIPTIME         #              2
                        GOBLTIME        # G    = -(MU/R )(UNITGOBL)(T - TIG)
                DMP     DDV             #  OBL
                        EARTHMU
                        34D             # 34D = /RN/ (2) FROM UNIT OPERATION.
                VXSC    VAD
                        UNITGOBL
                        DELVEET3        #  OUTPUT FROM INITVEL  VG = VR - VN
NOGOBL          STORE   DELVEET3        # VG = VR + GOBL - VN
                GOTO
                        VGAIN*


2PI+3           2DEC    3.141592653 B-2


## Page 767
# TRIMGIMB      (FORMERLY S40.6)
# MOD 0     24 FEB 67     PETER ADLER
# FUNCTION:
#          TRIMS DPS ENGINE TO MINIMIZE THRUST/CG OFFSET. ENGINE IS GIMBALLED TO FULL + PITCH AND + ROLL (TO LOCK)
#          FOR REFERENCE AND IS THEN BROUGHT BACK TO TRIM POSITION BY RUNNING FOR THE PROPER TIMES (TO BE
#          SPECIFIED BY GAEC) IN - PITCH AND - ROLL.
# CALLING SEQUENCE:
#          VIA WAITLIST FROM R03
# INPUT:
#          PITTIME     TIME TO RUN FROM FULL + PITCH TO TRIM  (CS)
#          ROLLTIME    TIME TO RUN FROM FULL + ROLL  TO TRIM  (CS)
# SUBROUTINES USED:
#          WAITLIST, FIXDELAY, VARDELAY, FLAGUP, FLAGDOWN, NOVAC

                COUNT*  $$/S40.6
                EBANK=  ROLLTIME        # OCTAL MASKS:  PRIO5=05000 EBANK5=02400

TRIMGIMB        TC      DOWNFLAG        # GMBDRVSW FLAG IS SET WHEN EITHER ROLL OR
                ADRES   GMBDRVSW        # PITCH IS COMPLETED, WHICHEVER IS FIRST.

                CS      PRIO5           # TURN OFF - PITCH, - ROLL, IF ON.
                EXTEND
                WAND    CHAN12
                CAF     EBANK5          # TURN ON + PITCH, + ROLL.
                EXTEND
                WOR     CHAN12
                TC      FIXDELAY        # WAIT ONE MINUTE TO MAKE SURE ENGINE IS
                DEC     6000            # AT FULL + PITCH AND FULL + ROLL
                CS      EBANK5          # TURN OFF + PITCH, + ROLL.
                EXTEND
                WAND    CHAN12
                CAF     PRIO5           # TURN ON - PITCH, - ROLL.
                EXTEND
                WOR     CHAN12
                CAE     PITTIME         # GET TIME TO SHUT OFF - PITCH AND SET UP
                TC      TWIDDLE         # TWIDDLE-TASK TO TURN IT OFF THEN
                ADRES   PITCHOFF

                CAE     ROLLTIME        # GET TIME TO SHUT OFF - ROLL AND GO AWAY
                TC      VARDELAY        # UNTIL THEN
                CS      BIT12
                EXTEND
                WAND    CHAN12          # SHUT OFF ROLL
ROLLOVER        CA      FLAGWRD6        # IF HERE INLINE (ROLL DONE) IS PITCH DONE
                MASK    GMBDRBIT        # IF HERE FROM PITCHOFF, IS ROLL DONE?
                EXTEND
                BZF     PITCHOFF +4     # NO.  SET FLAG, ROLL OR PITCH DONE.
                CAF     PRIO10          # RETURN TO R03
                TC      NOVAC
                EBANK=  WHOCARES
## Page 768
                2CADR   TRIMDONE

                TC      TASKOVER
PITCHOFF        CS      BIT10
                EXTEND
                WAND    CHAN12          # SHUT OFF PITCH
                TCF     ROLLOVER        # SEE IF ROLL HAS FINISHED ALSO.
                TC      UPFLAG          # ROLL DONE; OR PITCH DONE; BUT NOT BOTH.
                ADRES   GMBDRVSW
                TC      TASKOVER

## Page 769
# SUBROUTINE NAME: S41.1          MOD. NO. 0  DATE: FEBRUARY 28, 1967

#                         MOD. NO. 1  DATE: JANUARY 23, 1968: BY PETER ADLER (MIT/IL)

# AUTHOR: JONATHAN D. ADDELSTON (ADAMS ASSOCIATES)

# S41.1 PERFORMS THE COORDINATE SYSTEM TRANFORMATION FROM THE REFERENCE FRAME TO THE BODY OF THE LM.
# SPECIFICALLY, IT IS USED TO TRANSFORM A VELOCITY (SCALED AT 2(+7) METERS/CENTISECOND) FROM REFERENCE TO LM AXIS
# COORDINATES.  FIRST THE VECTOR IS TRANSFORMED TO THE STABLE MEMBER COORDINATES BY THE MATRIX REFSMMAT.  THIS
# LEAVES THE VECTOR IN MPAC, SCALED AT 2(+8) METERS/CENTISECOND.  THEN
# THE SUBROUTINE CDUTRIG IS CALLED TO SET UP THE DOUBLE-PRECISION CDU VECTOR ALONG WITH ITS SINES AND COSINES.
# THE VECTOR IS THEN TRANSFORMED FROM STABLE MEMBER COORDINATES TO SPACECRAFT (OR LM) COORDINATES BY THE
# SUBROUTINE *SMNB*.  FINALLY( THE VECTOR IS RESCALED TO 2(+7) METERS/CENTISECOND, AND CONTROL IS RETURNED TO THE
# CALLER WITH C(MPAC) = VELOCITY(LM).


# CALLING SEQUENCE:
#                                         L        VLOAD  CALL
#                                         L +1            VELOCITY(REF)   SCALED AT 2(+7)M/CS IN REFERENCE COORDS.
#                                         L +2            S41.1
#                                         L +3     STORE  VELOCITY(LM)    SCALED AT 2(+7)M/CS IN LM BODY AXIS SYS.

# SUBROUTINES CALLED:

#          1.  CDUTRIG,
#                 WHICH CALLS CDULOGIC.
#          2.  *SMNB*

# NORMAL RETURN: L +3 (SEE CALLING SEQUENCE, ABOVE.)

# ALARM/ABORT MODES: NONE.

# RESTART PROTECTION: NONE.

## Page 770
# INPUT:

#          1.  REFSMMAT.
#          2.  CDUX, CDUY, CDUZ.
#          3.  VELOCITY (REF) IN MPAC.

# OUTPUT:

#          1.  CDUSPOT:  DOUBLE PRECISION CDU VECTOR, ORDERED Y,Z,X.
#          2.  SINCDU:   HALF SINES OF CDUSPOT COMPONENTS.
#          3.  COSCDU:   HALF COSINES OF CDUSPOT COMPONENTS.
#          4.  MPAC:     VELOCITY(LM) (SCALED AT 2(+7) METERS/CENTISECOND)
#
# DEBRIS: NONE.

# CHECKOUT STATUS:  CODED.

                COUNT*  $$/S41.1
S41.1           MXV     VSL1            # CONVERT VECTOR IN MPAC FROM REF AT 2(+7)
                        REFSMMAT        # TO SM AND RESCALE DUE TO HALFUNIT MATRIX
                GOTO                    # CONVERT TO BODY AT 2(+7) USING PRESENT
                        CDU*SMNB        # CDU ANGLES.  CDU*SMNB WILL RETURN
                                        # VIA RVQ TO THE CALLER OF S41.1
