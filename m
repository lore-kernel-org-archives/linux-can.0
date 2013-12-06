From: John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3] linux-can-next: Changes to Documentation (can.txt)
Date: Fri,  6 Dec 2013 12:49:08 +0000
Message-ID: <1386334148-20468-1-git-send-email-johnfwhitmore@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:46643 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757670Ab3LFMtp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2013 07:49:45 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so602019wes.13
        for <linux-can@vger.kernel.org>; Fri, 06 Dec 2013 04:49:44 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: socketcan@hartkopp.net, hardbyte@gmail.com, linux-can@vger.kernel.org
Cc: rob@landley.net, johnfwhitmore@gmail.com

Changed MAINTAINERS file to add Documentation/networking/can.txt to the list
of maintained files.

can.txt:
  - Globally changed Socket CAN to SocketCAN
  - Removed section 3.3 from the document
  - Updated Section 7
  - Corrected a few simple typos

Signed-off-by: johnfwhitmore@gmail.com
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 Documentation/networking/can.txt |   94 +++++++++++++++-----------------------
 MAINTAINERS                      |    1 +
 2 files changed, 38 insertions(+), 57 deletions(-)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index 4c07241..f3089d4 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -2,21 +2,20 @@
 
 can.txt
 
-Readme file for the Controller Area Network Protocol Family (aka Socket CAN)
+Readme file for the Controller Area Network Protocol Family (aka SocketCAN)
 
 This file contains
 
-  1 Overview / What is Socket CAN
+  1 Overview / What is SocketCAN
 
   2 Motivation / Why using the socket API
 
-  3 Socket CAN concept
+  3 SocketCAN concept
     3.1 receive lists
     3.2 local loopback of sent frames
-    3.3 network security issues (capabilities)
-    3.4 network problem notifications
+    3.3 network problem notifications
 
-  4 How to use Socket CAN
+  4 How to use SocketCAN
     4.1 RAW protocol sockets with can_filters (SOCK_RAW)
       4.1.1 RAW socket option CAN_RAW_FILTER
       4.1.2 RAW socket option CAN_RAW_ERR_FILTER
@@ -34,7 +33,7 @@ This file contains
     4.3 connected transport protocols (SOCK_SEQPACKET)
     4.4 unconnected transport protocols (SOCK_DGRAM)
 
-  5 Socket CAN core module
+  5 SocketCAN core module
     5.1 can.ko module params
     5.2 procfs content
     5.3 writing own CAN protocol modules
@@ -51,20 +50,20 @@ This file contains
     6.6 CAN FD (flexible data rate) driver support
     6.7 supported CAN hardware
 
-  7 Socket CAN resources
+  7 SocketCAN resources
 
   8 Credits
 
 ============================================================================
 
-1. Overview / What is Socket CAN
+1. Overview / What is SocketCAN
 --------------------------------
 
 The socketcan package is an implementation of CAN protocols
 (Controller Area Network) for Linux.  CAN is a networking technology
 which has widespread use in automation, embedded devices, and
 automotive fields.  While there have been other CAN implementations
-for Linux based on character devices, Socket CAN uses the Berkeley
+for Linux based on character devices, SocketCAN uses the Berkeley
 socket API, the Linux network stack and implements the CAN device
 drivers as network interfaces.  The CAN socket API has been designed
 as similar as possible to the TCP/IP protocols to allow programmers,
@@ -74,7 +73,7 @@ sockets.
 2. Motivation / Why using the socket API
 ----------------------------------------
 
-There have been CAN implementations for Linux before Socket CAN so the
+There have been CAN implementations for Linux before SocketCAN so the
 question arises, why we have started another project.  Most existing
 implementations come as a device driver for some CAN hardware, they
 are based on character devices and provide comparatively little
@@ -89,10 +88,10 @@ the CAN controller requires employment of another device driver and
 often the need for adaption of large parts of the application to the
 new driver's API.
 
-Socket CAN was designed to overcome all of these limitations.  A new
+SocketCAN was designed to overcome all of these limitations.  A new
 protocol family has been implemented which provides a socket interface
 to user space applications and which builds upon the Linux network
