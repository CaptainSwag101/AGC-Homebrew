### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    P-AXIS_RCS_AUTOPILOT.agc
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
## Reference:   pp. 1409-1429
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2017-07-28 MAS  Created from Luminary 210.
##              2017-08-22 MAS  Updated for Zerlina 56.
##              2021-05-30 ABS  +8 -> +8D

## Page 1409
                BANK            16
                SETLOC          DAPS1
                BANK

                EBANK=          PERROR
                COUNT*          $$/DAPP

# THE FOLLOWING T5RUPT ENTRY BEGINS THE PROGRAM WHICH CONTROLS THE P-AXIS ACTION OF THE LEM USING THE RCS JETS.
# THE NOMINAL TIME BETWEEN THE P-AXIS RUPTS IS 100 MS IN ALL NON-IDLING MODES OF THE DAP.

PAXIS           CA              MS100
                ADS             TIME5                   # *** NECESSARY IN ORDER TO ALLOW SYN-
                                                        # CHRONIZATION WITH OTHER INTERRUPTS ***

                LXCH            BANKRUPT                # INTERRUPT LEAD IN (CONTINUED)
                EXTEND
                QXCH            QRUPT

# CHECK IF DAP PASS IS PERMISSIBLE

                CCS             DAPZRUPT                # IF DAPZRUPT POSITIVE, DAP (JASK) IS
                TC              BAILOUT                 #    STILL IN PROGRESS AND A RESTART IS
                OCT             32000                   #   CALLED FOR.  IT IS NEVER ZERO

                TC              CHEKBITS                # RETURN IS TO I+1 IF DAP SHOULD STAY ON.

                CA              CDUX                    # READ AND STORE CDU'S
                TS              DAPTREG4
                CA              CDUY
                TS              DAPTREG5
                CA              CDUZ
                TS              DAPTREG6
# ***** KALCMANU-DAP AND "RATE-HOLD"-DAP INTERFACE *****

# THE FOLLOWING SECTION IS EXECUTED EVERY 100 MS (10 TIMES A SECOND) WITHIN THE P-AXIS REACTION CONTROL SYSTEM
# AUTOPILOT (WHENEVER THE DAP IS IN OPERATION).

                CA              CDUXD
                EXTEND
                MSU             DELCDUX
                TC              1STOTWOS
                TS              CDUXD
                CA              CDUYD
                EXTEND
                MSU             DELCDUY
                TC              1STOTWOS
                TS              CDUYD
                CA              CDUZD
                EXTEND
                MSU             DELCDUZ

## Page 1410
                TC              1STOTWOS
                TS              CDUZD
                EXTEND                                  # DIMINISH MANUAL CONTROL DIRECT RATE
                DIM             TCP                     # TIME COUNTERS.
                EXTEND
                DIM             TCQR
#                                         RATELOOP COMPUTES JETRATEQ, JETRATER, AND 1JACC*NO. PJETS IN ITEMP1.
#                                           RETURNS TO BACKP.

#                                           JETRATE = 1JACC*NO.PJETS*TJP  (NOTE TJ IS THE TIME FIRED DURING CSP)

#                                           JETRATEQ= 1JACCQ(TJU*NO.UJETS - TJV*NO.VJETS)

#                                           JETRATER= 1JACCR(TJU*NO.UJETS + TJV*NO.VJETS)

                TCF             PAXFILT                 # PROCEEDS TO RATELOOP AFTER SUPERJOB
1STOTWOS        CCS             A
                AD              ONE
                TC              Q
                CS              A
                TC              Q
SUBDIVDE        EXTEND                                  # OVERFLOW PROCTION ROUTINE TO GIVE
                MP              DAPTEMP3                #   POSMAX OR NEGMAX IF THE DIVIDE WOULD
                DAS             OMEGAU                  #   OVERFLOW

 +3             EXTEND
                DCA             OMEGAU
                DXCH            DAPTEMP5
                CCS             OMEGAU
                TCF             +2
                TCF             DIVIDER
                AD              -OCT630
                EXTEND
                BZMF            DIVIDER

                CCS             OMEGAU
                CA              POSMAX                  # 45 DEG/SEC
                TC              Q
                CS              POSMAX
                TC              Q

DIVIDER         DXCH            OMEGAU
                EXTEND
                DV              DAPTREG4
                TC              Q

OVERSUB         TS              7                       # RETURNS A UNCHANGED OR LIMITED TO
                TC              Q                       #   POSMAX OR NEGMAX IF A HAS OVERFLOW
                INDEX           A
                CS              BIT15           -1

## Page 1411
                TC              Q

-OCT630         OCT             77147

BACKP           CA              DAPTEMP1
                EXTEND
                MP              1JACC
                TS              JETRATE
