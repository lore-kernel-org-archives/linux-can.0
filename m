From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: "Blessed" Version
Date: Sat, 13 Oct 2012 12:17:17 +0200
Message-ID: <50793FAD.6030704@hartkopp.net>
References: <5074B274.7070703@sunverge.com> <507554BB.4000809@grandegger.com> <5077196C.60405@sunverge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:28700 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2JMKRS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 13 Oct 2012 06:17:18 -0400
In-Reply-To: <5077196C.60405@sunverge.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stuart Statman <sstatman@sunverge.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

Hello Stuart,

On 11.10.2012 21:09, Stuart Statman wrote:

> Strangely enough, just yesterday we made a decision to migrate CAN hardware
> that reduced the urgency of my question.
> 
> However, it does bring up another question.
> 
> I've been using slcand and "ip link set xxx up" for a piece of hardware that
> uses the slcan protocol. I'm pretty happy with how it's working, but I'd be
> happier if it was compatible with the can_if script that's in the utilities. I
> could write my own version of can_if that just does the right things for
> slcan, but it does open up a few questions :
> 
> 1. What is slcan anyway, and why is it not handled like the other drivers?


The SLCAN driver adds the support for (usually low cost) simple CAN interfaces
that transfer the CAN frames via some ASCII based protocol.

As these interfaces are attached via the serial line (RS232 or USB/serial) the
slcan driver implements a 'serial line discipline' as you might know from
early internet times where you used a modem to connect the internet.

In that modem case IP network packets have been transmitted through the serial
line, after the modem has been set up and connected (-> ppp daemon).
Once switching the 'line discipline' IP packets are tranferred via serial.

Same here with SLCAN:

First the SLCAN adapter needs to be configured (speed 'S') and opened 'O' and
then the line discipline is switched to transfer CAN frames with the ASCII
protocol (slcan_attach, slcand).

As this is a completely different CAN adapter configuration interface the
CAN-DEV framework therefore can not be used and the 'ip link set' stuff does
not work for SLCAN devices.

> 2. Is there a can_if style script that already handles slcan?


We have extended the can_if script for slcan at Volkswagen and also extended
the slcand to do some of the setup from slcan_attach (e.g. for the CAN
bitrate). I don't know the exact state of these extensions and if it works
stable in all environments (udev, ...). But if you like, i can sent it to you
and you may check if it fit's your needs and if it's worth to merge it with
the can-utils.

Regards,
Oliver
