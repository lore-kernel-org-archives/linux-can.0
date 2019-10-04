From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: dev: add missing of_node_put after calling
 of_get_child_by_name
Date: Fri, 4 Oct 2019 23:11:56 +0200
Message-ID: <145bef76-27d9-e2be-d82d-53536f6cb597@pengutronix.de>
References: <20190928142905.34832-1-wenyang@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kx6zJ8ozKLmIG3ipuB2WQDQE6ztEEMiNn"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190928142905.34832-1-wenyang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wenyang@linux.alibaba.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: xlpang@linux.alibaba.com, "David S. Miller" <davem@davemloft.net>, Franklin S Cooper Jr <fcooper@ti.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kx6zJ8ozKLmIG3ipuB2WQDQE6ztEEMiNn
Content-Type: multipart/mixed; boundary="hHOlXNUXAjPWPaQfgHaIYtxH0J95P46Xj";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wen Yang <wenyang@linux.alibaba.com>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: xlpang@linux.alibaba.com, "David S. Miller" <davem@davemloft.net>,
 Franklin S Cooper Jr <fcooper@ti.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <145bef76-27d9-e2be-d82d-53536f6cb597@pengutronix.de>
Subject: Re: [PATCH] can: dev: add missing of_node_put after calling
 of_get_child_by_name
References: <20190928142905.34832-1-wenyang@linux.alibaba.com>
In-Reply-To: <20190928142905.34832-1-wenyang@linux.alibaba.com>

--hHOlXNUXAjPWPaQfgHaIYtxH0J95P46Xj
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/28/19 4:29 PM, Wen Yang wrote:
> of_node_put needs to be called when the device node which is got
> from of_get_child_by_name finished using.
>=20
> fixes: 2290aefa2e90 ("can: dev: Add support for limiting configured bit=
rate")
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Franklin S Cooper Jr <fcooper@ti.com>
> Cc: linux-can@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Applied to linux-can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hHOlXNUXAjPWPaQfgHaIYtxH0J95P46Xj--

--kx6zJ8ozKLmIG3ipuB2WQDQE6ztEEMiNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2XtZwACgkQWsYho5Hk
nSD2TAf+NdBv5mjGhDPf01YFrERBreJnPmbM5OIjbx0x7x3IJN2QTr5MR51osaRu
0wTNxst3ZBrG00bHtLyA/bAcF7pxwKj1jBvc8ZmEt+Pwc1CKxfBvkJL92RRhEsYa
QuUu51bDmeNOeg5KMV905HSJRtJbN4wCJas7VJNpZR2nXd3Y8B2AGZ+Ol96tfqvY
7gS32r2xrOTYfh4ZJkK1tgWHBASrAIBl3sFd0GfCsixfO3JVq0c2yk86FWVsjDsq
OmYHgHFPZKrDqnuSrSsHK0FV8UclYhV/FcEiehrS/AF+Ad7BZAmmFY46VkoJIWAn
vz1lsOTp8AZ122BwkKAjJOEMkJXSQg==
=jggk
-----END PGP SIGNATURE-----

--kx6zJ8ozKLmIG3ipuB2WQDQE6ztEEMiNn--
