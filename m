From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can-utils] J1939 v6 (#7)
Date: Mon, 28 Sep 2015 08:53:31 +0200
Message-ID: <5608E3EB.5090308@pengutronix.de>
References: <linux-can/can-utils/pull/7@github.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dQW7sJIjok8MWarSgok7aJ21cUU0AuKVN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45513 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513AbbI1Gxq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Sep 2015 02:53:46 -0400
In-Reply-To: <linux-can/can-utils/pull/7@github.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: reply+001c342fd7b1455c991eb49342cd421d7317d7ea6ef9754c92cf00000001121c121c92a169ce0672fa57@reply.github.com, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dQW7sJIjok8MWarSgok7aJ21cUU0AuKVN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Mikey and Kurt,

On 09/24/2015 09:33 PM, mikey32905 wrote:
>         You can view, comment on, or merge this pull request online at:=

>=20
>   https://github.com/linux-can/can-utils/pull/7
>=20
>=20
>         Commit Summary
>=20
>   * can-j1939: add libj1939.a
>   * can-j1939: add jspy 'sniffer' program
>   * can-j1939: add jsr program
>   * can-j1939: update headers with j1939
>   * can-j1939: add jacd address claim daemon

Kurt, I got this pull request of the j1939 tools from Mikey. What's the
status of the j1939, can we add it to the can-utils? Is the userspace
API stable?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--dQW7sJIjok8MWarSgok7aJ21cUU0AuKVN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWCOPrAAoJEP5prqPJtc/H/vwH/096p7KYtkKKjNof47C1X0Lv
EPd40PcQ8yEokQNVY70MSFN3relAHdqhFGZnJxcPeH8mdxQZcWhaF4N2+Ll+xgif
AwzfhfWNQc3L/VuWcuG6XZ5FXjfqi8ZEITZKQdZcePsplKNfqpyEW+yRiPfCO20s
fXGLJFo0DXEirn3RzyNA+cY3su5ElJBBItHj8p95MQKmYDIIZkF4DmPVima/GmF8
yYBkGcWqE25XFqh975cdtlXfk60YnptNVgFQnkGzzV1tAl87pqZBnlaCNamlRsjf
OnwbJS2CLs+jT4G5mJwaH77N6hJ/HsS3Y3h+QSPplLg2v8VIVaEMAOr5KYi/7mw=
=h+RK
-----END PGP SIGNATURE-----

--dQW7sJIjok8MWarSgok7aJ21cUU0AuKVN--
