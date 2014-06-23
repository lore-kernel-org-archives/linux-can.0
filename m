From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Gitorious] Activity: prabhakar requested a merge of prab...
Date: Mon, 23 Jun 2014 18:22:29 +0200
Message-ID: <53A85445.8070400@pengutronix.de>
References: <53a829dc98811_78d23ff48250bea851769@ratt.gitorious.c.bitbit.net.mail> <53A851DC.2060801@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vSCa5mvCEs7aREcHBcNejOO7kEXwnIfxo"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55726 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961AbaFWQWh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Jun 2014 12:22:37 -0400
In-Reply-To: <53A851DC.2060801@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, prabhakar.csengg@gmail.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vSCa5mvCEs7aREcHBcNejOO7kEXwnIfxo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/23/2014 06:12 PM, Oliver Hartkopp wrote:
> Hi Prabhakar,
>=20
> thanks for your patch.
>=20
> Can you please send it with git send-email to the mailing list for a re=
view?
>=20
> Additionally:
>=20
> Does this patch introduce any backward compatibility restrictions (e.g.=
 you
> need at least the includes from 2.6.14+ to build candump ...).

When was CAN support added to the linux kernel? :)

> You only provide to configure a value for SCHED_RR.
> Does it make sense to provide other scheduling policies too?

I would use chrt to start the tool, if I need non standard scheduling
policies.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--vSCa5mvCEs7aREcHBcNejOO7kEXwnIfxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOoVEUACgkQjTAFq1RaXHOnxwCdGogOW9To7Y/FQi5f95tboWVj
VmUAn1VfVx2zCSKCHamlcRAAYJXVt+eA
=KJpB
-----END PGP SIGNATURE-----

--vSCa5mvCEs7aREcHBcNejOO7kEXwnIfxo--
