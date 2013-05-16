From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: command ip -details -statistics link show wlan0
Date: Thu, 16 May 2013 15:45:16 +0200
Message-ID: <5194E2EC.2050804@pengutronix.de>
References: <CAOD0pe=EMt3+ymJMwT+gOUbFZN7_R8exkh36G5457O61GoV4UA@mail.gmail.com> <5194846B.1070307@grandegger.com> <CAOD0pekopW9g0SD=BnOMCEp3SdVZPrx5jY_CKLjZV09sWepS6A@mail.gmail.com> <CAOD0pekNvW1Vh7KkHGffNyxGh=RTe+2cHdZwO-q6VDfPV6z_dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2JNGUKHMNHVTJPLWVLDBW"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39066 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214Ab3EPNpT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 May 2013 09:45:19 -0400
In-Reply-To: <CAOD0pekNvW1Vh7KkHGffNyxGh=RTe+2cHdZwO-q6VDfPV6z_dQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ernast Sevo <ersevs@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2JNGUKHMNHVTJPLWVLDBW
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/16/2013 03:43 PM, Ernast Sevo wrote:
> That definitely clears things up a bit. One more question though. Does
> the number in
> overrun or the number in errors from the command above then directly
> refer to the number
> of packets lost on the hardware level due to there being no space to
> store it (i.e 11 overrun or
> errors means 11 packets lost) ?

This depends on the hardware/driver. But usually that means 11 overrun
events, which means _at_least_ 11 CAN frames lost.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2JNGUKHMNHVTJPLWVLDBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGU4uwACgkQjTAFq1RaXHPM+QCeKkuRLc16F3s/1fLvtn43Ipya
noUAn3UC2PEr5vMiJAr+dg6mkKqaFtY0
=GVXl
-----END PGP SIGNATURE-----

------enig2JNGUKHMNHVTJPLWVLDBW--
