From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH 1/2] canbusload: Add exact CAN frame length calculation (including bitstuffing)
Date: Thu, 30 Jan 2014 11:05:01 +0100
Message-ID: <1391076302-12053-1-git-send-email-sojkam1@fel.cvut.cz>
References: <id:87ob2tkcts.fsf@steelpick.2x.cz>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:48670 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbaA3KFZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 30 Jan 2014 05:05:25 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id AB95F19F364C
	for <linux-can@vger.kernel.org>; Thu, 30 Jan 2014 11:05:24 +0100 (CET)
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id Gi8XMkQHAe3N for <linux-can@vger.kernel.org>;
	Thu, 30 Jan 2014 11:05:20 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id C70B019F33AA
	for <linux-can@vger.kernel.org>; Thu, 30 Jan 2014 11:05:20 +0100 (CET)
In-Reply-To: <id:87ob2tkcts.fsf@steelpick.2x.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Michal Sojka <sojkam1@fel.cvut.cz>

This adds an algorithm for calculating the exact number of bits a CAN
frame occupies on the bus and uses this algorithm in canbusload. It
also moves the other methods for CAN frame length calculation, already
present in canbusload, to the new file.

The added algorithm calculates the exact number of stuffed bit in a
CAN frame. Note that in order to calculate that correctly, we must
also know the frame's CRC. Hence, the algorithm also includes CRC
calculation routine.

The correctness of the algorithm was verified on an oscilloscope for
several different SFF and EFF frames.

Currently only CAN frames are supported. For CANFD frames, a different
algorithm is needed. CANFD uses different CRC polynomials and
calculates the CRC from the staffed bit-stream (CAN calculates CRC
from de-stuffed bit-stream).

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 Makefile      |   2 +
 canbusload.c  |  41 +++-------
 canframelen.c | 245 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 canframelen.h |  35 +++++++++
 4 files changed, 293 insertions(+), 30 deletions(-)
 create mode 100644 canframelen.c
 create mode 100644 canframelen.h

diff --git a/Makefile b/Makefile
index 2f79ee7..ab99746 100644
--- a/Makefile
+++ b/Makefile
@@ -81,6 +81,7 @@ canbusload.o:	lib.h
 log2long.o:	lib.h
 log2asc.o:	lib.h
 asc2log.o:	lib.h
+canframelen.o:  canframelen.h
 
 cansend:	cansend.o	lib.o
 cangen:		cangen.o	lib.o
@@ -90,3 +91,4 @@ canlogserver:	canlogserver.o	lib.o
 log2long:	log2long.o	lib.o
 log2asc:	log2asc.o	lib.o
 asc2log:	asc2log.o	lib.o
+canbusload:	canbusload.o	canframelen.o
diff --git a/canbusload.c b/canbusload.c
index a3e0750..5943bb1 100644
--- a/canbusload.c
+++ b/canbusload.c
@@ -61,6 +61,7 @@
 #include <linux/can/raw.h>
 
 #include "terminal.h"
+#include "canframelen.h"
 
 #define MAXSOCK 16    /* max. number of CAN interfaces given on the cmdline */
 
@@ -84,7 +85,7 @@ static unsigned char redraw;
 static unsigned char timestamp;
 static unsigned char color;
 static unsigned char bargraph;
-static unsigned char ignore_bitstuffing;
+static enum cfl_mode mode = CFL_WORSTCASE;
 static char *prg;
 
 void print_usage(char *prg)
@@ -95,7 +96,8 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -c (colorize lines)\n");
 	fprintf(stderr, "         -b (show bargraph in %d%% resolution)\n", PERCENTRES);
 	fprintf(stderr, "         -r (redraw the terminal - similar to top)\n");
-	fprintf(stderr, "         -i (ignore bitstuffing estimation in bandwidth calculation)\n");
+	fprintf(stderr, "         -i (ignore bitstuffing in bandwidth calculation)\n");
+	fprintf(stderr, "         -e (exact calculation of stuffed bits)\n");
 	fprintf(stderr, "\n");
 	fprintf(stderr, "Up to %d CAN interfaces with mandatory bitrate can be specified on the \n", MAXSOCK);
 	fprintf(stderr, "commandline in the form: <ifname>@<bitrate>\n\n");
