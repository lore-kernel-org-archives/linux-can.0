From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/1] can: Avoid calling kfree_skb from interrupt context
Date: Tue, 18 Nov 2014 21:45:25 +0100
Message-ID: <546BAFE5.60405@pengutronix.de>
References: <1414737234-31132-1-git-send-email-thomas.koerper@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ev8gSbPETS9owlk1H7rqxh2dHVLCKrsAr"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60863 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbaKRUp2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Nov 2014 15:45:28 -0500
In-Reply-To: <1414737234-31132-1-git-send-email-thomas.koerper@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VGhvbWFzIEvDtnJwZXI=?= <thomas.koerper@esd.eu>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ev8gSbPETS9owlk1H7rqxh2dHVLCKrsAr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/31/2014 07:33 AM, Thomas K=C3=B6rper wrote:
> Called in can_free_echo_skb, which might be called from (TX Error) inte=
rrupt.

Applied to can/master.

Thanks, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



--ev8gSbPETS9owlk1H7rqxh2dHVLCKrsAr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa6/lAAoJECte4hHFiupUYjgQAJYQKc6Ax1R9xSBLQaRYA33F
pxAzRIoZLqjducofuezKObI4fo4LM1G2yguvcvxnXpDXlxIf31Zfjv0dhQuOLbjH
2XIa/IwbFM+Xl0J/HSgRwC7KdStubtKiUqGLRYvrMtpNWyLzxx9/kqGM62A+knpV
PpVAk9y+Pa43VCVJ+IKlIDH3EExaqY9c79COX/S9l5xziSCeuKP2K+EjfAFgAOl8
cEnj30XeHdFQBkzDYQGI9iSEWYnkp+KVj4JU5cDS7Zw2GjHE8JGKtZ14g/DuEyT/
L3wpJIikA2dpmlDcNdevTZ1oSOedTMG7u8FIlQD24rQMdyIxI7av9TOGLQ/T51CV
PU32oC6vu1tUkyIKlCvdAql2bTcMKmp8hXKbdiR5EfwWvJ1meM6RMlDyeGhQW8Jy
Z4c/fXiYCVHpndTQ1jHqaja09IW+DlrfMfMlpPIWOmGpcB967+XRQeB+urgR+dyT
p/5h0HIbT12F7zg/GpiL7uDMh7Mm6j1thvKXi4vfy0S6xEez2I1s0BuqIK3e1Nw+
RenPCokhx6YKs9u/p3SaW4nKExVp5Igl4xw7e1s+Oy16LuZNMqUyEYcyM611ZnWo
mWtK43nYiPaqlvbr2in6v1zkITdmgDCNIsXg01tiasjlm8w7qSVyOSjAsGmjaTs1
uQ0VVpo3oL+7v8f+0pT4
=gg6/
-----END PGP SIGNATURE-----

--ev8gSbPETS9owlk1H7rqxh2dHVLCKrsAr--
