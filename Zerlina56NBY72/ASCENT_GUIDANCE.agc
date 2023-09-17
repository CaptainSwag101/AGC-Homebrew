### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    ASCENT_GUIDANCE.agc
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
## Reference:   pp. 834-849
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2017-07-28 MAS  Created from Luminary 210.
##              2017-08-20 MAS  Updated for Zerlina 56.

## Page 834
                BANK    34
                SETLOC  ASCFILT
                BANK

                EBANK=  DVCNTR

                COUNT*  $$/ASENT

ATMAG           TC      PHASCHNG
                OCT     06025
                EBANK=  DVCNTR
                2CADR   PIPCYCLE


                TC      INTPRET
                BON
                        FLRCS
                        ASCENT
                SLOAD   DMP
                        ABDVACC
                        KPIP
                STORE   6D
                DSU
                        MINABDV
                BMN     CLEAR
                        ASCTERM4
                        SURFFLAG
                CLEAR   SLOAD
                        RENDWFLG
                        BIT3H
                DDV     EXIT
                        6D
                DXCH    MPAC
                DXCH    1/DV3
                DXCH    1/DV2
                DXCH    1/DV1
                DXCH    1/DV0
                TC      INTPRET
                DLOAD   DAD
                        1/DV0
                        1/DV1
                DAD     DAD
                        1/DV2
                        1/DV3
                DMP     DMP
                        VE
                        2SEC(9)
                SL3     PDDL
                        TBUP
                SR1     DAD
## Page 835
                DSU
                        6SEC(18)
                STODL   TBUP
                        VE
                SR1     DDV
                        TBUP
                STCALL  AT
                        ASCENT

BIT3H           OCT     4

## Page 836
                BANK    30
                SETLOC  ASENT
                BANK
                COUNT*  $$/ASENT


ASCENT          VLOAD   ABVAL
                        R
                STOVL   /R/MAG
                        UNIT/R/
                VXV     UNIT
                        QAXIS
                STORE   ZAXIS1
                DOT     SL1
                        V               # Z.V = ZDOT*2(-8).
                STOVL   ZDOT            # ZDOT*2(-7)
                        ZAXIS1
                VXV     VSL1
                        UNIT/R/         # Z X UR = LAXIS*2(-2)
                STORE   LAXIS           # LAXIS*2(-1)
                DOT     SL1
                        V               # L.V = YDOT*2(-8).
                STCALL  YDOT            # YDOT * 2(-7)
                        YCOMP
                VLOAD
                        G1
                DOT     SL4
                        UNIT/R/         # G.UR*2(9) = GR*2(9).
                PDVL    VXV             # STORE IN PDL(0)                     (2)
                        UNIT/R/         # LOAD UNIT/R/*2(-1).
                        V               # UR*2(-1) X V*2(-7) = H/R*2(-8).
                VSQ     DDV             # H(2)/R(2)*2(-16).
                        /R/MAG          # H(2)/R(3)*2(9).
                SL1     DAD
                STADR
                STORE   GEFF            # GEFF*2(10)M/CS/CS
                BOFF    CALL            # IF P7071FLG = 1 (I.E. P70 OR P71)
                        P7071FLG        #     CALL ZDOTDCMP TO UPDATE ZDOTD
                        +2              #     ON THE BASIS OF THE LAST RP.
                        ZDOTDCMP
   +2           DLOAD   DSU
                        ZDOTD
                        ZDOT
                STORE   DZDOT           # DZDOT = (ZDOTD - ZDOT)*2(7)M/CS.
                VXSC    PDDL
                        ZAXIS1
                        YDOTD
