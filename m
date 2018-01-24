From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH] can: migrate documentation to restructured text
Date: Wed, 24 Jan 2018 11:23:31 +0100
Message-ID: <20180124102331.sztnwpm3ojrefca5@pengutronix.de>
References: <20180124101911.18006-1-r.schwebel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36319 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932775AbeAXKXe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Jan 2018 05:23:34 -0500
Content-Disposition: inline
In-Reply-To: <20180124101911.18006-1-r.schwebel@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-doc@vger.kernel.org

On Wed, Jan 24, 2018 at 11:19:11AM +0100, Robert Schwebel wrote:
> This patch doesn't do any content change.

For easier review, here is the 'git diff -w' output that ignores rst
related whitespace changes:

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index aa15b9ee2e70..d23c51abf8c6 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -1,65 +1,9 @@
-============================================================================
-
-can.txt
-
-Readme file for the Controller Area Network Protocol Family (aka SocketCAN)
-
-This file contains
-
-  1 Overview / What is SocketCAN
-
-  2 Motivation / Why using the socket API
-
-  3 SocketCAN concept
-    3.1 receive lists
-    3.2 local loopback of sent frames
-    3.3 network problem notifications
-
-  4 How to use SocketCAN
-    4.1 RAW protocol sockets with can_filters (SOCK_RAW)
-      4.1.1 RAW socket option CAN_RAW_FILTER
-      4.1.2 RAW socket option CAN_RAW_ERR_FILTER
-      4.1.3 RAW socket option CAN_RAW_LOOPBACK
-      4.1.4 RAW socket option CAN_RAW_RECV_OWN_MSGS
-      4.1.5 RAW socket option CAN_RAW_FD_FRAMES
-      4.1.6 RAW socket option CAN_RAW_JOIN_FILTERS
-      4.1.7 RAW socket returned message flags
-    4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
-      4.2.1 Broadcast Manager operations
-      4.2.2 Broadcast Manager message flags
-      4.2.3 Broadcast Manager transmission timers
-      4.2.4 Broadcast Manager message sequence transmission
-      4.2.5 Broadcast Manager receive filter timers
-      4.2.6 Broadcast Manager multiplex message receive filter
-      4.2.7 Broadcast Manager CAN FD support
-    4.3 connected transport protocols (SOCK_SEQPACKET)
-    4.4 unconnected transport protocols (SOCK_DGRAM)
-
-  5 SocketCAN core module
-    5.1 can.ko module params
-    5.2 procfs content
-    5.3 writing own CAN protocol modules
-
-  6 CAN network drivers
-    6.1 general settings
-    6.2 local loopback of sent frames
-    6.3 CAN controller hardware filters
-    6.4 The virtual CAN driver (vcan)
-    6.5 The CAN network device driver interface
-      6.5.1 Netlink interface to set/get devices properties
-      6.5.2 Setting the CAN bit-timing
-      6.5.3 Starting and stopping the CAN network device
-    6.6 CAN FD (flexible data rate) driver support
-    6.7 supported CAN hardware
-
-  7 SocketCAN resources
-
-  8 Credits
-
-============================================================================
-
-1. Overview / What is SocketCAN
---------------------------------
+===================================
+SocketCAN - Controller Area Network
+===================================
+
+Overview / What is SocketCAN
+============================
 
 The socketcan package is an implementation of CAN protocols
 (Controller Area Network) for Linux.  CAN is a networking technology
@@ -72,8 +16,11 @@ as similar as possible to the TCP/IP protocols to allow programmers,
 familiar with network programming, to easily learn how to use CAN
 sockets.
 
-2. Motivation / Why using the socket API
-----------------------------------------
+
+.. _socketcan-motivation:
+
+Motivation / Why Using the Socket API
+=====================================
 
 There have been CAN implementations for Linux before SocketCAN so the
 question arises, why we have started another project.  Most existing
@@ -116,15 +63,15 @@ Similar functionality visible from user-space could be provided by a
 character device, too, but this would lead to a technically inelegant
 solution for a couple of reasons:
 
-* Intricate usage.  Instead of passing a protocol argument to
+* **Intricate usage:**  Instead of passing a protocol argument to
   socket(2) and using bind(2) to select a CAN interface and CAN ID, an
   application would have to do all these operations using ioctl(2)s.
 
-* Code duplication.  A character device cannot make use of the Linux
+* **Code duplication:**  A character device cannot make use of the Linux
   network queueing code, so all that code would have to be duplicated
   for CAN networking.
 
-* Abstraction.  In most existing character-device implementations, the
+* **Abstraction:**  In most existing character-device implementations, the
   hardware-specific device driver for a CAN controller directly
   provides the character device for the application to work with.
   This is at least very unusual in Unix systems for both, char and
@@ -152,10 +99,13 @@ solution for a couple of reasons:
 The use of the networking framework of the Linux kernel is just the
 natural and most appropriate way to implement CAN for Linux.
 
-3. SocketCAN concept
----------------------
 
-  As described in chapter 2 it is the main goal of SocketCAN to
+.. _socketcan-concept:
+
+SocketCAN Concept
+=================
+
+As described in :ref:`socketcan-motivation` the main goal of SocketCAN is to
 provide a socket interface to user space applications which builds
 upon the Linux network layer. In contrast to the commonly known
 TCP/IP and ethernet networking, the CAN bus is a broadcast-only(!)
@@ -165,7 +115,11 @@ solution for a couple of reasons:
 network the CAN-IDs are mapped to be sent by a specific ECU.
 For this reason a CAN-ID can be treated best as a kind of source address.
 
-  3.1 receive lists
+
+.. _socketcan-receive-lists:
+
+Receive Lists
+-------------
 
 The network transparent access of multiple applications leads to the
 problem that different applications may be interested in the same
@@ -177,17 +131,23 @@ solution for a couple of reasons:
 requested by the user. The subscription and unsubscription of
 CAN-IDs can be done for specific CAN interfaces or for all(!) known
 CAN interfaces with the can_rx_(un)register() functions provided to
