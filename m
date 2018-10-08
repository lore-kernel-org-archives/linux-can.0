From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 5/5] can: add support of SAE J1939 protocol.
Date: Mon,  8 Oct 2018 11:48:36 +0200
Message-ID: <20181008094836.14080-6-o.rempel@pengutronix.de>
References: <20181008094836.14080-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181008094836.14080-1-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: The j1939 authors <linux-can@vger.kernel.org>, Bastian Stender <bst@pengutronix.de>, Elenita Hinds <ecathinds@gmail.com>, Maxime Jayat <maxime.jayat@mobile-devices.fr>, Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: The j1939 authors <linux-can@vger.kernel.org>

SAE J1939 is the vehicle bus recommended practice used for communication
and diagnostics among vehicle components. Originating in the car and
heavy-duty truck industry in the United States, it is now widely used in
other parts of the world.

J1939, ISO 11783 and NMEA 2000 all share the same high level protocol.
SAE J1939 can be considered the replacement for the older SAE J1708 and
SAE J1587 specifications.

Signed-off-by: Bastian Stender <bst@pengutronix.de>
Signed-off-by: Elenita Hinds <ecathinds@gmail.com>
Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/networking/j1939.txt |  468 ++++++++++
 MAINTAINERS                        |   10 +
 include/linux/can/can-ml.h         |    3 +
 include/uapi/linux/can/j1939.h     |   83 ++
 net/can/Kconfig                    |    2 +
 net/can/Makefile                   |    2 +
 net/can/j1939/Kconfig              |   23 +
 net/can/j1939/Makefile             |   12 +
 net/can/j1939/address-claim.c      |  224 +++++
 net/can/j1939/bus.c                |  309 +++++++
 net/can/j1939/j1939-priv.h         |  176 ++++
 net/can/j1939/main.c               |  371 ++++++++
 net/can/j1939/socket.c             |  781 ++++++++++++++++
 net/can/j1939/transport.c          | 1333 ++++++++++++++++++++++++++++
 14 files changed, 3797 insertions(+)
 create mode 100644 Documentation/networking/j1939.txt
 create mode 100644 include/uapi/linux/can/j1939.h
 create mode 100644 net/can/j1939/Kconfig
 create mode 100644 net/can/j1939/Makefile
 create mode 100644 net/can/j1939/address-claim.c
 create mode 100644 net/can/j1939/bus.c
 create mode 100644 net/can/j1939/j1939-priv.h
 create mode 100644 net/can/j1939/main.c
 create mode 100644 net/can/j1939/socket.c
 create mode 100644 net/can/j1939/transport.c

diff --git a/Documentation/networking/j1939.txt b/Documentation/networking/j1939.txt
new file mode 100644
index 000000000000..6d03bc8b2f2c
--- /dev/null
+++ b/Documentation/networking/j1939.txt
@@ -0,0 +1,468 @@
+============================================================================
+
+j1939.txt
+
+Readme file for the J1939 Protocol
+
+This file contains
+
+  1 Overview / What is j1939
+    1.1 specifications used
+
+  2 Motivation
+
+  3 J1939 concepts
+    3.1 socket type
+    3.2 addressing
+    3.3 priority
+    3.4 PGN
+    3.5 filtering
+    3.6 destinations with dynamic address
+
+  4 How to use J1939
+    4.1 API calls
+        4.1.1 Message flags during sendmsg
+	4.1.2 SCM_J1939_DEST_ADDR & SCM_J1939_DEST_NAME
+	4.1.3 SCM_J1939_PRIORITY
+    4.2 Dynamic addressing
+    4.3 Send Examples
+        4.3.1 Static address
+	4.3.2 Dynamic address
+	4.3.3 Mixed mode
+
+  5 socket options
+    5.1 SO_J1939_FILTER
+    5.2 SO_J1939_PROMISC
+    5.3 SO_J1939_RECV_OWN
+    5.4 SO_J1939_SEND_PRIO
+
+  6 Credits
+
+============================================================================
+
+1. Introduction
+--------------------------------
+
+  SAE J1939 defines a higher layer protocol on CAN. It implements a more
+  sophisticated addressing scheme and extends the maximum packet size above
+  8 bytes. Several derived specifications exists, which differ from the
+  original j1939 on the application level, like MilCAN A, NMEA2000 and
+  especially ISO-11783 (ISOBUS). This last one specifies the so-called ETP
+  (Extended Transport Protocol) which is has been included in this
+  implementation. This inclusion results in a maximum packet size of
+  ((2^24)-1)*7 bytes
+
+
+1.1 specifications used
+
+  SAE J1939-21 : data link layer
+  SAE J1939-81 : network management
+  ISO 11783-6  : Virtual Terminal (Extended Transport Protocol)
+
+
+2. Motivation
+--------------------------------
+
+  Given the fact there's something like SocketCAN with an API similar to BSD
+  sockets, we found some reasons to justify a kernel implementation for the
+  addressing and transport methods used by J1939.
+
+  * addressing:
+    When a process on an ECU communicates via j1939, it should not necessarily
+    know its source address. Although at least 1 process per ECU should know
+    the source address. Other processes should be able to reuse that address.
+    This way, address parameters for different processes cooperating for the
+    same ECU, are not duplicated.
+    This way of working is closely related to the unix concept where programs
+    do just 1 thing, and do it well.
+
+  * dynamic addressing:
+    Address Claiming in J1939 is time critical. Furthermore data transport
+    should be handled properly during the address negotiation. Putting these
+    functionality in the kernel eliminates this functionality as a requirement
+    for _every_ userspace process that communicates via J1939. This results in
+    a consistent J1939 bus with proper addressing.
+
+  * transport:
+    Both TP & ETP reuse some PGN's to relay big packets over them. Different
+    processes may thus use the same TP & ETP PGN's without actually knowing it.
+    The individual TP & ETP sessions _must_ be serialized (synchronised)
+    between different processes. The kernel solves this problem properly, and
+    eliminates the serialisation (synchronisation) as a requirement for
+    _every_ userspace process that communicates via J1939.
+
+  J1939 defines some other features (relaying, gateway, Fast Packet transport,
+  ...). In-kernel code for these would not contribute to protocol stability.
+  Therefore, these parts are left to userspace.
+
+  The j1939 sockets operate on CAN network devices (see SocketCAN). Any j1939
+  userspace library operating on CAN raw sockets will still operate properly.
+  Since such library does not communicate with the in-kernel implementation,
+  care must be taken that these 2 do not interfere. In practice, this means
+  they cannot share ECU addresses. A single ECU (or virtual ECU) address is
+  used by the library exclusively, or by the in-kernel system exclusively.
+
+
+3. J1939 concepts
+--------------------------------
+
+3.1 PGN
+
+  The PGN (Parameter Group Number) is a number to identify a packet. The PGN
+  is composed as follows:
+   1 bit  : Reserved Bit
+   1 bit  : Data Page
+   8 bits : PF (PDU Format)
+   8 bits : PS (PDU Specific)
+
+  In J1939-21, distinction is made between PDU1 Format (where PF < 240) and
+  PDU2 Format (where PF >= 240). Furthermore, when using PDU2 Format, the
+  PS-field contains a so-called Group Extension, which is part of the PGN.
+  When using PDU2 Format, the Group Extension is set in the PS-field.
+
+  On the other hand, when using PDU1 Format, the PS-field contains a so-called
+  Destination Address, which is _not_ part of the PGN. When communicating a
+  PGN from userspace to kernel (or visa versa) and PDU2 Format is used, the
+  PS-field of the PGN shall be set to zero. The Destination Address shall be
+  set elsewhere.
+
+  Regarding PGN mapping to 29-bit CAN identifier, the Destination Address
+  shall be get/set from/to the appropriate bits of the identifier by the kernel.
+
+
+3.2 addressing
+
+  Both static and dynamic addressing methods can be used.
+
+  For static addresses, no extra checks are made by the kernel, and provided
+  addresses are considered right. This responsibility is for the OEM or system
+  integrator.
+
+  For dynamic addressing, so-called Address Claiming, extra support is forseen
+  in the kernel. In J1939 any ECU is known by it's 64-bit NAME. At the moment
+  of succesfull address claim, the kernel keeps track of both NAME and source
+  address being claimed. This serves as a base for filter schemes. By default,
+  packets with a destination that is not locally, will be rejected soon after
+  reception.
+
+  Mixed mode packets (from a static to a dynamic address or vice versa) are
+  allowed. The BSD sockets define separate API calls for getting/setting the
+  local & remote address and are applicable for J1939 sockets.
+
+
+3.3 Filtering
+
+  Similar to SocketCAN, j1939 defines filters per socket that a user can set
+  in order to receive a subset of the j1939 traffic. Filtering can base on
+  * SA
+  * NAME
+  * PGN
+
+  There is a semantic difference with SocketCAN with regard to filtering.
+  When multiple filters are in place for a single socket, and a packet comes
+  in that matches several of those filters, the packet is only received once
+  for that socket.
+  The rationale behind this difference originates in the filter capabilities.
+  Where SocketCAN filters on only 1 orthogonal (can id), J1939 can filter
+  on 3 orthogonal properties (sa, name, pgn).
+
+  When a filter on the SA is set, j1939 traffic with a matching SA, but with
+  its NAME set (aka having claimed SA successfully) will match, although
+  the filter would not match its NAME.
+
+  Filtering on priority is _not_ supported.
+
+
+4. How to use J1939
+--------------------------------
+
+4.1 API calls
+
+  Like TCP/IP and CAN, you first need to open a socket for communicating over a
+  CAN network. To use j1939, include <include/linux/j1939.h>. From there,
+  <include/linux/can.h> will be included too.
+  To open a socket, you would write
+
+    s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
+
+  J1939 does use SOCK_DGRAM sockets. In the j1939 specification, connections are
+  mentioned in the context of transport protocol sessions. These still deliver
+  packets to the other end (using several CAN packets).
+  SOCK_STREAM is never appropriate.
+
+  After the successful creation of the socket, you would normally use the
+  bind(2) and/or connect(2) system call to bind the socket to a CAN interface
+  (which is different from TCP/IP due to different addressing) After binding
+  and/or connecting the socket, you can read(2) and write(2) from/to the socket
+  or use send(2), sendto(2), sendmsg(2) and the recv* counterpart operations on
+  the socket as usual. There are also J1939 specific socket options described
+  below.
+
+  In order to send data, a bind(2) must have succeeded. bind(2) assigns a local
+  address to a socket. For this to succeed, you can only choose addresses
+  that have been assigned earlier (see 4.1). When an empty address is assigned
+  (ie. SA=0xff && name=0), a default is taken for the device that is bound to.
+
+  Different from CAN is that the payload data is just the data that get send,
+  without it's header info. The header info is derived from the sockaddr
+  supplied to bind(2), connect(2), sendto(2) and recvfrom(2). A write(2) with
+  size 4 will result in a packet with 4 bytes.
+
+  The sockaddr structure has extensions for use with j1939 as specified below:
+      struct sockaddr_can {
+         sa_family_t can_family;
+         int         can_ifindex;
+         union {
+            struct {
+               __u64 name;
+               __u32 pgn;
+               __u8  addr;
+            } j1939;
+         } can_addr;
+      }
+
+  can_family & can_ifindex serve the same purpose as for other SocketCAN sockets.
+
+  can_addr.j1939.pgn specifies the PGN (max 0x3ffff). Individual bits are
+  specified above.
+
+  can_addr.j1939.name contains the 64-bit J1939 NAME.
+
+  can_addr.j1939.addr contains the source address.
+
+  When sending data, the source address is applied as follows: If
+  can_addr.j1939.name != 0 the NAME is looked up by the kernel and the
+  corresponding Source Address is used. If can_addr.j1939.name == 0,
+  can_addr.j1939.addr is used.
+
+  After a bind(2), the local address is assigned, i.e. the source address.
+  After a connect(2), the remote address is assigned, i.e. the destination
+  address.
+
+  Both write(2) and send(2) will send a packet with local address from bind,
+  remote address from connect(2). When the address was not set, a broadcast is
+  sent. The PGN is used from bind(2) or overruled with sendto(2), which will
+  override the destination address when valid, and the PGN when valid.
+
+  Both read(2) and recv(2) will receive packets matching the sockets filters.
+  recvfrom(2) will receive these packets with originator's address.
+
+  When creating a socket, reasonable defaults have been set. Some options can be
+  modified with setsockopt(2) & getsockopt(2).
+
+4.1.1 Message flags during sendmsg
+
+  send(2), sendto(2) and sendmsg(2) take a 'flags' argument. J1939 interpretes
+  these flags during outgoing traffic:
+
+  * MSG_DONTWAIT determines nonblocking operation. When a packet must wait for
+    any reason, -EAGAIN is returned.
+
+  * MSG_SYN
+    Packets flagged with MSG_SYN will wait for all pending packets on a socket
+    to be sent before trying to send. This means that if a socket just started
+    a Transport Protocol session, a packet with MSG_SYN will wait for that
+    session to complete before proceeding.
+    Traffic without MSG_SYN (on that very same socket) will still continue.
+
+4.1.2 SCM_J1939_DEST_ADDR & SCM_J1939_DEST_NAME
+
+  Different received j1939 packets could have had different destionations:
+  - broadcast packet, i.e. no destination address
+  - destination address that matches the sockets local address
+  - destination address that matches _a_ local address on the system, and the
+    socket had no local address defined.
+  - SO_J1939_PROMISC was set
+
+  The destination address & destination name (if applicable) are attached
+  to the msghdr in the recvmsg(2) call. It can be extracted using cmsg(3) macros,
+  with cmsg_level == SOL_J1939 && cmsg_type == SCM_J1939_DEST_ADDR
+  or SCM_J1939_DEST_NAME. The returned data is a uint8_t/uint64_t.
+
+4.1.3 SCM_J1939_PRIORITY
+
+  Attached to the msghdr is also the packet's priority on the bus. This is a
+  uint8_t, packed as cmsg_type == SCM_J1939_PRIORITY.
+
+4.2 Dynamic Addressing
+
+  Distinction has to be made in and using the claimed address and doing an
+  address claim. To use an already claimed address, one has to fill in the
+  j1939.name member and provide it to bind(2). If the name had claimed an
+  address earlier, all further PGN's being sent will use that address. And the
+  j1939.addr member will be ignored.
+
+  An exception on this is pgn 0x0ee00. This is the "Address Claim/Cannot Claim
+  Address" message and when the kernel will use the j1939.addr member for that
+  pgn if necessary.
+
+  To claim an address, bind(2) with:
+  j1939.pgn  set to 0x0ee00
+  j1939.addr set to the desired Source Address.
+  j1939.name set to the NAME you want the Source Address to claim to.
+
+  Afterwards do a write(2) with data set to the NAME (Little Endian). If the
+  NAME provided, does not match the j1939.name provided to bind(2), EPROTO
+  will be returned. One might use sendto(2) also to send the Address Claim. In
+  that case, the j1939.addr member must be set to the broadcast address (255)
+  and the j1939.pgn must be set to 0x0ee00. If This combination is not given,
+  EPROTO is returned.
+
+  If no-one else contest the address claim within 250ms after transmission, the
+  kernel marks the NAME-SA assignment as valid. The valid assignment will be
+  kept, among other valid NAME-SA assignments. From that point, any socket
+  bound to the NAME can send packets.
+
+  If another ECU claims the address, the kernel will mark the NAME-SA expired.
+  No socket bound to the NAME can send packets (other than address claims).
+  To claim another address, some socket bound to NAME, must bind(2) again,
+  but with only j1939.addr changed to the new SA, and must then send a
+  valid address claim packet. This restarts the state machine in the kernel
+  (and any other participant on the bus) for this NAME.
+
+
+4.3 Send Examples
+
+4.3.1 Static addressing
+
+  This example will send a pgn (0x12300) from SA 0x20 to DA 0x30.
+
+  Bind:
+    struct sockaddr_can addr;
+
+    memset(&addr, 0, sizeof(addr));
+    addr.can_ifindex = ifindex("can0"); // ifindex is a substitute.
+    addr.can_addr.j1939.name = J1939_NO_NAME;
+    addr.can_addr.j1939.addr = 0x20;
+    addr.can_addr.j1939.pgn = J1939_NO_PGN;
+
+    bind(sk, (void *)&addr, sizeof(addr));
+
+  Now, the socket 'sk' is bound to the address 0x20. Since no pgn
+  was specified during bound, a pgn will be necessary during sendto() operations.
+  Alternatively, specifying addr.can_addr.j1939.pgn during bind() allows
+  for using send() & write(), since a default pgn (the pgn specified during bind())
+  can be used then.
+
+  Send:
+    struct sockaddr_can addr;
+
+    memset(&addr, 0, sizeof(addr));
+    addr.can_addr.j1939.name = J1939_NO_NAME;
+    addr.can_addr.j1939.addr = 0x30;
+    addr.can_addr.j1939.pgn = 0x12300;
+    // addr.can_ifindex is not necessary here.
+
+    sendto(sk, data, sizeof(data), 0, (void *)&addr, sizeof(addr));
+
+4.3.2 Dynamic addressing
+
+  This example will send a pgn (0x12300) from 12345678 to 9ABCDEF
+
+  Start an address claiming daemon (e.g. jacd)
+  $ jacd -r 0x20-0x30 12345678 can0 &
+
+  Bind:
+    struct sockaddr_can addr;
+
+    memset(&addr, 0, sizeof(addr));
+    addr.can_ifindex = if_nametoindex("can0");
+    addr.can_addr.j1939.name = 0x12345678ULL;
+    addr.can_addr.j1939.addr = J1939_NO_ADDR;
+    addr.can_addr.j1939.pgn = J1939_NO_PGN;
+
+    bind(sk, (void *)&addr, sizeof(addr));
+
+  Send:
+    struct sockaddr_can addr;
+
+    memset(&addr, 0, sizeof(addr));
+    addr.can_addr.j1939.name = 0x9ABCDEFULL;
+    addr.can_addr.j1939. = J1939_NO_ADDR;
+    addr.can_addr.j1939.pgn = 0x12300;
+
+    sendto(sk, data, sizeof(data), 0, (void *)&addr, sizeof(addr));
+
+4.3.3 Mixed mode
+
+  A scenario that sends a packet from a static address to a dynamic address
+  or vice versa is called 'mixed mode' here.
+
+  Combining the setup of the static address with a sendto() to a dynamic
+  address from the above examples is legal, and implements such mixed mode
+  addressing. The same applies for the setup of the dynamic address combined
+  with the sendto() towards a dynamic address.
+
+
+5 Socket Options
+--------------------------------
+
+  j1939 sockets have some options that are configurable via setsockopt(2).
+  Each of those options is initialized with a reasonable default.
+
+
+5.1 SO_J1939_FILTER
+
+  As mentioned above, J1939 supports filtering in both NAME, Source Address
+  and PGN. All members must match.
+
+   struct j1939_filter filter = {
+      .name         = ...
+      .name_mask   = ...
+      .addr         = ...
+      .addr_mask   = ...
+      .pgn         = ...
+      .pgn_mask   = ...
+   }
+
+    setsockopt(s, SOL_CAN_J1939, SO_J1939_FILTER, &filter, sizeof(filter));
+
+
+5.2 SO_J1939_PROMISC
+
+  When set, j1939 will receive all packets, not just those with a destination
+  on the local system.
+  default off.
+
+    int promisc = 1; /* 0 = disabled (default), 1 = enabled */
+
+    setsockopt(s, SOL_CAN_J1939, SO_J1939_PROMISC, &promisc, sizeof(promisc));
+
+
+5.3 SO_J1939_RECV_OWN
+
+  All the sent j1939 packets are looped back in the system.
+  The reception of the j1939 packets on the same socket that was
+  sending the j1939 packet is assumed to be unwanted and therefore
+  disabled by default. This default behaviour may be changed on
+  demand:
+
+    int recv_own_msgs = 1; /* 0 = disabled (default), 1 = enabled */
+
+    setsockopt(s, SOL_CAN_J1939, SO_J1939_RECV_OWN,
+               &recv_own_msgs, sizeof(recv_own_msgs));
+
+
+5.4 SO_J1939_SEND_PRIO
+
+  To set the priority field for outgoing packets, the SO_J1939_SEND_PRIO can
+  be changed. This int field specifies the priority that will be used.
+  j1939 defines a priority between 0 and 7 inclusive,
+  with 7 the lowest priority.
+  Per default, the priority is set to 6 (conforming J1939).
+  This priority socket option operates on the same value that is modified
+  with
+
+    setsockopt(s, SOL_SOCKET, SO_PRIORITY, &pri, sizeof(pri))
+
+  socketoption, with a difference that SOL_SOCKET/SO_PRIORITY is defined with
+  0 the lowest priority. SOL_CAN_J1939/SO_J1939_SEND_PRIO inverts this value
+  for you.
+
+
+6. Credits
+--------------------------------
+
+  Kurt Van Dijck (j1939 core, transport protocol, API)
+  Pieter Beyens (j1939 core, address claiming)
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..709dfbb9c741 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3307,6 +3307,16 @@ F:	include/uapi/linux/can/bcm.h
 F:	include/uapi/linux/can/raw.h
 F:	include/uapi/linux/can/gw.h
 
