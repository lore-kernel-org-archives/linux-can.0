From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] peak_usb: Fix info-leaks to USB devices
Date: Fri, 2 Aug 2019 13:45:59 +0200
Message-ID: <94a82ee7-880e-704c-14ea-328b17854441@pengutronix.de>
References: <20190731145447.29270-1-tomasbortoli@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bUHFL0ZY0h4QKkg7KNcgGEekD5qTsRGu2"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190731145447.29270-1-tomasbortoli@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Tomas Bortoli <tomasbortoli@gmail.com>, wg@grandegger.com, linux-can@vger.kernel.org
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, alexios.zavras@intel.com, tglx@linutronix.de, allison@lohutok.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bUHFL0ZY0h4QKkg7KNcgGEekD5qTsRGu2
Content-Type: multipart/mixed; boundary="taHezyBPFjLpFu9Ua1xiWSIFcmBQqJa51";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tomas Bortoli <tomasbortoli@gmail.com>, wg@grandegger.com,
 linux-can@vger.kernel.org
Cc: davem@davemloft.net, gregkh@linuxfoundation.org,
 alexios.zavras@intel.com, tglx@linutronix.de, allison@lohutok.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
Message-ID: <94a82ee7-880e-704c-14ea-328b17854441@pengutronix.de>
Subject: Re: [PATCH] peak_usb: Fix info-leaks to USB devices
References: <20190731145447.29270-1-tomasbortoli@gmail.com>
In-Reply-To: <20190731145447.29270-1-tomasbortoli@gmail.com>

--taHezyBPFjLpFu9Ua1xiWSIFcmBQqJa51
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 7/31/19 4:54 PM, Tomas Bortoli wrote:
> Uninitialized Kernel memory can leak to USB devices.
>=20
> Fix by using kzalloc() instead of kmalloc() on the affected buffers.
>=20
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+d6a5a1a3657b596ef132@syzkaller.appspotmail.com
> Reported-by: syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com

Applied, but split into two patches, as the problem was introduced in
two separate commits.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--taHezyBPFjLpFu9Ua1xiWSIFcmBQqJa51--

--bUHFL0ZY0h4QKkg7KNcgGEekD5qTsRGu2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1EIngACgkQWsYho5Hk
nSD8vgf8DJdo1LsTA5upQRO9+/x1xqDq+ssUrsPgYQU8Oeik4bHaDvyhN5pOXXVP
QXx9xNv6SFDKwi/I2IP/4A87PWbHRZf1TT67yMGRMBofgR9v1eM34oFdHRPsx16+
6fylUL5cvukN2Zo540ppZ/OxHmUZvNMzSSytt6KWL1FfwRdZzUSQ6bk02HHF1xTY
BAIHM6LKW12OgQ4eSJV9/EgDeOU+97BlnxDhlR6qUoDPgcp+tY/UpQqRA1dZ5wFY
J9ZDx8tZTfAc+MhRZ1+yzRB/+oOssIuhvHe8UP/IgviBre1osMmmggH1TXnPJVzQ
lgcWR9rpEFShfT+wI0YHK+Wi1rFgaA==
=YiHU
-----END PGP SIGNATURE-----

--bUHFL0ZY0h4QKkg7KNcgGEekD5qTsRGu2--