#                                         BEGINNING OF THE RATE DERIVATION
#                                         OMEGAP,Q,R      BODY RATES SCALED AT PI/4
#                                         TRAPER,Q,R      BODY ANGLE ERRORS FROM PREDICTED ANGLE (PI/40)
#                                         NP(QR)TRAPS     NUMBER OF TIMES ANGLE ERROR HAS BEEN ACCUMULATED
#                                         AOSQ(R)TERM     CHANGE IN RATE DUE TO OFFSET ACCELLERATION. (PI/4)
#                                         JETRATE,Q,R     CHANGE IN RATE DUE TO  JET   ACCELLERATION. (PI/4)
#                                         TRAPSIZE        NEGATIVE LIMIT OF MAGNITUDE OF TRAPEDP,ECT.
#                                         OMEGAU          DP-TEMPORARY STORAGE

#                                             OMEGA = OMEGA + JETRATE + AOSTERM (+TRAPED/NTRAPS IF TRAPED BIG)

                CAE             DAPTREG4                # CDUX IS STORED HERE
                TS              L
                EXTEND
                MSU             OLDXFORP                # SCALED AT PI
                LXCH            OLDXFORP
                TS              DAPTEMP1
                CA              1/40
                TS              DAPTREG4
                CS              JETRATE
                EXTEND
                MP              BIT14
                ADS             TRAPEDP
                CA              JETRATEQ
                AD              AOSQTERM
                EXTEND
                MP              -BIT14
                ADS             TRAPEDQ
                CA              JETRATER
                AD              AOSRTERM
                EXTEND
                MP              -BIT14
                ADS             TRAPEDR

                CA              DAPTREG5                # CDUY IS STORED HERE
                TS              L
                EXTEND
                MSU             OLDYFORP                # SCALED AT PI
                LXCH            OLDYFORP
                TS              DAPTEMP2
                EXTEND
                MP              M11                     # M11 SCALED AT 1
## Page 1412
                AD              DAPTEMP1
                DXCH            OMEGAU

                TC              SUBDIVDE +3             # RETURNS WITH CDU-RATE AT PI/4

                EXTEND
                SU              OMEGAP
                ADS             TRAPEDP
                TC              OVERSUB
                TS              TRAPEDP
                EXTEND
                DCA             DAPTEMP5
                DAS             DXERROR
                CS              PLAST
                EXTEND
                MP              1/40
                DAS             DXERROR                 # MANUAL MODE X-ATTITUDE ERROR (DP)
                CA              DAPTREG6                # CDUZ IS STORED HERE
                TS              L
                EXTEND
                MSU             OLDZFORQ
                TS              DAPTEMP3
                LXCH            OLDZFORQ
                CA              M21
                EXTEND
                MP              DAPTEMP2
                DXCH            OMEGAU
                CA              M22
                TC              SUBDIVDE

                EXTEND
                SU              OMEGAQ
                ADS             TRAPEDQ
                TC              OVERSUB
                TS              TRAPEDQ
                EXTEND
                DCA             DAPTEMP5
                DAS             DYERROR
                CS              QLAST
                EXTEND
                MP              1/40
                DAS             DYERROR                 # MANUAL MODE Y-ATTITUDE ERROR (DP)
                CA              M31
                EXTEND
                MP              DAPTEMP2
                DXCH            OMEGAU
                CA              M32

                TC              SUBDIVDE
## Page 1413
                EXTEND
                SU              OMEGAR
                ADS             TRAPEDR
                TC              OVERSUB
                TS              TRAPEDR                 # TRAPEDS HAVE ALL BEEN COMPUTED

                EXTEND
                DCA             DAPTEMP5
                DAS             DZERROR
                CS              RLAST
                EXTEND
                MP              1/40
                DAS             DZERROR                 # MANUAL MODE Z-ATTITUDE ERROR (DP)
                CA              DAPBOOLS                # PICK UP PAD LOADED STATE ESTIMATOR GAINS
                MASK            CSMDOCKD
                EXTEND
                BZF             LMONLY
                EXTEND                                  #    DOCKED
                DCA             DKOMEGAN
                DXCH            DAPTREG4
                CA              DKTRAP
                TCF             +5
LMONLY          EXTEND                                  #    UNDOCKED
                DCA             LMOMEGAN
                DXCH            DAPTREG4
                CA              LMTRAP
 +5             TS              DAPTREG6
                CCS             TRAPEDP
                TCF             +2
                TCF             SMALPDIF
                AD              DAPTREG6                # TRAPSIZE > ABOUT 77001 %-1.4DEG/SEC"
                EXTEND
                BZMF            SMALPDIF
                ZL
                LXCH            TRAPEDP
                CA              ZERO
                EXTEND
                DV              NPTRAPS
                ADS             OMEGAP
                TC              OVERSUB
                TS              OMEGAP
                CA              DAPTREG4                # ABOUT 10 OR 0 FOR DOCKED OR UNDOCKED
                TS              NPTRAPS
SMALPDIF        INCR            NPTRAPS
P-RATE          CA              JETRATE
                ADS             OMEGAP
                TC              OVERSUB
                TS              OMEGAP

                CCS             TRAPEDQ
