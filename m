From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3.6-rc1] canfd: remove redundant CAN FD flag
Date: Tue, 07 Aug 2012 10:16:55 +0200
Message-ID: <5020CEF7.9080809@pengutronix.de>
References: <501FEA95.3060906@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig34739C89DD486EDF94BF1A8E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55236 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab2HGIRC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Aug 2012 04:17:02 -0400
In-Reply-To: <501FEA95.3060906@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig34739C89DD486EDF94BF1A8E
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/06/2012 06:02 PM, Oliver Hartkopp wrote:
> The first idea of the CAN FD implementation started with a new struct
> canfd_frame to be used for both CAN FD frames and legacy CAN frames.
> The now mainlined implementation supports both CAN frame types simultan=
eously
> and distinguishes them only by their required sizes: CAN_MTU and CANFD_=
MTU.
>=20
> Only the struct canfd_frame contains a flags element which is needed fo=
r the
> additional CAN FD information. As CAN FD implicitly means that the 'Ext=
ened
> Data Length' mode is enabled the formerly defined CANFD_EDL bit became
> redundant and also confusing as an unset bit would be an error and woul=
d
> always need to be tested.
>=20
> This patch removes the obsolete CANFD_EDL bit and clarifies the documen=
tation
> for the use of struct canfd_frame and the CAN FD relevant flags.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> ---
>=20
> Hello Marc,
>=20
> when thinking about the extension of the can-utils to support the handl=
ing of
> CAN FD specific flags in logfiles and console output i stumbled upon an=

> implementation artifact i would like to fix before 3.6 is released.
>=20
> The former flags definition turned out to be hard to use and is redunda=
nt in
> the case of the CANFD_EDL flag.
>=20
> Do you want to take that patch in your linux-can tree to be pulled for =
3.6-rc2
> or should i send it to Dave/netdev-ML directly?
> The patch is based on Linus' 3.6-rc1 tree.

I'll take the patch. As I'm the single point of contact, David will
probably refuse to take it directly from you. I hope no one will blame
us hard for modifying the ABI of the kernel for canfd frames. However I
think it's okay as there are probably no users of the canfd frame out the=
re.

BTW: warning: 1 line adds whitespace errors.
I've fixed this.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig34739C89DD486EDF94BF1A8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAgzvwACgkQjTAFq1RaXHP3hwCgim0ZxgRdyvSe0734pA42+Srt
Q44AmgNJ6D3IU6Djt3caF6l7SgSP6dj5
=EQRF
-----END PGP SIGNATURE-----

--------------enig34739C89DD486EDF94BF1A8E--
