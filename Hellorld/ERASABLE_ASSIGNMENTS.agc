### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    ERASABLE_ASSIGNMENTS.agc
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


A               EQUALS  0
L               EQUALS  1               # L AND Q ARE BOTH CHANNELS AND REGISTERS.
Q               EQUALS  2
EBANK           EQUALS  3
FBANK           EQUALS  4
Z               EQUALS  5               # ADJACENT TO FBANK AND BBANK FOR DXCH Z
BBANK           EQUALS  6               # (DTCB) AND DXCH FBANK (DTCF).
                                        # REGISTER 7 IS A ZERO-SOURCE, USED BY ZL.

ARUPT           EQUALS  10              # INTERRUPT STORAGE.
LRUPT           EQUALS  11
QRUPT           EQUALS  12
SAMPTIME        EQUALS  13              # SAMPLED TIME 1 & 2.
ZRUPT           EQUALS  15              # (13 AND 14 ARE SPARES.)
BANKRUPT        EQUALS  16              # USUALLY HOLDS FBANK OR BBANK.
BRUPT           EQUALS  17              # RESUME ADDRESS AS WELL.

CYR             EQUALS  20
SR              EQUALS  21
CYL             EQUALS  22
EDOP            EQUALS  23              # EDITS INTERPRETIVE OPERATION CODE PAIRS.


TIME2           EQUALS  24
TIME1           EQUALS  25
TIME3           EQUALS  26
TIME4           EQUALS  27
TIME5           EQUALS  30
TIME6           EQUALS  31
CDUX            EQUALS  32
CDUY            EQUALS  33
CDUZ            EQUALS  34
OPTY            EQUALS  35
OPTX            EQUALS  36
PIPAX           EQUALS  37
PIPAY           EQUALS  40
PIPAZ           EQUALS  41
BMAGX           EQUALS  42
RHCP            EQUALS  42
BMAGY           EQUALS  43
RHCY            EQUALS  43
BMAGZ           EQUALS  44
RHCR            EQUALS  44
INLINK          EQUALS  45
RNRAD           EQUALS  46
GYROCTR         EQUALS  47
GYROCMD         EQUALS  47
CDUXCMD         EQUALS  50
CDUYCMD         EQUALS  51

CDUZCMD         EQUALS  52
OPTYCMD         EQUALS  53
OPTXCMD         EQUALS  54
EMSD            EQUALS  55
THRUST          EQUALS  55
LEMONM          EQUALS  56
OUTLINK         EQUALS  57
ALTM            EQUALS  60

                SETLOC  67              # DECODED REGISTER FOR NIGHT-WATCHMAN ALM.
NEWJOB          ERASE

LVSQUARE        EQUALS  34D             # SQUARE OF VECTOR INPUT TO ABVAL AND UNIT
LV              EQUALS  36D             # LENGTH OF VECTOR INPUT TO UNIT.
X1              EQUALS  38D             # INTERPRETIVE SPECIAL REGISTERS RELATIVE
X2              EQUALS  39D             # TO THE WORK AREA.
S1              EQUALS  40D
S2              EQUALS  41D
QPRET           EQUALS  42D


# GENERAL ERASABLE ASSIGNMENTS.

                SETLOC  61

# INTERPRETIVE SWITCH RESERVATIONS.

STATE           ERASE   +3              # 60 SWITCHES PRESENTLY.

# INTERPRETIVE SWITCH BIT ASSIGNMENTS:

WMATFLAG        EQUALS  0
JSWITCH         EQUALS  1
MIDFLAG         EQUALS  2
MOONFLAG        EQUALS  3
NBSMBIT         EQUALS  4
COAROFIN        EQUALS  5
BODYFLAG        EQUALS  6
IMUSE           EQUALS  7
OPTUSE          EQUALS  8D
# END OF SWITCH ASSIGNMENTS

#       THE FOLLOWING SET COMPRISES THE INTERRUPT TEMPORARY STORAGE POO

#       ANY OF THESE MAY BE USED AS TEMPORARIES DURING INTERRUPT OR WITH INTERRUPT INHIBITED. THE ITEMP SERIES
# IS USED DURING CALLS TO THE EXECUTIVE AND WAITLIST - THE RUPTREGS ARE NOT.

ITEMP1          ERASE
WAITEXIT        EQUALS  ITEMP1
EXECTEM1        EQUALS  ITEMP1

