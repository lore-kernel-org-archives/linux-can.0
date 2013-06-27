From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/3] ARM: imx: prepare for removal of
 flexcan_platform_data
Date: Thu, 27 Jun 2013 10:41:10 +0200
Message-ID: <20130627084110.GE516@pengutronix.de>
References: <1372317731-24966-1-git-send-email-mkl@pengutronix.de>
 <1372317731-24966-2-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55769 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3F0IlM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Jun 2013 04:41:12 -0400
Content-Disposition: inline
In-Reply-To: <1372317731-24966-2-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>

On Thu, Jun 27, 2013 at 09:22:09AM +0200, Marc Kleine-Budde wrote:
> As there are no imx in-tree users of flexcan_platform_data, this patch removes
> the possibility to register a flexcan device with platform data.
> 
> The functionality to swith on/off CAN transceivers is added to DT via
> regulators on a later patch.
> 
> Compile time tested with imx_v4_v5_defconfig and imx_v6_v7_defconfig.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

I like to see platform stuff go away ;)

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