## Page 837
                DSU
                        YDOT
                STORE   DYDOT           # DYDOT = (YDOTD - YDOT)*2(7)M/CS.
                VXSC    PDDL
                        LAXIS
                        RDOTD
                DSU
                        RDOT
                STORE   DRDOT           # DRDOT = (RDOTD - RDOT)*2(7)M/CS.
                VXSC    VAD
                        UNIT/R/
                VAD     VSL1
                STADR
                STORE   VGVECT          # VG = (DRDOT)R + (DYDOT)L + (DZDOT)Z.
                DLOAD   DMP             # LOAD TGO
                        TGO             # TGO GEFF
                        GEFF
                VXSC    VSL1
                        UNIT/R/         # TGO GEFF UR
                BVSU
                        VGVECT          # COMPENSATED FOR GEFF
                STORE   VGVECT          # STORE FOR DOWNLINK
                MXV     VSL1            # GET VGBODY FOR N85 DISPLAY
                        XNBPIP
                STOVL   VGBODY
                        VGVECT
                ABVAL   BOFF            # MAGNITUDE OF VGVECT
                        FLRCS           # IF FLRCS=0,DO NORMAL GUIDANCE
                        MAINENG
                DDV                     # USE TGO=VG/AT  WITH RCS
                        AT/RCS
                STCALL  TGO             # THIS WILL BE USED ON NEXT CYCLE
                        RPCOMP1         # COMPUTE NEW RP FOR NEXT CYCLE.
                RTB 
                        ASCTERM3
MAINENG         DDV     PUSH            # VG/VE IN PDL(0)                    (2)
                        VE
                SR1     BDSU            # 1 - VG / 2 VE
                        NEARONE
                DMP     DMP             # TBUP VG(1-KT VG/VE)/VE             (0)
                        TBUP            #  = TGO
                DSU                     # COMPENSATE FOR TAILOFF
                        TTO
                STORE   TGO
                SR      DCOMP
                        11D
                STODL   TTOGO           # TGO*2(-28)CS
                        TGO
                BON     DSU
                        IDLEFLAG
## Page 838
                        T2TEST
                        4SEC(17)        # ( TGO - 4 )*2(-17)CS.
                BMN
                        ENGOFF
T2TEST          DLOAD
                        TGO
                DSU     BMN             # IF TGO - T2 NEG., GO TO CMPONENT
                        T2A
                        CMPONENT
                DLOAD   DSU
                        TBUP
                        TGO
                DDV     CALL            # 1-TGO/TBUP
                        TBUP
                        LOGSUB
                SL      PUSH            # -L IN PDL(0)                        (2)
                        5
                BDDV    BDSU            # -TGO/L*2(-17)
                        TGO
                        TBUP            # TBUP + TGO/L = D12*2(-17)
                PUSH    BON             # STORE IN PDL(2)                      (4)
                        FLPC            # IF FLPC = 1, GO TO CONST
                        NORATES
                DLOAD   DSU
                        TGO
                        T3
                BPL     SET             # FLPC=1
                        RATES
                        FLPC
NORATES         DLOAD
                        HI6ZEROS
                STORE   PRATE           # B = 0
                STCALL  YRATE           # D = 0
                        CONST           # GO TO CONST
RATES           DLOAD   DSU
                        TGO
                        02D             # TGO - D12 = D21*2(-17)
                PUSH    SL1             # IN PDL(4)                            (6)
                BDSU    SL3             # (1/2TGO - D21)*2(-13) = E * 2(-13)
                        TGO             #                                      (8)
                PDDL    DMP             # IN PDL(6)
                        TGO
                        RDOT            # RDOT TGO * 2(-24)
                DAD     DSU             # R + RDOT TGO
                        /R/MAG          # R + RDOT TGO - RCO
                        RCO             # MPAC = - DR*2(-24).
                PDDL    DMP             # -DR IN PDL(8)                       (10)
                        DRDOT
                        04D             # D21 DRDOT*2(-24)
                DAD     SL2             # (D21 DRDOT-DR)*2(-22)                (8)
## Page 839
                DDV     DDV
                        06D             # (D21 DRDOT-DR)/E*2(-9)
                        TGO
                STORE   PRATE           # B * 2(8)
                BMN     DLOAD           # B>0 NOT PERMITTED
                        CHKBMAG
                        HI6ZEROS
                STCALL  PRATE
                        PROK
