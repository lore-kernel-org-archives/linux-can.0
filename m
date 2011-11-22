From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC PATCH] plx_pci: add Advantech PCI-1680 & UNO-2052 support
Date: Tue, 22 Nov 2011 10:09:38 +0100
Message-ID: <4ECB66D2.6030108@pengutronix.de>
References: <4ECAB5E4.6010903@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCD37AAA9B71FEA421C446861"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49237 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab1KVJJv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Nov 2011 04:09:51 -0500
In-Reply-To: <4ECAB5E4.6010903@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Frank Rysanek <rysanek@fccps.cz>, Pavel Cheblakov <P.B.Cheblakov@inp.nsk.su>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCD37AAA9B71FEA421C446861
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/21/2011 09:34 PM, Oliver Hartkopp wrote:
> Add Advantech PCI-1680 & UNO-2052 support for the SJA1000 plx_pci drive=
r.
>=20
> Signed-off-by: Frank Rysanek <rysanek@fccps.cz>

Nitpick: When posting this patch to netdev don't forget to add your
S-o-b line.

>=20
> ---
>=20
> Hello Frank,
>=20
> i found your patch to support the Advantech PCI-1680 & UNO-2052 cards h=
ere:
>=20
> 	http://www.fccps.cz/download/adv/frr/can-notes.html
>=20
> Are you fine with posting the changes on the netdev mailing list to bec=
ome
> part of the mainline Linux kernel?
>=20
> PLEASE REVIEW: You added an mdelay(100) in plx_pci_check_sja1000() ...

+1 - Such a long delay should not end up in the common code.

> Are you sure this long delay is needed in plx_pci_check_sja1000() or sh=
ould
> we better add a shorter mdelay(10) at the end of plx_pci_reset_common()=
 ??
>=20
> Are you sure your setup is not working without the added mdelay(100) ?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCD37AAA9B71FEA421C446861
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7LZtsACgkQjTAFq1RaXHMvHQCeIkBvz3y3fBIgr5XoHop3vy9X
bfEAoIhEc1mRIyj4A1m3IxZLHMgTEiir
=CNkn
-----END PGP SIGNATURE-----

--------------enigCD37AAA9B71FEA421C446861--
