### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    IMU_PERFORMANCE_TESTS_4.agc
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
## Reference:   pp. 387-394
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2017-07-28 MAS  Created from Luminary 210.
##		2017-08-23 RSB	Transcribed.

## Page 387
# PROGRAM-IMU PERFORMANCE TESTS 4
# DATE-NOV 15,1966
# BY- GEORGE SCHMIDT IL7-146 EXT 1126
# MOD NO-ZERO


# FUNCTIONAL DESCRIPTION

# THIS SECTION CONSISTS OF THE FILTER FOR THE GYRO DRIFT TESTS. NO COMPASS
# IS DONE IN LEM. FOR A DESCRIPTION OF THE FILTER SEE E-1973. THIS
# SECTION IS ENTERED FROM IMU 2. IT RETURNS THERE AT END OF TEST.

# EARTHR,OGC ZERO,ERTHRVSE

# NORMAL EXIT

# LENGTHOT GOES TO ZERO-RETURN TO IMU PERF TESTS 2 CONTROL

# ALARMS

# 1600 OVERFLOW IN DRIFT TEST
# 1601    BAD IMU MODING IN ANY ROUTINE THAT USES IMUSTALL
# OUTPUT

# FLASHING DISPLAY OF RESULTS-CONTROLLED IN IMU PERF TESTS 2

# DEBRIS

# ALL CENTRALS-ALL OF EBANK XSM

## Page 388
                BANK            33
                SETLOC          IMU4
                BANK
                COUNT*          $$/P07

                EBANK=          XSM


ESTIMS          INHINT
                CAE             1SECXT
                TC              TWIDDLE
                EBANK=          XSM
                ADRES           ALLOOP
                CAF             ZERO                    # ZERO THE PIPAS
                TS              PIPAX
                TS              PIPAY
                TS              PIPAZ
                RELINT
                CA              77DECML
                TS              ZERONDX
                CA              ALXXXZ
                TC              ZEROING
                TC              INTPRET
                SLOAD
                                SCHZEROS
                STOVL           GCOMPSW         -1
                                INTVAL          +2
                STOVL           ALX1S
                                SCHZEROS
                STORE           DELVX
                STORE           GCOMP
                SLOAD
                                TORQNDX
                DCOMP           BMN
                                VERTSKIP
                CALL
                                ERTHRVSE
VERTSKIP        EXIT
                TC              SLEEPIE         +1

## Page 389
ALLOOP          CA              OVFLOWCK
                EXTEND
                BZF             +2
                TC              TASKOVER
                CCS             ALTIM
                CA              A                       # SHOULD NEVER HIT THIS LOCATION
                TS              ALTIMS
                CS              A
                TS              ALTIM
                CS              ONE
                AD              GEOCOMPS
                EXTEND
                BZF             +4
                CA              LENGTHOT
                EXTEND
                BZMF            +5
                CAE             1SECXT
                TC              TWIDDLE
                EBANK=          XSM
                ADRES           ALLOOP
                CAF             ZERO
                XCH             PIPAX
                TS              DELVX
                CAF             ZERO
                XCH             PIPAY
                TS              DELVY
                CAF             ZERO
                XCH             PIPAZ
                TS              DELVZ
SPECSTS         CAF             PRIO20
                TC              FINDVAC
                EBANK=          XSM
                2CADR           ALFLT                   # START THE JOB
                
                TC              TASKOVER

## Page 390
ALFLT           CCS             GEOCOMPS
                TC              +2
                TC              NORMLOP
                TC              BANKCALL
                CADR            1/PIPA
NORMLOP         TC              INTPRET
                DLOAD
                                INTVAL
                STOVL           S1
                                DELVX
                VXM             VSL1
                                XSM
                DLOAD           DCOMP
                                MPAC +3
                STODL           DPIPAY
                                MPAC +5
                STORE           DPIPAZ

                SETPD           AXT,1
                                0
                                8D
                SLOAD           DCOMP
                                GEOCOMPS
                BMN
                                PERFERAS
ALCGKK          SLOAD           BMN
                                ALTIMS
                                ALFLT3
ALKCG           AXT,2           LXA,1                   # LOADS SLOPES AND TIME CONSTANTS AT RQST
                                12D
                                ALX1S
ALKCG2          DLOAD*          INCR,1
                                ALFDK           +144D,1
                DEC             -2
                STORE           ALDK            +10D,2
                TIX,2           SXA,1
                                ALKCG2
                                ALX1S

ALFLT3          AXT,1
                                8D
DELMLP          DLOAD*          DMP
                                DPIPAY          +8D,1
                                PIPASC
                SLR             BDSU*
                                9D
                                INTY            +8D,1
                STORE           INTY            +8D,1
                PDDL            DMP*
                                VELSC

## Page 391
                                VLAUN           +8D,1
                SL2R
                DSU             STADR
                STORE           DELM            +8D,1
                STORE           DELM            +10D,1
                TIX,1           AXT,2
                                DELMLP
                                4