## Page 1414
                TCF             +2
                TCF             Q-RATE
                AD              DAPTREG6                # TRAPSIZE > ABOUT 77001 %-1.4DEG/SEC"
                EXTEND
                BZMF            Q-RATE
                ZL
                LXCH            TRAPEDQ
                CA              ZERO
                EXTEND
                DV              NQTRAPS
                TS              DAPTEMP1                # SAVE FOR OFFSET ESTIMATE
                ADS             OMEGAQ
                TC              OVERSUB
                TS              OMEGAQ
                CA              DAPTREG4                # ABOUT 10 OR 0 FOR DOCKED OR UNDOCKED
                XCH             NQTRAPS
                AD              DAPTREG5                # KAOS > ABOUT 60D %N/N_60"
                XCH             DAPTEMP1
                EXTEND
                MP              FIVE
                EXTEND
                DV              DAPTEMP1
                ADS             AOSQ
Q-RATE          INCR            NQTRAPS
                CA              JETRATEQ
                AD              AOSQTERM
                ADS             OMEGAQ
                TC              OVERSUB
                TS              OMEGAQ

                CCS             TRAPEDR
                TCF             +2
                TCF             R-RATE
                AD              DAPTREG6                # TRAPSIZE > ABOUT 77001 %-1.4DEG/SEC"
                EXTEND
                BZMF            R-RATE
                ZL
                LXCH            TRAPEDR
                CA              ZERO
                EXTEND
                DV              NRTRAPS
                TS              DAPTEMP2                # SAVE FOR OFFSET ESTIMATE
                ADS             OMEGAR
                TC              OVERSUB
                TS              OMEGAR
                CA              DAPTREG4                # ABOUT 10 OR 0 FOR DOCKED OR UNDOCKED
                XCH             NRTRAPS
                AD              DAPTREG5                # KAOS > ABOUT 60D %N/N_60"
                XCH             DAPTEMP2
                EXTEND
## Page 1415
                MP              FIVE
                EXTEND
                DV              DAPTEMP2
                ADS             AOSR
R-RATE          INCR            NRTRAPS
                CA              JETRATER
                AD              AOSRTERM
                ADS             OMEGAR
                TC              OVERSUB
                TS              OMEGAR

#                                         END OF RATE DERIVATION

#                                          BEGIN OFFSET ESTIMATER

#                                           IN POWERED FLIGHT, AOSTASK WILL BE CALLED EVERY 2 SECONDS.

#                                           AOS = AOS + K*SUMRATE

                CS              DAPBOOLS
                MASK            DRIFTBIT
                CCS             A
                TCF             WORKTIME
                TS              ALPHAQ                  # ZERO THE OFFSET ACCELERATION VALUES.
                TS              ALPHAR
                TS              AOSQTERM
                TS              AOSRTERM
                TS              AOSQ
                TS              AOSR
                TCF             PRETIMCK
KAOS            DEC             60
WORKTIME        CA              QACCDOT
                EXTEND
                MP              CALLCODE                # OCTAL 00032 IS DECIMAL .1 AT 2(6).
                DAS             AOSQ
                CA              AOSQ
                TS              ALPHAQ
                EXTEND
                MP              200MS                   #  .2 AT 1
                TS              AOSQTERM
                CA              RACCDOT
                EXTEND
                MP              CALLCODE                # OCTAL 00032 IS DECIMAL .1 AT 2(6).
                DAS             AOSR
                CA              AOSR
                TS              ALPHAR
                EXTEND
                MP              200MS                   #  .2 AT 1
                TS              AOSRTERM
                TCF             PRETIMCK

## Page 1416
#

PAXFILT         CA              CALLGMBL                # EXECUTE ACDT+C12, IF NEEDED.
                MASK            RCSFLAGS
                CCS             A                       # CALLGMBL IS NOT BIT15, SO THIS TEST IS
                TC              ACDT+C12                # VALID.

                DXCH            ARUPT
                DXCH            DAPARUPT
                CA              SUPERJOB                # SETTING UP THE SUPERJOB
                XCH             BRUPT
                LXCH            QRUPT
                DXCH            DAPBQRPT
                CA              SUPERADR
                DXCH            ZRUPT
                DXCH            DAPZRUPT
                TCF             NOQBRSM         +1      # RELINT (JUST IN CASE) AND RESUME, IN THE
                                                        #   FORM OF A JASK, AT SUPERJOB.

SUPERADR        GENADR          SUPERJOB        +1
# COUNT DOWN GIMBAL DRIVE TIMERS AND TURN OFF DRIVES IF REQUIRED.

SUPERJOB        TCF             RATELOOP
PRETIMCK        CCS             QGIMTIMR
                TCF             DECQTIMR                #   POSITIVE- COUNTING DOWN
                TCF             TURNOFFQ                #   NEGATIVE- DRIVE SHOULD BE ENDED
