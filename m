From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: Bitrate and CAN status support for slcan
Date: Tue, 22 Apr 2014 09:08:59 +0200
Message-ID: <18170537.PzX3L82o9E@ws-stein>
References: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com> <5352CD6C.2090601@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:39010 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754937AbaDVHKN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Apr 2014 03:10:13 -0400
In-Reply-To: <5352CD6C.2090601@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hello Oliver,

On Saturday 19 April 2014 21:24:28, Oliver Hartkopp wrote:
> IMO your entire patch set has a major design flaw.
> 
> The general serial line discipline concept is a data encapsulation driver
> which converts PDUs into a serial line data stream.
> 
> If you check other implementations of serial line disciplines from
> 
> http://lxr.free-electrons.com/source/include/uapi/linux/tty.h
> 
> you'll see that their functionality is to encapsulate datagramms and/or
> support different modes for this functionality on the serial line.
> 
> There's no interaction on the serial stream triggered by open/close of the
> device - which additionally breaks the current userspace, which assumes to 
be
> responsible for the ASCII open/close commands.

I'm aware that this change behavior is different than before, which is
intended! The current problem we have is that there is no way changing
the bitrate and get CAN status information using the interface you use with
"normal" CAN drivers, e.g. c_can. The whole patch series is intended to make
them behave more similar.

> And when there are working queues that talk to the serial line, these are 
e.g.
> for line fills to prevent tty hangups.
> 
> I don't know if the first CAN frame can get lost when slcand issues the open
> command and then switches to the line discipline with the ioctl() ???
> 
> Therefore the idea to create the open/close commands in slcan.c *may* 
prevent
> a race condition at startup. Do you know whether the received ASCII 
characters
> remain queued when they are not read by slcand which controls the tty until
> the line discipline is switched to slcan.c ??
> 
> When this is really needed to prevent this kind of startup glitch the
> open/close commands need to be created by newly introduced ioctl() calls, so
> that slcand can check if the (new) ioctl() exists to decide if it has to 
send
> the ASCII 'open' command before the ldisc ioctl() OR send the 'open' ioctl()
> after the ldisc ioctl().

The problem here is the bitrate setting using netlink. If the device is
already started because some external userspace application send the 
approriate command no bitrate change can be done, even before the CAN 
interface itself has started!
In order to let slcan change the bitrate it must be ensured where serial CAN
interface is shutdown before and start when the CAN interface is put 'UP'.

> Same problem with the status polling:
> It introduces a functionality which has impacts to statistics depending on 
the
> given poll rate. Are the values consumed with answer to the 'F' command or
> does the next polled status represent the same status content?

AFAIK the represent the current state, so polling them faster without an 
actual state change returns the same as when polling slower.

> You introduced an automatism which does not look reliable to me.
> 
> What about creating a 'F' command on the serial line when you send a CAN 
frame
> with the CAN_ERR_FLAG set down to the slcan device?
> The answer of the slcan device can then be converted to a CAN frame similar 
to
> the way you suggested in patch 5.

Mh, this could be an additional feature, e.g. when polling is disabled (value 
of 0?). But I think the polling should stay, otherwise userspace needs 
additional handling of this special CAN interface compared to others.
IMHO they all should behave as similar as possible.

> Finally the bitrate setting approach is broken too:
> 1. it breaks the serial line discipline design again

My experience to serial line disciplines is next to nothing. Maybe you can 
elaborate why this breaks its design. Or give link me to some description.

> 2. there's obviously no race problem which is potentially solved

If the slcand is killed the serial CAN interface is still up, so when 
restarted the bitrate cannot be changed using netlink. The interface must be 
shutdown first. Putting up and down is now done in slcan itself to fulfill 
this requirement.

> 3. there's no bittiming_const which is needed to fill the bitrate via ip 
tool

Actually the birate can be set using the ip tool. It's what I've done all the 
time. I checked the sources and every usage of bittiming_const seems pure 
optional. Even for copying from/to kernel over netlink.
Well, in the end I don't know bittiming_const is for, I couldn't figure out 
:-/
slcan is special here, there is ne noeed for some tseg1_min, etc. Here just 
the plain bitrate is put over serial line.

> Summary:
> 
> - Can you please double check if there's a change for a race condition in 
the
> 'open' command before the ldisc ioctl() which may? lead to drop the first 
CAN
> frame? I assume there's no such problem as every other line discipline would
> have a similar problem then. And if there's no race there's no need to put
> open/close into the driver.

open/close is put into the driver in order to be able to change bitrate from 
within that driver.

> - Remove the bitrate setting stuff

Well, this is actually one feature (flags are the others) the whole thing was 
done: Change bitrate and handle CAN errors like when using other CAN 
interfaces.

> - Don't make the slcan driver depend on the CAN_DEV stuff: It's just
> encapsulation which is done in slcan.c - it's no really a CAN controller 
driver.

Which makes it much more circumstantial to use, because it relies on different 
userspace handling.

> Sorry but finally only the 'on demand' retrieval of the SLCAN status via
> CAN_ERR_FLAG set in a sent CAN frame looks like a potentially valuable
> improvement to me.

Don't forget patch 1 ;-)
But thanks for the input anyway.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

