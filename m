From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: j1939: Attempt to make j1939 network namespace-aware
Date: Thu, 8 Feb 2018 22:13:25 +0100
Message-ID: <6972f543-2bfe-e082-a82e-8e66f64a361d@hartkopp.net>
References: <CAHChkrvE+uczdhu66snkAt8p2AfgM=sKraaxFJTRDCSXjdS24g@mail.gmail.com>
 <480B3397-A3D5-4B24-901A-AA9C23DC43C1@vandijck-laurijssen.be>
 <CAHChkrtVGAUG=xwcD6c3YLZ8kvGi9EoucbtvY4H2_GU=i8Q7wg@mail.gmail.com>
 <b42195d6-7d59-edce-1eef-0e3d272e5495@hartkopp.net>
 <20180206201650.GD1198@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:26866 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBHVNl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Feb 2018 16:13:41 -0500
In-Reply-To: <20180206201650.GD1198@airbook.vandijck-laurijssen.be>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org

Hi Kurt,

On 02/06/2018 09:16 PM, Kurt Van Dijck wrote:

> So absolutely nothing is/should be shared between the namespaces
> from the userspace point of view?

The network interfaces and the created sockets are only working and 
visible in one specific namespace.
Before making the CAN subsystem namespace aware, it was only able to 
work in the root aka init namespace.

When you have a single vcan0 in a namespace the application that 
executes inside this namespace can only see this single interface.

> So the ideal j1939 implementation that shares nothing between
> interfaces only needs to forward an extra namespace parameter?

Yes. Each interface has a namespace and an ifindex. And each socket has 
a namespace.

All relevant data structures need to be per-namespace.
The initial namespace support from Mario gives an idea about the changes 
for the CAN subsystem (and CAN RAW):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/net/can?id=8e8cda6d737d356054c9eeef642aec0e8ae7e6bc

> How about ... /proc parameters?

per-namespace:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/net/can?id=cb5635a3677679666e4e81ecbb209d32f13dedcd

> or Module parameters?

Hm - we only have module_param(stats_timer, int, S_IRUGO) in af_can.c

This is just one module parameter for the module - which is not 
application relevant (like addressing or filters).

> or is that the main argument against them?

Don't know. I think netlink and sockopts should cover most of the 
configuration stuff. procfs and sysfs need to be namespace aware.

> Can different namespaces re-use interface numbers (ifindex)?

As written above every interface has a namespace and an ifindex.
So you may have the same ifindex value in different namespaces.

Best,
Oliver