CHKRTIMR        CCS             RGIMTIMR                #   NEGATIVE- INACTIVE
                TCF             DECRTIMR                #  (NEG ZERO- IMPOSSIBLE)
                TCF             TURNOFFR                # REPEATED (ABOVE) FOR R AXIS.

                EXTEND                                  # DECREMENT DOCKED JET INHIBITION COUNTERS
                DIM             PJETCTR
                EXTEND
                DIM             UJETCTR
                EXTEND
                DIM             VJETCTR
                CA              BIT12
                MASK            RCSFLAGS
                EXTEND
                BZF             SKIPPAXS
                TC              CHKVISFZ
DECQTIMR        TS              QGIMTIMR                # COUNT TIMERS DOWN TO POS ZERO.
                TCF             CHKRTIMR
DECRTIMR        TS              RGIMTIMR
                TCF             CHKRTIMR        +3

TURNOFFQ        TS              NEGUQ                   # HALT DRIVES.
                TS              QACCDOT
                CS              QGIMBITS
                EXTEND
## Page 1417
                WAND            CHAN12
                CAF             NEGMAX
                TS              QGIMTIMR
                TCF             CHKRTIMR
TURNOFFR        TS              NEGUR
                TS              RACCDOT
                CS              RGIMBITS
                EXTEND
                WAND            CHAN12
                CAF             NEGMAX
                TS              RGIMTIMR
                TCF             CHKRTIMR        +3
QGIMBITS        EQUALS          OCT1400                 # BITS 9 AND 10 (OF CHANNEL 12).
RGIMBITS        EQUALS          PRIO6                   # BITS 11 AND 12 (OF CHANNEL 12).

SKIPPAXS        CS              RCSFLAGS
                MASK            BIT12
                ADS             RCSFLAGS                # BIT 12 SET TO 1.
                TCF             QRAXIS                  # GO TO QRAXIS OR TO GTS.

#                                         Y-Z TRANSLATION

#                                         INPUT:  BITS 9-12 OF CH31 (FROM TRANSLATION CONTROLER)

#                                         OUTPUT: NEXTP

#                                           NEXTP IS THE CHANNEL 6 CODE OF JETS FOR THE DESIRED TRANSLATION.
#                                           IF THERE ARE FAILURES IN THE DESIRED POLICY, THEN

#                                              (1) FOR DIAGONAL TRANS:  UNFAILED PAIR
#                                                                       ALARM (IF NO PAIR)

#                                              (2) FOR PRINCIPAL TRANS: TRY TO TACK WITH DIAGONAL PAIRS
#                                                                       ALARM (IF DIAGONAL PAIRS ARE FAILED)
CHKVISFZ        EXTEND
                READ            CHAN31
                CS              A
                MASK            07400OCT
                EXTEND
                BZF             TSNEXTP
                EXTEND
                MP              BIT7
                INDEX           A
                CA              INDXYZ
                TS              ROTINDEX
TRYUORV         CA              SIX
                TC              SELECTYZ
                CS              SIX
                AD              NUMBERT
                EXTEND
## Page 1418
                BZF             TSNEXTP         -1
                CS              FIVE
                AD              ROTINDEX
                EXTEND
                BZMF            ALTERYZ
                CS              NUMBERT
                AD              FOUR
                EXTEND
                BZMF            TSNEXTP         -1
ABORTYZ         TC              ALARM
                OCT             02001
                CA              BIT1                    # INVERT BIT 1 OF RCSFLAGS.
                LXCH            RCSFLAGS
                EXTEND
                RXOR            1
                TS              RCSFLAGS
                CA              ZERO
                TCF             TSNEXTP
ALTERYZ         CA              BIT1                    # INVERT BIT 1 OF RCSFLAGS.
                LXCH            RCSFLAGS
                EXTEND
                RXOR            1
                TS              RCSFLAGS
                MASK            BIT1
                AD              FOUR
                ADS             ROTINDEX
                TCF             TRYUORV
                CA              POLYTEMP
TSNEXTP         TS              NEXTP
#                                         STATE LOGIC

#                                           CHECK IN ORDER:               IF ON
#                                             LPDPHASE                    GO TO PURGENCY
#                                             PULSES                      MINIMUM PULSE LOGIC
#                                             DETENT(BIT15 CH31)          RATE COMMAND
#                                             GO TO PURGENCY
                CA              BIT13                   # CHECK STICK IF IN ATT. HOLD.
                EXTEND
                RAND            CHAN31
                EXTEND
                BZF             MANMODE

                CA              DAPBOOLS
                MASK            XOVINHIB
                CCS             A
                TCF             PURGENCY                # ATTITUDE STEER DURING VISIBILITY PHASE

                TCF             DETENTCK
MANMODE         CA              PULSES                  # PULSES IS ONE FOR PULSE MODE
                MASK            DAPBOOLS
## Page 1419
                EXTEND
                BZF             DETENTCK                # BRANCH FOR RATE COMMAND

                CA              ZERO
                TS              PERROR
# MINIMUM IMPULSE MODE

                CA              CDUX
                TS              CDUXD

                CCS             OLDPMIN
                TCF             CHECKP

