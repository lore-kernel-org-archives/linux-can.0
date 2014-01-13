From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH can-utils v3 2/5] Move isotp.h into the project root
Date: Mon, 13 Jan 2014 22:13:18 +0100
Message-ID: <1389647601-10622-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1389647601-10622-1-git-send-email-u.kleine-koenig@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40253 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbaAMVN3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 16:13:29 -0500
In-Reply-To: <1389647601-10622-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

This file isn't a kernel header and only used by isotp*.c programs. So it
can better live there similar to log.h and terminal.h.
---
 GNUmakefile.am                |   3 +-
 include/linux/can/isotp.h     |   1 -
 include/socketcan/can/isotp.h | 110 ------------------------------------------
 isotp.h                       | 110 ++++++++++++++++++++++++++++++++++++++++++
 isotprecv.c                   |   3 +-
 isotpsend.c                   |   3 +-
 isotpserver.c                 |   3 +-
 isotpsniffer.c                |   3 +-
 isotptun.c                    |   3 +-
 9 files changed, 121 insertions(+), 118 deletions(-)
 delete mode 100644 include/linux/can/isotp.h
 delete mode 100644 include/socketcan/can/isotp.h
 create mode 100644 isotp.h

diff --git a/GNUmakefile.am b/GNUmakefile.am
index 34a7740c9906..8c6e93a25c35 100644
--- a/GNUmakefile.am
+++ b/GNUmakefile.am
@@ -8,13 +8,13 @@ LDADD = \
 	libcan.la
 
 noinst_HEADERS = \
+	isotp.h \
 	lib.h \
 	terminal.h \
 	include/linux/can/bcm.h \
 	include/linux/can/error.h \
 	include/linux/can/gw.h \
 	include/linux/can.h \
-	include/linux/can/isotp.h \
 	include/linux/can/netlink.h \
 	include/linux/can/raw.h \
 	include/socketcan/can/bcm.h \
@@ -22,7 +22,6 @@ noinst_HEADERS = \
 	include/socketcan/can/gw.h \
 	include/socketcan/can.h \
 	include/socketcan/can/ioctl.h \
-	include/socketcan/can/isotp.h \
 	include/socketcan/can/netlink.h \
 	include/socketcan/can/raw.h
 
