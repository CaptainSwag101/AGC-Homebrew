        SETLOC 4000
        BANK
BEGIN   CA      ZERO
        XCH     L

TEST1	CA	MPE1
	TS	MPELOC1
	CA	MPA1
	EXTEND
	MP	MPELOC1

TEST2	CA	MPE2
	TS	MPELOC2
	CA	MPA2
	EXTEND
	MP	MPELOC2

TEST3	CA	MPE3
	TS	MPELOC3
	CA	MPA3
	EXTEND
	MP	MPELOC3

TEST4	CA	MPE4
	TS	MPELOC4
	CA	MPA4
	EXTEND
	MP	MPELOC4

	TCF	BEGIN

# CONSTANTS AND SUCH
A       EQUALS  0
L       EQUALS  1
Q       EQUALS  2
EB      EQUALS  3
FB      EQUALS  4
Z       EQUALS  5
BB      EQUALS  6
ZERO    EQUALS  7
MPA1	OCT	016344
MPE1	OCT	010101
MPELOC1	EQUALS	000100
MPA2	OCT	016344
MPE2	OCT	067676
MPELOC2	EQUALS	000101
MPA3	OCT	037777
MPE3	OCT	000002
MPELOC3	EQUALS	000102
MPA4	OCT	000000
MPE4	OCT	037777
MPELOC4	EQUALS	000103