FIREP           CA              BIT3
                EXTEND
                RAND            CHAN31
                EXTEND
                BZF             +XMIN

                CA              BIT4
                EXTEND
                RAND            CHAN31
                EXTEND
                BZF             -XMIN

                TCF             JETSOFF

CHECKP          EXTEND
                READ            CHAN31
                CS              A
                MASK            OCT14
                TS              OLDPMIN
                TCF             JETSOFF

-XMIN           CS              TEN                     # ANYTHING LESS THAN 14MS.  CORRECTED
                TCF             +2                      #   IN JET SELECTION ROUTINE
+XMIN           CA              TEN
                TS              TJP
                CA              ONE
                TS              OLDPMIN
                TCF             PJETSLEC        -6

#                 MANUAL RATE COMMAND MODE
#                 ========================
#                   BY ROBERT F. STENGEL
#
# THIS MODE PROVIDES RCAH MANUAL CONTROL THRU 2 CONTROL LAWS:                   1) DIRECT RATE AND 2) PSEUDO-AUTO.
# THE DIRECT RATE MODE AFFORDS IMMEDIATE CONTROL WITHOUT OVERSHOOT. THE PSEUDO-AUTO MODE PROVIDES PRECISE
# RATE CONTROL AND ATTITUDE HOLD.
#
## Page 1420
# IN DIRECT RATE, JETS ARE FIRED WHEN STICK POSITION CHANGES BY A FIXED NUMBER OF INCREMENTS IN ONE DAP CYCLE.
# THE 'BREAKOUT LEVEL' IS .6 D/S FOR LM-ONLY AND .3 D/S FOR CSM-DOCKED. THIS LAW NULLS THE RATE ERROR TO WITHIN
# THE 'TARGET DEADBAND', WHICH EQUALS THE BREAKOUT LEVEL.
# IN PSEUDO-AUTO, BODY-FIXED RATE AND ATTITUDE ERRORS ARE SUPPLIED TO TJETLAW, WHICH EXERCISES CONTROL.
# CONTROL SWITCHES FROM DIRECT RATE TO PSEUDO-AUTO IF THE TARGET DB IS ACHIEVED OR IF TIME IN (1) EXCEEDS 4 SEC.
# IF THE INITIAL COMMAND DOES NOT EXCEED THE BREAKOUT LEVEL, CONTROL GOES TO PSEUDO-AUTO IMMEDIATELY.
#
# SINCE P-AXIS CONTROL IS SEPARATE FROM Q,R AXES CONTROL, IT IS POSSIBLE TO USE (1) IN P-AXIS AND (2) IN Q,R AXES,
# OR VICE VERSA.  THIS ALLOWS A DEGREE OF ATTITUDE HOLD IN UNCONTROLLED AXES.  DUE TO U,V CONTROL, HOWEVER, Q AND
# R AXES ARE COUPLED AND MUST USE THE SAME CONTROL LAW.
#
# HAND CONTROLLER COMMANDS ARE SCALED BY A LINEAR/QUADRATIC LAW. FOR THE LM-ALONE, MAXIMUM COMMANDED RATES ARE 20
# AND 4 D/S IN NORMAL AND FINE SCALING; HOWEVER, STICK SENSITIVITY AT ZERO COUNTS (OBTAINED AT A STICK DEFLECTION
# OF 2 DEGREES FROM THE CENTERED POSITION) IS .5 OR .1 D/S PER DEGREE. NORMAL AND FINE SCALINGS FOR THE CSM-DOCKED
# CASE IS AUTOMATICALLY SET TO 1/10 THE ABOVE VALUES. SCALING IS DETERMINED IN ROUTINE 3.
#                                         ZEROENBL        ENABLES COUNTERS SO THEY CAN BE READ NEXT TIME
#                                         JUSTOUT         FIRST DETECTION OF OUT OF DETENT (BY OURRCBIT)


DETENTCK        EXTEND
                READ            CHAN31
                TS              CH31TEMP
                MASK            BIT15                   # CHECK OUT-OF-DETENT BIT.
                EXTEND
                BZF             RHCMOVED                # BRANCH IF OUT OF DETENT.
                CAF             OURRCBIT                # IN DETENT. CHECK THE RATE COMMAND BIT.
                MASK            DAPBOOLS
                EXTEND
                BZF             PURGENCY                # BRANCH IF NOT IN RATE COMMAND LAST PASS.
# ........................................................................
                CA              BIT9                    # JUST IN DETENT??
                MASK            RCSFLAGS
                EXTEND
                BZF             RUTH
                CAF             BIT13                   # CHECK FOR ATTITUDE HOLD.
                EXTEND
                RAND            CHAN31
                EXTEND
                BZF             RATEDAMP                # BRANCH IF IN ATTITUDE HOLD.

                CS              BITS9,11                # IN AUTO.
                MASK            RCSFLAGS                # (X-AXIS OVERRIDE)
                TS              RCSFLAGS                # ZERO ORBIT (BIT 11) AND JUST-IN BIT (9).
                TCF             RATEDAMP

