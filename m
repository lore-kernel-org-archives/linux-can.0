From: Michael Josenhans <michael.josenhans@web.de>
Subject: Re: Issues with SocketCAN
Date: Sat, 7 Jan 2017 23:36:07 +0100
Message-ID: <705a81dc-36f6-3022-9a8b-9c114608414c@web.de>
References: <a4601513-6eb3-eef1-8245-11010d74e685@web.de>
 <67c0bc8f-2ee4-d64d-977b-a9c6e7d80779@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:55917 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbdAGWgN (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 7 Jan 2017 17:36:13 -0500
In-Reply-To: <67c0bc8f-2ee4-d64d-977b-a9c6e7d80779@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hello Oliver,

thank you for the fast reply:

>> 1) Concurrent BCM channels:
>>
>> Is it possible to use concurrent BCM channels?
>> When using multiple BCM channels it did not seem to work, but I did not
>> get an error message, nor did I find anything prohibiting it in the
>> SocketCAN specification
>> (https://www.kernel.org/doc/Documentation/networking/can.txt).
>
> What are "concurrent BCM channels"?
>
> You can open multiple CAN_BCM sockets and all of them operate
> independently and can work on different CAN interfaces each.
>

No, I have opened multiple BCM sockets for the same interface "vcan0". 
Not sure if this is permitted or should be prevented.


>> 2) BCM Sending / BCM Receiving of CAN- and CAN_FD-frames:
>>
>> Is it possible to mix sending and receiving CAN- and CAN_FD-frames via
>> the BCM? I did not find anything related in the SocketCAN specification.
>> Not sure if this even makes sense?
>
> The bit CAN_FD_FRAME in the bcm_msg_head flags defines the binary
> representation of the following CAN(FD) frame array.
>
> You can open one CAN_BCM socket and you can send multiple RX/TX jobs to
> this socket which are distinguished by CAN ID / interface / CAN_FD_FRAME
> flag:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/can/bcm.c#n718
>


Asked differently. Can I send CAN_FD- and CAN-frames on the same 
interface e.g. "vcan0"?
Is it permitted that I create a sequence with TX_SETUP, which sends 
first a CAN-frame and then 2 CAN_FD-frames?
I think the interface permits that, but does this make sense?

I need to review the BCM implementation for CAN_FD and add some test cases.

>>
>> 3) BCM TX_READ:
>>
>> Is there a TX_READ example. I did not get it working.
>>
>> I had been using the Sequence TX_SETUP, TX_DELETE, TX_READ. Especially
>> it is unclear, what TX_READ is supposed to return.
>
> TX_READ is supposed to read the tx job configuration which was given by
> TX_SETUP.
>
> A working example for TX_READ is here:
>
> https://github.com/linux-can/can-tests/blob/master/tst-bcm-tx_read.c
>
I tried with the same parameters. But it does not seem to work. I 
crashes my whole linux PC.
The test case did not work before, but it did not crash the PC in the 
past. Now the shell sometimes keeps working, but I can not activate any 
other kde-window anymore.

Lately I have updated the TTCN compiler version and also the kernel.
I am currently running kbuntu 16.10 and ubuntu 16.10. In the past I used 
ubuntu 16.04. I do not think that it is caused by the TTCN-compiler. We 
will check with older versions.

In above example there are 2 CAN_IDs:
msg.msg_head.can_id  = 0x42;
msg.frame[0].can_id = 0xAA;

In the log of candump I did not remember to have seen the CAN_ID 0xAA.

Is there a documentation of the BCM commands and their parameters?
Is there a specification, on what TX_READ should return?

>> A (broken) TTCN-3 testcase for this is available.
>>

>> 5) Socketname of BCM socket:
>>
>> I have set the BCM socket as default to "vcan0".
>>
>> Why is the socket name, when retrieved set to "any".
>>
>>     s = socket(PF_CAN, SOCK_DGRAM, CAN_BCM);
>>     strcpy(ifr.ifr_name, "vcan0");
>>     ioctl(s, SIOCGIFINDEX, &ifr);
>>
>> Why ifr.ifr_ifindex == 0?
>
> You should check for ioctl's return value.
> Are you sure vcan0 exists in your system?
> Did you create it and set it to 'up'?
>