-  CAN protocol modules by the SocketCAN core (see chapter 5).
+CAN protocol modules by the SocketCAN core (see :ref:`socketcan-core-module`).
 To optimize the CPU usage at runtime the receive lists are split up
 into several specific lists per device that match the requested
 filter complexity for a given use-case.
 
-  3.2 local loopback of sent frames
+
+.. _socketcan-local-loopback1:
+
+Local Loopback of Sent Frames
+-----------------------------
 
 As known from other networking concepts the data exchanging
 applications may run on the same or different nodes without any
 change (except for the according addressing information):
 
+.. code::
+
 	 ___   ___   ___                   _______   ___
 	| _ | | _ | | _ |                 | _   _ | | _ |
 	||A|| ||B|| ||C||                 ||A| |B|| ||C||
@@ -204,21 +164,25 @@ solution for a couple of reasons:
 transmission and reception of media dependent frames. Due to the
 arbitration on the CAN bus the transmission of a low prio CAN-ID
 may be delayed by the reception of a high prio CAN frame. To
-  reflect the correct* traffic on the node the loopback of the sent
+reflect the correct [*]_ traffic on the node the loopback of the sent
 data has to be performed right after a successful transmission. If
 the CAN network interface is not capable of performing the loopback for
 some reason the SocketCAN core can do this task as a fallback solution.
-  See chapter 6.2 for details (recommended).
+See :ref:`socketcan-local-loopback1` for details (recommended).
 
 The loopback functionality is enabled by default to reflect standard
 networking behaviour for CAN applications. Due to some requests from
 the RT-SocketCAN group the loopback optionally may be disabled for each
-  separate socket. See sockopts from the CAN RAW sockets in chapter 4.1.
+separate socket. See sockopts from the CAN RAW sockets in :ref:`socketcan-raw-sockets`.
 
-  * = you really like to have this when you're running analyser tools
-      like 'candump' or 'cansniffer' on the (same) node.
+.. [*] you really like to have this when you're running analyser
+       tools like 'candump' or 'cansniffer' on the (same) node.
 
-  3.3 network problem notifications
+
+.. _socketcan-network-problem-notifications:
+
+Network Problem Notifications
+-----------------------------
 
 The use of the CAN bus may lead to several problems on the physical
 and media access control layer. Detecting and logging of these lower
@@ -238,26 +202,27 @@ solution for a couple of reasons:
 by default. The format of the CAN error message frame is briefly
 described in the Linux header file "include/uapi/linux/can/error.h".
 
-4. How to use SocketCAN
-------------------------
+
+How to use SocketCAN
+====================
 
 Like TCP/IP, you first need to open a socket for communicating over a
 CAN network. Since SocketCAN implements a new protocol family, you
 need to pass PF_CAN as the first argument to the socket(2) system
 call. Currently, there are two CAN protocols to choose from, the raw
 socket protocol and the broadcast manager (BCM). So to open a socket,
-  you would write
+you would write::
 
     s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
 
-  and
+and::
 
     s = socket(PF_CAN, SOCK_DGRAM, CAN_BCM);
 
 respectively.  After the successful creation of the socket, you would
 normally use the bind(2) system call to bind the socket to a CAN
 interface (which is different from TCP/IP due to different addressing
-  - see chapter 3). After binding (CAN_RAW) or connecting (CAN_BCM)
+- see :ref:`socketcan-concept`). After binding (CAN_RAW) or connecting (CAN_BCM)
 the socket, you can read(2) and write(2) from/to the socket or use
 send(2), sendto(2), sendmsg(2) and the recv* counterpart operations
 on the socket as usual. There are also CAN specific socket options
@@ -266,6 +231,8 @@ solution for a couple of reasons:
 The basic CAN frame structure and the sockaddr structure are defined
 in include/linux/can.h:
 