+CAN-J1939 NETWORK LAYER
+M:	Robin van der Gracht <robin@protonic.nl>
+M:	Oleksij Rempel <o.rempel@pengutronix.de>
+R:	Pengutronix Kernel Team <kernel@pengutronix.de>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/j1939.txt
+F:	net/can/j1939/
+F:	include/uapi/linux/can/j1939.h
+
 CAPABILITIES
 M:	Serge Hallyn <serge@hallyn.com>
 L:	linux-security-module@vger.kernel.org
diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
index 2786b04251ea..9861946fe4ae 100644
--- a/include/linux/can/can-ml.h
+++ b/include/linux/can/can-ml.h
@@ -18,6 +18,9 @@
 
 struct can_ml_priv {
 	struct can_dev_rcv_lists dev_rcv_lists;
+#ifdef CAN_J1939
+	struct j1939_priv *j1939_priv;
+#endif
 };
 
 #endif /* CAN_ML_H */
diff --git a/include/uapi/linux/can/j1939.h b/include/uapi/linux/can/j1939.h
new file mode 100644
index 000000000000..5b2505e36d0e
--- /dev/null
+++ b/include/uapi/linux/can/j1939.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * j1939.h
+ *
+ * Copyright (c) 2010-2011 EIA Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _UAPI_CAN_J1939_H_
+#define _UAPI_CAN_J1939_H_
+
+#include <linux/types.h>
+#include <linux/socket.h>
+#include <linux/can.h>
+
+#define J1939_MAX_UNICAST_ADDR 0xfd
+#define J1939_IDLE_ADDR 0xfe
+#define J1939_NO_ADDR 0xff
+#define J1939_NO_NAME 0
+#define J1939_NO_PGN 0x40000
+
+/* J1939 Parameter Group Number
+ *
+ * bit 0-7	: PDU Specific (PS)
+ * bit 8-15	: PDU Format (PF)
+ * bit 16	: Data Page (DP)
+ * bit 17	: Reserved (R)
+ * bit 19-31	: set to zero
+ */
+typedef __u32 pgn_t;
+
+/* J1939 Priority
+ *
+ * bit 0-2	: Priority (P)
+ * bit 3-7	: set to zero
+ */
+typedef __u8 priority_t;
+
+/* J1939 NAME
+ *
+ * bit 0-20	: Identity Number
+ * bit 21-31	: Manufacturer Code
+ * bit 32-34	: ECU Instance
+ * bit 35-39	: Function Instance
+ * bit 40-47	: Function
+ * bit 48	: Reserved
+ * bit 49-55	: Vehicle System
+ * bit 56-59	: Vehicle System Instance
+ * bit 60-62	: Industry Group
+ * bit 63	: Arbitrary Address Capable
+ */
+typedef __u64 name_t;
+
+/* J1939 socket options */
+#define SOL_CAN_J1939 (SOL_CAN_BASE + CAN_J1939)
+enum {
+	SO_J1939_FILTER = 1,	/* set filters */
+	SO_J1939_PROMISC = 2,	/* set/clr promiscuous mode */
+	SO_J1939_RECV_OWN = 3,
+	SO_J1939_SEND_PRIO = 4,
+};
+
+enum {
+	SCM_J1939_DEST_ADDR = 1,
+	SCM_J1939_DEST_NAME = 2,
+	SCM_J1939_PRIO = 3,
+};
+
+struct j1939_filter {
+	name_t name;
+	name_t name_mask;
+	__u8 addr;
+	__u8 addr_mask;
+	pgn_t pgn;
+	pgn_t pgn_mask;
+};
+
+#define J1939_FILTER_MAX 512 /* maximum number of j1939_filter set via setsockopt() */
+
+#endif /* !_UAPI_CAN_J1939_H_ */
diff --git a/net/can/Kconfig b/net/can/Kconfig
index a4399be54ff4..8b2199d7027b 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -51,6 +51,8 @@ config CAN_GW
 	  They can be modified with AND/OR/XOR/SET operations as configured
 	  by the netlink configuration interface known e.g. from iptables.
 
+source "net/can/j1939/Kconfig"
+
 source "drivers/net/can/Kconfig"
 
 endif
diff --git a/net/can/Makefile b/net/can/Makefile
index 1242bbbfe57f..08bd217fc051 100644
--- a/net/can/Makefile
+++ b/net/can/Makefile
@@ -15,3 +15,5 @@ can-bcm-y		:= bcm.o
 
 obj-$(CONFIG_CAN_GW)	+= can-gw.o
 can-gw-y		:= gw.o