ITEMP2          ERASE
WAITBANK        EQUALS  ITEMP2
EXECTEM2        EQUALS  ITEMP2

                SETLOC  70

ITEMP3          ERASE
RUPTSTOR        EQUALS  ITEMP3
WAITADR         EQUALS  ITEMP3
NEWPRIO         EQUALS  ITEMP3

ITEMP4          ERASE
LOCCTR          EQUALS  ITEMP4
WAITTEMP        EQUALS  ITEMP4

ITEMP5          ERASE
NEWLOC          EQUALS  ITEMP5

ITEMP6          ERASE
# NEWLOC+1      EQUALS          ITEMP6                          DP ADDRESS.

RUPTREG1        ERASE
RUPTREG2        ERASE
RUPTREG3        ERASE
RUPTREG4        ERASE
KEYTEMP1        EQUALS  RUPTREG4
DSRUPTEM        EQUALS  RUPTREG4

#       THE FOLLOWING ARE EXECUTIVE TEMPORARIES WHICH MAY BE USED BETWEEN CCS NEWJOB INQUIRIES.
INTB15+         ERASE                   # REFLECTS 15TH BIT OF INDEXABLE ADDRESSES
DSEXIT          =       INTB15+         # RETURN FOR DSPIN
EXITEM          =       INTB15+         # RETURN FOR SCALE FACTOR ROUTINE SELECT
BLANKRET        =       INTB15+         # RETURN FOR 2BLANK

INTBIT15        ERASE                   # SIMILAR TO ABOVE.
WRDRET          =       INTBIT15        # RETURN FOR 5BLANK
WDRET           =       INTBIT15        # RETURN FOR DSPWD
DECRET          =       INTBIT15        # RETURN FOR PUTCOM(DEC LOAD)
21/22REG        =       INTBIT15        # TEMP FOR CHARIN

#       THE REGISTERS BETWEEN ADDRWD AND PRIORITY MUST STAY IN THE FOLLOWING ORDER FOR INTERPRETIVE TRACE.

ADDRWD          ERASE                   # 12 BIT INTERPRETIVE OPERAND SUB-ADDRESS.
POLISH          ERASE                   # HOLDS CADR MADE FROM POLISH ADDRESS.
UPDATRET        =       POLISH          # RETURN FOR UPDATNN, UPDATVB
CHAR            =       POLISH          # TEMP FOR CHARIN
ERCNT           =       POLISH          # COUNTER FOR ERROR LIGHT RESET
DECOUNT         =       POLISH          # COUNTER FOR SCALING AND DISPLAY (DEC)

FIXLOC          ERASE                   # WORK AREA ADDRESS.

OVFIND          ERASE                   # SET NON-ZERO ON OVERFLOW.

VBUF            ERASE   +5              # TEMPORARY STORAGE USED FOR VECTORS.
SGNON           =       VBUF            # TEMP FOR +,- ON
NOUNTEM         =       VBUF            # COUNTER FOR MIXNOUN FETCH
DISTEM          =       VBUF            # COUNTER FOR OCTAL DISPLAY VERBS
DECTEM          =       VBUF            # COUNTER FOR FETCH (DEC DISPLAY VERBS)

SGNOFF          =       VBUF    +1      # TEMP FOR +,- ON
NVTEMP          =       VBUF    +1      # TEMP FOR NVSUB
SFTEMP1         =       VBUF    +1      # STORAGE FOR SF CONST HI PART(=SFTEMP2-1)

CODE            =       VBUF    +2      # FOR DSPIN
SFTEMP2         =       VBUF    +2      # STORAGE FOR SF CONST LO PART(=SFTEMP1+1)
MIXTEMP         =       VBUF    +3      # FOR MIXNOUN DATA
SIGNRET         =       VBUF    +3      # RETURN FOR +,- ON

# ALSO MIXTEMP+1 = VBUF+4, MIXTEMP+2 = VBUF+5.

BUF             ERASE   +2              # TEMPORARY SCALAR STORAGE.
BUF2            ERASE   +1
INDEXLOC        EQUALS  BUF             # CONTAINS ADDRESS OF SPECIFIED INDEX.
SWWORD          EQUALS  BUF             # ADDRESS OF SWITCH WORD.
SWBIT           EQUALS  BUF +1          # SWITCH BIT WITHIN SWITCH WORD.
MPTEMP          ERASE                   # TEMPORARY USED IN MULTIPLY AND SHIFT.
DOTINC          ERASE                   # COMPONENT INCREMENT FOR DOT SUBROUTINE.
DVSIGN          EQUALS  DOTINC          # DETERMINES SIGN OF DDV RESULT.
ESCAPE          EQUALS  DOTINC          # USED IN ARCSIN/ARCCOS.
ENTRET          =       DOTINC          # EXIT FROM ENTER