@@ -223,7 +225,7 @@ int main(int argc, char **argv)
 
 	prg = basename(argv[0]);
 
-	while ((opt = getopt(argc, argv, "rtbcih?")) != -1) {
+	while ((opt = getopt(argc, argv, "rtbcieh?")) != -1) {
 		switch (opt) {
 		case 'r':
 			redraw = 1;
@@ -242,7 +244,11 @@ int main(int argc, char **argv)
 			break;
 
 		case 'i':
-			ignore_bitstuffing = 1;
+			mode = CFL_NO_BITSTUFFING;
+			break;
+
+		case 'e':
+			mode = CFL_EXACT;
 			break;
 
 		default:
@@ -372,32 +378,7 @@ int main(int argc, char **argv)
 
 				stat[i].recv_frames++;
 				stat[i].recv_bits_payload += frame.can_dlc*8;
-
-				/*
-				 * Following Ken Tindells *worst* case calculation for stuff-bits
-				 * (see "Guaranteeing Message Latencies on Controller Area Network" 1st ICC'94)
-				 * the needed bits on the wire can be calculated as:
-				 *
-				 * (34 + 8n)/5 + 47 + 8n for SFF frames (11 bit CAN-ID) => (269 + 48n)/5 
-				 * (54 + 8n)/5 + 67 + 8n for EFF frames (29 bit CAN-ID) => (389 + 48n)/5 
-				 *
-				 * while 'n' is the data length code (number of payload bytes)
-				 *
-				 */
-
-				if (ignore_bitstuffing) {
-					/* calculation without bitstuffing */
-					if (frame.can_id & CAN_EFF_FLAG)
-						stat[i].recv_bits_total += 67 + frame.can_dlc*8;
-					else
-						stat[i].recv_bits_total += 47 + frame.can_dlc*8;
-				} else {
-					/* needed bits including estimated worst case stuff bits */
-					if (frame.can_id & CAN_EFF_FLAG)
-						stat[i].recv_bits_total += (389 + frame.can_dlc*48)/5;
-					else
-						stat[i].recv_bits_total += (269 + frame.can_dlc*48)/5;
-				}
+				stat[i].recv_bits_total += can_frame_length(&frame, mode, sizeof(frame));
 			}
 		}
 	}
