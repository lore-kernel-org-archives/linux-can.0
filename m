From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Usb to can driver
Date: Tue, 23 Apr 2013 23:47:13 +0200
Message-ID: <51770161.2030005@pengutronix.de>
References: <1366737302.3325.36.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2HIOMTHBRJVEMKWUVBVSO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37909 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab3DWVrW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Apr 2013 17:47:22 -0400
In-Reply-To: <1366737302.3325.36.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2HIOMTHBRJVEMKWUVBVSO
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello Max,

On 04/23/2013 07:15 PM, Max S. wrote:
> I've been working on a device and a Linux socket can driver for it.
>=20
> Its a dual USB to CAN adapter in two variants external USB device with
> cable, or a mini pci form factor expansion card.
>=20
> This is my first Linux driver, and I'd like to have someone look at it.=

> Feel free to criticize. I have not done any massive testing, but am abl=
e
> to send and receive frames at 250k +full echo :). Higher speeds should
> easily be possible, but i have not tested.

Please use "./scripts/checkpatch.pl" from the kernel and fix all coding
style errors. The compile your code with "make C=3D1", fix all errors.
Then repost :).

Can you explain how the "struct device_config" works.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2HIOMTHBRJVEMKWUVBVSO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF3AWUACgkQjTAFq1RaXHPxDgCfYtxQXozZAg5vPwxeWeVOsseq
V0YAn389UmsHrDEyaCr+NsmOmKYvSZal
=Z5Kp
-----END PGP SIGNATURE-----

------enig2HIOMTHBRJVEMKWUVBVSO--
