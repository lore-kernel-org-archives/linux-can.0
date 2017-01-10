From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
Date: Tue, 10 Jan 2017 11:33:37 +0100
Message-ID: <14f11375-b53e-d839-81f7-469cec1d9547@pengutronix.de>
References: <20170106125344.15267-1-mkl@pengutronix.de>
 <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
 <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de>
 <588eacb5-c565-34bf-fed7-89bd46755819@hartkopp.net>
 <41946abf-548d-ba21-3da6-f3398905f932@pengutronix.de>
 <CAKT-o-dT5ZR9J+zwJuGZELg3=ssQ7GcuGzr7P5ATYX8rWa_YKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ITmaFBo8cQWrRs2l6uEhhf98xjFR7aNDP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41267 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935354AbdAJKds (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2017 05:33:48 -0500
In-Reply-To: <CAKT-o-dT5ZR9J+zwJuGZELg3=ssQ7GcuGzr7P5ATYX8rWa_YKQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ITmaFBo8cQWrRs2l6uEhhf98xjFR7aNDP
Content-Type: multipart/mixed; boundary="ufXNnTfA6jNpA9hkWixHvHCULI1P8R56U";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
 <remigiusz.kollataj@mobica.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <14f11375-b53e-d839-81f7-469cec1d9547@pengutronix.de>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
References: <20170106125344.15267-1-mkl@pengutronix.de>
 <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
 <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de>
 <588eacb5-c565-34bf-fed7-89bd46755819@hartkopp.net>
 <41946abf-548d-ba21-3da6-f3398905f932@pengutronix.de>
 <CAKT-o-dT5ZR9J+zwJuGZELg3=ssQ7GcuGzr7P5ATYX8rWa_YKQ@mail.gmail.com>
In-Reply-To: <CAKT-o-dT5ZR9J+zwJuGZELg3=ssQ7GcuGzr7P5ATYX8rWa_YKQ@mail.gmail.com>

--ufXNnTfA6jNpA9hkWixHvHCULI1P8R56U
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2017 11:18 AM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
> Hi,
>=20
> I can see three major problems with setting up predefined bitrates:
> 1. I think that there is no way to pass supported bitrates to
> userspace (other than printk)

yes

> 2. The bitrate that is passed to the driver is calculated/validated by
> can_get_bittiming. This causes that driver not always get exact value
> that was input by a user.

Have you seen my patch?

> 3. When CAN device is using predefined bitrates you do not have
> influence or even access to bittiming parameters. As you noticed I had
> to hardcode those values in mcba_usb to present them correctly to
> userspace.

With my patch, there's no need to set bittiming_const anymore.

> Based on solution created by Oliver for termination I created
> something similar for predefined bitrates. It solves issue number 1
> and 2. Not sure how to solve issue 3 correctly to maintain
> compatibility (adding another netlink value for predefined bitrate
> will break it). As for now I just zeroed values.
>=20
> The patch is just to visualise my idea. It definitely needs some more w=
ork.
>=20
> Inside the driver:
> const u32 predef_bitrate[] =3D {20000, 50000, 100000};
>=20
> priv->bitrate_const =3D predef_bitrate;
> priv->bitrate_const_cnt =3D ARRAY_SIZE(predef_bitrate);

The general idea makes sense, although we need support for CANFD, too.
Let's first agree on Oliver's and my patch, then yours will fit in easily=
=2E

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ufXNnTfA6jNpA9hkWixHvHCULI1P8R56U--

--ITmaFBo8cQWrRs2l6uEhhf98xjFR7aNDP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlh0uIEACgkQPTuqJayp
JWoLUQf40Zqkh2f9d5VZiJgqt0B+ezaYlZWz3VSeso/t45hY9Sq8trnIt14+bjnK
DUuJ5hxPhN0ppaYwHzLY8Psk2kb27a8OH8QCLjkqvfxbX/dJN+yfJrSug+q0vJrB
OUC/mNoQj1ga5FteN+8slOJVe7stPRgTiYyfeNgL7o97J86h5ONbN3F4hDXp0JGV
8rugXNJ73Dmhqf5IWPIOVhE40y8q/4ntK6AG7/goDywn2tpgHBo9w8YEN4VnwyE6
mZ2dsOkD5KNTOFKAwNa8PAddfg/TGXpdbWhLtHi3vUGnG+VWcx/RDKY18fHs4YxM
MghhjpG1LsOZedVOd6Ub98j4lLjh
=vOi2
-----END PGP SIGNATURE-----

--ITmaFBo8cQWrRs2l6uEhhf98xjFR7aNDP--
