# Copyright:	Public domain.
# Filename:	Makefile
# Purpose:	Makefile for Retread 50.
# Contact:	Ron Burkey <info@sandroid.org>.
# Website:	www.ibiblio.org/apollo/index.html
# Mod history:	2019-06-12 MAS  Created.
#		2019-06-17 RSB	Tweaked.
#		2022-10-10 JAP	Repurposed for the "Moonbase" proof-of-concept game I came up with.

BASENAME=MOONBASE

## Retread was built for the BLK2 target
EXTRA_YAYUL_ARGS+=--blk2 --early-sbank --no-checksums --parity --honeywell

# Retread does not have checksums, so disable them.
OCT2BIN_ARGS+=--no-checksums

NO_BINSOURCE=yes

include ../Makefile.inc
