From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: improve error message
Date: Tue, 3 Jan 2017 15:26:25 +0100
Message-ID: <40c163f0-9d41-6811-40f7-a58dea6454ea@pengutronix.de>
References: <1482941561-28094-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pmpqnuWwmk6qveNl1iS4H0il2OiCmd8K9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59485 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755730AbdACO1D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Jan 2017 09:27:03 -0500
In-Reply-To: <1482941561-28094-1-git-send-email-festevam@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pmpqnuWwmk6qveNl1iS4H0il2OiCmd8K9
Content-Type: multipart/mixed; boundary="XbB1PFKeqIxhDgOJS47gIIFwQxVgFjC4l";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Message-ID: <40c163f0-9d41-6811-40f7-a58dea6454ea@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: improve error message
References: <1482941561-28094-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1482941561-28094-1-git-send-email-festevam@gmail.com>

--XbB1PFKeqIxhDgOJS47gIIFwQxVgFjC4l
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/28/2016 05:12 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>=20
> When register_flexcandev() fails it is better to mention 'flexcandev'
> in the error message for better clarity.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Added to can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--XbB1PFKeqIxhDgOJS47gIIFwQxVgFjC4l--

--pmpqnuWwmk6qveNl1iS4H0il2OiCmd8K9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhrtJEACgkQPTuqJayp
JWpmBgf/ditRASVOPS2fzzZSHaiMeqLLBqlw0h4QbXMNdcigTxNmaCI4Euvte3FI
HdQ8dTP/Qxyy0F/G32on/h2sbDcEMB+bnr5mUT6dd6iGRZC9Y+aRLo51/KIrxgQd
NNY8YLlT84NQBjNNR+RUVuYNmPYReP3lH+KgvfY/i+H5WKTwOx+GaD69Gwk/aeZz
Ek87ePQbKwgH7klVGNqYl/0kTgWvuDBsOH9jukFs8JgguGrWAIyxaVEPO5HknDen
KDc+i7hg+TU5S4kOOgJWPoEPSmhCfuTaTNYpUHzKCyl+tsqzegRzgZv1cIIiepia
/lagGi+HEUkKqjw0+7Km0SlxLolhLA==
=uuJb
-----END PGP SIGNATURE-----

--pmpqnuWwmk6qveNl1iS4H0il2OiCmd8K9--
