From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: flexcan.c: Correctly initialize mailboxes
Date: Tue, 02 Sep 2014 12:24:28 +0200
Message-ID: <54059ADC.60309@pengutronix.de>
References: <1409133487-23367-1-git-send-email-david@protonic.nl> <1409133487-23367-2-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KDWOGsOqoMp8o3NqaLpTAG0TsEfWFvSgs"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45680 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbaIBKYl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 06:24:41 -0400
In-Reply-To: <1409133487-23367-2-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, wg@grandegger.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KDWOGsOqoMp8o3NqaLpTAG0TsEfWFvSgs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/27/2014 11:58 AM, David Jander wrote:
> Apparently mailboxes may contain random data at startup, causing some o=
f
> them being prepared for message reception. This causes overruns being
> missed or even confusing the IRQ check for trasmitted messages, increas=
ing
> the transmit counter instead of the error counter.
>=20
> Signed-off-by: David Jander <david@protonic.nl>

Before patch

0d1862e can: flexcan: fix flexcan_chip_start() on imx6

there was a loop clearing the whole cantxfg register space. But this
turned out to be bogus, as message buffers 1...7 are reserved by the
FIFO engine and we're not allowed to tough them. This lead to some kind
of abort on imx6.

You may need this patch once you don't make use of the FIFO engine any mo=
re.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--KDWOGsOqoMp8o3NqaLpTAG0TsEfWFvSgs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQFmtwACgkQjTAFq1RaXHMoIQCeLNQJRweI07brynd3MPnXN/uc
kowAnjVZRyDMRnLAKBQ7pQD7VA32nA+L
=wt7/
-----END PGP SIGNATURE-----

--KDWOGsOqoMp8o3NqaLpTAG0TsEfWFvSgs--