diff --git a/include/linux/can/isotp.h b/include/linux/can/isotp.h
deleted file mode 100644
index c52850f4bdb2..000000000000
--- a/include/linux/can/isotp.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <socketcan/can/isotp.h>
diff --git a/include/socketcan/can/isotp.h b/include/socketcan/can/isotp.h
deleted file mode 100644
index 6ba5ef1269f4..000000000000
--- a/include/socketcan/can/isotp.h
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * socketcan/can/isotp.h
- *
- * Definitions for isotp CAN sockets
- *
- * $Id$
- *
- * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
- * Copyright (c) 2008 Volkswagen Group Electronic Research
- * All rights reserved.
- *
- * Send feedback to <linux-can@vger.kernel.org>
- *
- */
-
-#ifndef CAN_ISOTP_H
-#define CAN_ISOTP_H
-
-#include <socketcan/can.h>
-
-#define SOL_CAN_ISOTP (SOL_CAN_BASE + CAN_ISOTP)
-
-/* for socket options affecting the socket (not the global system) */
-
-#define CAN_ISOTP_OPTS		1	/* pass struct can_isotp_options */
-
-#define CAN_ISOTP_RECV_FC	2	/* pass struct can_isotp_fc_options */
-
-/* sockopts to force stmin timer values for protocol regression tests */
-
-#define CAN_ISOTP_TX_STMIN	3	/* pass __u32 value in nano secs    */
-					/* use this time instead of value   */
-					/* provided in FC from the receiver */
-
-#define CAN_ISOTP_RX_STMIN	4	/* pass __u32 value in nano secs   */
-					/* ignore received CF frames which */
-					/* timestamps differ less than val */
-
-struct can_isotp_options {
-
-	__u32 flags;		/* set flags for isotp behaviour.	*/
-				/* __u32 value : flags see below	*/
-
-	__u32 frame_txtime;	/* frame transmission time (N_As/N_Ar)	*/
-				/* __u32 value : time in nano secs	*/
-
-	__u8  ext_address;	/* set address for extended addressing	*/
-				/* __u8 value : extended address	*/
-
-	__u8  txpad_content;	/* set content of padding byte (tx)	*/
-				/* __u8 value : content	on tx path	*/
-
-	__u8  rxpad_content;	/* set content of padding byte (rx)	*/
-				/* __u8 value : content	on rx path	*/
-};
-
-struct can_isotp_fc_options {
-
-	__u8  bs;		/* blocksize provided in FC frame	*/
-				/* __u8 value : blocksize. 0 = off	*/
-
-	__u8  stmin;		/* separation time provided in FC frame	*/
-				/* __u8 value :				*/
-				/* 0x00 - 0x7F : 0 - 127 ms		*/
-				/* 0x80 - 0xF0 : reserved		*/
-				/* 0xF1 - 0xF9 : 100 us - 900 us	*/
-				/* 0xFA - 0xFF : reserved		*/
-
-	__u8  wftmax;		/* max. number of wait frame transmiss.	*/
-				/* __u8 value : 0 = omit FC N_PDU WT	*/
-};
-
-
-/* flags for isotp behaviour */
-
-#define CAN_ISOTP_LISTEN_MODE	0x001	/* listen only (do not send FC) */
-#define CAN_ISOTP_EXTEND_ADDR	0x002	/* enable extended addressing */
-#define CAN_ISOTP_TX_PADDING	0x004	/* enable CAN frame padding tx path */
-#define CAN_ISOTP_RX_PADDING	0x008	/* enable CAN frame padding rx path */
-#define CAN_ISOTP_CHK_PAD_LEN	0x010	/* check received CAN frame padding */
-#define CAN_ISOTP_CHK_PAD_DATA	0x020	/* check received CAN frame padding */
-#define CAN_ISOTP_HALF_DUPLEX	0x040	/* half duplex error state handling */
-#define CAN_ISOTP_FORCE_TXSTMIN	0x080	/* ignore stmin from received FC */
-#define CAN_ISOTP_FORCE_RXSTMIN	0x100	/* ignore CFs depending on rx stmin */
-
-
-/* default values */
-
-#define CAN_ISOTP_DEFAULT_FLAGS		0
-#define CAN_ISOTP_DEFAULT_EXT_ADDRESS	0x00
-#define CAN_ISOTP_DEFAULT_RXPAD_CONTENT	0x00
-#define CAN_ISOTP_DEFAULT_TXPAD_CONTENT	0x00
-#define CAN_ISOTP_DEFAULT_FRAME_TXTIME	0
-#define CAN_ISOTP_DEFAULT_RECV_BS	0
-#define CAN_ISOTP_DEFAULT_RECV_STMIN	0x00
-#define CAN_ISOTP_DEFAULT_RECV_WFTMAX	0
-
-/*
- * Remark on CAN_ISOTP_DEFAULT_RECV_* values:
- *
- * We can strongly assume, that the Linux Kernel implementation of
- * CAN_ISOTP is capable to run with BS=0, STmin=0 and WFTmax=0.
- * But as we like to be able to behave as a commonly available ECU,
- * these default settings can be changed via sockopts.
- * For that reason the STmin value is intentionally _not_ checked for
- * consistency and copied directly into the flow control (FC) frame.
- *
- */
-
-#endif
diff --git a/isotp.h b/isotp.h
new file mode 100644
index 000000000000..be4fe1a06bfd
--- /dev/null
+++ b/isotp.h
@@ -0,0 +1,110 @@
+/*
+ * isotp.h
+ *
+ * Definitions for isotp CAN sockets
+ *
+ * $Id$
+ *
+ * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ * Copyright (c) 2008 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ * Send feedback to <linux-can@vger.kernel.org>
+ *
+ */
+
+#ifndef CAN_ISOTP_H
+#define CAN_ISOTP_H
+
+#include <socketcan/can.h>
+
+#define SOL_CAN_ISOTP (SOL_CAN_BASE + CAN_ISOTP)
+
+/* for socket options affecting the socket (not the global system) */
+
+#define CAN_ISOTP_OPTS		1	/* pass struct can_isotp_options */
+
+#define CAN_ISOTP_RECV_FC	2	/* pass struct can_isotp_fc_options */
+
+/* sockopts to force stmin timer values for protocol regression tests */
+
+#define CAN_ISOTP_TX_STMIN	3	/* pass __u32 value in nano secs    */
+					/* use this time instead of value   */
+					/* provided in FC from the receiver */
+
+#define CAN_ISOTP_RX_STMIN	4	/* pass __u32 value in nano secs   */
+					/* ignore received CF frames which */
+					/* timestamps differ less than val */
+
+struct can_isotp_options {
+
+	__u32 flags;		/* set flags for isotp behaviour.	*/
+				/* __u32 value : flags see below	*/
+
+	__u32 frame_txtime;	/* frame transmission time (N_As/N_Ar)	*/
+				/* __u32 value : time in nano secs	*/
+
+	__u8  ext_address;	/* set address for extended addressing	*/
+				/* __u8 value : extended address	*/
+
+	__u8  txpad_content;	/* set content of padding byte (tx)	*/
+				/* __u8 value : content	on tx path	*/
+
+	__u8  rxpad_content;	/* set content of padding byte (rx)	*/
+				/* __u8 value : content	on rx path	*/
+};
+
+struct can_isotp_fc_options {
+
+	__u8  bs;		/* blocksize provided in FC frame	*/
+				/* __u8 value : blocksize. 0 = off	*/
+
+	__u8  stmin;		/* separation time provided in FC frame	*/
+				/* __u8 value :				*/
+				/* 0x00 - 0x7F : 0 - 127 ms		*/
+				/* 0x80 - 0xF0 : reserved		*/
+				/* 0xF1 - 0xF9 : 100 us - 900 us	*/
+				/* 0xFA - 0xFF : reserved		*/
+
+	__u8  wftmax;		/* max. number of wait frame transmiss.	*/
+				/* __u8 value : 0 = omit FC N_PDU WT	*/
+};
+
+
+/* flags for isotp behaviour */
+
+#define CAN_ISOTP_LISTEN_MODE	0x001	/* listen only (do not send FC) */
+#define CAN_ISOTP_EXTEND_ADDR	0x002	/* enable extended addressing */
+#define CAN_ISOTP_TX_PADDING	0x004	/* enable CAN frame padding tx path */
+#define CAN_ISOTP_RX_PADDING	0x008	/* enable CAN frame padding rx path */
+#define CAN_ISOTP_CHK_PAD_LEN	0x010	/* check received CAN frame padding */
+#define CAN_ISOTP_CHK_PAD_DATA	0x020	/* check received CAN frame padding */
+#define CAN_ISOTP_HALF_DUPLEX	0x040	/* half duplex error state handling */
+#define CAN_ISOTP_FORCE_TXSTMIN	0x080	/* ignore stmin from received FC */
+#define CAN_ISOTP_FORCE_RXSTMIN	0x100	/* ignore CFs depending on rx stmin */
+
+
+/* default values */
+
+#define CAN_ISOTP_DEFAULT_FLAGS		0
+#define CAN_ISOTP_DEFAULT_EXT_ADDRESS	0x00
+#define CAN_ISOTP_DEFAULT_RXPAD_CONTENT	0x00
+#define CAN_ISOTP_DEFAULT_TXPAD_CONTENT	0x00
+#define CAN_ISOTP_DEFAULT_FRAME_TXTIME	0
+#define CAN_ISOTP_DEFAULT_RECV_BS	0
+#define CAN_ISOTP_DEFAULT_RECV_STMIN	0x00
+#define CAN_ISOTP_DEFAULT_RECV_WFTMAX	0
+
+/*
+ * Remark on CAN_ISOTP_DEFAULT_RECV_* values:
+ *
+ * We can strongly assume, that the Linux Kernel implementation of
+ * CAN_ISOTP is capable to run with BS=0, STmin=0 and WFTmax=0.
+ * But as we like to be able to behave as a commonly available ECU,
+ * these default settings can be changed via sockopts.
+ * For that reason the STmin value is intentionally _not_ checked for
+ * consistency and copied directly into the flow control (FC) frame.
+ *
+ */
+
+#endif
diff --git a/isotprecv.c b/isotprecv.c
index 1c8f79c6f957..9f33346cbaf7 100644
--- a/isotprecv.c
+++ b/isotprecv.c
@@ -53,7 +53,8 @@
 #include <sys/ioctl.h>
 
 #include <linux/can.h>