DOTRET          ERASE                   # RETURN FROM DOT SUBROUTINE.
DVNORMCT        EQUALS  DOTRET          # DIVIDEND NORMALIZATION COUNT IN DDV.
ESCAPE2         EQUALS  DOTRET          # ALTERNATE ARCSIN/ARCCOS SWITCH.
WDCNT           =       DOTRET          # CHAR COUNTER FOR DSPWD
INREL           =       DOTRET          # INPUT BUFFER SELECTOR ( X,Y,Z, REG )

MATINC          ERASE                   # VECTOR INCREMENT IN MXV AND VXM.
MAXDVSW         EQUALS  MATINC          # +0 IF DP QUOTIENT IS NEAR ONE - ELSE -1.
POLYCNT         EQUALS  MATINC          # POLYNOMIAL LOOP COUNTER
DSPMMTEM        =       MATINC          # DSPCOUNT SAVE FOR DSPMM
MIXBR           =       MATINC          # INDICATOR FOR MIXED OR NORMAL NOUN

TEM1            ERASE                   # EXEC TEMP
POLYRET         =       TEM1
DSREL           =       TEM1            # REL ADDRESS FOR DSPIN

TEM2            ERASE                   # EXEC TEMP
DSMAG           =       TEM2            # MAGNITUDE STORE FOR DSPIN
IDADDTEM        =       TEM2            # MIXNOUN INDIRECT ADDRESS STORAGE

TEM3            ERASE                   # EXEC TEMP
COUNT           =       TEM3            # FOR DSPIN

TEM4            ERASE                   # EXEC TEMP
LSTPTR          =       TEM4            # LIST POINTER FOR GRABUSY
RELRET          =       TEM4            # RETURN FOR RELDSP
FREERET         =       TEM4            # RETURN FOR FREEDSP

TEM5            ERASE                   # EXEC TEMP
NOUNADD         =       TEM5            # TEMP STORAGE FOR NOUN ADDRESS

NNADTEM         ERASE                   # TEMP FOR NOUN ADDRESS TABLE ENTRY
NNTYPTEM        ERASE                   # TEMP FOR NOUN TYPE TABLE ENTRY
IDAD1TEM        ERASE                   # TEMP FOR INDIR ADRESS TABLE ENTRY(MIXNN)
                                        # MUST = IDAD2TEM-1, = IDAD3TEM-2.
IDAD2TEM        ERASE                   # TEMP FOR INDIR ADRESS TABLE ENTRY(MIXNN)
                                        # MUST = IDAD1TEM+1, = IDAD3TEM-1.
IDAD3TEM        ERASE                   # TEMP FOR INDIR ADRESS TABLE ENTRY(MIXNN)
                                        # MUST = IDAD1TEM+2, = IDAD2TEM+1.
RUTMXTEM        ERASE                   # TEMP FOR SF ROUT TABLE ENTRY(MIXNN ONLY)



#       STORAGE USED BY THE EXECUTIVE.

MPAC            ERASE   +6              # MULTI-PURPOSE ACCUMULATOR.
MODE            ERASE                   # +1 FOR TP, +0 FOR DP, OR -1 FOR VECTOR.
LOC             ERASE                   # LOCATION ASSOCIATED WITH JOB.
BANKSET         ERASE                   # USUALLY CONTAINS BBANK SETTING.
PUSHLOC         ERASE                   # WORD OF PACKED INTERPRETIVE PARAMETERS.
PRIORITY        ERASE                   # PRIORITY OF PRESENT JOB AND WORK AREA.

                ERASE   +71D            # SEVEN SETS OF 12 REGISTERS EACH.

# THE FOLLOWING REGISTERS ARE RESERVED FOR PINBALL


# RESERVED FOR PINBALL EXECUTIVE ACTION

