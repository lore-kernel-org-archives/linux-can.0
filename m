From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2016-06-17,pull-request: can-next
 2016-06-17
Date: Fri, 17 Jun 2016 22:22:54 -0700 (PDT)
Message-ID: <20160617.222254.1310334864131214346.davem@davemloft.net>
References: <7075a8b3-562d-3de2-80f7-b593c665adef@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:57120 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbcFRFWz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 18 Jun 2016 01:22:55 -0400
In-Reply-To: <7075a8b3-562d-3de2-80f7-b593c665adef@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 17 Jun 2016 16:31:46 +0200

> this is a pull request of 14 patches for net-next/master.
> 
> Geert Uytterhoeven contributes a patch that adds a file patterns for
> CAN device tree bindings to MAINTAINERS. A patch by Alexander Aring
> fixes warnings when building without proc support. A patch by me 
> improves the sample point calculation. Marek Vasut's patch converts
> the slcan driver to use CAN_MTU. A patch by William Breathitt Gray
> converts the tscan1 driver to use module_isa_driver.
> 
> Two patches by Maximilian Schneider for the gs_usb driver fix coding
> style and add support for set_phys_id callback. 5 patches by Oliver
> Hartkopp add support for CANFD to the bcm. And finally two patches
> by Ramesh Shanmugasundaram, which add support for the rcar_canfd
> driver.

Pulled, thanks Marc.
