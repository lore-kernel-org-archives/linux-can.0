From: Michael Josenhans <michael.josenhans@web.de>
Subject: Re: Issues with SocketCAN
Date: Sun, 8 Jan 2017 18:29:54 +0100
Message-ID: <61b12351-36f4-6072-0a7c-3992779a1ae6@web.de>
References: <a4601513-6eb3-eef1-8245-11010d74e685@web.de>
 <67c0bc8f-2ee4-d64d-977b-a9c6e7d80779@hartkopp.net>
 <705a81dc-36f6-3022-9a8b-9c114608414c@web.de>
 <57cab00a-ecab-143b-8884-af888425f59b@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:62366 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752549AbdAHRaB (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 8 Jan 2017 12:30:01 -0500
In-Reply-To: <57cab00a-ecab-143b-8884-af888425f59b@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hello Oliver,

>>> What are "concurrent BCM channels"?
>>>
>>> You can open multiple CAN_BCM sockets and all of them operate
>>> independently and can work on different CAN interfaces each.
>>>
>>
>> No, I have opened multiple BCM sockets for the same interface "vcan0".
>> Not sure if this is permitted or should be prevented.
>
> It's just up to you.
> Based on your application and how the data is demultiplexed there it
> could make sense - but usually one BCM socket per interface is enough.

I remember that it did not work. I think I had been sending TX_SETUP and 
TX_DELETE on different BCM channels, but I can not remember the details 
and at the moment I have no test case at hand.

>>>> 2) BCM Sending / BCM Receiving of CAN- and CAN_FD-frames:
>>>>
>>>> Is it possible to mix sending and receiving CAN- and CAN_FD-frames via
>>>> the BCM? I did not find anything related in the SocketCAN
>>>> specification.
>>>> Not sure if this even makes sense?
>>>
>>> The bit CAN_FD_FRAME in the bcm_msg_head flags defines the binary
>>> representation of the following CAN(FD) frame array.
>>>
>>> You can open one CAN_BCM socket and you can send multiple RX/TX jobs to
>>> this socket which are distinguished by CAN ID / interface / CAN_FD_FRAME
>>> flag:
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/can/bcm.c#n718
>>>
>>>
>>>
>>
>>
>> Asked differently. Can I send CAN_FD- and CAN-frames on the same
>> interface e.g. "vcan0"?
>
> Yes. When the CAN interface is enabled to handle CAN FD frames you can
> send both type of CAN frames (CAN / CANFD) in a wild mix:
>
> You need to set the device MTU to 72 (sizeof(struct canfd_frame)) on the
> vcan0 interface before setting it to 'up'.
>
> https://github.com/linux-can/can-misc/blob/master/etc/can_if#L38
>
> ip link add name vcan0 type vcan
> ip link set vcan0 mtu 72
> ip link set vcan0 up
>
Ok. I will try that.

>> Is it permitted that I create a sequence with TX_SETUP, which sends
>> first a CAN-frame and then 2 CAN_FD-frames?
>
> No. The TX_SETUP allows to setup CAN 'OR' CAN FD (=> CAN_FD_FRAME flag)
>
> You can create a TX_SETUP for CAN ID 0x123 with CAN_FD_FRAME flag set.
> You can create a TX_SETUP for CAN ID 0x123 with CAN_FD_FRAME flag clear.
>
> But these tx jobs are not in a relation to each other.
>
>> I need to review the BCM implementation for CAN_FD and add some test
>> cases.
>
> Good idea :-)
>
>>> TX_READ is supposed to read the tx job configuration which was given by
>>> TX_SETUP.
>>>
>>> A working example for TX_READ is here:
>>>
>>> https://github.com/linux-can/can-tests/blob/master/tst-bcm-tx_read.c
>>>
>> I tried with the same parameters. But it does not seem to work. I
>> crashes my whole linux PC.
>> The test case did not work before, but it did not crash the PC in the
>> past. Now the shell sometimes keeps working, but I can not activate any
>> other kde-window anymore.

> You should never be able to crash your system by using BCM syscalls.
> Can you post the code that created the crash?

See my description here:

http://elinux.org/TTCN

You do not need to setup the Eclipse IDE. So you do not have command 
completion, however there will be a new offical version the next few 
days anyway. I hope that will be faster to install.

run:
ttcn3_start SocketCAN SocketCAN.cfg <testcase>

where <testcase> is SocketCAN_BCM_test.tc_can_bcm_TX_SETUP_TX_DELETE

ttcn3_start SocketCAN SocketCAN.cfg \
SocketCAN_BCM_test.tc_can_bcm_TX_SETUP_TX_DELETE

If you should have questions, please ask.

