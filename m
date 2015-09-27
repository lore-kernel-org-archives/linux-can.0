From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [RFC PATCH 1/4] net: can: make af_can header global
Date: Sun, 27 Sep 2015 18:22:17 +0000
Message-ID: <AM2PR05MB0916E0EB2BAC114121BDD0C689400@AM2PR05MB0916.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0077.outbound.protection.outlook.com ([157.56.112.77]:56173
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751894AbbI0ShT (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 27 Sep 2015 14:37:19 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, John Ernberg <john.ernberg@actia.se>

---
 include/net/af_can.h | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++
 net/can/af_can.c     |   2 +-
 net/can/af_can.h     | 126 ---------------------------------------------------
 net/can/proc.c       |   2 +-
 4 files changed, 128 insertions(+), 128 deletions(-)
 create mode 100644 include/net/af_can.h
 delete mode 100644 net/can/af_can.h

diff --git a/include/net/af_can.h b/include/net/af_can.h
new file mode 100644
index 0000000..002b16d
--- /dev/null
+++ b/include/net/af_can.h
@@ -0,0 +1,126 @@
+/*
+ * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
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
+ */
+
+#ifndef __LINUX_NET_AF_CAN_H__
+#define __LINUX_NET_AF_CAN_H__
+
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include <linux/list.h>
+#include <linux/rcupdate.h>
+#include <linux/can.h>
+
+/* af_can rx dispatcher structures */
+
+struct receiver {
+	struct hlist_node list;
+	struct rcu_head rcu;
+	canid_t can_id;
+	canid_t mask;
+	unsigned long matches;
+	void (*func)(struct sk_buff *, void *);
+	void *data;
+	char *ident;
+};
+
+#define CAN_SFF_RCV_ARRAY_SZ (1 << CAN_SFF_ID_BITS)
+#define CAN_EFF_RCV_HASH_BITS 10
+#define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
+
+enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
+
+/* per device receive filters linked at dev->ml_priv */
+struct dev_rcv_lists {
+	struct hlist_head rx[RX_MAX];
+	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
+	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
+	int remove_on_zero_entries;
+	int entries;
+};
+
+/* statistic structures */
+
+/* can be reset e.g. by can_init_stats() */
+struct s_stats {
+	unsigned long jiffies_init;
+
+	unsigned long rx_frames;
+	unsigned long tx_frames;
+	unsigned long matches;
+
+	unsigned long total_rx_rate;
+	unsigned long total_tx_rate;
+	unsigned long total_rx_match_ratio;
+
+	unsigned long current_rx_rate;
+	unsigned long current_tx_rate;
+	unsigned long current_rx_match_ratio;
+
+	unsigned long max_rx_rate;
+	unsigned long max_tx_rate;
+	unsigned long max_rx_match_ratio;
+
+	unsigned long rx_frames_delta;
+	unsigned long tx_frames_delta;
+	unsigned long matches_delta;
+};
+
+/* persistent statistics */
+struct s_pstats {
+	unsigned long stats_reset;
+	unsigned long user_reset;
+	unsigned long rcv_entries;
+	unsigned long rcv_entries_max;
+};
+
+/* receive filters subscribed for 'all' CAN devices */
+extern struct dev_rcv_lists can_rx_alldev_list;
+
+/* function prototypes for the CAN networklayer procfs (proc.c) */
+void can_init_proc(void);
+void can_remove_proc(void);
+void can_stat_update(unsigned long data);
+
+/* structures and variables from af_can.c needed in proc.c for reading */
+extern struct timer_list can_stattimer;    /* timer for statistics update */
+extern struct s_stats    can_stats;        /* packet statistics */
+extern struct s_pstats   can_pstats;       /* receive list statistics */
+extern struct hlist_head can_rx_dev_list;  /* rx dispatcher structures */
+
+#endif /* __LINUX_NET_AF_CAN_H__ */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 166d436..1fe846b 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -62,7 +62,7 @@
 #include <net/net_namespace.h>
 #include <net/sock.h>
 
-#include "af_can.h"
+#include <net/af_can.h>
 
 MODULE_DESCRIPTION("Controller Area Network PF_CAN core");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/net/can/af_can.h b/net/can/af_can.h
deleted file mode 100644
index fca0fe9..0000000
--- a/net/can/af_can.h
+++ /dev/null
@@ -1,126 +0,0 @@
-/*
- * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. Neither the name of Volkswagen nor the names of its contributors
- *    may be used to endorse or promote products derived from this software
- *    without specific prior written permission.
- *
- * Alternatively, provided that this notice is retained in full, this
- * software may be distributed under the terms of the GNU General
- * Public License ("GPL") version 2, in which case the provisions of the
- * GPL apply INSTEAD OF those given above.
- *
- * The provided data structures and external interfaces from this code
- * are not restricted to be used by modules with a GPL compatible license.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
- * DAMAGE.
- *
- */
-
-#ifndef AF_CAN_H
-#define AF_CAN_H
-
-#include <linux/skbuff.h>
-#include <linux/netdevice.h>
-#include <linux/list.h>
-#include <linux/rcupdate.h>
-#include <linux/can.h>
-
-/* af_can rx dispatcher structures */
-
-struct receiver {
-	struct hlist_node list;
-	struct rcu_head rcu;
-	canid_t can_id;
-	canid_t mask;
-	unsigned long matches;
-	void (*func)(struct sk_buff *, void *);
-	void *data;
-	char *ident;
-};
-
-#define CAN_SFF_RCV_ARRAY_SZ (1 << CAN_SFF_ID_BITS)
-#define CAN_EFF_RCV_HASH_BITS 10
-#define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
-
-enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
-
-/* per device receive filters linked at dev->ml_priv */
-struct dev_rcv_lists {
-	struct hlist_head rx[RX_MAX];
-	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
-	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
-	int remove_on_zero_entries;
-	int entries;
-};
-
-/* statistic structures */
-
-/* can be reset e.g. by can_init_stats() */
-struct s_stats {
-	unsigned long jiffies_init;
-
-	unsigned long rx_frames;
-	unsigned long tx_frames;
-	unsigned long matches;
-
-	unsigned long total_rx_rate;
-	unsigned long total_tx_rate;
-	unsigned long total_rx_match_ratio;
-
-	unsigned long current_rx_rate;
-	unsigned long current_tx_rate;
-	unsigned long current_rx_match_ratio;
-
-	unsigned long max_rx_rate;
-	unsigned long max_tx_rate;
-	unsigned long max_rx_match_ratio;
-
-	unsigned long rx_frames_delta;
-	unsigned long tx_frames_delta;
-	unsigned long matches_delta;
-};
-
-/* persistent statistics */
-struct s_pstats {
-	unsigned long stats_reset;
-	unsigned long user_reset;
-	unsigned long rcv_entries;
-	unsigned long rcv_entries_max;
-};
-
-/* receive filters subscribed for 'all' CAN devices */
-extern struct dev_rcv_lists can_rx_alldev_list;
-
-/* function prototypes for the CAN networklayer procfs (proc.c) */
-void can_init_proc(void);
-void can_remove_proc(void);
-void can_stat_update(unsigned long data);
-
-/* structures and variables from af_can.c needed in proc.c for reading */
-extern struct timer_list can_stattimer;    /* timer for statistics update */
-extern struct s_stats    can_stats;        /* packet statistics */
-extern struct s_pstats   can_pstats;       /* receive list statistics */
-extern struct hlist_head can_rx_dev_list;  /* rx dispatcher structures */
-
-#endif /* AF_CAN_H */
diff --git a/net/can/proc.c b/net/can/proc.c
index 1a19b98..b6bbc62 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -46,7 +46,7 @@
 #include <linux/if_arp.h>
 #include <linux/can/core.h>
 
-#include "af_can.h"
+#include <net/af_can.h>
 
 /*
  * proc filenames for the PF_CAN core
-- 
2.5.3

