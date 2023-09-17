### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    EXTENDED_VERBS.agc
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
## Reference:   pp. 268-305
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2017-07-28 MAS  Created from Luminary 210.
##		2017-08-21 RSB	Transcribed.
##		2017-08-21 MAS	Fixed a missed VxxNxx label/value change.

## Page 268
                BANK    7
                SETLOC  EXTVERBS
                BANK

                EBANK=  OGC

                COUNT*  $$/EXTVB
# FAN-OUT

GOEXTVB         INDEX   MPAC            # VERB-40 IS IN MPAC
                TC      LST2FAN         # FAN AS BEFORE.

LST2FAN         TC      VBZERO          # VB40 ZERO (USED WITH NOUN 20 OR 72 ONLY)
                TC      VBCOARK         # VB41 COARSE ALIGN (USED WITH NOUN 20 OR
                                        #                                 72 ONLY)
                TC      IMUFINEK        # VB42 FINE ALIGN IMU
                TC      IMUATTCK        # VB43  LOAD IMU ATTITUDE ERROR METERS.
                TC      RRDESEND        # VB44 TERMINATE CONTINUOUS DESIGNATE
                TC      ALM/END         # VB45 SPARE
                TC      ALM/END         # VB46 SPARE
                TC      V47TXACT        # VB47 AGS INITIALIZATION
                TC      DAPDISP         # VB48  LOAD A/P DATA
                TCF     CREWMANU        # VB49 START AUTOMATIC ATTITUDE MANEUVER
                TC      GOLOADLV        # VB50 PLEASE PERFORM
                TC      ALM/END         # VB51 SPARE
                TC      GOLOADLV        # VB52 PLEASE MARK X - RETICLE.
                TC      GOLOADLV        # VB53 PLEASE MARK Y - RETICLE.
                TC      GOLOADLV        # VB54 PLEASE MARK X OR Y - RETICLE
                TC      ALINTIME        # VB55 ALIGN TIME
                TC      TRMTRACK        # VB56 TERMINATE TRACKING - P20 + P25
                TC      LRON            # VB57 PERMIT  LANDING RADAR UPDATES
                TC      LROFF           # VB58 INHIBIT LANDING RADAR UPDATES
                TC      LRPOS2K         # VB59 COMMAND LR TO POSITION 2.
                TC      RATEDISP        # VB60 DISPLAY DAP ESTIMATED RATES
                TC      DAPATTER        # VB61 DISPLAY DAP ATTITUDE ERROR
                TC      TOTATTER        # VB62 DISPLAY TOTAL ATTITUDE ERROR
                TC      R04             # VB63 SAMPLE RADAR ONCE PER SECOND
                TC      VB64            # VB64 CALCULATE,DISPLAY S-BAND ANT ANGLES
                TC      SNUFFOUT        # VB65 DISABLE U,V JETS DURING DPS BURNS.
                TC      ATTACHED        # VB66 ATTACHED   MOVE THIS TO OTHER STATE
                TC      V67             # VB67 W MATRIX MONITOR
                TC      TEROFF          # VB68 TAKE OUT TERRAIN MODEL IN DESCENT
VERB69          TC      VERB69          # VB69 FORCE A HARDWARE RESTART
                TC      V70UPDAT        # VB70 UPDATE LIFTOFF TIME.
                TC      V71UPDAT        # VB71 UNIVERSAL UPDATE - BLOCK ADDRESS.
                TC      V72UPDAT        # VB72 UNIVERSAL UPDATE - SINGLE ADDRESS.
                TC      V73UPDAT        # VB73 UPDATE AGC TIME (OCTAL).
                TC      DNEDUMP         # VB74 INITIALIZE DOWN-TELEMETRY PROGRAM
                                        #        FOR ERASABLE DUMP.
                TC      OUTSNUFF        # VB75 ENABLE U,V JETS DURING DPS BURNS.
## Page 269
                TC      MINIMP          # VB76 MINIMUM IMPULSE MODE
                TC      NOMINIMP        # VB77 RATE COMMAND MODE
                TC      R77             # VB78 START LR SPURIOUS RETURN TEST
                TC      R77END          # VB79 TERMINATE LR SPURIOUS RETURN TEST
                TC      LEMVEC          # VB80 UPDATE LEM STATE VECTOR
                TC      CSMVEC          # VB81 UPDATE CSM STATE VECTOR
                TC      V82PERF         # VB82 REQUEST ORBIT PARAM DISPLAY (R30)
                TC      V83PERF         # VB83 REQUEST REND PARAM DISPLAY (R31)
                TC      ALM/END         # VB84 SPARE
                TC      VERB85          # VB85 DISPLAY RR LOS AZ AND ELEV
                TC      ALM/END         # VB86 SPARE
                TC      ALM/END         # VB87 SPARE
                TC      ALM/END         # VB88 SPARE
                TC      V89PERF         # VB89 ALIGN XORZ LEM AXIS ALONG LOS (R63)
                TC      V90PERF         # VB90 OUT OF PLANE RENDEZVOUS DISPLAY
                TC      GOSHOSUM        # VB91 DISPLAY BANK SUM.
                TC      SYSTEST         # VB92 OPERATE IMU PERFORMANCE TEST.
                TC      WMATRXNG        # VB93 CLEAR RENDWFLG
                TC      ALM/END         # VB94 SPARE
                TC      UPDATOFF        # VB95 NO STATE VECTOR UPDATE ALLOWED
                TC      VERB96          # VB96 INTERRUPT INTEGRATION AND GO TO POO
                TC      GOLOADLV        # VB97 PLEASE VERIFY ENGINE FAILURE
                TC      ALM/END         # VB98 SPARE
                TC      GOLOADLV        # VB99 PLEASE ENABLE ENGINE

# END OF EXTENDED VERB FAN


TESTXACT        CCS     EXTVBACT        # ARE EXTENDED VERBS BUSY
                TC      ALM/END         # YES, TURN ON OPERATOR LIGHT
                CA      FLAGWRD4        # ARE PRIORITY DISPLAYS USING DSKY
                MASK    OC24100
                CCS     A
                TC      ALM/END         # YES
                CAF     OCT25           # SET BITS 1, 3, AND 5
SETXTACT        TS      EXTVBACT        # NO. SET FLAG TO SHOW EXT VERB DISPLAY
                                        # SYSTEM BUSY

                CA      Q
                TS      MPAC +1

                CS      TWO             # BLANK EVERYTHING EXCEPT MM AND VERB
                TC      NVSUB
                TC      +1
                CCS     NEWJOB
                TC      CHANG1

                TC      MPAC +1

TERMEXTV        EQUALS  ENDEXT
## Page 270
ENDEXTVB        EQUALS  ENDEXT

ALM/END         TC      FALTON          # TURN ON OPERATOR ERROR LIGHT
GOPIN           TC      POSTJUMP
                CADR    PINBRNCH

CHKPOOH         CA      MODREG          # CHECK FOR POO OR POO-.
                EXTEND
                BZF     TCQ
                TC      ALM/END

OC24100         OCT     24100

## Page 271
#          VBZERO       VERB 40            DESCRIPTION

#              1. REQUIRE NOUN 20 (ICDU ANGLES) OR NOUN 72 (RCDU ANGLES).
#             2. FOR N20, CHECK IMUCADR IN AN EFFORT TO AVOID A 1210 RESTART.
#                FOR N72, CHECK IF EITHER RADAR IS IN USE.
#              3. EXECUTE THE CDU ZERO.
#              4. STALL UNTILL THE ZERO IS DONE.
#              5. DON'T DIFFERENIATE BETWEEN A BAD OR GOOD RETURN.
#              6. EXIT, RE-ESTABLISHING THE INTERRUPTED DISPLAY (IF ANY).

VBZERO          TC      OP/INERT
                TC      IMUZEROK        # RETURN HERE IF NOUN = ICDU(20)
                TC      RRZEROK         # RETURN HERE IF NOUN = RCDU(72)
IMUZEROK        TC      CKMODCAD
                TC      BANKCALL        # KEYBOARD REQ FOR ISS CDUZERO
                CADR    IMUZERO

                TC      BANKCALL        # STALL
                CADR    IMUSTALL
                TC      +1

                TC      GOPIN           # IMUZERO

RRZEROK         TC      RDRUSECK
                TC      BANKCALL
                CADR    RRZERO

RWAITK          TC      BANKCALL
                CADR    RADSTALL
                TCF     +1
                TC      GOPIN           # RRZERO

