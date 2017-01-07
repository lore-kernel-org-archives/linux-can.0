From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Issues with SocketCAN
Date: Sat, 7 Jan 2017 15:16:21 +0100
Message-ID: <67c0bc8f-2ee4-d64d-977b-a9c6e7d80779@hartkopp.net>
References: <a4601513-6eb3-eef1-8245-11010d74e685@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:18171 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932828AbdAGOQ0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 7 Jan 2017 09:16:26 -0500
In-Reply-To: <a4601513-6eb3-eef1-8245-11010d74e685@web.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Josenhans <michael.josenhans@web.de>, linux-can@vger.kernel.org

Hi Michael,

On 01/07/2017 02:05 PM, Michael Josenhans wrote:

> 1) Concurrent BCM channels:
>
> Is it possible to use concurrent BCM channels?
> When using multiple BCM channels it did not seem to work, but I did not
> get an error message, nor did I find anything prohibiting it in the
> SocketCAN specification
> (https://www.kernel.org/doc/Documentation/networking/can.txt).

What are "concurrent BCM channels"?

You can open multiple CAN_BCM sockets and all of them operate 
independently and can work on different CAN interfaces each.

> 2) BCM Sending / BCM Receiving of CAN- and CAN_FD-frames:
>
> Is it possible to mix sending and receiving CAN- and CAN_FD-frames via
> the BCM? I did not find anything related in the SocketCAN specification.
> Not sure if this even makes sense?

The bit CAN_FD_FRAME in the bcm_msg_head flags defines the binary 
representation of the following CAN(FD) frame array.

You can open one CAN_BCM socket and you can send multiple RX/TX jobs to 
this socket which are distinguished by CAN ID / interface / CAN_FD_FRAME 
flag:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/can/bcm.c#n718

>
> 3) BCM TX_READ:
>
> Is there a TX_READ example. I did not get it working.
>
> I had been using the Sequence TX_SETUP, TX_DELETE, TX_READ. Especially
> it is unclear, what TX_READ is supposed to return.

TX_READ is supposed to read the tx job configuration which was given by 
TX_SETUP.

A working example for TX_READ is here:

https://github.com/linux-can/can-tests/blob/master/tst-bcm-tx_read.c

>
> A (broken) TTCN-3 testcase for this is available.
>
> 4) SocketCAN specification for getting the interface name
>
> I saw that later SocketCAN application implementations use the function
> if_nametoindex instead of the way recommended in:
>
> https://www.kernel.org/doc/Documentation/networking/can.txt
>
> Which is the preferred way? Should the specification be updated?

Both are fine to use.

In fact if_nametoindex() uses a library function that opens an 
additional PF_PACKET socket to get the interface index.

if_nametoindex() is a convenience function.

Using

	strcpy(ifr.ifr_name, "can0");
	ioctl(s, SIOCGIFINDEX, &ifr);

is just more application code to reach the same target.

> 5) Socketname of BCM socket:
>
> I have set the BCM socket as default to "vcan0".
>
> Why is the socket name, when retrieved set to "any".
>
>     s = socket(PF_CAN, SOCK_DGRAM, CAN_BCM);
>     strcpy(ifr.ifr_name, "vcan0");
>     ioctl(s, SIOCGIFINDEX, &ifr);
>
> Why ifr.ifr_ifindex == 0?

You should check for ioctl's return value.
Are you sure vcan0 exists in your system?
Did you create it and set it to 'up'?

> 6) Querying the BCM socketname for interface Index = 0 (=Any)
>
> Querying the interface name for interface index set to 0 fails:
>
> Example:
>
>     ifr.ifr_ifindex = 0; /* Any interface*/
>     ioctl(s, SIOCGIFNAME, &ifr);
>

There is no interface name for interface index 0.

Interface index 0 is not defined in Linux and we use this value to read 
data from 'any' CAN interface, e.g. using the CAN_RAW socket in candump.
This is a PF_CAN specific thing on the interface index value.

> 7) RTR-Bit
>
> What is the purpose of the RTR-bit, if set in the CAN-ID?

https://en.wikipedia.org/wiki/CAN_bus#Remote_frame

> 8) Send queue full behavior is unclear to me
>
> How to handle writing of long sequences of CAN-messages. E.g. SAE J1939
> based standards like Isobus segment large messages into a sequence of
> CAN-Frames. These may easily overflow any configured CAN-queue size.
>
>  nbytes = write(s, &frame, sizeof(struct can_frame));
>
> I assume that nbytes becomes 0, if nothing could be sent as the queue is
> full and -1 in case of an error. How to resume sending when the send
> queue becomes empty again? Is there a blocking write?

See chapter 3.4 here:
http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

> 9) SocketCAN-kernel interface versioning
>
> Is there a defined way to build a software against any (older or newer)
> kernel version?
> It was quite a mess, when building against multiple kernels. When
> looking at the latest version of the specification it seemed to get even
> more complicated.
> I have to do this as the test adapter is not shipped with the kernel but
> with TTCN-Titan.
>
> Here is the solution I came up with:
>
>
> // workaround, as some of those below may not yet be defined in
> "linux/can/raw.h":
> #define CAN_RAW_FILTER            1 /* set 0 .. n can_filter(s)          */
> #define CAN_RAW_ERR_FILTER        2 /* set filter for error frames       */
> #define CAN_RAW_LOOPBACK          3 /* local loopback (default:on)       */
> #define CAN_RAW_RECV_OWN_MSGS     4 /* receive my own msgs (default:off) */
> #define CAN_RAW_FD_FRAMES         5 /* allow CAN FD frames (default:off) */
> #define CAN_RAW_JOIN_FILTERS      6 /* all filters must match to trigger */
>
> // workaround, as not yet defined in all versions of "linux/Can.h":
> #ifndef CAN_MAX_DLEN
> #define CAN_MAX_DLEN 8
> #endif
>
> // workaround, as not defined in some older kernel versions
> #ifndef    CAN_MTU
> #define CAN_MTU        (sizeof(struct can_frame))
> #endif  //CANFD_MTU
>
> // workaround, as canfd not defined in some older kernel versions
> // and thus canfd frames can not be used for data transfer between
> // kernel module and userspace.
> #ifdef    CANFD_MTU
> #define CANFD_FRAME_STRUCT_DEFINED             true
> #define RAW_CANFD_SUPPORT                      true
> #endif  //CANFD_MTU
>
> // has to be defined in later kernel versions in bcm.h as #define
> CAN_FD_FRAME   0x0800
> #ifdef  CAN_FD_FRAME
> #define BCM_CANFD_SUPPORT                      true
> #endif
>
> I use the following compile flags in my software:
> CANFD_FRAME_STRUCT_DEFINED
> RAW_CANFD_SUPPORT
> BCM_CANFD_SUPPORT
>
> Is there a better way to do that?

The binary API is fixed and can only be extended by the time.

I would suggest to create you compile flags based on the Linux kernel 
version and always use the latest can.h and friends.

> 10) SocketCAN-regression tests
> Is there a need for a SocketCAN-regression test suite?

This test has been contributed to the Linux Test Project (LTP):
https://github.com/linux-can/can-tests/blob/master/test_netlayer.sh

More regression tests are always welcome :-)
I'll try to support you as best I can.

Best regards,
Oliver


> Reference:
> http://elinux.org/TTCN