CHKBMAG         SR4     DDV             # B*2(4)
                        TBUP            # (B / TAU) * 2(21)
                DSU     BPL
                        PRLIMIT         # ( B/ TAU) * 2(21) MAX.
                        PROK
                DLOAD   DMP
                        PRLIMIT
                        TBUP            # B MAX. * 2(4)
                SL4                     # BMAX*2(8)
                STORE   PRATE
PROK            DLOAD
                        TGO
                DMP     DAD             # YDOT TGO
                        YDOT
                        Y               # Y + YDOT TGO
                DSU     PDDL            # Y + YDOT TGO - YCO
                        YCO             # MPAC = - DY*2(-24.) IN PDL(8)       (10)
                        DYDOT
                DMP     DAD             # D21 DYDOT - DY                      (8)
                        04D
                SL2     DDV             # (D21 DYDOT - DY)/E*2(-9)
                DDV     SETPD           # (D21 DYDOT - DY)/E TGO*2(8)
                        TGO             #   = D*2(8)
                        04
                STORE   YRATE
CONST           DLOAD   DMP             # LOAD B*2(8)
                        PRATE           # B D12*2(-9)
                        02D
                PDDL    DDV             # D12 B IN PDL(4)                     (6)
                        DRDOT           # LOAD DRDOT*2(-7)
                        00D             # -DRDOT/L*2(-7)
                SR2     DSU             # (-DRDOT/L-D12 B)=A*2(-9)             (4)
                STADR
                STODL   PCONS
                        YRATE           # D*2(8)
                DMP     PDDL            # D12 D,EXCH WITH -L IN PDL(0)       (2,2)
                BDDV    SR2             # -DYDOT/L*2(-9)
                        DYDOT
                DSU                     # (-DYDOT/L-D12 D)=C*2(-9)
                        00D
                STORE   YCONS
## Page 840
CMPONENT        SETPD   BOFF
                        00D
                        P7071FLG
                        +3              # IF P7071FLG = 1 (I.E. P70 OR P71)
                CALL                    #     COMPUTE NEW RP FOR NEXT CYCLE.
                        RPCOMP2
 +3             DLOAD   DMP
                        100CS
                        PRATE           # B(T-T0)*2(-9)
                DAD     DDV             # (A+B(T-T0))*2(-9)
                        PCONS           # (A+B(T-T0))/TBUP*2(8)
                        TBUP
                SL1     DSU
                        GEFF            # ATR*2(9)
                STODL   ATR
                        100CS
                DMP     DAD
                        YRATE
                        YCONS           # (C+D(T-T0))*2(-9)
                DDV     SL1
                        TBUP
                STORE   ATY             # ATY*2(9)
                VXSC    PDDL            # ATY UY*2(8)                         (6)
                        LAXIS
                        ATR
                VXSC    VAD             #                                     (0)
                        UNIT/R/
                VSL1    PUSH            # AH*2(9) IN PDL(0)                   (6)
                ABVAL   PDDL            # AH(2) IN PDL(34)
                        AT              # AHMAG IN PDL(6)                     (8)
                DSQ     DSU             # (AT(2)-AH(2))*2(18)
                        34D             # =ATP2*2(18)
                PDDL    PUSH            #                                     (12)
                        AT
                DSQ     DSU             # (AT(2)KR(2)-AH(2))*2(18)            (10)
                        34D             # =ATP3*2(18)
                BMN     DLOAD           # IF ATP3 NEG,GO TO NO-ATP
                        NO-ATP          # LOAD ATP2,IF ATP3 POS
                        8D
                SQRT    GOTO            # ATP*2(9)
                        AIMER
NO-ATP          DLOAD   BDDV            # KR AT/AH = KH                       (8)
                        6D
                VXSC                    # KH AH*2(9)
                        00D
                STODL   00D             # STORE NEW AH IN PDL(0)
                        HI6ZEROS
