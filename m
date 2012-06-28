From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios
 support
Date: Thu, 28 Jun 2012 20:02:46 +0800
Message-ID: <20120628120245.GM6406@shlinux2.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20120628113327.GJ6406@shlinux2.ap.freescale.net>
 <20120628114559.GE22990@S2101-09.ap.freescale.net>
 <20120628114815.GL6406@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:34547
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752452Ab2F1MIX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 08:08:23 -0400
Content-Disposition: inline
In-Reply-To: <20120628114815.GL6406@shlinux2.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Hui Wang <jason77.wang@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Thu, Jun 28, 2012 at 07:48:16PM +0800, Dong Aisheng wrote:
> On Thu, Jun 28, 2012 at 07:46:02PM +0800, Shawn Guo wrote:
> > On Thu, Jun 28, 2012 at 07:33:28PM +0800, Dong Aisheng wrote:
> > > > +		phy_stby_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
> > > > +							"phy-standby-gpios",
> > > > +							0, &flags);
> > > > +		if (gpio_is_valid(phy_stby_gpio)) {
> > > > +			if (flags == OF_GPIO_ACTIVE_LOW)
> > > > +				phy_stby_high = false;
> > > > +			err = devm_gpio_request_one(&pdev->dev, phy_stby_gpio,
> > > > +						    GPIOF_DIR_OUT,
> > > > +						    "phy-standby");
> > > > +			if (err) {
> > > > +				dev_err(&pdev->dev,
> > > > +					"failed to request gpio %d: %d\n",
> > > > +					phy_stby_gpio, err);
> > > > +				goto failed_gpio;
> > > I checked mx28 evk, it seems the phy only has a STB gpio and shared by both CAN0&CAN1.
> > > I wonder the CAN1 probe may fail here.
> > > 
> > It can be managed by dts.  Here is what I have in imx28-evk.dts, where
> > only can0 has phy-enable-gpios property.
> > 
> > 
> > 	can0: can@80032000 {
> > 		pinctrl-names = "default";
> > 		pinctrl-0 = <&can0_pins_a>;
> > 		phy-enable-gpios = <&gpio2 13 0>;
> > 		status = "okay";
> > 	};
> > 
> > 	can1: can@80034000 {
> > 		pinctrl-names = "default";
> > 		pinctrl-0 = <&can1_pins_a>;
> > 		status = "okay";
> > 	};
> Yes, that is a solution.
> But it may not so reasonable since dts file should represent hw, but here
> we have to do some trick by we know how driver works.
> Maybe we need find a better solution.
> 
One more thing, for such dt representation, if can0 phy is disabled,
can1 may be disabled wrongly too, right?

Regards
Dong Aisheng

