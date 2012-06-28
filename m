From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 19:46:02 +0800
Message-ID: <20120628114559.GE22990@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20120628113327.GJ6406@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:37989
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751036Ab2F1Lpr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 07:45:47 -0400
Content-Disposition: inline
In-Reply-To: <20120628113327.GJ6406@shlinux2.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Thu, Jun 28, 2012 at 07:33:28PM +0800, Dong Aisheng wrote:
> > +		phy_stby_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
> > +							"phy-standby-gpios",
> > +							0, &flags);
> > +		if (gpio_is_valid(phy_stby_gpio)) {
> > +			if (flags == OF_GPIO_ACTIVE_LOW)
> > +				phy_stby_high = false;
> > +			err = devm_gpio_request_one(&pdev->dev, phy_stby_gpio,
> > +						    GPIOF_DIR_OUT,
> > +						    "phy-standby");
> > +			if (err) {
> > +				dev_err(&pdev->dev,
> > +					"failed to request gpio %d: %d\n",
> > +					phy_stby_gpio, err);
> > +				goto failed_gpio;
> I checked mx28 evk, it seems the phy only has a STB gpio and shared by both CAN0&CAN1.
> I wonder the CAN1 probe may fail here.
> 
It can be managed by dts.  Here is what I have in imx28-evk.dts, where
only can0 has phy-enable-gpios property.


	can0: can@80032000 {
		pinctrl-names = "default";
		pinctrl-0 = <&can0_pins_a>;
		phy-enable-gpios = <&gpio2 13 0>;
		status = "okay";
	};

	can1: can@80034000 {
		pinctrl-names = "default";
		pinctrl-0 = <&can1_pins_a>;
		status = "okay";
	};


-- 
Regards,
Shawn

