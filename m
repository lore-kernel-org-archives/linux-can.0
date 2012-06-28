From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 13:30:40 +0800
Message-ID: <20120628053038.GC30041@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20459.59910.783086.760997@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:32629
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750784Ab2F1FaZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 28 Jun 2012 01:30:25 -0400
Content-Disposition: inline
In-Reply-To: <20459.59910.783086.760997@ipc1.ka-ro>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Thu, Jun 28, 2012 at 07:22:14AM +0200, Lothar Wa=DFmann wrote:
> > +- phy-enable-gpios : Specify the gpio used to enable phy
> > +- phy-standby-gpios : Specify the gpio used to put phy into STANDB=
Y mode
> > =20
> Why the plural form 'gpios'? It's just one gpio.
> s/gpios/gpio/ ?
>=20
It's a common pattern suggested by common gpio bindings
Documentation/devicetree/bindings/gpio/gpio.txt.

--=20
Regards,
Shawn

