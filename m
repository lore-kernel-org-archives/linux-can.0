From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: migrate documentation to restructured text
Date: Wed, 24 Jan 2018 12:50:20 +0100
Message-ID: <4dfbb289-1acf-403d-43f8-d13ee4ac931b@pengutronix.de>
References: <20180124101911.18006-1-r.schwebel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="yNKB0ohyl7in6EAoSEG4K5HTQlb4Jra2M"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35095 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933417AbeAXLuu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Jan 2018 06:50:50 -0500
In-Reply-To: <20180124101911.18006-1-r.schwebel@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>, linux-can@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, linux-doc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yNKB0ohyl7in6EAoSEG4K5HTQlb4Jra2M
Content-Type: multipart/mixed; boundary="9WWaAHFyFzcJVzyoUO2N4XoHE5r3kV5RV";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Robert Schwebel <r.schwebel@pengutronix.de>, linux-can@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Oliver Hartkopp
 <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>,
 linux-doc@vger.kernel.org
Message-ID: <4dfbb289-1acf-403d-43f8-d13ee4ac931b@pengutronix.de>
Subject: Re: [PATCH] can: migrate documentation to restructured text
References: <20180124101911.18006-1-r.schwebel@pengutronix.de>
In-Reply-To: <20180124101911.18006-1-r.schwebel@pengutronix.de>

--9WWaAHFyFzcJVzyoUO2N4XoHE5r3kV5RV
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 01/24/2018 11:19 AM, Robert Schwebel wrote:
> The kernel documentation is now restructured text. Convert the SocketCA=
N
> documentation and include it in the toplevel kernel documentation.
>=20
> This patch doesn't do any content change.
>=20
> All references to can.txt in the code are converted to can.rst.
>=20
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

This fails to apply on next-next/master. v4.15-rc7 was working though
and git rebase did the work. Use net-next/master as a base in the future.=


> ---
>  .../devicetree/bindings/powerpc/fsl/mpc5200.txt    |    2 +-
>  Documentation/networking/00-INDEX                  |    2 -
>  Documentation/networking/can.rst                   | 1437 ++++++++++++=
++++++++
>  Documentation/networking/can.txt                   | 1308 ------------=
------
>  Documentation/networking/index.rst                 |    1 +
>  MAINTAINERS                                        |    2 +-
>  drivers/net/can/dev.c                              |    2 +-
>  drivers/net/can/vcan.c                             |    2 +-
>  net/can/Kconfig                                    |    2 +-
>  9 files changed, 1443 insertions(+), 1315 deletions(-)
>  create mode 100644 Documentation/networking/can.rst
>  delete mode 100644 Documentation/networking/can.txt
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt =
b/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
> index 4ccb2cd5df94..418d0baae2e9 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
> @@ -195,4 +195,4 @@ External interrupts:
> =20
>  fsl,mpc5200-mscan nodes
>  -----------------------
> -See file can.txt in this directory.
> +See file can.rst in this directory.

This is wrong since a long time. I've fixed this in an individual patch.
Otherwise applied.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--9WWaAHFyFzcJVzyoUO2N4XoHE5r3kV5RV--

--yNKB0ohyl7in6EAoSEG4K5HTQlb4Jra2M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpocvwACgkQHv7KIOw4
HPaVEQf+JWV69ifeCTRINsujRHeEqOu+p9dLyVQIuzO3ka8po5kmi+aHzuH6dGG9
gZ5FyQS87szF3D1KqvlcnA8ZzZSz2/ZrrFj5lNO6oev94agUjzuTkcGmLOf3PP0A
PAAVPFsJUq9BH9mcKQFoWq2VfscuZa4PVLGiDd885Pg+Smg/1FWJZ5YCLQfgJOwG
sJluXMdPd/qcoSmRlQJMDUuEbVYlc9zu7nX0IPmS6h1SL/noe9ysrDBL0E/Lg1HR
y2Gn6KDak2nYOIMgSnAN1LVg8gV57WYPXR7L+fzvIPzY0DzNcbDhuHp2B3mnUkuF
X6+Yj+Pj4LJovWqYY11vEYp/vaX0DA==
=oeZs
-----END PGP SIGNATURE-----

--yNKB0ohyl7in6EAoSEG4K5HTQlb4Jra2M--