RUTH            CA              RCSFLAGS
                MASK            PBIT                    # IN ATTITUDE HOLD.
                EXTEND
                BZF             +2                      # BRANCH IF P-RATE DAMPING IS FINISHED.
                TCF             RATEDAMP
## Page 1421
                CA              RCSFLAGS
                MASK            QRBIT
                EXTEND
                BZF             RATEDONE                # BRANCH IF Q,R RATE DAMPING IS FINISHED.
                TCF             RATEDAMP
# ============================================
1/10SEC         =               BIT1
40CYC           =               OCT50
PQRBIT          OCT             74777
BITS9,11        EQUALS          EBANK5
LINRATP         DEC             46
# ============================================
RATEDONE        CS              OURRCBIT                # MANUAL COMMAND AND DAMPING COMPLETED IN
                INHINT                                  # ALL AXES.
                MASK            DAPBOOLS
                TS              DAPBOOLS

# READ CDUS INTO CDU DESIRED REGISTERS

                CAF             BIT13
                EXTEND
                RAND            CHAN31
                EXTEND
                BZF             +4
                CA              CDUX                    # (X-AXIS OVERRIDE)
                TS              CDUXD
                TC              +3
                TC              IBNKCALL
                FCADR           ZATTEROR
                RELINT
                TCF             PURGENCY

JUSTOUT         TS              PERROR                  # INITIALIZATION - FIRST MANUAL PASS (A=0)
                TS              DXERROR
                TS              DXERROR         +1
                TS              DYERROR
                TS              DYERROR         +1
                TS              DZERROR
                TS              DZERROR         +1
                TS              PLAST
                TS              QLAST
                TS              RLAST
                TS              Q-RHCCTR
                TS              R-RHCCTR
                CA              PQRBIT
                MASK            RCSFLAGS
                TS              RCSFLAGS                # BITS 10 AND 11 OF RCSFLAGS ARE 0.
                TC              ZEROENBL
                CA              OURRCBIT                # SET INTERNAL RATE COMMAND FLAG (WHICH
                ADS             DAPBOOLS                #   WAS FOUND TO BE ZERO EARLIER)
## Page 1422
                RELINT
                TCF             JETSOFF
ZEROENBL        LXCH            R-RHCCTR
                CA              Q-RHCCTR
                DXCH            SAVEHAND
                CA              ZERO
                TS              P-RHCCTR
                TS              Q-RHCCTR
                TS              R-RHCCTR
                INHINT
                EXTEND
                QXCH            C13QSAV
                TC              C13STALL

                CA              BITS8,9
                EXTEND
                WOR             CHAN13                  # COUNTERS ZEROED AND ENABLED
                TC              C13QSAV

RATEDAMP        CA              ZERO
                TS              P-RHCCTR
                TCF             RATERROR

RHCMOVED        CS              RCSFLAGS                # SET JUSTIN BIT TO 1
                MASK            BIT9
                ADS             RCSFLAGS
                CA              OURRCBIT                # P CONTROL
                MASK            DAPBOOLS
                EXTEND
                BZF             JUSTOUT
RATERROR        CA              CDUX                    # FINDCDUW REQUIRES THAT CDUXD=CDUX DURING
                TS              CDUXD                   # X-AXIS OVERRIDE
                CCS             P-RHCCTR
                TCF             +3
                TCF             +2
                TCF             +1
                DOUBLE                                  # LINEAR/QUADRATIC CONTROLLER SCALING
                DOUBLE                                  # (SEE EXPLANATION IN Q,R-AXES RCS
                AD              LINRATP                 #  AUTOPILOT)
                EXTEND
                MP              P-RHCCTR
                CA              L
                EXTEND
                MP              STIKSENS
                XCH             PLAST
                COM
                AD              PLAST
                TS              DAPTEMP1
                TC              ZEROENBL                # INTERVAL.  ZERO AND ENABLE ACA COUNTERS.
                RELINT
## Page 1423
                CS              PLAST
                AD              OMEGAP
                TS              EDOTP
                CCS             DAPTEMP1                # IF P COMMAND CHANGE EXCEEDS BREAKOUT
                TCF             +3                      # LEVEL, GO TO DIRECT RATE CONTROL. IF NOT
                TCF             +8D                     # CHECK FOR DIRECT RATE CONTROL LAST TIME.
                TCF             +1
                AD              -RATEDB
                EXTEND
                BZMF            +4
                CA              40CYC
                TS              TCP
                TC              PEGI
                CA              RCSFLAGS                # CHECK FOR DIRECT RATE COMMAND LAST TIME.
                MASK            PBIT
                EXTEND
                BZF             +2
                TC              PEGI                    # TO PURE RATE COMMAND
                CA              DXERROR                 # PSEUDO-AUTO CONTROL.
                TS              E                       # X-ATTITUDE ERROR (SP)
                TS              PERROR                  # LOAD P-AXIS ERROR FOR MODE1 FDAI DISPLAY
                TC              PURGENCY        +4
