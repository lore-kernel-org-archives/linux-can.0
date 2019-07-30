From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next] can: fix ioctl function removal
Date: Tue, 30 Jul 2019 08:30:40 +0200
Message-ID: <79020cce-4f58-2104-a817-235e6d216528@pengutronix.de>
References: <20190729204056.2976-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DBn7XNyJyxx3wl4DuIhL9wGMiKcLFY07b"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190729204056.2976-1-socketcan@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, davem@davemloft.net, netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, kernel test robot <rong.a.chen@intel.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DBn7XNyJyxx3wl4DuIhL9wGMiKcLFY07b
Content-Type: multipart/mixed; boundary="ebDKpq1kSlPBM7D86uHsDXf6fU1GgRk16";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, davem@davemloft.net,
 netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, kernel test robot <rong.a.chen@intel.com>
Message-ID: <79020cce-4f58-2104-a817-235e6d216528@pengutronix.de>
Subject: Re: [PATCH net-next] can: fix ioctl function removal
References: <20190729204056.2976-1-socketcan@hartkopp.net>
In-Reply-To: <20190729204056.2976-1-socketcan@hartkopp.net>

--ebDKpq1kSlPBM7D86uHsDXf6fU1GgRk16
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 7/29/19 10:40 PM, Oliver Hartkopp wrote:
> Commit 60649d4e0af ("can: remove obsolete empty ioctl() handler") repla=
ced the
> almost empty can_ioctl() function with sock_no_ioctl() which always ret=
urns
> -EOPNOTSUPP.
>=20
> Even though we don't have any ioctl() functions on socket/network layer=
 we need
> to return -ENOIOCTLCMD to be able to forward ioctl commands like SIOCGI=
FINDEX
> to the network driver layer.
>=20
> This patch fixes the wrong return codes in the CAN network layer protoc=
ols.
>=20
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: 60649d4e0af ("can: remove obsolete empty ioctl() handler")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

David Miller has already applied the patch.

| commit 473d924d7d46cb57aa4c1863261d18366af345af
| Author: Oliver Hartkopp <socketcan@hartkopp.net>
| Date:   Mon Jul 29 22:40:56 2019 +0200

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ebDKpq1kSlPBM7D86uHsDXf6fU1GgRk16--

--DBn7XNyJyxx3wl4DuIhL9wGMiKcLFY07b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl0/5BAACgkQWsYho5Hk
nSAdlwf9FvQXprA9ijUqrNwvCNVM/h2siMdeeoUrg1SqzhgA7widx9raFr12K3Zu
rDef8fGTPErEz6ARQpF6ThMhEd6N3qjplMsK/WHBz7LaGPy+6RtCLr4p8g7cR0XL
EDb0b808S6onPQQJqjqBQGaBqRwBNsf1xshZPU5ECv5nMC9wtUitONw+DWfJeGZG
cgYiTbobOAyPBXDkXcfuyWRxM6wGlf8VEcNZ4X6gYbYQW1ufpu9Yp6BevO+F/8kw
OAFEcuX3WC04SIwH9hZBqIG2nH2Df6gzXJbVJtXjWvS48E4pGZoUa+EzqVSxJvgf
s1gY216N6Z+3HW6FjcNTvsQYYVPdfA==
=8Qnh
-----END PGP SIGNATURE-----

--DBn7XNyJyxx3wl4DuIhL9wGMiKcLFY07b--
