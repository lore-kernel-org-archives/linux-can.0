From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 14:05:14 +0200
Message-ID: <4FEC487A.2050901@pengutronix.de>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org> <1340853701-4488-3-git-send-email-shawn.guo@linaro.org> <20120628113327.GJ6406@shlinux2.ap.freescale.net> <20120628114559.GE22990@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig25A1ECA315CADC419732ED5E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43717 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab2F1MFZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 08:05:25 -0400
In-Reply-To: <20120628114559.GE22990@S2101-09.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25A1ECA315CADC419732ED5E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/28/2012 01:46 PM, Shawn Guo wrote:
> On Thu, Jun 28, 2012 at 07:33:28PM +0800, Dong Aisheng wrote:
>>> +		phy_stby_gpio =3D of_get_named_gpio_flags(pdev->dev.of_node,
>>> +							"phy-standby-gpios",
>>> +							0, &flags);
>>> +		if (gpio_is_valid(phy_stby_gpio)) {
>>> +			if (flags =3D=3D OF_GPIO_ACTIVE_LOW)
>>> +				phy_stby_high =3D false;
>>> +			err =3D devm_gpio_request_one(&pdev->dev, phy_stby_gpio,
>>> +						    GPIOF_DIR_OUT,
>>> +						    "phy-standby");
>>> +			if (err) {
>>> +				dev_err(&pdev->dev,
>>> +					"failed to request gpio %d: %d\n",
>>> +					phy_stby_gpio, err);
>>> +				goto failed_gpio;
>> I checked mx28 evk, it seems the phy only has a STB gpio and shared by=
 both CAN0&CAN1.
>> I wonder the CAN1 probe may fail here.
>>
> It can be managed by dts.  Here is what I have in imx28-evk.dts, where
> only can0 has phy-enable-gpios property.
>=20
>=20
> 	can0: can@80032000 {
> 		pinctrl-names =3D "default";
> 		pinctrl-0 =3D <&can0_pins_a>;
> 		phy-enable-gpios =3D <&gpio2 13 0>;
> 		status =3D "okay";
> 	};
>=20
> 	can1: can@80034000 {
> 		pinctrl-names =3D "default";
> 		pinctrl-0 =3D <&can1_pins_a>;
> 		status =3D "okay";
> 	};

Will this work if can0 is down and can1 is up?

Can we abstract the transceiver power as a regulator? Or a clock? :P

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig25A1ECA315CADC419732ED5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/sSH4ACgkQjTAFq1RaXHN02QCfV1GHlaie42hCLiaB+Y8jICjv
zDMAoI67ojozs6Dv23vWQuvsOZracqx0
=k0OC
-----END PGP SIGNATURE-----

--------------enig25A1ECA315CADC419732ED5E--
