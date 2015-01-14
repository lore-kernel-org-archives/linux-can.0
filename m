From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] can/peak_usb: add support for PEAK new CANFD USB adapters
Date: Wed, 14 Jan 2015 12:07:11 +0100
Message-ID: <54B64DDF.5050909@pengutronix.de>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com> <54AD66C5.10908@pengutronix.de> <54B64B41.2040500@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="M8SXNPlgieJT35eqQVJpQpLTXeo6TuNM2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49704 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbANLHT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Jan 2015 06:07:19 -0500
In-Reply-To: <54B64B41.2040500@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M8SXNPlgieJT35eqQVJpQpLTXeo6TuNM2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/14/2015 11:56 AM, Stephane Grosjean wrote:
> Hi again Marc,
>=20
> Well... What's wrong?
>=20
>    $ git clone https://gitorious.org/linux-can/linux-can.git
>    Cloning into 'linux-can'...
>    error: RPC failed; result=3D22, HTTP code =3D 504
>    fatal: The remote end hung up unexpectedly
>=20
> (same with linux-can-next...)

Same here:
> =E2=9E=9C (pts/32) frogger@hardanger:/tmp git clone https://gitorious.o=
rg/linux-can/linux-can.git=20
> Cloning into 'linux-can'...
> error: RPC failed; result=3D22, HTTP code =3D 504
> fatal: The remote end hung up unexpectedly

504 is Gateway timeout - maybe the kernel is too big to clone :D

I'd suggest to add can and can-next as a remote to an existing linux git =
tree.

Skip the first step if you already have a linux git tree:

    git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
    cd linux
    git remote add -f can https://gitorious.org/linux-can/linux-can.git
    git remote add -f can-next https://gitorious.org/linux-can/linux-can-=
next.git

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--M8SXNPlgieJT35eqQVJpQpLTXeo6TuNM2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtk3fAAoJECte4hHFiupUb7kQAIDfORXrsJEKIOTjZc+FV1u5
/qpBytw6NsYshWw6QjA3VJghFBgiZXfJrSwAR8BqcbtjOeFeCbWaiADewnBtWG/1
g9xQZn+G3AuP5BcWsbJDiyqXm9C4UcmpM5wdrlBHjFp5HdZi3IW98mIUX8ogA7zn
ucIGSiWS//te9wyqSgWIJRUchj4K4iIJZA2n9In1G48binrlxHx8B/7UtklbDv4A
hiEsowRreByWqvmNuW02WHd3lF735OroDHnqkMEXSgABZW13VyF1Ac3XjheKbSgi
GnBufusLOB8SRB9CFIi3uz3gKoPtoDRjQXe7kP6O5k27R0Wm/I8WosfeJ68k6Gak
vVy9htqkFz9mCwaVulrvKw87qlpG3DkHFUZxGc/i4UcczQ4LipUsmGc35GuSf8uE
YXxGCmv6E5Bf9cntZl5BM53bEvf3vuGsRNO+4PocEOL/xZiYg/L+383orwuW6hi/
/VbMUOR6C2kqWRJDLKxH4jkHlGkqjTyhIWPybhzV6CRiQCnmP1Pd9ZpFE+SmyHa4
uljOPSxt65e/9BMw1Q7gj89OwtbpqSLqzf+F3Ib07wiWDN/NqTPe9xODjGaXh8nn
5nV2MGFDHbSDJ+E9XSTRsHY/NwQjUSgPKbFEtKAJne7AQOoo+vaLLgHrgXsv7UCK
IXW7RMNtz6D9RA9GPeao
=+oMT
-----END PGP SIGNATURE-----

--M8SXNPlgieJT35eqQVJpQpLTXeo6TuNM2--