DSPCOUNT        ERASE                   # DISPLAY POSITION INDICATOR
DECBRNCH        ERASE                   # +DEC, - DEC, OCT INDICATOR
VERBREG         ERASE                   # VERB CODE
NOUNREG         ERASE                   # NOUN CODE
XREG            ERASE                   # R1 INPUT BUFFER
YREG            ERASE                   # R2 INPUT BUFFER
ZREG            ERASE                   # R3 INPUT BUFFER
XREGLP          ERASE                   # LO PART OF XREG (FOR DEC CONV ONLY)
YREGLP          ERASE                   # LO PART OF YREG (FOR DEC CONV ONLY)
ZREGLP          ERASE                   # LO PART OF ZREG (FOR DEC CONV ONLY)
MODREG          ERASE                   # MODE CODE
DSPLOCK         ERASE                   # KEYBOARD/SUBROUTINE CALL INTERLOCK
REQRET          ERASE                   # RETURN REGISTER FOR LOAD
LOADSTAT        ERASE                   # STATUS INDICATOR FOR LOADTST
CLPASS          ERASE                   # PASS INDICATOR CLEAR
NOUT            ERASE                   # ACTIVITY COUNTER FOR DSPTAB
NOUNCADR        ERASE                   # MACHINE CADR FOR NOUN
MONSAVE         ERASE                   # N/V CODE FOR MONITOR. (= MONSAVE1-1)
MONSAVE1        ERASE                   # NOUNCADR FOR MONITOR(MATBS) =MONSAVE+1
DSPTAB          ERASE   +11D            # 0-10D, DISPLAY PANEL BUFF. 11D, C/S LTS.
CADRSTOR        ERASE                   # ENDIDLE STORAGE
GRABLOCK        ERASE                   # INTERNAL INTERLOCK FOR DISPLAY SYSTEM
NVQTEM          ERASE                   # NVSUB STORAGE FOR CALLING ADDRESS
                                        # MUST = NVBNKTEM-1
NVBNKTEM        ERASE                   # NVSUB STORAGE FOR CALLING BANK
                                        # MUST = NVQTEM+1
DSPLIST         ERASE   +2              # WAITING LIST FOR DSP SYST INTERNAL USE
EXTVBACT        ERASE                   # EXTENDED VERB ACTIVITY INTERLOCK
DSPTEM1         ERASE   +2              # BUFFER STORAGE AREA 1 (MOSTLY FOR TIME)
DSPTEM2         ERASE   +2              # BUFFER STORAGE AREA 2 (MOSTLY FOR DEG)
# END OF ERASABLES RESERVED FOR PINBALL EXECUTIVE ACTION



# RESERVED FOR PINBALL INTERRUPT ACTION

DSPCNT          ERASE                   # COUNTER FOR DSPOUT
UPLOCK          ERASE                   # BIT1 = UPLINK INTERLOCK (ACTIVATED BY
                                        # RECEPTION OF A BAD MESSAGE IN UPLINK)
# END OF ERASABLES RESERVED FOR PINBALL INTERRUPT ACTION



#        DAP STORAGE IN NON-SWITCHED ERASABLE.

T6LOC           ERASE   +1
T6ADR           EQUALS  T6LOC
T5LOC           ERASE   +1
T5ADR           EQUALS  T5LOC

# ASSIGNMENTS FOR T4RUPT PROGRAM
DSRUPTSW        ERASE
OPTIND          ERASE
LGYRO           ERASE
COMMANDO        ERASE   +1


# END OF T4RUPT ASSIGNMENTS


OPTMODES        ERASE
SWSAMPLE        ERASE
DESOPMOD        ERASE
WTOPTION        ERASE
ZOPTCNT         ERASE
IMODES30        ERASE
IMODES33        ERASE
MODECADR        ERASE   +1
IMUCADR         EQUALS  MODECADR
OPTCADR         EQUALS  MODECADR +1

MARKSTAT        ERASE

# THE FOLLOWING REGS ARE USED BY THE STANDBY VERBS

TIMESAV         ERASE   +1
SCALSAV         ERASE   +1
TIMAR           ERASE   +1
TIMEDIFF        ERASE   +1

                SETLOC  400

THETAD          ERASE   +2
DESOPTT         ERASE                   # DESIRED OPTICS CDU ANGLES.
DESOPTS         ERASE
DELVX           ERASE   +5



#        DOWNLINK LIST ADDRESS.
DNLSTADR        ERASE


VAC1USE         ERASE
VAC1            ERASE   +42D
VAC2USE         ERASE
VAC2            ERASE   +42D
VAC3USE         ERASE
VAC3            ERASE   +42D
VAC4USE         ERASE
VAC4            ERASE   +42D
VAC5USE         ERASE
VAC5            ERASE   +42D