AIMER           SIGN
                        DZDOT
                STORE   ATP
## Page 841
                VXSC
                        ZAXIS1          # ATP ZAXIS *2(8).
                VSL1    VAD             # AT*2(9)
                        00D
                STORE   UNFC/2          # WILL BE OVERWRITTEN IF IN VERT. RISE.
                SETPD   BON
                        00D
                        FLPI
                        P12RET
                BON
                        FLVR
                        CHECKALT
MAINLINE        VLOAD   VCOMP
                        UNIT/R/
                STODL   UNWC/2
                        TXO
                DSU     BPL
                        PIPTIME
                        ASCTERM
                BON
                        ROTFLAG
                        ANG1CHEK
CLRXFLAG        CLEAR   
                        XOVINFLG        #   (XOVINFLG)
ASCTERM         EXIT
                CA      FLAGWRD9
                MASK    FLRCSBIT
                CCS     A
                TCF     ASCTERM3
                TC      INTPRET
                CALL
                        FINDCDUW -2
ASCTERM1        EXIT
   +1           CA      FLAGWRD9        # INSURE THAT THE NOUN 63 DISPLAY IS
                MASK    FLRCSBIT        # BYPASSED IF WE ARE IN THE RCS TRIMMING
                CCS     A               # MODE OF OPERATION
                TCF     ASCTERM3
                CA      FLAGWRD8        # BYPASS DISPLAYS IF ENGINE FAILURE IS
                MASK    FLUNDBIT        # INDICATED.
                CCS     A
                TCF     ASCTERM3
                CAF     PRIO23          # RAISE PRIORITY SO MAKEPLAY WILL BE SET
                TC      PRIOCHNG        #   UP AT A HIGHER PRIORITY THAN SERVICER
                CAF     V06N94
                TC      BANKCALL
                CADR    REGODSPR
                CAF     PRIO20          # RETURN TO NORMAL SERVICER PRIORITY
                TC      PRIOCHNG
ASCTERM3        TC      POSTJUMP
                CADR    PIPCYCLE
## Page 842
ASCTERM4        EXIT
                INHINT
                TC      IBNKCALL        # NO GUIDANCE THIS CYCLE -- HENCE ZERO
                CADR    STOPRATE        # THE DAP COMMANDED RATES.
                TCF     ASCTERM1 +1

CHECKALT        DLOAD   DSU
                        /R/MAG
                        /LAND/
                DSU     BMN             # IF H LT 25K CHECK Z AXIS ORIENTATION.
                        25KFT
                        CHECKYAW
EXITVR          CLEAR   BON
                        FLVR
                        ROTFLAG
                        MAINLINE
                DLOAD   DAD
                        PIPTIME
                        10SECS
                STCALL  TXO
                        MAINLINE
EXITVR1         CLRGO
                        ROTFLAG
                        EXITVR

                SETLOC  ASENT1
                BANK
                COUNT*  $$/ASENT

ANG1CHEK        VLOAD   UNIT
                        UNFC/2
                DOT
                        XNBPIP
                DSU     BPL
                        COSTHET1
                        OFFROT
                VLOAD   DOT
                        XNBPIP
                        UNIT/R/
                DSU     BMN
                        COSTHET2
                        KEEPVR1
OFFROT          CLRGO
                        ROTFLAG
                        CLRXFLAG

                BANK    7
                SETLOC  ASENT1
                BANK
                COUNT*  $$/ASENT

## Page 843
SETXFLAG        =       CHECKYAW

CHECKYAW        SET
                        XOVINFLG        # PROHIBIT X-AXIS OVERRIDE
                DLOAD   VXSC
                        ATY
                        LAXIS
                PDDL    VXSC
                        ATP
                        ZAXIS1
                VAD     UNIT
                PDDL    DSU
                        RDOT
                        40FPS
                BPL     GOTO
                        EXITVR1
                        KEEPVR