>> Lately I have updated the TTCN compiler version and also the kernel.
>> I am currently running kbuntu 16.10 and ubuntu 16.10. In the past I used
>> ubuntu 16.04. I do not think that it is caused by the TTCN-compiler. We
>> will check with older versions.
>>

I tested with Ubuntu 16.04 and the latest TTCN compiler again, it did 
not crash there. Thus I think it is a kernel/BCM issue.

>> In above example there are 2 CAN_IDs:
>> msg.msg_head.can_id  = 0x42;
>> msg.frame[0].can_id = 0xAA;
>>
>> In the log of candump I did not remember to have seen the CAN_ID 0xAA.
>
> Yes. This was a test whether the flag TX_CP_CAN_ID did its work
> correctly and the msg.msg_head.can_id is copied into all
> msg.frame[?].can_id's.
>
>> Is there a documentation of the BCM commands and their parameters?
>> Is there a specification, on what TX_READ should return?
>
> A short description is here:
> https://www.kernel.org/doc/Documentation/networking/can.txt
>
> A more detailed description in German can you find here in Chapter B.3:
>
> http://edoc2.bibliothek.uni-halle.de/hs/urn/urn:nbn:de:101:1-201108243513
>
>>>> 6) Querying the BCM socketname for interface Index = 0 (=Any)
>>>>
>>>> Querying the interface name for interface index set to 0 fails:
>>>>
>>>> Example:
>>>>
>>>>     ifr.ifr_ifindex = 0; /* Any interface*/
>>>>     ioctl(s, SIOCGIFNAME, &ifr);
>>>>
>>>
>>> There is no interface name for interface index 0.
>>>
>>> Interface index 0 is not defined in Linux and we use this value to read
>>> data from 'any' CAN interface, e.g. using the CAN_RAW socket in candump.
>>> This is a PF_CAN specific thing on the interface index value.
>>>
>>
>> As I understood the 'any' interface can be used for sending or do I have
>> always to select a specific interface such as "vcan0" for sending?
>>
>> Here the related sections from the specification:
>>     "To send on a socket that is bound to 'any' interface sendto(2) is
>> needed to specify the outgoing interface."
>>     "When the broadcast manager socket is bound to 'any' CAN interface"
>>
>> Did I misinterpret 'any' here?
>
> Reading from 'any' interface is simple: You get the content from all CAN
> interfaces registered on this linux host. This is implemented with a
> separate filter list in the CAN subsystem.
>
> Writing to 'any' CAN interface is not supported. You always need to
> provide an interface for sending CAN frames (either on BCM and RAW
> sockets) -> use sendto() on sockets bound to 'any'.

Ok. I will fix that.

>>> I would suggest to create you compile flags based on the Linux kernel
>>> version and always use the latest can.h and friends.
>>>
>>
>>>
>> Do you suggest that I review the can changes in all mainline kernels and
>> create something like this:
>>
>>
>> #include <linux/version.h>
>>
>> #if LINUX_VERSION_CODE <= KERNEL_VERSION(X1,Y1,Z1)
>>
>> #define CANFD_FRAME_STRUCT_DEFINED             true
>> #define RAW_CANFD_SUPPORT                      true
>>
>> #else
>>
>> #define CANFD_FRAME_STRUCT_DEFINED             false
>> #define RAW_CANFD_SUPPORT                      false
>>
>> #endif
>
> Yes.
>
>> #if LINUX_VERSION_CODE <= KERNEL_VERSION(X2,Y2,Z2)
>>
>>
>> #define CAN_MAX_DLEN 8
>> #define CAN_MTU        (sizeof(struct can_frame))
>>
>> #endif
>>
>>
>> Ref:
>> http://stackoverflow.com/questions/16721346/linux-kernel-version-macro-definition
>>
>
> The CAN subsystem is not changing very fast.
> A big impact was the CAN FD integration.
>
> Other changes are mostly functional enhancements, e.g. with
> CAN_RAW_JOIN_FILTERS in RAW sockets.
> Do you think about tracking each of them?

No. Currently I have just redefined this constant. Thus it becomes only 
a runtime dependency.
When it becomes called, it setsockopt will return an error anyway.

TTCN is more formal than C.

f_setsockopt(v_socket_id, setsockopt_command)

where could be e.g.

for rfilter activation:
setsockopt_command := {rfilter:={c_rfilter0, c_rfilter1, c_rfilter2}}

with
const CAN_RAW_filter c_rfilter0 := {
     can_id := '00000123'O,
     can_mask := bit2oct(oct2bit(CAN_EFF_FLAG) or4b 
oct2bit(CAN_RTR_FLAG) or4b oct2bit(CAN_SFF_MASK))};
const CAN_RAW_filter c_rfilter1 := {
     can_id := '00000200'O,
     can_mask := '00000700'O};
