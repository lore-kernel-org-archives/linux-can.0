From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: j1939: bind() and connect()
Date: Mon, 14 Aug 2017 19:37:33 +0200
Message-ID: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QjfKCS8aR3qIKRWJo6vDH9VNGnjvUD3N1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52933 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751427AbdHNRhq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Aug 2017 13:37:46 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QjfKCS8aR3qIKRWJo6vDH9VNGnjvUD3N1
Content-Type: multipart/mixed; boundary="M5Vtp29NGIspN3UX3Da5vwSmaT2HPjSft";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
 linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>
Message-ID: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
Subject: j1939: bind() and connect()

--M5Vtp29NGIspN3UX3Da5vwSmaT2HPjSft
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello Kurt,

I've a few questions about the j1939 socket model:

- Should bind() be allowed to any interface, i.e. with can_ifindex =3D=3D=
 0?

I don't think so, but it's never checked for this.

- Should a connect() without a previous bind() be allowed?

It's not checked for, but the error handling in sk_connect doesn't take
that into account.

- Should a second bind() be allowed on a previously bind() socket?

As far as I understand the code, there's some support, but when the
interface is switched, j1939_ifindex_stop() is not called.

- Should a second conect() be allowed on a previously connect() socket?

Again some code, but AFAICS no real support.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--M5Vtp29NGIspN3UX3Da5vwSmaT2HPjSft--

--QjfKCS8aR3qIKRWJo6vDH9VNGnjvUD3N1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmR390ACgkQHv7KIOw4
HPY7lQf9Gtz3wrZtdHfBVmSHeB1Xi4W5tag24PTB3SG2RXzdRTlqPXHzvpgLXCIz
AAHnA1px7+5koV+dVH+qqQyWS5NUHIUqduHJ19/aKLf3Eu8aLFR745fbWtvYDrMY
An63LY52s1gxJTJU+QANHlSonoHqB12f1JSBoYr4LXYpndrJ7rhOHdvNTvdFrDb8
KaXeEaymr832Fgbbi0jy4qfWnd5faSzIqzKV5jTgRjyePXlEaoLowtx4wTQlN2Yl
7xLSwAY3DgiPH6MVDinsEBMor7PTKFlrFSWmakThPvPNoWN9iHUuMS1qGTZAwkwn
Tb/xODFNktBbTSbBpaCDAdc/DlABzg==
=/v4x
-----END PGP SIGNATURE-----

--QjfKCS8aR3qIKRWJo6vDH9VNGnjvUD3N1--
