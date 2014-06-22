From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Kvaser lapcan driver (init and probe)
Date: Sun, 22 Jun 2014 19:19:42 +0200
Message-ID: <53A7102E.6060002@pengutronix.de>
References: <CAGqyy=ZHGDovR1i_ZzKqTYqp5QAVhbSco6uwE2-nFefL-g+ouw@mail.gmail.com>	 <53A5990A.5050409@hartkopp.net> <1403454565.3506.3.camel@PCLUK>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="75U16N2RPQ3uCEJbGX1MQq9KgJbCsn86D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45731 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbaFVRTv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 22 Jun 2014 13:19:51 -0400
In-Reply-To: <1403454565.3506.3.camel@PCLUK>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Luis de Arquer <ldearquer@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--75U16N2RPQ3uCEJbGX1MQq9KgJbCsn86D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/22/2014 06:29 PM, Luis de Arquer wrote:
> Hello Oliver,
>=20
> Thanks for your help.
>=20
>>
>> So you should post your driver on either linux-pcmcia@lists.infradead.=
org
>> and linux-can@vger.kernel.org.
>>
>=20
> Yes, I'll do. I had only checked the vger lists, that's why I didn't
> find the pcmcia one :(
>=20
> I will submit it as a patch then -it is a bit of an empty driver, doing=

> only low level initialization and no CAN stuff yet, I hope it is
> alright.

Make sure your driver passes the ./scripts/checkpatch.pl test in the kern=
el.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--75U16N2RPQ3uCEJbGX1MQq9KgJbCsn86D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOnEC4ACgkQjTAFq1RaXHNQfgCgj/PFbmT6SwEuisBETS36MogO
WcwAnRkAS9eZpntFcG2oar28EkNcpYmY
=9mhd
-----END PGP SIGNATURE-----

--75U16N2RPQ3uCEJbGX1MQq9KgJbCsn86D--
