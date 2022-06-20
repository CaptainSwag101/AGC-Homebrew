	SETLOC	4000

	INHINT		# FRESH START VECTOR
	TCF	BEGIN	# START TESTS
	NOOP
	NOOP

# MISC. IGNORED INTERRUPT HANDLERS
# ALWAYS RESUME IMMEDIATELY.

	RESUME		# T6RUPT
	NOOP
	NOOP
	NOOP

	RESUME		# T5RUPT
	NOOP
	NOOP
	NOOP

	RESUME		# T3RUPT
	NOOP
	NOOP
	NOOP

	RESUME		# T4RUPT
	NOOP
	NOOP
	NOOP

	RESUME		# KEYRUPT1
	NOOP
	NOOP
	NOOP

	RESUME		# KEYRUPT2
	NOOP
	NOOP
	NOOP

	RESUME		# UPRUPT
	NOOP
	NOOP
	NOOP

	RESUME		# DOWN
	NOOP
	NOOP
	NOOP

	RESUME		# RADAR RUPT
	NOOP
	NOOP
	NOOP

	RESUME		# HAND CONTROL RUPT
	NOOP
	NOOP
	NOOP

# BEGIN ACTUAL CODE HERE.


BEGIN   CA	ZERO
	XCH	L

# TESTS DV WITH TWO POSITIVES, AND RSC CONTROL PULSE
TEST1	CA	DVE1
	TS	DVEMEM1	# 021212 IN E
	CA	DVL1
	XCH	L	# 033400 IN L
	CA	DVA1	# 012345 IN A
	EXTEND
	DV	DVEMEM1
	NOOP

TEST2	CA	DVE2
	TS	DVEMEM2 # 156565 IN E
	CA	DVL2
	XCH	L	# 033400 IN L
	CA	DVA2	# 012345 IN A
	EXTEND
	DV	DVEMEM2
	NOOP

TEST3	CA	DVE3
	TS	DVEMEM3 # 156565 IN E
	CA	DVL3
	XCH	L	# 033400 IN L
	CA	DVA3	# 012345 IN A
	EXTEND
	DV	DVEMEM3
	NOOP

TEST4	CA	DVE4
	TS	DVEMEM4
	CA	DVL4
	XCH	L
	CA	DVA4
	EXTEND
	DV	DVEMEM4
	NOOP

TEST5	CA	DVE5
	TS	DVEMEM5
	CA	DVL5
	XCH	L
	CA	DVA5
	EXTEND
	DV	DVEMEM5
	NOOP

TEST6	CA	DVE6
	TS	DVEMEM6
	CA	DVL6
	XCH	L
	CA	DVA6
	EXTEND
	DV	DVEMEM6
	NOOP

TEST7	CA	DVE7
	TS	DVEMEM7
	CA	DVL7
	XCH	L
	CA	DVA7
	EXTEND
	DV	DVEMEM7
	NOOP

TEST8	CA	DVE8
	TS	DVEMEM8
	CA	DVL8
	XCH	L
	CA	DVA8
	EXTEND
	DV	DVEMEM8
	NOOP

TEST9A	CA	DVE9A
	TS	DVEMEM9A
	CA	DVL9A
	XCH	L
	CA	DVA9A
	EXTEND
	DV	DVEMEM9A
	NOOP

TEST9B	CA	DVE9B
	TS	DVEMEM9B
	CA	DVL9B
	XCH	L
	CA	DVA9B
	EXTEND
	DV	DVEMEM9B
	NOOP

TEST10A	CA	DVE10A
	TS	DVEME10A
	CA	DVL10A
	XCH	L
	CA	DVA10A
	EXTEND
	DV	DVEME10A
	NOOP

TEST10B	CA	DVE10B
	TS	DVEME10B
	CA	DVL10B
	XCH	L
	CA	DVA10B
	EXTEND
	DV	DVEME10B
	NOOP

TEST11A	CA	DVE11A
	TS	DVEME11A
	CA	DVL11A
	XCH	L
	CA	DVA11A
	EXTEND
	DV	DVEME11A
	NOOP

TEST11B	CA	DVE11B
	TS	DVEME11B
	CA	DVL11B
	XCH	L
	CA	DVA11B
	EXTEND
	DV	DVEME11B
	NOOP

TEST12A	CA	DVE12A
	TS	DVEME12A
	CA	DVL12A
	XCH	L
	CA	DVA12A
	EXTEND
	DV	DVEME12A
	NOOP

TEST12B	CA	DVE12B
	TS	DVEME12B
	CA	DVL12B
	XCH	L
	CA	DVA12B
	EXTEND
	DV	DVEME12B
	NOOP

	TCF	BEGIN

# CONSTANTS AND SUCH
A	EQUALS	0
L	EQUALS	1
Q	EQUALS	2
EB	EQUALS	3
FB	EQUALS	4
Z	EQUALS	5
BB	EQUALS	6
ZERO	EQUALS	7

DVA1	OCT	012345
DVL1	OCT	033400
DVE1	OCT	021212
DVEMEM1	EQUALS	000100

DVA2    OCT     012345
DVL2    OCT     033400
DVE2    OCT     156565
DVEMEM2 EQUALS  000101

DVA3	OCT	012346
DVL3	OCT	173377
DVE3	OCT	021212
DVEMEM3	EQUALS	000102

DVA4	OCT	012346
DVL4	OCT	173377
DVE4	OCT	156565
DVEMEM4	EQUALS	000103

DVA5	OCT	165432
DVL5	OCT	144377
DVE5	OCT	156565
DVEMEM5	EQUALS	000104

DVA6	OCT	165432
DVL6	OCT	144377
DVE6	OCT	021212
DVEMEM6	EQUALS	000105

DVA7	OCT	165431
DVL7	OCT	004400
DVE7	OCT	156565
DVEMEM7	EQUALS	000106

DVA8	OCT	165431
DVL8	OCT	004400
DVE8	OCT	026212
DVEMEM8 EQUALS	000107

DVA9A	OCT	000000
DVL9A	OCT	005162
DVE9A	OCT	021212
DVEMEM9A EQUALS	000110

DVA9B	OCT	177777
DVL9B	OCT	005162
DVE9B	OCT	021212
DVEMEM9B EQUALS	000110

DVA10A	OCT	000000
DVL10A	OCT	005162
DVE10A	OCT	156565
DVEME10A EQUALS	000111

DVA10B	OCT	177777
DVL10B	OCT	005162
DVE10B	OCT	156565
DVEME10B EQUALS	000111

DVA11A	OCT	000000
DVL11A	OCT	172615
DVE11A	OCT	156565
DVEME11A EQUALS	000112

DVA11B	OCT	177777
DVL11B	OCT	172615
DVE11B	OCT	156565
DVEME11B EQUALS	000112

DVA12A	OCT	000000
DVL12A	OCT	172615
DVE12A	OCT	021212
DVEME12A EQUALS	000113

DVA12B	OCT	177777
DVL12B	OCT	172615
DVE12B	OCT	021212
DVEME12B EQUALS	000113