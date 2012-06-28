From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 19:21:14 +0800
Message-ID: <20120628112111.GC22990@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <4FEC329C.7070004@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:38770 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753706Ab2F1LU5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 07:20:57 -0400
Content-Disposition: inline
In-Reply-To: <4FEC329C.7070004@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 28, 2012 at 12:31:56PM +0200, Marc Kleine-Budde wrote:
> Hmm I'm wondering if transceiver or phy is the correct name here. In
> platform_data it's called transceiver_switch.

The transceiver_switch in platform_data names a function, while we are
naming a couple gpios which happen to be access in that function.  It
looks all correct to me.

> > +	int phy_en_gpio = -EINVAL;
> > +	int phy_stby_gpio = -EINVAL;
> > +	bool phy_en_high = true;
> > +	bool phy_stby_high = true;
> >  
> >  	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> >  	if (IS_ERR(pinctrl))
> > @@ -940,11 +962,46 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
> >  
> >  	if (pdev->dev.of_node) {
> >  		const u32 *clock_freq_p;
> > +		enum of_gpio_flags flags;
> >  
> >  		clock_freq_p = of_get_property(pdev->dev.of_node,
> >  						"clock-frequency", NULL);
> >  		if (clock_freq_p)
> >  			clock_freq = *clock_freq_p;
> > +
> > +		phy_en_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
> > +						      "phy-enable-gpios",
> > +						       0, &flags);
> > +		if (gpio_is_valid(phy_en_gpio)) {
> > +			if (flags == OF_GPIO_ACTIVE_LOW)
> > +				phy_en_high = false;
> 
> I really like the "flags" solution, much better than a DT property. What
> about keeping the term active_low instead of en_high? From my limited
> knowledge about electronic I say, that active low is a standard term.
> 
Ok, we will have these two bool variables named phy_en_active_low and
phy_stby_active_low.  Will resend to change them.

-- 
Regards,
Shawn