ALILP           DLOAD*          DMPR*
                                ALK             +4,2
                                ALDK            +4,2
                STORE           ALK             +4,2
                TIX,2           AXT,2
                                ALILP
                                8D
ALKLP           LXC,1           SXA,1
                                CMPX1
                                CMPX1
                DLOAD*          DMPR*
                                ALK             +1,1
                                DELM            +8D,2
                DAD*
                                INTY            +8D,2
                STORE           INTY            +8D,2
                DLOAD*          DAD*
                                ALK             +12D,2
                                ALDK            +12D,2
                STORE           ALK             +12D,2
                DMPR*           DAD*
                                DELM            +8D,2
                                INTY            +16D,2
                STORE           INTY            +16D,2
                DLOAD*          DMP*
                                ALSK            +1,1
                                DELM            +8D,2
                SL1R            DAD*
                                VLAUN           +8D,2
                STORE           VLAUN           +8D,2
                TIX,2           AXT,1
                                ALKLP
                                8D


LOOSE           DLOAD*          PDDL*
                                ACCWD           +8D,1
                                VLAUN           +8D,1
                PDDL*           VDEF
                                POSNV           +8D,1
                MXV             VSL1
                                TRANSM1
## Page 392
                DLOAD
                                MPAC
                STORE           POSNV           +8D,1
                DLOAD
                                MPAC            +3
                STORE           VLAUN           +8D,1
                DLOAD
                                MPAC            +5
                STORE           ACCWD           +8D,1
                TIX,1
                                LOOSE


                AXT,2           AXT,1                   # EVALUATE SINES AND COSINES
                                6
                                2
BOOP            DLOAD*          DMPR
                                ANGX            +2,1
                                GEORGEJ
                SR2R
                PUSH            SIN
                SL3R            XAD,1
                                X1
                STORE           16D,2
                DLOAD
                COS
                STORE           22D,2                   # COSINES
                TIX,2
                                BOOP

PERFERAS        EXIT
                CA              EBANK7
                TS              EBANK
                EBANK=          ATIGINC
                TC              ATIGINC                 # GOTO ERASABLE TO CALCULATE ONLY TO RETN

#             CAUTION
#
# THE ERASABLE PROGRAM THAT DOES THE CALCULATIONS MUST BE LOADED
# BEFORE ANY ATTEMPT IS MADE TO RUN THE IMU PERFORMANCE TEST

                EBANK=          AZIMUTH
                CCS             LENGTHOT
                TC              SLEEPIE
                CCS             TORQNDX
                TCF             +2
                TC              SETUPER1
                CA              CDUX
                TS              LOSVEC          +1      # FOR TROUBLESHOOTING VD POSNS 2$4

## Page 393
SETUPER1        TC              INTPRET
                DLOAD           PDDL                    # ANGLES FROM DRIFT TEST ONLY
                                ANGZ
                                ANGY
                PDDL            VDEF
                                ANGX
                VCOMP           VXSC
                                GEORGEJ
                MXV             VSR1
                                XSM
                STORE           OGC
                EXIT


                CA              OGCPL
                TC              BANKCALL
                CADR            IMUPULSE
                TC              IMUSLLLG
GEOSTRT4        CCS             TORQNDX                 # ONLY POSITIVE IF IN VERTICAL DRIFT TEST
                TC              VALMIS
                TC              INTPRET
                CALL
                                ERTHRVSE
                EXIT
                TC              TORQUE


SLEEPIE         TS              LENGTHOT                # TEST NOT OVER-DECREMENT LENGTHOT
                CCS             TORQNDX                 # ARE WE DOING VERTDRIFT
                TC              EARTHR*
                TC              ENDOFJOB


SOMEERRR        CA              EBANK5
                TS              EBANK
                CA              ONE
                TS              OVFLOWCK                # STOP ALLOOP FROM CALLING ITSELF
                TC              ALARM
                OCT             1600
                TC              ENDTEST1
SOMERR2         CAF             OCT1601
                TC              VARALARM
                TC              DOWNFLAG
                ADRES           IMUSE
                TC              ENDOFJOB

OCT1601         OCT             01601
DEC585          OCT             06200                   # 3200 B+14   ORDER IS IMPORTANT
SCHZEROS        2DEC            .00000000

## Page 394
                2DEC            .00000000
                OCT             00000
ONEDPP          OCT             00000                   # ORDER IS IMPORTANT
                OCT             00001

INTVAL          OCT             4
                OCT             2
                DEC             144
                DEC             -1
SOUPLY          2DEC            .93505870               # INITIAL GAINS FOR PIP OUTPUTS
                2DEC            .26266423               # INITIAL GAINS/4 FOR ERECTION ANGLES

77DECML         DEC             77
ALXXXZ          GENADR          ALX1S -1
PIPASC          2DEC            .13055869
VELSC           2DEC            -.52223476              # 512/980.402
ALSK            2DEC            .17329931               # SSWAY VEL GAIN X 980.402/4096
                2DEC            -.00835370              # SSWAY ACCEL GAIN X 980.402/4096


GEORGEJ         2DEC            .63661977
GEORGEK         2DEC            .59737013