#          LRPOS2K          VERB 59            DESCRIPTION
#              COMMAND LANDING RADAR TO POSITION 2
#             1. EXIT WITH OP ERROR IF SOMEONE IS USING EITHER RADAR.
#              2. ALARM WITH CODE 523 IF POS 2 IS NOT INDICATED WITHIN
#                 THE PRESCRIBED TIME.
#              3. RE-ESTABLISH THE DISPLAYS.

LRPOS2K         CA      FLAGWRD7
                MASK    AVEGFBIT
                EXTEND
                BZF     LRPOS2K1        # AVERAGE G NOT ON
                CS      FLGWRD11
                MASK    LRBYBIT
                EXTEND
                BZF     ALM/END         # IF AVE G ON AND NOT R12- OPERATOR ERROR
                TC      POSTJUMP
                CADR    V59GP63
LRPOS2K1        TC      RDRUSECK
## Page 272
                TC      BANKCALL
                CADR    LRP2COMM        # COMMAND LR TO POS2
# V61      VERB 61, DISPLAY DAP ATTITUDE ERRORS ON FDAI ATTITUDE ERROR NEEDLES.

DAPATTER        TC      DOWNFLAG
                ADRES   NEEDLFLG
                TCF     TOTATTER +2

# V62      VERB 62, DISPLAY TOTAL ATTITUDE ERRORS ON FDAI ATTITUDE ERROR NEEDLES.

TOTATTER        TC      UPFLAG
                ADRES   NEEDLFLG
 +2             TC      DOWNFLAG
                ADRES   NEED2FLG
                TC      GOPIN

# V60      VERB 60, DISPLAY DAP ESTIMATED RATES ON FDAI ATTITUDE ERROR NEEDLES.

RATEDISP        TC      UPFLAG
                ADRES   NEED2FLG
                TC      GOPIN

#

## Page 273
#          VBCOARK      VERB 41            DESCRIPTION
#              COARSE ALIGN IMU OR RADAR
#             1. REQUIRE NOUN 20 OR NOUN 72 OR TURN ON OPERATOR ERROR.
#              2. REQUIRE EXT VERB DISPLAY SYS AVAILABLE OR TURN ON OPERATOR ERROR LIGHT AND GO TO PINBRNCH.
#              CASE 1     NOUN 20     (ICDU ANGLES)
#              3. SET EXT VERB DISPLAY ACTIVE FLAG.
#              4. DISPLAY FLASHING V25,N22 (LOAD NEW ICDU ANGLES).
#                 RESPONSES
#                   A. TERMINATE
#                      1. RELEASE EXT VERB DISPLAY SYSTEM
#                   B. PROCEED
#                     1. COARSE ALIGN TO THE EXISTING THETAD'S (ICORK2).
#                   C. ENTER
#                     1. COARSE ALIGN TO THE LOADED THETAD'S (ICORK2).
#              ICORK2
#                 1. RE-DISPLAY VERB 41.
#                 2. EXECUTE IMUCOARS (IMU COARSE ALIGN).
#                 3. EXECUTE IMUSTALL (ALLOW TIME FOR DATA TRANSFER).
#                 4. RELEASE EXT VERB DISPLAY SYSTEM.
#              CASE 2     NOUN 72     (RCDU ANGLES)
#                EXIT WITH OP ERROR IF SOMEONE IS USING EITHER RADAD.
#              5. DISPLAY FLASHING V24,N73 (LOAD NEW RR TRUNION ANGLE AND NEW SHAFT ANGLE).
#                 RESPONSES
#                 A. TERMINATE
#                    1. RELEASE EXT VERB DISPLAY SYS.
#                 B. PROCEED OR ENTER
#                    1. EXECUTE AURLOKON (ASK OPERATOR FOR LOCK-ON REQUIREMENTS).
#                    2. RE-DISPLAY VERB 41.
#                    3. SCHEDULE RRDESK2 WITH PRIORITY 20.
#                    4. RELEASE EXT VERB DISPLAY SYS.

#                 AURLOKON

#                1. FLASH V04 N12 R1 = 00006 R2 = 00002
#                    RESPONSES
#                    A. TERMINATE
#                    B. PROCEED
#                      1. RESET LOCK-ON SWITCH
#                      2. SET CONTINUOUS DESIGNATE FLAG
#                      3. DISABLE R25
#                   C. V22 E 1 E, R1 = 00001, PROCEED
#                      1. SET LOCK-ON SWITCH
VBCOARK         TC      OP/INERT
                TC      IMUCOARK                # RETURN HERE IF NOUN = ICDU(20)
                TC      RRDESNBK                # RETURN HERE IF NOUN = RCDU(72)
#          RETURNS TO L+1 IF IMU OR L+2 IF RR.

OP/INERT        CS      OCT24
                AD      NOUNREG
                EXTEND
## Page 274
                BZF     TCQ                     # IF = 20.

                AD      RRIMUDIF                # -52
                EXTEND
                BZF     Q+1

                TC      ALM/END                 # ILLEGAL.

RRIMUDIF        DEC     -52                     # THE IMU
IMUCOARK        TC      CKMODCAD
                TC      TESTXACT                # COARSE ALIGN FROM KEYBOARD.
                CAF     VNLODCDU                # CALL FOR THETAD LOAD
                TC      BANKCALL
                CADR    GOXDSPF
                TC      TERMEXTV
                TCF     +1

ICORK2          CAF     IMUCOARV                # RE-DISPLAY COARSE ALIGN VERB.
                TC      BANKCALL
                CADR    EXDSPRET

                TC      BANKCALL                # CALL MODE SWITCHING PROG
                CADR    IMUCOARS

                TC      BANKCALL                # STALL
                CADR    IMUSTALL
                TC      ENDEXTVB
                TC      ENDEXTVB

VNLODCDU        VN      2522
IMUCOARV        VN      4100

## Page 275
#          DESIGNATE TO DESIRED GIMBAL ANGLES.

RRDESNBK        TC      RDRUSECK
                TC      TESTXACT
                CS	BIT10+15		# TERMINATE PRESENT DESIGNATION.
REFTAG3		=	DESIGBIT
REFTAG4		=	CDESBIT
		INHINT				# RELINT DONE IN GOXDSPF
		MASK	RADMODES		# RESET CONTINUOUS DESIGNATE BIT AND
		TS	RADMODES		#   DESIGNATION IN PROGRESS BIT.                
                
                CAF     VNLDRCDU                # ASK FOR GIMBAL ANGLES.
                TC      BANKCALL
                CADR    GOXDSPF
                TC      TERMEXTV
                TCF     -4                      # V33

                TC      BANKCALL                # ASK OP FOR LOCK ON REQUIREMENTS.
                CADR    AURLOKON

                CAF     OPTCOARV                # RE-DISPLAY OUR OWN VERB
                TC      BANKCALL
                CADR    EXDSPRET

                CAF     PRIO20
                TC      FINDVAC
                EBANK=  LOSCOUNT
                2CADR   RRDESK2


                TCF     TERMEXTV                # FREES DISPLAY.

VNLDRCDU        VN      2473
OPTCOARV        EQUALS  IMUCOARV                # DIFFERENT NOUNS.

RRDESK2         TC      BANKCALL
                CADR    RRDESNB

                TC      +1                      # DUMMY NEEDED SINCE DESRETRN DOES INCR
                CA      PRIORITY
                MASK    LOW9
                CCS     A
                INDEX   A
                TS      A                       # RELEASE THIS JOBS VAC AREA.
                COM                             # INSURE ENDOFJOB DOES A NOVAC END (BZMF).
                ADS     PRIORITY
                TC      BANKCALL                # WAIT FOR COMPLETION OF DESIGNATE
                CADR    RADSTALL
                TC      +2                      # BADEND-NO LOCKON OR OUT OF LIMITS
                TC      ENDOFJOB                # GOODEND-LOCKON ACHIEVED
## Page 276
                TC      ALARM
                OCT     503                     # TURN ON ALARM LIGHT -503 DESIGNATE FAIL
                TC      ENDOFJOB


RRDESEND        CCS     RADMODES                # TERMINATE CONTINUOUS DESIGNATE ONLY
                TCF     GOPIN
                TCF     GOPIN
                TCF     +1
REMODCHK        CS      RADMODES                # CHECK FOR REMODE OR REPOSITION
                MASK    BIT14&11
REFTAG1         =       REMODBIT
REFTAG2         =       REPOSBIT
                CCS	A
                TCF     NOREMODE                # NO
                CAF     1SEC                    # YES- WAIT 1 SECOND AND CHECK AGAIN
                TC      BANKCALL
                CADR    DELAYJOB
                TC      REMODCHK
NOREMODE        TC      CLRADMOD
                CAF     1SEC
                TC      BANKCALL
                CADR    DELAYJOB
                TC      DOWNFLAG                # ENABLE R25 GIMBAL MONITOR
                ADRES   NORRMON
