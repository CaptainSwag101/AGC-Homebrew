### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    THE_LUNAR_LANDING.agc
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
## Reference:   pp. 771-778
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2017-07-28 MAS  Created from Luminary 210.
##              2017-08-24 MAS  Updated for Zerlina 56.

## Page 771
                BANK            32
                SETLOC          F2DPS*32
                BANK

                EBANK=          E2DPS

#                                 ****************************************
#                                 P63: THE LUNAR LANDING, BRAKING PHASE
#                                 ****************************************

                COUNT*          $$/P63

P63LM           TC              PHASCHNG
                OCT             04024

                TC              BANKCALL                # DO IMU STATUS CHECK ROUTINE R02
                CADR            R02BOTH

                CAF             P63ADRES                # INITIALIZE WHICH FOR BURNBABY
                TS              WHICH

                CAF             DPSTHRSH                # INITIALIZE DVMON
                TS              DVTHRUSH
                CAF             FOUR
                TS              DVCNTR

                CS              ONE                     # INITIALIZE WCHPHASE AND FLPASSO
                TS              WCHPHASE

                CA              ZERO
                TS              FLPASS0

                CAF             HLROFFF                 # SET LR CUTOFF ALTITUDE
                TS              HLROFF

                CS              BIT14
                EXTEND
                WAND            CHAN12                  # REMOVE TRACK-ENABLE DISCRETE.

FLAGORGY        TC              INTPRET                 # DIONYSIAN FLAG WAVING
                CLEAR           SET
                                NOTERFLG                # PERMIT TERRAIN MODEL
                                ALW66FLG                # PERMIT P66 SELECTION
                CLEAR           CLEAR
                                NOTHROTL
                                REDFLAG
                CLEAR           SET
                                LRBYPASS
                                MUNFLAG
                CLEAR           CLEAR
## Page 772
                                P25FLAG                 # TERMINATE P25 IF IT IS RUNNING.
                                RNDVZFLG                # TERMINATE P20 IF IT IS RUNNING

                                                        # ****************************************

IGNALG          SETPD           VLOAD                   # FIRST SET UP INPUTS FOR RP-TO-R:-
                                0                       #   AT 0D LANDING SITE IN MOON FIXED FRAME
                                RLS                     #   AT 6D ESTIMATED TIME OF LANDING
                PDDL            PUSH                    #   MPAC NON-ZERO TO INDICATE LUNAR CASE
                                TLAND
                STCALL          TPIP                    # ALSO SET TPIP FOR FIRST GUIDANCE PASS
                                RP-TO-R
                VSL4            MXV
                                REFSMMAT
                STCALL          LAND
                                GUIDINIT                # GUIDINIT INITIALIZES WM AND /LAND/
                DLOAD           DSU
                                TLAND
                                GUIDDURN
                STCALL          TDEC1                   # INTEGRATE STATE FORWARD TO THAT TIME
                                LEMPREC
                SSP             VLOAD
                                NIGNLOOP
                                40D
                                UNITX
                STOVL           CG
                                UNITY
                STOVL           CG              +6
                                UNITZ
                STODL           CG              +14
                                99999CON
                STOVL           DELTAH                  # INITIALIZE DELTAH FOR V16N68 DISPLAY
                                ZEROVECS
                STODL           UNFC/2                  # INITIALIZE TRIM VELOCITY CORRECTION TERM
                                HI6ZEROS
                STORE           TTF/8

IGNALOOP        DLOAD
                                TAT
                STOVL           PIPTIME1
                                RATT1
                VSL4            MXV
## REFSMMAT below is circled in blue pen.
                                REFSMMAT
                STCALL          R
                                MUNGRAV
                STCALL          G
                                ?GUIDSUB                # WHICH DELIVERS N PASSES OF GUIDANCE

