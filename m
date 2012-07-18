From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add 2nd clock to support imx53 and newer
Date: Wed, 18 Jul 2012 10:49:44 +0200
Message-ID: <20120718084944.GD30009@pengutronix.de>
References: <1342562748-24701-1-git-send-email-mkl@pengutronix.de>
 <50061B86.7080200@gmail.com>
 <500675C2.9090303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55996 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab2GRIuV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 04:50:21 -0400
Content-Disposition: inline
In-Reply-To: <500675C2.9090303@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, linux-can@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

On Wed, Jul 18, 2012 at 10:37:22AM +0200, Marc Kleine-Budde wrote:
> 
> Yes, good catch.
> 
> Is it allowed to call clk_put with a NULL pointer?

As NULL is a valid clock by definition it is allowed to do this.
However, calling clk_put with a NULL pointer when a corresponding
call to clk_get never returned NULL is probably not a good idea.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
