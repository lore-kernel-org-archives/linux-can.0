From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Issues with SocketCAN
Date: Sun, 8 Jan 2017 15:08:28 +0100
Message-ID: <57cab00a-ecab-143b-8884-af888425f59b@hartkopp.net>
References: <a4601513-6eb3-eef1-8245-11010d74e685@web.de>
 <67c0bc8f-2ee4-d64d-977b-a9c6e7d80779@hartkopp.net>
 <705a81dc-36f6-3022-9a8b-9c114608414c@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:11815 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967783AbdAHOIh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 8 Jan 2017 09:08:37 -0500
In-Reply-To: <705a81dc-36f6-3022-9a8b-9c114608414c@web.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Josenhans <michael.josenhans@web.de>
Cc: linux-can@vger.kernel.org

Hello Michael,

On 01/07/2017 11:36 PM, Michael Josenhans wrote:

>> What are "concurrent BCM channels"?
>>
>> You can open multiple CAN_BCM sockets and all of them operate
>> independently and can work on different CAN interfaces each.
>>
>
> No, I have opened multiple BCM sockets for the same interface "vcan0".
> Not sure if this is permitted or should be prevented.

It's just up to you.
Based on your application and how the data is demultiplexed there it 
could make sense - but usually one BCM socket per interface is enough.

>>> 2) BCM Sending / BCM Receiving of CAN- and CAN_FD-frames:
>>>
>>> Is it possible to mix sending and receiving CAN- and CAN_FD-frames via
>>> the BCM? I did not find anything related in the SocketCAN specification.
>>> Not sure if this even makes sense?
>>
>> The bit CAN_FD_FRAME in the bcm_msg_head flags defines the binary
>> representation of the following CAN(FD) frame array.
>>
>> You can open one CAN_BCM socket and you can send multiple RX/TX jobs to
>> this socket which are distinguished by CAN ID / interface / CAN_FD_FRAME
>> flag:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/can/bcm.c#n718
>>
>>
>
>
> Asked differently. Can I send CAN_FD- and CAN-frames on the same
> interface e.g. "vcan0"?

Yes. When the CAN interface is enabled to handle CAN FD frames you can 
send both type of CAN frames (CAN / CANFD) in a wild mix:

You need to set the device MTU to 72 (sizeof(struct canfd_frame)) on the 
vcan0 interface before setting it to 'up'.

https://github.com/linux-can/can-misc/blob/master/etc/can_if#L38

ip link add name vcan0 type vcan
ip link set vcan0 mtu 72
ip link set vcan0 up


> Is it permitted that I create a sequence with TX_SETUP, which sends
> first a CAN-frame and then 2 CAN_FD-frames?

No. The TX_SETUP allows to setup CAN 'OR' CAN FD (=> CAN_FD_FRAME flag)

You can create a TX_SETUP for CAN ID 0x123 with CAN_FD_FRAME flag set.
You can create a TX_SETUP for CAN ID 0x123 with CAN_FD_FRAME flag clear.

But these tx jobs are not in a relation to each other.

> I need to review the BCM implementation for CAN_FD and add some test cases.

Good idea :-)

>> TX_READ is supposed to read the tx job configuration which was given by
>> TX_SETUP.
>>
>> A working example for TX_READ is here:
>>
>> https://github.com/linux-can/can-tests/blob/master/tst-bcm-tx_read.c
>>
> I tried with the same parameters. But it does not seem to work. I
> crashes my whole linux PC.
> The test case did not work before, but it did not crash the PC in the
> past. Now the shell sometimes keeps working, but I can not activate any
> other kde-window anymore.

You should never be able to crash your system by using BCM syscalls.
Can you post the code that created the crash?

> Lately I have updated the TTCN compiler version and also the kernel.
> I am currently running kbuntu 16.10 and ubuntu 16.10. In the past I used
> ubuntu 16.04. I do not think that it is caused by the TTCN-compiler. We
> will check with older versions.
>
> In above example there are 2 CAN_IDs:
> msg.msg_head.can_id  = 0x42;
> msg.frame[0].can_id = 0xAA;
>
> In the log of candump I did not remember to have seen the CAN_ID 0xAA.

Yes. This was a test whether the flag TX_CP_CAN_ID did its work 
correctly and the msg.msg_head.can_id is copied into all 
msg.frame[?].can_id's.

> Is there a documentation of the BCM commands and their parameters?
> Is there a specification, on what TX_READ should return?