-layer, so to use all of the provided queueing functionality.  A device
+layer, enabling use all of the provided queueing functionality.  A device
 driver for CAN controller hardware registers itself with the Linux
 network layer as a network device, so that CAN frames from the
 controller can be passed up to the network layer and on to the CAN
@@ -146,15 +145,15 @@ solution for a couple of reasons:
   providing an API for device drivers to register with.  However, then
   it would be no more difficult, or may be even easier, to use the
   networking framework provided by the Linux kernel, and this is what
-  Socket CAN does.
+  SocketCAN does.
 
   The use of the networking framework of the Linux kernel is just the
   natural and most appropriate way to implement CAN for Linux.
 
-3. Socket CAN concept
+3. SocketCAN concept
 ---------------------
 
-  As described in chapter 2 it is the main goal of Socket CAN to
+  As described in chapter 2 it is the main goal of SocketCAN to
   provide a socket interface to user space applications which builds
   upon the Linux network layer. In contrast to the commonly known
   TCP/IP and ethernet networking, the CAN bus is a broadcast-only(!)
@@ -168,11 +167,11 @@ solution for a couple of reasons:
 
   The network transparent access of multiple applications leads to the
   problem that different applications may be interested in the same
-  CAN-IDs from the same CAN network interface. The Socket CAN core
+  CAN-IDs from the same CAN network interface. The SocketCAN core
   module - which implements the protocol family CAN - provides several
   high efficient receive lists for this reason. If e.g. a user space
   application opens a CAN RAW socket, the raw protocol module itself
-  requests the (range of) CAN-IDs from the Socket CAN core that are
+  requests the (range of) CAN-IDs from the SocketCAN core that are
   requested by the user. The subscription and unsubscription of
   CAN-IDs can be done for specific CAN interfaces or for all(!) known
   CAN interfaces with the can_rx_(un)register() functions provided to
@@ -217,21 +216,7 @@ solution for a couple of reasons:
   * = you really like to have this when you're running analyser tools
       like 'candump' or 'cansniffer' on the (same) node.
 
-  3.3 network security issues (capabilities)
-
-  The Controller Area Network is a local field bus transmitting only
-  broadcast messages without any routing and security concepts.
-  In the majority of cases the user application has to deal with
-  raw CAN frames. Therefore it might be reasonable NOT to restrict
-  the CAN access only to the user root, as known from other networks.
-  Since the currently implemented CAN_RAW and CAN_BCM sockets can only
-  send and receive frames to/from CAN interfaces it does not affect
-  security of others networks to allow all users to access the CAN.
-  To enable non-root users to access CAN_RAW and CAN_BCM protocol
-  sockets the Kconfig options CAN_RAW_USER and/or CAN_BCM_USER may be
-  selected at kernel compile time.
-
-  3.4 network problem notifications
+  3.3 network problem notifications
 
   The use of the CAN bus may lead to several problems on the physical
   and media access control layer. Detecting and logging of these lower
@@ -251,11 +236,11 @@ solution for a couple of reasons:
   by default. The format of the CAN error message frame is briefly
   described in the Linux header file "include/linux/can/error.h".
 
-4. How to use Socket CAN
+4. How to use SocketCAN
 ------------------------
 
   Like TCP/IP, you first need to open a socket for communicating over a
-  CAN network. Since Socket CAN implements a new protocol family, you
+  CAN network. Since SocketCAN implements a new protocol family, you
   need to pass PF_CAN as the first argument to the socket(2) system
   call. Currently, there are two CAN protocols to choose from, the raw
   socket protocol and the broadcast manager (BCM). So to open a socket,
@@ -286,8 +271,8 @@ solution for a couple of reasons:
     };
 
   The alignment of the (linear) payload data[] to a 64bit boundary
-  allows the user to define own structs and unions to easily access the
-  CAN payload. There is no given byteorder on the CAN bus by
+  allows the user to define their own structs and unions to easily access
+  the CAN payload. There is no given byteorder on the CAN bus by
   default. A read(2) system call on a CAN_RAW socket transfers a
   struct can_frame to the user space.
 
@@ -479,7 +464,7 @@ solution for a couple of reasons:
 
     setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);
 
-  To set the filters to zero filters is quite obsolete as not read
+  To set the filters to zero filters is quite obsolete as to not read
   data causes the raw socket to discard the received CAN frames. But
   having this 'send only' use-case we may remove the receive list in the
   Kernel to save a little (really a very little!) CPU usage.