+.. code-block:: C
+
     struct can_frame {
             canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
             __u8    can_dlc; /* frame payload length in byte (0 .. 8) */
@@ -284,6 +251,8 @@ solution for a couple of reasons:
 The sockaddr_can structure has an interface index like the
 PF_PACKET socket, that also binds to a specific interface:
 
+.. code-block:: C
+
     struct sockaddr_can {
             sa_family_t can_family;
             int         can_ifindex;
@@ -298,6 +267,8 @@ solution for a couple of reasons:
 To determine the interface index an appropriate ioctl() has to
 be used (example for CAN_RAW sockets without error checking):
 
+.. code-block:: C
+
     int s;
     struct sockaddr_can addr;
     struct ifreq ifr;
@@ -324,6 +295,8 @@ solution for a couple of reasons:
 Reading CAN frames from a bound CAN_RAW socket (see above) consists
 of reading a struct can_frame:
 
+.. code-block:: C
+
     struct can_frame frame;
 
     nbytes = read(s, &frame, sizeof(struct can_frame));
@@ -341,7 +314,7 @@ solution for a couple of reasons:
 
     /* do something with the received CAN frame */
 
-  Writing CAN frames can be done similarly, with the write(2) system call:
+Writing CAN frames can be done similarly, with the write(2) system call::
 
     nbytes = write(s, &frame, sizeof(struct can_frame));
 
@@ -349,6 +322,8 @@ solution for a couple of reasons:
 (addr.can_ifindex = 0) it is recommended to use recvfrom(2) if the
 information about the originating CAN interface is needed:
 
+.. code-block:: C
+
     struct sockaddr_can addr;
     struct ifreq ifr;
     socklen_t len = sizeof(addr);
@@ -363,7 +338,9 @@ solution for a couple of reasons:
     printf("Received a CAN frame from interface %s", ifr.ifr_name);
 
 To write CAN frames on sockets bound to 'any' CAN interface the
-  outgoing interface has to be defined certainly.
+outgoing interface has to be defined certainly:
+
+.. code-block:: C
 
     strcpy(ifr.ifr_name, "can0");
     ioctl(s, SIOCGIFINDEX, &ifr);
@@ -376,6 +353,8 @@ solution for a couple of reasons:
 An accurate timestamp can be obtained with an ioctl(2) call after reading
 a message from the socket:
 
+.. code-block:: C
+
     struct timeval tv;
     ioctl(s, SIOCGSTAMP, &tv);
 
@@ -392,10 +371,12 @@ solution for a couple of reasons:
 bytes of payload (struct can_frame) like the CAN_RAW socket. Therefore e.g.
 the CAN_RAW socket supports a new socket option CAN_RAW_FD_FRAMES that
 switches the socket into a mode that allows the handling of CAN FD frames
-  and (legacy) CAN frames simultaneously (see section 4.1.5).
+and (legacy) CAN frames simultaneously (see :ref:`socketcan-rawfd`).
 
 The struct canfd_frame is defined in include/linux/can.h:
 
+.. code-block:: C
+
     struct canfd_frame {
             canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
             __u8    len;     /* frame payload length in byte (0 .. 64) */
@@ -418,16 +399,22 @@ solution for a couple of reasons:
 contains a plain length value from 0 .. 64. So both canfd_frame.len and
 can_frame.can_dlc are equal and contain a length information and no DLC.
 For details about the distinction of CAN and CAN FD capable devices and
-  the mapping to the bus-relevant data length code (DLC), see chapter 6.6.
+the mapping to the bus-relevant data length code (DLC), see :ref:`socketcan-can-fd-driver`.
 
 The length of the two CAN(FD) frame structures define the maximum transfer
 unit (MTU) of the CAN(FD) network interface and skbuff data length. Two
 definitions are specified for CAN specific MTUs in include/linux/can.h:
 
+.. code-block:: C
+
   #define CAN_MTU   (sizeof(struct can_frame))   == 16  => 'legacy' CAN frame
   #define CANFD_MTU (sizeof(struct canfd_frame)) == 72  => CAN FD frame
 
-  4.1 RAW protocol sockets with can_filters (SOCK_RAW)
+
+.. _socketcan-raw-sockets:
+
+RAW Protocol Sockets with can_filters (SOCK_RAW)
+------------------------------------------------
 
 Using CAN_RAW sockets is extensively comparable to the commonly
 known access to CAN character devices. To meet the new possibilities
@@ -436,26 +423,34 @@ solution for a couple of reasons:
 
 - The filters are set to exactly one filter receiving everything
 - The socket only receives valid data frames (=> no error message frames)
-  - The loopback of sent CAN frames is enabled (see chapter 3.2)
+- The loopback of sent CAN frames is enabled (see :ref:`socketcan-local-loopback2`)
 - The socket does not receive its own sent frames (in loopback mode)
 
 These default settings may be changed before or after binding the socket.
 To use the referenced definitions of the socket options for CAN_RAW
 sockets, include <linux/can/raw.h>.
 
-  4.1.1 RAW socket option CAN_RAW_FILTER
+
+.. _socketcan-rawfilter:
+
+RAW socket option CAN_RAW_FILTER
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The reception of CAN frames using CAN_RAW sockets can be controlled
 by defining 0 .. n filters with the CAN_RAW_FILTER socket option.
 
 The CAN filter structure is defined in include/linux/can.h:
 
+.. code-block:: C
+
     struct can_filter {
             canid_t can_id;
             canid_t can_mask;
     };
 
-  A filter matches, when
+A filter matches, when:
+
+.. code-block:: C
 
     <received_can_id> & mask == can_id & mask
 
@@ -465,6 +460,8 @@ solution for a couple of reasons:
 contrast to CAN controller hardware filters the user may set 0 .. n
 receive filters for each open socket separately:
 
+.. code-block:: C
+
     struct can_filter rfilter[2];
 
     rfilter[0].can_id   = 0x123;
@@ -476,6 +473,8 @@ solution for a couple of reasons:
 
 To disable the reception of CAN frames on the selected CAN_RAW socket:
 
+.. code-block:: C
+
     setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);
 
 To set the filters to zero filters is quite obsolete as to not read
@@ -483,7 +482,8 @@ solution for a couple of reasons:
 having this 'send only' use-case we may remove the receive list in the
 Kernel to save a little (really a very little!) CPU usage.
 
-  4.1.1.1 CAN filter usage optimisation
+CAN Filter Usage Optimisation
+.............................
 
 The CAN filters are processed in per-device filter lists at CAN frame
 reception time. To reduce the number of checks that need to be performed
@@ -499,7 +499,9 @@ solution for a couple of reasons:
 CAN_SFF_MASK or CAN_EFF_MASK have to be set into can_filter.mask together
 with set CAN_EFF_FLAG and CAN_RTR_FLAG bits. A set CAN_EFF_FLAG bit in the
 can_filter.mask makes clear that it matters whether a SFF or EFF CAN ID is
-  subscribed. E.g. in the example from above
+subscribed. E.g. in the example from above:
+
+.. code-block:: C
 
     rfilter[0].can_id   = 0x123;
     rfilter[0].can_mask = CAN_SFF_MASK;
@@ -509,6 +511,8 @@ solution for a couple of reasons:
 To filter for only 0x123 (SFF) and 0x12345678 (EFF) CAN identifiers the
 filter has to be defined in this way to benefit from the optimized filters:
 
+.. code-block:: C
+
     struct can_filter rfilter[2];
 
     rfilter[0].can_id   = 0x123;
@@ -518,33 +522,43 @@ solution for a couple of reasons:
 
     setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, &rfilter, sizeof(rfilter));
 
-  4.1.2 RAW socket option CAN_RAW_ERR_FILTER
 
-  As described in chapter 3.3 the CAN interface driver can generate so
+RAW Socket Option CAN_RAW_ERR_FILTER
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+As described in :ref:`socketcan-network-problem-notifications` the CAN interface driver can generate so
 called Error Message Frames that can optionally be passed to the user
 application in the same way as other CAN frames. The possible
 errors are divided into different error classes that may be filtered
 using the appropriate error mask. To register for every possible
 error condition CAN_ERR_MASK can be used as value for the error mask.
-  The values for the error mask are defined in linux/can/error.h .
+The values for the error mask are defined in linux/can/error.h:
+
+.. code-block:: C
 
     can_err_mask_t err_mask = ( CAN_ERR_TX_TIMEOUT | CAN_ERR_BUSOFF );
 
     setsockopt(s, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
                &err_mask, sizeof(err_mask));
 
-  4.1.3 RAW socket option CAN_RAW_LOOPBACK
+
+RAW Socket Option CAN_RAW_LOOPBACK
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 To meet multi user needs the local loopback is enabled by default
-  (see chapter 3.2 for details). But in some embedded use-cases
+(see :ref:`socketcan-local-loopback1` for details). But in some embedded use-cases
 (e.g. when only one application uses the CAN bus) this loopback
 functionality can be disabled (separately for each socket):
 
+.. code-block:: C
+
     int loopback = 0; /* 0 = disabled, 1 = enabled (default) */
 
     setsockopt(s, SOL_CAN_RAW, CAN_RAW_LOOPBACK, &loopback, sizeof(loopback));
 
-  4.1.4 RAW socket option CAN_RAW_RECV_OWN_MSGS
+
+RAW socket option CAN_RAW_RECV_OWN_MSGS
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 When the local loopback is enabled, all the sent CAN frames are
 looped back to the open CAN sockets that registered for the CAN
@@ -554,12 +568,18 @@ solution for a couple of reasons:
 disabled by default. This default behaviour may be changed on
 demand:
 
+.. code-block:: C
+
     int recv_own_msgs = 1; /* 0 = disabled (default), 1 = enabled */
 
     setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS,
                &recv_own_msgs, sizeof(recv_own_msgs));
 
