From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/3] Fixes for kvaser_usb driver
Date: Tue, 21 Nov 2017 14:14:14 +0100
Message-ID: <448613d6-e9a5-d4f4-c6ce-eef31fbf4c56@pengutronix.de>
References: <20171121072228.7570-1-jimmyassarsson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3ChPp62kGjtuUAShBk5GsfKUEkxO5LuND"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39965 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750772AbdKUNOT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Nov 2017 08:14:19 -0500
In-Reply-To: <20171121072228.7570-1-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3ChPp62kGjtuUAShBk5GsfKUEkxO5LuND
Content-Type: multipart/mixed; boundary="36tEcFF0V5boaMQlCs6AQqQsEbduIeIvF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org
Message-ID: <448613d6-e9a5-d4f4-c6ce-eef31fbf4c56@pengutronix.de>
Subject: Re: [PATCH 0/3] Fixes for kvaser_usb driver
References: <20171121072228.7570-1-jimmyassarsson@gmail.com>
In-Reply-To: <20171121072228.7570-1-jimmyassarsson@gmail.com>

--36tEcFF0V5boaMQlCs6AQqQsEbduIeIvF
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/21/2017 08:22 AM, Jimmy Assarsson wrote:
> The first patch fix two missing free calls in error paths. The second p=
atch
> fix a bad comparison between signed and unsigned integer, causing undes=
ired
> behaviour. The third patch will ratelimit error prinouts, if incomplete=
 USB
> messages are received. My kernel log got flooded with these error messa=
ges,
> when I encountered the bug described in the previous patch.

Applied to can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--36tEcFF0V5boaMQlCs6AQqQsEbduIeIvF--

--3ChPp62kGjtuUAShBk5GsfKUEkxO5LuND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloUJqYACgkQHv7KIOw4
HPYB7ggAmKfj2slHThxGYClgKT3QtkfYJR9ExeLvPyQmHFr4X08rOXIs5hH4k95E
L2ZCAol5hLESMLl8q43Qicj7XxbQYQAhC/YTnwxF38I6W7ZJTqdMlz+P/NXVJohM
t48+p6p11000Jcb1Ef0ysetI553+A2ef5QfeJXDH0zEqOK26iMXMAAmBIeyX7c1F
dBnDQz52FANmueVGU9IQE+jL/T4QAiuDppSRZA/lrKlvgGWMnzrpfUzS/Gi91rcE
wvxBjPqlZZEB85j5TJq/7uFmL5MZuQ63Z6PZn83/riLeNMeuIa8BoXi1lmuCBffY
Ymd+A11Mx4D7yAz5z1Co+SSjsNMJAA==
=+sYW
-----END PGP SIGNATURE-----

--3ChPp62kGjtuUAShBk5GsfKUEkxO5LuND--
