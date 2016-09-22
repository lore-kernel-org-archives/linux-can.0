From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/1] can: fix deadlock reported after bus-off
Date: Thu, 22 Sep 2016 10:02:53 +0200
Message-ID: <26ba9ddb-48f8-0c60-e971-305be23a2e02@pengutronix.de>
References: <1473256272-30283-1-git-send-email-sergeimir@emcraft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="sFBpe5TvUI39iidFPkgWe9jvld0m6lh7J"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33458 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751455AbcIVIDL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Sep 2016 04:03:11 -0400
In-Reply-To: <1473256272-30283-1-git-send-email-sergeimir@emcraft.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sergei Miroshnichenko <sergeimir@emcraft.com>, linux-can@vger.kernel.org
Cc: Alexander Dyachenko <sasha_d@emcraft.com>, Stefano Babic <sbabic@denx.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sFBpe5TvUI39iidFPkgWe9jvld0m6lh7J
Content-Type: multipart/mixed; boundary="3Kk9jvSUFM0I8iwSgcO19QsQ8qoelgKrP";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sergei Miroshnichenko <sergeimir@emcraft.com>, linux-can@vger.kernel.org
Cc: Alexander Dyachenko <sasha_d@emcraft.com>, Stefano Babic <sbabic@denx.de>
Message-ID: <26ba9ddb-48f8-0c60-e971-305be23a2e02@pengutronix.de>
Subject: Re: [PATCH 1/1] can: fix deadlock reported after bus-off
References: <1473256272-30283-1-git-send-email-sergeimir@emcraft.com>
In-Reply-To: <1473256272-30283-1-git-send-email-sergeimir@emcraft.com>

--3Kk9jvSUFM0I8iwSgcO19QsQ8qoelgKrP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/07/2016 03:51 PM, Sergei Miroshnichenko wrote:
> A timer was used to restart after the bus-off state, leading to a
> relatively large can_restart() executed in an interrupt context,
> which in turn sets up pinctrl. When this happens during system boot,
> there is a high probability of grabbing the pinctrl_list_mutex,
> which is locked already by the probe() of other device, making the
> kernel suspect a deadlock condition [1].
>=20
> To resolve this issue, the restart_timer is replaced by a delayed
> work.
>=20
> [1] https://github.com/victronenergy/venus/issues/24
>=20
> Signed-off-by: Sergei Miroshnichenko <sergeimir@emcraft.com>

Applied to can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--3Kk9jvSUFM0I8iwSgcO19QsQ8qoelgKrP--

--sFBpe5TvUI39iidFPkgWe9jvld0m6lh7J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX45AtAAoJED07qiWsqSVqJ6YH/3Xu5RWzKteswFyNoR5VQ3e0
K0MjkAGcJRoGZwgTQ8IPpbDKNtCWoKaRo8rPRltPEN/LfKlXLUJXOJcBliFNu+Xb
AA1eJprkDXDzMpo+fn1gU3cLkrlYY/3J9qQFynR2BakCa2rqgtwMPJkI57Ijtnn8
8sjkMxTWqCYLuxx7guHqpkNNOZTTx8SH07FqaJsZR0bqwmnaKbjkDTyjeoObhT+l
Pbx35MtgQL8hFcFqOQ/ugv9ZGox7TVUyWk+5e/KaSkSLqedH5BAFME8BLqjFFBUN
cD1Xd91t0PDmIdOZDxFL4EiAR2JBBmK15S9ZCZQPhWiz2WJrLOCaZPL0z6JFhZ0=
=ZX2d
-----END PGP SIGNATURE-----

--sFBpe5TvUI39iidFPkgWe9jvld0m6lh7J--
