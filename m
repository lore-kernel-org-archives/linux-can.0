From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: dev: fix crtlmode_supported check
Date: Wed, 28 Jan 2015 09:25:30 +0100
Message-ID: <54C89CFA.7080606@pengutronix.de>
References: <1422385920-29763-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iNsiCWmwvonPSVDbHrcpfaxFEBHpbTBk0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48458 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359AbbA1UQx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Jan 2015 15:16:53 -0500
In-Reply-To: <1422385920-29763-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iNsiCWmwvonPSVDbHrcpfaxFEBHpbTBk0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/27/2015 08:12 PM, Oliver Hartkopp wrote:
> When changing flags in the CAN drivers ctrlmode the provided new conten=
t has to
> be checked whether the bits are allowed to be changed. The bits that ar=
e to be
> changed are given as a bitfield in cm->mask. Therefore checking against=

> cm->flags is wrong as the content can hold any kind of values.
>=20
> The iproute2 tool sets the bits in cm->mask and cm->flags depending on =
the
> detected command line options. To be robust against bogus user space
> applications additionally sanitize the provided flags with the provided=
 mask.
>=20
> (Backport of upstream commit 9b1087aa5e86448fe6ad40a58964e35f3ba423d5 f=
or
> Linux 3.2 .. Linux 3.14)

Zefan Li <lizefan@huawei.com> is taking care of v3.4

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iNsiCWmwvonPSVDbHrcpfaxFEBHpbTBk0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUyJz9AAoJECte4hHFiupUbm8QAKu5KXfwBfsjA1lOtJxHgw9R
cuWVMUYd/z3WcW9vDQ7Sw/4LOYbTpjbS1d1Erq+KuJZBYC/l5RZeILWsb0ajWloJ
cy/r1/K/Xvy2GRIdm1wfL6W/bNsru7qyLqWY51sMh5jWybIvyBs9BKJVNSMsuROY
Syk741ku5BfAoACFwLILfiRctZUHuvyfFJm4ILHhQo8WUDy7+S7W+dA1HI+TH1L6
eNaZ41ndoG7V5KoVMIvNmRHcDvUkPWffS/IELunFKdyU4nNWjV6eLglfRLW+x0x0
Z0v6bJGKpwhOWINPio61p0Swsi8i7xacBM/UOtuncxnQ1rTlMiOiSbFzpHR70/X0
a+YY8QwyXqFSvgOmnWVl0fxTc5lP4WInZxDZ2iq20AZUPluKFJatW1xAm39ebOfv
ADs6ATxtEOXj+2q/3+g7dw2YdSWFv76YRouaCtM8aCC7Hogo4aGtFZHiLj/pV7Pc
iDK1f517y0BUFYqqXpL/xe1Gx2jqoe4zH7Ikgf8UaC5vO9RHhulmjAR+aFOzjLXz
e3cFwAx2eGATfV6PWMH4RZ/ntihzWjoLpDGAe3FxAG3Cu9FThXUG3JN76sJxCKG8
d91cZMt6tdQMoRVKgVmP6BIGRlKadd96GqILSTPDrtM9onLrXDPmQ674EpVgm7C5
CEbV1ltG6je6hqgXZg3I
=VTLH
-----END PGP SIGNATURE-----

--iNsiCWmwvonPSVDbHrcpfaxFEBHpbTBk0--
