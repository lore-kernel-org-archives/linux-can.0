From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next] Add broadcast manager documentation
Date: Mon, 14 Oct 2013 21:41:44 +0200
Message-ID: <525C48F8.1050907@hartkopp.net>
References: <CAENe87otPZVjDkvJJDR4CLE2e4dcyzde1=5rQZWytG_JyOpvsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:18956 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434Ab3JNTlr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Oct 2013 15:41:47 -0400
In-Reply-To: <CAENe87otPZVjDkvJJDR4CLE2e4dcyzde1=5rQZWytG_JyOpvsQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Brian Thorne <hardbyte@gmail.com>
Cc: linux-can@vger.kernel.org

On 08.10.2013 02:56, Brian Thorne wrote:
> Hi all,
> 
> I wanted to use the bcm module and ended up putting together some basic findings
> that might be a useful addition to the can.txt documentation.
> 
> I haven't tried submitting any patches before so please point out any mistakes.
> 
> Cheers,
> Brian
> 

Hi Brian,

I updated and enhanced your documentation patch for the broadcast manager.

Please review and make your annotations inline.

Tnx,
Oliver




Signed-off-by: Brian Thorne <hardbyte@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index 820f553..f227ba6 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -25,6 +25,10 @@ This file contains
       4.1.5 RAW socket option CAN_RAW_FD_FRAMES
       4.1.6 RAW socket returned message flags
     4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
+      4.2.1 Broadcast Manager Operations
+      4.2.2 Broadcast Manager message flags
+      4.2.3 Broadcast Manager message sequence transmission
+      4.2.4 Broadcast Manager multiplex message receive filter
     4.3 connected transport protocols (SOCK_SEQPACKET)
     4.4 unconnected transport protocols (SOCK_DGRAM)
 
@@ -593,6 +597,161 @@ solution for a couple of reasons:
       In order to receive such messages, CAN_RAW_RECV_OWN_MSGS must be set.
 
   4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