40FPS           2DEC    0.12192 B-7

                BANK    34
                SETLOC  ASENT8
                BANK
                COUNT*  $$/ASENT

KEEPVR          VLOAD   STADR           # RECALL LOSVEC FROM PUSHLIST
                STORE   UNWC/2
KEEPVR1         VLOAD
                        UNIT/R/
                STCALL  UNFC/2
                        ASCTERM


                BANK    14
                SETLOC  ASENT4
                BANK
                COUNT*  $$/ASENT

ENGOFF          RTB
                        LOADTIME
                DSU     DAD
                        PIPTIME
                        TTOGO
                DCOMP   EXIT
                TC      TPAGREE         # FORCE SIGN AGREEMENT ON MPAC, MPAC +1.
                CAF     EBANK7
                TS      EBANK
                EBANK=  TGO
                INHINT
                CCS     MPAC +1
## Page 844
                TCF     +3              # C(A) = DT - 1 BIT
                TCF     +2              # C(A) = 0
                CAF     ZERO            # C(A) = 0
                AD      BIT1            # C(A) = 1 BIT OR DT.
                TS      ENGOFFDT
                TC      TWIDDLE
                ADRES   ENGOFF1
                TC      PHASCHNG
                OCT     47014
                -GENADR ENGOFFDT
                EBANK=  TGO
                2CADR   ENGOFF1

                TC      INTPRET
                SET     GOTO
                        IDLEFLAG        # DISABLE DELTA-V MONITOR
                        T2TEST

ENGOFF1         TC      IBNKCALL        # SHUT OFF THE ENGINE.
                CADR    ENGINOF2

                CAF     PRIO17          # SET UP A JOB FOR THE ASCENT GUIDANCE
                TC      NOVAC
                EBANK=  WHICH
                2CADR   CUTOFF

                TC      PHASCHNG
                OCT     07024
                OCT     17000
                EBANK=  TGO
                2CADR   CUTOFF

                TCF     TASKOVER

CUTOFF          TC      UPFLAG          # SET FLRCS FLAG.
                ADRES   FLRCS

   -5           CAF     V16N63
                TC      BANKCALL
                CADR    GOFLASH
                TCF     +3
                TCF     CUTOFF1
                TCF     -5

   +3           TC      POSTJUMP
                CADR    TERMASC

CUTOFF1         INHINT
                TC      IBNKCALL        # ZERO ATTITUDE ERRORS BEFORE REDUCING DB.
                CADR    ZATTEROR
## Page 845
                TC      IBNKCALL
                CADR    SETMINDB
                TC      POSTJUMP
                CADR    CUTOFF2

V16N63          VN      1663
                BANK    34
                SETLOC  ASENT8
                BANK
                COUNT*  $$/ASENT

CUTOFF2         TC      PHASCHNG
                OCT     04024

                CAF     V16N85C
                TC      BANKCALL
                CADR    GOFLASH
                TCF     TERMASC
                TCF     +2              # PROCEED
                TCF     CUTOFF2

TERMASC         TC      PHASCHNG
                OCT     04024

                INHINT                  # RESTORE DEADBAND DESIRED BY ASTRONAUT.
                TC      IBNKCALL
                CADR    RESTORDB
                TC      DOWNFLAG        # DISALLOW ABORTS AT THIS TIME.
                ADRES   LETABORT
                TCF     GOTOPOOH

V16N85C         VN      1685

RPCOMP1         DLOAD                   # FLRCS = 1 (TRIM MODE)
                        HI6ZEROS
                STORE   PCONS           # SET PCONS = PRATE = 0 SO THAT
                STORE   PRATE           #     RP = R + RDOT TGO