BIT14&11        =       PRIO22
		BANK	23
                SETLOC  EXTVB1
                BANK
                COUNT*  $$/EXTVB

AURLOKON        TC      MAKECADR
                TS      DESRET
                CAF     TWO
                TS      OPTIONX +1
                CAF     SIX                     # OPTION CODE FOR V04N12
                TS      OPTIONX

 -5             CAF     V04N1272
                TC      BANKCALL                #      R2   00001  LOCK-ON
                CADR    GOMARKFR
                TCF     ENDEXT                  # V34
                TCF     +5                      # V33
                TCF     -5                      # V32
                CAF     BIT3
                TC      BLANKET
                TC      ENDOFJOB

 +5             CA      OPTIONX +1
                MASK    BIT2
## Page 277
                CCS     A
                TCF     NOLOKON
                TC      UPFLAG
                ADRES   LOKONSW
                TCF     AURLKON1

NOLOKON         TC      DOWNFLAG                # IF NO LOCK-ON, SET BIT15 OF RADMODES TO
                ADRES   LOKONSW                 # INDICATE THAT CONTINUOUS DESIGNATION IS
                TC      UPFLAG                  # WANTED (TO BE TERMINATED BY V44.)
                ADRES   CDESFLAG
                TC      UPFLAG                  # SET NO RR ANGLE MONITOR FLAG.
                ADRES   NORRMON                 # (DISABLE R25 RR GIMBAL MONITOR IN T4RUPT
AURLKON1        RELINT
                CA      DESRET
                TCF     BANKJUMP


V04N1272        VN      412
-LOKONFG        OCT     -20

                BANK    43
                SETLOC  EXTVERBS
                BANK
                COUNT*  $$/EXTVB

LRON            TC      UPFLAG                  # PERMIT INCORPORATION OF LR DATA      V57
                ADRES   LRINH
                TC      GOPIN

LROFF           TC      DOWNFLAG                # INHIBIT INCORPORATION OF LR DATA     V58
                ADRES   LRINH
                TC      GOPIN

TEROFF          TC      UPFLAG                  # TURN OFF TERRAIN MODEL	       V68
                ADRES   NOTERFLG
                TCF     GOPIN


                EBANK=  OGC

## Page 278
#          IMUFINEK     VERB 42            DESCRIPTION
#              FINE ALIGN IMU
#              1. REQUIRE EXT VERB DISPLAY AVAILABLE AND SET BUSY FLAG OR TURN ON OPER ERROR AND GO TO PINBRNCH.
#              2. DISPLAY FLASHING V25,N93....LOAD DELTA GYRO ANGLES....
#                 RESPONSES
#                 A. TERMINATE
#                    1. RELEASE EXT VERB DISPLAY SYSTEM.
#                 B. PROCEED OR ENTER
#                    1. RE-DISPLAY VERB 42
#                    2. EXECUTE IMUFINE (IMU FIVE ALIGN MODE SWITCHING).
#                    3. EXECUTE IMUSTALL (ALLOW FOR DATA TRANSFER)
#                       A. FAILED
#                          1. RELEASE EXT VERB DISPLAY SYSTEM.
#                       B. GOOD
#                          1. EXECUTE IMUPULSE (TORQUE IRIGS).
#                          2. EXECUTE IMUSTALL AND RELEASE EXT VERB DISPLAY SYSTEM.

IMUFINEK        TC      CKMODCAD
                TC      TESTXACT                # FINE ALIGN WITH GYRO TORQUING.
                CAF     VNLODGYR                # CALL FOR LOAD OF GYRO COMMANDS
                TC      BANKCALL
                CADR    GOXDSPF
                TC      TERMEXTV
                TC      +1                      # PROCEED WITHOUT A LOAD

                CAF     IMUFINEV                # RE-DISPLAY OUR OWN VERB
                TC      BANKCALL
                CADR    EXDSPRET

                TC      BANKCALL                # CALL MODE SWITCH PROG
                CADR    IMUFINE

                TC      BANKCALL                # HIBERNATION
                CADR    IMUSTALL
                TC      ENDEXTVB

FINEK2          CAF     LGYROBIN                # PINBALL LEFT COMMANDS IN OGC REGIST5RS
                TC      BANKCALL
                CADR    IMUPULSE

                TC      BANKCALL                # WAIT FOR PULSES TO GET OUT.
                CADR    IMUSTALL
                TC      ENDEXTVB
                TC      ENDEXTVB

LGYROBIN        ECADR   OGC
VNLODGYR        VN      2593
IMUFINEV        VN      4200
#          GOLOADLV     VERB 50            DESCRIPTION
#                       AND OTHER PLEASE
## Page 279
#                       DO SOMETHING VERBS
#              PLEASE PERFORM, MARK, CALIBRATE, ETC.
#              1. PRESSING ENTER ON DSKY INDICATES REQUESTED ACTION HAS BEEN  PERFORMED, AND THE PROGRAM DOES THE
#                 SAME RECALL AS A COMPLETED LOAD.
#              2. THE EXECUTION OF A VERB 33 (PROCEED WITHOUT DATA) INDICATES THE REQUESTED ACTION IS NOT DESIRED.

                SBANK=  PINSUPER        # FOR LOADLV1 AND SHOWSUM CADR'S.

GOLOADLV        TC      FLASHOFF

                CAF     PINSUPBT
                EXTEND
                WRITE   SUPERBNK
                TC      POSTJUMP
                CADR    LOADLV1
# VERB 47 - AGS INITIALIZATION - R47.

#          SEE LOG SECTION AGS INITIALIZATION FOR OTHER PERTINENT REMARKS.

V47TXACT        TC      TESTXACT        # NO OTHER EXTVERB.
                CAF     PRIO4
                TC      FINDVAC
                EBANK=  AGSK
                2CADR   AGSINIT

                TC      ENDOFJOB

CKMODCAD        CA      MODECADR
                EXTEND
                BZF     TCQ
                TC      ALM/END         # SOMEBODY IS USING MODECADR SO EXIT

## Page 280
#          ALINTIME     VERB 55            DESCRIPTION
#                 REQUIRE POO OR POO-.
#              1. SET EXT VERB DISPLAY BUSY FLAG.
#              2. DISPLAY FLASHING V25,N24 (LOAD DELTA TIME FOR AGC CLOCK.
#              3. REQUIRE EXECUTION OF VERB 23.
#              4. ADD DELTA TIME, RECEIVED FROM INPUT REGISTER, TO THE COMPUTER TIME.
#              5. RELEASE EXT VERB DISPLAY SYSTEM

ALINTIME        TC      TESTXACT
                TC      POSTJUMP        # NO ROOM IN 43
                CADR    R33

                BANK    42
                SETLOC  SBAND
                BANK
                COUNT*  $$/R33

R33             CAF     PRIO7
                TC      PRIOCHNG
                CAF     VNLODDT
                TC      BANKCALL
                CADR    GOXDSPF
                TC      ENDEXT          # TERMINATE
                TC      ENDEXT          # PROCEED
                CS      DEC23           # DATA IN OR RESEQUENCE(UNLIKELY)
                AD      MPAC            # RECALL LEFT VERB IN MPAC
                EXTEND
                BZF     UPDATIME        # GO AHEAD WITH UPDATE ONLY IF RECALL
                TC      ENDEXT          #   WITH V23 (DATA IN).

UPDATIME        INHINT                  # DELTA TIME IS IN DSPTEM1, +1.
                CAF     ZERO
                TS      MPAC +2         # NEEDED FOR TP AGREE
                TS      L               # ZERO T1 + 2 WHILE ALIGNING.
                DXCH    TIME2
                DXCH    MPAC
                DXCH    DSPTEM2 +1      # INCREMENT
                DAS     MPAC

                TC      TPAGREE         # FORCE SIGN AGREEMENT.
                DXCH    MPAC            # NEW CLOCK.
                DAS     TIME2
                RELINT
UPDTMEND        TC      ENDEXT

DEC23           DEC     23              # V 23

VNLODDT         VN      2524            # V25N24 FOR LOAD DELTA TIME

## Page 281
#          SET UP FOR RADAR SAMPLING.

                BANK    42
                SETLOC  EXTVERBS
                BANK

                EBANK=  RSTACK

                COUNT*  $$/R0477

R77             TC      RDRUSECK        # TRY TO AVOID THE 1210.
                CA      FLAGWRD3        # IS R04 RUNNING?
                MASK    R04FLBIT
                CCS     A
                TC      ALM/END         # YES.
                TC      UPFLAG
                ADRES   R77FLAG
                TCF     R04Z

