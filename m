From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: flexcan.c: Implement last step of workaround
 for errata ERR005829
Date: Tue, 02 Sep 2014 13:28:55 +0200
Message-ID: <5405A9F7.5090004@pengutronix.de>
References: <1409133487-23367-1-git-send-email-david@protonic.nl> <1409133487-23367-4-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="iTpDtq48GtGn6bwKSSfW9fcQO90utiIgT"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36533 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaIBL3F (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 07:29:05 -0400
In-Reply-To: <1409133487-23367-4-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, wg@grandegger.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iTpDtq48GtGn6bwKSSfW9fcQO90utiIgT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/27/2014 11:58 AM, David Jander wrote:
> It is not clear if this errata only applies to i.MX6, but the impact of=

> the workaround should be minimal. Basically it comes down to reserving
> mailbox 0 as a permanently inactive MB and writing twice to its C/S fie=
ld
> on every message transmit.
>=20
> Signed-off-by: David Jander <david@protonic.nl>

Please fix this errata in one patch exactly. Please fix the errata
before introducing a new feature, i.e. rewriting of the RX path.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iTpDtq48GtGn6bwKSSfW9fcQO90utiIgT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQFqfcACgkQjTAFq1RaXHOaQQCfdd4GdeZoy0i/0BaieIczduLR
mxwAoIX7CkdFW5emeNMrpxxEeevLbVA2
=Fx5s
-----END PGP SIGNATURE-----

--iTpDtq48GtGn6bwKSSfW9fcQO90utiIgT--
