From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] mscan: fix rx path lockup when returning from polling to
 irq mode
Date: Thu, 2 Jan 2020 17:19:40 +0100
Message-ID: <40ad7d2c-6e34-109b-560a-2056a932acb6@pengutronix.de>
References: <860de41f-bb60-728b-7602-90dced920c27@faberman.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xIsVOaKtpHxIl5iDUucCCCHKLskVIH22D"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <860de41f-bb60-728b-7602-90dced920c27@faberman.de>
Sender: stable-owner@vger.kernel.org
To: Florian Faber <faber@faberman.de>, linux-can@vger.kernel.org
Cc: stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xIsVOaKtpHxIl5iDUucCCCHKLskVIH22D
Content-Type: multipart/mixed; boundary="8KUKqe5NdK8MvM3270RNcisiM0Xe5Ezws";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Florian Faber <faber@faberman.de>, linux-can@vger.kernel.org
Cc: stable@vger.kernel.org
Message-ID: <40ad7d2c-6e34-109b-560a-2056a932acb6@pengutronix.de>
Subject: Re: [PATCH] mscan: fix rx path lockup when returning from polling to
 irq mode
References: <860de41f-bb60-728b-7602-90dced920c27@faberman.de>
In-Reply-To: <860de41f-bb60-728b-7602-90dced920c27@faberman.de>

--8KUKqe5NdK8MvM3270RNcisiM0Xe5Ezws
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/26/19 7:51 PM, Florian Faber wrote:
> Under load, the RX side of the mscan driver can get stuck while TX stil=
l
> works. Restarting the interface locks up the system. This behaviour=20
> could be reproduced reliably on a MPC5121e based system.
>=20
> The patch fixes the return value of the NAPI polling function (should b=
e
> the number of processed packets, not constant 1) and the condition unde=
r
> which IRQs are enabled again after polling is finished.
>=20
> With this patch, no more lockups were observed over a test period of te=
n=20
> days.
>=20
> Signed-off-by: Florian Faber <faber@faberman.de>

Applied to linux-can. Please consider using git-send-email in the
future, as your mail setup somehow mangles spaces and tabs.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--8KUKqe5NdK8MvM3270RNcisiM0Xe5Ezws--

--xIsVOaKtpHxIl5iDUucCCCHKLskVIH22D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl4OGBwACgkQWsYho5Hk
nSBhNAgAo6wBBJ5u6IKGlrqGSsl+X5LZo+SsvSir1W8y1Sm40YoUiTPO6YXkaLtS
GtGjlsf+dwm4tpuBXpWLdy1KhqIcOd0UYpAcRp+AF95JLLS6IlDFHLa4i4FVzBOf
x6riCnULvnhrzSFPDrxh6yALJiX6RnWVkVBhRrc9xhfkE/sS0jbfd4VVyPL0nKfi
kgmK7QtrzR/LfWQu1KuEdyUh14l6+s+rFcttw8IYFE2Fwfyjq5WtpOQo7Tfgrbsa
yjCcvBm34SUqInBMFNQfDB1IpYctwhihXwfIjJjex05A3T2jp912ZPgLaKOpNHP+
/Lfs1NrR3ep1WQqUUfGGRU1xrptc5g==
=AFjm
-----END PGP SIGNATURE-----

--xIsVOaKtpHxIl5iDUucCCCHKLskVIH22D--
