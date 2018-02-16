From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 1/2] can: kvaser_usb: Simplify struct
 kvaser_msg_cardinfo
Date: Fri, 16 Feb 2018 15:20:23 +0100
Message-ID: <92aa2d7a-875e-322f-b1b9-b1a1a1c139d2@pengutronix.de>
References: <20180216134107.9096-1-jimmyassarsson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="610ebvbNEkTLlpDqgTfgwpx3Ym55DTqvm"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56333 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034156AbeBPOVK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 09:21:10 -0500
In-Reply-To: <20180216134107.9096-1-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--610ebvbNEkTLlpDqgTfgwpx3Ym55DTqvm
Content-Type: multipart/mixed; boundary="7ikl2Sczp0iFAdVrGTlRFp5e4tacrR7pk";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org
Message-ID: <92aa2d7a-875e-322f-b1b9-b1a1a1c139d2@pengutronix.de>
Subject: Re: [PATCH v4 1/2] can: kvaser_usb: Simplify struct
 kvaser_msg_cardinfo
References: <20180216134107.9096-1-jimmyassarsson@gmail.com>
In-Reply-To: <20180216134107.9096-1-jimmyassarsson@gmail.com>

--7ikl2Sczp0iFAdVrGTlRFp5e4tacrR7pk
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/16/2018 02:41 PM, Jimmy Assarsson wrote:
> serial_number_high can be removed from the struct since it is never use=
d in
> the USBcan II firmware.
>=20
> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>

Applied to can.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7ikl2Sczp0iFAdVrGTlRFp5e4tacrR7pk--

--610ebvbNEkTLlpDqgTfgwpx3Ym55DTqvm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqG6KcACgkQk9IU1zQo
ZfFMsAgApMwOBb3sY6yhEpZvdQxK0QjU77rqZ9paOUozA/W6edGPTvS8Fs3CF7uY
D9pYJaikAyIvyLfUhDwKnWX2otJLa85nzeoA4tRoDtCht0L6iPOeI+GYj93dA+r0
XmLAOEoY5ZAn9lLVbocOlvjHF5O/lKZOt4hSLtMr1nkGaNMukmrfZ6KKevHLjbq1
7GRrLTWiojWlNj90LvSQF0VUmWwXjJ6f71X8Z+jSzDvs3sOgX36uxO+FMuj/GUy0
8i8fWvgSGGFdENVAvULi19R1smQYPfn1bS6Oe/O2vqFdHNIYUjHXUPlccJUpXg23
rF95nuNCQyFUMFTEcIpvjC79M6+t6g==
=nt9p
-----END PGP SIGNATURE-----

--610ebvbNEkTLlpDqgTfgwpx3Ym55DTqvm--
