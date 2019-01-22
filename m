From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix NULL pointer exception during bringup
Date: Tue, 22 Jan 2019 11:38:43 +0100
Message-ID: <141795e7-3b20-0297-fad7-96feb247f4b3@pengutronix.de>
References: <20190111105619.gkf2735zlpe6qbxv@pengutronix.de>
 <20190111112041.10710-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pL4gJIA5sr5svXurq5pWOFZYrzvEqc8js"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190111112041.10710-1-u.kleine-koenig@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stable <stable@vger.kernel.org>, linux-can@vger.kernel.org, kernel@pengutronix.de, davem@davemloft.net, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pL4gJIA5sr5svXurq5pWOFZYrzvEqc8js
Content-Type: multipart/mixed; boundary="a5oDNiJJFSQoCUgOJJhfiXSLJXcLQNUPp";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stable <stable@vger.kernel.org>,
 linux-can@vger.kernel.org, kernel@pengutronix.de, davem@davemloft.net,
 Alexander Stein <alexander.stein@systec-electronic.com>
Message-ID: <141795e7-3b20-0297-fad7-96feb247f4b3@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix NULL pointer exception during bringup
References: <20190111105619.gkf2735zlpe6qbxv@pengutronix.de>
 <20190111112041.10710-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20190111112041.10710-1-u.kleine-koenig@pengutronix.de>

--a5oDNiJJFSQoCUgOJJhfiXSLJXcLQNUPp
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/11/19 12:20 PM, Uwe Kleine-K=C3=B6nig wrote:
> Commit cbffaf7aa09e ("can: flexcan: Always use last mailbox for TX")
> introduced a loop letting i run up to (including) ARRAY_SIZE(regs->mb)
> and in the body accessed regs->mb[i] which is an out-of-bounds array
> access that then resulted in an access to an reserved register area.
>=20
> Later this was changed by commit 0517961ccdf1 ("can: flexcan: Add
> provision for variable payload size") to iterate a bit differently but
> still runs one iteration too much resulting to call
>=20
> 	flexcan_get_mb(priv, priv->mb_count)
>=20
> which results in a WARN_ON and then a NULL pointer exception. This
> only affects devices compatible with "fsl,p1010-flexcan",
> "fsl,imx53-flexcan", "fsl,imx35-flexcan", "fsl,imx25-flexcan",
> "fsl,imx28-flexcan", so newer i.MX SoCs are not affected.
>=20
> Fixes: cbffaf7aa09e ("can: flexcan: Always use last mailbox for TX")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to linux-can

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--a5oDNiJJFSQoCUgOJJhfiXSLJXcLQNUPp--

--pL4gJIA5sr5svXurq5pWOFZYrzvEqc8js
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlxG8rMACgkQk9IU1zQo
ZfG0RggAljpkkk2AH+HcY2JBVGcH7S9kxDCWHUneS0Zx9j+NdWEIeDIwUv/K259H
hTzhbb1dPupE0UnDv6ysP6ZR2AqmYqrLL8eg0Bq3fRtu7P0h4IS2XnoZDXxJ6dwm
D0aL782/ROUclK+3QM5tUSsJCYcjiVyI322Frt0xXv+nBBhX28w5u/UvbrE7BIUz
LpkJ/X/KhV32KRPolDs387Jut23IqeLxOLNI+U74Bp7qDvDtb+Jco9iubsPMzmGl
7YUZGOqmZlhXOJKG16WENTrmDIxoU+r+wBFImOrL6+TOe9vQpV8tqd+N1VsVsVBU
6DJyrEUN+e/CWiTlj7yO3Adkmk9Zwg==
=yamr
-----END PGP SIGNATURE-----

--pL4gJIA5sr5svXurq5pWOFZYrzvEqc8js--
