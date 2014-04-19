From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Bitrate and CAN status support for slcan
Date: Sat, 19 Apr 2014 21:24:28 +0200
Message-ID: <5352CD6C.2090601@hartkopp.net>
References: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:55045 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbaDSTYb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 19 Apr 2014 15:24:31 -0400
In-Reply-To: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello Alexander,

IMO your entire patch set has a major design flaw.

The general serial line discipline concept is a data encapsulation driver
which converts PDUs into a serial line data stream.

If you check other implementations of serial line disciplines from

http://lxr.free-electrons.com/source/include/uapi/linux/tty.h

you'll see that their functionality is to encapsulate datagramms and/or
support different modes for this functionality on the serial line.

There's no interaction on the serial stream triggered by open/close of the
device - which additionally breaks the current userspace, which assumes to be
responsible for the ASCII open/close commands.

And when there are working queues that talk to the serial line, these are e.g.
for line fills to prevent tty hangups.

I don't know if the first CAN frame can get lost when slcand issues the open
command and then switches to the line discipline with the ioctl() ???

Therefore the idea to create the open/close commands in slcan.c *may* prevent
a race condition at startup. Do you know whether the received ASCII characters
remain queued when they are not read by slcand which controls the tty until
the line discipline is switched to slcan.c ??

When this is really needed to prevent this kind of startup glitch the
open/close commands need to be created by newly introduced ioctl() calls, so
that slcand can check if the (new) ioctl() exists to decide if it has to send
the ASCII 'open' command before the ldisc ioctl() OR send the 'open' ioctl()
after the ldisc ioctl().

Same problem with the status polling:
It introduces a functionality which has impacts to statistics depending on the
given poll rate. Are the values consumed with answer to the 'F' command or
does the next polled status represent the same status content?

You introduced an automatism which does not look reliable to me.

What about creating a 'F' command on the serial line when you send a CAN frame
with the CAN_ERR_FLAG set down to the slcan device?
The answer of the slcan device can then be converted to a CAN frame similar to
the way you suggested in patch 5.

Finally the bitrate setting approach is broken too:
1. it breaks the serial line discipline design again
2. there's obviously no race problem which is potentially solved
3. there's no bittiming_const which is needed to fill the bitrate via ip tool

Summary:

- Can you please double check if there's a change for a race condition in the
'open' command before the ldisc ioctl() which may? lead to drop the first CAN
frame? I assume there's no such problem as every other line discipline would
have a similar problem then. And if there's no race there's no need to put
open/close into the driver.

- Remove the bitrate setting stuff
- Don't make the slcan driver depend on the CAN_DEV stuff: It's just
encapsulation which is done in slcan.c - it's no really a CAN controller driver.

Sorry but finally only the 'on demand' retrieval of the SLCAN status via
CAN_ERR_FLAG set in a sent CAN frame looks like a potentially valuable
improvement to me.

Thanks for your contribution & best regards,
Oliver

On 15.04.2014 16:51, Alexander Stein wrote:
> This series adds bitrate selection support. It uses the API described
> in the SLCAN-API which is identical on all listed serial interfaces.
> Thus slcan only supports that limited set of bitrates, as only a bitrate
> index is sent over serial wire.
> Patch 5 also adds support for CAN status polling. This has do be done
> regulrarly from CPU side.
> Tests have been done on a LAWICEL CANUSB device.