SUMEBANK        ERASE
SUMADDR         ERASE
SUMEND          ERASE
ERASUM          ERASE

                SETLOC  1000

GEOMTRX         ERASE   +17D
GEOSAVED        ERASE
LTHOTSAV        ERASE
ANGXSAV         ERASE   +1
GAZ1SAV         ERASE

#	STORAGE FOR HELLORLD CUSTOM VERB'S CURRENT INNER AND OUTER LOOP INDEX, AND CONSTANT 3

HELLOINLP	ERASE
HELLOOUTLP	ERASE
HELLOINMAX	ERASE

                SETLOC  1071
#       WAITLIST REPEAT FLAG:

RUPTAGN         ERASE
KEYTEMP2        =       RUPTAGN         # TEMP FOR KEYRUPT, UPRUPT

#       PHASE TABLE AND RESTART COUNTER.

-PHASE0         ERASE
PHASE0          ERASE
-PHASE1         ERASE
PHASE1          ERASE
-PHASE2         ERASE
PHASE2          ERASE
-PHASE3         ERASE
PHASE3          ERASE
-PHASE4         ERASE
PHASE4          ERASE
-PHASE5         ERASE
PHASE5          ERASE

# ERASABLE FOR SINGLE PRECISION SUBROUTINES.

HALFY           ERASE
ROOTRET         ERASE
SQRARG          ERASE
TEMK            EQUALS  HALFY
SQ              EQUALS  ROOTRET

1/PIPADT        ERASE                   # IMU COMPENSATION PACKAGE
OLDBT1          =       1/PIPADT

# ASSIGNMENTS RESERVED EXCLUSIVELY FOR SELF-CHECK
SELFERAS        ERASE   1357 - 1377

ERESTORE        =       1357
SELFRET         =       1360
SMODE           =       1361
REDOCTR         =       1362            # KEEPS TRACK OF RESTARTS
FAILREG         =       1363
SFAIL           =       1364
ERCOUNT         =       1365
SCOUNT          =       1366
SKEEP1          =       1371
SKEEP2          =       1372
SKEEP3          =       1373
SKEEP4          =       1374
SKEEP5          =       1375
SKEEP6          =       1376
SKEEP7          =       1377

# WAITLIST TASK LISTS

                SETLOC  1400

LST1            ERASE   +7              # DELTA T'S.
LST2            ERASE   +17D            # 2CADR TASK ADDRESSES.

# IMU COMPENSATION PARAMETERS:

NBDX            ERASE                   # GYRO BIAS DRIFTS
GBIASX          =       NBDX
NBDY            ERASE
NBDZ            ERASE

ADIAX           ERASE                   # ACCELERATION SENSITIVE DRIFT ALONG THE
ADIAY           ERASE                   # INPUT AXIS
ADIAZ           ERASE

ADSRAX          ERASE                   # ACCELERATION SENSITIVE DRIFT ALONG THE
ADSRAY          ERASE                   # SPIN REFERENCE AXIS
ADSRAZ          ERASE

PBIASX          ERASE                   # PIPA BIAS AND PIPA SCALE FACTOR TERMS
PIPABIAS        =       PBIASX          #       INTERMIXED.
PIPASCFX        ERASE
PIPASCF         =       PIPASCFX
PBIASY          ERASE
PIPASCFY        ERASE
PBIASZ          ERASE
PIPASCFZ        ERASE

GCOMP           ERASE   +5              # CONTAINS COMPENSATING TORQUES

COMMAND         EQUALS  GCOMP
CDUIND          EQUALS  GCOMP +3

#       ASSIGNMENTS FOR PRESENTLY UNUSED NOUNS.
ROLL            ERASE   +2
LANDMARK        ERASE   +5

                SETLOC  2000

AMEMORY         ERASE   +150D
#       THE FOLLOWING A MEMORY LOCATIONS ARE USED BY MID-COURSE NAVIGATION:

