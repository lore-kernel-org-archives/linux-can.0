From: Michael Josenhans <michael.josenhans@web.de>
Subject: Issues with SocketCAN
Date: Sat, 7 Jan 2017 14:05:11 +0100
Message-ID: <a4601513-6eb3-eef1-8245-11010d74e685@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:59964 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932228AbdAGNFQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 7 Jan 2017 08:05:16 -0500
Received: from [192.168.178.35] ([89.244.96.239]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MB06e-1cI6vD488q-009xUD for
 <linux-can@vger.kernel.org>; Sat, 07 Jan 2017 14:05:12 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dear all,

the last months I wrote a TTCN-test adapter for the eclipse titan. 
Eclipse Titan is a TTCN-3 compiler written in C++ with Eclipse IDE 
integration provided by Ericsson.

TTCN is a protocol testing language widely used by various Standards 
such as 3GPP, ITU, Bluetooth, .. for protocol tests and protocol 
conformance tests. It allows now testing of complex scenarios with a 
fraction of the usually needed effort.

With the TTCN-test adapter it is now possible to do CAN-protocol tests 
using TTCN-3.

While developing the test adapter, I build also some regression tests 
and came up with several issues I'd like to get clarifications on:

1) Concurrent BCM channels:

Is it possible to use concurrent BCM channels?
When using multiple BCM channels it did not seem to work, but I did not 
get an error message, nor did I find anything prohibiting it in the 
SocketCAN specification 
(https://www.kernel.org/doc/Documentation/networking/can.txt).

2) BCM Sending / BCM Receiving of CAN- and CAN_FD-frames:

Is it possible to mix sending and receiving CAN- and CAN_FD-frames via 
the BCM? I did not find anything related in the SocketCAN specification. 
Not sure if this even makes sense?

3) BCM TX_READ:

Is there a TX_READ example. I did not get it working.

I had been using the Sequence TX_SETUP, TX_DELETE, TX_READ. Especially 
it is unclear, what TX_READ is supposed to return.

A (broken) TTCN-3 testcase for this is available.

4) SocketCAN specification for getting the interface name

I saw that later SocketCAN application implementations use the function 
if_nametoindex instead of the way recommended in:

https://www.kernel.org/doc/Documentation/networking/can.txt

Which is the preferred way? Should the specification be updated?

5) Socketname of BCM socket:

I have set the BCM socket as default to "vcan0".

Why is the socket name, when retrieved set to "any".

     s = socket(PF_CAN, SOCK_DGRAM, CAN_BCM);
     strcpy(ifr.ifr_name, "vcan0");
     ioctl(s, SIOCGIFINDEX, &ifr);

Why ifr.ifr_ifindex == 0?

6) Querying the BCM socketname for interface Index = 0 (=Any)

Querying the interface name for interface index set to 0 fails:

Example:

     ifr.ifr_ifindex = 0; /* Any interface*/
     ioctl(s, SIOCGIFNAME, &ifr);

7) RTR-Bit

What is the purpose of the RTR-bit, if set in the CAN-ID?

8) Send queue full behavior is unclear to me

How to handle writing of long sequences of CAN-messages. E.g. SAE J1939 
based standards like Isobus segment large messages into a sequence of 
CAN-Frames. These may easily overflow any configured CAN-queue size.

  nbytes = write(s, &frame, sizeof(struct can_frame));

I assume that nbytes becomes 0, if nothing could be sent as the queue is 
full and -1 in case of an error. How to resume sending when the send 
queue becomes empty again? Is there a blocking write?

9) SocketCAN-kernel interface versioning

Is there a defined way to build a software against any (older or newer) 
kernel version?
It was quite a mess, when building against multiple kernels. When 
looking at the latest version of the specification it seemed to get even 
more complicated.
I have to do this as the test adapter is not shipped with the kernel but 
with TTCN-Titan.

Here is the solution I came up with:


// workaround, as some of those below may not yet be defined in 
"linux/can/raw.h":
#define CAN_RAW_FILTER            1 /* set 0 .. n can_filter(s)          */
#define CAN_RAW_ERR_FILTER        2 /* set filter for error frames       */
#define CAN_RAW_LOOPBACK          3 /* local loopback (default:on)       */
#define CAN_RAW_RECV_OWN_MSGS     4 /* receive my own msgs (default:off) */
#define CAN_RAW_FD_FRAMES         5 /* allow CAN FD frames (default:off) */
#define CAN_RAW_JOIN_FILTERS      6 /* all filters must match to trigger */

// workaround, as not yet defined in all versions of "linux/Can.h":
#ifndef CAN_MAX_DLEN
#define CAN_MAX_DLEN 8
#endif

// workaround, as not defined in some older kernel versions
#ifndef    CAN_MTU
#define CAN_MTU        (sizeof(struct can_frame))
#endif  //CANFD_MTU

// workaround, as canfd not defined in some older kernel versions
// and thus canfd frames can not be used for data transfer between
// kernel module and userspace.
#ifdef    CANFD_MTU
#define CANFD_FRAME_STRUCT_DEFINED             true
#define RAW_CANFD_SUPPORT                      true
#endif  //CANFD_MTU

// has to be defined in later kernel versions in bcm.h as #define 
CAN_FD_FRAME   0x0800
#ifdef  CAN_FD_FRAME
#define BCM_CANFD_SUPPORT                      true
#endif

I use the following compile flags in my software:
CANFD_FRAME_STRUCT_DEFINED
RAW_CANFD_SUPPORT
BCM_CANFD_SUPPORT

Is there a better way to do that?

10) SocketCAN-regression tests
Is there a need for a SocketCAN-regression test suite?

Best regards,
Michael

PS:

Reference:
http://elinux.org/TTCN

