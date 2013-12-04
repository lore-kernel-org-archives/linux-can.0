From: John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH] CAN-Next Simple changes to Documentation (can.txt)
Date: Wed,  4 Dec 2013 21:37:02 +0000
Message-ID: <1386193022-8550-1-git-send-email-johnfwhitmore@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:40981 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756Ab3LDViX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Dec 2013 16:38:23 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so14384824wgh.2
        for <linux-can@vger.kernel.org>; Wed, 04 Dec 2013 13:38:21 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: socketcan@hartkopp.net, hardbyte@gmail.com, linux-can@vger.kernel.org
Cc: rob@landley.net, John Whitmore <johnfwhitmore@gmail.com>

MAINTAINERS: added Documentation/networking/can.txt to the list of
maintained files in CAN NETWORK LAYER.

Documentation/networking/can.txt: corrected a few typos and removed
redundant description of Kconfig options CAN_RAW_USER and CAN_BCM_USER.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 Documentation/networking/can.txt |   24 +++++++++---------------
 MAINTAINERS                      |    1 +
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index 4c07241..cd213f4 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -92,7 +92,7 @@ new driver's API.
 Socket CAN was designed to overcome all of these limitations.  A new
 protocol family has been implemented which provides a socket interface
 to user space applications and which builds upon the Linux network
-layer, so to use all of the provided queueing functionality.  A device
+layer, enabbling use of the provided queueing functionality.  A device
 driver for CAN controller hardware registers itself with the Linux
 network layer as a network device, so that CAN frames from the
 controller can be passed up to the network layer and on to the CAN
@@ -222,14 +222,8 @@ solution for a couple of reasons:
   The Controller Area Network is a local field bus transmitting only
   broadcast messages without any routing and security concepts.
   In the majority of cases the user application has to deal with
-  raw CAN frames. Therefore it might be reasonable NOT to restrict
-  the CAN access only to the user root, as known from other networks.
-  Since the currently implemented CAN_RAW and CAN_BCM sockets can only
-  send and receive frames to/from CAN interfaces it does not affect
-  security of others networks to allow all users to access the CAN.
-  To enable non-root users to access CAN_RAW and CAN_BCM protocol
-  sockets the Kconfig options CAN_RAW_USER and/or CAN_BCM_USER may be
-  selected at kernel compile time.
+  raw CAN frames. Therefore CAN access is NOT restricted to only the user
+  root.
 
   3.4 network problem notifications
 
@@ -286,8 +280,8 @@ solution for a couple of reasons:
     };
 
   The alignment of the (linear) payload data[] to a 64bit boundary
-  allows the user to define own structs and unions to easily access the
-  CAN payload. There is no given byteorder on the CAN bus by
+  allows the user to define their own structs and unions to easily access
+  the CAN payload. There is no given byteorder on the CAN bus by
   default. A read(2) system call on a CAN_RAW socket transfers a
   struct can_frame to the user space.
 
@@ -298,7 +292,7 @@ solution for a couple of reasons:
             sa_family_t can_family;
             int         can_ifindex;
             union {
-                    /* transport protocol class address info (e.g. ISOTP) */
+                    /* transport protocol class address info (e.g. ISO-TP) */
                     struct { canid_t rx_id, tx_id; } tp;
 
                     /* reserved for future CAN protocols address information */
@@ -479,7 +473,7 @@ solution for a couple of reasons:
 
     setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);
 
-  To set the filters to zero filters is quite obsolete as not read
+  To set the filters to zero filters is quite obsolete as to not read
   data causes the raw socket to discard the received CAN frames. But
   having this 'send only' use-case we may remove the receive list in the
   Kernel to save a little (really a very little!) CPU usage.
@@ -1105,7 +1099,7 @@ solution for a couple of reasons:
 
     $ ip link set canX up type can bitrate 125000
 
-  A device may enter the "bus-off" state if too much errors occurred on
+  A device may enter the "bus-off" state if too many errors occurred on
   the CAN bus. Then no more messages are received or sent. An automatic
   bus-off recovery can be enabled by setting the "restart-ms" to a
   non-zero value, e.g.:
@@ -1125,7 +1119,7 @@ solution for a couple of reasons:
 
   CAN FD capable CAN controllers support two different bitrates for the
   arbitration phase and the payload phase of the CAN FD frame. Therefore a
-  second bittiming has to be specified in order to enable the CAN FD bitrate.
+  second bit timing has to be specified in order to enable the CAN FD bitrate.
 
   Additionally CAN FD capable CAN controllers support up to 64 bytes of
   payload. The representation of this length in can_frame.can_dlc and
diff --git a/MAINTAINERS b/MAINTAINERS
index 67c0068..fbd74ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2010,6 +2010,7 @@ L:	linux-can@vger.kernel.org
 W:	http://gitorious.org/linux-can
 T:	git git://gitorious.org/linux-can/linux-can-next.git
 S:	Maintained
+F:	Documentation/networking/can.txt
 F:	net/can/
 F:	include/linux/can/core.h
 F:	include/uapi/linux/can.h
-- 
1.7.10.4

