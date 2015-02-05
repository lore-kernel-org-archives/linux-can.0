From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: kvaser_usb: Consolidate and unify state change handling
Date: Thu, 05 Feb 2015 09:30:45 +0100
Message-ID: <54D32A35.9060308@pengutronix.de>
References: <20150205081239.GA30683@mwanda> <54D32731.2070106@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kXvVp2QgUm1iwpMh87WWPqqtHQ1B7IgBL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49191 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbbBEIax (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Feb 2015 03:30:53 -0500
In-Reply-To: <54D32731.2070106@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, ahmed.darwish@valeo.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kXvVp2QgUm1iwpMh87WWPqqtHQ1B7IgBL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2015 09:17 AM, Marc Kleine-Budde wrote:
> Hey Dan,
>=20
> On 02/05/2015 09:12 AM, Dan Carpenter wrote:
>> The patch 96d7f10634e6: "can: kvaser_usb: Consolidate and unify state
>> change handling" from Jan 26, 2015, leads to the following Smatch
>> warning:
>>
>> 	drivers/net/can/usb/kvaser_usb.c:827 kvaser_usb_rx_error_update_can_s=
tate()
>> 	warn: impossible condition '(es->txerr >=3D 256) =3D> (0-255 >=3D 256=
)'
>=20
> A patch that implicitly fixes this warning, along with other
> things, is in my latest pull request to David Miller.

=2E..which has just been merged.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--kXvVp2QgUm1iwpMh87WWPqqtHQ1B7IgBL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU0yo4AAoJECte4hHFiupUNLYP/0u3Xg1OCWOLXndOmZfVUEpb
4Yl2SpWuMmv2PQ9KlvTaSxWPqO3qvJm1skLDQb/aAEQN+0PpLFlkhTElGNFJWBg1
X4XECly6pWTdNxy6UhUYQhF/zPLNykvgj5aeoA3y86L1GtX61Fq2pMtIooaqw3z6
gT+9tNNCHpSXwo0wkwPR57gj1mKKaHcgdcneP/shy7hBWOMnQ+ebnIvmM7ou6l4a
FSOISM7yKpfCagDJhJfePxlVotO6FI6wV2Hnc0NXe8wGNwFRPIw7BkNVEtxMAWTk
lJRsf0WGZEbGQzDXtuC+L1cgM6KM78g1PrVOSUIQ9tq40EuSKHVo9XrRa5vacaFd
aEmf9zOUfyMTtV8pDAcpTyoQinlmzPjQ6ALM1ZNg7Rut6fnTdq8yFb/UjyMX8tHu
jqog2bi9dsc2vu5JtLIBYE0Anlzp3ggy8FZVrfdYtuaD+4cTW+F24tTQ83pXMSkQ
O9VbeLS8roci7wWYrUeN63Hw3KU/Qf4rxYEUirbYzC3kUKuunjcWaljQbdvkORSc
+zFCoqui1W8K+7oE21LuSt6IqLUWVcO2z22mZYBZlzJYruue58MWEzEzb/vKMDre
Pc6N37UvCMIpRL2PbGd4zQqH2V/izhc7/TcOnMv/mvgWjbErEmKwKlpCL9g8dHt6
hkiKUP1yF3flul6Hyt9C
=TPDc
-----END PGP SIGNATURE-----

--kXvVp2QgUm1iwpMh87WWPqqtHQ1B7IgBL--
