From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/3] ARM: imx: flexcan: convert transceiver switching to
 DT
Date: Thu, 27 Jun 2013 21:11:19 +0800
Message-ID: <20130627131117.GB2695@S2101-09.ap.freescale.net>
References: <1372317731-24966-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:51115
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752882Ab3F0NLa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Jun 2013 09:11:30 -0400
Content-Disposition: inline
In-Reply-To: <1372317731-24966-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>

On Thu, Jun 27, 2013 at 09:22:08AM +0200, Marc Kleine-Budde wrote:
> Hello,
> 
> this series converts the flexcan driver from using a callback function
> (configured via platform data), to switch the transceiver on and off, to a
> standard regulator. As there are no in-tree users of the platform data, it's
> finally removed.
> 
> If there are no objections I'd like to upstream this via can-next and David
> Miller's net-next. As these patches are touching arch/arm/mach-imx, I don't
> want to continue without some Acked-bys.
 
For the series,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