A short description is here:
https://www.kernel.org/doc/Documentation/networking/can.txt

A more detailed description in German can you find here in Chapter B.3:

http://edoc2.bibliothek.uni-halle.de/hs/urn/urn:nbn:de:101:1-201108243513

>>> 6) Querying the BCM socketname for interface Index = 0 (=Any)
>>>
>>> Querying the interface name for interface index set to 0 fails:
>>>
>>> Example:
>>>
>>>     ifr.ifr_ifindex = 0; /* Any interface*/
>>>     ioctl(s, SIOCGIFNAME, &ifr);
>>>
>>
>> There is no interface name for interface index 0.
>>
>> Interface index 0 is not defined in Linux and we use this value to read
>> data from 'any' CAN interface, e.g. using the CAN_RAW socket in candump.
>> This is a PF_CAN specific thing on the interface index value.
>>
>
> As I understood the 'any' interface can be used for sending or do I have
> always to select a specific interface such as "vcan0" for sending?
>
> Here the related sections from the specification:
>     "To send on a socket that is bound to 'any' interface sendto(2) is
> needed to specify the outgoing interface."
>     "When the broadcast manager socket is bound to 'any' CAN interface"
>
> Did I misinterpret 'any' here?

Reading from 'any' interface is simple: You get the content from all CAN 
interfaces registered on this linux host. This is implemented with a 
separate filter list in the CAN subsystem.

Writing to 'any' CAN interface is not supported. You always need to 
provide an interface for sending CAN frames (either on BCM and RAW 
sockets) -> use sendto() on sockets bound to 'any'.

>> I would suggest to create you compile flags based on the Linux kernel
>> version and always use the latest can.h and friends.
>>
>
>>
> Do you suggest that I review the can changes in all mainline kernels and
> create something like this:
>
>
> #include <linux/version.h>
>
> #if LINUX_VERSION_CODE <= KERNEL_VERSION(X1,Y1,Z1)
>
> #define CANFD_FRAME_STRUCT_DEFINED             true
> #define RAW_CANFD_SUPPORT                      true
>
> #else
>
> #define CANFD_FRAME_STRUCT_DEFINED             false
> #define RAW_CANFD_SUPPORT                      false
>
> #endif

Yes.

> #if LINUX_VERSION_CODE <= KERNEL_VERSION(X2,Y2,Z2)
>
> #define CANFD_FRAME_STRUCT_DEFINED             true
> #define RAW_CANFD_SUPPORT                      true
>
> #else
>
> #define CAN_MAX_DLEN 8
> #define CAN_MTU        (sizeof(struct can_frame))
>
> #endif
>
>
> Ref:
> http://stackoverflow.com/questions/16721346/linux-kernel-version-macro-definition

The CAN subsystem is not changing very fast.
A big impact was the CAN FD integration.

Other changes are mostly functional enhancements, e.g. with 
CAN_RAW_JOIN_FILTERS in RAW sockets.

Do you think about tracking each of them?

>>> 10) SocketCAN-regression tests
>>> Is there a need for a SocketCAN-regression test suite?
>>
>> This test has been contributed to the Linux Test Project (LTP):
>> https://github.com/linux-can/can-tests/blob/master/test_netlayer.sh
>>
>> More regression tests are always welcome :-)
>>
> I had been thinking on building a test suite with the test cases in TTCN.
> In fact I have already build a test suite with some test cases for my
> purpose:
>
> Until now I have created the following tests:
> <TTCN-testcase-filename>.<testcasename>
> SocketCAN_RAW_test.tc_can_raw_send_and_receive_frame
> SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_FILTER
> SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_ERR_FILTER
> SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_LOOPBACK
> SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_RECV_OWN_MSGS
> SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_FD_FRAMES
> SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_JOIN_FILTERS
>
> //CAN BCM tests
> SocketCAN_BCM_test.tc_can_bcm_TX_SETUP_TX_DELETE                 (lately
> broken, crashes on some kernels, needs to be investigated)

I'll take a look at this too.

> SocketCAN_BCM_test.tc_can_bcm_TX_SETUP_TX_DELETE_TX_READ__broken
> (broken, handling of TX_READ unclear)

dito.

> Especially for building bcm tests I am lacking a clear description of
> the BCM commands, the meaning of their parameter and their expected
> returns.

See above.

Regards,
Oliver

