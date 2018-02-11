From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Framework for hardware filter support?
Date: Sun, 11 Feb 2018 13:32:28 +0100
Message-ID: <eabc4877-8f50-7246-32da-1f5bbb2e507e@hartkopp.net>
References: <98bcd448-4d2a-bf2f-ae5a-4db7f1eac896@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:36122 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752691AbeBKMcf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Feb 2018 07:32:35 -0500
In-Reply-To: <98bcd448-4d2a-bf2f-ae5a-4db7f1eac896@pobox.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniel Santos <daniel.santos@pobox.com>
Cc: linux-can <linux-can@vger.kernel.org>

Hello Daniel,

On 02/11/2018 03:38 AM, Daniel Santos wrote:
> Hello.  I'm doing a project where hardware filters will pretty much be
> required unless we change the hardware.  I can just hack up the mcp251x
> driver and add some sysfs nodes to modify the filters, but it would be
> much nicer to implement using some type of standard framework that I
> could submit back upstream.

Definitely a better approach :-)

> My current project uses an MCP2515 (with only two rx buffers) connected
> via an MCP2210 USB-to-SPI bridge and that introduces a lot of latency
> and interrupts may not be serviced for as much as 20-30 ms and w/o
> hardware filters, we'll be missing a lot of messages we want to sniff.
> 
> I've read some of the arguments against it, such is it being a
> multi-user environment.  To me that just means that hardware filters
> should be configured at the interface level and not at the socket level.

Correct for your use-case.

As you already pointed out in the user in a multi-user environment 
expects to be able to access the entire CAN traffic on that bus.

You want to reduce bandwidth and system load on the path from the 
controller into the system to cope with hardware limitations.

IMO this can be a valid requirement BUT we always have to keep in mind 
that the filters on that (CAN controller) level affect all users.

> So is there no such framework already in place?  If not, where would be
> the most logical place to add it? netfilter in the kernel and iproute2
> in userland?

A hardware filter support needs to be placed in hardware ;-)

The netfilter stuff comes into action when the network packets are 
already processed inside the network layer - so it's too late.

I would suggest to create an add-on to the existing netlink 
configuration interface for CAN controllers (the iproute2 stuff).

The question is, how to build a common configuration interface for CAN 
hardware filters that fits the design of the CAN controllers hardware 
filters?!?

Would it make sense to implement a similar interface like CAN_RAW filters

http://elixir.free-electrons.com/linux/v4.15.2/source/Documentation/networking/can.txt#L446

for the configuration of hardware filters?

E.g. the SJA1000 controller only has exactly ONE of these filters

http://elixir.free-electrons.com/linux/v4.15.2/source/drivers/net/can/sja1000/sja1000.c#L190

where the CAN_RAW filter design would easily fit.

E.g. the MCP2515 filters look a bit different on page 33:
http://ww1.microchip.com/downloads/en/DeviceDoc/21801e.pdf

but the CAN_RAW filter set idea seems to be applicable too.

Would this approach match your requirements?

Best regards,
Oliver