RPCOMP2         DLOAD   DMP             # FLRCS = 0 (GUIDANCE MODE)
                        PRATE           # LEAVE PCONS AND PRATE ALONE SO THAT
                        TGO             #     RP = R + RDOT TGO + (PCONS*TGO**2)/
                DMP     DAD             #     (2 TBUP) + (PRATE*TGO**3)/(6 TBUP)
                        THIRD
                        PCONS
                DMP     DMP
                        TGO
                        TGO
                DDV     SL1
                        TBUP
                DAD     PDDL
                        /R/MAG
## Page 846
                        RDOT
                DMP     DAD
                        TGO
                STADR
                STORE   RP
                RVQ

ZDOTDCMP        STQ     CALL            # COMPUTE CENTRAL ANGLE                (0)
                        ASCSAVE
                        THETCOMP
                DMP     DAD             # CENTRAL ANGLE IN MPAC
                        KPARM
                        JPARM
                DSU     PUSH            # RA IN MPAC AND IN PUSHLIST          (2)
                        RP
                DSU     BPL
                        RAMIN
                        +3
                DLOAD   PDDL            # RA < RAMIN.  SET RA = RAMIN.        (2)
                        RAMIN
 +3             DLOAD   DMP
                        0D
                        MUM(-37)
                PDDL
                DAD     DMP
                        RP
                        RP
                BDDV    SQRT            #                                     (0)
                STADR
                STCALL  ZDOTD           # UPDATE ZDOTD FOR GUIDANCE AND DOWNLINK.
                        ASCSAVE

THETCOMP        VLOAD   UNIT
                        R
                PDVL    UNIT            #                                     (6)
                        R(CSM)
                PUSH    VXV             #                                     (12)
                        0D
                DOT
                        WM
                STOVL   30D             #                                     (6)
                DOT     SL1             #                                     (0)
                ARCCOS  SIGN
                        30D
                RVQ

                BANK    27
                SETLOC  ASENT1
                BANK
                COUNT*  $$/ASENT

## Page 847
YCOMP           VLOAD   DOT
                        UNIT/R/
                        QAXIS
                SL2     DMP
                        RCO
                STORE   Y
                RVQ


                BANK    30
                SETLOC  ASENT
                BANK

## Page 848
# ASCENT GUIDANCE CONSTANTS

100CS           EQUALS  2SEC(18)
T2A             EQUALS  2SEC(17)
4SEC(17)        2DEC    400 B-17

2SEC(17)        2DEC    200 B-17

T3              2DEC    1000 B-17

6SEC(18)        2DEC    600 B-18

2SEC(9)         2DEC    200 B-9

V06N94          VN      0694
V06N76          VN      0676
V06N33A         VN      0633

                BANK    33
                SETLOC  ASENT6
                BANK
                COUNT*  $$/ASENT

PRLIMIT         2DEC    -.0639          # (B/TBUP)MIN=-.1FT.SEC(-3)

MINABDV         2DEC    .0356 B-5       # 10 PERCENT BIGGER THAN GRAVITY

25KFT           2DEC    7620 B-24

## Page 849
# THE LOGARITHM SUBROUTINE

                BANK    24
                SETLOC  FLOGSUB
                BANK

# INPUT ..... X IN MPAC
# OUTPUT ..... -LOG(X) IN MPAC

LOGSUB          NORM    BDSU
                        MPAC +6
                        NEARONE
                EXIT
                TC      POLY
                DEC     6
                2DEC    .0000000060
                
                2DEC    -.0312514377
                
                2DEC    -.0155686771
                
                2DEC    -.0112502068
                
                2DEC    -.0018545108
                
                2DEC    -.0286607906
                
                2DEC    .0385598563
                
                2DEC    -.0419361902

                CAF     ZERO
                TS      MPAC +2
                EXTEND
                DCA     CLOG2/32
                DXCH    MPAC
                DXCH    BUF +1
                CA      MPAC +6
                TC      SHORTMP
                DXCH    MPAC +1
                DXCH    MPAC
                DXCH    BUF +1
                DAS     MPAC
                TC      INTPRET
                DCOMP   RVQ

CLOG2/32        2DEC    .0216608494