R04             TC      RDRUSECK        # TRY TO AVOID THE 1210.
                TC      TESTXACT
                TC      UPFLAG
                ADRES   R04FLAG         # SET R04FLAG FOR ALARMS

R04Z            CAF     EBANK4
                TS      EBANK
                CAF     1SEC+1          # SAMPLE ONCE PER SECOND
                TS      RSAMPDT
                CAF     ZERO
                TS      RTSTLOC
                TS      RFAILCNT        # ZERO BAD SAMPLE COUNTER

                INHINT
                CS      LRPOSCAL        # INITIALIZE
                MASK    RADMODES        #     BIT9   LR RANGE  LOW SCALE =0
                TS      RADMODES        #     BIT6   LR POS 1 =0
                CAF     LRPOSCAL        #     BIT3   RR RANGE  LOW SCALE =0
                EXTEND
                RAND    CHAN33
                ADS     RADMODES
                RELINT

                CS      FLAGWRD3        # CHECK R04FLAG      R04 =1    R77 =0
                MASK    R04FLBIT
                CCS     A
                TCF     R04K

                CAF     ONE             # INDICATES RENDEZVOUS DESIRED
                TS      OPTIONX +1
R04A            CAF     BIT3            # OPTION CODE FOR V04N12

## Page 282
                TS      OPTIONX
                CAF     V04N12X
                TC      BANKCALL        #     R2   00001  RENDEZVOUS RADAR
                CADR    GOMARKFR        #          00002  LANDING RADAR
                TCF     R04END          # V34
                TCF     +5              # V33
                TCF     R04A +2         # R2
                CAF     BIT3
                TC      BLANKET
                TC      ENDOFJOB

                CA      OPTIONX +1      # SAVE DESIRED OPTION     RR =1     LR =2
                TS      RTSTDEX

R04X            CAF     SIX             # RR OR LR DESIRED
                MASK    RTSTDEX
                CCS     A
                TCF     R04L            # LANDING RADAR
                TS      RTSTBASE        # FOR RR   BASE = 0, MAX = 1

R04B            CAF     BIT2            # IS RR AUTO MODE DISCRETE PRESENT
                EXTEND
                RAND    CHAN33
                EXTEND
                BZF     R04C            # YES

                CAF     201R04          # REQUEST SELECTION OF RR AUTO MODE
                TS      DSPTEM1
                CAF     V50N25X
                TC      BANKCALL
                CADR    GOMARK4
                TCF     R04END          # V34
                TCF     R04B            # V33
                TCF     -7              # E

R04C            CAF     BIT14           # ENABLE RR AUTO TRACKER
                EXTEND
                WOR     CHAN12

                CAF     TWO
                TS      RTSTMAX         # FOR SEQUENTIAL STORAGE

                TC      WAITLIST
                EBANK=  RSTACK
                2CADR   RADSAMP

                RELINT

                CS      FLAGWRD3        # CHECK R04FLAG      R04 =1    R77 =0
                MASK    R04FLBIT
## Page 283
                CCS     A
                TCF     GOPIN           # R77

                CAF     SIX             # RR OR LR
                MASK    RTSTDEX
                CCS     A
                TCF     R04LR           # LR

R04RR           CAF     V16N72          # DISPLAY RR CDU ANGLES (1/SEC)
                TC      BANKCALL        #          R1  +  XXX.XX DEG   TRUNNION
                CADR    GOMARKF         #          R2  +  XXX.XX DEG   SHAFT
                TCF     R04END          # V34      R3     BLANK
                TCF     +2              # V33
                TCF     R04RR           # V32

                CAF     V16N78          # DISPLAY RR RANGE AND RANGE RATE (1/SEC)
                TC      BANKCALL        #          R1  +- XXX.XX NM    RANGE
                CADR    GOMARKF         #          R2  +- XXXXX. FPS   RANGE RATE
                TCF     R04END          # V34      R3     BLANK
                TCF     R04Y            # V33
                TCF     R04RR           # V32

R04LR           CAF     V16N66          # DISPLAY LR RANGE AND POSITION (1/SEC)
                TC      BANKCALL        #          R1  +- XXXXX. FT    LR RANGE
                CADR    GOMARKF         #          R2  +  0000X.       POS. NO.
                TCF     R04END          # V34      R3     BLANK
                TCF     +2              # V33
                TCF     R04LR           # V32

                CAF     V16N67          # DISPLAY LR VELX, VELY, VELZ (1/SEC)
                TC      BANKCALL        #          R1  +- XXXXX. FPS   LR V(X)
                CADR    GOMARKF         #          R2  +- XXXXX. FPS   LR V(Y)
                TCF     R04END          # V34      R3  +- XXXXX. FPS   LR V(Z)
                TCF     R04Y            # V33
                TCF     R04LR           # V32

R04Y            CAF     ZERO            # TO TERMINATE SAMPLING
                TS      RSAMPDT
                TC      BANKCALL
                CADR    2SECDELY        # WAIT FOR LAST RADARUPT
                CAF     1SEC+1          # SAMPLE ONCE PER SECOND
                TS      RSAMPDT
                CAF     ZERO            # FOR STORING RESULTS
                TS      RTSTLOC
                CCS     RTSTBASE        #  CHECK WHICH RADAR HAD BEEN SAMPLED
                CS      ONE             # WAS LR
                AD      TWO             # WAS RR
                TCF     R04X -1

R04K            CAF     250MS+1         # SAMPLE 4 LR COMPONENTS PER SECOND.
## Page 284
                TS      RSAMPDT

R04L            CAF     TWO
                TS      RTSTBASE        # FOR LR   BASE = 2, MAX = 3
                CAF     SIX
                TCF     R04C +4
R04END          CAF     ZERO            # ZERO RSAMPDT
                TS      RSAMPDT         # TO TERMINATE SAMPLING
                CAF     BIT8            # WAIT 1.28 SECONDS FOR POSSIBLE
                TC      BANKCALL        # PENDING RUPT.
                CADR    DELAYJOB

                INHINT
                CS      BIT14           # DISABLE RR AUTO TRACKER
                EXTEND
                WAND    CHAN12

                TC      DOWNFLAG
                ADRES   R04FLAG         # SIGNAL END OF R04.

                TC      ENDEXT

R77END          CAF     EBANK4          # TO TERMINATE SAMPLING
                TS      EBANK
                CAF     ZERO
                TS      RSAMPDT
                CAF     BIT6            # WAIT 320 MS FOR POSSIBLE
                TC      BANKCALL        # PENDING RUPT.
                CADR    DELAYJOB

                TC      DOWNFLAG
                ADRES   R77FLAG
                TCF     GOPIN

V16N72          VN      1672
V16N78          VN      1678
V16N66          VN      1666
V16N67          VN      1667
V04N12X         VN      412
V50N25X         VN      5025
201R04          OCT     00201
1SEC+1          DEC     101
250MS+1         EQUALS  CALLCODE
LRPOSCAL        OCT     444

## Page 285
RDRUSECK        CA      FLAGWRD5        # IS R77 RUNNING?
                MASK    R77FLBIT
                CCS     A
                TC      ALM/END         # YES.
                CS      FLAGWRD7        # IS SERVICER RUNNING AND HENCE POSSIBLY
                MASK    V37FLBIT        # R12 USING THE LR?
                CCS     A
                TCF     CHECKRR         # NO
                CA      FLGWRD11        # YES, IS R12 ON?
                MASK    LRBYBIT         # BIT 15
                EXTEND
                BZF     ALM/END         # YES
CHECKRR         CS      FLAGWRD1        # IS THE TRACK FLAG SET AND HENCE POSSIBLY
                MASK    TRACKBIT        # P20 USING THE RR?
                CCS     A
                TC      Q               # NOT ALLOWED DURING P20
                TC      ALM/END         # P22 OR P25,  (R65)
                COUNT*  $$/EXTVB

VB64            TC      TESTXACT        # IF DISPLAY SYS. NOT BUSY,MAKE IT BUSY.
                CAF     PRIO4
                TC      FINDVAC
                EBANK=  ALPHASB
                2CADR   SBANDANT        # CALC.,DISPLAY S-BAND ANTENNA ANGLES.

                TC      ENDOFJOB

## Page 286
#          IMUATTCK     VERB 43            DESCRIPTION
#              LOAD IMU ATTITUDE ERROR METERS
#                 1. REQUIRE POO OR FRESH START.
#                 2. REQUIRE COARSE ALIGN ENABLE AND ZERO ICDU BITS OFF.
#                 3. REQUIRE THAT NEEDLES BE OFF.
#                 4. REQUEST LOAD OF N22  (VAUES TO BE DISPLAYED).
#                 5. ON PROCEED OR ENTER RE-DISPLAY V43 AND SEND PULSES.

