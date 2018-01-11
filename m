From: Dmitry Vyukov <dvyukov@google.com>
Subject: syzkaller support for AF_CAN
Date: Thu, 11 Jan 2018 09:15:22 +0100
Message-ID: <CACT4Y+avEXjEGDEdtnmV3sS=Y463x03PN0RHXeKTtPZkZThSGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:38555 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753660AbeAKIPo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Jan 2018 03:15:44 -0500
Received: by mail-pf0-f171.google.com with SMTP id k19so1120765pfj.5
        for <linux-can@vger.kernel.org>; Thu, 11 Jan 2018 00:15:43 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: syzkaller <syzkaller@googlegroups.com>, mkl@pengutronix.de, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, Jan 10, 2018 at 8:35 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Dmitry,
>
> I'm the maintainer of the CAN bus networking subsystem in linux/net/can/ and
> I'm following the interesting bugs the syzkaller is posting on netdev
> mailing list.
>
> We already had a CAN issue here:
> https://groups.google.com/forum/#!topic/syzkaller/to2Or4lUrTU
>
> But now CONFIG_CAN seems to be disabled in the recent posts.
> I would be happy if you could also enable CONFIG_CAN and the network layer
> stuff below (RAW/BCM/GW) to see, if it explodes ;-)
>
> No idea whether it makes sense to create virtual CAN interfaces with the
> vcan driver or if it's just enough to enable the CAN network layer?!?

+mailing lists

Hi Oliver,

Sure, we can enable CAN configs if there is active interest in fixing
bugs in this subsystem.
Please provide full set of configs. Is CONFIG_CAN the only one? What
is RAW/BCM/GW?

While you are here I have a counter ask. syzkaller is magic, but not
completely. It needs help to test particular subsystems in 2 ways:
1. It needs descriptions of user<->kernel interfaces to meaningfully
test a subsystem. For example, you can see what we have for SCTP:
https://github.com/google/syzkaller/blob/master/sys/linux/socket_inet_sctp.txt
and generally *.txt files here:
https://github.com/google/syzkaller/tree/master/sys/linux

I see that for AF_CAN we have only
syzkaller$ grep "AF_CAN" sys/linux/*.txt
sys/linux/socket.txt:# TODO: AF_CAN
sys/linux/socket.txt:# TODO: AF_CAN

So I guess it was mostly just able to create an AF_CAN socket, but
wasn't able to progress further. Adding proper descriptions can make
difference between few bugs (I see 4 for net/can here
https://github.com/google/syzkaller/blob/master/docs/linux/found_bugs.md)
and several dozens (yes, that happened with ALSA, AF_KEY and some
other subsystems).

But writing these descriptions requires subsystem expertise, and we
don't have expertise in just any kernel subsystem. You (maintainer of
a particular subsystem) is in the best position to do this. If you add
them to syzkaller, they will be automatically picked up by syzbot.

2. Some subsystems require expertise beyond plain interfaces (e.g.
cgroups, kvm). You are mentioning "virtual CAN interfaces", "vcan
driver", but this says nothing to me. What are these? If proper
testing of this subsystem requires these things, then we need to
ensure that syzkaller is capable of creating them on the fly, or
somehow arrange precreated things. syzkaller also requires as much
isolation between test programs as possible (in particular to be able
to create reproducers). Is creation of virtual CAN interfaces per
test-process feasible/meaningful?

Thanks