PEGI            CA              CDUX                    # DIRECT RATE CONTROL.
                TS              CDUXD
                CA              ZERO
                TS              DXERROR
                TS              DXERROR         +1
                TS              PERROR                  # ZERO P-AXIS ERROR FOR MODE1 FDAI DISPLAY
                CCS             EDOTP
                TC              +3
                TC              +2
                TC              +1
                TS              ABSEDOTP
                AD              TARGETDB
                EXTEND                                  # IF RATE ERROR IS LESS THAN DEADBAND,
                BZMF            LAST                    # FIRE, AND SWITCH TO PSEUDO-AUTO.
                CA              TCP
                EXTEND                                  # IF TIME IN RATE COMMAND EXCEEDS 4 SEC.,
                BZMF            LAST
                CS              RCSFLAGS
                MASK            PBIT
                ADS             RCSFLAGS                # BIT 10 IS 1.
                TCF             +4
LAST            CS              PBIT
                MASK            RCSFLAGS
                TS              RCSFLAGS                # BIT 10 IS 0.
                CS              EDOTP
                EXTEND
                MP              1/ANETP                 # 1/2JTACC SCALED AT 2EXP(7)/PI
                DAS             A
## Page 1424
                TC              OVERSUB
                EXTEND
                MP              25/32                   # A CONTAINS TJET SCALED AT 2EXP(4)(16/25)
                TS              TJP                     # 4.JET TIME
                CA              ABSEDOTP
                AD              -2JETLIM                # COMPARING DELTA RATE WITH 2 JET LIMIT
                EXTEND
                BZMF            +3

                CA              SIX
                TCF             +8D
                CA              TJP
                ADS             TJP
#                                          GOES TO PJETSLEC FOR TWO JETS

#                                         P-JET-SELECTION-ROUTINE (ROTATION)

#                                         INPUT:   NUMBERT     4,5,6 FOR WHICH PAIR OR 4 JETS
#                                                  TJP         + FOR +P ROTATION

#                                         OUTPUT:  CHANNEL 6
#                                                  PJUMPADR              FOR P-AXIS SKIP
#                                                  (JTLST CALL)          (SMALL TJP)

#                                           ORDER OF POLICIES TRIED IN CASE OF FAILURE.
#                                                  +P             -P
#                                                  7,15           8,16
#                                                  4,12           3,11
#                                                  4,7            8,11
#                                                  7,12           11,16
#                                                  12,15          3,16
#                                                  4,15           3,8
#                                                  ALARM          ALARM
                CA              AORBSYST
                MASK            FLAGWRD5
                CCS             A
                CA              ONE
                AD              FOUR
                TS              NUMBERT
PJETSLEC        CA              ONE
                TS              L
                CCS             TJP
                TCF             +5
                TCF             JETSOFF
                TCF             +2
                TCF             JETSOFF
                ZL
                AD              ONE
                TS              ABSTJ
                LXCH            ROTINDEX
## Page 1425
                TC              SELECTP
                CS              SIX
                AD              NUMBERT
                EXTEND
                BZF             +2

                CS              TWO
                AD              FOUR
                TS              NO.PJETS
                CA              POLYTEMP
                TC              WRITEP
                CS              ABSTJ
                AD              +150MST6
                EXTEND
                BZMF            QRAXIS                  # GO TO QRAXIS OR TO GTS.

                AD              -136MST6
                EXTEND
                BZMF            +5

                ADS             ABSTJ
                INDEX           ROTINDEX
                CA              MINTIMES
                TS              TJP

                CA              ABSTJ
                ZL
                INHINT
                DXCH            T6FURTHA
                TC              IBNKCALL
                CADR            JTLST
                CS              BIT12
                MASK            RCSFLAGS
                TS              RCSFLAGS                # BIT 12 SET TO 0.
                TC              ALTSYST
                TCF             QRAXIS

ALTSYST         CA              FLAGWRD5                # ALTERNATE P-AXIS JETS
                TS              L
                CA              AORBSYST
                EXTEND
                RXOR            LCHAN
                TS              FLAGWRD5
                RELINT
                TC              Q

DKALT           TC              ALTSYST

JETSOFF         TC              WRITEP          -1
                CA              ZERO
## Page 1426
                TS              TJP
                TCF             QRAXIS
# (NOTE -- M13 = 1 IDENTICALLY IMPLIES NULL MULTIPLICATION.)

CALCPERR        CA              CDUY                    # P-ERROR CALCULATION.
                EXTEND
                MSU             CDUYD                   # CDU VALUE - ANGLE DESIRED (Y-AXIS)
                EXTEND
                MP              M11                     # (CDUY-CDUYD)M11 SCALED AT PI RADIANS
                XCH             E                       # SAVE FIRST TERM (OF TWO)
                CA              CDUX                    # THIRD COMPONENT
                EXTEND
                MSU             CDUXD                   # CDU VALUE - ANGLE DESIRED (X-AXIS)