I can not reproduce it anymore. I come back, if it should appear again.
>> 6) Querying the BCM socketname for interface Index = 0 (=Any)
>>
>> Querying the interface name for interface index set to 0 fails:
>>
>> Example:
>>
>>     ifr.ifr_ifindex = 0; /* Any interface*/
>>     ioctl(s, SIOCGIFNAME, &ifr);
>>
>
> There is no interface name for interface index 0.
>
> Interface index 0 is not defined in Linux and we use this value to read
> data from 'any' CAN interface, e.g. using the CAN_RAW socket in candump.
> This is a PF_CAN specific thing on the interface index value.
>

As I understood the 'any' interface can be used for sending or do I have 
always to select a specific interface such as "vcan0" for sending?

Here the related sections from the specification:
     "To send on a socket that is bound to 'any' interface sendto(2) is 
needed to specify the outgoing interface."
     "When the broadcast manager socket is bound to 'any' CAN interface"

Did I misinterpret 'any' here?

>
>> 8) Send queue full behavior is unclear to me
>>
>> How to handle writing of long sequences of CAN-messages. E.g. SAE J1939
>> based standards like Isobus segment large messages into a sequence of
>> CAN-Frames. These may easily overflow any configured CAN-queue size.
>>
>>  nbytes = write(s, &frame, sizeof(struct can_frame));
>>
>> I assume that nbytes becomes 0, if nothing could be sent as the queue is
>> full and -1 in case of an error. How to resume sending when the send
>> queue becomes empty again? Is there a blocking write?
>
> See chapter 3.4 here:
> http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

Ok. I will set SO_SNDBUF and txqueuelen accordingly.

>> 9) SocketCAN-kernel interface versioning
>>
>> Is there a defined way to build a software against any (older or newer)
>> kernel version?
>> ...
>
> The binary API is fixed and can only be extended by the time.
>
> I would suggest to create you compile flags based on the Linux kernel
> version and always use the latest can.h and friends.
>

 >
Do you suggest that I review the can changes in all mainline kernels and 
create something like this:


#include <linux/version.h>

#if LINUX_VERSION_CODE <= KERNEL_VERSION(X1,Y1,Z1)

#define CANFD_FRAME_STRUCT_DEFINED             true
#define RAW_CANFD_SUPPORT                      true

#else

#define CANFD_FRAME_STRUCT_DEFINED             false
#define RAW_CANFD_SUPPORT                      false

#endif


#if LINUX_VERSION_CODE <= KERNEL_VERSION(X2,Y2,Z2)

#define CANFD_FRAME_STRUCT_DEFINED             true
#define RAW_CANFD_SUPPORT                      true

#else

#define CAN_MAX_DLEN 8
#define CAN_MTU        (sizeof(struct can_frame))

#endif


Ref:
http://stackoverflow.com/questions/16721346/linux-kernel-version-macro-definition

>> 10) SocketCAN-regression tests
>> Is there a need for a SocketCAN-regression test suite?
>
> This test has been contributed to the Linux Test Project (LTP):
> https://github.com/linux-can/can-tests/blob/master/test_netlayer.sh
>
> More regression tests are always welcome :-)
>
I had been thinking on building a test suite with the test cases in TTCN.
In fact I have already build a test suite with some test cases for my 
purpose:

Until now I have created the following tests:
<TTCN-testcase-filename>.<testcasename>
SocketCAN_RAW_test.tc_can_raw_send_and_receive_frame
SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_FILTER
SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_ERR_FILTER
SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_LOOPBACK
SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_RECV_OWN_MSGS
SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_FD_FRAMES
SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_JOIN_FILTERS

//CAN BCM tests
SocketCAN_BCM_test.tc_can_bcm_TX_SETUP_TX_DELETE                 (lately 
broken, crashes on some kernels, needs to be investigated)
SocketCAN_BCM_test.tc_can_bcm_TX_SETUP_TX_DELETE_TX_READ__broken 
(broken, handling of TX_READ unclear)

Especially for building bcm tests I am lacking a clear description of 
the BCM commands, the meaning of their parameter and their expected returns.


Best regards,
Michael

>> Reference:
>> http://elinux.org/TTCN