@@ -814,17 +799,17 @@ solution for a couple of reasons:
   4.4 unconnected transport protocols (SOCK_DGRAM)
 
 
-5. Socket CAN core module
+5. SocketCAN core module
 -------------------------
 
-  The Socket CAN core module implements the protocol family
+  The SocketCAN core module implements the protocol family
   PF_CAN. CAN protocol modules are loaded by the core module at
   runtime. The core module provides an interface for CAN protocol
   modules to subscribe needed CAN IDs (see chapter 3.1).
 
   5.1 can.ko module params
 
-  - stats_timer: To calculate the Socket CAN core statistics
+  - stats_timer: To calculate the SocketCAN core statistics
     (e.g. current/maximum frames per second) this 1 second timer is
     invoked at can.ko module start time by default. This timer can be
     disabled by using stattimer=0 on the module commandline.
@@ -833,7 +818,7 @@ solution for a couple of reasons:
 
   5.2 procfs content
 
-  As described in chapter 3.1 the Socket CAN core uses several filter
+  As described in chapter 3.1 the SocketCAN core uses several filter
   lists to deliver received CAN frames to CAN protocol modules. These
   receive lists, their filters and the count of filter matches can be
   checked in the appropriate receive list. All entries contain the
@@ -860,15 +845,15 @@ solution for a couple of reasons:
 
   Additional procfs files in /proc/net/can
 
-    stats       - Socket CAN core statistics (rx/tx frames, match ratios, ...)
+    stats       - SocketCAN core statistics (rx/tx frames, match ratios, ...)
     reset_stats - manual statistic reset
-    version     - prints the Socket CAN core version and the ABI version
+    version     - prints the SocketCAN core version and the ABI version
 
   5.3 writing own CAN protocol modules
 
   To implement a new protocol in the protocol family PF_CAN a new
   protocol has to be defined in include/linux/can.h .
-  The prototypes and definitions to use the Socket CAN core can be
+  The prototypes and definitions to use the SocketCAN core can be
   accessed by including include/linux/can/core.h .
   In addition to functions that register the CAN protocol and the
   CAN device notifier chain there are functions to subscribe CAN
@@ -1105,7 +1090,7 @@ solution for a couple of reasons:
 
     $ ip link set canX up type can bitrate 125000
 
-  A device may enter the "bus-off" state if too much errors occurred on
+  A device may enter the "bus-off" state if too many errors occurred on
   the CAN bus. Then no more messages are received or sent. An automatic
   bus-off recovery can be enabled by setting the "restart-ms" to a
   non-zero value, e.g.:
@@ -1125,7 +1110,7 @@ solution for a couple of reasons:
 
   CAN FD capable CAN controllers support two different bitrates for the
   arbitration phase and the payload phase of the CAN FD frame. Therefore a
-  second bittiming has to be specified in order to enable the CAN FD bitrate.
+  second bit timing has to be specified in order to enable the CAN FD bitrate.
 
   Additionally CAN FD capable CAN controllers support up to 64 bytes of
   payload. The representation of this length in can_frame.can_dlc and
@@ -1150,21 +1135,16 @@ solution for a couple of reasons:
   6.7 Supported CAN hardware
 
   Please check the "Kconfig" file in "drivers/net/can" to get an actual
-  list of the support CAN hardware. On the Socket CAN project website
+  list of the support CAN hardware. On the SocketCAN project website
   (see chapter 7) there might be further drivers available, also for
   older kernel versions.
 
-7. Socket CAN resources
+7. SocketCAN resources
 -----------------------
 
-  You can find further resources for Socket CAN like user space tools,
-  support for old kernel versions, more drivers, mailing lists, etc.
-  at the BerliOS OSS project website for Socket CAN:
-
-    http://developer.berlios.de/projects/socketcan
-
-  If you have questions, bug fixes, etc., don't hesitate to post them to
-  the Socketcan-Users mailing list. But please search the archives first.
+  The Linux CAN / SocketCAN project ressources (project site / mailing list)
+  are referenced in the MAINTAINERS file in the Linux source tree.
+  Search for CAN NETWORK [LAYERS|DRIVERS].
 
 8. Credits
 ----------
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