-  4.1.5 RAW socket option CAN_RAW_FD_FRAMES
+
+.. _socketcan-rawfd:
+
+RAW Socket Option CAN_RAW_FD_FRAMES
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 CAN FD support in CAN_RAW sockets can be enabled with a new socket option
 CAN_RAW_FD_FRAMES which is off by default. When the new socket option is
@@ -568,12 +588,17 @@ solution for a couple of reasons:
 
 Once CAN_RAW_FD_FRAMES is enabled the application can send both CAN frames
 and CAN FD frames. OTOH the application has to handle CAN and CAN FD frames
-  when reading from the socket.
+when reading from the socket:
+
+.. code-block:: C
 
     CAN_RAW_FD_FRAMES enabled:  CAN_MTU and CANFD_MTU are allowed
     CAN_RAW_FD_FRAMES disabled: only CAN_MTU is allowed (default)
 
 Example:
+
+.. code-block:: C
+
     [ remember: CANFD_MTU == sizeof(struct canfd_frame) ]
 
     struct canfd_frame cfd;
@@ -615,12 +640,14 @@ solution for a couple of reasons:
 CAN FD frames by checking if the device maximum transfer unit is CANFD_MTU.
 The CAN device MTU can be retrieved e.g. with a SIOCGIFMTU ioctl() syscall.
 
-  4.1.6 RAW socket option CAN_RAW_JOIN_FILTERS
+
+RAW socket option CAN_RAW_JOIN_FILTERS
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The CAN_RAW socket can set multiple CAN identifier specific filters that
 lead to multiple filters in the af_can.c filter processing. These filters
 are indenpendent from each other which leads to logical OR'ed filters when
-  applied (see 4.1.1).
+applied (see :ref:`socketcan-rawfilter`).
 
 This socket option joines the given CAN filters in the way that only CAN
 frames are passed to user space that matched *all* given CAN filters. The
@@ -630,18 +657,25 @@ solution for a couple of reasons:
 where the CAN_INV_FILTER flag is set in order to notch single CAN IDs or
 CAN ID ranges from the incoming traffic.
 
-  4.1.7 RAW socket returned message flags
+
+RAW Socket Returned Message Flags
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 When using recvmsg() call, the msg->msg_flags may contain following flags:
 
-    MSG_DONTROUTE: set when the received frame was created on the local host.
+MSG_DONTROUTE:
+	set when the received frame was created on the local host.
 
-    MSG_CONFIRM: set when the frame was sent via the socket it is received on.
+MSG_CONFIRM:
+	set when the frame was sent via the socket it is received on.
 	This flag can be interpreted as a 'transmission confirmation' when the
-      CAN driver supports the echo of frames on driver level, see 3.2 and 6.2.
+	CAN driver supports the echo of frames on driver level, see
+	:ref:`socketcan-local-loopback1` and :ref:`socketcan-local-loopback2`.
 	In order to receive such messages, CAN_RAW_RECV_OWN_MSGS must be set.
 
-  4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
+
+Broadcast Manager Protocol Sockets (SOCK_DGRAM)
+-----------------------------------------------
 
 The Broadcast Manager protocol provides a command based configuration
 interface to filter and send (e.g. cyclic) CAN messages in kernel space.
@@ -662,6 +696,8 @@ solution for a couple of reasons:
 message header with a command ('opcode') followed by zero or more CAN frames.
 The broadcast manager sends responses to user space in the same form:
 
+.. code-block:: C
+
     struct bcm_msg_head {
             __u32 opcode;                   /* command */
             __u32 flags;                    /* special flags */
@@ -673,12 +709,14 @@ solution for a couple of reasons:
     };
 
 The aligned payload 'frames' uses the same basic CAN frame structure defined
-  at the beginning of section 4 and in the include/linux/can.h include. All
+at the beginning of :ref:`socketcan-rawfd` and in the include/linux/can.h include. All
 messages to the broadcast manager from user space have this structure.
 
 Note a CAN_BCM socket must be connected instead of bound after socket
 creation (example without error checking):
 
+.. code-block:: C
+
     int s;
     struct sockaddr_can addr;
     struct ifreq ifr;
@@ -705,7 +743,9 @@ solution for a couple of reasons:
 interface index. When using recvfrom() instead of read() to retrieve BCM
 socket messages the originating CAN interface is provided in can_ifindex.
 
-  4.2.1 Broadcast Manager operations
+
+Broadcast Manager Operations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The opcode defines the operation for the broadcast manager to carry out,
 or details the broadcast managers response to several events, including
@@ -713,71 +753,98 @@ solution for a couple of reasons:
 
 Transmit Operations (user space to broadcast manager):
 