RRECT           EQUALS  AMEMORY +000D
RIGNTION        EQUALS  AMEMORY +000D
VRECT           EQUALS  AMEMORY +006D
VIGNTION        EQUALS  AMEMORY +006D
TDELTAV         EQUALS  AMEMORY +012D
NEWDLTAV        EQUALS  AMEMORY +012D
TNUV            EQUALS  AMEMORY +018D
NEWNUV          EQUALS  AMEMORY +018D
RCV             EQUALS  AMEMORY +024D
FOUNDR          EQUALS  AMEMORY +024D
VCV             EQUALS  AMEMORY +030D
FOUNDV          EQUALS  AMEMORY +030D
TC              EQUALS  AMEMORY +036D
TET             EQUALS  AMEMORY +038D
XKEP            EQUALS  AMEMORY +040D
ALPHAV          EQUALS  AMEMORY +042D
DELR            EQUALS  AMEMORY +042D
BETAV           EQUALS  AMEMORY +048D
DELVEL          EQUALS  AMEMORY +048D
PHIV            EQUALS  AMEMORY +054D
BVECTOR         EQUALS  AMEMORY +054D
PSIV            EQUALS  AMEMORY +060D
FV              EQUALS  AMEMORY +066D

VECTAB          EQUALS  AMEMORY +072D

TAVEGON         EQUALS  AMEMORY +072D
TRESUME         EQUALS  AMEMORY +074D
RAVEGON         EQUALS  AMEMORY +076D
VAVEGON         EQUALS  AMEMORY +082D
RIG-4SEC        EQUALS  AMEMORY +088D
ALPHAM          EQUALS  AMEMORY +108D
BETAM           EQUALS  AMEMORY +110D
TAU             EQUALS  AMEMORY +112D
GIVENT          EQUALS  AMEMORY +112D
DT/2            EQUALS  AMEMORY +114D
H               EQUALS  AMEMORY +116D
TDEC            EQUALS  AMEMORY +118D
FBRANCH         EQUALS  AMEMORY +120D
HBRANCH         EQUALS  AMEMORY +121D
GMODE           EQUALS  AMEMORY +122D
QREADY          EQUALS  AMEMORY +123D
MEASQ           EQUALS  AMEMORY +124D
DELTAQ          EQUALS  AMEMORY +126D

MEASMODE        EQUALS  AMEMORY +128D
NVCODE          EQUALS  AMEMORY +129D
MIDEXIT         EQUALS  AMEMORY +130D
DSPRTRN         EQUALS  AMEMORY +130D
INCORPEX        EQUALS  AMEMORY +131D
STEPEXIT        EQUALS  AMEMORY +132D
DIFEQCNT        EQUALS  AMEMORY +133D
NORMGAM         EQUALS  AMEMORY +133D
SCALEA          EQUALS  AMEMORY +134D
SCALEB          EQUALS  AMEMORY +135D
SCALDT          EQUALS  AMEMORY +136D
SCALDELT        EQUALS  AMEMORY +137D
SCALER          EQUALS  AMEMORY +138D

YV              EQUALS  AMEMORY +139D
ZV              EQUALS  AMEMORY +145D

PBODY           ERASE
W               ERASE   +071D

#  THE FOLLOWING ERASABLE REGISTERS ARE USED BY THE  ENTRY AND INITIALIZATION JOB OF THE CSM & SATURN TEST.

QCSI            EQUALS  AMEMORY +000D
SATPBUF         EQUALS  AMEMORY +001D
SATYBUF         EQUALS  AMEMORY +002D
SATRBUF         EQUALS  AMEMORY +003D
CHCNTR          EQUALS  AMEMORY +004D
TRIMYBUF        EQUALS  AMEMORY +005D
OFFTMBUF        EQUALS  AMEMORY +006D

#   THE FOLLOWING ERASABLE REGISTERS ARE USED BY THE JETSET TASK.

JETSTEP         EQUALS  AMEMORY +007D
NTIMES          EQUALS  AMEMORY +008D
NEXTTIME        EQUALS  AMEMORY +016D
JETONTM         EQUALS  AMEMORY +024D
XJETS           EQUALS  AMEMORY +032D
YZJETS          EQUALS  AMEMORY +040D
JETOFFTM        EQUALS  AMEMORY +048D

#    THE FOLLOWING ERASABLE REGISTERS ARE USED BY THE ENGINE ON-OFF TASK.

ENGSTEP         EQUALS  AMEMORY +056D
CYLTIMES        EQUALS  AMEMORY +057D
NEXTCYLT        EQUALS  AMEMORY +060D
ONTIME          EQUALS  AMEMORY +063D
OFFTIME         EQUALS  AMEMORY +066D
OFFTIMER        EQUALS  AMEMORY +069D

#   THE FOLLOWING ERASABLE REGISTERS ARE USED BY THE TRIM TASK.