+
+obj-$(CONFIG_CAN_J1939)	+= j1939/
diff --git a/net/can/j1939/Kconfig b/net/can/j1939/Kconfig
new file mode 100644
index 000000000000..ff0b08a8af3f
--- /dev/null
+++ b/net/can/j1939/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# SAE J1939 network layer core configuration
+#
+
+config CAN_J1939
+	tristate "SAE J1939"
+	depends on CAN
+	---help---
+	  SAE J1939
+	  Say Y to have in-kernel support for j1939 socket type. This
+	  allows communication according to SAE j1939.
+	  The relevant parts in kernel are
+	  SAE j1939-21 (datalink & transport protocol)
+	  & SAE j1939-81 (network management).
+
+config CAN_J1939_DEBUG
+	bool "debug SAE J1939"
+	depends on CAN_J1939
+	default n
+	---help---
+	  Say Y to add extra debug code (via printk) in the j1939 stack
+
diff --git a/net/can/j1939/Makefile b/net/can/j1939/Makefile
new file mode 100644
index 000000000000..46e6c6ed221d
--- /dev/null
+++ b/net/can/j1939/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+
+cppflags-$(CONFIG_CAN_J1939_DEBUG) += -DDEBUG
+
+obj-$(CONFIG_CAN_J1939) += can-j1939.o
+
+can-j1939-objs := \
+	address-claim.o \
+	bus.o \
+	main.o \
+	socket.o \
+	transport.o
diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
new file mode 100644
index 000000000000..43082c0aef60
--- /dev/null
+++ b/net/can/j1939/address-claim.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2010-2011 EIA Electronics, Kurt Van Dijck <kurt.van.dijck@eia.be>
+// Copyright (c) 2010-2011 EIA Electronics, Pieter Beyens <pieter.beyens@eia.be>
+// Copyright (c) 2017-2018 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+// Copyright (c) 2017-2018 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+
+/* J1939 Address Claiming.
+ * Address Claiming in the kernel
+ * - keeps track of the AC states of ECU's,
+ * - resolves NAME<=>SA taking into account the AC states of ECU's.
+ *
+ * All Address Claim msgs (including host-originated msg) are processed
+ * at the receive path (a sent msg is always received again via CAN echo).
+ * As such, the processing of AC msgs is done in the order on which msgs
+ * are sent on the bus.
+ *
+ * This module doesn't send msgs itself (e.g. replies on Address Claims),
+ * this is the responsibility of a user space application or daemon.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/skbuff.h>
+
+#include "j1939-priv.h"
+
+static inline name_t j1939_skb_to_name(const struct sk_buff *skb)
+{
+	return le64_to_cpup((__le64 *)skb->data);
+}
+
+static inline bool j1939_ac_msg_is_request(struct sk_buff *skb)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	int req_pgn;
+
+	if (skb->len < 3 || skcb->addr.pgn != J1939_PGN_REQUEST)
+		return false;
+
+	req_pgn = skb->data[0] | (skb->data[1] << 8) | (skb->data[2] << 16);
+
+	return req_pgn == J1939_PGN_ADDRESS_CLAIMED;
+}
+
+static int j1939_ac_verify_outgoing(struct sk_buff *skb)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+
+	if (skb->len != 8) {
+		pr_notice("tx address claim with dlc %i\n", skb->len);
+		return -EPROTO;
+	}
+
+	if (skcb->addr.src_name != j1939_skb_to_name(skb)) {
+		pr_notice("tx address claim with different name\n");
+		return -EPROTO;
+	}
+
+	if (skcb->addr.sa == J1939_NO_ADDR) {
+		pr_notice("tx address claim with broadcast sa\n");
+		return -EPROTO;
+	}
+
+	/* ac must always be a broadcast */
+	if (skcb->addr.dst_name || skcb->addr.da != J1939_NO_ADDR) {
+		pr_notice("tx address claim with dest, not broadcast\n");
+		return -EPROTO;
+	}
+	return 0;
+}
+
+int j1939_ac_fixup(struct j1939_priv *priv, struct sk_buff *skb)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	int ret;
+	u8 addr;
+
+	/* network mgmt: address claiming msgs */
+	if (skcb->addr.pgn == J1939_PGN_ADDRESS_CLAIMED) {
+		struct j1939_ecu *ecu;
+
+		ret = j1939_ac_verify_outgoing(skb);
+		/* return both when failure & when successful */
+		if (ret < 0)
+			return ret;
+		ecu = j1939_ecu_get_by_name(priv, skcb->addr.src_name);
+		if (!ecu)
+			return -ENODEV;
+
+		if (ecu->addr != skcb->addr.sa)
+			/* hold further traffic for ecu, remove from parent */
+			j1939_ecu_unmap(ecu);
+		j1939_ecu_put(ecu);
+	} else if (skcb->addr.src_name) {
+		/* assign source address */
+		addr = j1939_name_to_addr(priv, skcb->addr.src_name);
+		if (!j1939_address_is_unicast(addr) &&
+		    !j1939_ac_msg_is_request(skb)) {
+			pr_notice("tx drop: invalid sa for name 0x%016llx\n",
+				  skcb->addr.src_name);
+			return -EADDRNOTAVAIL;
+		}
+		skcb->addr.sa = addr;
+	}
+
+	/* assign destination address */
+	if (skcb->addr.dst_name) {
+		addr = j1939_name_to_addr(priv, skcb->addr.dst_name);
+		if (!j1939_address_is_unicast(addr)) {
+			pr_notice("tx drop: invalid da for name 0x%016llx\n",
+				  skcb->addr.dst_name);
+			return -EADDRNOTAVAIL;
+		}
+		skcb->addr.da = addr;
+	}
+	return 0;
+}
+
+static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	struct j1939_ecu *ecu, *prev;
+	name_t name;
+
+	if (skb->len != 8) {
+		pr_notice("rx address claim with wrong dlc %i\n", skb->len);
+		return;
+	}
+
+	name = j1939_skb_to_name(skb);
+	skcb->addr.src_name = name;
+	if (!name) {
+		pr_notice("rx address claim without name\n");
+		return;
+	}
+
+	if (!j1939_address_is_valid(skcb->addr.sa)) {
+		pr_notice("rx address claim with broadcast sa\n");
+		return;
+	}
+
+	write_lock_bh(&priv->lock);
+
+	/* Few words on the ECU ref counting:
+	 *
+	 * First we get an ECU handle, either with
+	 * j1939_ecu_get_by_name_locked() (increments the ref counter)
+	 * or j1939_ecu_create_locked() (initializes an ECU object
+	 * with a ref counter of 1).
+	 *
+	 * j1939_ecu_unmap_locked() will decrement the ref counter,
+	 * but only if the ECU was mapped before. So "ecu" still
+	 * belongs to us.
+	 *
+	 * j1939_ecu_timer_start() will increment the ref counter
+	 * before it starts the timer, so we can put the ecu when
+	 * leaving this function.
+	 */
+	ecu = j1939_ecu_get_by_name_locked(priv, name);
+	if (!ecu && j1939_address_is_unicast(skcb->addr.sa))
+		ecu = j1939_ecu_create_locked(priv, name);
+
+	if (IS_ERR_OR_NULL(ecu))
+		goto out_unlock_bh;
+
+	/* cancel pending (previous) address claim */
+	j1939_ecu_timer_cancel(ecu);
+
+	if (j1939_address_is_idle(skcb->addr.sa)) {
+		j1939_ecu_unmap_locked(ecu);
+		goto out_ecu_put;
+	}
+
+	/* save new addr */
+	if (ecu->addr != skcb->addr.sa)
+		j1939_ecu_unmap_locked(ecu);
+	ecu->addr = skcb->addr.sa;
+
+	prev = j1939_ecu_get_by_addr_locked(priv, skcb->addr.sa);
+	if (prev == ecu) {
+		j1939_ecu_put(prev);
+	} else if (prev) {
+		if (ecu->name > prev->name) {
+			j1939_ecu_unmap_locked(ecu);
+			j1939_ecu_put(prev);
+			goto out_ecu_put;
+		} else {
+			/* kick prev */
+			j1939_ecu_unmap_locked(prev);
+			j1939_ecu_put(prev);
+		}
+	}
+
+	j1939_ecu_timer_start(ecu);
+ out_ecu_put:
+	j1939_ecu_put(ecu);
+ out_unlock_bh:
+	write_unlock_bh(&priv->lock);
+}
+
+void j1939_ac_recv(struct j1939_priv *priv, struct sk_buff *skb)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	struct j1939_ecu *ecu;
+
+	/* network mgmt */
+	if (skcb->addr.pgn == J1939_PGN_ADDRESS_CLAIMED) {
+		j1939_ac_process(priv, skb);
+	} else if (j1939_address_is_unicast(skcb->addr.sa)) {
+		/* assign source name */
+		ecu = j1939_ecu_get_by_addr(priv, skcb->addr.sa);
+		if (ecu) {
+			skcb->addr.src_name = ecu->name;
+			j1939_ecu_put(ecu);
+		}
+	}
+
+	/* assign destination name */
+	ecu = j1939_ecu_get_by_addr(priv, skcb->addr.da);
+	if (ecu) {
+		skcb->addr.dst_name = ecu->name;
+		j1939_ecu_put(ecu);
+	}
+}
diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
new file mode 100644
index 000000000000..5b6d762f0448
--- /dev/null
+++ b/net/can/j1939/bus.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2010-2011 EIA Electronics, Kurt Van Dijck <kurt.van.dijck@eia.be>
+// Copyright (c) 2017-2018 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+// Copyright (c) 2017-2018 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+
+/* bus for j1939 remote devices
+ * Since rtnetlink, no real bus is used.
+ */
+
+#include <net/sock.h>
+
+#include "j1939-priv.h"
+
+#define ecu_dbg(_ecu, fmt, ...) \
+{ \
+	struct j1939_ecu *ecu = _ecu; \
+	pr_debug("j1939-%i,%016llx,%02x: " fmt, ecu->priv->ndev->ifindex, \
+		 ecu->name, ecu->addr, ##__VA_ARGS__); \
+}
+
+static void __j1939_ecu_release(struct kref *kref)
+{
+	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
+	struct j1939_priv *priv = ecu->priv;
+
+	list_del(&ecu->list);
+	kfree(ecu);
+	j1939_priv_put(priv);
+}
+
+void j1939_ecu_put(struct j1939_ecu *ecu)
+{
+	kref_put(&ecu->kref, __j1939_ecu_release);
+}
+
+static void j1939_ecu_get(struct j1939_ecu *ecu)
+{
+	kref_get(&ecu->kref);
+}
+
+static bool j1939_ecu_is_mapped_locked(struct j1939_ecu *ecu)
+{
+	struct j1939_priv *priv = ecu->priv;
+
+	lockdep_assert_held(&priv->lock);
+
+	return j1939_ecu_find_by_addr_locked(priv, ecu->addr) == ecu;
+}
+
+/* ECU device interface */
+/* map ECU to a bus address space */
+static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
+{
+	lockdep_assert_held(&ecu->priv->lock);
+
+	if (!j1939_address_is_unicast(ecu->addr))
+		return;
+
+	j1939_ecu_get(ecu);
+	ecu->priv->ents[ecu->addr].ecu = ecu;
+	ecu->priv->ents[ecu->addr].nusers += ecu->nusers;
+}
+
+/* unmap ECU from a bus address space */
+void j1939_ecu_unmap_locked(struct j1939_ecu *ecu)
+{
+	lockdep_assert_held(&ecu->priv->lock);
+
+	if (!j1939_address_is_unicast(ecu->addr))
+		return;
+
+	if (!j1939_ecu_is_mapped_locked(ecu))
+		return;
+
+	ecu->priv->ents[ecu->addr].ecu = NULL;
+	ecu->priv->ents[ecu->addr].nusers -= ecu->nusers;
+	j1939_ecu_put(ecu);
+}
+
+void j1939_ecu_unmap(struct j1939_ecu *ecu)
+{
+	write_lock_bh(&ecu->priv->lock);
+	j1939_ecu_unmap_locked(ecu);
+	write_unlock_bh(&ecu->priv->lock);
+}
+
+void j1939_ecu_timer_start(struct j1939_ecu *ecu)
+{
+	/* The ECU is held here and released in the
+	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
+	 */
+	j1939_ecu_get(ecu);
+
+	/* Schedule timer in 250 msec to commit address change. */
+	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
+		      HRTIMER_MODE_REL_SOFT);
+}
+
+void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
+{
+	if (hrtimer_cancel(&ecu->ac_timer))
+		j1939_ecu_put(ecu);
+}
+
+static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
+{
+	struct j1939_ecu *ecu =
+		container_of(hrtimer, struct j1939_ecu, ac_timer);
+	struct j1939_priv *priv = ecu->priv;
+
+	write_lock_bh(&priv->lock);
+	/* TODO: can we test if ecu->addr is unicast before starting
+	 * the timer?
+	 */
+	j1939_ecu_map_locked(ecu);
+
+	/* The corresponding j1939_ecu_get() is in
+	 * j1939_ecu_timer_start().
+	 */
+	j1939_ecu_put(ecu);
+	write_unlock_bh(&priv->lock);
+
+	return HRTIMER_NORESTART;
+}
+
+struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
+{
+	struct j1939_ecu *ecu;
+
+	lockdep_assert_held(&priv->lock);
+
+	ecu = kzalloc(sizeof(*ecu), gfp_any());
+	if (!ecu)
+		return ERR_PTR(-ENOMEM);
+	kref_init(&ecu->kref);
+	ecu->addr = J1939_IDLE_ADDR;
+	ecu->name = name;
+
+	hrtimer_init(&ecu->ac_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	ecu->ac_timer.function = j1939_ecu_timer_handler;
+	INIT_LIST_HEAD(&ecu->list);
+
+	j1939_priv_get(priv);
+	ecu->priv = priv;
+	list_add_tail(&ecu->list, &priv->ecus);
+
+	ecu_dbg(ecu, "%s\n", __func__);
+	return ecu;
+}
+
+struct j1939_ecu *j1939_ecu_find_by_addr_locked(struct j1939_priv *priv, u8 addr)
+{
+	lockdep_assert_held(&priv->lock);
+
+	return priv->ents[addr].ecu;
+}
+
+struct j1939_ecu *j1939_ecu_get_by_addr_locked(struct j1939_priv *priv, u8 addr)
+{
+	struct j1939_ecu *ecu;
+
+	lockdep_assert_held(&priv->lock);
+
+	if (!j1939_address_is_unicast(addr))
+		return NULL;
+
+	ecu = j1939_ecu_find_by_addr_locked(priv, addr);
+	if (ecu)
+		j1939_ecu_get(ecu);
+
+	return ecu;
+}
+
+struct j1939_ecu *j1939_ecu_get_by_addr(struct j1939_priv *priv, u8 addr)
+{
+	struct j1939_ecu *ecu;
+
+	read_lock_bh(&priv->lock);
+	ecu = j1939_ecu_get_by_addr_locked(priv, addr);
+	read_unlock_bh(&priv->lock);
+
+	return ecu;
+}
+
+/* get pointer to ecu without increasing ref counter */
+static struct j1939_ecu *j1939_ecu_find_by_name_locked(struct j1939_priv *priv, name_t name)
+{
+	struct j1939_ecu *ecu;
+
+	lockdep_assert_held(&priv->lock);
+
+	list_for_each_entry(ecu, &priv->ecus, list) {
+		if (ecu->name == name)
+			return ecu;
+	}
+
+	return NULL;
+}
+
+struct j1939_ecu *j1939_ecu_get_by_name_locked(struct j1939_priv *priv, name_t name)
+{
+	struct j1939_ecu *ecu;
+
+	lockdep_assert_held(&priv->lock);
+
+	if (!name)
+		return NULL;
+
+	ecu = j1939_ecu_find_by_name_locked(priv, name);
+	if (ecu)
+		j1939_ecu_get(ecu);
+
+	return ecu;
+}
+
+struct j1939_ecu *j1939_ecu_get_by_name(struct j1939_priv *priv, name_t name)
+{
+	struct j1939_ecu *ecu;
+
+	read_lock_bh(&priv->lock);
+	ecu = j1939_ecu_get_by_name_locked(priv, name);
+	read_unlock_bh(&priv->lock);
+
+	return ecu;
+}
+
+u8 j1939_name_to_addr(struct j1939_priv *priv, name_t name)
+{
+	struct j1939_ecu *ecu;
+	int addr = J1939_IDLE_ADDR;
+
+	if (!name)
+		return J1939_NO_ADDR;
+
+	read_lock_bh(&priv->lock);
+	ecu = j1939_ecu_find_by_name_locked(priv, name);
+	if (j1939_ecu_is_mapped_locked(ecu))
+		/* ecu's SA is registered */
+		addr = ecu->addr;
+
+	read_unlock_bh(&priv->lock);
+
+	return addr;
+}
+
+/* TX addr/name accounting
+ * Transport protocol needs to know if a SA is local or not
+ * These functions originate from userspace manipulating sockets,
+ * so locking is straigforward
+ */
+
+int j1939_local_ecu_get(struct j1939_priv *priv, name_t name, u8 sa)
+{
+	struct j1939_ecu *ecu;
+	int err = 0;
+
+	write_lock_bh(&priv->lock);
+
+	if (j1939_address_is_unicast(sa))
+		priv->ents[sa].nusers++;
+
+	if (!name)
+		goto done;
+
+	ecu = j1939_ecu_get_by_name_locked(priv, name);
+	if (!ecu)
+		ecu = j1939_ecu_create_locked(priv, name);
+	err = PTR_ERR_OR_ZERO(ecu);
+	if (err)
+		goto done;
+
+	ecu->nusers++;
+	/* TODO: do we care if ecu->addr != sa? */
+	if (j1939_ecu_is_mapped_locked(ecu))
+		/* ecu's sa is active already */
+		priv->ents[ecu->addr].nusers++;
+
+ done:
+	write_unlock_bh(&priv->lock);
+
+	return err;
+}
+
+void j1939_local_ecu_put(struct j1939_priv *priv, name_t name, u8 sa)
+{
+	struct j1939_ecu *ecu;
+
+	write_lock_bh(&priv->lock);
+
+	if (j1939_address_is_unicast(sa))
+		priv->ents[sa].nusers--;
+
+	if (!name)
+		goto done;
+
+	ecu = j1939_ecu_find_by_name_locked(priv, name);
+	if (WARN_ON_ONCE(!ecu))
+		goto done;
+
+	ecu->nusers--;
+	/* TODO: do we care if ecu->addr != sa? */
+	if (j1939_ecu_is_mapped_locked(ecu))
+		/* ecu's sa is active already */
+		priv->ents[ecu->addr].nusers--;
+	j1939_ecu_put(ecu);
+
+ done:
+	write_unlock_bh(&priv->lock);
+}
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
new file mode 100644
index 000000000000..9db9077849e7
--- /dev/null
+++ b/net/can/j1939/j1939-priv.h
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2010-2011 EIA Electronics, Kurt Van Dijck <kurt.van.dijck@eia.be>
+// Copyright (c) 2017-2018 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+// Copyright (c) 2017-2018 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+
+#ifndef _J1939_PRIV_H_
+#define _J1939_PRIV_H_
+
+#include <linux/can/j1939.h>
+
+/* TODO: return ENETRESET on busoff. */
+
+#define J1939_PGN_REQUEST 0x0ea00
+#define J1939_PGN_ADDRESS_CLAIMED 0x0ee00
+#define J1939_PGN_MAX 0x3ffff
+
+/* j1939 devices */
+struct j1939_ecu {
+	struct list_head list;
+	name_t name;
+	u8 addr;
+
+	/* indicates that this ecu successfully claimed @sa as its address */
+	struct hrtimer ac_timer;
+	struct kref kref;
+	struct j1939_priv *priv;
+
+	/* count users, to help transport protocol decide for interaction */
+	int nusers;
+};
+
+struct j1939_priv {
+	struct list_head ecus;
+	/* local list entry in priv
+	 * These allow irq (& softirq) context lookups on j1939 devices
+	 * This approach (separate lists) is done as the other 2 alternatives
+	 * are not easier or even wrong
+	 * 1) using the pure kobject methods involves mutexes, which are not
+	 *    allowed in irq context.
+	 * 2) duplicating data structures would require a lot of synchronization
+	 *    code
+	 * usage:
+	 */
+
+	/* segments need a lock to protect the above list */
+	rwlock_t lock;
+
+	struct net_device *ndev;
+
+	/* list of 256 ecu ptrs, that cache the claimed addresses.
+	 * also protected by the above lock
+	 */
+	struct j1939_addr_ent {
+		struct j1939_ecu *ecu;
+		/* count users, to help transport protocol */
+		int nusers;
+	} ents[256];
+
+	struct kref kref;
+
+	spinlock_t tp_session_list_lock;
+	struct list_head tp_sessionq;
+	struct list_head tp_extsessionq;
+	wait_queue_head_t tp_wait;
+};
+
+void j1939_ecu_put(struct j1939_ecu *ecu);
+
+/* keep the cache of what is local */
+int j1939_local_ecu_get(struct j1939_priv *priv, name_t name, u8 sa);
+void j1939_local_ecu_put(struct j1939_priv *priv, name_t name, u8 sa);
+
+static inline bool j1939_address_is_unicast(u8 addr)
+{
+	return addr <= J1939_MAX_UNICAST_ADDR;
+}
+
+static inline bool j1939_address_is_idle(u8 addr)
+{
+	return addr == J1939_IDLE_ADDR;
+}
+
+static inline bool j1939_address_is_valid(u8 addr)
+{
+	return addr != J1939_NO_ADDR;
+}
+
+static inline bool j1939_pgn_is_pdu1(pgn_t pgn)
+{
+	/* ignore dp & res bits for this */
+	return (pgn & 0xff00) < 0xf000;
+}
+
+/* utility to correctly unmap an ECU */
+void j1939_ecu_unmap_locked(struct j1939_ecu *ecu);
+void j1939_ecu_unmap(struct j1939_ecu *ecu);
+
+u8 j1939_name_to_addr(struct j1939_priv *priv, name_t name);
+struct j1939_ecu *j1939_ecu_find_by_addr_locked(struct j1939_priv *priv, u8 addr);
+struct j1939_ecu *j1939_ecu_get_by_addr(struct j1939_priv *priv, u8 addr);
+struct j1939_ecu *j1939_ecu_get_by_addr_locked(struct j1939_priv *priv, u8 addr);
+struct j1939_ecu *j1939_ecu_get_by_name(struct j1939_priv *priv, name_t name);
+struct j1939_ecu *j1939_ecu_get_by_name_locked(struct j1939_priv *priv, name_t name);
+
+struct j1939_addr {
+	name_t src_name;
+	name_t dst_name;
+	pgn_t pgn;
+
+	u8 sa;
+	u8 da;
+};
+
+/* control buffer of the sk_buff */
+struct j1939_sk_buff_cb {
+	struct j1939_addr addr;
+	priority_t priority;
+
+	/* Flags for quick lookups during skb processing
+	 * These are set in the receive path only
+	 */
+#define J1939_ECU_LOCAL	BIT(0)
+	u32 src_flags;
+	u32 dst_flags;
+
+	/* for tx, MSG_SYN will be used to sync on sockets */
+	u32 msg_flags;
+
+	/* j1939 clones incoming skb's.
+	 * insock saves the incoming skb->sk
+	 * to determine local generated packets
+	 */
+	struct sock *insock;
+};
+
+static inline struct j1939_sk_buff_cb *j1939_skb_to_cb(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct j1939_sk_buff_cb) > sizeof(skb->cb));
+
+	return (struct j1939_sk_buff_cb *)skb->cb;
+}
+
+int j1939_send(struct sk_buff *skb);
+void j1939_sk_recv(struct sk_buff *skb);
+
+/* stack entries */
+int j1939_tp_send(struct j1939_priv *priv, struct sk_buff *skb);
+int j1939_tp_recv(struct j1939_priv *priv, struct sk_buff *skb);
+int j1939_ac_fixup(struct j1939_priv *priv, struct sk_buff *skb);
+void j1939_ac_recv(struct j1939_priv *priv, struct sk_buff *skb);
+
+/* network management */
+struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name);
+
+void j1939_ecu_timer_start(struct j1939_ecu *ecu);
+void j1939_ecu_timer_cancel(struct j1939_ecu *ecu);
+
+int j1939_netdev_start(struct net *net, struct net_device *ndev);
+void j1939_netdev_stop(struct net_device *ndev);
+
+struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev);
+void j1939_priv_put(struct j1939_priv *priv);
+void j1939_priv_get(struct j1939_priv *priv);
+
+/* notify/alert all j1939 sockets bound to ifindex */
+void j1939_sk_netdev_event(struct net_device *ndev, int error_code);
+int j1939_tp_rmdev_notifier(struct j1939_priv *priv);
+void j1939_tp_init(struct j1939_priv *priv);
+
+/* decrement pending skb for a j1939 socket */
+void j1939_sock_pending_del(struct sock *sk);
+
+/* CAN protocol */
+extern const struct can_proto j1939_can_proto;
+
+#endif /* _J1939_PRIV_H_ */
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
new file mode 100644
index 000000000000..73d3f590adc6
--- /dev/null
+++ b/net/can/j1939/main.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2010-2011 EIA Electronics, Pieter Beyens <pieter.beyens@eia.be>
+// Copyright (c) 2010-2011 EIA Electronics, Kurt Van Dijck <kurt.van.dijck@eia.be>
+// Copyright (c) 2017-2018 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+// Copyright (c) 2017-2018 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+// Copyright (c) 2018 Protonic, Robin van der Gracht <robin@protonic.nl>
+
+/* Core of can-j1939 that links j1939 to CAN. */
+
+#include <linux/can/can-ml.h>
+#include <linux/can/core.h>
+#include <linux/if_arp.h>
+#include <linux/module.h>
+
+#include "j1939-priv.h"
+
+MODULE_DESCRIPTION("PF_CAN SAE J1939");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("EIA Electronics (Kurt Van Dijck & Pieter Beyens)");
+MODULE_ALIAS("can-proto-" __stringify(CAN_J1939));
+
+/* LOWLEVEL CAN interface */
+
+/* CAN_HDR: #bytes before can_frame data part */
+#define J1939_CAN_HDR (offsetof(struct can_frame, data))
+
+/* CAN_FTR: #bytes beyond data part */
+#define J1939_CAN_FTR (sizeof(struct can_frame) - J1939_CAN_HDR - \
+		 sizeof(((struct can_frame *)0)->data))
+
+/* lowest layer */
+static void j1939_can_recv(struct sk_buff *iskb, void *data)
+{
+	struct j1939_priv *priv = data;
+	struct sk_buff *skb;
+	struct j1939_sk_buff_cb *skcb;
+	struct can_frame *cf;
+
+	/* create a copy of the skb
+	 * j1939 only delivers the real data bytes,
+	 * the header goes into sockaddr.
+	 * j1939 may not touch the incoming skb in such way
+	 */
+	skb = skb_clone(iskb, GFP_ATOMIC);
+
+	/* get a pointer to the header of the skb
+	 * the skb payload (pointer) is moved, so that the next skb_data
+	 * returns the actual payload
+	 */
+	cf = (void *)skb->data;
+	skb_pull(skb, J1939_CAN_HDR);
+
+	/* fix length, set to dlc, with 8 maximum */
+	skb_trim(skb, min_t(uint8_t, cf->can_dlc, 8));
+
+	/* set addr */
+	skcb = j1939_skb_to_cb(skb);
+	memset(skcb, 0, sizeof(*skcb));
+
+	/* save incoming socket, without assigning the skb to it */
+	skcb->insock = iskb->sk;
+	skcb->priority = (cf->can_id >> 26) & 0x7;
+	skcb->addr.sa = cf->can_id;
+	skcb->addr.pgn = (cf->can_id >> 8) & J1939_PGN_MAX;
+	if (j1939_pgn_is_pdu1(skcb->addr.pgn)) {
+		/* Type 1: with destination address */
+		skcb->addr.da = skcb->addr.pgn;
+		/* normalize pgn: strip dst address */
+		skcb->addr.pgn &= 0x3ff00;
+	} else {
+		/* set broadcast address */
+		skcb->addr.da = J1939_NO_ADDR;
+	}
+
+	/* update localflags */
+	read_lock_bh(&priv->lock);
+	if (j1939_address_is_unicast(skcb->addr.sa) &&
+	    priv->ents[skcb->addr.sa].nusers)
+		skcb->src_flags |= J1939_ECU_LOCAL;
+	if (j1939_address_is_unicast(skcb->addr.da) &&
+	    priv->ents[skcb->addr.da].nusers)
+		skcb->dst_flags |= J1939_ECU_LOCAL;
+	read_unlock_bh(&priv->lock);
+
+	/* deliver into the j1939 stack ... */
+	j1939_ac_recv(priv, skb);
+
+	if (j1939_tp_recv(priv, skb))
+		/* this means the transport layer processed the message */
+		goto done;
+	j1939_sk_recv(skb);
+ done:
+	kfree_skb(skb);
+}
+
+/* NETDEV MANAGEMENT */
+
+/* values for can_rx_(un)register */
+#define J1939_CAN_ID CAN_EFF_FLAG
+#define J1939_CAN_MASK (CAN_EFF_FLAG | CAN_RTR_FLAG)
+
+static DEFINE_SPINLOCK(j1939_netdev_lock);
+
+static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
+{
+	struct j1939_priv *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	rwlock_init(&priv->lock);
+	INIT_LIST_HEAD(&priv->ecus);
+	priv->ndev = ndev;
+	kref_init(&priv->kref);
+	dev_hold(ndev);
+
+	return priv;
+}
+
+static inline void j1939_priv_set(struct net_device *ndev, struct j1939_priv *priv)
+{
+	struct can_ml_priv *can_ml_priv = ndev->ml_priv;
+
+	can_ml_priv->j1939_priv = priv;
+}
+
+static void __j1939_priv_release(struct kref *kref)
+{
+	struct j1939_priv *priv = container_of(kref, struct j1939_priv, kref);
+	struct net_device *ndev = priv->ndev;
+
+	can_rx_unregister(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
+			  j1939_can_recv, priv);
+
+	/* remove pending transport protocol sessions */
+	j1939_tp_rmdev_notifier(priv);
+
+	/* unlink from netdev */
+	j1939_priv_set(ndev, NULL);
+
+	dev_put(ndev);
+	kfree(priv);
+}
+
+void j1939_priv_put(struct j1939_priv *priv)
+{
+	kref_put(&priv->kref, __j1939_priv_release);
+}
+
+void j1939_priv_get(struct j1939_priv *priv)
+{
+	kref_get(&priv->kref);
+}
+
+int j1939_netdev_start(struct net *net, struct net_device *ndev)
+{
+	struct j1939_priv *priv;
+	int ret;
+
+	spin_lock(&j1939_netdev_lock);
+	priv = j1939_priv_get_by_ndev(ndev);
+	spin_unlock(&j1939_netdev_lock);
+	if (priv)
+		return 0;
+
+	priv = j1939_priv_create(ndev);
+	if (!priv)
+		return -ENOMEM;
+
+	j1939_tp_init(priv);
+
+	/* add CAN handler */
+	ret = can_rx_register(net, ndev, J1939_CAN_ID, J1939_CAN_MASK,
+			      j1939_can_recv, priv, "j1939", NULL);
+	if (ret < 0)
+		goto out_dev_put;
+
+	spin_lock(&j1939_netdev_lock);
+	if (j1939_priv_get_by_ndev(ndev)) {
+		/* Someone was faster than us, use their priv and roll
+		 * back our's.
+		 */
+		spin_unlock(&j1939_netdev_lock);
+		goto out_rx_unregister;
+	}
+	j1939_priv_set(ndev, priv);
+	spin_unlock(&j1939_netdev_lock);
+
+	return 0;
+
+ out_rx_unregister:
+	can_rx_unregister(net, ndev, J1939_CAN_ID, J1939_CAN_MASK,
+			  j1939_can_recv, priv);
+ out_dev_put:
+	dev_put(ndev);
+	kfree(priv);
+
+	return ret;
+}
+
+/* get pointer to priv without increasing ref counter */
+static inline struct j1939_priv *j1939_ndev_to_priv(struct net_device *ndev)
+{
+	struct can_ml_priv *can_ml_priv = ndev->ml_priv;
+
+	return can_ml_priv->j1939_priv;
+}
+
+void j1939_netdev_stop(struct net_device *ndev)
+{
+	struct j1939_priv *priv;
+
+	spin_lock(&j1939_netdev_lock);
+	priv = j1939_ndev_to_priv(ndev);
+	j1939_priv_put(priv);
+	spin_unlock(&j1939_netdev_lock);
+}
+
+struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev)
+{
+	struct j1939_priv *priv;
+
+	if (ndev->type != ARPHRD_CAN)
+		return NULL;
+
+	priv = j1939_ndev_to_priv(ndev);
+	if (priv)
+		j1939_priv_get(priv);
+
+	return priv;
+}
+
+static int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
+{
+	int ret, dlc;
+	canid_t canid;
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	struct can_frame *cf;
+
+	/* apply sanity checks */
+	if (j1939_pgn_is_pdu1(skcb->addr.pgn))
+		skcb->addr.pgn &= 0x3ff00;
+	else
+		skcb->addr.pgn &= J1939_PGN_MAX;
+
+	if (skcb->priority > 7)
+		skcb->priority = 6;
+
+	ret = j1939_ac_fixup(priv, skb);
+	if (unlikely(ret))
+		goto failed;
+	dlc = skb->len;
+
+	/* re-claim the CAN_HDR from the SKB */
+	cf = skb_push(skb, J1939_CAN_HDR);
+
+	/* make it a full can frame again */
+	skb_put(skb, J1939_CAN_FTR + (8 - dlc));
+
+	canid = CAN_EFF_FLAG |
+		(skcb->priority << 26) |
+		(skcb->addr.pgn << 8) |
+		skcb->addr.sa;
+	if (j1939_pgn_is_pdu1(skcb->addr.pgn))
+		canid |= skcb->addr.da << 8;
+
+	cf->can_id = canid;
+	cf->can_dlc = dlc;
+
+	return can_send(skb, 1);
+
+ failed:
+	consume_skb(skb);
+	return ret;
+}
+
+int j1939_send(struct sk_buff *skb)
+{
+	struct j1939_priv *priv;
+	int ret;
+
+	priv = j1939_priv_get_by_ndev(skb->dev);
+	if (!priv)
+		return -EINVAL;
+
+	if (skb->len > 8)
+		/* re-route via transport protocol */
+		ret = j1939_tp_send(priv, skb);
+	else
+		ret = j1939_send_one(priv, skb);
+
+	j1939_priv_put(priv);
+
+	return ret;
+}
+
+static int j1939_netdev_notify(struct notifier_block *nb,
+			       unsigned long msg, void *data)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(data);
+	struct j1939_priv *priv;
+
+	spin_lock(&j1939_netdev_lock);
+	priv = j1939_priv_get_by_ndev(ndev);
+	spin_unlock(&j1939_netdev_lock);
+	if (!priv)
+		goto notify_done;
+
+	if (!net_eq(dev_net(ndev), &init_net))
+		goto notify_put;
+
+	if (ndev->type != ARPHRD_CAN)
+		goto notify_put;
+
+	switch (msg) {
+	case NETDEV_UNREGISTER:
+		j1939_tp_rmdev_notifier(priv);
+		j1939_sk_netdev_event(ndev, ENODEV);
+		break;
+
+	case NETDEV_DOWN:
+		j1939_sk_netdev_event(ndev, ENETDOWN);
+		break;
+	}
+
+notify_put:
+	j1939_priv_put(priv);
+
+notify_done:
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block j1939_netdev_notifier = {
+	.notifier_call = j1939_netdev_notify,
+};
+
+/* MODULE interface */
+static __init int j1939_module_init(void)
+{
+	int ret;
+
+	pr_info("can: SAE J1939\n");
+
+	ret = register_netdevice_notifier(&j1939_netdev_notifier);
+	if (ret)
+		goto fail_notifier;
+
+	ret = can_proto_register(&j1939_can_proto);
+	if (ret < 0) {
+		pr_err("can: registration of j1939 protocol failed\n");
+		goto fail_sk;
+	}
+
+	return 0;
+
+ fail_sk:
+	unregister_netdevice_notifier(&j1939_netdev_notifier);
+ fail_notifier:
+	return ret;
+}
+
+static __exit void j1939_module_exit(void)
+{
+	can_proto_unregister(&j1939_can_proto);
+
+	unregister_netdevice_notifier(&j1939_netdev_notifier);
+}
+
+module_init(j1939_module_init);
+module_exit(j1939_module_exit);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
new file mode 100644
index 000000000000..3a5450a18820
--- /dev/null
+++ b/net/can/j1939/socket.c
@@ -0,0 +1,781 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2010-2011 EIA Electronics, Pieter Beyens <pieter.beyens@eia.be>
+// Copyright (c) 2010-2011 EIA Electronics, Kurt Van Dijck <kurt.van.dijck@eia.be>
+// Copyright (c) 2017-2018 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+// Copyright (c) 2017-2018 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+// Copyright (c) 2018 Protonic, Robin van der Gracht <robin@protonic.nl>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/can/core.h>
+#include <linux/can/skb.h>
+#include <linux/if_arp.h>
+
+#include "j1939-priv.h"
+
+#define J1939_MIN_NAMELEN REQUIRED_SIZE(struct sockaddr_can, can_addr.j1939)
+
+/* list of sockets */
+static struct list_head j1939_socks = LIST_HEAD_INIT(j1939_socks);
+static DEFINE_SPINLOCK(j1939_socks_lock);
+
+struct j1939_sock {
+	struct sock sk; /* must be first to skip with memset */
+	struct list_head list;
+
+#define J1939_SOCK_BOUND BIT(0)
+#define J1939_SOCK_CONNECTED BIT(1)
+#define J1939_SOCK_PROMISC BIT(2)
+#define J1939_SOCK_RECV_OWN BIT(3)
+	int state;
+
+	int ifindex;
+	struct j1939_addr addr;
+	struct j1939_filter *filters;
+	int nfilters;
+
+	/* j1939 may emit equal PGN (!= equal CAN-id's) out of order
+	 * when transport protocol comes in.
+	 * To allow emitting in order, keep a 'pending' nr. of packets
+	 */
+	atomic_t skb_pending;
+	wait_queue_head_t waitq;
+};
+
+static inline struct j1939_sock *j1939_sk(const struct sock *sk)
+{
+	return container_of(sk, struct j1939_sock, sk);
+}
+
+/* conversion function between struct sock::sk_priority from linux and
+ * j1939 priority field
+ */
+static inline priority_t j1939_prio(u32 sk_priority)
+{
+	sk_priority = min(sk_priority, 7U);
+
+	return 7 - sk_priority;
+}
+
+static inline u32 j1939_to_sk_priority(priority_t prio)
+{
+	return 7 - prio;
+}
+
+/* function to see if pgn is to be evaluated */
+static inline bool j1939_pgn_is_valid(pgn_t pgn)
+{
+	return pgn <= J1939_PGN_MAX;
+}
+
+/* test function to avoid non-zero DA placeholder for pdu1 pgn's */
+static inline bool j1939_pgn_is_clean_pdu(pgn_t pgn)
+{
+	if (j1939_pgn_is_pdu1(pgn))
+		return !(pgn & 0xff);
+	else
+		return true;
+}
+
+/* j1939_sock_pending_add_first
+ * Succeeds when the first pending SKB is scheduled
+ * Fails when SKB are already pending
+ */
+static inline int j1939_sock_pending_add_first(struct sock *sk)
+{
+	struct j1939_sock *jsk = j1939_sk(sk);
+
+	/* atomic_cmpxchg returns the old value
+	 * When it was 0, it is exchanged with 1 and this function
+	 * succeeded. (return 1)
+	 * When it was != 0, it is not exchanged, and this function
+	 * fails (returns 0).
+	 */
+	return !atomic_cmpxchg(&jsk->skb_pending, 0, 1);
+}
+
+static inline void j1939_sock_pending_add(struct sock *sk)
+{
+	struct j1939_sock *jsk = j1939_sk(sk);
+
+	atomic_inc(&jsk->skb_pending);
+}
+
+void j1939_sock_pending_del(struct sock *sk)
+{
+	struct j1939_sock *jsk = j1939_sk(sk);
+
+	/* atomic_dec_return returns the new value */
+	if (!atomic_dec_return(&jsk->skb_pending))
+		wake_up(&jsk->waitq);	/* no pending SKB's */
+}
+
+/* matches skb control buffer (addr) with a j1939 filter */
+static inline bool j1939_packet_match(const struct j1939_sk_buff_cb *skcb,
+				      const struct j1939_filter *f, int nfilter)
+{
+	if (!nfilter)
+		/* receive all when no filters are assigned */
+		return true;
+
+	/* Filters relying on the addr for static addressing _should_ get
+	 * packets from dynamic addressed ECU's too if they match their SA.
+	 * Sockets using dynamic addressing in their filters should not set it.
+	 */
+	for (; nfilter; ++f, --nfilter) {
+		if ((skcb->addr.pgn & f->pgn_mask) != (f->pgn & f->pgn_mask))
+			continue;
+		if ((skcb->addr.sa & f->addr_mask) != (f->addr & f->addr_mask))
+			continue;
+		if ((skcb->addr.src_name & f->name_mask) !=
+		    (f->name & f->name_mask))
+			continue;
+		return true;
+	}
+	return false;
+}
+
+static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
+{
+	struct sk_buff *skb;
+	const struct j1939_sk_buff_cb *oskcb = j1939_skb_to_cb(oskb);
+	const struct can_skb_priv *oskb_prv = can_skb_prv(oskb);
+	struct j1939_sk_buff_cb *skcb;
+
+	if (!(jsk->state & (J1939_SOCK_BOUND | J1939_SOCK_CONNECTED)))
+		return;
+	if (jsk->ifindex != oskb_prv->ifindex)
+		/* this socket does not take packets from this iface */
+		return;
+	if (!(jsk->state & J1939_SOCK_PROMISC)) {
+		if (jsk->addr.src_name) {
+			/* reject message for other destinations */
+			if (oskcb->addr.dst_name &&
+			    oskcb->addr.dst_name != jsk->addr.src_name)
+				/* the msg is not destined for the name
+				 * that the socket is bound to
+				 */
+				return;
+		} else {
+			/* reject messages for other destination addresses */
+			if (j1939_address_is_unicast(oskcb->addr.da) &&
+			    oskcb->addr.da != jsk->addr.sa)
+				/* the msg is not destined for the name
+				 * that the socket is bound to
+				 */
+				return;
+		}
+	}
+
+	if (oskcb->insock == &jsk->sk && !(jsk->state & J1939_SOCK_RECV_OWN))
+		/* own message */
+		return;
+
+	if (!j1939_packet_match(oskcb, jsk->filters, jsk->nfilters))
+		return;
+
+	skb = skb_clone(oskb, GFP_ATOMIC);
+	if (!skb) {
+		pr_warn("skb clone failed\n");
+		return;
+	}
+	skcb = j1939_skb_to_cb(skb);
+	skcb->msg_flags &= ~(MSG_DONTROUTE | MSG_CONFIRM);
+	if (skcb->insock)
+		skcb->msg_flags |= MSG_DONTROUTE;
+	if (skcb->insock == &jsk->sk)
+		skcb->msg_flags |= MSG_CONFIRM;
+
+	if (sock_queue_rcv_skb(&jsk->sk, skb) < 0)
+		kfree_skb(skb);
+}
+
+void j1939_sk_recv(struct sk_buff *skb)
+{
+	struct j1939_sock *jsk;
+
+	spin_lock_bh(&j1939_socks_lock);
+	list_for_each_entry(jsk, &j1939_socks, list) {
+		j1939_sk_recv_one(jsk, skb);
+	}
+	spin_unlock_bh(&j1939_socks_lock);
+}
+
+static int j1939_sk_init(struct sock *sk)
+{
+	struct j1939_sock *jsk = j1939_sk(sk);
+
+	INIT_LIST_HEAD(&jsk->list);
+	init_waitqueue_head(&jsk->waitq);
+	jsk->sk.sk_priority = j1939_to_sk_priority(6);
+	jsk->sk.sk_reuse = 1; /* per default */
+	jsk->addr.sa = J1939_NO_ADDR;
+	jsk->addr.da = J1939_NO_ADDR;
+	jsk->addr.pgn = J1939_NO_PGN;
+	atomic_set(&jsk->skb_pending, 0);
+	return 0;
+}
+
+static int j1939_sk_sanity_check(struct sockaddr_can *addr, int len)
+{
+	if (!addr)
+		return -EDESTADDRREQ;
+	if (len < J1939_MIN_NAMELEN)
+		return -EINVAL;
+	if (addr->can_family != AF_CAN)
+		return -EINVAL;
+	if (!addr->can_ifindex)
+		return -ENODEV;
+	if (j1939_pgn_is_valid(addr->can_addr.j1939.pgn) &&
+	    !j1939_pgn_is_clean_pdu(addr->can_addr.j1939.pgn))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
+{
+	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
+	struct j1939_sock *jsk = j1939_sk(sock->sk);
+	struct sock *sk = sock->sk;
+	struct net *net = sock_net(sk);
+	struct net_device *ndev;
+	struct j1939_priv *priv;
+	int ret = 0;
+
+	ret = j1939_sk_sanity_check(addr, len);
+	if (ret)
+		return ret;
+
+	lock_sock(sock->sk);
+
+	ndev = dev_get_by_index(net, addr->can_ifindex);
+	if (!ndev) {
+		ret = -ENODEV;
+		goto out_release_sock;
+	}
+
+	/* Already bound to an interface? */
+	if (jsk->state & J1939_SOCK_BOUND) {
+		/* A re-bind() to a different interface is not
+		 * supported.
+		 */
+		if (jsk->ifindex != addr->can_ifindex) {
+			ret = -EINVAL;
+			goto out_dev_put;
+		}
+
+		/* drop old references */
+		priv = j1939_priv_get_by_ndev(ndev);
+		j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
+	} else {
+		if (ndev->type != ARPHRD_CAN) {
+			ret = -ENODEV;
+			goto out_dev_put;
+		}
+
+		ret = j1939_netdev_start(net, ndev);
+		if (ret < 0)
+			goto out_dev_put;
+
+		jsk->ifindex = addr->can_ifindex;
+		priv = j1939_priv_get_by_ndev(ndev);
+	}
+
+	/* set default transmit pgn */
+	if (j1939_pgn_is_valid(addr->can_addr.j1939.pgn))
+		jsk->addr.pgn = addr->can_addr.j1939.pgn;
+	jsk->addr.src_name = addr->can_addr.j1939.name;
+	jsk->addr.sa = addr->can_addr.j1939.addr;
+
+	/* get new references */
+	ret = j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
+	j1939_priv_put(priv);
+	if (ret) {
+		j1939_netdev_stop(ndev);
+		goto out_dev_put;
+	}
+
+	if (!(jsk->state & J1939_SOCK_BOUND)) {
+		spin_lock_bh(&j1939_socks_lock);
+		list_add_tail(&jsk->list, &j1939_socks);
+		spin_unlock_bh(&j1939_socks_lock);
+
+		jsk->state |= J1939_SOCK_BOUND;
+	}
+
+ out_dev_put:	/* fallthrough */
+	dev_put(ndev);
+ out_release_sock:
+	release_sock(sock->sk);
+
+	return ret;
+}
+
+static int j1939_sk_connect(struct socket *sock, struct sockaddr *uaddr,
+			    int len, int flags)
+{
+	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
+	struct j1939_sock *jsk = j1939_sk(sock->sk);
+	int ret = 0;
+
+	ret = j1939_sk_sanity_check(addr, len);
+	if (ret)
+		return ret;
+
+	lock_sock(sock->sk);
+
+	/* bind() before connect() is mandatory */
+	if (!(jsk->state & J1939_SOCK_BOUND)) {
+		ret = -EINVAL;
+		goto out_release_sock;
+	}
+
+	/* A re-connect() is not supported */
+	if (jsk->state & J1939_SOCK_CONNECTED) {
+		ret = -EBUSY;
+		goto out_release_sock;
+	}
+
+	jsk->addr.dst_name = addr->can_addr.j1939.name;
+	jsk->addr.da = addr->can_addr.j1939.addr;
+
+	if (j1939_pgn_is_valid(addr->can_addr.j1939.pgn))
+		jsk->addr.pgn = addr->can_addr.j1939.pgn;
+
+	jsk->state |= J1939_SOCK_CONNECTED;
+
+ out_release_sock: /* fallthrough */
+	release_sock(sock->sk);
+	return ret;
+}
+
+static void j1939_sk_sock2sockaddr_can(struct sockaddr_can *addr,
+				       const struct j1939_sock *jsk, int peer)
+{
+	addr->can_family = AF_CAN;
+	addr->can_ifindex = jsk->ifindex;
+	addr->can_addr.j1939.pgn = jsk->addr.pgn;
+	if (peer) {
+		addr->can_addr.j1939.name = jsk->addr.dst_name;
+		addr->can_addr.j1939.addr = jsk->addr.da;
+	} else {
+		addr->can_addr.j1939.name = jsk->addr.src_name;
+		addr->can_addr.j1939.addr = jsk->addr.sa;
+	}
+}
+
+static int j1939_sk_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
+{
+	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
+	struct sock *sk = sock->sk;
+	struct j1939_sock *jsk = j1939_sk(sk);
+	int ret = 0;
+
+	lock_sock(sk);
+
+	if (peer && !(jsk->state & J1939_SOCK_CONNECTED)) {
+		ret = -EADDRNOTAVAIL;
+		goto failure;
+	}
+
+	j1939_sk_sock2sockaddr_can(addr, jsk, peer);
+	ret = J1939_MIN_NAMELEN;
+
+ failure:
+	release_sock(sk);
+
+	return ret;
+}
+
+static int j1939_sk_release(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	struct j1939_sock *jsk;
+	struct j1939_priv *priv;
+
+	if (!sk)
+		return 0;
+
+	jsk = j1939_sk(sk);
+	lock_sock(sk);
+
+	if (jsk->state & J1939_SOCK_BOUND) {
+		struct net_device *ndev;
+
+		spin_lock_bh(&j1939_socks_lock);
+		list_del_init(&jsk->list);
+		spin_unlock_bh(&j1939_socks_lock);
+
+		ndev = dev_get_by_index(sock_net(sk), jsk->ifindex);
+		if (ndev) {
+			priv = j1939_priv_get_by_ndev(ndev);
+			j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
+			j1939_priv_put(priv);
+
+			j1939_netdev_stop(ndev);
+			dev_put(ndev);
+		}
+	}
+
+	sock_orphan(sk);
+	sock->sk = NULL;
+
+	release_sock(sk);
+	sock_put(sk);
+
+	return 0;
+}
+
+static int j1939_sk_setsockopt_flag(struct j1939_sock *jsk, char __user *optval,
+				    unsigned int optlen, int flag)
+{
+	int tmp;
+
+	if (optlen != sizeof(tmp))
+		return -EINVAL;
+	if (copy_from_user(&tmp, optval, optlen))
+		return -EFAULT;
+	lock_sock(&jsk->sk);
+	if (tmp)
+		jsk->state |= flag;
+	else
+		jsk->state &= ~flag;
+	release_sock(&jsk->sk);
+	return tmp;
+}
+
+static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, unsigned int optlen)
+{
+	struct sock *sk = sock->sk;
+	struct j1939_sock *jsk = j1939_sk(sk);
+	int tmp, count = 0;
+	struct j1939_filter *filters = NULL, *ofilters;
+
+	if (level != SOL_CAN_J1939)
+		return -EINVAL;
+
+	switch (optname) {
+	case SO_J1939_FILTER:
+		if (optval) {
+			if (optlen % sizeof(*filters) != 0)
+				return -EINVAL;
+
+			if (optlen > J1939_FILTER_MAX *
+			    sizeof(struct j1939_filter))
+				return -EINVAL;
+
+			count = optlen / sizeof(*filters);
+			filters = memdup_user(optval, optlen);
+			if (IS_ERR(filters))
+				return PTR_ERR(filters);
+		}
+
+		spin_lock_bh(&j1939_socks_lock);
+		ofilters = jsk->filters;
+		jsk->filters = filters;
+		jsk->nfilters = count;
+		spin_unlock_bh(&j1939_socks_lock);
+		kfree(ofilters);
+		return 0;
+	case SO_J1939_PROMISC:
+		return j1939_sk_setsockopt_flag(jsk, optval, optlen,
+						J1939_SOCK_PROMISC);
+	case SO_J1939_RECV_OWN:
+		return j1939_sk_setsockopt_flag(jsk, optval, optlen,
+						J1939_SOCK_RECV_OWN);
+	case SO_J1939_SEND_PRIO:
+		if (optlen != sizeof(tmp))
+			return -EINVAL;
+		if (copy_from_user(&tmp, optval, optlen))
+			return -EFAULT;
+		if (tmp < 0 || tmp > 7)
+			return -EDOM;
+		if (tmp < 2 && !capable(CAP_NET_ADMIN))
+			return -EPERM;
+		lock_sock(&jsk->sk);
+		jsk->sk.sk_priority = j1939_to_sk_priority(tmp);
+		release_sock(&jsk->sk);
+		return 0;
+	default:
+		return -ENOPROTOOPT;
+	}
+}
+
+static int j1939_sk_getsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = sock->sk;
+	struct j1939_sock *jsk = j1939_sk(sk);
+	int ret, ulen;
+	/* set defaults for using 'int' properties */
+	int tmp = 0;
+	int len = sizeof(tmp);
+	void *val = &tmp;
+
+	if (level != SOL_CAN_J1939)
+		return -EINVAL;
+	if (get_user(ulen, optlen))
+		return -EFAULT;
+	if (ulen < 0)
+		return -EINVAL;
+
+	lock_sock(&jsk->sk);
+	switch (optname) {
+	case SO_J1939_PROMISC:
+		tmp = (jsk->state & J1939_SOCK_PROMISC) ? 1 : 0;
+		break;
+	case SO_J1939_RECV_OWN:
+		tmp = (jsk->state & J1939_SOCK_RECV_OWN) ? 1 : 0;
+		break;
+	case SO_J1939_SEND_PRIO:
+		tmp = j1939_prio(jsk->sk.sk_priority);
+		break;
+	default:
+		ret = -ENOPROTOOPT;
+		goto no_copy;
+	}
+
+	/* copy to user, based on 'len' & 'val'
+	 * but most sockopt's are 'int' properties, and have 'len' & 'val'
+	 * left unchanged, but instead modified 'tmp'
+	 */
+	if (len > ulen)
+		ret = -EFAULT;
+	else if (put_user(len, optlen))
+		ret = -EFAULT;
+	else if (copy_to_user(optval, val, len))
+		ret = -EFAULT;
+	else
+		ret = 0;
+ no_copy:
+	release_sock(&jsk->sk);
+	return ret;
+}
+
+static int j1939_sk_recvmsg(struct socket *sock, struct msghdr *msg,
+			    size_t size, int flags)
+{
+	struct sock *sk = sock->sk;
+	struct sk_buff *skb;
+	struct j1939_sk_buff_cb *skcb;
+	int ret = 0;
+
+	skb = skb_recv_datagram(sk, flags, 0, &ret);
+	if (!skb)
+		return ret;
+
+	if (size < skb->len)
+		msg->msg_flags |= MSG_TRUNC;
+	else
+		size = skb->len;
+
+	ret = memcpy_to_msg(msg, skb->data, size);
+	if (ret < 0) {
+		skb_free_datagram(sk, skb);
+		return ret;
+	}
+
+	skcb = j1939_skb_to_cb(skb);
+	if (j1939_address_is_valid(skcb->addr.da))
+		put_cmsg(msg, SOL_CAN_J1939, SCM_J1939_DEST_ADDR,
+			 sizeof(skcb->addr.da), &skcb->addr.da);
+
+	if (skcb->addr.dst_name)
+		put_cmsg(msg, SOL_CAN_J1939, SCM_J1939_DEST_NAME,
+			 sizeof(skcb->addr.dst_name), &skcb->addr.dst_name);
+
+	put_cmsg(msg, SOL_CAN_J1939, SCM_J1939_PRIO,
+		 sizeof(skcb->priority), &skcb->priority);
+
+	if (msg->msg_name) {
+		struct sockaddr_can *paddr = msg->msg_name;
+
+		msg->msg_namelen = J1939_MIN_NAMELEN;
+		memset(msg->msg_name, 0, msg->msg_namelen);
+		paddr->can_family = AF_CAN;
+		paddr->can_ifindex = skb->skb_iif;
+		paddr->can_addr.j1939.name = skcb->addr.src_name;
+		paddr->can_addr.j1939.addr = skcb->addr.sa;
+		paddr->can_addr.j1939.pgn = skcb->addr.pgn;
+	}
+
+	sock_recv_ts_and_drops(msg, sk, skb);
+	msg->msg_flags |= skcb->msg_flags;
+	skb_free_datagram(sk, skb);
+
+	return size;
+}
+
+static int j1939_sk_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
+{
+	struct sock *sk = sock->sk;
+	struct j1939_sock *jsk = j1939_sk(sk);
+	struct sockaddr_can *addr = msg->msg_name;
+	struct j1939_sk_buff_cb *skcb;
+	struct sk_buff *skb;
+	struct net_device *ndev;
+	int ifindex;
+	int ret;
+
+	/* various socket state tests */
+	if (!(jsk->state & J1939_SOCK_BOUND))
+		return -EBADFD;
+
+	ifindex = jsk->ifindex;
+
+	if (jsk->addr.sa == J1939_NO_ADDR && !jsk->addr.src_name)
+		/* no address assigned yet */
+		return -EBADFD;
+
+	/* deal with provided address info */
+	if (msg->msg_name) {
+		if (msg->msg_namelen < J1939_MIN_NAMELEN)
+			return -EINVAL;
+		if (addr->can_family != AF_CAN)
+			return -EINVAL;
+		if (j1939_pgn_is_valid(addr->can_addr.j1939.pgn) &&
+		    !j1939_pgn_is_clean_pdu(addr->can_addr.j1939.pgn))
+			return -EINVAL;
+		/* TODO: always check if ifindex is correct? */
+		if (addr->can_ifindex && ifindex != addr->can_ifindex)
+			return -EBADFD;
+	}
+
+	ndev = dev_get_by_index(sock_net(sk), ifindex);
+	if (!ndev)
+		return -ENXIO;
+
+	skb = sock_alloc_send_skb(sk,
+				  size +
+				  sizeof(struct can_frame) -
+				  sizeof(((struct can_frame *)NULL)->data) +
+				  sizeof(struct can_skb_priv),
+				  msg->msg_flags & MSG_DONTWAIT, &ret);
+	if (!skb)
+		goto put_dev;
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = ndev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
+	skb_reserve(skb, offsetof(struct can_frame, data));
+
+	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
+	if (ret < 0)
+		goto free_skb;
+	sock_tx_timestamp(sk, skb->sk->sk_tsflags, &skb_shinfo(skb)->tx_flags);
+
+	skb->dev = ndev;
+
+	skcb = j1939_skb_to_cb(skb);
+	memset(skcb, 0, sizeof(*skcb));
+	skcb->addr = jsk->addr;
+	skcb->priority = j1939_prio(sk->sk_priority);
+	skcb->msg_flags = msg->msg_flags;
+
+	if (msg->msg_name) {
+		struct sockaddr_can *addr = msg->msg_name;
+
+		if (addr->can_addr.j1939.name ||
+		    addr->can_addr.j1939.addr != J1939_NO_ADDR) {
+			skcb->addr.dst_name = addr->can_addr.j1939.name;
+			skcb->addr.da = addr->can_addr.j1939.addr;
+		}
+		if (j1939_pgn_is_valid(addr->can_addr.j1939.pgn))
+			skcb->addr.pgn = addr->can_addr.j1939.pgn;
+	}
+	if (!j1939_pgn_is_valid(skcb->addr.pgn)) {
+		ret = -EINVAL;
+		goto free_skb;
+	}
+
+	if (skcb->msg_flags & MSG_SYN) {
+		if (skcb->msg_flags & MSG_DONTWAIT) {
+			ret = j1939_sock_pending_add_first(&jsk->sk);
+			if (ret > 0)
+				ret = -EAGAIN;
+		} else {
+			ret = wait_event_interruptible(jsk->waitq,
+						       j1939_sock_pending_add_first(&jsk->sk));
+		}
+		if (ret < 0)
+			goto free_skb;
+	} else {
+		j1939_sock_pending_add(&jsk->sk);
+	}
+
+	ret = j1939_send(skb);
+	if (ret < 0)
+		j1939_sock_pending_del(&jsk->sk);
+
+	dev_put(ndev);
+	return (ret < 0) ? ret : size;
+
+ free_skb:
+	kfree_skb(skb);
+ put_dev:
+	dev_put(ndev);
+	return ret;
+}
+
+void j1939_sk_netdev_event(struct net_device *ndev, int error_code)
+{
+	struct j1939_sock *jsk;
+
+	spin_lock_bh(&j1939_socks_lock);
+	list_for_each_entry(jsk, &j1939_socks, list) {
+		if (jsk->ifindex != ndev->ifindex)
+			continue;
+
+		jsk->sk.sk_err = error_code;
+		if (!sock_flag(&jsk->sk, SOCK_DEAD))
+			jsk->sk.sk_error_report(&jsk->sk);
+
+		if (error_code == ENODEV) {
+			struct j1939_priv *priv;
+
+			priv = j1939_priv_get_by_ndev(ndev);
+			j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
+			j1939_priv_put(priv);
+
+			j1939_netdev_stop(ndev);
+		}
+		/* do not remove filters here */
+	}
+	spin_unlock_bh(&j1939_socks_lock);
+}
+
+static const struct proto_ops j1939_ops = {
+	.family = PF_CAN,
+	.release = j1939_sk_release,
+	.bind = j1939_sk_bind,
+	.connect = j1939_sk_connect,
+	.socketpair = sock_no_socketpair,
+	.accept = sock_no_accept,
+	.getname = j1939_sk_getname,
+	.poll = datagram_poll,
+	.ioctl = can_ioctl,
+	.listen = sock_no_listen,
+	.shutdown = sock_no_shutdown,
+	.setsockopt = j1939_sk_setsockopt,
+	.getsockopt = j1939_sk_getsockopt,
+	.sendmsg = j1939_sk_sendmsg,
+	.recvmsg = j1939_sk_recvmsg,
+	.mmap = sock_no_mmap,
+	.sendpage = sock_no_sendpage,
+};
+
+static struct proto j1939_proto __read_mostly = {
+	.name = "CAN_J1939",
+	.owner = THIS_MODULE,
+	.obj_size = sizeof(struct j1939_sock),
+	.init = j1939_sk_init,
+};
+
+const struct can_proto j1939_can_proto = {
+	.type = SOCK_DGRAM,
+	.protocol = CAN_J1939,
+	.ops = &j1939_ops,
+	.prot = &j1939_proto,
+};
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
new file mode 100644
index 000000000000..27cf1738f77a
--- /dev/null
+++ b/net/can/j1939/transport.c
@@ -0,0 +1,1333 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2010-2011 EIA Electronics, Kurt Van Dijck <kurt.van.dijck@eia.be>
+// Copyright (c) 2017-2018 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+// Copyright (c) 2017-2018 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+// Copyright (c) 2018 Protonic, Robin van der Gracht <robin@protonic.nl>
+
+#include <linux/can/skb.h>
+
+#include "j1939-priv.h"
+
+#define J1939_REGULAR 0
+#define J1939_EXTENDED 1
+
+#define J1939_ETP_PGN_CTL 0xc800
+#define J1939_ETP_PGN_DAT 0xc700
+#define J1939_TP_PGN_CTL 0xec00
+#define J1939_TP_PGN_DAT 0xeb00
+
+#define J1939_TP_CMD_RTS 0x10
+#define J1939_TP_CMD_CTS 0x11
+#define J1939_TP_CMD_EOMA 0x13
+#define J1939_TP_CMD_BAM 0x20
+#define J1939_TP_CMD_ABORT 0xff
+
+#define J1939_ETP_CMD_RTS 0x14
+#define J1939_ETP_CMD_CTS 0x15
+#define J1939_ETP_CMD_DPO 0x16
+#define J1939_ETP_CMD_EOMA 0x17
+#define J1939_ETP_CMD_ABORT 0xff
+
+enum j1939_xtp_abort {
+	J1939_XTP_ABORT_NO_ERROR = 0,
+	J1939_XTP_ABORT_BUSY = 1,
+	J1939_XTP_ABORT_RESOURCE = 2,
+	J1939_XTP_ABORT_TIMEOUT = 3,
+	J1939_XTP_ABORT_GENERIC = 4,
+	J1939_XTP_ABORT_FAULT = 5,
+};
+
+#define J1939_MAX_TP_PACKET_SIZE (7 * 0xff)
+#define J1939_MAX_ETP_PACKET_SIZE (7 * 0x00ffffff)
+
+static unsigned int j1939_tp_block = 255;
+static unsigned int j1939_tp_max_packet_size = J1939_MAX_ETP_PACKET_SIZE;
+static unsigned int j1939_tp_retry_ms = 20;
+static unsigned int j1939_tp_packet_delay;
+static unsigned int j1939_tp_padding = 1;
+
+struct j1939_session {
+	struct j1939_priv *priv;
+	struct list_head list;
+	struct kref kref;
+	spinlock_t lock;
+
+	/* ifindex, src, dst, pgn define the session block
+	 * the are _never_ modified after insertion in the list
+	 * this decreases locking problems a _lot_
+	 */
+	struct j1939_sk_buff_cb *skcb;
+	struct sk_buff *skb;
+
+	/* all tx related stuff (last_txcmd, pkt.tx)
+	 * is protected (modified only) with the txtimer hrtimer
+	 * 'total' & 'block' are never changed,
+	 * last_cmd, last & block are protected by ->lock
+	 * this means that the tx may run after cts is received that should
+	 * have stopped tx, but this time discrepancy is never avoided anyhow
+	 */
+	u8 last_cmd, last_txcmd;
+	bool transmission;
+	bool extd;
+	struct {
+		/* these do not require 16 bit, they should fit in u8
+		 * but putting in int makes it easier to deal with
+		 */
+		unsigned int total, done, last, tx;
+		unsigned int block; /* for TP */
+		unsigned int dpo; /* for ETP */
+	} pkt;
+	struct hrtimer txtimer, rxtimer;
+};
+
+/* helpers */
+static inline void j1939_fix_cb(struct j1939_sk_buff_cb *skcb)
+{
+	skcb->msg_flags &= ~MSG_SYN;
+}
+
+static inline struct list_head *j1939_sessionq(struct j1939_priv *priv, bool extd)
+{
+	if (extd)
+		return &priv->tp_extsessionq;
+	else
+		return &priv->tp_sessionq;
+}
+
+static inline void j1939_session_list_lock(struct j1939_priv *priv)
+{
+	spin_lock_bh(&priv->tp_session_list_lock);
+}
+
+static inline void j1939_session_list_unlock(struct j1939_priv *priv)
+{
+	spin_unlock_bh(&priv->tp_session_list_lock);
+}
+
+static void j1939_session_list_add(struct j1939_session *session, struct list_head *list)
+{
+	list_add_tail(&session->list, list);
+}
+
+static void j1939_session_list_del(struct j1939_session *session)
+{
+	list_del_init(&session->list);
+}
+
+static inline void j1939_session_get(struct j1939_session *session)
+{
+	kref_get(&session->kref);
+}
+
+static void j1939_session_destroy(struct j1939_session *session)
+{
+	j1939_session_list_lock(session->priv);
+	j1939_session_list_del(session);
+	j1939_session_list_unlock(session->priv);
+	kfree_skb(session->skb);
+	j1939_priv_put(session->priv);
+	kfree(session);
+}
+
+static void __j1939_session_release(struct kref *kref)
+{
+	struct j1939_session *session = container_of(kref, struct j1939_session, kref);
+
+	j1939_session_destroy(session);
+}
+
+static inline void j1939_session_put(struct j1939_session *session)
+{
+	kref_put(&session->kref, __j1939_session_release);
+}
+
+static void j1939_session_txtimer_cancel(struct j1939_session *session)
+{
+	if (hrtimer_cancel(&session->txtimer))
+		j1939_session_put(session);
+}
+
+static void j1939_session_rxtimer_cancel(struct j1939_session *session)
+{
+	if (hrtimer_cancel(&session->rxtimer))
+		j1939_session_put(session);
+}
+
+static void j1939_session_timers_cancel(struct j1939_session *session)
+{
+	j1939_session_txtimer_cancel(session);
+	j1939_session_rxtimer_cancel(session);
+}
+
+static inline bool j1939_cb_is_broadcast(const struct j1939_sk_buff_cb *skcb)
+{
+	return (!skcb->addr.dst_name && (skcb->addr.da == 0xff));
+}
+
+/* transport status locking */
+static inline void j1939_session_lock(struct j1939_session *session)
+{
+	spin_lock_bh(&session->lock);
+}
+
+static inline void j1939_session_unlock(struct j1939_session *session)
+{
+	spin_unlock_bh(&session->lock);
+}
+
+/* see if we are receiver
+ * returns 0 for broadcasts, although we will receive them
+ */
+static inline int j1939_tp_im_receiver(struct sk_buff *skb)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+
+	return skcb->dst_flags & J1939_ECU_LOCAL;
+}
+
+/* see if we are sender */
+static inline int j1939_tp_im_transmitter(struct sk_buff *skb)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+
+	return skcb->src_flags & J1939_ECU_LOCAL;
+}
+
+/* see if we are involved as either receiver or transmitter */
+static int j1939_tp_im_involved(struct sk_buff *skb, bool swap)
+{
+	if (swap)
+		return j1939_tp_im_receiver(skb);
+	else
+		return j1939_tp_im_transmitter(skb);
+}
+
+static int j1939_tp_im_involved_anydir(struct sk_buff *skb)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+
+	return (skcb->src_flags | skcb->dst_flags) & J1939_ECU_LOCAL;
+}
+
+/* extract pgn from flow-ctl message */
+static inline pgn_t j1939_xtp_ctl_to_pgn(const u8 *dat)
+{
+	pgn_t pgn;
+
+	pgn = (dat[7] << 16) | (dat[6] << 8) | (dat[5] << 0);
+	if (j1939_pgn_is_pdu1(pgn))
+		pgn &= 0xffff00;
+	return pgn;
+}
+
+static inline unsigned int j1939_tp_ctl_to_size(const u8 *dat)
+{
+	return (dat[2] << 8) + (dat[1] << 0);
+}
+
+static inline unsigned int j1939_etp_ctl_to_packet(const u8 *dat)
+{
+	return (dat[4] << 16) | (dat[3] << 8) | (dat[2] << 0);
+}
+
+static inline unsigned int j1939_etp_ctl_to_size(const u8 *dat)
+{
+	return (dat[4] << 24) | (dat[3] << 16) |
+		(dat[2] << 8) | (dat[1] << 0);
+}
+
+/* find existing session:
+ * reverse: swap cb's src & dst
+ * there is no problem with matching broadcasts, since
+ * broadcasts (no dst, no da) would never call this
+ * with reverse == true
+ */
+static bool j1939_session_match(struct j1939_session *session, struct sk_buff *skb,
+				bool reverse)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+
+	if (can_skb_prv(session->skb)->ifindex != can_skb_prv(skb)->ifindex)
+		return false;
+	if (reverse) {
+		if (session->skcb->addr.src_name) {
+			if (session->skcb->addr.src_name != skcb->addr.dst_name)
+				return false;
+		} else if (session->skcb->addr.sa != skcb->addr.da) {
+			return false;
+		}
+
+		if (session->skcb->addr.dst_name) {
+			if (session->skcb->addr.dst_name != skcb->addr.src_name)
+				return false;
+		} else if (session->skcb->addr.da != skcb->addr.sa) {
+			return false;
+		}
+	} else {
+		if (session->skcb->addr.src_name) {
+			if (session->skcb->addr.src_name != skcb->addr.src_name)
+				return false;
+		} else if (session->skcb->addr.sa != skcb->addr.sa) {
+			return false;
+		}
+
+		if (session->skcb->addr.dst_name) {
+			if (session->skcb->addr.dst_name != skcb->addr.dst_name)
+				return false;
+		} else if (session->skcb->addr.da != skcb->addr.da) {
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static struct j1939_session *j1939_session_get_by_skb_locked(struct j1939_priv *priv, struct list_head *root,
+						  struct sk_buff *skb, bool reverse)
+{
+	struct j1939_session *session;
+
+	lockdep_assert_held(&priv->tp_session_list_lock);
+
+	list_for_each_entry(session, root, list) {
+		j1939_session_get(session);
+		if (j1939_session_match(session, skb, reverse))
+			return session;
+		j1939_session_put(session);
+	}
+
+	return NULL;
+}
+
+static struct j1939_session *j1939_session_get_by_skb(struct j1939_priv *priv, struct list_head *root,
+					   struct sk_buff *skb, bool reverse)
+{
+	struct j1939_session *session;
+
+	j1939_session_list_lock(priv);
+	session = j1939_session_get_by_skb_locked(priv, root, skb, reverse);
+	j1939_session_list_unlock(priv);
+
+	return session;
+}
+
+static void j1939_skbcb_swap(struct j1939_sk_buff_cb *skcb)
+{
+	swap(skcb->addr.dst_name, skcb->addr.src_name);
+	swap(skcb->addr.da, skcb->addr.sa);
+	swap(skcb->dst_flags, skcb->src_flags);
+}
+
+static struct sk_buff *j1939_tp_tx_dat_new(struct sk_buff *related,
+					    bool extd, bool ctl, bool swap_src_dst)
+{
+	struct sk_buff *skb;
+	struct j1939_sk_buff_cb *skcb;
+
+	skb = alloc_skb(sizeof(struct can_frame) + sizeof(struct can_skb_priv),
+			GFP_ATOMIC);
+	if (unlikely(!skb))
+		return ERR_PTR(-ENOMEM);
+
+	skb->dev = related->dev;
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = can_skb_prv(related)->ifindex;
+	/* reserve CAN header */
+	skb_reserve(skb, offsetof(struct can_frame, data));
+	skb->protocol = related->protocol;
+	skb->pkt_type = related->pkt_type;
+	skb->ip_summed = related->ip_summed;
+
+	memcpy(skb->cb, related->cb, sizeof(skb->cb));
+	skcb = j1939_skb_to_cb(skb);
+	j1939_fix_cb(skcb);
+	if (swap_src_dst)
+		j1939_skbcb_swap(skcb);
+
+	if (ctl) {
+		if (extd)
+			skcb->addr.pgn = J1939_ETP_PGN_CTL;
+		else
+			skcb->addr.pgn = J1939_TP_PGN_CTL;
+	} else {
+		if (extd)
+			skcb->addr.pgn = J1939_ETP_PGN_DAT;
+		else
+			skcb->addr.pgn = J1939_TP_PGN_DAT;
+	}
+
+	return skb;
+}
+
+/* TP transmit packet functions */
+static int j1939_tp_tx_dat(struct sk_buff *related, bool extd,
+			   const u8 *dat, int len)
+{
+	struct sk_buff *skb;
+
+	skb = j1939_tp_tx_dat_new(related, extd, false, false);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	skb_put_data(skb, dat, len);
+	if (j1939_tp_padding && len < 8)
+		memset(skb_put(skb, 8 - len), 0xff, 8 - len);
+
+	return j1939_send(skb);
+}
+
+static int j1939_xtp_do_tx_ctl(struct sk_buff *related, bool extd,
+			       bool swap_src_dst, pgn_t pgn, const u8 *dat)
+{
+	struct sk_buff *skb;
+	u8 *skdat;
+
+	if (!j1939_tp_im_involved(related, swap_src_dst))
+		return 0;
+
+	skb = j1939_tp_tx_dat_new(related, extd, true, swap_src_dst);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	skdat = skb_put(skb, 8);
+	memcpy(skdat, dat, 5);
+	skdat[5] = (pgn >> 0);
+	skdat[6] = (pgn >> 8);
+	skdat[7] = (pgn >> 16);
+
+	return j1939_send(skb);
+}
+
+static inline int j1939_tp_tx_ctl(struct j1939_session *session,
+				  bool swap_src_dst, const u8 *dat)
+{
+	return j1939_xtp_do_tx_ctl(session->skb, session->extd, swap_src_dst,
+				   session->skcb->addr.pgn, dat);
+}
+
+static int j1939_xtp_tx_abort(struct sk_buff *related, bool extd,
+			      bool swap_src_dst, enum j1939_xtp_abort err, pgn_t pgn)
+{
+	u8 dat[5];
+
+	if (!j1939_tp_im_involved(related, swap_src_dst))
+		return 0;
+
+	memset(dat, 0xff, sizeof(dat));
+	dat[0] = J1939_TP_CMD_ABORT;
+	if (extd)
+		dat[1] = J1939_XTP_ABORT_GENERIC;
+	else
+		dat[1] = err;
+	return j1939_xtp_do_tx_ctl(related, extd, swap_src_dst, pgn, dat);
+}
+
+static inline void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
+{
+	j1939_session_get(session);
+	hrtimer_start(&session->txtimer, ms_to_ktime(msec), HRTIMER_MODE_REL_SOFT);
+}
+
+static inline void j1939_tp_set_rxtimeout(struct j1939_session *session, int msec)
+{
+	j1939_session_rxtimer_cancel(session);
+	j1939_session_get(session);
+	hrtimer_start(&session->rxtimer, ms_to_ktime(msec), HRTIMER_MODE_REL_SOFT);
+}
+
+/* transmit function */
+static int j1939_tp_txnext(struct j1939_session *session)
+{
+	u8 dat[8];
+	const u8 *tpdat;
+	int ret, offset, pkt_done, pkt_end;
+	unsigned int pkt, len, pdelay;
+
+	memset(dat, 0xff, sizeof(dat));
+
+	switch (session->last_cmd) {
+		case 0:
+			if (!j1939_tp_im_transmitter(session->skb))
+				break;
+			dat[1] = (session->skb->len >> 0);
+			dat[2] = (session->skb->len >> 8);
+			dat[3] = session->pkt.total;
+			if (session->extd) {
+				dat[0] = J1939_ETP_CMD_RTS;
+				dat[1] = (session->skb->len >> 0);
+				dat[2] = (session->skb->len >> 8);
+				dat[3] = (session->skb->len >> 16);
+				dat[4] = (session->skb->len >> 24);
+			} else if (j1939_cb_is_broadcast(session->skcb)) {
+				dat[0] = J1939_TP_CMD_BAM;
+				/* fake cts for broadcast */
+				session->pkt.tx = 0;
+			} else {
+				dat[0] = J1939_TP_CMD_RTS;
+				dat[4] = dat[3];
+			}
+			if (dat[0] == session->last_txcmd)
+				/* done already */
+				break;
+			ret = j1939_tp_tx_ctl(session, false, dat);
+			if (ret < 0)
+				goto failed;
+			session->last_txcmd = dat[0];
+			/* must lock? */
+			if (dat[0] == J1939_TP_CMD_BAM)
+				j1939_tp_schedule_txtimer(session, 50);
+			j1939_tp_set_rxtimeout(session, 1250);
+			break;
+		case J1939_TP_CMD_RTS:
+		case J1939_ETP_CMD_RTS: /* fallthrough */
+			if (!j1939_tp_im_receiver(session->skb))
+				break;
+tx_cts:
+			ret = 0;
+			len = session->pkt.total - session->pkt.done;
+			len = min3(len, session->pkt.block, j1939_tp_block ?: 255);
+
+			if (session->extd) {
+				pkt = session->pkt.done + 1;
+				dat[0] = J1939_ETP_CMD_CTS;
+				dat[1] = len;
+				dat[2] = (pkt >> 0);
+				dat[3] = (pkt >> 8);
+				dat[4] = (pkt >> 16);
+			} else {
+				dat[0] = J1939_TP_CMD_CTS;
+				dat[1] = len;
+				dat[2] = session->pkt.done + 1;
+			}
+			if (dat[0] == session->last_txcmd)
+				/* done already */
+				break;
+			ret = j1939_tp_tx_ctl(session, true, dat);
+			if (ret < 0)
+				goto failed;
+			if (len)
+				/* only mark cts done when len is set */
+				session->last_txcmd = dat[0];
+			j1939_tp_set_rxtimeout(session, 1250);
+			break;
+		case J1939_ETP_CMD_CTS:
+			if (j1939_tp_im_transmitter(session->skb) && session->extd &&
+					session->last_txcmd != J1939_ETP_CMD_DPO) {
+				/* do dpo */
+				dat[0] = J1939_ETP_CMD_DPO;
+				session->pkt.dpo = session->pkt.done;
+				pkt = session->pkt.dpo;
+				dat[1] = session->pkt.last - session->pkt.done;
+				dat[2] = (pkt >> 0);
+				dat[3] = (pkt >> 8);
+				dat[4] = (pkt >> 16);
+				ret = j1939_tp_tx_ctl(session, false, dat);
+				if (ret < 0)
+					goto failed;
+				session->last_txcmd = dat[0];
+				j1939_tp_set_rxtimeout(session, 1250);
+				session->pkt.tx = session->pkt.done;
+			}
+	/* fallthrough */
+		case J1939_TP_CMD_CTS: /* fallthrough */
+		case 0xff: /* did some data */
+		case J1939_ETP_CMD_DPO: /* fallthrough */
+			if ((session->extd || !j1939_cb_is_broadcast(session->skcb)) &&
+					j1939_tp_im_receiver(session->skb)) {
+				if (session->pkt.done >= session->pkt.total) {
+					if (session->extd) {
+						dat[0] = J1939_ETP_CMD_EOMA;
+						dat[1] = session->skb->len >> 0;
+						dat[2] = session->skb->len >> 8;
+						dat[3] = session->skb->len >> 16;
+						dat[4] = session->skb->len >> 24;
+					} else {
+						dat[0] = J1939_TP_CMD_EOMA;
+						dat[1] = session->skb->len;
+						dat[2] = session->skb->len >> 8;
+						dat[3] = session->pkt.total;
+					}
+					if (dat[0] == session->last_txcmd)
+						/* done already */
+						break;
+					ret = j1939_tp_tx_ctl(session, true, dat);
+					if (ret < 0)
+						goto failed;
+					session->last_txcmd = dat[0];
+					j1939_tp_set_rxtimeout(session, 1250);
+					/* wait for the EOMA packet to come in */
+					break;
+				} else if (session->pkt.done >= session->pkt.last) {
+					session->last_txcmd = 0;
+					goto tx_cts;
+				}
+			}
+		case J1939_TP_CMD_BAM: /* fallthrough */
+			if (!j1939_tp_im_transmitter(session->skb))
+				break;
+			tpdat = session->skb->data;
+			ret = 0;
+			pkt_done = 0;
+			if (!session->extd && j1939_cb_is_broadcast(session->skcb))
+				pkt_end = session->pkt.total;
+			else
+				pkt_end = session->pkt.last;
+
+			while (session->pkt.tx < pkt_end) {
+				dat[0] = session->pkt.tx - session->pkt.dpo + 1;
+				offset = session->pkt.tx * 7;
+				len = session->skb->len - offset;
+				if (len > 7)
+					len = 7;
+				memcpy(&dat[1], &tpdat[offset], len);
+				ret = j1939_tp_tx_dat(session->skb, session->extd,
+									  dat, len + 1);
+				if (ret < 0)
+					break;
+				session->last_txcmd = 0xff;
+				++pkt_done;
+				++session->pkt.tx;
+				pdelay = j1939_cb_is_broadcast(session->skcb) ? 50 :
+						 j1939_tp_packet_delay;
+				if (session->pkt.tx < session->pkt.total && pdelay) {
+					j1939_tp_schedule_txtimer(session, pdelay);
+					break;
+				}
+			}
+			if (pkt_done)
+				j1939_tp_set_rxtimeout(session, 250);
+			if (ret)
+				goto failed;
+			break;
+	}
+
+	return 0;
+
+failed:
+	return ret;
+}
+
+/* timer & scheduler functions */
+static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
+{
+	struct j1939_session *session =
+		container_of(hrtimer, struct j1939_session, txtimer);
+	int ret;
+
+	ret = j1939_tp_txnext(session);
+	if (ret < 0)
+		j1939_tp_schedule_txtimer(session, j1939_tp_retry_ms ?: 20);
+	j1939_session_put(session);
+
+	return HRTIMER_NORESTART;
+}
+
+/* session completion functions */
+static void __j1939_session_drop(struct j1939_session *session)
+{
+	struct j1939_priv *priv = session->priv;
+
+	if (session->transmission) {
+		if (session->skb && session->skb->sk)
+			j1939_sock_pending_del(session->skb->sk);
+		wake_up_all(&priv->tp_wait);
+	}
+}
+
+static void j1939_session_completed(struct j1939_session *session)
+{
+	/* distribute among j1939 receivers */
+	j1939_sk_recv(session->skb);
+	__j1939_session_drop(session);
+}
+
+static void j1939_session_cancel(struct j1939_session *session, enum j1939_xtp_abort err)
+{
+	if (err && j1939_tp_im_involved_anydir(session->skb)) {
+		if (!j1939_cb_is_broadcast(session->skcb)) {
+			/* do not send aborts on incoming broadcasts */
+			j1939_xtp_tx_abort(session->skb, session->extd,
+					   !(session->skcb->src_flags & J1939_ECU_LOCAL),
+					   err, session->skcb->addr.pgn);
+		}
+	}
+	__j1939_session_drop(session);
+}
+
+static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
+{
+	struct j1939_session *session = container_of(hrtimer, struct j1939_session,
+						     rxtimer);
+
+	pr_alert("%s: timeout on %i\n", __func__,
+		 can_skb_prv(session->skb)->ifindex);
+	j1939_session_txtimer_cancel(session);
+	j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
+	j1939_session_put(session);
+
+	return HRTIMER_NORESTART;
+}
+
+/* receive packet functions */
+static void j1939_xtp_rx_bad_message_one(struct j1939_priv *priv, struct sk_buff *skb, bool extd, bool reverse)
+{
+	struct j1939_session *session;
+	pgn_t pgn;
+
+	pgn = j1939_xtp_ctl_to_pgn(skb->data);
+	session = j1939_session_get_by_skb(priv, j1939_sessionq(priv, extd), skb, reverse);
+	if (session /*&& (session->skcb->addr.pgn == pgn)*/) {
+		/* do not allow TP control messages on 2 pgn's */
+		j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
+		goto out_session_put;
+	}
+	j1939_xtp_tx_abort(skb, extd, false, J1939_XTP_ABORT_FAULT, pgn);
+	if (!session)
+		return;
+
+ out_session_put:
+	j1939_session_put(session);
+}
+
+/* abort packets may come in 2 directions */
+static void j1939_xtp_rx_bad_message(struct j1939_priv *priv, struct sk_buff *skb, bool extd)
+{
+	pr_info("%s, pgn %05x\n", __func__, j1939_xtp_ctl_to_pgn(skb->data));
+
+	j1939_xtp_rx_bad_message_one(priv, skb, extd, false);
+	j1939_xtp_rx_bad_message_one(priv, skb, extd, true);
+}
+
+static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb, bool extd, bool reverse)
+{
+	struct j1939_session *session;
+	pgn_t pgn;
+
+	pgn = j1939_xtp_ctl_to_pgn(skb->data);
+	session = j1939_session_get_by_skb(priv, j1939_sessionq(priv, extd), skb, reverse);
+	if (!session)
+		return;
+	if (session->transmission && !session->last_txcmd) {
+		/* empty block:
+		 * do not drop session when a transmit session did not
+		 * start yet
+		 */
+	} else if (session->skcb->addr.pgn == pgn) {
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_NO_ERROR);
+	}
+
+	/* TODO: maybe cancel current connection
+	 * as another pgn was communicated
+	 */
+	j1939_session_put(session);
+}
+
+/* abort packets may come in 2 directions */
+static void j1939_xtp_rx_abort(struct j1939_priv *priv, struct sk_buff *skb, bool extd)
+{
+	pr_info("%s %i, %05x\n", __func__, can_skb_prv(skb)->ifindex,
+		j1939_xtp_ctl_to_pgn(skb->data));
+
+	j1939_xtp_rx_abort_one(priv, skb, extd, false);
+	j1939_xtp_rx_abort_one(priv, skb, extd, true);
+}
+
+static void j1939_xtp_rx_eoma(struct j1939_priv *priv, struct sk_buff *skb, bool extd)
+{
+	struct j1939_session *session;
+	pgn_t pgn;
+
+	/* end of tx cycle */
+	pgn = j1939_xtp_ctl_to_pgn(skb->data);
+	session = j1939_session_get_by_skb(priv, j1939_sessionq(priv, extd), skb, true);
+	if (!session) {
+		/* strange, we had EOMA on closed connection
+		 * do nothing, as EOMA closes the connection anyway
+		 */
+		return;
+	}
+
+	j1939_session_timers_cancel(session);
+	if (session->skcb->addr.pgn != pgn) {
+		j1939_xtp_tx_abort(skb, extd, true, J1939_XTP_ABORT_BUSY, pgn);
+		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
+	} else {
+		/* transmitted without problems */
+		j1939_session_completed(session);
+	}
+
+	j1939_session_put(session);
+}
+
+static void j1939_xtp_rx_cts(struct j1939_priv *priv, struct sk_buff *skb, bool extd)
+{
+	struct j1939_session *session;
+	pgn_t pgn;
+	unsigned int pkt;
+	const u8 *dat;
+
+	dat = skb->data;
+	pgn = j1939_xtp_ctl_to_pgn(skb->data);
+	session = j1939_session_get_by_skb(priv, j1939_sessionq(priv, extd), skb, true);
+	if (!session) {
+		/* 'CTS shall be ignored' */
+		return;
+	}
+
+	if (session->skcb->addr.pgn != pgn) {
+		/* what to do? */
+		j1939_xtp_tx_abort(skb, extd, true, J1939_XTP_ABORT_BUSY, pgn);
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
+		goto out_session_put;
+	}
+
+	j1939_session_lock(session);
+	if (extd)
+		pkt = j1939_etp_ctl_to_packet(dat);
+	else
+		pkt = dat[2];
+	if (!pkt) {
+		goto out_session_unlock;
+	} else if (dat[1] > session->pkt.block /* 0xff for etp */) {
+		goto out_session_unlock;
+	} else {
+		/* set packet counters only when not CTS(0) */
+		session->pkt.done = pkt - 1;
+		session->pkt.last = session->pkt.done + dat[1];
+		if (session->pkt.last > session->pkt.total)
+			/* safety measure */
+			session->pkt.last = session->pkt.total;
+		/* TODO: do not set tx here, do it in txtimer */
+		session->pkt.tx = session->pkt.done;
+	}
+
+	session->last_cmd = dat[0];
+	j1939_session_unlock(session);
+	if (dat[1]) {
+		j1939_tp_set_rxtimeout(session, 1250);
+		if (j1939_tp_im_transmitter(session->skb))
+			j1939_tp_schedule_txtimer(session, 0);
+	} else {
+		/* CTS(0) */
+		j1939_tp_set_rxtimeout(session, 550);
+	}
+	j1939_session_put(session);
+	return;
+
+ out_session_unlock:
+	j1939_session_unlock(session);
+	j1939_session_timers_cancel(session);
+	j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
+ out_session_put:
+	j1939_session_put(session);
+}
+
+static struct j1939_session *j1939_session_new(struct j1939_priv *priv, struct sk_buff *skb)
+{
+	struct j1939_session *session;
+
+	session = kzalloc(sizeof(*session), gfp_any());
+	if (!session)
+		return NULL;
+	INIT_LIST_HEAD(&session->list);
+	spin_lock_init(&session->lock);
+	kref_init(&session->kref);
+
+	j1939_priv_get(priv);
+	session->priv = priv;
+	/* corresponding skb_unref() is in j1939_session_fresh_new */
+	session->skb = skb_get(skb);
+	session->skcb = j1939_skb_to_cb(session->skb);
+
+	hrtimer_init(&session->txtimer, CLOCK_MONOTONIC,
+				 HRTIMER_MODE_REL_SOFT);
+	session->txtimer.function = j1939_tp_txtimer;
+	hrtimer_init(&session->rxtimer, CLOCK_MONOTONIC,
+				 HRTIMER_MODE_REL_SOFT);
+	session->rxtimer.function = j1939_tp_rxtimer;
+
+	return session;
+}
+
+static struct j1939_session *j1939_session_fresh_new(struct j1939_priv *priv, int size,
+		struct sk_buff *rel_skb,
+		pgn_t pgn)
+{
+	const struct j1939_sk_buff_cb *rel_skcb = j1939_skb_to_cb(rel_skb);
+	struct sk_buff *skb;
+	struct j1939_sk_buff_cb *skcb;
+	struct j1939_session *session;
+
+	skb = alloc_skb(size + sizeof(struct can_skb_priv), GFP_ATOMIC);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb->dev = rel_skb->dev;
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = can_skb_prv(rel_skb)->ifindex;
+	skcb = j1939_skb_to_cb(skb);
+	memcpy(skcb, rel_skcb, sizeof(*skcb));
+	j1939_fix_cb(skcb);
+	skcb->addr.pgn = pgn;
+
+	session = j1939_session_new(priv, skb);
+	if (!session) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* alloc data area */
+	skb_put(skb, size);
+	/* skb is recounted in j1939_session_new() */
+	WARN_ON_ONCE(skb_unref(skb));
+	return session;
+}
+
+static int j1939_session_insert(struct j1939_session *session)
+{
+	struct j1939_priv *priv = session->priv;
+	struct j1939_session *pending;
+	int ret = 0;
+
+	pending = j1939_session_get_by_skb(priv, j1939_sessionq(priv, session->extd),
+									   session->skb, false);
+	if (pending) {
+		j1939_session_put(pending);
+		ret = -EAGAIN;
+	} else {
+		j1939_session_list_lock(priv);
+		j1939_session_list_add(session, j1939_sessionq(priv, session->extd));
+		j1939_session_list_unlock(priv);
+	}
+
+	return ret;
+}
+
+static void j1939_xtp_rx_rts(struct j1939_priv *priv, struct sk_buff *skb, bool extd)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	struct j1939_session *session;
+	int len;
+	const u8 *dat;
+	pgn_t pgn;
+
+	dat = skb->data;
+	pgn = j1939_xtp_ctl_to_pgn(dat);
+
+	if (dat[0] == J1939_TP_CMD_RTS && j1939_cb_is_broadcast(skcb)) {
+		pr_alert("%s: rts without destination (%i %02x)\n", __func__,
+			 can_skb_prv(skb)->ifindex, skcb->addr.sa);
+		return;
+	}
+
+	/* TODO: abort RTS when a similar
+	 * TP is pending in the other direction
+	 */
+	session = j1939_session_get_by_skb(priv, j1939_sessionq(priv, extd), skb, false);
+	if (session && !j1939_tp_im_transmitter(skb)) {
+		/* RTS on pending connection */
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
+
+		if (pgn != session->skcb->addr.pgn && dat[0] != J1939_TP_CMD_BAM)
+			j1939_xtp_tx_abort(skb, extd, true, J1939_XTP_ABORT_BUSY, pgn);
+
+		goto out_session_put;
+	} else if (!session && j1939_tp_im_transmitter(skb)) {
+		pr_alert("%s: I should tx (%i %02x %02x)\n", __func__,
+			 can_skb_prv(skb)->ifindex, skcb->addr.sa, skcb->addr.da);
+
+		return;
+	}
+
+	if (session && session->last_cmd != 0) {
+		/* we received a second rts on the same connection */
+		pr_alert("%s: connection exists (%i %02x %02x)\n", __func__,
+			 can_skb_prv(skb)->ifindex, skcb->addr.sa, skcb->addr.da);
+
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
+
+		goto out_session_put;
+	}
+
+	if (session) {
+		/* make sure 'sa' & 'da' are correct !
+		 * They may be 'not filled in yet' for sending
+		 * skb's, since they did not pass the Address Claim ever.
+		 */
+		session->skcb->addr.sa = skcb->addr.sa;
+		session->skcb->addr.da = skcb->addr.da;
+	} else {
+		enum j1939_xtp_abort abort = J1939_XTP_ABORT_NO_ERROR;
+
+		if (extd) {
+			len = j1939_etp_ctl_to_size(dat);
+			if (len > J1939_MAX_ETP_PACKET_SIZE)
+				abort = J1939_XTP_ABORT_FAULT;
+			else if (j1939_tp_max_packet_size && (len > j1939_tp_max_packet_size))
+				abort = J1939_XTP_ABORT_RESOURCE;
+			else if (len <= J1939_MAX_TP_PACKET_SIZE)
+				abort = J1939_XTP_ABORT_FAULT;
+		} else {
+			len = j1939_tp_ctl_to_size(dat);
+			if (len > J1939_MAX_TP_PACKET_SIZE)
+				abort = J1939_XTP_ABORT_FAULT;
+			else if (j1939_tp_max_packet_size && (len > j1939_tp_max_packet_size))
+				abort = J1939_XTP_ABORT_RESOURCE;
+		}
+		if (abort) {
+			j1939_xtp_tx_abort(skb, extd, true, abort, pgn);
+			return;
+		}
+
+		session = j1939_session_fresh_new(priv, len, skb, pgn);
+		if (!session) {
+			j1939_xtp_tx_abort(skb, extd, true, J1939_XTP_ABORT_RESOURCE,
+					   pgn);
+			return;
+		}
+		session->extd = extd;
+
+		/* initialize the control buffer: plain copy */
+		session->pkt.total = (len + 6) / 7;
+		session->pkt.block = 0xff;
+		if (!extd) {
+			if (dat[3] != session->pkt.total)
+				pr_alert("%s: strange total, %u != %u\n",
+					 __func__, session->pkt.total,
+					 dat[3]);
+			session->pkt.total = dat[3];
+			session->pkt.block = min(dat[3], dat[4]);
+		}
+
+		session->pkt.done = 0;
+		session->pkt.tx = 0;
+
+		WARN_ON_ONCE(j1939_session_insert(session));
+	}
+	session->last_cmd = dat[0];
+
+	j1939_tp_set_rxtimeout(session, 1250);
+
+	if (j1939_tp_im_receiver(session->skb)) {
+		if (extd || dat[0] != J1939_TP_CMD_BAM)
+			j1939_tp_schedule_txtimer(session, 0);
+	}
+
+	/* as soon as it's inserted, things can go fast
+	 * protect against a long delay
+	 * between spin_unlock & next statement
+	 * so, only release here, at the end
+	 */
+ out_session_put:
+	j1939_session_put(session);
+}
+
+static void j1939_xtp_rx_dpo(struct j1939_priv *priv, struct sk_buff *skb, bool extd)
+{
+	struct j1939_session *session;
+	pgn_t pgn;
+	const u8 *dat = skb->data;
+
+	pgn = j1939_xtp_ctl_to_pgn(dat);
+	session = j1939_session_get_by_skb(priv, j1939_sessionq(priv, extd), skb, false);
+	if (!session) {
+		pr_info("%s: %s\n", __func__, "no connection found");
+		return;
+	}
+
+	if (session->skcb->addr.pgn != pgn) {
+		pr_info("%s: different pgn\n", __func__);
+		j1939_xtp_tx_abort(skb, true, true, J1939_XTP_ABORT_BUSY, pgn);
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
+		goto out_session_put;
+	}
+
+	/* transmitted without problems */
+	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
+	session->last_cmd = dat[0];
+	j1939_tp_set_rxtimeout(session, 750);
+ out_session_put:
+	j1939_session_put(session);
+}
+
+static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb, bool extd)
+{
+	struct j1939_session *session;
+	const u8 *dat;
+	u8 *tpdat;
+	int offset;
+	int nbytes;
+	bool final = false;
+	bool do_cts_eoma = false;
+	int packet;
+
+	session = j1939_session_get_by_skb(priv, j1939_sessionq(priv, extd), skb, false);
+	if (!session) {
+		pr_info("%s:%s\n", __func__, "no connection found");
+		return;
+	}
+	dat = skb->data;
+	if (skb->len <= 1)
+		/* makes no sense */
+		goto out_session_cancel;
+
+	j1939_session_lock(session);
+
+	switch (session->last_cmd) {
+	case 0xff:
+		break;
+	case J1939_ETP_CMD_DPO:
+		if (extd)
+			break;
+	case J1939_TP_CMD_BAM:
+	case J1939_TP_CMD_CTS:
+		if (!extd)
+			break;
+	default:
+		pr_info("%s: last %02x\n", __func__,
+			session->last_cmd);
+		goto out_session_unlock;
+	}
+
+	packet = (dat[0] - 1 + session->pkt.dpo);
+	offset = packet * 7;
+	if (packet > session->pkt.total ||
+	    (session->pkt.done + 1) > session->pkt.total) {
+		pr_info("%s: should have been completed\n", __func__);
+		goto out_session_unlock;
+	}
+	nbytes = session->skb->len - offset;
+	if (nbytes > 7)
+		nbytes = 7;
+	if (nbytes <= 0 || (nbytes + 1) > skb->len) {
+		pr_info("%s: nbytes %i, len %i\n", __func__, nbytes,
+			skb->len);
+		goto out_session_unlock;
+	}
+	tpdat = session->skb->data;
+	memcpy(&tpdat[offset], &dat[1], nbytes);
+	if (packet == session->pkt.done)
+		++session->pkt.done;
+
+	if (!extd && j1939_cb_is_broadcast(session->skcb)) {
+		if (session->pkt.done >= session->pkt.total)
+			final = true;
+	} else {
+		/* never final, an EOMA must follow */
+		if (session->pkt.done >= session->pkt.last)
+			do_cts_eoma = true;
+	}
+	j1939_session_unlock(session);
+
+	if (final) {
+		j1939_session_completed(session);
+	} else if (do_cts_eoma) {
+		j1939_tp_set_rxtimeout(session, 1250);
+		if (j1939_tp_im_receiver(session->skb))
+			j1939_tp_schedule_txtimer(session, 0);
+	} else {
+		j1939_tp_set_rxtimeout(session, 250);
+	}
+	session->last_cmd = 0xff;
+	j1939_session_put(session);
+
+	return;
+
+ out_session_unlock:
+	/* unlock session (spinlock) before trying to send */
+	j1939_session_unlock(session);
+ out_session_cancel:
+	j1939_session_timers_cancel(session);
+	j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
+	j1939_session_put(session);
+}
+
+static inline int j1939_tp_tx_initial(struct j1939_session *session)
+{
+	int ret;
+
+	ret = j1939_tp_txnext(session);
+	/* set nonblocking for further packets */
+	session->skcb->msg_flags |= MSG_DONTWAIT;
+
+	return ret;
+}
+
+/* j1939 main intf */
+int j1939_tp_send(struct j1939_priv *priv, struct sk_buff *skb)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	struct j1939_session *session;
+	int ret;
+
+	if (skcb->addr.pgn == J1939_TP_PGN_DAT ||
+	    skcb->addr.pgn == J1939_TP_PGN_CTL ||
+	    skcb->addr.pgn == J1939_ETP_PGN_DAT ||
+	    skcb->addr.pgn == J1939_ETP_PGN_CTL)
+		/* avoid conflict */
+		return -EDOM;
+	if ((skb->len > J1939_MAX_ETP_PACKET_SIZE) ||
+	    (j1939_tp_max_packet_size && (skb->len > j1939_tp_max_packet_size)))
+		return -EMSGSIZE;
+	if (skb->len > J1939_MAX_TP_PACKET_SIZE && j1939_cb_is_broadcast(skcb))
+		return -EDESTADDRREQ;
+
+	/* fill in addresses from names */
+	ret = j1939_ac_fixup(priv, skb);
+	if (unlikely(ret))
+		return ret;
+
+	/* fix dst_flags, it may be used there soon */
+	if (j1939_address_is_unicast(skcb->addr.da) &&
+	    priv->ents[skcb->addr.da].nusers)
+		skcb->dst_flags |= J1939_ECU_LOCAL;
+
+	/* src is always local, I'm sending ... */
+	skcb->src_flags |= J1939_ECU_LOCAL;
+
+	/* prepare new session */
+	session = j1939_session_new(priv, skb);
+	if (!session)
+		return -ENOMEM;
+
+	if (skb->len > J1939_MAX_TP_PACKET_SIZE)
+		session->extd = J1939_EXTENDED;
+	else
+		session->extd = J1939_REGULAR;
+	session->transmission = true;
+	session->pkt.total = (skb->len + 6) / 7;
+	session->pkt.block = session->extd ? 255 :
+		min(j1939_tp_block ?: 255, session->pkt.total);
+
+	if (j1939_cb_is_broadcast(session->skcb))
+		/* set the end-packet for broadcast */
+		session->pkt.last = session->pkt.total;
+
+	/* insert into queue, but avoid collision with pending session */
+	if (session->skcb->msg_flags & MSG_DONTWAIT)
+		ret = j1939_session_insert(session);
+	else
+		ret = wait_event_interruptible(priv->tp_wait,
+					       j1939_session_insert(session) == 0);
+	if (ret < 0)
+		goto failed;
+
+	ret = j1939_tp_tx_initial(session);
+	if (ret)
+		goto failed;
+
+	/* transmission started */
+	j1939_session_put(session);
+	return 0;
+
+ failed:
+	j1939_session_timers_cancel(session);
+	j1939_session_cancel(session, J1939_XTP_ABORT_NO_ERROR);
+	j1939_session_put(session);
+	return ret;
+}
+
+int j1939_tp_recv(struct j1939_priv *priv, struct sk_buff *skb)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	const u8 *dat;
+
+	switch (skcb->addr.pgn) {
+	case J1939_ETP_PGN_DAT:
+		j1939_xtp_rx_dat(priv, skb, J1939_EXTENDED);
+		break;
+	case J1939_ETP_PGN_CTL:
+		if (skb->len < 8) {
+			j1939_xtp_rx_bad_message(priv, skb, J1939_EXTENDED);
+			break;
+		}
+		dat = skb->data;
+		switch (*dat) {
+		case J1939_ETP_CMD_RTS:
+			j1939_xtp_rx_rts(priv, skb, J1939_EXTENDED);
+			break;
+		case J1939_ETP_CMD_CTS:
+			j1939_xtp_rx_cts(priv, skb, J1939_EXTENDED);
+			break;
+		case J1939_ETP_CMD_DPO:
+			j1939_xtp_rx_dpo(priv, skb, J1939_EXTENDED);
+			break;
+		case J1939_ETP_CMD_EOMA:
+			j1939_xtp_rx_eoma(priv, skb, J1939_EXTENDED);
+			break;
+		case J1939_ETP_CMD_ABORT:
+			j1939_xtp_rx_abort(priv, skb, J1939_EXTENDED);
+			break;
+		default:
+			j1939_xtp_rx_bad_message(priv, skb, J1939_EXTENDED);
+			break;
+		}
+		break;
+	case J1939_TP_PGN_DAT:
+		j1939_xtp_rx_dat(priv, skb, J1939_REGULAR);
+		break;
+	case J1939_TP_PGN_CTL:
+		if (skb->len < 8) {
+			j1939_xtp_rx_bad_message(priv, skb, J1939_REGULAR);
+			break;
+		}
+		dat = skb->data;
+		switch (*dat) {
+		case J1939_TP_CMD_BAM:
+		case J1939_TP_CMD_RTS:
+			j1939_xtp_rx_rts(priv, skb, J1939_REGULAR);
+			break;
+		case J1939_TP_CMD_CTS:
+			j1939_xtp_rx_cts(priv, skb, J1939_REGULAR);
+			break;
+		case J1939_TP_CMD_EOMA:
+			j1939_xtp_rx_eoma(priv, skb, J1939_REGULAR);
+			break;
+		case J1939_TP_CMD_ABORT:
+			j1939_xtp_rx_abort(priv, skb, J1939_REGULAR);
+			break;
+		default:
+			j1939_xtp_rx_bad_message(priv, skb, J1939_REGULAR);
+			break;
+		}
+		break;
+	default:
+		return 0; /* no problem */
+	}
+	return 1; /* "I processed the message" */
+}
+
+int j1939_tp_rmdev_notifier(struct j1939_priv *priv)
+{
+	struct j1939_session *session, *saved;
+	struct net_device *ndev = priv->ndev;
+
+	j1939_session_list_lock(priv);
+	list_for_each_entry_safe(session, saved,
+				 &priv->tp_sessionq, list) {
+		if (can_skb_prv(session->skb)->ifindex != ndev->ifindex)
+			continue;
+		j1939_session_timers_cancel(session);
+	}
+	list_for_each_entry_safe(session, saved,
+				 &priv->tp_extsessionq, list) {
+		if (can_skb_prv(session->skb)->ifindex != ndev->ifindex)
+			continue;
+		j1939_session_timers_cancel(session);
+	}
+	j1939_session_list_unlock(priv);
+	return NOTIFY_DONE;
+}
+
+void j1939_tp_init(struct j1939_priv *priv)
+{
+	spin_lock_init(&priv->tp_session_list_lock);
+	INIT_LIST_HEAD(&priv->tp_sessionq);
+	INIT_LIST_HEAD(&priv->tp_extsessionq);
+	init_waitqueue_head(&priv->tp_wait);
+}
-- 
2.19.0
