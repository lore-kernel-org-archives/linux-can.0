From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: fix oops caused by wrong rtnl dellink usage
Date: Wed, 22 Jun 2016 22:43:12 +0200
Message-ID: <3c001239-0c69-65e2-dca3-20c5c4e86017@pengutronix.de>
References: <1466516747-5192-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="x0HcfNk5Uo61oA4NxKLxHVCMAjHIuDa0c"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36130 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751123AbcFVUnT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jun 2016 16:43:19 -0400
In-Reply-To: <1466516747-5192-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x0HcfNk5Uo61oA4NxKLxHVCMAjHIuDa0c
Content-Type: multipart/mixed; boundary="LIhNGdWS1k1LfU5w4nPmvRsMHbuPFirge"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <3c001239-0c69-65e2-dca3-20c5c4e86017@pengutronix.de>
Subject: Re: [PATCH] can: fix oops caused by wrong rtnl dellink usage
References: <1466516747-5192-1-git-send-email-socketcan@hartkopp.net>
In-Reply-To: <1466516747-5192-1-git-send-email-socketcan@hartkopp.net>

--LIhNGdWS1k1LfU5w4nPmvRsMHbuPFirge
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/21/2016 03:45 PM, Oliver Hartkopp wrote:
> For 'real' hardware CAN devices the netlink interface is used to set CA=
N
> specific communication parameters. Real CAN hardware can not be created=
 nor
> removed with the ip tool ...
>=20
> This patch adds a private dellink function for the CAN device driver in=
terface
> that does just nothing.
>=20
> It's a follow up to commit 993e6f2fd ("can: fix oops caused by wrong rt=
nl
> newlink usage") but for dellink.
>=20
> Reported-by: ajneu <ajneu1@gmail.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to can + stable on Cc.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--LIhNGdWS1k1LfU5w4nPmvRsMHbuPFirge--

--x0HcfNk5Uo61oA4NxKLxHVCMAjHIuDa0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXavhgAAoJED07qiWsqSVq0QQIAKLMjJ0NaaxS/of3CuifKyWM
H8Isiyk81ZK8AunkAsqcCcl4fGUP9DOog/5Xxp+KEpqlrqN51Sj334MPeECyJOkP
atkRmTKlvQd8ttNAI2ywEI4phuMjSpNcKMbfy0nHUe9CVdSMYqXES29G2GdEJHzv
6KXnX901FzY81ogWXidbPQYQLY9216FlqHxa6dGOf62L1cHVi7ImTJo5RK8Jldmm
QTNz1dR87O6WVdF5KCVcBdwib/E/4YvHZiozTzsKXlGjtZdCQJyRSiU5iuHAbZBp
WHI4MUuFcFmpclYW7OyW5ApRCA7fILY+k05gVimvuAzLjXbu1uvAywttZgfB2cg=
=OJBd
-----END PGP SIGNATURE-----

--x0HcfNk5Uo61oA4NxKLxHVCMAjHIuDa0c--