-    TX_SETUP:   Create (cyclic) transmission task.
+TX_SETUP:
+	Create (cyclic) transmission task.
 
-    TX_DELETE:  Remove (cyclic) transmission task, requires only can_id.
+TX_DELETE:
+	Remove (cyclic) transmission task, requires only can_id.
 
-    TX_READ:    Read properties of (cyclic) transmission task for can_id.
+TX_READ:
+	Read properties of (cyclic) transmission task for can_id.
 
-    TX_SEND:    Send one CAN frame.
+TX_SEND:
+	Send one CAN frame.
 
 Transmit Responses (broadcast manager to user space):
 
-    TX_STATUS:  Reply to TX_READ request (transmission task configuration).
+TX_STATUS:
+	Reply to TX_READ request (transmission task configuration).
 
-    TX_EXPIRED: Notification when counter finishes sending at initial interval
+TX_EXPIRED:
+	Notification when counter finishes sending at initial interval
 	'ival1'. Requires the TX_COUNTEVT flag to be set at TX_SETUP.
 
 Receive Operations (user space to broadcast manager):
 
-    RX_SETUP:   Create RX content filter subscription.
+RX_SETUP:
+	Create RX content filter subscription.
 
-    RX_DELETE:  Remove RX content filter subscription, requires only can_id.
+RX_DELETE:
+	Remove RX content filter subscription, requires only can_id.
 
-    RX_READ:    Read properties of RX content filter subscription for can_id.
+RX_READ:
+	Read properties of RX content filter subscription for can_id.
 
 Receive Responses (broadcast manager to user space):
 
-    RX_STATUS:  Reply to RX_READ request (filter task configuration).
+RX_STATUS:
+	Reply to RX_READ request (filter task configuration).
 
-    RX_TIMEOUT: Cyclic message is detected to be absent (timer ival1 expired).
+RX_TIMEOUT:
+	Cyclic message is detected to be absent (timer ival1 expired).
 
-    RX_CHANGED: BCM message with updated CAN frame (detected content change).
+RX_CHANGED:
+	BCM message with updated CAN frame (detected content change).
 	Sent on first message received or on receipt of revised CAN messages.
 
-  4.2.2 Broadcast Manager message flags
+
+Broadcast Manager Message Flags
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 When sending a message to the broadcast manager the 'flags' element may
 contain the following flag definitions which influence the behaviour:
 
-    SETTIMER:           Set the values of ival1, ival2 and count
+SETTIMER:
+	Set the values of ival1, ival2 and count
 
-    STARTTIMER:         Start the timer with the actual values of ival1, ival2
+STARTTIMER:
+	Start the timer with the actual values of ival1, ival2
 	and count. Starting the timer leads simultaneously to emit a CAN frame.
 
-    TX_COUNTEVT:        Create the message TX_EXPIRED when count expires
+TX_COUNTEVT:
+	Create the message TX_EXPIRED when count expires
 
-    TX_ANNOUNCE:        A change of data by the process is emitted immediately.
+TX_ANNOUNCE:
+	A change of data by the process is emitted immediately.
 
-    TX_CP_CAN_ID:       Copies the can_id from the message header to each
+TX_CP_CAN_ID:
+	Copies the can_id from the message header to each
 	subsequent frame in frames. This is intended as usage simplification. For
 	TX tasks the unique can_id from the message header may differ from the
 	can_id(s) stored for transmission in the subsequent struct can_frame(s).
 
-    RX_FILTER_ID:       Filter by can_id alone, no frames required (nframes=0).
+RX_FILTER_ID:
+	Filter by can_id alone, no frames required (nframes=0).
 
-    RX_CHECK_DLC:       A change of the DLC leads to an RX_CHANGED.
+RX_CHECK_DLC:
+	A change of the DLC leads to an RX_CHANGED.
 
-    RX_NO_AUTOTIMER:    Prevent automatically starting the timeout monitor.
+RX_NO_AUTOTIMER:
+	Prevent automatically starting the timeout monitor.
 
-    RX_ANNOUNCE_RESUME: If passed at RX_SETUP and a receive timeout occurred, a
+RX_ANNOUNCE_RESUME:
+	If passed at RX_SETUP and a receive timeout occurred, a
 	RX_CHANGED message will be generated when the (cyclic) receive restarts.
 
-    TX_RESET_MULTI_IDX: Reset the index for the multiple frame transmission.
+TX_RESET_MULTI_IDX:
+	Reset the index for the multiple frame transmission.
+
+RX_RTR_FRAME:
+	Send reply for RTR-request (placed in op->frames[0]).
 
-    RX_RTR_FRAME:       Send reply for RTR-request (placed in op->frames[0]).
 
-  4.2.3 Broadcast Manager transmission timers
+Broadcast Manager Transmission Timers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Periodic transmission configurations may use up to two interval timers.
 In this case the BCM sends a number of messages ('count') at an interval
@@ -786,12 +853,16 @@ solution for a couple of reasons:
 When SET_TIMER and START_TIMER flag were set the timers are activated.
 The timer values can be altered at runtime when only SET_TIMER is set.
 
-  4.2.4 Broadcast Manager message sequence transmission
+
+Broadcast Manager message sequence transmission
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Up to 256 CAN frames can be transmitted in a sequence in the case of a cyclic
 TX task configuration. The number of CAN frames is provided in the 'nframes'
 element of the BCM message head. The defined number of CAN frames are added