TRIMSTEP        EQUALS  AMEMORY +072D
NUMTIMES        EQUALS  AMEMORY +073D
STEPDLYT        EQUALS  AMEMORY +079D
TRIMONT         EQUALS  AMEMORY +085D
TRIMPTCH        EQUALS  AMEMORY +091D
TRIMYAW         EQUALS  AMEMORY +097D

#  THE FOLLOWING ERASABLE REGISTERS ARE USED BY THE INTERFACE LOOK TASK.

TESTIDX         EQUALS  AMEMORY +103D
30BUF1          EQUALS  AMEMORY +104D
30BUF0          EQUALS  AMEMORY +108D
QUITLOOK        EQUALS  AMEMORY +112D


#   THE FOLLOWING ERASABLE REGISTERS ARE USED BY THE SATURN STEERING TASK.

NOSIVBNJ        EQUALS  AMEMORY +113D
SATSTEP         EQUALS  AMEMORY +114D
SATTIMES        EQUALS  AMEMORY +115D
SATDELAY        EQUALS  AMEMORY +125D
SATONT          EQUALS  AMEMORY +135D
SATPITCH        EQUALS  AMEMORY +145D
SATYAW          EQUALS  AMEMORY +155D
SATROLL         EQUALS  AMEMORY +165D

                SETLOC  2400
# THE FOLLOWING ERASABLE LOCATIONS ARE UTILIZED BY THE IN-FLIGHT ALIGNMENT ROUTINES

XSM             ERASE   +17D
YSM             =       XSM +6
ZSM             =       XSM +12D
XDC             ERASE   +17D
YDC             =       XDC +6
ZDC             =       XDC +12D
XNB             =       XDC
YNB             =       XDC +6
ZNB             =       XDC +12D
STARAD          ERASE   +17D
STAR            ERASE   +5
SAC             ERASE   +1
PAC             ERASE   +1
OGC             ERASE   +1
IGC             ERASE   +1
MGC             ERASE   +1
ZPRIME          =       22D
PDA             =       22D
COSTH           =       16D
SINTH           =       18D
THETA           =       20D
STARM           =       32D



# THE FOLLOWING ERASABLE LOCATIONS ARE UTILIZED BY THE SYSTEM TESTS
AZIMUTH         ERASE   +1
LATITUDE        ERASE   +1

EROPTN          ERASE
ERVECTOR        ERASE   +5
GYROD           ERASE   +5
LENGTHOT        ERASE
LOSVEC          ERASE   +5
SXTOPTN         =       LOSVEC
TARG1/2         =       LOSVEC +1
NBPOS           ERASE
NDXCTR          ERASE
PIPANO          ERASE
PIPINDEX        ERASE
PIPNDX          ERASE   +1
POSITON         ERASE
QPLAC           ERASE

QPLACE          ERASE
QPLACES         ERASE
RUN             ERASE
STOREPL         ERASE
SOUTHDR         ERASE
TAZEL1          ERASE   +5
TEMPTIME        ERASE   +1
TESTNO          ERASE
TMARK           ERASE   +1
SHAFTA          ERASE
GENPL           ERASE   +111D

CDUTIMEI        =       GENPL
CDUTIMEF        =       GENPL +2
IMU/OPT         =       GENPL +4
CDUDANG         =       GENPL +4
CDUREADF        =       GENPL +5
CDUREADI        =       GENPL +6
CDULIMIT        =       GENPL +7

TEMPADD         =       GENPL +4
TEMP            =       GENPL +5
NOBITS          =       GENPL +6
CHAN            =       GENPL +7

LOS1            =       GENPL +8D
LOS2            =       GENPL +14D

CALCDIR         EQUALS  GENPL +20D
CDUFLAG         EQUALS  GENPL +21D
GYTOBETQ        EQUALS  GENPL +22D
OPTNREG         EQUALS  GENPL +23D
SAVE            EQUALS  GENPL +24D      # THREE CONSEC LOC
SFCONST1        EQUALS  GENPL +27D
TIMER           EQUALS  GENPL +28D

DATAPL          EQUALS  GENPL +30D
RDSP            EQUALS  GENPL           # FIX LATER   POSSIBLY KEEP1
MASKREG         EQUALS  GENPL +64D
CDUNDX          EQUALS  GENPL +66D
RESULTCT        EQUALS  GENPL +67D
COUNTPL         EQUALS  GENPL +70D

CDUANG          EQUALS  GENPL +71D
AINLA           =       GENPL           # 110 DEC OR 156 OCT LOCATIONS

