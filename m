From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] net: can: sja1000: Replace mdelay with usleep_range
 in peak_pci_probe
Date: Wed, 25 Apr 2018 16:53:10 +0200
Message-ID: <82c41390-982e-c05f-79ba-9bf14697df18@pengutronix.de>
References: <1523410978-1834-1-git-send-email-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kzscgHpQcq2btGk02eClp5JxUqeKLEMOF"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1523410978-1834-1-git-send-email-baijiaju1990@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>, wg@grandegger.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kzscgHpQcq2btGk02eClp5JxUqeKLEMOF
Content-Type: multipart/mixed; boundary="f6c4iPjbmcY8z6dkBMGsFlLbFXrQfqfTq";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, wg@grandegger.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <82c41390-982e-c05f-79ba-9bf14697df18@pengutronix.de>
Subject: Re: [PATCH 1/2] net: can: sja1000: Replace mdelay with usleep_range
 in peak_pci_probe
References: <1523410978-1834-1-git-send-email-baijiaju1990@gmail.com>
In-Reply-To: <1523410978-1834-1-git-send-email-baijiaju1990@gmail.com>

--f6c4iPjbmcY8z6dkBMGsFlLbFXrQfqfTq
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/11/2018 03:42 AM, Jia-Ju Bai wrote:
> peak_pci_probe() is never called in atomic context.
>=20
> peak_pci_probe() is set as ".probe" in struct pci_driver.
>=20
> Despite never getting called from atomic context, peak_pci_probe()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range() to
> avoid busy waiting.
>=20
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
>=20
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied both to linux-can-next.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--f6c4iPjbmcY8z6dkBMGsFlLbFXrQfqfTq--

--kzscgHpQcq2btGk02eClp5JxUqeKLEMOF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlrgllYACgkQk9IU1zQo
ZfG9RwgAhMCquisobaLm20AhILqPj2qfpZ2zNmipP1hzKcrBZT2cRb8WYteG6V23
CQVJ2+C1RASY7B4jLNaJt2y7lh6589HtBcjHDj3cISyzHg47RGwO5lqktrYzgwVP
pPnquQpUpn5bRPssahLH64Mm7Wa7WYb6gZHaBg6r4xi+ERFiDf1UIHAX+wvaTMwt
923HyvBD8j/McPxvl4GBGAz3jclgl0FlogGLgTpcY0kK16xv2w6l96hfx/Kxs7R6
VSgVDmakNwK4CYsT25MDGZUidYpYQlrKyLLUEuEZl5ytuLIHONGrv4MOZZMsDAg/
COS4dQR7JStsclEvHPHMg1SP1jSNqw==
=/ejb
-----END PGP SIGNATURE-----

--kzscgHpQcq2btGk02eClp5JxUqeKLEMOF--