-  as array to the TX_SETUP BCM configuration message.
+as array to the TX_SETUP BCM configuration message:
+
+.. code-block:: C
 
     /* create a struct to set up a sequence of four CAN frames */
     struct {
@@ -808,21 +879,26 @@ solution for a couple of reasons:
 With every transmission the index in the array of CAN frames is increased
 and set to zero at index overflow.
 
-  4.2.5 Broadcast Manager receive filter timers
+
+Broadcast Manager Receive Filter Timers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The timer values ival1 or ival2 may be set to non-zero values at RX_SETUP.
 When the SET_TIMER flag is set the timers are enabled:
 
-  ival1: Send RX_TIMEOUT when a received message is not received again within
+ival1:
+	Send RX_TIMEOUT when a received message is not received again within
 	the given time. When START_TIMER is set at RX_SETUP the timeout detection
 	is activated directly - even without a former CAN frame reception.
 
-  ival2: Throttle the received message rate down to the value of ival2. This
+ival2:
+	Throttle the received message rate down to the value of ival2. This
 	is useful to reduce messages for the application when the signal inside the
 	CAN frame is stateless as state changes within the ival2 periode may get
 	lost.
 
-  4.2.6 Broadcast Manager multiplex message receive filter
+Broadcast Manager Multiplex Message Receive Filter
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 To filter for content changes in multiplex message sequences an array of more
 than one CAN frames can be passed in a RX_SETUP configuration message. The
@@ -831,7 +907,9 @@ solution for a couple of reasons:
 If one of the subsequent CAN frames is matching the bits in that frame data
 mark the relevant content to be compared with the previous received content.
 Up to 257 CAN frames (multiplex filter bit mask CAN frame plus 256 CAN
-  filters) can be added as array to the TX_SETUP BCM configuration message.
+filters) can be added as array to the TX_SETUP BCM configuration message:
+
+.. code-block:: C
 
     /* usually used to clear CAN frame data[] - beware of endian problems! */
     #define U64_DATA(p) (*(unsigned long long*)(p)->data)
@@ -853,13 +931,17 @@ solution for a couple of reasons:
 
     write(s, &msg, sizeof(msg));
 
-  4.2.7 Broadcast Manager CAN FD support
+
+Broadcast Manager CAN FD Support
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The programming API of the CAN_BCM depends on struct can_frame which is
 given as array directly behind the bcm_msg_head structure. To follow this
 schema for the CAN FD frames a new flag 'CAN_FD_FRAME' in the bcm_msg_head
 flags indicates that the concatenated CAN frame structures behind the
