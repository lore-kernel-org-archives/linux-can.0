From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: add documentation about CAN FD controller specific configuration
Date: Thu, 17 Sep 2015 21:58:46 +0200
Message-ID: <1442519926-4506-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:22589 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbbIQT7D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Sep 2015 15:59:03 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 Documentation/networking/can.txt | 75 +++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 20 deletions(-)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index fd1a1aa..56bad15 100644
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
 
@@ -1178,7 +1187,33 @@ solution for a couple of reasons:
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
 
   6.7 Supported CAN hardware
 
-- 
2.1.4