IMUATTCK        TC      CHKPOOH         # VB 76 - LOAD IMU ATT. ERROR METERS

                CAF     BITS4&5         # SEE IF COARSE ALIGN ENABLE AND ZERO IMU
                EXTEND                  # CDUS BITS ARE ON
                RAND    CHAN12
                CCS     A
                TCF     ALM/END         # NOT ALLOWED IF IMU COARSE OR IMU ZERO ON

                CAF     BIT13-14        # BOTH BITS 13 AND 14 MUST BE 1
                EXTEND                  # INDICATING THE MODE SELECTED IS OFF.
                RXOR    CHAN31
                MASK    BIT13-14
                EXTEND
                BZF     +2              # NEEDLES IS OFF.
                TCF     ALM/END         # EXIT.  NEEDLES IS ON.

                TC      TESTXACT

                CAF     VNLODCDU
                TC      BANKCALL
                CADR    GOXDSPF
                TC      ENDEXT          # V34
                TC      +1
                CAF     V43K            # REDISPLAY OUR VERB.
                TC      BANKCALL
                CADR    EXDSPRET
                CAF     BIT6
                EXTEND
                WOR     CHAN12          # ENABLE ERROR COUNTERS.
                CAF     TWO
                TC      WAITLIST        # PUT OUT COMMANDS IN .32 SECONDS.
                EBANK=  THETAD
                2CADR   ATTCK2

                TCF     ENDEXT

                BANK    42
                SETLOC  PINBALL3        # SOMETHING IN B42.
                BANK

                COUNT*  $$/EXTVB
## Page 287
ATTCK2          CAF     TWO             # PUT OUT COMMANDS.
 +1             TS      Q               # CDU WILL LIMIT EXCESS DATA.
                INDEX   A
                CA      THETAD
                EXTEND
                MP      ATTSCALE
                INDEX   Q
                XCH     CDUXCMD
                CCS     Q
                TCF     ATTCK2 +1

                CAF     13,14,15
                EXTEND
                WOR     CHAN14
                TCF     TASKOVER        # LEAVE ERROR COUNTERS ENABLED.

ATTSCALE        DEC     0.1

                BANK    7
                SETLOC  EXTVERBS
                BANK

                COUNT*  $$/EXTVB

V43K            VN      4300
#          V82PERF     VERB 82             DESCRIPTION
#              REQUEST ORBIT PARAMETERS DISPLAY (R30)
# 1. IF AVERAGE G IS OFF:
#          FLASH DISPLAY V04N06. R2 INDICATES WHICH SHIP'S STATE VECTOR IS
#           TO BE UPDATED. INITIAL CHOICE IS THIS SHIP (R2=1). ASTRONAUT
#           CAN CHANGE TO OTHER SHIP BY V22EXE, WHERE X NOT EQ 1.
#          SELECTED STATE VECTOR UPDATED BY THISPREC (OTHPREC).
#          CALLS SR30.1 (WHICH CALLS TFFCONMU + TFFRP/RA) TO CALCULATE
#           RPER (PERIGEE RADIUS), RAPO (APOGEE RADIUS), HPER (PERIGEE
#           HEIGHT ABOVE LAUNCH PAD OR LUNAR LANDING SITE), HAPO (APOGEE
#           HEIGHT AS ABOVE), TPER (TIME TO PERIGEE), TFF (TIME TO
#           INTERSECT 300 KFT ABOVE PAD OR 35KFT ABOVE LANDING SITE).
#          FLASH MONITOR V16N44 (HAPO, HPER, TFF).TFF IS -59M59S IF IT WAS
#           NOT COMPUTABLE, OTHERWISE IT INCREMENTS ONCE PER SECOND.
#           ASTRONAUT HAS OPTION TO MONITOR TPER BY KEYING IN N 32 E.
#           DISPLAY IS IN HMS, IS NEGATIVE (AS WAS TFF), AND INCREMENTS
#           ONCE PER SECOND ONLY IF TFF DISPLAY WAS -59M59S.

# 2. IF AVERAGE G IS ON:
#          CALLS SR30.1 APPROX EVERY TWO SECS.  STATE VECTOR IS ALWAYS
#           FOR THIS VEHICLE. V82 DOES NOT DISTURB STATE VECTOR.  RESULTS
#           OF SR30.1 ARE RAPO, RPER, HAPO, HPER, TPER, TFF.
#          FLASH MONITOR V16N44 (HAPO, HPER, TFF).
#          IF MODE IS P11, THEN CALL DELRSPL SO ASTRONAUT CAN MONITOR
#           RESULTS BY N50E. SPLASH COMPUTATION DONE ONCE PER TWO SECS.

## Page 288
V82PERF         TC      TESTXACT

                CAF     PRIO7           # LESS THAN LAMBERT.  R30,V82
                TC      PRIOCHNG
                EXTEND
                DCA     V82CON
                TC      SUPDXCHZ        # V82CALL IN DIFF SUPERBANK FROM V82PERF

                EBANK=  HAPO
V82CON          2CADR   V82CALL

#          VB83PERF     VERB 83            DESCRIPTION
#              REQUEST RENDEZVOUS PARAMETER DISPLAY (R31)
#              1. SET EXT VERB DISPLAY BUSY FLAG.
#              2. SCHEDULE R31CALL WITH PRIORITY 5.
#                 A. DISPLAY
#                     R1  RANGE
#                     R2  RANGE RATE
#                     R3  THETA

V83PERF         TC      TESTXACT

                CAF     BIT2
                TC      WAITLIST
                EBANK=  TSTRT
                2CADR   R31CALL

                TC      ENDOFJOB

# VERB 89 DESCRIPTION     RENDEZVOUS FINAL ATTITUDE ROUTINE (R63)

# CALLED BY VERB 89 ENTER DURING P00. PRIO 10 USED.  CALCULATES AND
# DISPLAYS FINAL FDAI BALL ANGLES TO POINT LM +X OR +Z AXIS AT CSM.

# 1. KEY IN V 89 E ONLY IF IN PROG 00. IF NOT IN P00, OPERATOR ERROR AND
# EXIT R63, OTHERWISE CONTINUE.

# 2. IF IN P00, DO IMU STATUS CHECK ROUTINE (R02BOTH). IF IMU ON AND ITS
# ORIENTATION KNOWN TO LGC, CONTINUE.

# 3. FLASH DISPLAY V 04 N 06.  R2 INDICATES WHICH SPACECRAFT AXIS IS TO
# BE POINTED AT CSM.  INITIAL CHOICE IS PREFERRED (+Z) AXIS (R2=1).
# ASTRONAUT CAN CHANGE TO (+X) AXIS (R2 NOT = 1) BY V 22 E 2 E.  CONTINUE
# AFTER KEYING IN PROCEED.

# 4. BOTH VEHICLE STATE VECTORS UPDATED BY CONIC EQS.

# 5. HALF MAGNITUDE UNIT LOS VECTOR (IN STABLE MEMBER COORDINATES) AND
## Page 289
# HALF MAGNITUDE UNIT SPACECRAFT AXIS VECTOR (IN BODY COORDINATES)
# PREPARED FOR VECPOINT.

# 6. GIMBAL ANGLES FROM VECPOINT TRANSFORMED INTO FDAI BALL ANGLES BY
# BALLANGS. FLASH DISPLAY V 06 N 18 AND AWAIT RESPONSE.

# 7. RECYCLE - RETURN TO STEP 4.
#    TERMINATE - EXIT R63.
#    PROCEED - RESET 3AXISFLG AND CALL R60LEM FOR ATTITUDE MANEUVER.


V89PERF         TC      CHKPOOH
                TC      TESTXACT
                CAF     PRIO10
                TC      FINDVAC
                EBANK=  RONE
                2CADR   V89CALL

                TC      ENDOFJOB

#          V90PERF     VERB 90             DESCRIPTION
#              REQUEST RENDEZVOUS OUT-OF-PLANE DISPLAY (R36)
#              1. SET EXT VERB DISPLAY BUSY FLAG.
#              2. SCHEDULE R36 CALL WITH PRIORITY 10
#                 A. DISPLAY
#                     TIME OF EVENT - HOURS , MINUTES , SECONDS
#                     Y  OUT-OF-PLANE POSITION - NAUTICAL MILES
#                     YDOT  OUT-OF-PLANE VELOCITY - FEET/SECOND
#                     PSI  ANGLE BTW LINE OF SIGHT AND FORWARD
#                          DIRECTION VECTOR IN HORIZONTAL PLANE - DEGREES

