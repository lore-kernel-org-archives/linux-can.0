From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v1] can: j1939: j1939_sk_bind(): take priv after lock is
 held
Date: Sat, 7 Dec 2019 14:05:32 +0100
Message-ID: <45a5246e-8bf2-3312-5931-18e525d78f4b@pengutronix.de>
References: <20191206141835.20557-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zK88azG4d9z8EORMOzhEmBFJhkgfPcvUO"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191206141835.20557-1-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>, dev.kurt@vandijck-laurijssen.be, wg@grandegger.com
Cc: syzbot+99e9e1b200a1e363237d@syzkaller.appspotmail.com, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zK88azG4d9z8EORMOzhEmBFJhkgfPcvUO
Content-Type: multipart/mixed; boundary="uuoC5PUj9c5LTGrBHp3YYnFeNlNDpw7XZ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 dev.kurt@vandijck-laurijssen.be, wg@grandegger.com
Cc: syzbot+99e9e1b200a1e363237d@syzkaller.appspotmail.com,
 kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <45a5246e-8bf2-3312-5931-18e525d78f4b@pengutronix.de>
Subject: Re: [PATCH v1] can: j1939: j1939_sk_bind(): take priv after lock is
 held
References: <20191206141835.20557-1-o.rempel@pengutronix.de>
In-Reply-To: <20191206141835.20557-1-o.rempel@pengutronix.de>

--uuoC5PUj9c5LTGrBHp3YYnFeNlNDpw7XZ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/6/19 3:18 PM, Oleksij Rempel wrote:
> syzbot reproduced following crash:

applied to linux-can.

Tnx,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--uuoC5PUj9c5LTGrBHp3YYnFeNlNDpw7XZ--

--zK88azG4d9z8EORMOzhEmBFJhkgfPcvUO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3ro50ACgkQWsYho5Hk
nSC6dQf/Wsll9DQlJcLCgcrNOJQBdo5t9PP+M0YBPqFWw7Lf4a9VlyGZNRUw8Y9M
4LRvCnEthSUNNHY6Yu4goCKs9HoumXFQwQZeEih/rEM84LsT8KFvgy8aTCqeiQcl
yv8cCyCDT1DyOYsY50sjypduPWct1JjYT/WD7DGm2nR2tUFVws2qn9kcnK8EV5jF
BixcCDdYs+pXb0mWd+aLopyRYRysl5hlD79+FGtuXaZRuxNdUBxZwEEk5AC7yZg4
exYwzVCi1R4PTu7XtzjxF2D6td1lgY/ms2ws7/QRCyRKZK9V4M/g18+CisbVQYuY
Ax2rsRMLDHvlWwh1kdA9aaMZeCbuvQ==
=FI+m
-----END PGP SIGNATURE-----

--zK88azG4d9z8EORMOzhEmBFJhkgfPcvUO--
