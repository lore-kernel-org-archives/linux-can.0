From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 07:22:14 +0200
Message-ID: <20459.59910.783086.760997@ipc1.ka-ro>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
	<1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:59633 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab2F1FWg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 01:22:36 -0400
In-Reply-To: <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

Hi,

Shawn Guo writes:
> The flexcan driver has function pointer transceiver_switch defined in
> flexcan_platform_data for platform codes to hook up their transceiver
> switch implementation.  However this does not cope with device tree
> probe.
>=20
> It's been observed that platforms mostly use gpios to control the
> switch of flexcan transceiver, like enable and standby.  The patch
> adds transceiver switch gpios support into flexcan driver, so that
> platforms booting from device tree can just define properties
> phy-enable-gpios and phy-standby-gpios to have flexcan driver control
> the gpios.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../devicetree/bindings/net/can/fsl-flexcan.txt    |    2 +
>  drivers/net/can/flexcan.c                          |   62 ++++++++++=
++++++++++
>  2 files changed, 64 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.tx=
t b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index 8ff324e..e0dbac7 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -15,6 +15,8 @@ Required properties:
>  Optional properties:
> =20
>  - clock-frequency : The oscillator frequency driving the flexcan dev=
ice
> +- phy-enable-gpios : Specify the gpio used to enable phy
> +- phy-standby-gpios : Specify the gpio used to put phy into STANDBY =
mode
> =20
Why the plural form 'gpios'? It's just one gpio.
s/gpios/gpio/ ?


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
