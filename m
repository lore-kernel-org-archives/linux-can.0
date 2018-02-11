From: Daniel Santos <daniel.santos@pobox.com>
Subject: Re: Framework for hardware filter support?
Date: Sun, 11 Feb 2018 16:33:43 -0600
Message-ID: <6c112388-5dcb-2dca-06c6-eac56d470fbb@pobox.com>
References: <98bcd448-4d2a-bf2f-ae5a-4db7f1eac896@pobox.com>
 <eabc4877-8f50-7246-32da-1f5bbb2e507e@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50158 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932168AbeBKWdh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Feb 2018 17:33:37 -0500
In-Reply-To: <eabc4877-8f50-7246-32da-1f5bbb2e507e@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can <linux-can@vger.kernel.org>

Thanks for your response Oliver!


On 02/11/2018 06:32 AM, Oliver Hartkopp wrote:
> Hello Daniel,
>
> On 02/11/2018 03:38 AM, Daniel Santos wrote:
>> Hello.=C2=A0 I'm doing a project where hardware filters will pretty mu=
ch be
>> required unless we change the hardware.=C2=A0 I can just hack up the m=
cp251x
>> driver and add some sysfs nodes to modify the filters, but it would be
>> much nicer to implement using some type of standard framework that I
>> could submit back upstream.
>
> Definitely a better approach :-)

Well I'm on the clock for this functionality, so I've added a sysfs
interface to do this.=C2=A0 If it's too ugly for upstream, then I'll have=
 to
have my client post the sources somewhere. :-)=C2=A0 I'm not sure they'll=
 be
interested in paying me to make this pretty, lol!

>> My current project uses an MCP2515 (with only two rx buffers) connecte=
d
>> via an MCP2210 USB-to-SPI bridge and that introduces a lot of latency
>> and interrupts may not be serviced for as much as 20-30 ms and w/o
>> hardware filters, we'll be missing a lot of messages we want to sniff.
>>
>> I've read some of the arguments against it, such is it being a
>> multi-user environment.=C2=A0 To me that just means that hardware filt=
ers
>> should be configured at the interface level and not at the socket leve=
l.
>
> Correct for your use-case.
>
> As you already pointed out in the user in a multi-user environment
> expects to be able to access the entire CAN traffic on that bus.
>
> You want to reduce bandwidth and system load on the path from the
> controller into the system to cope with hardware limitations.
>
> IMO this can be a valid requirement BUT we always have to keep in mind
> that the filters on that (CAN controller) level affect all users.

So I haven't dug into SocketCAN yet -- that part of my project is next,
but my first thought was that this layer could allow the user to know
what hardware filters are in place (that they cannot change).=C2=A0 So th=
at
the interface would have both its current configurable software filters
in addition to read-only hardware filters.=C2=A0 That could feasibly save
programmers some headaches down the road.

>> So is there no such framework already in place?=C2=A0 If not, where wo=
uld be
>> the most logical place to add it? netfilter in the kernel and iproute2
>> in userland?
>
> A hardware filter support needs to be placed in hardware ;-)
>
> The netfilter stuff comes into action when the network packets are
> already processed inside the network layer - so it's too late.

Oh yeah, I forgot about that! :) I used a lot of netfilter long ago when
I had to host a server for something.

> I would suggest to create an add-on to the existing netlink
> configuration interface for CAN controllers (the iproute2 stuff).
>
> The question is, how to build a common configuration interface for CAN
> hardware filters that fits the design of the CAN controllers hardware
> filters?!?

Yes, I've thought about this.=C2=A0 I will have to study the hardware
filtering mechanisms of a number of CAN controllers to design anything sa=
ne.

> Would it make sense to implement a similar interface like CAN_RAW filte=
rs
>
> http://elixir.free-electrons.com/linux/v4.15.2/source/Documentation/net=
working/can.txt#L446
>
>
> for the configuration of hardware filters?
>
> E.g. the SJA1000 controller only has exactly ONE of these filters
>
> http://elixir.free-electrons.com/linux/v4.15.2/source/drivers/net/can/s=
ja1000/sja1000.c#L190
>
>
> where the CAN_RAW filter design would easily fit.

This is what I mean by a framework.=C2=A0 So the driver should inform the
core CAN driver what it's filtering capabilities are -- again, I would
have to study a number of devices to design this sanely.=C2=A0 It would s=
eem
that iproute2 would be the best userland mechanism to specify them, and
it could pass an array of struct can_filter objects.=C2=A0 Then based upo=
n
the hardware, it can apply or reject them.=C2=A0 It would also be nice fo=
r
iproute2 to query the driver and be able to report those capabilities.

> E.g. the MCP2515 filters look a bit different on page 33:
> http://ww1.microchip.com/downloads/en/DeviceDoc/21801e.pdf

Yes, this is a good example of an oddity.=C2=A0 It has two rx buffers, th=
e
first of higher priority.=C2=A0 RXB0 can optionally use a single mask and=
 two
filters, RXB1 can use a single mask and 4 filters.=C2=A0 RXB0 can also be
configured so that if it matches a message when it already has one (that
the MCU hasn't retrieved yet), it rolls it over to RXB1, even
overwriting any message that was matched from RXB1's own filters.

That's not very straight-forward, but aside from clarifying rather or
not to rollover, an array of 1-6 struct can_filter objects can be used.=C2=
=A0
If the first two masks are the same, it can use the common mask and two
filters for RXB0, then if the remaining 4 masks are the same, then it
can similarly init the RXB1 filters.=C2=A0 What I need to learn is just h=
ow
diverse this is in the hardware that's out there.

In the mcp251x driver's current state, it always enables this rollover
because without using filters, it means it can rx two messages before
overflowing.

> but the CAN_RAW filter set idea seems to be applicable too.
>
> Would this approach match your requirements?

I think we're getting close.=C2=A0 I certainly understand the situation m=
uch
better now.=C2=A0 I suppose I'll just have to come up with something and
propose it.

> Best regards,
> Oliver
>

Thanks!
Daniel
