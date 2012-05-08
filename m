From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: update documentation wording error frames -> error messages
Date: Tue, 08 May 2012 22:20:33 +0200
Message-ID: <4FA98011.3020600@hartkopp.net>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:57667 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891Ab2EHUUf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 May 2012 16:20:35 -0400
In-Reply-To: <1318506157-10329-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>

As Heinz-Juergen Oertel pointed out 'CAN error frames' are a already defined
term for the CAN protocol violation indication on the wire.

To avoid confusion with the error messages created by CAN drivers available
via CAN RAW sockets update the documentation and change the naming from
'error frames' to 'error messages' or 'error message frames'.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index 56ca3b7..28d9b14 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -232,16 +232,16 @@ solution for a couple of reasons:
   arbitration problems and error frames caused by the different
   ECUs. The occurrence of detected errors are important for diagnosis
   and have to be logged together with the exact timestamp. For this
-  reason the CAN interface driver can generate so called Error Frames
-  that can optionally be passed to the user application in the same
-  way as other CAN frames. Whenever an error on the physical layer
+  reason the CAN interface driver can generate so called Error Message
+  Frames that can optionally be passed to the user application in the
+  same way as other CAN frames. Whenever an error on the physical layer
   or the MAC layer is detected (e.g. by the CAN controller) the driver
-  creates an appropriate error frame. Error frames can be requested by
-  the user application using the common CAN filter mechanisms. Inside
-  this filter definition the (interested) type of errors may be
-  selected. The reception of error frames is disabled by default.
-  The format of the CAN error frame is briefly described in the Linux
-  header file "include/linux/can/error.h".
+  creates an appropriate error message frame. Error messages frames can
+  be requested by the user application using the common CAN filter
+  mechanisms. Inside this filter definition the (interested) type of
+  errors may be selected. The reception of error messages is disabled
+  by default. The format of the CAN error message frame is briefly
+  described in the Linux header file "include/linux/can/error.h".
 
 4. How to use Socket CAN
 ------------------------
@@ -383,7 +383,7 @@ solution for a couple of reasons:
   defaults are set at RAW socket binding time:
 
   - The filters are set to exactly one filter receiving everything
-  - The socket only receives valid data frames (=> no error frames)
+  - The socket only receives valid data frames (=> no error message frames)
   - The loopback of sent CAN frames is enabled (see chapter 3.2)
   - The socket does not receive its own sent frames (in loopback mode)
 
@@ -434,7 +434,7 @@ solution for a couple of reasons:
   4.1.2 RAW socket option CAN_RAW_ERR_FILTER
 
   As described in chapter 3.4 the CAN interface driver can generate so
-  called Error Frames that can optionally be passed to the user
+  called Error Message Frames that can optionally be passed to the user
   application in the same way as other CAN frames. The possible
   errors are divided into different error classes that may be filtered
   using the appropriate error mask. To register for every possible
@@ -527,7 +527,7 @@ solution for a couple of reasons:
 
     rcvlist_all - list for unfiltered entries (no filter operations)
     rcvlist_eff - list for single extended frame (EFF) entries
-    rcvlist_err - list for error frames masks
+    rcvlist_err - list for error message frames masks
     rcvlist_fil - list for mask/value filters
     rcvlist_inv - list for mask/value filters (inverse semantic)
     rcvlist_sff - list for single standard frame (SFF) entries
@@ -784,13 +784,13 @@ solution for a couple of reasons:
     $ ip link set canX type can restart-ms 100
 
   Alternatively, the application may realize the "bus-off" condition
-  by monitoring CAN error frames and do a restart when appropriate with
-  the command:
+  by monitoring CAN error message frames and do a restart when
+  appropriate with the command:
 
     $ ip link set canX type can restart
 
-  Note that a restart will also create a CAN error frame (see also
-  chapter 3.4).
+  Note that a restart will also create a CAN error message frame (see
+  also chapter 3.4).
 
   6.6 Supported CAN hardware
 
diff --git a/include/linux/can.h b/include/linux/can.h
index 9a19bcb..17334c0 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -21,7 +21,7 @@
 /* special address description flags for the CAN_ID */
 #define CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
 #define CAN_RTR_FLAG 0x40000000U /* remote transmission request */
