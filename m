From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/4] can: c_can: fix: enable CAN HW interrupts after
 napi_enable()
Date: Thu, 10 May 2012 21:16:55 +0200
Message-ID: <4FAC1427.7070708@pengutronix.de>
References: <1336649657-4152-1-git-send-email-anilkumar@ti.com> <1336649657-4152-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE47A3439AC62C2372A7EABD3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60447 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586Ab2EJTRC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 May 2012 15:17:02 -0400
In-Reply-To: <1336649657-4152-3-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE47A3439AC62C2372A7EABD3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/10/2012 01:34 PM, AnilKumar Ch wrote:
> Fix the issue of C_CAN interrupts getting disabled forever even though
> we do can configuration multiple times using can utils. According to
> NAPI usage we disable all the hardware interrupts in ISR and re-enable
> them in poll(). Current implementation calls napi_enable() after hardwa=
re
> interrupts are enabled. If we get any interrupts between these two step=
s
> then we do not process those interrupts because napi is not enabled. Mo=
stly
> these interrupts come because of STATUS is not 0x7 or ERROR interrupts.=
 If
> napi_enable() happens before hardware interrupts enabled then c_can_pol=
l()
> function will be called eventual re-enabling of interrupts will happen.=

>=20
> This patch moves the napi_enable() call before interrupts enabled.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Please test on c_can, also this is a stable candidate. What about add
the term "race condition" to the subject?

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE47A3439AC62C2372A7EABD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+sFCcACgkQjTAFq1RaXHM98gCfcdii15DcMYd2KI5zCpW/5T/E
TQoAn0qTbbfbWoYuSelrPyt4bKCbC1l2
=A0Yw
-----END PGP SIGNATURE-----

--------------enigE47A3439AC62C2372A7EABD3--
