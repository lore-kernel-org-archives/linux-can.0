From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 09/15] net: can: Convert to use devm_ioremap_resource
Date: Mon, 10 Jun 2013 15:09:27 +0200
Message-ID: <51B5D007.8050005@pengutronix.de>
References: <1370864113-17895-1-git-send-email-tushar.behera@linaro.org> <1370864113-17895-10-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2HOPDDRMHMUDPMUODDQBC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50659 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab3FJNJk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 09:09:40 -0400
In-Reply-To: <1370864113-17895-10-git-send-email-tushar.behera@linaro.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-kernel@vger.kernel.org, thierry.reding@gmail.com, patches@linaro.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2HOPDDRMHMUDPMUODDQBC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/10/2013 01:35 PM, Tushar Behera wrote:
> Commit 75096579c3ac ("lib: devres: Introduce devm_ioremap_resource()")
> introduced devm_ioremap_resource() and deprecated the use of
> devm_request_and_ioremap().

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Are the patches going over the individual subsystem maintainers?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2HOPDDRMHMUDPMUODDQBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlG10A0ACgkQjTAFq1RaXHOgrgCfc5EAxsxXoVlmBUx8FsblfoWg
oYQAn3dbgReZJpqQR7ynY5UYUwNzoot5
=z0Sn
-----END PGP SIGNATURE-----

------enig2HOPDDRMHMUDPMUODDQBC--
