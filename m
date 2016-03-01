From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] arm64: dts: r8a7795: Add CAN support
Date: Tue, 1 Mar 2016 09:12:42 +0100
Message-ID: <56D54EFA.6020105@pengutronix.de>
References: <1456755759-51288-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DOQWuwIh0k0v96ThfUQwlcUoabwTsKnCv"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456755759-51288-1-git-send-email-ramesh.shanmugasundaram-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, chris.paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DOQWuwIh0k0v96ThfUQwlcUoabwTsKnCv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/29/2016 03:22 PM, Ramesh Shanmugasundaram wrote:
> Adds CAN controller nodes for r8a7795.
>=20
> Note: CAN channel register base address mentioned in R-Car Gen3 Hardwar=
e
> User Manual v0.5E is incorrect. The corrected base addresses are:
>=20
> CAN Channel 0 - 0xe6c30000
> CAN Channel 1 - 0xe6c38000
>=20
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram-+3GIUL1IS+U@public.gmane.org=
sas.com>
> ---
> Hi All,
>=20
>    This patch is based on linux-next (tag:next-20160225) with following=
 patch
>    applied on top

Who should take this patch?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DOQWuwIh0k0v96ThfUQwlcUoabwTsKnCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJW1U76AAoJED07qiWsqSVqZjsIAJZ5yDVFXnOTWA35uVymCA1V
1/i1TYpVusL7sU4tKtjuLQPRmisHl2laa8YIOyjZlyl4nnkb4cCN1bHeTRmpAgYf
BHQgv6uy4z18OBaphEf2+TK5gIfMaubeCBlSnyZqMnD/0DKnnjl4k3QircIN9Ql4
f2rPr7IlGZk1EujHutyLkAKp5SPJammRLVYTqaIC4hG7CU8JGs9OkZoJfGC+Iuse
GOezap083EsMymmKTs/InmHft4JIoyCbPYdzAaRIYcUHEan9JmkPOKZlbnRkmbR9
TSEPNeqgqJA0It5njzSM0Lizoavw5ASWscODW8lPXZlc04Ltc0smR9JZqATlt6Q=
=NQGV
-----END PGP SIGNATURE-----

--DOQWuwIh0k0v96ThfUQwlcUoabwTsKnCv--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