-#define CAN_ERR_FLAG 0x20000000U /* error frame */
+#define CAN_ERR_FLAG 0x20000000U /* error message frame */
 
 /* valid bits in CAN ID for frame formats */
 #define CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
@@ -32,14 +32,14 @@
  * Controller Area Network Identifier structure
  *
  * bit 0-28	: CAN identifier (11/29 bit)
- * bit 29	: error frame flag (0 = data frame, 1 = error frame)
+ * bit 29	: error message frame flag (0 = data frame, 1 = error message)
  * bit 30	: remote transmission request flag (1 = rtr frame)
  * bit 31	: frame format flag (0 = standard 11 bit, 1 = extended 29 bit)
  */
 typedef __u32 canid_t;
 
 /*
- * Controller Area Network Error Frame Mask structure
+ * Controller Area Network Error Message Frame Mask structure
  *
  * bit 0-28	: error class mask (see include/linux/can/error.h)
  * bit 29-31	: set to zero
@@ -97,7 +97,7 @@ struct sockaddr_can {
  *          <received_can_id> & mask == can_id & mask
  *
  * The filter can be inverted (CAN_INV_FILTER bit set in can_id) or it can
- * filter for error frames (CAN_ERR_FLAG bit set in mask).
+ * filter for error message frames (CAN_ERR_FLAG bit set in mask).
  */
 struct can_filter {
 	canid_t can_id;
diff --git a/include/linux/can/error.h b/include/linux/can/error.h
index 63e855e..7b7148b 100644
--- a/include/linux/can/error.h
+++ b/include/linux/can/error.h
@@ -1,7 +1,7 @@
 /*
  * linux/can/error.h
  *
- * Definitions of the CAN error frame to be filtered and passed to the user.
+ * Definitions of the CAN error messages to be filtered and passed to the user.
  *
  * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
  * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
@@ -12,7 +12,7 @@
 #ifndef CAN_ERROR_H
 #define CAN_ERROR_H
 
-#define CAN_ERR_DLC 8 /* dlc for error frames */
+#define CAN_ERR_DLC 8 /* dlc for error message frames */
 
 /* error class (mask) in can_id */
 #define CAN_ERR_TX_TIMEOUT   0x00000001U /* TX timeout (by netdevice driver) */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0ce2ad0..6efcd37 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -334,8 +334,8 @@ static struct dev_rcv_lists *find_dev_rcv_lists(struct net_device *dev)
  *  relevant bits for the filter.
  *
  *  The filter can be inverted (CAN_INV_FILTER bit set in can_id) or it can
- *  filter for error frames (CAN_ERR_FLAG bit set in mask). For error frames
- *  there is a special filterlist and a special rx path filter handling.
+ *  filter for error messages (CAN_ERR_FLAG bit set in mask). For error msg
+ *  frames there is a special filterlist and a special rx path filter handling.
  *
  * Return:
  *  Pointer to optimal filterlist for the given can_id/mask pair.
@@ -347,7 +347,7 @@ static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
 {
 	canid_t inv = *can_id & CAN_INV_FILTER; /* save flag before masking */
 
-	/* filter for error frames in extra filterlist */
+	/* filter for error message frames in extra filterlist */
 	if (*mask & CAN_ERR_FLAG) {
 		/* clear CAN_ERR_FLAG in filter entry */
 		*mask &= CAN_ERR_MASK;
@@ -408,7 +408,7 @@ static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
  *          <received_can_id> & mask == can_id & mask
  *
  *  The filter can be inverted (CAN_INV_FILTER bit set in can_id) or it can
- *  filter for error frames (CAN_ERR_FLAG bit set in mask).
+ *  filter for error message frames (CAN_ERR_FLAG bit set in mask).
  *
  *  The provided pointer to the sk_buff is guaranteed to be valid as long as
  *  the callback function is running. The callback function must *not* free
@@ -578,7 +578,7 @@ static int can_rcv_filter(struct dev_rcv_lists *d, struct sk_buff *skb)
 		return 0;
 
 	if (can_id & CAN_ERR_FLAG) {
-		/* check for error frame entries only */
+		/* check for error message frame entries only */
 		hlist_for_each_entry_rcu(r, n, &d->rx[RX_ERR], list) {
 			if (can_id & r->mask) {
 				deliver(skb, r);


