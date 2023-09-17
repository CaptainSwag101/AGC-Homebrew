### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    T6-RUPT_PROGRAMS.agc
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
## Reference:   pp. 1391-1393
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2017-07-28 MAS  Created from Luminary 210.
##              2017-08-29 MAS  Updated for Zerlina 56.

## Page 1391
# PROGRAM NAMES:  (1) T6JOBCHK      MOD. NO. 5    OCTOBER 2, 1967
#                (2) DOT6RUPT

# MODIFICATION BY: LOWELL G HULL (A.C.ELECTRONICS)
# THESE PROGRAMS ENABLE THE LM DAP TO CONTROL THE THRUST TIMES OF THE REACTION CONTROL SYSTEM JETS BY USING TIME6.
# SINCE THE LM DAP MAINTAINS EXCLUSIVE CONTROL OVER TIME6 AND ITS INTERRUPTS, THE FOLLOWING CONVENTIONS HAVE BEEN
# ESTABLISHED AND MUST NOT BE TAMPERED WITH:
#          1. NO NUMBER IS EVER PLACED INTO TIME6 EXCEPT BY LM DAP.
#          2. NO PROGRAM OTHER THAN LM DAP ENABLES THE TIME6 COUNTER.
#          3. TO USE TIME6, THE FOLLOWING SEQUENCE IS ALWAYS EMPLOYED:
#                 A. A POSITIVE (NON-ZERO) NUMBER IS STORED IN TIME6.
#                 B. THE TIME6 CLOCK IS ENABLED.
#                 C. TIME6 IS INTERROGATED AND IS:
#                        I. NEVER FOUND NEGATIVE(NON-ZERO) OR +0.
#                       II. SOMETIMES FOUND POSITIVE(BETWEEN 1 AND 240D) INDICATING THAT IT IS ACTIVE.
#                      III. SOMETIMES FOUND POSMAX INDICATING THAT IT IS INACTIVE AND NOT ENABLED.
#                       IV. SOMETIMES FOUND NEGATIVE ZERO INDICATING THAT:
#                               A. A T6RUPT IS ABOUT TO OCCUR AT THE NEXT DINC, OR
#                               B. A T6RUPT IS WAITING IN THE PRIORITY CHAIN, OR
#                               C. A T6RUPT IS IN PROCESS NOW.
#          4) ALL PROGRAMS WHICH OPERATE IN EITHER INTERRUPT MODE OR WITH INTERRUPT INHIBITED MUST CALL T6JOBCHK
#             EVERY 5 MILLISECONDS TO PROCESS A POSSIBLE WAITING T6RUPT BEFORE IT CAN BE HONORED BY THE HARDWARE.

#         (5. PROGRAM JTLST, IN Q,R-AXES, HANDLES THE INPUT LIST.)
# T6JOBCHK CALLING SEQUENCE:

#                                         L        TC     T6JOBCHK
#                                         L +1    (RETURN)

# DOT6RUPT CALLING SEQUENCE:

#                                                  DXCH   ARUPT           T6RUPT LEAD IN AT LOCATION 4004.
#                                                  EXTEND
#                                                  DCA    T6ADR
#                                                  DTCB

# SUBROUTINES CALLED: DOT6RUPT CALLS T6JOBCHK.

# NORMAL EXIT MODES: T6JOBCHK RETURNS TO L +1.
#                    DOT6RUPT TRANSFERS CONTROL TO RESUME.

# ALARM/ABORT MODES: NONE.

# INPUT: TIME6    NXT6ADR      OUTPUT: TIME6     NXT6ADR     CHANNEL 5
#        T6NEXT   T6NEXT +1            T6NEXT    T6NEXT +1   CHANNEL 6
#        T6FURTHA T6FURTHA +1          T6FURTHA  T6FURTHA +1 BIT15/CH13
# DEBRIS: T6JOBCHK CLOBBERS A.  DOT6RUPT CLOBBERS NOTHING.


                BLOCK   02
## Page 1392
                BANK    17
                SETLOC  DAPS2
                BANK
                EBANK=  T6NEXT
                COUNT*  $$/DAPT6

T6JOBCHK        CCS     TIME6           # CHECK TIME6 FOR WAITING T6RUPT:
                TC      Q               # NONE: CLOCK COUTING DOWN.
                TC      CCSHOLE
                TC      CCSHOLE
# CONTROL PASSES TO T6JOB ONLY WHEN C(TIME6) = -0 (I.E. WHEN A T6RUPT MUST BE PROCESSED).

T6JOB           CA      POSMAX
                ZL
                DXCH    T6FURTHA
                DXCH    T6NEXT
                LXCH    NXT6ADR
                TS      TIME6

                AD      PRIO37
                TS      A
                TCF     ENABLET6
                CA      POSMAX
                TS      TIME6
                TCF     GOCH56
ENABLET6        EXTEND
                QXCH    C13QSAV
                LXCH    RUPTREG1
                TC      C13STALL
                EXTEND
                QXCH    C13QSAV
                LXCH    RUPTREG1
                CAF     BIT15
                EXTEND
                WOR     CHAN13
                CA      T6NEXT
                AD      PRIO37
                TS      A
                TCF     GOCH56
                CA      POSMAX
                TS      T6NEXT
GOCH56          INDEX   L
                TCF     WRITEP -1

                BLOCK   02
                SETLOC  FFTAG9
                BANK
                EBANK=  CDUXD
                COUNT*  $$/DAPT6
## Page 1393
                CA      NEXTP
WRITEP          EXTEND
                WRITE   CHAN6
                TC      Q

                CA      NEXTU
WRITEU          TS      L
                CS      00314OCT
                EXTEND
                RAND    CHAN5
                AD      L
                EXTEND
                WRITE   CHAN5
                TC      Q

                CA      NEXTV
WRITEV          TS      L
                CA      00314OCT
                TCF     -9D
00314OCT        OCT     00314

                BANK    17
                SETLOC  DAPS2
                BANK

                EBANK=  T6NEXT
                COUNT*  $$/DAPT6

DOT6RUPT        LXCH    BANKRUPT        # (INTERRUPT LEAD INS CONTINUED)
                EXTEND
                QXCH    QRUPT

                TC      T6JOBCHK        # CALL T6JOBCHK.

                TCF     RESUME          # END TIME6 INTERRUPT PROCESSOR.