+
+  The Broadcast Manager protocol provides a command based configuration
+  interface to filter and send (e.g. cyclic) CAN messages in kernel space.
+
+  Receive filters can be used to down sample frequent messages; detect events
+  such as message contents changes, packet length changes, and do time-out
+  monitoring of received messages.
+
+  Periodic transmissions can be modified at runtime; both the message content
+  and the transmit interval can be altered. Periodic transmissions can use two
+  intervals, sending a number of messages at a interval ival1, then continuing
+  to send at another given interval ival2.
+
+  A BCM socket is not intended for sending individual CAN frames using the
+  struct can_frame as known from the CAN_RAW socket. Instead a special BCM
+  configuration message is defined. The basic BCM configuration message used
+  to communicate with the broadcast manager and the available operations are
+  defined in the linux/can/bcm.h include. The BCM message consists of a
+  message header with an 'opcode' command followed by zero or more CAN frames.
+  The broadcast manager sends responses to user space in the same form:
+
+    struct bcm_msg_head {
+            __u32 opcode;                   /* command */
+            __u32 flags;                    /* special flags */
+            __u32 count;                    /* run 'count' times with ival1 */
+            struct timeval ival1, ival2;    /* count and subsequent interval */
+            canid_t can_id;                 /* unique can_id for task */
+            __u32 nframes;                  /* number of can_frames following */
+            struct can_frame frames[0];
+    };
+
+  The frames payload uses the same basic CAN frame structure defined at the
+  beginning of section 4. All messages to the broadcast manager from user
+  space have this structure.
+
+  Note a CAN_BCM socket must be connected instead of bound after socket
+  creation (example without error checking):
+
+    int s;
+    struct sockaddr_can addr;
+    struct ifreq ifr;
+
+    s = socket(PF_CAN, SOCK_DGRAM, CAN_BCM);
+
+    strcpy(ifr.ifr_name, "can0");
+    ioctl(s, SIOCGIFINDEX, &ifr);
+
+    addr.can_family = AF_CAN;
+    addr.can_ifindex = ifr.ifr_ifindex;
+
+    connect(s, (struct sockaddr *)&addr, sizeof(addr))
+
+    (..)
+
+  The broadcast manager socket is able to handle any number of in flight
+  transmissions or receive filters concurrently. The different RX/TX jobs are
+  distinguished by the unique can_id in each BCM message. However additional
+  CAN_BCM sockets are recommended to communicate on multiple CAN interfaces.
+  When the broadcast manager socket is bound to 'any' CAN interface (=> the
+  interface index is set to zero) the configured receive filters apply to any
+  CAN interface unless the sendto() syscall is used to overrule the zero CAN
+  interface index. When using recvfrom() instead of read() to retrieve BCM
+  socket messages the originating CAN interface is provided in can_ifindex.
+
+  4.2.1 Broadcast Manager Operations
+
+  The opcode defines the operation for the broadcast manager to carry out, or
+  details the broadcast managers response to several events, including user
+  requests.
+
+  Transmit Operations (user space to broadcast manager):
+
+    TX_SETUP:   create (cyclic) transmission task
+
+    TX_DELETE:  remove (cyclic) transmission task, requires only can_id.
+
+    TX_READ:    read properties of (cyclic) transmission task
+
+    TX_SEND:    send one CAN frame
+
+  Transmit Responses (broadcast manager to user space):
+
+    TX_STATUS:  reply to TX_READ request
+
+    TX_EXPIRED: notification when counter finishes sending at initial interval
+      Requires the TX_COUNTEVT flag to be set.
+
+  Receive Operations (user space to broadcast manager):
+
+    RX_SETUP:   create RX content filter subscription
+
+    RX_DELETE:  remove RX content filter subscription, requires only can_id.
+
+    RX_READ:    read properties of RX content filter subscription
+
+  Receive Responses (broadcast manager to user space):
+
+    RX_STATUS:  reply to RX_READ request
+
+    RX_TIMEOUT: Cyclic message is detected to be absent
+
+    RX_CHANGED: updated CAN frame (detected content change). Sent on first
+      message received or on a receipt of a revised CAN messages.
+
+  4.2.2 Broadcast Manager message flags
+
+  When sending a message to the broadcast manager the msg->flags may contain
+  the following flags which influence the behaviour:
+
+    SETTIMER:           Set the value of ival1, ival2 and count
+
+    STARTTIMER:         Start the timer with the actual value of ival1, ival2
+      and count. Starting the timer leads simultaneously to emit a can_frame.
+
+    TX_COUNTEVT:        create the message TX_EXPIRED when count expires
+
+    TX_ANNOUNCE:        A change of data by the process is emitted immediately.
+
+    TX_CP_CAN_ID:       Copies the can_id from the message header to each
+      subsequent frame in frames. This is intended as usage simplification. For
+      TX tasks the unique can_id from the message header may differ from the
+      can_id(s) stored for transmission in the subsequent struct can_frame(s).
+
+    RX_FILTER_ID:       Filter by can_id alone, no frames required (nframes=0)
+
+    RX_CHECK_DLC:       A change of the DLC leads to an RX_CHANGED.
+
+    RX_NO_AUTOTIMER:    Prevent automatically starting the timeout monitor.
+
+    RX_ANNOUNCE_RESUME: If passed to RX_SETUP, when a receive timeout occurs,
+      an RX_CHANGED will be generated when the (cyclic) receive restarts.
+
+    TX_RESET_MULTI_IDX: Start multiple frame transmission with index 0.
+
+    RX_RTR_FRAME:       send reply for RTR-request (placed in op->frames[0])
+
+  4.2.3 Broadcast Manager message sequence transmission
+
+  Up to 256 CAN frames can be transmitted in a sequence in the case of a cyclic
+  TX task. The number of CAN frames is provided in the 'nframes' element of the
+  BCM message head. The defined number of CAN frames are added as array to the
+  TX_SETUP BCM configuration message. With every transmission the index in the
+  array of CAN frames is increased and set to zero at index overflow.
+
+  4.2.4 Broadcast Manager multiplex message receive filter
+
+  To filter for content changes in multiplex message sequences an array of more
+  than one CAN frames can be passed in a RX_SETUP configuration message. The
+  data bytes of the first CAN frame contain the mask of relevant bits that
+  have to match in the subsequent CAN frames with the received CAN frame.
+  If one of the subsequent CAN frames is matching the bits in that frame data
+  mark the relevant content to be compared with the previous received content.
+  Up to 257 CAN frames (multiplex filter bit mask CAN frame plus 256 CAN
+  filters) can be added as array to the TX_SETUP BCM configuration message. 
+
   4.3 connected transport protocols (SOCK_SEQPACKET)
   4.4 unconnected transport protocols (SOCK_DGRAM)
 

