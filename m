From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next] can: add broadcast manager documentation
Date: Sat, 19 Oct 2013 12:18:56 +0200
Message-ID: <52625C90.6030508@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:47164 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab3JSKTB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 19 Oct 2013 06:19:01 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Brian Thorne <hardbyte@gmail.com>, Daniele Venzano <linux@brownhat.org>, Andre Naujoks <nautsch2@gmail.com>

Signed-off-by: Brian Thorne <hardbyte@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
CC: Daniele Venzano <linux@brownhat.org>
CC: Andre Naujoks <nautsch2@gmail.com>

---

Hi all,

after the latest attempt from Brian i reworked a CAN BCM documentation based
on Brians patch: http://marc.info/?l=linux-can&m=138119382015496&w=2

It's a bit shorter than the original documentation that has been translated
and reworked by Daniele here: http://brownhat.org/docs/socketcan.html

I hope, i was able to catch all the provided functionalities and typos :-)

Thanks for your support and patience.

Best regards,
Oliver


 can.txt |  217 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index 820f553..4c07241 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -25,6 +25,12 @@ This file contains
       4.1.5 RAW socket option CAN_RAW_FD_FRAMES
       4.1.6 RAW socket returned message flags
     4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
+      4.2.1 Broadcast Manager operations
+      4.2.2 Broadcast Manager message flags
+      4.2.3 Broadcast Manager transmission timers
+      4.2.4 Broadcast Manager message sequence transmission
+      4.2.5 Broadcast Manager receive filter timers
+      4.2.6 Broadcast Manager multiplex message receive filter
     4.3 connected transport protocols (SOCK_SEQPACKET)
     4.4 unconnected transport protocols (SOCK_DGRAM)
 
