From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/5] can: enable multi-queue for SocketCAN devices
Date: Fri, 20 Jul 2018 16:34:48 +0200
Message-ID: <d61c82a6-3120-5c32-3264-238d2b964ced@pengutronix.de>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
 <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
 <1528900641-18677-2-git-send-email-mark.jonas@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jbXFFXKZbFVcsboz6oQVC153hDdHp2VLd"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528900641-18677-2-git-send-email-mark.jonas@de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jonas <mark.jonas@de.bosch.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hs@denx.de, yi.zhu5@cn.bosch.com, petar.petrovic2@de.bosch.com, stephan.baetge@de.bosch.com, andy.shevchenko@gmail.com, socketcan@hartkopp.net, o.rempel@pengutronix.de
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jbXFFXKZbFVcsboz6oQVC153hDdHp2VLd
Content-Type: multipart/mixed; boundary="7MK7jnJhyZ4l2uhqvePK7WjHpVWhtGZiP";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mark Jonas <mark.jonas@de.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, hs@denx.de, yi.zhu5@cn.bosch.com,
 petar.petrovic2@de.bosch.com, stephan.baetge@de.bosch.com,
 andy.shevchenko@gmail.com, socketcan@hartkopp.net, o.rempel@pengutronix.de
Message-ID: <d61c82a6-3120-5c32-3264-238d2b964ced@pengutronix.de>
Subject: Re: [PATCH v2 1/5] can: enable multi-queue for SocketCAN devices
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
 <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
 <1528900641-18677-2-git-send-email-mark.jonas@de.bosch.com>
In-Reply-To: <1528900641-18677-2-git-send-email-mark.jonas@de.bosch.com>

--7MK7jnJhyZ4l2uhqvePK7WjHpVWhtGZiP
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 06/13/2018 04:37 PM, Mark Jonas wrote:
> From: Zhu Yi <yi.zhu5@cn.bosch.com>
>=20
> The existing SocketCAN implementation provides alloc_candev() to
> allocate a CAN device using a single Tx and Rx queue. This can lead to
> priority inversion in case the single Tx queue is already full with low=

> priority messages and a high priority message needs to be sent while th=
e
> bus is fully loaded with medium priority messages.
>=20
> This problem can be solved by using the existing multi-queue support of=

> the network subsytem. The commit makes it possible to use multi-queue i=
n
> the CAN subsystem in the same way it is used in the Ethernet subsystem
> by adding an alloc_candev_mqs() call and accompanying macros. With this=

> support a CAN device can use multi-queue qdisc (e.g. mqprio) to avoid
> the aforementioned priority inversion.
>=20
> The exisiting functionality of alloc_candev() is the same as before.
>=20
> CAN devices need to have prioritized multiple hardware queues or are
> able to abort waiting for arbitration to make sensible use of
> multi-queues.
>=20
> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> Reviewed-by: Heiko Schocher <hs@denx.de>

Applied to linux-can-next.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7MK7jnJhyZ4l2uhqvePK7WjHpVWhtGZiP--

--jbXFFXKZbFVcsboz6oQVC153hDdHp2VLd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltR8wgACgkQk9IU1zQo
ZfGT2Af/XqAfR3SHb7SAJg0jrQmWyc4F+OlKl5yNM06LfV/eXnf9Wy9AS81RtANV
ZODGx6T5qsqm8XCv3Ve4GD71A5uCv1Sh8UaGSq+9fFZDyhJnxSVwq4lLIWLKHs9X
wN6/OIgE+iit0JNMyaGYLHNWK8gvFA/i6ptTdDukyXcDUu2IXe2yU+Od2SMKfRTL
c6HU/0gtR/ySOf8OUqCnUn5ZcVCpoOEs931GmAZwQmai3Hvk1kK4j0QPFoCBWmkC
jcjAMbTPxlO3qL4og3omHpvzh/KkBZ1gn8EnVoPtIPvsm5vnveTPNqGEG33CQ7Ni
rnqvJrtyo+6ffHt1aBzYLag40R8Rzg==
=TugX
-----END PGP SIGNATURE-----

--jbXFFXKZbFVcsboz6oQVC153hDdHp2VLd--
