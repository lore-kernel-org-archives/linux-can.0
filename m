From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Thu, 06 Dec 2012 09:35:47 +0100
Message-ID: <50C058E3.7090207@pengutronix.de>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <2955657.EIGT0HjrVV@ws-stein> <50BF4326.4040507@grandegger.com> <4250988.UdN8LQq6de@ws-stein> <50BF85DD.6090809@grandegger.com> <50BFC226.5030609@pengutronix.de> <50C044A2.6040304@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig20E56E9BA471EEC172A4246B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43922 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab2LFIfz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 03:35:55 -0500
In-Reply-To: <50C044A2.6040304@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig20E56E9BA471EEC172A4246B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/06/2012 08:09 AM, Wolfgang Grandegger wrote:
>>> That's wired! Writing 0xe to offset 0x0 does re-enable the interrupts=
 at
>>> the end of poll-rx. Disabling the interrupts in the isr does not show=

>>> that symptoms. Strange.
>>
>> The write+read check is racy. The interrupt handler might disable the
>> interrupts again.
>=20
> Ah, yes, of course. Nothing to worry about then. Sorry for the noise.

However we can add a spinlock around the write+read and the read
function itself for debugging purpose.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig20E56E9BA471EEC172A4246B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDAWOcACgkQjTAFq1RaXHPSjACfYZvU2jccResxUedzO4BeuGxr
mfEAn3I6bXG9SXRkG5LJuQccqeMu4is+
=/vYL
-----END PGP SIGNATURE-----

--------------enig20E56E9BA471EEC172A4246B--