@@ -593,6 +599,217 @@ solution for a couple of reasons:
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
+  Periodic transmission tasks of CAN frames or a sequence of CAN frames can be
+  created and modified at runtime; both the message content and the two
+  possible transmit intervals can be altered.
+
+  A BCM socket is not intended for sending individual CAN frames using the
+  struct can_frame as known from the CAN_RAW socket. Instead a special BCM
+  configuration message is defined. The basic BCM configuration message used
+  to communicate with the broadcast manager and the available operations are
+  defined in the linux/can/bcm.h include. The BCM message consists of a
+  message header with a command ('opcode') followed by zero or more CAN frames.
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
+  The aligned payload 'frames' uses the same basic CAN frame structure defined
+  at the beginning of section 4 and in the include/linux/can.h include. All
+  messages to the broadcast manager from user space have this structure.
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
+  CAN interface unless the sendto() syscall is used to overrule the 'any' CAN
+  interface index. When using recvfrom() instead of read() to retrieve BCM
+  socket messages the originating CAN interface is provided in can_ifindex.
+
+  4.2.1 Broadcast Manager operations
+
+  The opcode defines the operation for the broadcast manager to carry out,
+  or details the broadcast managers response to several events, including
+  user requests.
+
+  Transmit Operations (user space to broadcast manager):
+
+    TX_SETUP:   Create (cyclic) transmission task.
+
+    TX_DELETE:  Remove (cyclic) transmission task, requires only can_id.
+
+    TX_READ:    Read properties of (cyclic) transmission task for can_id.
+
+    TX_SEND:    Send one CAN frame.
+
+  Transmit Responses (broadcast manager to user space):
+
+    TX_STATUS:  Reply to TX_READ request (transmission task configuration).
+
+    TX_EXPIRED: Notification when counter finishes sending at initial interval
+      'ival1'. Requires the TX_COUNTEVT flag to be set at TX_SETUP.
+
+  Receive Operations (user space to broadcast manager):
+
+    RX_SETUP:   Create RX content filter subscription.
+
+    RX_DELETE:  Remove RX content filter subscription, requires only can_id.
+
+    RX_READ:    Read properties of RX content filter subscription for can_id.
+
+  Receive Responses (broadcast manager to user space):
+
+    RX_STATUS:  Reply to RX_READ request (filter task configuration).
+
+    RX_TIMEOUT: Cyclic message is detected to be absent (timer ival1 expired).
+
+    RX_CHANGED: BCM message with updated CAN frame (detected content change).
+      Sent on first message received or on receipt of revised CAN messages.
+
+  4.2.2 Broadcast Manager message flags
+
+  When sending a message to the broadcast manager the 'flags' element may
+  contain the following flag definitions which influence the behaviour:
+
+    SETTIMER:           Set the values of ival1, ival2 and count
+
+    STARTTIMER:         Start the timer with the actual values of ival1, ival2
+      and count. Starting the timer leads simultaneously to emit a CAN frame.
+
+    TX_COUNTEVT:        Create the message TX_EXPIRED when count expires
+
+    TX_ANNOUNCE:        A change of data by the process is emitted immediately.
+
+    TX_CP_CAN_ID:       Copies the can_id from the message header to each
+      subsequent frame in frames. This is intended as usage simplification. For
+      TX tasks the unique can_id from the message header may differ from the
+      can_id(s) stored for transmission in the subsequent struct can_frame(s).
+
+    RX_FILTER_ID:       Filter by can_id alone, no frames required (nframes=0).
+
+    RX_CHECK_DLC:       A change of the DLC leads to an RX_CHANGED.
+
+    RX_NO_AUTOTIMER:    Prevent automatically starting the timeout monitor.
+
+    RX_ANNOUNCE_RESUME: If passed at RX_SETUP and a receive timeout occured, a
+      RX_CHANGED message will be generated when the (cyclic) receive restarts.
+
+    TX_RESET_MULTI_IDX: Reset the index for the multiple frame transmission.
+
+    RX_RTR_FRAME:       Send reply for RTR-request (placed in op->frames[0]).
+
+  4.2.3 Broadcast Manager transmission timers
+
+  Periodic transmission configurations may use up to two interval timers.
+  In this case the BCM sends a number of messages ('count') at an interval
+  'ival1', then continuing to send at another given interval 'ival2'. When
+  only one timer is needed 'count' is set to zero and only 'ival2' is used.
+  When SET_TIMER and START_TIMER flag were set the timers are activated.
+  The timer values can be altered at runtime when only SET_TIMER is set.
+
+  4.2.4 Broadcast Manager message sequence transmission
+
+  Up to 256 CAN frames can be transmitted in a sequence in the case of a cyclic
+  TX task configuration. The number of CAN frames is provided in the 'nframes'
+  element of the BCM message head. The defined number of CAN frames are added
+  as array to the TX_SETUP BCM configuration message.
+
+    /* create a struct to set up a sequence of four CAN frames */
+    struct {
+            struct bcm_msg_head msg_head;
+            struct can_frame frame[4];
+    } mytxmsg;
+
+    (..)
+    mytxmsg.nframes = 4;
+    (..)
+
+    write(s, &mytxmsg, sizeof(mytxmsg));
+
+  With every transmission the index in the array of CAN frames is increased
+  and set to zero at index overflow.
+
+  4.2.5 Broadcast Manager receive filter timers
+
+  The timer values ival1 or ival2 may be set to non-zero values at RX_SETUP.
+  When the SET_TIMER flag is set the timers are enabled:
+
+  ival1: Send RX_TIMEOUT when a received message is not received again within
+    the given time. When START_TIMER is set at RX_SETUP the timeout detection
+    is activated directly - even without a former CAN frame reception.
+
+  ival2: Throttle the received message rate down to the value of ival2. This
+    is useful to reduce messages for the application when the signal inside the
+    CAN frame is stateless as state changes within the ival2 periode may get
+    lost.
+
+  4.2.6 Broadcast Manager multiplex message receive filter
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
+    /* usually used to clear CAN frame data[] - beware of endian problems! */
+    #define U64_DATA(p) (*(unsigned long long*)(p)->data)
+
+    struct {
+            struct bcm_msg_head msg_head;
+            struct can_frame frame[5];
+    } msg;
+
+    msg.msg_head.opcode  = RX_SETUP;
+    msg.msg_head.can_id  = 0x42;
+    msg.msg_head.flags   = 0;
+    msg.msg_head.nframes = 5;
+    U64_DATA(&msg.frame[0]) = 0xFF00000000000000ULL; /* MUX mask */
+    U64_DATA(&msg.frame[1]) = 0x01000000000000FFULL; /* data mask (MUX 0x01) */
+    U64_DATA(&msg.frame[2]) = 0x0200FFFF000000FFULL; /* data mask (MUX 0x02) */
+    U64_DATA(&msg.frame[3]) = 0x330000FFFFFF0003ULL; /* data mask (MUX 0x33) */
+    U64_DATA(&msg.frame[4]) = 0x4F07FC0FF0000000ULL; /* data mask (MUX 0x4F) */
+
+    write(s, &msg, sizeof(msg));
+
   4.3 connected transport protocols (SOCK_SEQPACKET)
   4.4 unconnected transport protocols (SOCK_DGRAM)
 
