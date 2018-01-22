From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] [stable pre-4.12] can: af_can: can_rcv(): replace
 WARN_ONCE by pr_warn_once
Date: Mon, 22 Jan 2018 14:48:06 +0100
Message-ID: <0c937dd9-8b39-adf0-1495-a50bc71c1012@pengutronix.de>
References: <20180122134447.4533-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HrhCPDHGRu0a4txmhhNYeKMbWlsYu4n8r"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48901 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeAVNsf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jan 2018 08:48:35 -0500
In-Reply-To: <20180122134447.4533-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HrhCPDHGRu0a4txmhhNYeKMbWlsYu4n8r
Content-Type: multipart/mixed; boundary="HOPVsLHAJOcWYbqClDDuFy8OqouPbgZqf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <0c937dd9-8b39-adf0-1495-a50bc71c1012@pengutronix.de>
Subject: Re: [PATCH 1/2] [stable pre-4.12] can: af_can: can_rcv(): replace
 WARN_ONCE by pr_warn_once
References: <20180122134447.4533-1-socketcan@hartkopp.net>
In-Reply-To: <20180122134447.4533-1-socketcan@hartkopp.net>

--HOPVsLHAJOcWYbqClDDuFy8OqouPbgZqf
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/22/2018 02:44 PM, Oliver Hartkopp wrote:
> In Linux 4.12 commit 8e8cda6d737d356054c ("can: initial support for net=
work
> namespaces") removed a namespace check which affected this patch:
>=20
> upstream commit 8cb68751c115d176ec851ca56ecfbb411568c9e8
>=20
> can: af_can: can_rcv(): replace WARN_ONCE by pr_warn_once
>=20
> If an invalid CAN frame is received, from a driver or from a tun
> interface, a Kernel warning is generated.
>=20
> This patch replaces the WARN_ONCE by a simple pr_warn_once, so that a
> kernel, bootet with panic_on_warn, does not panic. A printk seems to be=

> more appropriate here.
>=20
> Reported-by: syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: linux-stable <stable@vger.kernel.org> [pre 4.12]
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

nice!

thnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HOPVsLHAJOcWYbqClDDuFy8OqouPbgZqf--

--HrhCPDHGRu0a4txmhhNYeKMbWlsYu4n8r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpl65YACgkQHv7KIOw4
HPbGqAgAqjoHX+sxmDXz3O/ljfrRsjrhy9Ct+Yuldx2OHUSXmEzx3F46Rma64IE+
Q3qX62qh0Cga03T5b1bv87FXEIQ+3hW8RUGXJzOQlq0UdlkPA8s2nhS4LKqjow68
z7bm0WmJeBOc3Z/L7bneh1FFtqNoKNyHcP6r1oFa+sJHlVWZUcEnmkgfmv471dtR
sK9qm40CMWNNuqyn+qSuLzUuIg2KXwdpLPqitvbKe1QdJnkHmbW9G91NVoF/fUtZ
lZViL9634TEYhqrvXze7OpS2pFhWuESGzzbvYvTK3pb9h7K/+fEYYCmgRP6oUKv0
TntupXECHlfuhGpNS+OK+fP4Sr8ibg==
=rt2p
-----END PGP SIGNATURE-----

--HrhCPDHGRu0a4txmhhNYeKMbWlsYu4n8r--
