From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can + ARM i.MX53: use 24 MHz clock parent on i.MX53
Date: Tue, 26 Nov 2013 15:35:35 +0100
Message-ID: <5294B1B7.4030006@pengutronix.de>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de> <20131126045340.GJ30476@S2101-09.ap.freescale.net> <52945B40.5020200@pengutronix.de> <20131126143258.GA5685@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="36l7DlQlwtbI5kDcCuMaAUskwbClv6qwP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49251 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab3KZOfr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 26 Nov 2013 09:35:47 -0500
In-Reply-To: <20131126143258.GA5685@S2101-09.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: kernel@pengutronix.de, lst@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--36l7DlQlwtbI5kDcCuMaAUskwbClv6qwP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/26/2013 03:33 PM, Shawn Guo wrote:
> On Tue, Nov 26, 2013 at 09:26:40AM +0100, Marc Kleine-Budde wrote:
>> The problem is, that the wrong clock is being used. An all i.mx, but n=
ot
>> on imx6, both clocks are the same, the bug doesn't show up. So before =
we
>> can use the 24 MHz clock on mx53, we have to fix the driver.
>=20
> So it sounds like a more appropriate merging path would be that,
> you send the driver fix right away to mainline via net tree with
> v3.13-rc series, and I rebase IMX tree on the -rc that has the fix,
> and then apply the DTS patch.
                     ^^^

Clocktree not Devicetree :)

Okay, fine with me.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--36l7DlQlwtbI5kDcCuMaAUskwbClv6qwP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKUsbcACgkQjTAFq1RaXHOJYgCdHRuu3Gm9bzUYWakOp4z+TBgY
iKoAn2d5uPI8PTnkovPZQplYHxNdEGoR
=ztfj
-----END PGP SIGNATURE-----

--36l7DlQlwtbI5kDcCuMaAUskwbClv6qwP--
