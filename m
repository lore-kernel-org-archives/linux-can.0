From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pull-request: can 2018-07-23
Date: Tue, 24 Jul 2018 09:27:30 +0200
Message-ID: <738a1779-1375-1159-54b7-39a327509b61@pengutronix.de>
References: <20180723125843.391-1-mkl@pengutronix.de>
 <20180723.110241.1700809256849434700.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="H733dGdHlyfQ31gwB6y7sQLaANOWhnf18"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180723.110241.1700809256849434700.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H733dGdHlyfQ31gwB6y7sQLaANOWhnf18
Content-Type: multipart/mixed; boundary="PKvn2C9lNKD7kiD9kicPTYt3QIW9LgSJS";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <738a1779-1375-1159-54b7-39a327509b61@pengutronix.de>
Subject: Re: pull-request: can 2018-07-23
References: <20180723125843.391-1-mkl@pengutronix.de>
 <20180723.110241.1700809256849434700.davem@davemloft.net>
In-Reply-To: <20180723.110241.1700809256849434700.davem@davemloft.net>

--PKvn2C9lNKD7kiD9kicPTYt3QIW9LgSJS
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 07/23/2018 08:02 PM, David Miller wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Mon, 23 Jul 2018 14:58:31 +0200
>=20
>> this is a pull request of 12 patches for net/master.
>>
>> The patch by Stephane Grosjean for the peak_canfd CAN driver fixes a p=
roblem
>> with older firmware. The next patch is by Roman Fietze and fixes the s=
etup of
>> the CCCR register in the m_can driver. Nicholas Mc Guire's patch for t=
he
>> mpc5xxx_can driver adds missing error checking. The two patches by Fai=
z Abbas
>> fix the runtime resume and clean up the probe function in the m_can dr=
iver. The
>> last 7 patches by Anssi Hannula fix several problem in the xilinx_can =
driver.
>=20
> Pulled, thanks Marc.

Thanks David. Can you please merge net into next-next, as I've some
patches for net-next that would result in a merge conflict between net
and net-next later.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PKvn2C9lNKD7kiD9kicPTYt3QIW9LgSJS--

--H733dGdHlyfQ31gwB6y7sQLaANOWhnf18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltW1OQACgkQk9IU1zQo
ZfGw/gf/bCQCr/3GcniGWfDX0zUuS05nMJR+TLa033SWMT0ZwCADbGPeqk+sFRKP
hA/BFbABLzRlZsMeDqgx1koWHBMWA6akTgg1x6wjZIv7z23Jl2gGePR109Un1Ejy
l/FiW3opeMZ3E+fFV7bvHRiOhCL5tCQSry+YLPNVH5Kce454fka+RS+8tHsRSixw
1oy7cJT84RBXEMRW5YRkRHFsZwKXml+LM6UCOg9oQjQ5/thXOWFIfTSy28YV5wfA
7AYFogw09MmLukJ1W0FRYxCr1t3OueHps1yM4GlFAEnmRypMJ6api4W1QYnkxnZW
YIwemu8n0LDnK+QhUiEYybKHPG6uCw==
=yrFc
-----END PGP SIGNATURE-----

--H733dGdHlyfQ31gwB6y7sQLaANOWhnf18--
