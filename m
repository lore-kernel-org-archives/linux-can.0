From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Fri, 07 Dec 2012 00:34:15 +0100
Message-ID: <50C12B77.1060501@pengutronix.de>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <4036287.fuKZ6k5idx@ws-stein> <50C0AC38.8080405@grandegger.com> <9545085.epYbjMqEeA@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig07D12E45EE91A09D76C316C5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47332 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156Ab2LFXeT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 18:34:19 -0500
In-Reply-To: <9545085.epYbjMqEeA@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07D12E45EE91A09D76C316C5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/06/2012 06:14 PM, Alexander Stein wrote:
>> This is a typical out-of-sequence reception with a=20
>> RX-goes-into-first-free-mailbox hardware. I've implemented the
>> algorithm used in the at91 and fixed the one for the ti_hecc.
>=20
> Marc, do you mean out-of-sequence reception with such mailbox types
> can happen even with the algorithm used in c_can and at91?

It can happen, if the algorithm isn't implemented properly and adopted
to the needs of the hardware. On the unmodified ti_hecc we see this
out-of-sequence problems, too.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig07D12E45EE91A09D76C316C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDBK3cACgkQjTAFq1RaXHMxOwCfeeKj76qCh+8L962Dlmvfo54R
IvwAnAgHvT4dkjmFaAhkrFMJIpX9oDQ5
=Nyfx
-----END PGP SIGNATURE-----

--------------enig07D12E45EE91A09D76C316C5--