# DDUMCALC IS PROGRAMMED AS FOLLOWS:-
## Page 773
#                                       2                                           -
#            (RIGNZ - RGU )/16 + 16(RGU  )KIGNY/B8 + (RGU - RIGNX)KIGNX/B4 + (ABVAL(VGU) - VIGN)KIGNV/B4
#                        2             1                 0
#     DDUM = -------------------------------------------------------------------------------------------
#                                            10
#                                           2   (VGU  - 16 VGU  KIGNX/B4)
#                                                   2         0

# THE NUMERATOR IS SCALED IN METERS AT 2(28).   THE DENOMINATOR IS A VELOCITY IN UNITS OF 2(10)M/CS.
# THE QUOTIENT IS THUS A TIME IN UNITS OF 2(18) CENTISECONDS.   THE FINAL SHIFT RESCALES TO UNITS OF 2(28) CS.
# THERE IS NO DAMPING FACTOR.   THE CONSTANTS KIGNX/B4, KIGNY/B8 AND KIGNV/B4 ARE ALL NEGATIVE IN SIGN.

DDUMCALC        TS              NIGNLOOP
                TC              INTPRET
                DLOAD           DMPR                    # FORM DENOMINATOR FIRST
                                VGU
                                KIGNX/B4
                SL4R            BDSU
                                VGU             +4
                PDDL            DSU
## The value in the following line has a blue arrow drawn in pointing to it.
                                RIGNZ
                                RGU             +4
                SR4R            PDDL
                                RGU             +2
                DSQ             DMPR
## The value in the following line has a blue arrow drawn in pointing to it.
                                KIGNY/B8
                SL4R            PDDL
                                RGU
                DSU             DMPR
## The values in the following two line have blue arrows drawn in pointing to them.
                                RIGNX
                                KIGNX/B4
                PDVL            ABVAL
                                VGU
                DSU             DMPR
## The values in the following two line have blue arrows drawn in pointing to them.
                                VIGN
                                KIGNV/B4
                DAD             DAD
                DAD             DDV
                SRR
                                10D

                PUSH            DAD
                                PIPTIME1
                STODL           TDEC1                   # STORE NEW GUESS FOR NEXT INTEGRATION
                ABS             DSU
                                DDUMCRIT
                BMN             CALL
                                DDUMGOOD
                                INTSTALL
                SET             SET
## Page 774
                                INTYPFLG
                                MOONFLAG
                DLOAD
                                PIPTIME1
                STOVL           TET                     # HOPEFULLY ?GUIDSUB DID NOT
                                RATT1                   #   CLOBBER RATT1 AND VATT1
                STOVL           RCV
                                VATT1
                STCALL          VCV
                                INTEGRVS
                GOTO
                                IGNALOOP

DDUMGOOD        VLOAD           UNIT                    # INITIALIZE KALCMANU
                                UNFC/2
                STOVL           POINTVSM
                                UNITX
                STOVL           SCAXIS                  # NEXT COMPUTE DISTANCE LANDING SITE IS
                                V                       #   OUT OF LM'S ORBITAL PLANE AT IGNITION:
                VXV             UNIT                    #   SIGN IS + IF LANDING SITE IS TO THE
                                R                       #   RIGHT, NORTH; - IF TO THE LEFT, SOUTH.
                DOT             SL1
                                LAND
                STODL           OUTOFPLN                # NEXT COMPUTE TIG
                                ZOOMTIME
                SR              BDSU
                                14D
                                TDEC1
                STORE           TIG
                EXIT
                                                        # ****************************************

IGNALGRT        TC              PHASCHNG                # PREVENT REPEATING IGNALG
                OCT             04024

ASTNCLOK        CS              ASTNDEX
                TC              BANKCALL
                CADR            STCLOK2
                TCF             ENDOFJOB                # RETURN IN NEW JOB AND IN EBANK FIVE

ASTNRET         CAF             EBANK7
                TS              EBANK

                INHINT
                TC              IBNKCALL
                CADR            PFLITEDB
                RELINT

                TC              BANKCALL
                CADR            R60LEM