-  bcm_msg_head are defined as struct canfd_frame.
+bcm_msg_head are defined as struct canfd_frame:
+
+.. code-block:: C
 
     struct {
             struct bcm_msg_head msg_head;
@@ -875,34 +957,51 @@ solution for a couple of reasons:
 When using CAN FD frames for multiplex filtering the MUX mask is still
 expected in the first 64 bit of the struct canfd_frame data section.
 
-  4.3 connected transport protocols (SOCK_SEQPACKET)
-  4.4 unconnected transport protocols (SOCK_DGRAM)
+
+Connected Transport Protocols (SOCK_SEQPACKET)
+----------------------------------------------
+
+(to be written)
 
 
-5. SocketCAN core module
--------------------------
+Unconnected Transport Protocols (SOCK_DGRAM)
+--------------------------------------------
+
+(to be written)
+
+
+.. _socketcan-core-module:
+
+SocketCAN Core Module
+=====================
 
 The SocketCAN core module implements the protocol family
 PF_CAN. CAN protocol modules are loaded by the core module at
 runtime. The core module provides an interface for CAN protocol
-  modules to subscribe needed CAN IDs (see chapter 3.1).
+modules to subscribe needed CAN IDs (see :ref:`socketcan-receive-lists`).
+
 
-  5.1 can.ko module params
+can.ko Module Params
+--------------------
 
-  - stats_timer: To calculate the SocketCAN core statistics
+- **stats_timer**:
+  To calculate the SocketCAN core statistics
   (e.g. current/maximum frames per second) this 1 second timer is
   invoked at can.ko module start time by default. This timer can be
   disabled by using stattimer=0 on the module commandline.
 
-  - debug: (removed since SocketCAN SVN r546)
+- **debug**:
+  (removed since SocketCAN SVN r546)
 
-  5.2 procfs content
 
-  As described in chapter 3.1 the SocketCAN core uses several filter
+procfs content
+--------------
+
+As described in :ref:`socketcan-receive-lists` the SocketCAN core uses several filter
 lists to deliver received CAN frames to CAN protocol modules. These
 receive lists, their filters and the count of filter matches can be
 checked in the appropriate receive list. All entries contain the
-  device and a protocol module identifier:
+device and a protocol module identifier::
 
     foo@bar:~$ cat /proc/net/can/rcvlist_all
 
@@ -914,7 +1013,7 @@ solution for a couple of reasons:
        vcan0     000    00000000  f88e6370  f6c6f400         0  raw
       (any: no entry)
 
-  In this example an application requests any CAN traffic from vcan0.
+In this example an application requests any CAN traffic from vcan0::
 
     rcvlist_all - list for unfiltered entries (no filter operations)
     rcvlist_eff - list for single extended frame (EFF) entries
@@ -923,13 +1022,15 @@ solution for a couple of reasons:
     rcvlist_inv - list for mask/value filters (inverse semantic)
     rcvlist_sff - list for single standard frame (SFF) entries
 
-  Additional procfs files in /proc/net/can
+Additional procfs files in /proc/net/can::
 
     stats       - SocketCAN core statistics (rx/tx frames, match ratios, ...)
     reset_stats - manual statistic reset
     version     - prints the SocketCAN core version and the ABI version
 
-  5.3 writing own CAN protocol modules
+
+Writing Own CAN Protocol Modules
+--------------------------------
 
 To implement a new protocol in the protocol family PF_CAN a new
 protocol has to be defined in include/linux/can.h .
@@ -937,7 +1038,7 @@ solution for a couple of reasons:
 accessed by including include/linux/can/core.h .
 In addition to functions that register the CAN protocol and the
 CAN device notifier chain there are functions to subscribe CAN
-  frames received by CAN interfaces and to send CAN frames:
+frames received by CAN interfaces and to send CAN frames::
 
     can_rx_register   - subscribe CAN frames from a specific interface
     can_rx_unregister - unsubscribe CAN frames from a specific interface
@@ -946,8 +1047,9 @@ solution for a couple of reasons:
 For details see the kerneldoc documentation in net/can/af_can.c or
 the source code of net/can/raw.c or net/can/bcm.c .
 
-6. CAN network drivers
-----------------------
+
+CAN Network Drivers
+===================
 
 Writing a CAN network device driver is much easier than writing a
 CAN character device driver. Similar to other known network device
@@ -959,7 +1061,11 @@ solution for a couple of reasons:
 See e.g. at Documentation/networking/netdevices.txt . The differences
 for writing CAN network device driver are described below:
 
-  6.1 general settings
+
+General Settings
+----------------
+
+.. code-block:: C
 
     dev->type  = ARPHRD_CAN; /* the netdevice hardware type */
     dev->flags = IFF_NOARP;  /* CAN has no arp */
@@ -972,17 +1078,23 @@ solution for a couple of reasons:
 The struct can_frame or struct canfd_frame is the payload of each socket
 buffer (skbuff) in the protocol family PF_CAN.
 
-  6.2 local loopback of sent frames
 
-  As described in chapter 3.2 the CAN network device driver should
+.. _socketcan-local-loopback2:
+
+Local Loopback of Sent Frames
+-----------------------------
+
+As described in :ref:`socketcan-local-loopback1` the CAN network device driver should
 support a local loopback functionality similar to the local echo
 e.g. of tty devices. In this case the driver flag IFF_ECHO has to be
 set to prevent the PF_CAN core from locally echoing sent frames
-  (aka loopback) as fallback solution:
+(aka loopback) as fallback solution::
 
     dev->flags = (IFF_NOARP | IFF_ECHO);
 
-  6.3 CAN controller hardware filters
+
+CAN Controller Hardware Filters
+-------------------------------
 
 To reduce the interrupt load on deep embedded systems some CAN
 controllers support the filtering of CAN IDs or ranges of CAN IDs.
@@ -998,7 +1110,9 @@ solution for a couple of reasons:
 @133MHz with four SJA1000 CAN controllers from 2002 under heavy bus
 load without any problems ...
 
-  6.4 The virtual CAN driver (vcan)
+
+The Virtual CAN Driver (vcan)
+-----------------------------
 
 Similar to the network loopback devices, vcan offers a virtual local
 CAN interface. A full qualified address on CAN consists of
@@ -1015,7 +1129,7 @@ solution for a couple of reasons:
 
 Since Linux Kernel version 2.6.24 the vcan driver supports the Kernel
 netlink interface to create vcan network devices. The creation and
-  removal of vcan network devices can be managed with the ip(8) tool:
+removal of vcan network devices can be managed with the ip(8) tool::
 
   - Create a virtual CAN network interface:
        $ ip link add type vcan
@@ -1026,7 +1140,9 @@ solution for a couple of reasons:
   - Remove a (virtual CAN) network interface 'vcan42':
        $ ip link del vcan42
 
-  6.5 The CAN network device driver interface
+
+The CAN Network Device Driver Interface
+---------------------------------------
 
 The CAN network device driver interface provides a generic interface
 to setup, configure and monitor CAN network devices. The user can then
@@ -1038,7 +1154,9 @@ solution for a couple of reasons:
 should use. Please have a look to the SJA1000 or MSCAN driver to
 understand how to use them. The name of the module is can-dev.ko.
 
-  6.5.1 Netlink interface to set/get devices properties
+
+Netlink interface to set/get devices properties
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The CAN device must be configured via netlink interface. The supported
 netlink message types are defined and briefly described in
@@ -1046,7 +1164,7 @@ solution for a couple of reasons:
 of the IPROUTE2 utility suite is available and it can be used as shown
 below:
 
-  - Setting CAN device properties:
+Setting CAN device properties::
 
     $ ip link set can0 type can help
     Usage: ip link set DEVICE type can
@@ -1079,7 +1197,7 @@ solution for a couple of reasons:
                SJW           := { 1..4 }
                RESTART-MS    := { 0 | NUMBER }
 
-  - Display CAN device details and statistics:
+Display CAN device details and statistics::
 
     $ ip -details -statistics link show can0
     2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP qlen 10
@@ -1127,8 +1245,7 @@ solution for a couple of reasons:
 	independent format as proposed by the Bosch CAN 2.0 spec (see
 	chapter 8 of http://www.semiconductors.bosch.de/pdf/can2spec.pdf).
 
-    "sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
-     clock 8000000"
+"sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1 clock 8000000"
 	Shows the bit-timing constants of the CAN controller, here the
 	"sja1000". The minimum and maximum values of the time segment 1
 	and 2, the synchronisation jump width in units of tq, the
@@ -1142,19 +1259,20 @@ solution for a couple of reasons:
 	bus-off state. RX overrun errors are listed in the "overrun"
 	field of the standard network statistics.
 
-  6.5.2 Setting the CAN bit-timing
+Setting the CAN Bit-Timing
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The CAN bit-timing parameters can always be defined in a hardware
 independent format as proposed in the Bosch CAN 2.0 specification
 specifying the arguments "tq", "prop_seg", "phase_seg1", "phase_seg2"
-  and "sjw":
+and "sjw"::
 
     $ ip link set canX type can tq 125 prop-seg 6 \
 				phase-seg1 7 phase-seg2 2 sjw 1
 
 If the kernel option CONFIG_CAN_CALC_BITTIMING is enabled, CIA
 recommended CAN bit-timing parameters will be calculated if the bit-
-  rate is specified with the argument "bitrate":
+rate is specified with the argument "bitrate"::
 
     $ ip link set canX type can bitrate 125000
 
@@ -1164,38 +1282,44 @@ solution for a couple of reasons:
 space and allows user-space tools to solely determine and set the
 bit-timing parameters. The CAN controller specific bit-timing
 constants can be used for that purpose. They are listed by the
-  following command:
+following command::
 
     $ ip -details link show can0
     ...
       sja1000: clock 8000000 tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
 
-  6.5.3 Starting and stopping the CAN network device
+
+Starting and Stopping the CAN Network Device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 A CAN network device is started or stopped as usual with the command
 "ifconfig canX up/down" or "ip link set canX up/down". Be aware that
 you *must* define proper bit-timing parameters for real CAN devices
-  before you can start it to avoid error-prone default settings:
+before you can start it to avoid error-prone default settings::
 
     $ ip link set canX up type can bitrate 125000
 
 A device may enter the "bus-off" state if too many errors occurred on
 the CAN bus. Then no more messages are received or sent. An automatic
 bus-off recovery can be enabled by setting the "restart-ms" to a
-  non-zero value, e.g.:
+non-zero value, e.g.::
 
     $ ip link set canX type can restart-ms 100
 
 Alternatively, the application may realize the "bus-off" condition
 by monitoring CAN error message frames and do a restart when
-  appropriate with the command:
+appropriate with the command::
 
     $ ip link set canX type can restart
 
 Note that a restart will also create a CAN error message frame (see
-  also chapter 3.3).
+also :ref:`socketcan-network-problem-notifications`).
+
+
+.. _socketcan-can-fd-driver:
 
-  6.6 CAN FD (flexible data rate) driver support
+CAN FD (Flexible Data Rate) Driver Support
+------------------------------------------
 
 CAN FD capable CAN controllers support two different bitrates for the
 arbitration phase and the payload phase of the CAN FD frame. Therefore a
@@ -1211,7 +1335,7 @@ solution for a couple of reasons:
 functions can_dlc2len() and can_len2dlc().
 
 The CAN netdevice driver capabilities can be distinguished by the network
-  devices maximum transfer unit (MTU):
+devices maximum transfer unit (MTU)::
 
   MTU = 16 (CAN_MTU)   => sizeof(struct can_frame)   => 'legacy' CAN device
   MTU = 72 (CANFD_MTU) => sizeof(struct canfd_frame) => CAN FD capable device
@@ -1247,7 +1371,7 @@ solution for a couple of reasons:
 The ISO/non-ISO-mode can be altered by setting 'fd-non-iso {on|off}' for
 switchable CAN FD controllers only.
 
-  Example configuring 500 kbit/s arbitration bitrate and 4 Mbit/s data bitrate:
+Example configuring 500 kbit/s arbitration bitrate and 4 Mbit/s data bitrate::
 
     $ ip link set can0 up type can bitrate 500000 sample-point 0.75 \
                                    dbitrate 4000000 dsample-point 0.8 fd on
@@ -1266,43 +1390,48 @@ solution for a couple of reasons:
           dbrp-inc 1
           clock 80000000
 
-  Example when 'fd-non-iso on' is added on this switchable CAN FD adapter:
+Example when 'fd-non-iso on' is added on this switchable CAN FD adapter::
+
    can <FD,FD-NON-ISO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
 
-  6.7 Supported CAN hardware
+
+Supported CAN Hardware
+----------------------
 
 Please check the "Kconfig" file in "drivers/net/can" to get an actual
 list of the support CAN hardware. On the SocketCAN project website
-  (see chapter 7) there might be further drivers available, also for
+(see :ref:`socketcan-resources`) there might be further drivers available, also for
 older kernel versions.
 
-7. SocketCAN resources
------------------------
+
+.. _socketcan-resources:
+
+SocketCAN Resources
+===================
 
 The Linux CAN / SocketCAN project resources (project site / mailing list)
 are referenced in the MAINTAINERS file in the Linux source tree.
 Search for CAN NETWORK [LAYERS|DRIVERS].
 
-8. Credits
-----------
-
-  Oliver Hartkopp (PF_CAN core, filters, drivers, bcm, SJA1000 driver)
-  Urs Thuermann (PF_CAN core, kernel integration, socket interfaces, raw, vcan)
-  Jan Kizka (RT-SocketCAN core, Socket-API reconciliation)
-  Wolfgang Grandegger (RT-SocketCAN core & drivers, Raw Socket-API reviews,
-                       CAN device driver interface, MSCAN driver)
-  Robert Schwebel (design reviews, PTXdist integration)
-  Marc Kleine-Budde (design reviews, Kernel 2.6 cleanups, drivers)
-  Benedikt Spranger (reviews)
-  Thomas Gleixner (LKML reviews, coding style, posting hints)
-  Andrey Volkov (kernel subtree structure, ioctls, MSCAN driver)
-  Matthias Brukner (first SJA1000 CAN netdevice implementation Q2/2003)
-  Klaus Hitschler (PEAK driver integration)
-  Uwe Koppe (CAN netdevices with PF_PACKET approach)
-  Michael Schulze (driver layer loopback requirement, RT CAN drivers review)
-  Pavel Pisa (Bit-timing calculation)
-  Sascha Hauer (SJA1000 platform driver)
-  Sebastian Haas (SJA1000 EMS PCI driver)
-  Markus Plessing (SJA1000 EMS PCI driver)
-  Per Dalen (SJA1000 Kvaser PCI driver)
-  Sam Ravnborg (reviews, coding style, kbuild help)
+Credits
+=======
+
+- Oliver Hartkopp (PF_CAN core, filters, drivers, bcm, SJA1000 driver)
+- Urs Thuermann (PF_CAN core, kernel integration, socket interfaces, raw, vcan)
+- Jan Kizka (RT-SocketCAN core, Socket-API reconciliation)
+- Wolfgang Grandegger (RT-SocketCAN core & drivers, Raw Socket-API reviews, CAN device driver interface, MSCAN driver)
+- Robert Schwebel (design reviews, PTXdist integration)
+- Marc Kleine-Budde (design reviews, Kernel 2.6 cleanups, drivers)
+- Benedikt Spranger (reviews)
+- Thomas Gleixner (LKML reviews, coding style, posting hints)
+- Andrey Volkov (kernel subtree structure, ioctls, MSCAN driver)
+- Matthias Brukner (first SJA1000 CAN netdevice implementation Q2/2003)
+- Klaus Hitschler (PEAK driver integration)
+- Uwe Koppe (CAN netdevices with PF_PACKET approach)
+- Michael Schulze (driver layer loopback requirement, RT CAN drivers review)
+- Pavel Pisa (Bit-timing calculation)
+- Sascha Hauer (SJA1000 platform driver)
+- Sebastian Haas (SJA1000 EMS PCI driver)
+- Markus Plessing (SJA1000 EMS PCI driver)
+- Per Dalen (SJA1000 Kvaser PCI driver)
+- Sam Ravnborg (reviews, coding style, kbuild help)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