#               EXTEND
#               MP      M13
                AD              DELPEROR                # KALCMANU INERFACE ERROR
                ADS             E                       # SAVE SUM OF TERMS.  COULD BE OVERFLOW.
                XCH             PERROR                  # SAVE P-ERROR FOR EIGHT-BALL DISPLAY.
                TC              Q                       # RETURN TO CALLER

# P-AXIS URGENCY FUNCTION CALCULATION.

PURGENCY        TC              CALCPERR                # CALCULATE P-AXIS ERRORS.
                CS              OMEGAPD                 # THIS CODING IS COMMON TO BOTH LM DAP AND
                AD              OMEGAP                  # SPS-BACKUP MODE.
                TS              EDOTP                   # EDOTP = OMEGAP - OMEGAPD AT PI/4 RAD/SEC


                CS              ONE
                TS              AXISCTR
                CA              DAPBOOLS
                MASK            CSMDOCKD
                EXTEND
                BZF             HEADTJET
                INHINT                                  # IF CSMDOCKD = 1, GO TO DOCKED RCS LOGIC
                TC              IBNKCALL
                CADR            SPSRCS

                CA              TJP
                EXTEND
                BZF             DKALT                   # IF TJP = ZERO, CHANGE AORBSYST.
                RELINT
                TCF             PJETSLEC        -6      #    SELECT AORBSYST AND USE TWO JETS
HEADTJET        CA              ZERO
                TS              SENSETYP
                INHINT
                TC              IBNKCALL
                CADR            TJETLAW
                RELINT

## Page 1427
                CS              FIREFCT
                AD              -FOURDEG
                EXTEND
                BZMF            PJETSLEC        -6
                CCS             TJP
                TCF             +2
                TCF             JETSOFF
                AD              -160MST6
                EXTEND
                BZMF            PJETSLEC        -6
                CA              SIX
                TCF             PJETSLEC        -1
-160MST6        DEC             -256
-FOURDEG        DEC             -.08888

## Page 1428
# JET POLICY CONSTRUCTION SUBROUTINE

#                                            INPUT: ROTINDEX, NUMBERT

#                                            OUTPUT: POLYTEMP (JET POLICY)

#                                         THIS SUBROUTINE SELECT A SUBSET OF THE DESIRED JETS WHICH HAS NO FAILURE
SELECTP         CA              SIX
                TS              TEMPNUM
                INDEX           NUMBERT
                CA              TYPEP
                INDEX           ROTINDEX
                MASK            JETSALL
                TS              POLYTEMP
                MASK            CH6MASK
                CCS             A
                TCF             +2
                TC              Q
                CCS             TEMPNUM
                TCF             +4
                TC              ALARM
                OCT             02003
                TCF             JETSOFF                 # *****TCF   ALARMJET *********************
SELECTYZ        TS              NUMBERT
                TCF             SELECTP         +1
 -1             TCF             ABORTYZ         +2
JETSALL         OCT             00252
                OCT             00125                   #   +P
                OCT             00140                   #   -Y
                OCT             00006                   #   -Z
                OCT             00220                   #   +Y
                OCT             00011                   #   +Z
                OCT             00151                   #   +V
TYPEP           OCT             00146                   #   -U
                OCT             00226                   #   -V
                OCT             00231                   #   +U
                OCT             00151                   #   +V
                OCT             00132                   #   1-3
                OCT             00245                   #   2-4
                OCT             00377                   #   ALL
INDXYZ          =               -136MST6
-136MST6        DEC             -218
                DEC             4
                DEC             2
                OCT             07776
                DEC             5
                DEC             9
                DEC             10
                OCT             07776
                DEC             3
## Page 1429
                DEC             8
                DEC             7
                OCT             07776                   # THESE INDEXES OF MASK JETSALL WILL
                OCT             07776                   # CHANGE THE INSTRUCTION AT SELECTP +4
                OCT             07776                   # TO BE    TC  JETSALL -1
                OCT             07776                   # ONLY USED FOR TRANSLATION FAILURE
                OCT             07776
+150MST6        DEC             240
07400OCT        OCT             07400
# T-JET LAW FIXED CONSTANTS

NORMSCL         OCT             266
-100MS          DEC             -.1
200MS           DEC             .2
25/32           =               PRIO31                  # (DEC .78125)
BITS8,9         OCTAL           00600
1/40            DEC             .02500
MINTIMES        DEC             -22
                DEC             22
PSKIPADR        GENADR          SKIPPAXS

#                                         GOES TO Q,R-AXES RCS AUTOPILOT
QRAXIS          CS              OMEGARD
                AD              OMEGAR
                TC              OVERSUB
                TS              EDOTR
                CS              OMEGAQD
                AD              OMEGAQ
                TC              OVERSUB
                TS              EDOTQ
                EXTEND
                DCA             QERRCALL
                DTCB

                EBANK=          AOSQ
QERRCALL        2CADR           CALLQERR