const CAN_RAW_filter c_rfilter2 := {
     can_id := bit2oct(oct2bit('12345678'O) or4b oct2bit(CAN_EFF_FLAG))


for rfilter deactivation:
setsockopt_command := {rfilter:={}}

for join filter activation / deactivation:
setsockopt_command := {join_filters := Enable}
setsockopt_command := {join_filters := Disable}

for loopback activation / deactivation:
setsockopt_command := {loopback := Enable}
setsockopt_command := {loopback := Disable}

etc.

Thus all commands have a TTCN representation and are calling the 
corresponding Socket functions under the hood.

>>>> 10) SocketCAN-regression tests
>>>> Is there a need for a SocketCAN-regression test suite?
>>>
>>> This test has been contributed to the Linux Test Project (LTP):
>>> https://github.com/linux-can/can-tests/blob/master/test_netlayer.sh
>>>
>>> More regression tests are always welcome :-)
>>>
>> I had been thinking on building a test suite with the test cases in TTCN.
>> In fact I have already build a test suite with some test cases for my
>> purpose:
>>
>> Until now I have created the following tests:
>> <TTCN-testcase-filename>.<testcasename>
>> SocketCAN_RAW_test.tc_can_raw_send_and_receive_frame
>> SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_FILTER
>> SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_ERR_FILTER
>> SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_LOOPBACK
>> SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_RECV_OWN_MSGS
>> SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_FD_FRAMES
>> SocketCAN_RAW_test.tc_can_raw_setsockopt_CAN_RAW_JOIN_FILTERS
>>
>> //CAN BCM tests
>> SocketCAN_BCM_test.tc_can_bcm_TX_SETUP_TX_DELETE                 (lately
>> broken, crashes on some kernels, needs to be investigated)
> I'll take a look at this too.

   v_can_frame1 := {can_id := '00000001'O, can_pdu := '1111111111111111'O};
   v_can_frame2 := {can_id := '00000002'O, can_pdu := 
'2222222222222222'O};
   v_can_frame3 := {can_id := '00000003'O, can_pdu := '3333333333333333'O};
   v_can_frame4 := {can_id := '00000004'O, can_pdu := '4444444444444444'O};
   v_can_frame5 := {can_id := '00000005'O, can_pdu := '5555555555555555'O};

   template SocketCAN_CAN_or_CAN_FD_frames a_expected_can_frames := {
         {can_frame := v_can_frame1},
         {can_frame := v_can_frame2},
         {can_frame := v_can_frame3},
         {can_frame := v_can_frame4},
         {can_frame := v_can_frame5},
         {can_frame := v_can_frame1},
         {can_frame := v_can_frame2},
         {can_frame := v_can_frame3},
         {can_frame := v_can_frame4},
         {can_frame := v_can_frame5}
   }

   v_bcm_activation_frame := {
     opcode := '00000001'O, // TX_SETUP
     flags  := '00000000000000000000000000000011'B,  // refers to 
SETTIMER | STARTTIMER
     count  := 0,
     ival1  := {0, 0},
     ival2  := {0, 100000},
     can_id := '00000042'O,
     frames := {can_frame := {
         v_can_frame1,
         v_can_frame2,
         v_can_frame3,
         v_can_frame4,
         v_can_frame5}}
   }

   v_bcm_deactivation_frame := {
     opcode := '00000002'O, // TX_DELETE
     flags  := '00000000000000000000000000000000'B,
     count  := 0,
     ival1  := {0, 0},
     ival2  := {0, 0},
     can_id := '00000042'O,
     frames := {can_frame := {}}
   }

Currently the test case does roughly the following:
1. Sends above (hopefully self explanatory) TX_SETUP command using 
v_bcm_activation_frame
2. Opens a SocketCAN raw and waits for frame {can_frame := v_can_frame1}
3. Parallel to 2: Opens a SocketCAN raw and waits for the frame sequence 
a_expected_can_frames := {
         {can_frame := v_can_frame1},
         {can_frame := v_can_frame2},
         {can_frame := v_can_frame3},
         {can_frame := v_can_frame4},
         {can_frame := v_can_frame5},
         {can_frame := v_can_frame1},
         {can_frame := v_can_frame2},
         {can_frame := v_can_frame3},
         {can_frame := v_can_frame4},
         {can_frame := v_can_frame5}
4. Upon completion of 2. and 3. it sends TX_DELETE using 
v_bcm_deactivation_frame.

>> SocketCAN_BCM_test.tc_can_bcm_TX_SETUP_TX_DELETE_TX_READ__broken
>> (broken, handling of TX_READ unclear)
>
> dito.

Perhaps you have just to fix the parameters of the sent commands.

For regression tests it is useful to reset the BCM of an interface or 
all interfaces, before starting the next command.
Is there such a BCM reset command?

Best regards,
Michael
