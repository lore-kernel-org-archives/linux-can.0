From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: flexcan: use of_property_read_u32 to get
 DT entry value
Date: Sat, 30 Jun 2012 14:29:30 +0200
Message-ID: <4FEEF12A.7010906@pengutronix.de>
References: <1340871695-26327-1-git-send-email-jason77.wang@gmail.com> <1340871695-26327-2-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig88062FC3F146740BDCE754E1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46943 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249Ab2F3M3j (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 30 Jun 2012 08:29:39 -0400
In-Reply-To: <1340871695-26327-2-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: wg@grandegger.com, shawn.guo@linaro.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig88062FC3F146740BDCE754E1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/28/2012 10:21 AM, Hui Wang wrote:
> of_property_read_u32() can auto handle endian problems, use this
> function can make code clean and simple.
>=20
> No need to check return value here since the following got value
> check will handle this.
>=20
> Cc: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>

Applied to linux-can-next

tnx, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig88062FC3F146740BDCE754E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/u8SoACgkQjTAFq1RaXHPC1ACglGC1rWbtjlT3UeccMpBs20Cl
qnwAoIZ6tLUk15UsvqnKQqRXlVgrmJJ9
=S4IP
-----END PGP SIGNATURE-----

--------------enig88062FC3F146740BDCE754E1--
