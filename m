From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 19:52:26 +0800
Message-ID: <20120628115224.GF22990@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <4FEC329C.7070004@pengutronix.de>
 <20120628112111.GC22990@S2101-09.ap.freescale.net>
 <4FEC400F.8010506@pengutronix.de>
 <20120628114108.GD22990@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:49133
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752343Ab2F1LwJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 07:52:09 -0400
Content-Disposition: inline
In-Reply-To: <20120628114108.GD22990@S2101-09.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Thu, Jun 28, 2012 at 07:41:10PM +0800, Shawn Guo wrote:
> On Thu, Jun 28, 2012 at 01:29:19PM +0200, Marc Kleine-Budde wrote:
> > I mean which name is more precise, do these gpio enable/standy a "phy"
> > or a "transceiver". For example:
> > http://www.nxp.com/documents/application_note/AN00094.pdf, this document
> > says: TJA1041/1041A high speed CAN transceiver.
> > 
> Isn't term "phy" (physical interface) generally meant to be the same
> thing as "transceiver"?  I just happened to like the shorter one as
> what Hui did in his patch.
> 
> But it does not really matter to me, will change the name since you
> care about it.
> 
Do you care the variable name also?  If so, we will get:

        int transceiver_en_gpio;
        int transceiver_stby_gpio;
        bool transceiver_en_high;
        bool transceiver_stby_high;

So everything becomes long :)

-- 
Regards,
Shawn

