From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 3/4] j1939: sync docs with current code state
Date: Wed, 24 Jan 2018 12:06:58 +0100
Message-ID: <20180124110659.438-3-o.rempel@pengutronix.de>
References: <20180124110659.438-1-o.rempel@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52533 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeAXLHK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Jan 2018 06:07:10 -0500
In-Reply-To: <20180124110659.438-1-o.rempel@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, mkl@pengutronix.de
Cc: Oleksij Rempel <o.rempel@pengutronix.de>

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/networking/j1939.txt | 66 +++++++++++---------------------------
 1 file changed, 18 insertions(+), 48 deletions(-)

diff --git a/Documentation/networking/j1939.txt b/Documentation/networking/j1939.txt
index 8e688cc2e1e4..08f7b035d821 100644
--- a/Documentation/networking/j1939.txt
+++ b/Documentation/networking/j1939.txt
@@ -20,16 +20,15 @@ This file contains
     3.6 destinations with dynamic address
 
   4 How to use J1939
-    4.1 rtnetlink interface
-    4.2 API calls
-        4.2.1 Message flags during sendmsg
-	4.2.2 SCM_J1939_DEST_ADDR & SCM_J1939_DEST_NAME
-	4.2.3 SCM_J1939_PRIORITY
-    4.3 Dynamic addressing
-    4.4 Send Examples
-        4.4.1 Static address
-	4.4.2 Dynamic address
-	4.4.3 Mixed mode
+    4.1 API calls
+        4.1.1 Message flags during sendmsg
+	4.1.2 SCM_J1939_DEST_ADDR & SCM_J1939_DEST_NAME
+	4.1.3 SCM_J1939_PRIORITY
+    4.2 Dynamic addressing
+    4.3 Send Examples
+        4.3.1 Static address
+	4.3.2 Dynamic address
+	4.3.3 Mixed mode
 
   5 socket options
     5.1 SO_J1939_FILTER
@@ -188,30 +187,7 @@ This file contains
 4. How to use J1939
 --------------------------------
 
-4.1 rtnetlink interface
-
-  Per default j1939 is not active. Specifying can_ifindex != 0 in bind(2)
-  or connect(2) needs an active j1939 on that interface. You must have done
-  $ ip link set canX j1939 on
-  on that interface.
-
-  $ ip link set canX j1939 off
-  disables j1939 on canX.
-
-  Assigning addresses is done via
-  $ ip addr add dev canX j1939 0xXX
-  statically or
-  $ ip addr add dev canX j1939 name 0xXX
-  dynamically. In the latter case, address claiming must take place
-  before other traffic can leave.
-
-  Removing addresses is done similarly via
-  $ ip addr del dev canX j1939 0xXX
-  $ ip addr del dev canX j1939 name 0xXX
-
-  A static address cannot be assigned together with a 64bit name.
-
-4.2 API calls
+4.1 API calls
 
   Like TCP/IP and CAN, you first need to open a socket for communicating over a
   CAN network. To use j1939, include <include/linux/j1939.h>. From there,
@@ -285,7 +261,7 @@ This file contains
   When creating a socket, reasonable defaults have been set. Some options can be
   modified with setsockopt(2) & getsockopt(2).
 
-4.2.1 Message flags during sendmsg
+4.1.1 Message flags during sendmsg
 
   send(2), sendto(2) and sendmsg(2) take a 'flags' argument. J1939 interpretes
   these flags during outgoing traffic:
@@ -300,7 +276,7 @@ This file contains
     session to complete before proceeding.
     Traffic without MSG_SYN (on that very same socket) will still continue.
 
-4.2.2 SCM_J1939_DEST_ADDR & SCM_J1939_DEST_NAME
+4.1.2 SCM_J1939_DEST_ADDR & SCM_J1939_DEST_NAME
 
   Different received j1939 packets could have had different destionations:
   - broadcast packet, i.e. no destination address
@@ -314,12 +290,12 @@ This file contains
   with cmsg_level == SOL_J1939 && cmsg_type == SCM_J1939_DEST_ADDR
   or SCM_J1939_DEST_NAME. The returned data is a uint8_t/uint64_t.
 
-4.2.3 SCM_J1939_PRIORITY
+4.1.3 SCM_J1939_PRIORITY
 
   Attached to the msghdr is also the packet's priority on the bus. This is a
   uint8_t, packed as cmsg_type == SCM_J1939_PRIORITY.
 
-4.3 Dynamic Addressing
+4.2 Dynamic Addressing
 
   Distinction has to be made in and using the claimed address and doing an
   address claim. To use an already claimed address, one has to fill in the
@@ -356,15 +332,12 @@ This file contains
   (and any other participant on the bus) for this NAME.
 
 
-4.4 Send Examples
+4.3 Send Examples
 
-4.4.1 Static addressing
+4.3.1 Static addressing
 
   This example will send a pgn (0x12300) from SA 0x20 to DA 0x30.
 
-  Add the address to the system:
-  $ ip addr add j1939 0x20 dev can0
-
   Bind:
     struct sockaddr_can addr;
 
@@ -393,13 +366,10 @@ This file contains
 
     sendto(sk, data, sizeof(data), 0, (void *)&addr, sizeof(addr));
 
-4.4.2 Dynamic addressing
+4.3.2 Dynamic addressing
 
   This example will send a pgn (0x12300) from 12345678 to 9ABCDEF
 
-  Add the name to the system:
-  $ ip addr add j1939 name 12345678 dev can0
-
   Start an address claiming daemon (e.g. jacd)
   $ jacd -r 0x20-0x30 12345678 can0 &
 
@@ -424,7 +394,7 @@ This file contains
 
     sendto(sk, data, sizeof(data), 0, (void *)&addr, sizeof(addr));
 
-4.4.3 Mixed mode
+4.3.3 Mixed mode
 
   A scenario that sends a packet from a static address to a dynamic address
   or vice versa is called 'mixed mode' here.
-- 
2.15.1

