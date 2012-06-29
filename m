From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Fri, 29 Jun 2012 11:27:04 +0200
Message-ID: <4FED74E8.4040805@pengutronix.de>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org> <1340853701-4488-3-git-send-email-shawn.guo@linaro.org> <20120628113327.GJ6406@shlinux2.ap.freescale.net> <20120628114559.GE22990@S2101-09.ap.freescale.net> <4FEC487A.2050901@pengutronix.de> <20120628121817.GA5755@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7F729F98695616BEE36B1B58"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59205 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab2F2J1W (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 29 Jun 2012 05:27:22 -0400
In-Reply-To: <20120628121817.GA5755@shlinux2.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng-B29396 <B29396@freescale.com>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Sascha Hauer <sha@pengutronix.de>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7F729F98695616BEE36B1B58
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/28/2012 02:18 PM, Dong Aisheng wrote:
> On Thu, Jun 28, 2012 at 08:05:14PM +0800, Marc Kleine-Budde wrote:
>> On 06/28/2012 01:46 PM, Shawn Guo wrote:
>>> On Thu, Jun 28, 2012 at 07:33:28PM +0800, Dong Aisheng wrote:
>>>>> +		phy_stby_gpio =3D of_get_named_gpio_flags(pdev->dev.of_node,
>>>>> +							"phy-standby-gpios",
>>>>> +							0, &flags);
>>>>> +		if (gpio_is_valid(phy_stby_gpio)) {
>>>>> +			if (flags =3D=3D OF_GPIO_ACTIVE_LOW)
>>>>> +				phy_stby_high =3D false;
>>>>> +			err =3D devm_gpio_request_one(&pdev->dev, phy_stby_gpio,
>>>>> +						    GPIOF_DIR_OUT,
>>>>> +						    "phy-standby");
>>>>> +			if (err) {
>>>>> +				dev_err(&pdev->dev,
>>>>> +					"failed to request gpio %d: %d\n",
>>>>> +					phy_stby_gpio, err);
>>>>> +				goto failed_gpio;
>>>> I checked mx28 evk, it seems the phy only has a STB gpio and shared =
by both CAN0&CAN1.
>>>> I wonder the CAN1 probe may fail here.
>>>>
>>> It can be managed by dts.  Here is what I have in imx28-evk.dts, wher=
e
>>> only can0 has phy-enable-gpios property.
>>>
>>>
>>> 	can0: can@80032000 {
>>> 		pinctrl-names =3D "default";
>>> 		pinctrl-0 =3D <&can0_pins_a>;
>>> 		phy-enable-gpios =3D <&gpio2 13 0>;
>>> 		status =3D "okay";
>>> 	};
>>>
>>> 	can1: can@80034000 {
>>> 		pinctrl-names =3D "default";
>>> 		pinctrl-0 =3D <&can1_pins_a>;
>>> 		status =3D "okay";
>>> 	};
>>
>> Will this work if can0 is down and can1 is up?
>>
>> Can we abstract the transceiver power as a regulator? Or a clock? :P
>>
> Hmm, it may not be a power.
> For mx28evk, it's a STBY pin.
> So it may hard to abstract it as a regulator or clock.

I just talked to Sascha, He pointed out, that there already is regulator
that toggles a gpio (only one, not several). I haven't looked at the
details, but a regulator should solve the "two CAN ports share the same
transceiver/phy" problem.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig7F729F98695616BEE36B1B58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/tdOsACgkQjTAFq1RaXHNWtQCggR3+hLQNe9HKt8xLEA8vBoF+
olgAn0J74Ho1U5YRXb8EsrVS+RikjzJ+
=fo5A
-----END PGP SIGNATURE-----

--------------enig7F729F98695616BEE36B1B58--
