From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: upcoming pull reqeust
Date: Sat, 19 Jan 2013 14:34:07 +0100
Message-ID: <50FAA0CF.8000007@hartkopp.net>
References: <50F5C2EA.8030304@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:55692 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab3ASNeK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 19 Jan 2013 08:34:10 -0500
In-Reply-To: <50F5C2EA.8030304@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Can you add my patchset

"CAN sk_buff and can-gw enhancements"

and Bernds

"[PATCH v11] usb_8dev: Add support for USB2CAN interface from 8 devices"

and the omitted LED support for the usb_8dev driver from Fabio too?

Regards,
Oliver

On 15.01.2013 21:58, Marc Kleine-Budde wrote:

> Hello,
> 
> I'm going to send a pull request to David this week, it will include:
> the LED trigger patches by Fabio and Kurt and my Kconfig cleanup. The
> usb8-dev driver has some problems with unplug under heavy load, so it
> will not be included.
> 
> The patches are in the for-davem branch in the linux-can-next repo at
> gitorious:
> 
> https://gitorious.org/linux-can/linux-can-next/commits/for-davem
> 
> The shortlog is:
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
>  drivers/net/can/Kconfig           |   37 +++++++----
>  drivers/net/can/Makefile          |    2 +
>  drivers/net/can/at91_can.c        |   10 +++
>  drivers/net/can/c_can/Kconfig     |    2 +-
>  drivers/net/can/c_can/c_can.c     |   10 +++
>  drivers/net/can/cc770/Kconfig     |    2 +-
>  drivers/net/can/dev.c             |   18 ++++++
>  drivers/net/can/flexcan.c         |   11 ++++
>  drivers/net/can/led.c             |  129 +++++++++++++++++++++++++++++++++++++
>  drivers/net/can/mcp251x.c         |   23 +++++--
>  drivers/net/can/mscan/Kconfig     |    2 +-
>  drivers/net/can/sja1000/Kconfig   |   14 ++--
>  drivers/net/can/sja1000/sja1000.c |   17 ++++-
>  drivers/net/can/softing/Kconfig   |    2 +-
>  drivers/net/can/ti_hecc.c         |   10 +++
>  drivers/net/can/usb/Kconfig       |    2 +-
>  include/linux/can/dev.h           |   11 ++++
>  include/linux/can/led.h           |   51 +++++++++++++++
>  net/can/Kconfig                   |   13 ++--
>  19 files changed, 329 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/net/can/led.c
>  create mode 100644 include/linux/can/led.h
> 
> Comments, any missing patches or {Reviewed,Acked,Tested}-by?
> 
> regards,
> Marc
> 