-#include <linux/can/isotp.h>
+
+#include "isotp.h"
 
 #define NO_CAN_ID 0xFFFFFFFFU
 
diff --git a/isotpsend.c b/isotpsend.c
index 3bb8282b2c50..d5f7b2c557f9 100644
--- a/isotpsend.c
+++ b/isotpsend.c
@@ -53,7 +53,8 @@
 #include <sys/ioctl.h>
 
 #include <linux/can.h>
-#include <linux/can/isotp.h>
+
+#include "isotp.h"
 
 #define NO_CAN_ID 0xFFFFFFFFU
 
diff --git a/isotpserver.c b/isotpserver.c
index 60b0a738c390..a69f67ab37ce 100644
--- a/isotpserver.c
+++ b/isotpserver.c
@@ -73,7 +73,8 @@
 #include <netinet/in.h>
 
 #include <linux/can.h>
-#include <linux/can/isotp.h>
+
+#include "isotp.h"
 
 #define NO_CAN_ID 0xFFFFFFFFU
 
diff --git a/isotpsniffer.c b/isotpsniffer.c
index 84d39a2a9d46..80ee693c68ce 100644
--- a/isotpsniffer.c
+++ b/isotpsniffer.c
@@ -54,7 +54,8 @@
 #include <sys/ioctl.h>
 
 #include <linux/can.h>
-#include <linux/can/isotp.h>
+
+#include "isotp.h"
 #include "terminal.h"
 
 #define NO_CAN_ID 0xFFFFFFFFU
diff --git a/isotptun.c b/isotptun.c
index 77ee1d3cd539..07341fc26b08 100644
--- a/isotptun.c
+++ b/isotptun.c
@@ -62,9 +62,10 @@
 #include <sys/ioctl.h>
 
 #include <linux/can.h>
-#include <linux/can/isotp.h>
 #include <linux/if_tun.h>
 
+#include "isotp.h"
+
 #define NO_CAN_ID 0xFFFFFFFFU
 #define DEFAULT_NAME "ctun%d"
 
-- 
1.8.5.2

