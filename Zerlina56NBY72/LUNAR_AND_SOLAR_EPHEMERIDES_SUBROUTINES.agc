### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    LUNAR_AND_SOLAR_EPHEMERIDES_SUBROUTINES.agc
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
## Reference:   pp. 975-978
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2017-07-28 MAS  Created from Luminary 210.
##              2017-08-26 MAS  Updated for Zerlina 56.

## Page 975
# NAME - LSPOS  - LOCATE SUN AND MOON                                                      DATE - 25 OCT 67
# MOD NO.1
# MOD BY NEVILLE                                                                           ASSEMBLY SUNDANCE

# FUNCTIONAL DESCRIPTION

#        COMPUTES UNIT POSITION VECTOR OF THE SUN AND MOON IN THE BASIC REFERENCE SYSTEM. THE SUN VECTOR S IS
# LOCATED VIA TWO ANGLES. THE FIRST ANGLE(OBLIQUITY) IS THE ANGLE BETWEEN THE EARTH EQUATOR AND THE ECLIPTIC. THE
# SECOND ANGLE IS THE LONGITUDE OF THE SUN MEASURED IN THE ECLIPTIC.
# THE POSITION VECTOR OF THE SUN IS
#        -
#        S=(COS(LOS), COS(OBL)*SIN(LOS), SIN(OBL)*SIN(LOS)), WHERE

#      LOS=LOS +LOS *T-(C *SIN(2PI*T)/365.24 +C *COS(2PI*T)/365.24)
#             0    R     0                     1
#      LOS  (RAD) IS THE LONGITUDE OF THE SUN FOR MIDNIGHT JUNE 30TH OF THE PARTICULAR YEAR.
#         0
#      LOS  (RAD/DAY) IS THE MEAN RATE FOR THE PARTICULAR YEAR.
#         R
# LOS  AND LOS  ARE STORED AS LOSC AND LOSR IN RATESP.
#    0        R
# COS(OBL) AND SIN(OBL) ARE STORED IN THE MATRIX KONMAT.
# T, TIME MEASURED IN DAYS(24 HOURS), IS STORED IN TIMEP.
# C  AND C  ARE FUDGE FACTORS TO MINIMIZE THE DEVIATION. THEY ARE STORED AS ONE CONSTANT(CMOD), SINCE
#  0      1                               2  2 1/2
# C *SIN(X)+C *COS(X) CAN BE WRITTEN AS (C +C )   *SIN(X+PHI), WHERE PHI=ARCTAN(C /C ).
#  0         1                            0  1                                   1  0

# THE MOON IS LOCATED VIA FOUR ANGLES. THE FIRST IS THE OBLIQUITY. THE SECOND IS THE MEAN LONGITUDE OF THE MOON,
# MEASURED IN THE ECLIPTIC FROM THE MEAN EQUINOX TO THE MEAN ASCENDING NODE OF THE LUNAR ORBIT, AND THEN ALONG THE
# ORBIT. THE THIRD ANGLE IS THE ANGLE BETWEEN THE ECLIPTIC AND THE LUNAR ORBIT. THE FOURTH ANGLE IS THE LONGITUDE
# OF THE NODE OF THE MOON, MEASURED IN THE LUNAR ORBIT. LET THESE ANGLES BE OBL,LOM,IM, AND LON RESPECTIVELY.

# THE SIMPLIFIED POSITION VECTOR OF THE MOON IS
#   -
#   M=(COS(LOM), COS(OBL)*SIN(LOM)-SIN(OBL)*SIN(IM)*SIN(LOM-LON), SIN(OBL)*SIN(LOM)+COS(OBL)*SIN(IM)*SIN(LOM-LON))

#   WHERE
#      LOM=LOM +LOM *T-(A *SIN 2PI*T/27.5545+A *COS(2PI*T/27.5545)+B *SIN 2PI*T/32+B *COS(2PI*T/32)), AND
#             0    R     0                    1                     0               1
#       LON=LON +LON
#              0    R
# A , A , B  AND B  ARE STORED AS AMOD AND BMOD (SEE DESCRIPTION OF CMOD, ABOVE).  COS(OBL), SIN(OBL)*SIN(IM),
#  0   1   0      1
# SIN(OBL), AND COS(OBL)*SIN(IM) ARE STORED IN KONMAT AS K1, K2, K3 AND K4, RESPECTIVELY. LOM , LOM , LON , LON
# ARE STORED AS LOMO, LOMR, LONO, AND LONR IN RATESP.                                        0     R     0     R
# THE THREE PHIS ARE STORED AS AARG, BARG, AND CARG(SUN).  ALL CONSTANTS ARE UPDATED BY YEAR.

