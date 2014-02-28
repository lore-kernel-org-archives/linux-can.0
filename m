From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 4/6] can: introduce the data bitrate configuration
 for CAN FD
Date: Fri, 28 Feb 2014 11:56:43 +0100
Message-ID: <53106B6B.6040307@pengutronix.de>
References: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net> <1393452662-3154-5-git-send-email-socketcan@hartkopp.net> <530EFAA0.4090000@pengutronix.de> <530F7E6A.4050307@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4hPNsCicwmxhSbLPEXJSrHsmb6U0LfUTN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45904 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaB1K4u (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 05:56:50 -0500
In-Reply-To: <530F7E6A.4050307@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4hPNsCicwmxhSbLPEXJSrHsmb6U0LfUTN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2014 07:05 PM, Oliver Hartkopp wrote:
> On 27.02.2014 09:43, Marc Kleine-Budde wrote:
>=20
>>> +		if (priv->do_set_data_bittiming) {
>>> +			/* Finally, set the bit-timing registers */
>>> +			err =3D priv->do_set_data_bittiming(dev);
>>> +			if (err)
>>> +				return err;
>>> +		}
>>
>> Do we really need the do_set_data_bittiming() callback? Allmost all
>> drivers set the bitrate during open and not asynchronously (when the
>> interface is down) via the set_bittiming() callback. If there is a
>> driver which really needs this callback, we can introduce it.
>=20
> No. I assume you did not check the current implementation %-)

Yes, but...no :)

> The bitrate is always set via do_set[_data]_bittiming() when the interf=
ace is
> down - and *not* during the open process.

No, not _always_. The flexcan and at91 drivers (maybe others, too) write
the values during open().

> In the open process only the availability of the bitrate(s) is checked =
before
> the controller is set into operational mode.

Yes, by the framework. This is good.

> It is pretty straight forward to introduce do_set_data_bittiming() as a=

> different register set is addressed for CAN FD.

The reason why I don't want to introduce a do_set_data_bittiming() is
that it makes the driver more complicated. If you really want to write
it into the registers, you have to power up you CAN core, as on modern
controllers you cannot write to regs if the clocks are turned off. So
you have to turn on the clock, power up your chip, get into the correct
mode, write the bittiming and power down everything again. During open()
you do the same thing again but don't write the bit timing registers. So
better keep things simple.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4hPNsCicwmxhSbLPEXJSrHsmb6U0LfUTN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMQa2sACgkQjTAFq1RaXHMQEQCfcTSnmmDAKE7eEeIk3TC1qf9y
l5cAmgNqwnOGb6oQuX/XbXj2K5tN5T6K
=0Ieg
-----END PGP SIGNATURE-----

--4hPNsCicwmxhSbLPEXJSrHsmb6U0LfUTN--
