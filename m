From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2019-09-03,pull-request: can-next
 2019-09-03
Date: Thu, 05 Sep 2019 00:57:51 -0700 (PDT)
Message-ID: <20190905.005751.1798664766004500473.davem@davemloft.net>
References: <a6751a50-f15d-612d-783b-a706098ea90e@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <a6751a50-f15d-612d-783b-a706098ea90e@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 3 Sep 2019 11:46:31 +0200

> this is a pull request for net-next/master consisting of 15 patches.
> 
> The first patch is by Christer Beskow, targets the kvaser_pciefd driver
> and fixes the PWM generator's frequency.
> 
> The next three patches are by Dan Murphy, the tcan4x5x is updated to use
> a proper interrupts/interrupt-parent DT binding to specify the devices
> IRQ line. Further the unneeded wake ups of the device is removed from
> the driver.
> 
> A patch by me for the mcp25xx driver removes the deprecated board file
> setup example. Three patches by Andy Shevchenko simplify clock handling,
> update the driver from OF to device property API and simplify the
> mcp251x_can_suspend() function.
> 
> The remaining 7 patches are by me and clean up checkpatch warnings in
> the generic CAN device infrastructure.

Pulled, thanks.
