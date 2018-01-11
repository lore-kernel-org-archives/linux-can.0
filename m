From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: syzkaller support for AF_CAN
Date: Thu, 11 Jan 2018 19:30:59 +0100
Message-ID: <58697f8b-7a87-a549-a79a-f8f03fd1c0cf@hartkopp.net>
References: <CACT4Y+avEXjEGDEdtnmV3sS=Y463x03PN0RHXeKTtPZkZThSGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:12308 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965212AbeAKSbI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Jan 2018 13:31:08 -0500
In-Reply-To: <CACT4Y+avEXjEGDEdtnmV3sS=Y463x03PN0RHXeKTtPZkZThSGA@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzkaller <syzkaller@googlegroups.com>, mkl@pengutronix.de, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Dmitry,

On 01/11/2018 09:15 AM, Dmitry Vyukov wrote:
> On Wed, Jan 10, 2018 at 8:35 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>> I would be happy if you could also enable CONFIG_CAN and the network layer
>> stuff below (RAW/BCM/GW) to see, if it explodes ;-)

> Sure, we can enable CAN configs if there is active interest in fixing
> bugs in this subsystem.
> Please provide full set of configs. Is CONFIG_CAN the only one? What
> is RAW/BCM/GW?

CONFIG_CAN enables the selection of CONFIG_CAN_RAW, CONFIG_CAN_BCM and 
CONFIG_CAN_GW which all should be enabled for testing.

Additionally CONFIG_CAN allows to select CAN network drivers (like the 
virtual CAN driver vcan).

I prepared some slides for a talk at an AGL F2F in 2017 
(https://wiki.automotivelinux.org/agl-distro/apr2017-f2f), if you are 
interested to get a brief overview of CAN in Linux:
https://wiki.automotivelinux.org/_media/agl-distro/agl2017-socketcan-print.pdf

> While you are here I have a counter ask. syzkaller is magic, but not
> completely. It needs help to test particular subsystems in 2 ways:
> 1. It needs descriptions of user<->kernel interfaces to meaningfully
> test a subsystem. For example, you can see what we have for SCTP:
> https://github.com/google/syzkaller/blob/master/sys/linux/socket_inet_sctp.txt

Oh - interesting to see, that sockopts can be tested too :-)

> and generally *.txt files here:
> https://github.com/google/syzkaller/tree/master/sys/linux
> 
> I see that for AF_CAN we have only
> syzkaller$ grep "AF_CAN" sys/linux/*.txt
> sys/linux/socket.txt:# TODO: AF_CAN
> sys/linux/socket.txt:# TODO: AF_CAN
> 
> So I guess it was mostly just able to create an AF_CAN socket, but
> wasn't able to progress further. Adding proper descriptions can make
> difference between few bugs (I see 4 for net/can here
> https://github.com/google/syzkaller/blob/master/docs/linux/found_bugs.md)
> and several dozens (yes, that happened with ALSA, AF_KEY and some
> other subsystems).
> 
> But writing these descriptions requires subsystem expertise, and we
> don't have expertise in just any kernel subsystem. You (maintainer of
> a particular subsystem) is in the best position to do this. If you add
> them to syzkaller, they will be automatically picked up by syzbot.

Sounds like a plan for the weekend ;-)

> 2. Some subsystems require expertise beyond plain interfaces (e.g.
> cgroups, kvm). You are mentioning "virtual CAN interfaces", "vcan
> driver", but this says nothing to me. What are these?

See slide 16 of above PDF.
vcan's are just some local loopbacks for testing.
The addressing in CAN is about "CAN Identifier on a specific CAN bus" so 
you would need a virtual CAN bus to succeed e.g. with 'bind'.

> If proper
> testing of this subsystem requires these things, then we need to
> ensure that syzkaller is capable of creating them on the fly, or
> somehow arrange precreated things. syzkaller also requires as much
> isolation between test programs as possible (in particular to be able
> to create reproducers). Is creation of virtual CAN interfaces per
> test-process feasible/meaningful?

I think so. Creating a vcan with a specific name is easy:

$ ip link add dev vcan42 type vcan
$ ip link set vcan42 up

and when we need per-process vcan's we can name them uniquely.
To test the CAN_GW we would need two vcan interfaces to configure and 
test meaningful setups.

I'll definitely take a look at your suggestions!

Tnx & best regards,
Oliver
