From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: upcoming pull reqeust
Date: Fri, 25 Jan 2013 16:55:03 +0100
Message-ID: <5102AAD7.3040403@hartkopp.net>
References: <50F5C2EA.8030304@pengutronix.de> <50FAA0CF.8000007@hartkopp.net> <50FF0C9C.3030207@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:65059 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755747Ab3AYPzG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jan 2013 10:55:06 -0500
In-Reply-To: <50FF0C9C.3030207@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 22.01.2013 23:03, Marc Kleine-Budde wrote:


> The patches are in the for-davem branch in the linux-can-next repo at
> gitorious:
> 
> https://gitorious.org/linux-can/linux-can-next/commits/for-davem
> 
> Bernd Krumboeck (2):
>       can: usb_8dev: Add support for USB2CAN interface from 8 devices
>       can: usb_8dev: add LED trigger support
> 
> Fabio Baltieri (7):
>       can: add tx/rx LED trigger support
>       can: flexcan: add LED trigger support
>       can: at91_can: add LED trigger support
>       can: ti_hecc: add LED trigger support
>       can: c_can: add LED trigger support
>       can: mcp251x: add LED trigger support
>       can: sja1000: add LED trigger support
> 
> Kurt Van Dijck (2):
>       can: export a safe netdev_priv wrapper for candev
>       can: rename LED trigger name on netdev renames
> 
> Marc Kleine-Budde (4):
>       can: Kconfig: convert 'depends on CAN' into 'if CAN...endif' block
>       can: Kconfig: convert 'depends on CAN_DEV' into 'if CAN_DEV...endif' block
>       can: Kconfig: switch on all CAN protocolls by default
>       can: sja1000: correct indention of Kconfig help text
> 
> Oliver Hartkopp (4):
>       can: add private data space for CAN sk_buffs
>       can: gw: make routing to the incoming CAN interface configurable
>       can: gw: add a variable limit for CAN frame routings
>       can: gw: indicate and count deleted frames due to misconfiguration
> 

> 
> Comments?
> 


What's you plan when to send the pull request to Dave?

Btw. have you seen the 3 c_can fixes from Olivier Sobrie for the net/stable
tree from 2013-01-18? They all look correct.

Regards,
Oliver