diff --git a/canframelen.c b/canframelen.c
new file mode 100644
index 0000000..d54cf6e
--- /dev/null
+++ b/canframelen.c
@@ -0,0 +1,245 @@
+/*
+ * canframelen.c
+ *
+ * Copyright (c) 2013, 2014 Czech Technical University in Prague
+ *
+ * Author: Michal Sojka <sojkam1@fel.cvut.cz>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Czech Technical University in Prague nor the
+ *    names of its contributors may be used to endorse or promote
+ *    products derived from this software without specific prior
+ *    written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of the
+ * GPL apply INSTEAD OF those given above.
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible license.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * Send feedback to <linux-can@vger.kernel.org>
+ *
+ */
+
+#include "canframelen.h"
+#include <stdint.h>
+#include <stddef.h>
+#include <stdbool.h>
+#include <string.h>
+#include <assert.h>
+#include <arpa/inet.h>
+
+/**
+ * Functions and types for CRC checks.
+ *
+ * Generated on Wed Jan  8 15:14:20 2014,
+ * by pycrc v0.8.1, http://www.tty1.net/pycrc/
+ * using the configuration:
+ *    Width        = 15
+ *    Poly         = 0x4599
+ *    XorIn        = 0x0000
+ *    ReflectIn    = False
+ *    XorOut       = 0x0000
+ *    ReflectOut   = False
+ *    Algorithm    = table-driven
+ *****************************************************************************/
+
+typedef uint16_t crc_t;
+
+/**
+ * Static table used for the table_driven implementation.
+ *****************************************************************************/
+static const crc_t crc_table[256] = {
+    0x0000, 0x4599, 0x4eab, 0x0b32, 0x58cf, 0x1d56, 0x1664, 0x53fd, 0x7407, 0x319e, 0x3aac, 0x7f35, 0x2cc8, 0x6951, 0x6263, 0x27fa,
+    0x2d97, 0x680e, 0x633c, 0x26a5, 0x7558, 0x30c1, 0x3bf3, 0x7e6a, 0x5990, 0x1c09, 0x173b, 0x52a2, 0x015f, 0x44c6, 0x4ff4, 0x0a6d,
+    0x5b2e, 0x1eb7, 0x1585, 0x501c, 0x03e1, 0x4678, 0x4d4a, 0x08d3, 0x2f29, 0x6ab0, 0x6182, 0x241b, 0x77e6, 0x327f, 0x394d, 0x7cd4,
+    0x76b9, 0x3320, 0x3812, 0x7d8b, 0x2e76, 0x6bef, 0x60dd, 0x2544, 0x02be, 0x4727, 0x4c15, 0x098c, 0x5a71, 0x1fe8, 0x14da, 0x5143,
+    0x73c5, 0x365c, 0x3d6e, 0x78f7, 0x2b0a, 0x6e93, 0x65a1, 0x2038, 0x07c2, 0x425b, 0x4969, 0x0cf0, 0x5f0d, 0x1a94, 0x11a6, 0x543f,
+    0x5e52, 0x1bcb, 0x10f9, 0x5560, 0x069d, 0x4304, 0x4836, 0x0daf, 0x2a55, 0x6fcc, 0x64fe, 0x2167, 0x729a, 0x3703, 0x3c31, 0x79a8,
+    0x28eb, 0x6d72, 0x6640, 0x23d9, 0x7024, 0x35bd, 0x3e8f, 0x7b16, 0x5cec, 0x1975, 0x1247, 0x57de, 0x0423, 0x41ba, 0x4a88, 0x0f11,
+    0x057c, 0x40e5, 0x4bd7, 0x0e4e, 0x5db3, 0x182a, 0x1318, 0x5681, 0x717b, 0x34e2, 0x3fd0, 0x7a49, 0x29b4, 0x6c2d, 0x671f, 0x2286,
+    0x2213, 0x678a, 0x6cb8, 0x2921, 0x7adc, 0x3f45, 0x3477, 0x71ee, 0x5614, 0x138d, 0x18bf, 0x5d26, 0x0edb, 0x4b42, 0x4070, 0x05e9,
+    0x0f84, 0x4a1d, 0x412f, 0x04b6, 0x574b, 0x12d2, 0x19e0, 0x5c79, 0x7b83, 0x3e1a, 0x3528, 0x70b1, 0x234c, 0x66d5, 0x6de7, 0x287e,
+    0x793d, 0x3ca4, 0x3796, 0x720f, 0x21f2, 0x646b, 0x6f59, 0x2ac0, 0x0d3a, 0x48a3, 0x4391, 0x0608, 0x55f5, 0x106c, 0x1b5e, 0x5ec7,
+    0x54aa, 0x1133, 0x1a01, 0x5f98, 0x0c65, 0x49fc, 0x42ce, 0x0757, 0x20ad, 0x6534, 0x6e06, 0x2b9f, 0x7862, 0x3dfb, 0x36c9, 0x7350,
+    0x51d6, 0x144f, 0x1f7d, 0x5ae4, 0x0919, 0x4c80, 0x47b2, 0x022b, 0x25d1, 0x6048, 0x6b7a, 0x2ee3, 0x7d1e, 0x3887, 0x33b5, 0x762c,
+    0x7c41, 0x39d8, 0x32ea, 0x7773, 0x248e, 0x6117, 0x6a25, 0x2fbc, 0x0846, 0x4ddf, 0x46ed, 0x0374, 0x5089, 0x1510, 0x1e22, 0x5bbb,
+    0x0af8, 0x4f61, 0x4453, 0x01ca, 0x5237, 0x17ae, 0x1c9c, 0x5905, 0x7eff, 0x3b66, 0x3054, 0x75cd, 0x2630, 0x63a9, 0x689b, 0x2d02,
+    0x276f, 0x62f6, 0x69c4, 0x2c5d, 0x7fa0, 0x3a39, 0x310b, 0x7492, 0x5368, 0x16f1, 0x1dc3, 0x585a, 0x0ba7, 0x4e3e, 0x450c, 0x0095
+};
+
+/**
+ * Update the crc value with new data.
+ *
+ * \param crc      The current crc value.
+ * \param data     Pointer to a buffer of \a data_len bytes.
+ * \param data_len Number of bytes in the \a data buffer.
+ * \return         The updated crc value.
+ *****************************************************************************/
+static crc_t crc_update_bytewise(crc_t crc, const unsigned char *data, size_t data_len)
+{
+    unsigned int tbl_idx;
+
+    while (data_len--) {
+        tbl_idx = ((crc >> 7) ^ *data) & 0xff;
+        crc = (crc_table[tbl_idx] ^ (crc << 8)) & 0x7fff;
+
+        data++;
+    }
+    return crc & 0x7fff;
+}
+
+/**
+ * Update the crc value with new data.
+ *
+ * \param crc      The current crc value.
+ * \param data     Data value
+ * \param bits	   The number of most significant bits in data used for CRC calculation
+ * \return         The updated crc value.
+ *****************************************************************************/
+static crc_t crc_update_bitwise(crc_t crc, uint8_t data, size_t bits)
+{
+    uint8_t i;
+    bool bit;
+
+    for (i = 0x80; bits--; i >>= 1) {
+            bit = crc & 0x4000;
+            if (data & i) {
+		    bit = !bit;
+            }
+            crc <<= 1;
+            if (bit) {
+		    crc ^= 0x4599;
+            }
+    }
+    return crc & 0x7fff;
+}
+
+static crc_t calc_bitmap_crc(uint8_t *bitmap, unsigned start, unsigned end)
+{
+    crc_t crc = 0;
+
+    if (start%8) {
+	    crc = crc_update_bitwise(crc, bitmap[start/8] << (start%8), 8 - start%8);
+	    start += 8 - start%8;
+    }
+    crc = crc_update_bytewise(crc, &bitmap[start/8], (end - start) / 8);
+    crc = crc_update_bitwise(crc, bitmap[end/8], end%8);
+    return crc;
+}
+
+static unsigned cfl_exact(struct can_frame *frame)
+{
+	uint8_t bitmap[16];
+	unsigned start = 0, end;
+
+	/* Prepare bitmap */
+	memset(bitmap, 0, sizeof(bitmap));
+	if (frame->can_id & CAN_EFF_FLAG) {
+		//            bit 7      0 7      0 7      0 7      0
+		// bitmap[0-3]   |.sBBBBBB BBBBBSIE EEEEEEEE EEEEEEEE| s = SOF, B = Base ID (11 bits), S = SRR, I = IDE, E = Extended ID (18 bits)
+		// bitmap[4-7]   |ER10DLC4 00000000 11111111 22222222| R = RTR, 0 = r0, 1 = r1, DLC4 = DLC, Data bytes
+		// bitmap[8-11]  |33333333 44444444 55555555 66666666| Data bytes
+		// bitmap[12-15] |77777777 ........ ........ ........| Data bytes
+		bitmap[0] = (frame->can_id & CAN_EFF_MASK) >> 23;
+		bitmap[1] = ((frame->can_id >> 18) & 0x3f) << 3 |
+			    3 << 1	       	     	      	| /* SRR, IDE */
+			    ((frame->can_id >> 17) & 0x01);
+		bitmap[2] = (frame->can_id >> 9) & 0xff;
+		bitmap[3] = (frame->can_id >> 1) & 0xff;
+		bitmap[4] = (frame->can_id & 0x1) << 7              |
+			    (!!(frame->can_id & CAN_RTR_FLAG)) << 6 |
+			    0 << 4	      		       	    | /* r1, r0 */
+			    frame->can_dlc & 0xf;
+		memcpy(&bitmap[5], &frame->data, frame->can_dlc);
+		start = 1;
+		end = 40 + 8*frame->can_dlc;
+	} else {
+		//           bit 7      0 7      0 7      0 7      0
+		// bitmap[0-3]  |.....sII IIIIIIII IRE0DLC4 00000000| s = SOF, I = ID (11 bits), R = RTR, E = IDE, DLC4 = DLC
+		// bitmap[4-7]  |11111111 22222222 33333333 44444444| Data bytes
+		// bitmap[8-11] |55555555 66666666 77777777 ........| Data bytes
+		bitmap[0] = (frame->can_id & CAN_SFF_MASK) >> 9;
+		bitmap[1] = (frame->can_id >> 1) & 0xff;
+		bitmap[2] = (frame->can_id << 7) & 0xff |
+			    (!!(frame->can_id & CAN_RTR_FLAG)) << 6 |
+			    0 << 4 | /* IDE, r0 */
+			    frame->can_dlc & 0xf;
+		memcpy(&bitmap[3], &frame->data, frame->can_dlc);
+		start = 5;
+		end = 24 + 8*frame->can_dlc;
+	}
+
+	/* Calc and append CRC */
+	crc_t crc = calc_bitmap_crc(bitmap, start, end);
+	uint16_t crc_be = htons(crc << 1);
+	assert(end%8 == 0);
+	memcpy(bitmap + end/8, &crc_be, 2);
+	end += 15;
+
+	/* Count stuffed bits */
+	uint8_t mask = 0x1f, lookfor = 0;
+	unsigned i = start, stuffed = 0;
+	const int8_t clz[32] = /* count of leading zeros in 5 bit numbers */
+		{ 5, 4, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+	while (i < end) {
+		unsigned bits = (bitmap[i/8] << 8 | bitmap[i/8+1]) >> (16 - 5 - i%8);
+		lookfor = lookfor ? 0 : mask; /* We alternate between looking for a series of zeros or ones */
+		unsigned change = (bits & mask) ^ lookfor; /* 1 indicates a change */
+		if (change) { /* No bit was stuffed here */
+			i += clz[change];
+			mask = 0x1f; /* Next look for 5 same bits */
+		} else {
+			i += (mask == 0x1f) ? 5 : 4;
+			if (i <= end) {
+				stuffed++;
+				mask = 0x1e; /* Next look for 4 bits (5th bit is the suffed one) */
+			}
+		}
+	}
+	return end - start + stuffed +
+		3 + 		/* CRC del, ACK, ACK del */
+		7 +		/* EOF */
+		3;		/* IFS */
+}
+
+
+unsigned can_frame_length(struct canfd_frame *frame, enum cfl_mode mode, int mtu)
+{
+	int eff = (frame->can_id & CAN_EFF_FLAG);
+
+	if (mtu != CAN_MTU)
+		return 0;	/* CANFD is not supported yet */
+
+	switch (mode) {
+	case CFL_NO_BITSTUFFING:
+		return (eff ? 67 : 47) + frame->len*8;
+	case CFL_WORSTCASE:
+		return ((eff ? 389 : 269) + frame->len*48)/5;
+	case CFL_EXACT:
+		return cfl_exact((struct can_frame*)frame);
+	}
+	return 0; /* Unknown mode */
+}
diff --git a/canframelen.h b/canframelen.h
new file mode 100644
index 0000000..225bc09
--- /dev/null
+++ b/canframelen.h
@@ -0,0 +1,35 @@
+#ifndef CANFRAMELEN_H
+#define CANFRAMELEN_H
+
+#include <linux/can.h>
+
+/**
+ * Frame length calculation modes.
+ *
+ * CFL_WORSTCASE corresponds to Ken Tindells *worst* case calculation
+ * for stuff-bits (see "Guaranteeing Message Latencies on Controller
+ * Area Network" 1st ICC'94) the needed bits on the wire can be
+ * calculated as:
+ *
+ * (34 + 8n)/5 + 47 + 8n for SFF frames (11 bit CAN-ID) => (269 + 48n)/5
+ * (54 + 8n)/5 + 67 + 8n for EFF frames (29 bit CAN-ID) => (389 + 48n)/5
+ *
+ * while 'n' is the data length code (number of payload bytes)
+ *
+ */
+enum cfl_mode {
+	CFL_NO_BITSTUFFING, /* plain bit calculation without bitstuffing */
+	CFL_WORSTCASE, /* with bitstuffing following Tindells estimation */
+	CFL_EXACT, /* exact calculation of stuffed bits based on frame
+		    * content and CRC */
+};
+
+/**
+ * Calculates the number of bits a frame needs on the wire (including
+ * inter frame space).
+ *
+ * Mode determines how to deal with stuffed bits.
+ */
+unsigned can_frame_length(struct canfd_frame *frame, enum cfl_mode mode, int mtu);
+
+#endif
-- 
1.8.5.2

