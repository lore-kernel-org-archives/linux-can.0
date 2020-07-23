From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: About sysfs usage by socket-can drivers
Date: Thu, 23 Jul 2020 22:13:09 +0200
Message-ID: <f22b3382-da16-8bf3-02b4-e3fc818e504e@pengutronix.de>
References: <VI1PR03MB50531E485F82E3FD4D64C459D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Bax9yCPcjsfaFa834DyRAp0nfzzXExHA9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWUNT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Jul 2020 16:13:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AD8C0619DC
        for <linux-can@vger.kernel.org>; Thu, 23 Jul 2020 13:13:18 -0700 (PDT)
In-Reply-To: <VI1PR03MB50531E485F82E3FD4D64C459D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bax9yCPcjsfaFa834DyRAp0nfzzXExHA9
Content-Type: multipart/mixed; boundary="1Dhfad15FHctyHiO2uavH1Tuf5wLMoNXN";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <f22b3382-da16-8bf3-02b4-e3fc818e504e@pengutronix.de>
Subject: Re: About sysfs usage by socket-can drivers
References: <VI1PR03MB50531E485F82E3FD4D64C459D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
In-Reply-To: <VI1PR03MB50531E485F82E3FD4D64C459D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>

--1Dhfad15FHctyHiO2uavH1Tuf5wLMoNXN
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 7/23/20 9:39 PM, St=C3=A9phane Grosjean wrote:
>>> - changing the default clock value,
>=20
>> The input clock rate for the CAN IP Core?
> Yes

Can you query the possible clock rates? Either add to ethtool or make it =
a CAN
specific callback.

>>> - reading the bus load value,
>> ..as calculated by the USB device?
>=20
> or by the IP core, yes.

maybe we can add this to ethtool's stats, otherwise to the CAN stats.

>>> - using a flashed device id. to better control the can interface numb=
er,
>=20
>> Can you make use of dev_id/dev_port
>> https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice=
=2Eh#L1687
>=20
> Ok. I'll check that, thanks.
>=20
>=20
>>> - identifying the (USB) channel
>=20
>> Does udev offer all needed information? E.g.:
>=20
> Sorry, nope: identify the USB adapter <=3D> flash the LED (which USB de=
vice corresponds to which canX)

Use ethtool's set_phys_id for this:

https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/gs_usb=
=2Ec#L762

You can either implement a "activate blink", "deactivate blink" or "switc=
h LED
on", "switch LED off" (and I think the core will take care of blinking).

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--1Dhfad15FHctyHiO2uavH1Tuf5wLMoNXN--

--Bax9yCPcjsfaFa834DyRAp0nfzzXExHA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl8Z71YACgkQqclaivrt
76m4Jwf9E9w3fdgui0fE9p+sQfrHC7dVakZpE0M1t7PWJ8n3UT2SsqexWlw6Nj+N
8esgT3lDhQOEL+BnqfmhiOau+x4Hcub7GSK80s71Js1xJUG8obA1Hz4fl7jWGoEZ
AaDhRSM0+jLKe8YGfOLgIHf8YRA1rKd/bi6b2rRGKscRkZOIWFo7zhaD6jxU3F4I
QkkJxRlAukkKWEn6LS6fjE9UDgdAmVZD6aO8acZ35MmM3NRrlDfLdP+/w54DDWh8
tdYxzz+bz3+ITR81HCz+k7WWGw1bvVKs5Oc9S07p2vT5G/QHOwbc5xhX6YJ/Duwz
5NS8i4YQn/c8gDV3BkEyxJA/v/BIWg==
=tv4o
-----END PGP SIGNATURE-----

--Bax9yCPcjsfaFa834DyRAp0nfzzXExHA9--
