From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: About sysfs usage by socket-can drivers
Date: Fri, 24 Jul 2020 11:45:02 +0200
Message-ID: <20200724094502.GB27720@x1.vandijck-laurijssen.be>
References: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:48485 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXJph (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Jul 2020 05:45:37 -0400
Content-Disposition: inline
In-Reply-To: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> We've several pending requests regarding:
> - changing the default clock value,
> - reading the bus load value,
> - using a flashed device id. to better control the can interface number,
> - identifying the (USB) channel
> - ...

I tend to look in the (in your case) usb device, and add properties there.
After all, those are device-related properties, not?

You could reach them via /sys/class/net/canX/device/...

If you add them before the netdev is registered, you can use them in
udev rules without race conditions.

Kurt