# CALLING SEQUENCE
## Page 976
#   CALL LSPOS.  RETURN IS VIA CPRET.
#
# ALARMS OR ABORTS

#   NONE

# ERASABLE INITIALIZATION REQUIRED

#   TEPHEM - TIME FROM MIDNIGHT 1 JULY PRECEDING THE LAUNCH TO THE TIME OF THE LAUNCH (WHEN THE AGC CLOCK WENT
# TO ZERO). TEPHEM IS TP WITH UNITS OF CENTI-SECONDS.
#   TIME2 AND TIME1 ARE IN MPAC AND MPAC +1 WHEN PROGRAM IS CALLED.

# OUTPUT

#   UNIT POSITIONAL VECTOR OF SUN IN VSUN.   (SCALED B-1)
#   UNIT POSITIONAL VECTOR OF MOON IN VMOON. (SCALED B-1)

# SUBROUTINES USED

#   NONE

# DEBRIS

#   CURRENT CORE SET,WORK AREA AND FREEFLAG
                BANK            04
                SETLOC          EPHEM
                BANK

                EBANK=          VSUN
                COUNT*          $$/EPHEM
LUNPOS          EQUALS          LSPOS

LSPOS           SETPD           SR
                                0
                                14D                     # TP
                TAD             DDV
                                TEPHEM                  # TIME OF LAUNCH
                                CSTODAY                 # 24 HOURS-8640000 CENTI-SECS/DAY B-33
                STORE           TIMEP                   # T IN DAYS
                AXT,1           AXT,2
                                0
                                0
                CLEAR
                                FREEFLAG                # SWITCH BIT
POSITA          DLOAD
                                KONMAT          +2      # ZEROS
                STORE           GTMP
POSITB          DLOAD           DMP*
                                TIMEP                   # T
                                VAL67           +4,1    # 1/27 OR 1/32 OR 1/365
## Page 977
                SL              DAD*
                                8D
                                VAL67           +2,1    # AARG
                SIN             DMP*                    # SIN(T/27+PHI) OR T/32 OR T/365
                                VAL67,1                 # (A0**2+A1**2)**1/2SIN(X+PHIA)
                DAD             INCR,1                  # PLUS
                                GTMP                    # (B0**2+B1**2)**1/2SIN(X+PHIB)
                DEC             -6
                STORE           GTMP                    # OR (C0**2+C1**2)**1/2SIN(X+PHIC)
                BOFSET
                                FREEFLAG
                                POSITB
POSITD          DLOAD           DMP*
                                TIMEP                   # T
                                RATESP,2                # LOMR,LOSR,LONR
                SL              DAD*
                                5D
                                RATESP          +6,2    # LOMO,LOSO,LONO
                DSU
                                GTMP
                STORE           STMP,2                  # LOM,LOS,LON
                SLOAD           INCR,2
                                X2
                DEC             -2
                DAD             BZE
                                RCB-13                  # PLUS 2
                                POSITE                  # 2ND
                BPL
                                POSITA                  # 1ST
POSITF          DLOAD           DSU                     # 3RD
                                STMP                    # LOM
                                STMP            +4      # LON
                SIN             PDDL                    # SIN(LOM-LON)
                                STMP
                SIN             PDDL                    # SIN LOM
                                STMP
                COS             VDEF                    # COS LOM
                MXV             UNIT
                                KONMAT                  # K1,K2,K3,K4,
                STORE           VMOON
                DLOAD           PDDL
                                KONMAT          +2      # ZERO
                                STMP            +2
                SIN             PDDL                    # SIN LOS
                                STMP            +2
                COS             VDEF                    # COS LOS
                MXV             UNIT
                                KONMAT
                STORE           VSUN
                RVQ

## Page 978
POSITE          DLOAD
                                KONMAT          +2      # ZEROS
                STORE           GTMP
                GOTO
                                POSITD
                SETLOC          EPHEM1
                BANK

                COUNT*          $$/EPHEM

STMP            EQUALS          16D

GTMP            EQUALS          22D

TIMEP           EQUALS          24D
