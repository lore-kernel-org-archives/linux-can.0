From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/4] can: flexcan: add ipg and ser clocks support
Date: Wed, 27 Jun 2012 10:45:21 +0200
Message-ID: <4FEAC821.4070604@pengutronix.de>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com> <1340785161-3598-2-git-send-email-jason77.wang@gmail.com> <1340785161-3598-3-git-send-email-jason77.wang@gmail.com> <1340785161-3598-4-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF7FCBC6B9E4AB5E732E7ABB1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44510 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab2F0Ipf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 04:45:35 -0400
In-Reply-To: <1340785161-3598-4-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: davem@davemloft.net, shawn.guo@linaro.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF7FCBC6B9E4AB5E732E7ABB1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/27/2012 10:19 AM, Hui Wang wrote:
> Some i.MX chip (like i.MX6) has two clocks to drive flexcan module,
> one is ipg clock, another is serial clock, if we want the flexcan
> to work, we need to enable both two clocks, but current driver only
> support one clock.
>=20
> My modification doesn't break existing platforms. For those without
> clocks (like powerpc platforms), two clk pointers are set to NULL as
> before, for those only have one clock (like i.MX25 and i.MX35), the
> second clk pointer is set to NULL.

Looks good at the first sight. Will test on hardware later.

Tnx, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF7FCBC6B9E4AB5E732E7ABB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/qyCEACgkQjTAFq1RaXHO1OACeNZZauU1XmytbDVcpP14TgMvD
Cw8An1WRY91P+nhITBQSl/fvr4QotcgF
=Tfeg
-----END PGP SIGNATURE-----

--------------enigF7FCBC6B9E4AB5E732E7ABB1--
