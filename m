From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 6/6] canfd: update documentation according to CAN FD extensions
Date: Mon, 18 Jun 2012 19:40:09 +0200
Message-ID: <4FDF67F9.2060608@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:31978 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab2FRRkI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 13:40:08 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 Documentation/networking/can.txt |  154 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 146 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index a067418..820f553 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -22,7 +22,8 @@ This file contains
       4.1.2 RAW socket option CAN_RAW_ERR_FILTER
       4.1.3 RAW socket option CAN_RAW_LOOPBACK
       4.1.4 RAW socket option CAN_RAW_RECV_OWN_MSGS
-      4.1.5 RAW socket returned message flags
+      4.1.5 RAW socket option CAN_RAW_FD_FRAMES
+      4.1.6 RAW socket returned message flags
     4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
     4.3 connected transport protocols (SOCK_SEQPACKET)
     4.4 unconnected transport protocols (SOCK_DGRAM)
@@ -41,7 +42,8 @@ This file contains
       6.5.1 Netlink interface to set/get devices properties
       6.5.2 Setting the CAN bit-timing
       6.5.3 Starting and stopping the CAN network device
-    6.6 supported CAN hardware
+    6.6 CAN FD (flexible data rate) driver support
+    6.7 supported CAN hardware
    7 Socket CAN resources
 @@ -273,7 +275,7 @@ solution for a couple of reasons:
      struct can_frame {
             canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
-            __u8    can_dlc; /* data length code: 0 .. 8 */
+            __u8    can_dlc; /* frame payload length in byte (0 .. 8) */
             __u8    data[8] __attribute__((aligned(8)));
     };
 @@ -375,6 +377,51 @@ solution for a couple of reasons:
     nbytes = sendto(s, &frame, sizeof(struct can_frame),
                     0, (struct sockaddr*)&addr, sizeof(addr));
 +  Remark about CAN FD (flexible data rate) support:
+
+  Generally the handling of CAN FD is very similar to the formerly described
+  examples. The new CAN FD capable CAN controllers support two different
+  bitrates for the arbitration phase and the payload phase of the CAN FD frame
+  and up to 64 bytes of payload. This extended payload length breaks all the
+  kernel interfaces (ABI) which heavily rely on the CAN frame with fixed eight
+  bytes of payload (struct can_frame) like the CAN_RAW socket. Therefore e.g.
+  the CAN_RAW socket supports a new socket option CAN_RAW_FD_FRAMES that
+  switches the socket into a mode that allows the handling of CAN FD frames
+  and (legacy) CAN frames simultaneously (see section 4.1.5).
+
+  The struct canfd_frame is defined in include/linux/can.h:
+
+    struct canfd_frame {
+            canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
+            __u8    len;     /* frame payload length in byte (0 .. 64) */
+            __u8    flags;   /* additional flags for CAN FD */
+            __u8    __res0;  /* reserved / padding */
+            __u8    __res1;  /* reserved / padding */
+            __u8    data[64] __attribute__((aligned(8)));
+    };
+
+  The struct canfd_frame and the existing struct can_frame have the can_id,
+  the payload length and the payload data at the same offset inside their
+  structures. This allows to handle the different structures very similar.
+  When the content of a struct can_frame is copied into a struct canfd_frame
+  all structure elements can be used as-is - only the data[] becomes extended.
+
+  When introducing the struct canfd_frame it turned out that the data length
+  code (DLC) of the struct can_frame was used as a length information as the
+  length and the DLC has a 1:1 mapping in the range of 0 .. 8. To preserve
+  the easy handling of the length information the canfd_frame.len element
+  contains a plain length value from 0 .. 64. So both canfd_frame.len and
+  can_frame.can_dlc are equal and contain a length information and no DLC.
+  For details about the distinction of CAN and CAN FD capable devices and
+  the mapping to the bus-relevant data length code (DLC), see chapter 6.6.
+
+  The length of the two CAN(FD) frame structures define the maximum transfer
+  unit (MTU) of the CAN(FD) network interface and skbuff data length. Two
+  definitions are specified for CAN specific MTUs in include/linux/can.h :
+
+  #define CAN_MTU   (sizeof(struct can_frame))   == 16  => 'legacy' CAN frame
+  #define CANFD_MTU (sizeof(struct canfd_frame)) == 72  => CAN FD frame
+
   4.1 RAW protocol sockets with can_filters (SOCK_RAW)
    Using CAN_RAW sockets is extensively comparable to the commonly
@@ -472,7 +519,69 @@ solution for a couple of reasons:
     setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS,
                &recv_own_msgs, sizeof(recv_own_msgs));
 -  4.1.5 RAW socket returned message flags
