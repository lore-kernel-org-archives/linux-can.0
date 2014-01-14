From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pull-request: can-next 2014-01-11
Date: Tue, 14 Jan 2014 21:31:19 +0100
Message-ID: <52D59E97.9090109@pengutronix.de>
References: <52D191E2.8040703@pengutronix.de> <52D597B4.7020607@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5JgF4CibRowrHJNXQ86h1gRlFovQaXb0f"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55990 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbaANUbb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Jan 2014 15:31:31 -0500
In-Reply-To: <52D597B4.7020607@cogentembedded.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, netdev@vger.kernel.org
Cc: David Miller <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5JgF4CibRowrHJNXQ86h1gRlFovQaXb0f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/14/2014 09:01 PM, Sergei Shtylyov wrote:
> Hello.
>=20
> On 01/11/2014 09:48 PM, Marc Kleine-Budde wrote:
>=20
>> Hello David,
>=20
>> this is a pull request of three patches for net-next/master.
>=20
>> Oleg Moroz added support for a new PCI card to the generic SJA1000 PCI=

>> driver, Guenter Roeck's patch limits the flexcan driver to little
>> endian arm (and powerpc) and I fixed a sparse warning found by the
>> kbuild robot in the ti_hecc driver.
>=20
>    What about the rewritten Renesas R-Car CAN driver? Is there a chance=

> to get it into 3.14-rc1 now that we've missed 3.13-rc1? I've sent it at=

> the very end of December, and have got no feedback still...

I was ill last week and as a customer today and tomorrow, I'll review
your driver this week.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5JgF4CibRowrHJNXQ86h1gRlFovQaXb0f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLVnpcACgkQjTAFq1RaXHN35ACfVNP/rhpojLy3KACTLvyiRl39
65wAoJBKo2XBn45SIc+mz5V/TqO+yxnb
=dCom
-----END PGP SIGNATURE-----

--5JgF4CibRowrHJNXQ86h1gRlFovQaXb0f--
