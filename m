From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] ip: add vxcan/veth to ip-link man page
Date: Sat, 16 Dec 2017 12:38:57 +0100
Message-ID: <20171216113857.2397-1-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:9735 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbdLPLjK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 16 Dec 2017 06:39:10 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

veth and vxcan both create a vitual tunnel between a pair of virtual network
devices. This patch adds the content for the now supported vxcan netdevices
and the documentation to create peer devices for vxcan and veth.

Additional remove 'can' that accidently was on the list of link types which
can be created by 'ip link add' as 'can' devices are real network devices.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 man/man8/ip-link.8.in | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index a6a10e57..94ecbece 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -194,6 +194,7 @@ ip-link \- network device configuration
 .BR macvlan  " | "
 .BR macvtap  " | "
 .BR vcan " | "
+.BR vxcan " | "
 .BR veth " | "
 .BR vlan " | "
 .BR vxlan " |"
@@ -252,9 +253,6 @@ Link types:
 .B bond
 - Bonding device
 .sp
-.B can
-- Controller Area Network interface
-.sp
 .B dummy
 - Dummy network interface
 .sp
@@ -276,6 +274,9 @@ Link types:
 .B vcan
 - Virtual Controller Area Network interface
 .sp
+.B vxcan
+- Virtual Controller Area Network tunnel interface
+.sp
 .B veth
 - Virtual ethernet interface
 .sp
@@ -651,6 +652,29 @@ keyword.
 
 .in -8
 
+.TP
+VETH, VXCAN Type Support
+For a link of types
+.I VETH/VXCAN
+the following additional arguments are supported:
+
+.BI "ip link add " DEVICE
+.BR type " { " veth " | " vxcan " }"
+[
+.BR peer
+.BI "name " NAME
+]
+
+.in +8
+.sp
+.BR peer
+.BI "name " NAME
+- specifies the virtual pair device name of the
+.I VETH/VXCAN
+tunnel.
+
+.in -8
+
 .TP
 GRE, IPIP, SIT, ERSPAN Type Support
 For a link of types
-- 
2.15.1