V90PERF         CS      FLAGWRD7
                MASK    V37FLBIT
                EXTEND
                BZF     ALM/END         # AVERAGE G ON: ILL EAGLE
                TC      TESTXACT
                CAF     PRIO7           # R36,V90
                TC      FINDVAC
                EBANK=  TIG
                2CADR   R36

                TCF     ENDOFJOB
#          MINIMP     VERB 76              DESCRIPTION
#              MINIMUM IMPULSE MODE
#              1. SET MINIMUM IMPULSE RHC MODE FLAG TO 1.

MINIMP          TC      UPFLAG          # SET PULSES = 1 (MIN. IMPULSE MODE)
                ADRES   PULSEFLG
                TCF     GOPIN           # RETURN VIA PINBRNCH

## Page 290
#          NOMINIMP     VERB 77            DESCRIPTION
#              RATE COMMAND MODE
#              1. SET MINIMUM IMPULSE RHC MODE FLAG TO 0. (ZERO INDICATES NOT MINIMUM IMPULSE MODE.).
#              2. MOVE CDUX,CDUY,CDUZ INTO CDUXD,CDUYD,CDUZD.

NOMINIMP        TC      DOWNFLAG        # SET PULSES = 0 (NOT MINIMUM IMPULSE MODE
                ADRES   PULSEFLG
                INHINT
                TC      IBNKCALL
                CADR    ZATTEROR
                TC      GOPIN

## Page 291
#          CREWMANU     VERB 49            DESCRIPTION
#              START AUTOMATIC ATTITUDE MANEUVER
#              1. REQUIRE PROGRAM 00 ACTIVE.
#              2. SET EXT VERB DISPLAY BUSY FLAG.
#              3. SCHEDULE R62DISP WITH PRIORITY 10.
#              4. RELEASE EXT VERB DISPLAY.

#            R62DISP
#              1. DISPLAY FLASHING V06,N22.
#                 RESPONSES
#                 A. TERMINATE
#                    1. GO TO GOTOPOOH.
#                 B. PROCEED
#                    1. SET 3AXISFLG TO INDICATE MANEUVER IS SPECIFIED BY 3 AXIS.
#                    2. EXECUTE R60LEM (ATTITUDE MANEUVER).
#                 C. ENTER
#                    1. REPEAT FLASHING V06,N22.

CREWMANU        TC      CHKPOOH         # DEMAND POO

                TC      TESTXACT

                CAF     PRIO10
                TC      FINDVAC
                EBANK=  BCDU
                2CADR   R62DISP

                TC      ENDOFJOB

## Page 292
# TRMTRACK     VERB 56                     DESCRIPTION
#              TERMINATE TRACKING (P20 AND P25).
#              1. KNOCK DOWN RENDEZVOUS, TRACK, AND UPDATE FLAGS.
#              2. REQUIRE P20 OR  P25 NOT RUNNING ALONE OR GO TO GOTOPOOH (REQUEST PROGRAM 00).
#              3. SCHEDULE V56TOVAC WITH PRIORITY 30.

#              V56TOVAC
#              1. EXECUTE INTSTALL (IF INTEGRATION IS RUNNING, STALL UNTIL IT IS FINISHED.).
#              2. ZERO GROUP 2 TO HALT P20.
#              3. TRANSFER CONTROL TO GOPROG2 (SOFTWARE RESTART).

TRMTRACK        CA      BITS9+7         # IS REND OR P25 FLAG ON
                MASK    FLAGWRD0
                EXTEND
                BZF     GOPIN           # NO

		TC	DOWNFLAG
		ADRES	RNDVZFLG
		
		TC	DOWNFLAG
		ADRES	P25FLAG

                TC      DOWNFLAG        # ENSURE SEARCH FLAG IS OFF
                ADRES   SRCHOPTN

                CA      TRACKBIT        # IS TRACK FLAG ON?
                MASK    FLAGWRD1
                EXTEND
                BZF     GOPIN
                
                TC      POSTJUMP
                CADR    TRMTRAK1

BITS9+7         OCT     500

                SETLOC  SBAND           # BANK 42
                BANK

                COUNT*  $$/EXTVB

TRMTRAK1        TC      INTPRET
                CLEAR   CLEAR
                        UPDATFLG	# CLEAR UPDATE FLAG
                        TRACKFLG	# CLEAR TRACK FLAG
                CLEAR	CALL
                	IMUSE
                        INTSTALL        # DONT INTERRUPT INTEGRATION
                EXIT

                TC      PHASCHNG
## Page 293
                OCT     2               # KILL GROUP 2 TO HALT P20 ACTIVITY

                INHINT
                TC      IBNKCALL        # ZERO THE COMMANDED RATES TO STOP
                CADR    STOPRATE        # MANEUVER

                TC      IBNKCALL
                CADR    RESTORDB

                TC      CLRADMOD        # CLEAR BITS 10 + 15 OF RADMODES.

                CS      BIT14           # DISABLE LOCKON
                EXTEND
                WAND    CHAN12
                TC      POSTJUMP
                CADR    GOPROG2         # CAUSE RESTART.

#          DNEDUMP     VERB 74             DESCRIPTION
#              INITIALIZE DOWN-TELEMETRY PROGRAM FOR ERASABLE MEMORY DUMP.
#              1. SET EXT VERB DISPLAY BUSY FLAG.
#              2. REPLACE CURRENT DOWNLIST WITH ERASABLE MEMORY.
#              3. RELEASE EXT VERB DISPLAY.

                SETLOC  EXTVERBS
                BANK

                COUNT*  $$/EXTVB

                EBANK=  400
DNEDUMP         CAF     LDNDUMPI
                TS      DNTMGOTO
                TC      GOPIN

V74             EQUALS  DNEDUMP
LDNDUMPI        REMADR  DNDUMPI

#          LEMVEC     VERB 80              DESCRIPTION
#              UPDATE LEM STATE VECTOR
#                 RESET VEHUPFLG TO 0

LEMVEC          TC      DOWNFLAG
                ADRES   VEHUPFLG        # VB 80 - VEHUPFLG DOWN INDICATES LEM

                TC      NOUPDOWN
#          CSMVEC     VERB 81              DESCRIPTION
#              UPDATE CSM STATE VECTOR
#                 SET   VEHUPFLG TO 1

CSMVEC          TC      UPFLAG
## Page 294
                ADRES   VEHUPFLG        # VB 81 - VEHUPFLG UP INDICATES CSM

NOUPDOWN        TC      DOWNFLAG
                ADRES   NOUPFLAG

                TCF     GOPIN

#          UPDATOFF   VERB 95      DESCRIPTION
#              INHIBIT STATE VECTOR UPDATES BY INCORP
#                 SET NOUPFLAG TO 1

UPDATOFF        TC      UPFLAG          # VB 95 SET NOUPFLAG
                ADRES   NOUPFLAG

                TC      GOPIN

## Page 295
#          SYSTEST     VERB 92             DESCRIPTION
#            OPERATE IMU PERFORMANCE TEST.
#              1. REQUIRE PROGRAM 00 OR TURN ON OPERATOR ERROR.
#              2. SET EXT VERB BUSY FLAG.
                EBANK=  QPLACE

SYSTEST         TC      CHKPOOH         # DEMAND POO

                CS      FLAGWRD3        # DO NOT ALLOW P07 IN FLIGHT
                MASK    NOP07BIT        # IF FLAG IS SET, TURN ON OE LITE AND EXIT
                EXTEND
                BZF     ALM/END
                TC      TESTXACT

                CAF     PRIO22
                TC      FINDVAC
                EBANK=  QPLACE
                SBANK=  IMUSUPER
                2CADR   REDO

                TC      ENDOFJOB

# VERB 93         CLEAR RENDWFLG, CAUSES W-MATRIX TO BE RE-INITIALIZED.

WMATRXNG        INHINT
                CS      RENDWBIT
                MASK    FLAGWRD5
                TS      FLAGWRD5

                TC      GOPIN

GOSHOSUM        EQUALS  SHOWSUM

SHOWSUM         TC      CHKPOOH         # *
                TC      TESTXACT        # *
                CAF     PRIO7           # ALLOW OTHER CHARINS.
                TC      PRIOCHNG
                CAF     S+1             # *
                TS      SKEEP6          # * SHOWSUM OPTION
                CAF     S+ZERO          # *
                TS      SMODE           # * TURN OFF SELF-CHECK
                CA      SELFADRS        # *
                TS      SELFRET         # *
                TC      STSHOSUM        # * ENTER ROPECHK