## Page 775
                TC              PHASCHNG                # PREVENT RECALLING R60
                OCT             04024

P63SPOT3        CA              BIT6                    # IS THE LR ANTENNA IN POSITION 1 YET
                EXTEND
                RAND            CHAN33
                EXTEND
                BZF             P63SPOT4                # BRANCH IF ANTENNA ALREADY IN POSITION 1

                CAF             CODE500                 # ASTRONAUT: PLEASE CRANK THE
                TC              BANKCALL                #            SILLY THING AROUND
                CADR            GOPERF1
                TCF             GOTOPOOH                # TERMINATE
                TCF             P63SPOT3                # PROCEED    SEE IF HE'S LYING

P63SPOT4        CAF             TWO                     # ENTER      INITIALIZE LANDING RADAR
                TS              STILBADH
                TS              STILBADV
                CAF             ZERO
                TS              LRLCTR
                TS              LRMCTR
                TS              LRRCTR
                TS              LRSCTR
                TS              VSELECT

                CA              FOUR                    # INITIALIZE COUNTER TO ISSUE 511
                TS              511CTR                  #   ALARM AFTER 10 SECONDS

                TC              POSTJUMP                # OFF TO SEE THE WIZARD...
                CADR            BURNBABY


#                                 ----------------------------------------

#                                      CONSTANTS FOR P63LM AND IGNALG


P63ADRES        GENADR          P63TABLE


ASTNDEX         =               MD1                     # OCT 25;  INDEX FOR CLOKTASK


CODE500         OCT             00500


99999CON        2DEC            30479.7         B-24

## Page 776
GUIDDURN        2DEC            +66440                  #         GUIDDURN    +6.64400314E+ 2

DDUMCRIT        2DEC            +8              B-28    # CRITERION FOR IGNALG CONVERGENCE



HLROFFF         DEC             15.24           B-10    # LOADED DP, BUT LOW ORDER DOESN'T MATTER


#                                 ----------------------------------------

## Page 777
#                                 ****************************************
#                                 P68: LANDING CONFIRMATION
#                                 ****************************************

                BANK            34
                SETLOC          F2DPS*34
                BANK

                COUNT*          $$/P6567

LANDJUNK        TC              PHASCHNG
                OCT             04024

                INHINT
                TC              BANKCALL                # ZERO ATTITUDE ERROR
                CADR            ZATTEROR

                TC              INTPRET                 # TO INTERPRETIVE AS TIME IS NOT CRITICAL
                SET                                     # PREVENT RCS JET FIRINGS IF MODE CONT IS
                                PULSEFLG                # IN ATT HOLD
                SET             CLEAR
                                SURFFLAG
                                LETABORT
                SET             VLOAD
                                APSFLAG
                                RN
                STODL           ALPHAV
                                PIPTIME
                SET             CALL
                                LUNAFLAG
                                LAT-LONG
                SETPD           VLOAD                   # COMPUTE RLS AND STORE IT AWAY
                                0
                                RN
                VSL2            PDDL
                                PIPTIME
                PUSH            CALL
                                R-TO-RP
                STORE           RLS
                EXIT
                CAF             V06N43*                 # ASTRONAUT: NOW LOOK WHERE YOU ENDED UP
                TC              BANKCALL
                CADR            GOFLASH
                TCF             GOTOPOOH                # TERMINATE
                TCF             +2                      # PROCEED
                TCF             -5                      # RECYCLE

                TC              INTPRET
                VLOAD           MXV                     # INITIALIZE GSAV AND (USING REFMF)
## Page 778
                                RN                      #   YNBSAV, ZNBSAV AND ATTFLAG FOR P57
                                REFSMMAT
                UNIT            CALL
                                CDU*SMNB
                STCALL          GSAV
                                REFMF
                EXIT

                TCF             GOTOPOOH                # ASTRONAUT: PLEASE SELECT P57


V06N43*         VN              0643
