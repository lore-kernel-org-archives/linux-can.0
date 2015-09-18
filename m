From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2] can: Add documentation for CAN FD driver configuration
Date: Fri, 18 Sep 2015 11:10:15 +0200
Message-ID: <1442567415-4271-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:15447 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbbIRJK2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Sep 2015 05:10:28 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: corbet@lwn.net, Oliver Hartkopp <socketcan@hartkopp.net>

With Linux 3.15 the infrastructure for CAN FD hardware drivers had been
introduced into the kernel. Now the M_CAN driver and the peak_usb driver
support CAN FD. Update the documentation to show the latest CAN related
configuration options of 'ip' from iproute2 and describe the CAN FD specific
options to set the data bitrate and protocol version (ISO/non-ISO).

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 Documentation/networking/can.txt | 97 +++++++++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 20 deletions(-)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index fd1a1aa..4636b94 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -1018,25 +1018,34 @@ solution for a couple of reasons:
 
     $ ip link set can0 type can help
     Usage: ip link set DEVICE type can
-    	[ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |
-    	[ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1
-     	  phase-seg2 PHASE-SEG2 [ sjw SJW ] ]
-
-    	[ loopback { on | off } ]
-    	[ listen-only { on | off } ]
-    	[ triple-sampling { on | off } ]
-
-    	[ restart-ms TIME-MS ]
-    	[ restart ]
-
-    	Where: BITRATE       := { 1..1000000 }
-    	       SAMPLE-POINT  := { 0.000..0.999 }
-    	       TQ            := { NUMBER }
-    	       PROP-SEG      := { 1..8 }
-    	       PHASE-SEG1    := { 1..8 }
-    	       PHASE-SEG2    := { 1..8 }
-    	       SJW           := { 1..4 }
-    	       RESTART-MS    := { 0 | NUMBER }
+        [ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |
+        [ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1
+          phase-seg2 PHASE-SEG2 [ sjw SJW ] ]
+
+        [ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] |
+        [ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1
+          dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]
+
+        [ loopback { on | off } ]
+        [ listen-only { on | off } ]
+        [ triple-sampling { on | off } ]
+        [ one-shot { on | off } ]
+        [ berr-reporting { on | off } ]
+        [ fd { on | off } ]
+        [ fd-non-iso { on | off } ]
+        [ presume-ack { on | off } ]
+
+        [ restart-ms TIME-MS ]
+        [ restart ]
+
+        Where: BITRATE       := { 1..1000000 }
+               SAMPLE-POINT  := { 0.000..0.999 }
+               TQ            := { NUMBER }
+               PROP-SEG      := { 1..8 }
+               PHASE-SEG1    := { 1..8 }
+               PHASE-SEG2    := { 1..8 }
+               SJW           := { 1..4 }
+               RESTART-MS    := { 0 | NUMBER }
 
   - Display CAN device details and statistics:
 
@@ -1178,7 +1187,55 @@ solution for a couple of reasons:
   The CAN device MTU can be retrieved e.g. with a SIOCGIFMTU ioctl() syscall.
   N.B. CAN FD capable devices can also handle and send legacy CAN frames.
 
-  FIXME: Add details about the CAN FD controller configuration when available.
+  When configuring CAN FD capable CAN controllers an additional 'data' bitrate
+  has to be set. This bitrate for the data phase of the CAN FD frame has to be
+  at least the bitrate which was configured for the arbitration phase. This
+  second bitrate is specified analogue to the first bitrate but the bitrate
+  setting keywords for the 'data' bitrate start with 'd' e.g. dbitrate,
+  dsample-point, dsjw or dtq and similar settings. When a data bitrate is set
+  within the configuration process the controller option "fd on" can be
+  specified to enable the CAN FD mode in the CAN controller. This controller
+  option also switches the device MTU to 72 (CANFD_MTU).
+
+  The first CAN FD specification presented as whitepaper at the International
+  CAN Conference 2012 needed to be improved for data integrity reasons.
+  Therefore two CAN FD implementations have to be distinguished today:
+
+  - ISO compliant:     The ISO 11898-1:2015 CAN FD implementation (default)
+  - non-ISO compliant: The CAN FD implementation following the 2012 whitepaper
+
+  Finally there are three types of CAN FD controllers:
+
+  1. ISO compliant (fixed)
+  2. non-ISO compliant (fixed, like the M_CAN IP core v3.0.1 in m_can.c)
+  3. ISO/non-ISO CAN FD controllers (switchable, like the PEAK PCAN-USB FD)
+
+  The current ISO/non-ISO mode is announced by the CAN controller driver via
+  netlink and displayed by the 'ip' tool (controller option FD-NON-ISO).
+  The ISO/non-ISO-mode can be altered by setting 'fd-non-iso {on|off}' for
+  switchable CAN FD controllers only.
+
+  Example configuring 500 kbit/s arbitration bitrate and 4 Mbit/s data bitrate:
+
+    $ ip link set can0 up type can bitrate 500000 sample-point 0.75 \
+                                   dbitrate 4000000 dsample-point 0.8 fd on
+    $ ip -details link show can0
+    5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UNKNOWN \
+             mode DEFAULT group default qlen 10
+    link/can  promiscuity 0
+    can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
+          bitrate 500000 sample-point 0.750
+          tq 50 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 1
+          pcan_usb_pro_fd: tseg1 1..64 tseg2 1..16 sjw 1..16 brp 1..1024 \
+          brp-inc 1
+          dbitrate 4000000 dsample-point 0.800
+          dtq 12 dprop-seg 7 dphase-seg1 8 dphase-seg2 4 dsjw 1
+          pcan_usb_pro_fd: dtseg1 1..16 dtseg2 1..8 dsjw 1..4 dbrp 1..1024 \
+          dbrp-inc 1
+          clock 80000000
+
+  Example when 'fd-non-iso on' is added on this switchable CAN FD adapter:
+   can <FD,FD-NON-ISO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
 
   6.7 Supported CAN hardware
 
-- 
2.1.4