SDISPLAY        LXCH    SKEEP2          # * BANK # FOR DISPLAY
                LXCH    SKEEP3          # * BUGGER WORD FOR DISPLAY
NOKILL          CA      ADRS1           # *
                TS      MPAC +2         # *
                CA      VNCON           # * 0501
## Page 296
                TC      BANKCALL        # *
                CADR    GOXDSPF         # *
                TC      +3              # *
                TC      NXTBNK          # *
                TC      NOKILL          # *
                CA      SELFADRS
                TS      SKEEP1

                TC      ENDEXT          # *

VNCON           VN      501             # *

ENDSUMS         CA      SKEEP6          # *
                EXTEND                  # *
                BZF     SELFCHK         # * ROPECHK, START SELFCHK AGAIN.
                TC      STSHOSUM        # * START SHOWSUM AGAIN.

## Page 297
#          DAPDISP     VERB 48             DESCRIPTION
#              LOAD AUTO PILOT  DATA
#              1. REQUIRE EXT VERB DISPLAY AVAILABLE AND SET BUSY FLAG.
#              2. EXECUTE DAPDATA1, DAPDATA2, AND DAPDATA3.
#              3. RELEASE EXT VERB DISPLAY SYSTEM.
# KEY
# THE FOLLOWING IS A KEY TO THE 5 DIGITS OF THE DAP DATA CODE (N46)

# DIGIT A - VEHICLE CONFIGURATION
#          1 - LM ALONE, ASCENT
#          2 - LM ALONE, DESCENT
#          3 - CSM AND LM DOCKED

# DIGIT B - ACCELERATION CODE
#          0 - 2 JET TRANSLATION, RCS SYSTEM A PREFERRED
#          1 - 2 JET TRANSLATION, RCS SYSTEM B PREFERRED
#          2 - 4 JET TRANSLATION, RCS SYSTEM A PREFERRED (NOT MEANINGFUL)
#          3 - 4 JET TRANSLATION, RCS SYSTEM B PREFERRED (NOT MEANINGFUL)

# DIGIT C - ACA SCALING
#          0 - FINE
#          1 - NORMAL

# DIGIT D - DEADBAND
#          0 - 0.3 DEG
#          1 - 1.0 DEG
#          2 - 5.0 DEG
#         (3 - 5.0 DEG BY DEFAULT)

# DIGIT E - MANEUVER RATE
#          0 - 0.2 DEG/SEC
#          1 - 0.5 DEG/SEC
#          2 - 2.0 DEG/SEC
#          3 -10.0 DEG/SEC

DAPDISP         TC      TESTXACT
                CAF     PRIO7           # R03
                TC      PRIOCHNG
                TC      POSTJUMP
                CADR    DAPDATA1
                BANK    34
                SETLOC  LOADDAP
                BANK

                COUNT*  $$/R03

                SBANK=  LOWSUPER        # FOR SUBSEQUENT LOW 2CADR'S.

DAPDATA1        CAF     BOOLSMSK        # SET DISPLAY ACCORDING TO DAPBOOLS BITS.
                MASK    DAPBOOLS        # LM
## Page 298
                TS      DAPDATR1        # LM
                CS      FLGWRD10        # SET BIT 14 TO BE COMPLEMENT OF APSFLAG.
                MASK    APSFLBIT
                CCS     A
                CAF     BIT14
                ADS     DAPDATR1
CHKDATA1        CAE     DAPDATR1        # IF BITS 13 AND 14 ARE BOTH ZERO, FORCE
                MASK    BIT13-14        #   A ONE INTO BIT 13.
                EXTEND
                BZF     FORCEONE
                CAE     DAPDATR1        # ENSURE THAT NO ILLEGAL BITS SET BY CREW.
MSKDATR1        MASK    DSPLYMSK
                TS      DAPDATR1
                CAF     V01N46          # LM
                TC      BANKCALL
                CADR    GOXDSPFR
                TCF     ENDEXT          # V34E  TERMINATE
                TCF     DPDAT1          # V33E  PROCEED
                TCF     CHKDATA1        # E     NEW DATA    CHECK AND REDISPLAY
                CAF     REVCNT		# BITS 2 & 3:  BLANKS R2 & R3.
                TC      BLANKET
                TCF     ENDOFJOB
FORCEONE        CAF     BIT13
                ADS     DAPDATR1
                TCF     MSKDATR1

DPDAT1          INHINT                  # INHINT FOR SETTING OF FLAG BITS AND MASS
                CS      APSFLBIT        #   ON BASIS OF DISPLAYED DAPDATR1.
                MASK    FLGWRD10
                TS      L               # SET APSFLAG TO BE COMPLEMENT OF BIT 14.
                CS      DAPDATR1
                MASK    BIT14
                CCS     A
                CAF     APSFLBIT
                AD      L
                TS      FLGWRD10
                CS      DAPDATR1        # SET BITS OF DAPBOOLS ON BASIS OF DISPLAY
                MASK    BIT13-14        #   MASK OUT CSMDOCKD (BIT 13) UNLESS BOTH
                CCS     A               #   13 AND 14 ARE SET.
                CS      CSMDOCKD
                AD      BOOLSMSK
                MASK    DAPDATR1
                TS      L
                CS      BOOLSMSK
                MASK    DAPBOOLS
                AD      L
                TS      DAPBOOLS
                MASK    CSMDOCKD        # LOAD MASS IN ACCORDANCE WITH CSMDOCKD.
                CCS     A               #   MASS IS USUALLY ALREADY OKAY, SO DO
                CAE     CSMMASS         #   NOT TOUCH ITS LOW-ORDER PART.
## Page 299
                AD      LEMMASS
                TS      MASS
                CAE     DAPBOOLS
                MASK    ACC4OR2X        # 2 OR 4 JET X-TRANSLATION
                EXTEND                  # (BIT ACC4OR2X = 1 FOR 4 JETS)
                BZF     +5
                CS      BIT15
                MASK    FLAGWRD1        # CLEAR NJTSFLAG TO 0 FOR 4 JETS
                TS      FLAGWRD1
                TCF     +4
                CS      FLAGWRD1        # SET NJTSFLAG TO 1 FOR 2 JETS
                MASK    BIT15
                ADS     FLAGWRD1
                CA      DAPBOOLS        # SELECT DESIRED KALCMANU AUTOMATIC
                MASK    THREE           # MANEUVER RATE
                DOUBLE                  # RATEINDX HAS TO BE 0,2,4,6 SINCE RATES
                TS      RATEINDX        # ARE DP
                TC      POSTJUMP
                CADR    STIKLOAD

V01N46          VN      0146
DSPLYMSK        OCT     33133
BOOLSMSK        OCT     13133
                BANK    01
                SETLOC  LOADDAP1
                BANK

                COUNT*  $$/R03

STIKLOAD        CAF     EBANK6
                TS      EBANK
                EBANK=  STIKSENS
                CA      RHCSCALE        # SET STICK SENSITIVITY TO CORRESPOND TO A
                MASK    DAPBOOLS        # MAXIMUM COMMANDED RATE (AT 42 COUNTS) OF
                CCS     A               # 20 D/S(NORMAL) OR 4 D/S(FINE), SCALED
                CA      NORMAL          # AT 45 D/S.
                AD      FINE
                TS      STIKSENS
                CA      -0.6D/S
                TS      -RATEDB         # LM-ONLY BREAKOUT LEVEL IS .6 D/S.
                CA      CSMDOCKD        # IF CSM-DOCKED, DIVIDE STICK SENSITIVITY
                MASK    DAPBOOLS        # BY 10. NORMAL SCALING IS THEN 2 D/S AND
                EXTEND                  # FINE SCALING IS 0.4 D/S
                BZF     +7              # BRANCH IF CSM IS NOT DOCKED.
                CA      STIKSENS
                EXTEND
                MP      1/10
                TS      STIKSENS
                CA      -0.3D/S         # CSM-DOCKED BREAKOUT LEVEL IS .3 D/S.
                TS      -RATEDB
## Page 300
                RELINT                  # PROCEED TO NOUN 47, MASS LOAD,

DAPDATA2        CAF     V0647
                TC      BANKCALL
                CADR    GOXDSPFR
                TCF     ENDR03          # V34E  TERMINATE. FIRST SET DB, DO 1/ACCS
                TCF     DAPDAT2         # V33E  PROCEED
                TCF     DAPDATA2        #       LOAD NEW DATA AND RECYCLE
                CAF     BIT3            # BLANKS R3
                TC      BLANKET         #            LM
                TCF     ENDOFJOB
ENDR03          INHINT
                TC      IBNKCALL
                CADR    RESTORDB
                TCF     ENDEXT          # DOES RELINT