+  4.1.5 RAW socket option CAN_RAW_FD_FRAMES
+
+  CAN FD support in CAN_RAW sockets can be enabled with a new socket option
+  CAN_RAW_FD_FRAMES which is off by default. When the new socket option is
+  not supported by the CAN_RAW socket (e.g. on older kernels), switching the
+  CAN_RAW_FD_FRAMES option returns the error -ENOPROTOOPT.
+
+  Once CAN_RAW_FD_FRAMES is enabled the application can send both CAN frames
+  and CAN FD frames. OTOH the application has to handle CAN and CAN FD frames
+  when reading from the socket.
+
+    CAN_RAW_FD_FRAMES enabled:  CAN_MTU and CANFD_MTU are allowed
+    CAN_RAW_FD_FRAMES disabled: only CAN_MTU is allowed (default)
+
+  Example:
+    [ remember: CANFD_MTU == sizeof(struct canfd_frame) ]
+
+    struct canfd_frame cfd;
+
+    nbytes = read(s, &cfd, CANFD_MTU);
+
+    if (nbytes == CANFD_MTU) {
+            printf("got CAN FD frame with length %d\n", cfd.len);
+	    /* cfd.flags contains valid data */
+    } else if (nbytes == CAN_MTU) {
+            printf("got legacy CAN frame with length %d\n", cfd.len);
+	    /* cfd.flags is undefined */
+    } else {
+            fprintf(stderr, "read: invalid CAN(FD) frame\n");
+            return 1;
+    }
+
+    /* the content can be handled independently from the received MTU size */
+
+    printf("can_id: %X data length: %d data: ", cfd.can_id, cfd.len);
+    for (i = 0; i < cfd.len; i++)
+            printf("%02X ", cfd.data[i]);
+
+  When reading with size CANFD_MTU only returns CAN_MTU bytes that have
+  been received from the socket a legacy CAN frame has been read into the
+  provided CAN FD structure. Note that the canfd_frame.flags data field is
+  not specified in the struct can_frame and therefore it is only valid in
+  CANFD_MTU sized CAN FD frames.
+
+  As long as the payload length is <=8 the received CAN frames from CAN FD
+  capable CAN devices can be received and read by legacy sockets too. When
+  user-generated CAN FD frames have a payload length <=8 these can be send
+  by legacy CAN network interfaces too. Sending CAN FD frames with payload
+  length > 8 to a legacy CAN network interface returns an -EMSGSIZE error.
+
+  Implementation hint for new CAN applications:
+
+  To build a CAN FD aware application use struct canfd_frame as basic CAN
+  data structure for CAN_RAW based applications. When the application is
+  executed on an older Linux kernel and switching the CAN_RAW_FD_FRAMES
+  socket option returns an error: No problem. You'll get legacy CAN frames
+  or CAN FD frames and can process them the same way.
+
+  When sending to CAN devices make sure that the device is capable to handle
+  CAN FD frames by checking if the device maximum transfer unit is CANFD_MTU.
+  The CAN device MTU can be retrieved e.g. with a SIOCGIFMTU ioctl() syscall.
+
+  4.1.6 RAW socket returned message flags
    When using recvmsg() call, the msg->msg_flags may contain following flags:
 @@ -573,10 +682,13 @@ solution for a couple of reasons:
     dev->type  = ARPHRD_CAN; /* the netdevice hardware type */
     dev->flags = IFF_NOARP;  /* CAN has no arp */
 -    dev->mtu   = sizeof(struct can_frame);
+    dev->mtu = CAN_MTU; /* sizeof(struct can_frame) -> legacy CAN interface */
 -  The struct can_frame is the payload of each socket buffer in the
-  protocol family PF_CAN.
+    or alternative, when the controller supports CAN with flexible data rate:
+    dev->mtu = CANFD_MTU; /* sizeof(struct canfd_frame) -> CAN FD interface */
+
+  The struct can_frame or struct canfd_frame is the payload of each socket
+  buffer (skbuff) in the protocol family PF_CAN.
    6.2 local loopback of sent frames
 @@ -792,7 +904,33 @@ solution for a couple of reasons:
   Note that a restart will also create a CAN error message frame (see
   also chapter 3.4).
 -  6.6 Supported CAN hardware
+  6.6 CAN FD (flexible data rate) driver support
+
+  CAN FD capable CAN controllers support two different bitrates for the
+  arbitration phase and the payload phase of the CAN FD frame. Therefore a
+  second bittiming has to be specified in order to enable the CAN FD bitrate.
+
+  Additionally CAN FD capable CAN controllers support up to 64 bytes of
+  payload. The representation of this length in can_frame.can_dlc and
+  canfd_frame.len for userspace applications and inside the Linux network
+  layer is a plain value from 0 .. 64 instead of the CAN 'data length code'.
+  The data length code was a 1:1 mapping to the payload length in the legacy
+  CAN frames anyway. The payload length to the bus-relevant DLC mapping is
+  only performed inside the CAN drivers, preferably with the helper
+  functions can_dlc2len() and can_len2dlc().
+
+  The CAN netdevice driver capabilities can be distinguished by the network
+  devices maximum transfer unit (MTU):
+
+  MTU = 16 (CAN_MTU)   => sizeof(struct can_frame)   => 'legacy' CAN device
+  MTU = 72 (CANFD_MTU) => sizeof(struct canfd_frame) => CAN FD capable device
+
+  The CAN device MTU can be retrieved e.g. with a SIOCGIFMTU ioctl() syscall.
+  N.B. CAN FD capable devices can also handle and send legacy CAN frames.
+
+  FIXME: Add details about the CAN FD controller configuration when available.
+
+  6.7 Supported CAN hardware
    Please check the "Kconfig" file in "drivers/net/can" to get an actual
   list of the support CAN hardware. On the Socket CAN project website
-- 
1.7.10.4