XSM1            EQUALS  AINLA
ERCOMP1         EQUALS  AINLA +18D
GYROANG         EQUALS  AINLA +24D
AZERR           EQUALS  AINLA +28D
FILDELV         EQUALS  AINLA +30D
THETAN          EQUALS  AINLA +36D
PREVTIME        EQUALS  AINLA +42D
ERVECT1         EQUALS  AINLA +44D
VECTEM          EQUALS  AINLA +50D
GYROCSW         EQUALS  AINLA +56D
PRELTEMP        EQUALS  AINLA +57D
QSAVED          EQUALS  AINLA +58D
TAZ             EQUALS  AINLA +60D
TEL             EQUALS  AINLA +62D
LATITUD1        EQUALS  AINLA +64D
PIPTIME         EQUALS  AINLA +66D
TARGET1         EQUALS  AINLA +68D
PTEMP           EQUALS  AINLA +80D
AZIMUTH1        EQUALS  AINLA +124D
STARS           EQUALS  AINLA +126D

ALX1S           EQUALS  AINLA           # IN
CMPX1           EQUALS  AINLA +1D       # IND
ALK             EQUALS  AINLA +2D       # GAINS
WANGO           EQUALS  AINLA +14D      # VERT ERATE
WANGI           EQUALS  AINLA +16D      # HO
WANGT           EQUALS  AINLA +18D      # T
TORQNDX         =       WANGT
FILDELVX        EQUALS  AINLA +20D
FILDELVY        EQUALS  AINLA +22D
FILDELVZ        EQUALS  AINLA +24D
INTY            EQUALS  AINLA +26D      # SOUTH PIP INTE
ANGZ            EQUALS  AINLA +28D      # EAST AXIS
INTZ            EQUALS  AINLA +30D      # EAST PIP I
ANGY            EQUALS  AINLA +32D      # SOUTH
ANGX            EQUALS  AINLA +34D      # VE
PIPAN           EQUALS  AINLA +36D
DRIFTO          EQUALS  AINLA +36D      # VERT
PIPAE           EQUALS  AINLA +38D
DRIFTI          EQUALS  AINLA +38D      # SOU
DRIFTT          EQUALS  AINLA +40D      # EAST AX
VLAUN           EQUALS  AINLA +42D      # LAUNCH
ACCWD           EQUALS  AINLA +44D      # LAUN
POSNV           EQUALS  AINLA +50D      # LAUNC
DPIPAY          EQUALS  AINLA +52D      # SOUTH
DPIPAZ          EQUALS  AINLA +56D      # NORTH PIP INCREMENT
ALTIM           EQUALS  AINLA +58D      # LENG
ALTIMS          EQUALS  AINLA +59D      #  INDEX
ALDK            EQUALS  AINLA +60D      #  TIME CONSTAN
GAZ1            EQUALS  AINLA +74D
GTSOPNDZ        EQUALS  AINLA +76D
GEOCOMPS        EQUALS  AINLA +77D
GAZIMUTH        EQUALS  AINLA +78D
SPDRIFT         EQUALS  AINLA +80D
SINGAZ          EQUALS  AINLA +83D
COSGAZ          EQUALS  AINLA +85D
BPLAC           EQUALS  AINLA +90D
XNB1            EQUALS  AINLA +100D
WPLATO          EQUALS  AINLA +102D
WPLATI          EQUALS  AINLA +104D
WPLATT          EQUALS  AINLA +106D
YNB1            EQUALS  AINLA +106D
DELM            EQUALS  AINLA +108D
ZNB1            EQUALS  AINLA +112D
ZERONDX         EQUALS  AINLA +116D
PRELMTRX        EQUALS  AINLA +117D
TRANSM1         =       PRELMTRX
PREMTRXC        EQUALS  AINLA +135D
OPDATRET        EQUALS  AINLA +136D

BMEMORY         EQUALS  GENPL
ERCOMP          EQUALS  DELVX
DELVY           EQUALS  DELVX +2
DELVZ           EQUALS  DELVX +4
                SETLOC  3425

#       DOWNLINK STORAGE.
LDATALST        ERASE
DNTMGOTO        ERASE
TMINDEX         ERASE
DNTMBUFF        ERASE   +21D            # SNAPSHOT BUFFER.

#       STORAGE FOR INBIT SCANNER.

LAST30          ERASE   +2              # LAST SAMPLED INBITS.
MSGCNT          ERASE