DAPDAT2         CS      FLGWRD10        # DETERMINE STAGE FROM APSFLAG
                MASK    APSFLBIT
                CCS     A
                CA      MINLMD
                AD      MINMINLM
                AD      LEMMASS         # LEMMASS MUST BE GREATER THAN EMPTY LEM
                EXTEND
                BZMF    DAPDATA2        # ASK FOR NEW MASSES
                CAE     DAPBOOLS
                MASK    CSMDOCKD
                EXTEND
                BZF     LEMALONE        # SKIP TEST ON CSMMASS IF NOT DOCKED.
                CS      MINCSM          # TEST CSM MASS
                AD      CSMMASS         # CSMMASS MUST BE GREATER THAN EMPTY CSM
                EXTEND
                BZMF    DAPDATA2        # ASK FOR NEW MASSES
                CAE     CSMMASS         # DOCKED:  MASS = CSMMASS + LEMMASS
LEMALONE        AD      LEMMASS         # LEM ALONE:  MASS = LEMMASS
                ZL
                DXCH    MASS
                INHINT
                TC      IBNKCALL        # SET DEADBANK AND COMPUTE MOMENTS OF
                CADR    RESTORDB        #   INERTIA.
                RELINT                  # PROCEED TO NOUN 48 (OR END).

DAPDATA3        CS      FLGWRD10
                MASK    APSFLBIT
                EXTEND                  # END ROUTINE IF LEM HAS STAGED,
                BZF     ENDEXT
                CAF     V06N48          # DISPLAY TRIM ANGLES AND REQUEST RESPONSE
                TC      BANKCALL
                CADR    GOXDSPFR
                TC      ENDEXT
                TCF     DPDAT3          # V33E GO DO TRIM (WAITLIST TO TRIMGIMB)

## Page 301
                TCF     -5              #      LOAD NEW DATA AND RECYCLE
                CAF     BIT3
                TC      BLANKET         # BLANK R3
                TCF     ENDOFJOB
DPDAT3          CAF     BIT1
                TC      WAITLIST
                EBANK=  ROLLTIME
                2CADR   TRIMGIMB

                TCF     ENDOFJOB        # DOES A RELINT
TRIMDONE        CAF     V50N48
                TC      BANKCALL        # TRIM IS FINISHED; PLEASE TERMINATE R03
                CADR    GOMARK3R -1
                TC      ENDEXT          # V34E TERMINATE
                TC      ENDEXT
                TC      ENDEXT
                CAF     OCT24           # BIT5 TO CHANGE TO PERFORM, 3 TO BLANK R3
                TC      BLANKET
                TCF     ENDOFJOB

V0647           VN      0647
V06N48          VN      0648

V50N48          =       V06N48

NORMAL          DEC     .660214
                                        # NORMAL SCALING IS 20 D/S
FINE            DEC     .165054         # FINE STICK SCALING (4 D/S).
1/10            DEC     .1              # FACTOR FOR CSM-DOCKED SCALING
-0.6D/S         DEC     -218
-0.3D/S         DEC     -109

## Page 302
# VERB 66.  VEHICLES ARE ATTACHED.  MOVE THIS VEHICLE STATE VECTOR TO
#           OTHER VEHICLE STATE VECTOR.

#     USE SUBROUTINE GENTRAN.

                BANK    7
                SETLOC  EXTVERBS
                BANK

                COUNT*  $$/EXTVB

                EBANK=  RRECTHIS

ATTACHED        CS      FLAGWRD8
                MASK    SURFFBIT
                EXTEND
                BZF     ALM/END         # TURN ON OE AND EXIT IF SURFFLAG SET.
                CAF     PRIO10
                TC      FINDVAC
                EBANK=  RRECTHIS

                2CADR   ATTACHIT

                TC      ENDOFJOB

ATTACHIT        TC      INTPRET
                CALL
                        INTSTALL
                SET     BON
                        MOONOTH
                        MOONTHIS
                        +3
                CLEAR
                        MOONOTH
                EXIT
                CAF     OCT51
                TC      GENTRAN
                ADRES   RRECTHIS        # OUR STATE VECTOR INTO OTHER VIA GENTRAN
                ADRES   RRECTOTH

                RELINT
                TC      INTPRET
                CALL                    # UPDATE R-OTHER, V-OTHER
                        PTOALEM
                LXA,2   CALL
                        PBODY
                        SVDWN1
                EXIT

                CAF     TCPINAD
## Page 303
                INDEX   FIXLOC
                TS      QPRET
                TC      POSTJUMP
                CADR    INTWAKE         # FREE INTEGRATION AND EXIT.

TCPIN           RTB
                        PINBRNCH

OCT51           OCT     51
TCPINAD         CADR    TCPIN

# VERB 96  SET QUITFLAG TO STOP INTEGRATION.

#          GO TO V37 WITH ZERO TO CAUSE POO.
#          STATEINT WILL CHECK QUITFLAG AND SKIP 1ST PASS,
#                 THUS ALLOWING A 10 MINUTE PERIOD WITHOUT INTEGRATION.

VERB96          TC      UPFLAG          # QUITFLAG WILL CAUSE INTEGRATION TO EXIT
                ADRES   QUITFLAG        #    AT NEXT TIMESTEP

                CAF     ZERO
                TC      POSTJUMP
                CADR    V37             # GO TO POO


# VERB 67 :   DISPLAY OF W MATRIX

V67             TC      TESTXACT
                CAF     PRIO5
                TC      FINDVAC
                EBANK=  WWPOS
                2CADR   V67CALL

                TC      ENDOFJOB

# VERB 65         DISABLE U,V JETS DURING DPS BURNS

SNUFFOUT        TC      UPFLAG
                ADRES   SNUFFER
                TC      GOPIN

# VERB 75         ENABLE U,V JETS DURING DPS BURNS

OUTSNUFF        TC      DOWNFLAG
                ADRES   SNUFFER
                TC      GOPIN
# VERB 85         DISPLAY RR LOS AZIMUTH AND ELEVATION.

#          AZIMUTH IS THE ANGLE BETWEEN THE LOS AND THE X-Z NB PLANE, 0 - 90 DEG IN THE +Y HEMISPHERE,
# 360 - 270 DEG IN THE -Y HEMISPHERE.

## Page 304
#          ELEVATION IS THE ANGLE BETWEEN +ZNB AND THE PROJECTION OF THE LOS INTO THE X-Z PLANE, 0 - 360 ABOUT +Y.

                EBANK=  RR-AZ
VERB85          TC      TESTXACT
                TC      POSTJUMP
                CADR    DSPRRLOS

                SETLOC  PINBALL2
                BANK

                COUNT*  $$/EXTVB

DSPRRLOS        CAF     PRIO5
                TC      FINDVAC
                EBANK=  RR-AZ
                2CADR   RRLOSDSP

                CAF     PRIO4
                TC      PRIOCHNG
                CAF     V16N56
                TC      BANKCALL
                CADR    GOMARKFR
                TC      B5OFF
                TC      B5OFF
                TC      B5OFF

                CAF     BIT3
                TC      BLANKET
                TC      ENDOFJOB

V16N56          VN      1656


                SETLOC  PINBALL1
                BANK

RRLOSDSP        EXTEND
                DCA     CDUT
                DXCH    MPAC
                TC      INTPRET
                CALL
                        RRNBMPAC        # GET RR LOS IN BODY AXIS.
                STORE   0D              # UNIT LOS
                STODL   6D
                        HI6ZEROS
                STOVL   8D
                        6D
                UNIT
                STORE   6D              # UNIT OF LOS PROJ IN X-Z PLANE
                DOT
## Page 305
                        UNITZ
                STOVL   COSTH           # 16D
                        UNITX
                DOT
                        6D
                STCALL  SINTH           # 18D
                        ARCTRIG
                BPL     DAD             # INSURE DISPLAY OF 0 - 360 DEG.
                        +2
                        DPPOSMAX        # INTRODUCES AN ERROR OF B-28 REVS.
                STOVL   RR-ELEV
                        0D
                DOT
                        UNITY
                STOVL   SINTH
                        0D
                DOT
                        6D
                STCALL  COSTH
                        ARCTRIG
                BPL     DAD             # INSURE DISPLAY OF 0 - 360 DEG.
                        +2
                        DPPOSMAX        # INTRODUCES AN ERROR OF B-28 REVS.
                STORE   RR-AZ
                EXIT
                CA      1SEC
                TC      BANKCALL
                CADR    DELAYJOB

                CA      BIT5
                MASK    EXTVBACT
                CCS     A
                TC      RRLOSDSP
                TC      ENDEXT
