From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios
 support
Date: Thu, 28 Jun 2012 20:47:37 +0800
Message-ID: <20120628124736.GA5778@shlinux2.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20120628113327.GJ6406@shlinux2.ap.freescale.net>
 <20120628114559.GE22990@S2101-09.ap.freescale.net>
 <4FEC487A.2050901@pengutronix.de>
 <20120628121817.GA5755@shlinux2.ap.freescale.net>
 <20460.20182.552394.407578@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:3160
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753557Ab2F1MxT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 28 Jun 2012 08:53:19 -0400
Content-Disposition: inline
In-Reply-To: <20460.20182.552394.407578@ipc1.ka-ro>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Dong Aisheng-B29396 <B29396@freescale.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Hui Wang <jason77.wang@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "David S. Miller" <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jun 28, 2012 at 08:32:22PM +0800, Lothar Wa=DFmann wrote:
> Hi,
>=20
> Dong Aisheng writes:
> > On Thu, Jun 28, 2012 at 08:05:14PM +0800, Marc Kleine-Budde wrote:
> > > On 06/28/2012 01:46 PM, Shawn Guo wrote:
> > > > On Thu, Jun 28, 2012 at 07:33:28PM +0800, Dong Aisheng wrote:
> > > >>> +		phy_stby_gpio =3D of_get_named_gpio_flags(pdev->dev.of_nod=
e,
> > > >>> +							"phy-standby-gpios",
> > > >>> +							0, &flags);
> > > >>> +		if (gpio_is_valid(phy_stby_gpio)) {
> > > >>> +			if (flags =3D=3D OF_GPIO_ACTIVE_LOW)
> > > >>> +				phy_stby_high =3D false;
> > > >>> +			err =3D devm_gpio_request_one(&pdev->dev, phy_stby_gpio,
> > > >>> +						    GPIOF_DIR_OUT,
> > > >>> +						    "phy-standby");
> > > >>> +			if (err) {
> > > >>> +				dev_err(&pdev->dev,
> > > >>> +					"failed to request gpio %d: %d\n",
> > > >>> +					phy_stby_gpio, err);
> > > >>> +				goto failed_gpio;
> > > >> I checked mx28 evk, it seems the phy only has a STB gpio and s=
hared by both CAN0&CAN1.
> > > >> I wonder the CAN1 probe may fail here.
> > > >>
> > > > It can be managed by dts.  Here is what I have in imx28-evk.dts=
, where
> > > > only can0 has phy-enable-gpios property.
> > > >=20
> > > >=20
> > > > 	can0: can@80032000 {
> > > > 		pinctrl-names =3D "default";
> > > > 		pinctrl-0 =3D <&can0_pins_a>;
> > > > 		phy-enable-gpios =3D <&gpio2 13 0>;
> > > > 		status =3D "okay";
> > > > 	};
> > > >=20
> > > > 	can1: can@80034000 {
> > > > 		pinctrl-names =3D "default";
> > > > 		pinctrl-0 =3D <&can1_pins_a>;
> > > > 		status =3D "okay";
> > > > 	};
> > >=20
> > > Will this work if can0 is down and can1 is up?
> > >=20
> > > Can we abstract the transceiver power as a regulator? Or a clock?=
 :P
> > >=20
> > Hmm, it may not be a power.
> > For mx28evk, it's a STBY pin.
> > So it may hard to abstract it as a regulator or clock.
> >=20
> I have created a 'gpio-switch' driver in my private tree that can be
> used for exactly this purpose. It takes care of the pin polarity and
> initial state of the pins and can handle shared pins like in this
> case. The client driver does not even need to care whether an actual
> GPIO exists for the current platform.
>=20
> I could prepare a patch and post it here.
>=20
Would be glad to see your patches.
It may be useful, not only for this case,
we also meet some other issues, i'm not sure but may have similar requi=
rement
like SDIO WiFi reset, usb phy reset and etc.

Regards
Dong Aisheng

