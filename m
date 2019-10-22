From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] net: sch_generic: Use pfifo_fast as fallback scheduler
 for CAN hardware
Date: Tue, 22 Oct 2019 16:55:26 +0200
Message-ID: <a0adc1d1-8a88-b2fa-d6d3-928785b16ebb@pengutronix.de>
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <1571750597-14030-1-git-send-email-vincent.prince.fr@gmail.com>
 <84b8ce24-fe5d-ead0-0d1d-03ea24b36f71@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PMtC1ri3OfM9u9f3SFy99Oy3vmyGD5O2C"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <84b8ce24-fe5d-ead0-0d1d-03ea24b36f71@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Vincent Prince <vincent.prince.fr@gmail.com>
Cc: jiri@resnulli.us, dave.taht@gmail.com, netdev@vger.kernel.org, jhs@mojatatu.com, linux-can@vger.kernel.org, kernel@pengutronix.de, xiyou.wangcong@gmail.com, davem@davemloft.net
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PMtC1ri3OfM9u9f3SFy99Oy3vmyGD5O2C
Content-Type: multipart/mixed; boundary="Op2BsBVqswp7K1qzXiYA7tDcsxKi4wePu";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Prince <vincent.prince.fr@gmail.com>
Cc: jiri@resnulli.us, dave.taht@gmail.com, netdev@vger.kernel.org,
 jhs@mojatatu.com, linux-can@vger.kernel.org, kernel@pengutronix.de,
 xiyou.wangcong@gmail.com, davem@davemloft.net
Message-ID: <a0adc1d1-8a88-b2fa-d6d3-928785b16ebb@pengutronix.de>
Subject: Re: [PATCH v2] net: sch_generic: Use pfifo_fast as fallback scheduler
 for CAN hardware
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <1571750597-14030-1-git-send-email-vincent.prince.fr@gmail.com>
 <84b8ce24-fe5d-ead0-0d1d-03ea24b36f71@pengutronix.de>
In-Reply-To: <84b8ce24-fe5d-ead0-0d1d-03ea24b36f71@pengutronix.de>

--Op2BsBVqswp7K1qzXiYA7tDcsxKi4wePu
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/22/19 4:53 PM, Marc Kleine-Budde wrote:
> On 10/22/19 3:23 PM, Vincent Prince wrote:
>> Signed-off-by: Vincent Prince <vincent.prince.fr@gmail.com>
>=20
> please include a patch description. I.e. this one:
>=20
> -------->8-------->8-------->8-------->8-------->8-------->8-------->8-=
-------
> There is networking hardware that isn't based on Ethernet for layers 1 =
and 2.
>=20
> For example CAN.
>=20
> CAN is a multi-master serial bus standard for connecting Electronic Con=
trol
> Units [ECUs] also known as nodes. A frame on the CAN bus carries up to =
8 bytes
> of payload. Frame corruption is detected by a CRC. However frame loss d=
ue to
> corruption is possible, but a quite unusual phenomenon.
>=20
> While fq_codel works great for TCP/IP, it doesn't for CAN. There are a =
lot of
> legacy protocols on top of CAN, which are not build with flow control o=
r high
> CAN frame drop rates in mind.
>=20
> When using fq_codel, as soon as the queue reaches a certain delay based=
 length,
> skbs from the head of the queue are silently dropped. Silently meaning =
that the
> user space using a send() or similar syscall doesn't get an error. Howe=
ver
> TCP's flow control algorithm will detect dropped packages and adjust th=
e
> bandwidth accordingly.
>=20
> When using fq_codel and sending raw frames over CAN, which is the commo=
n use
> case, the user space thinks the package has been sent without problems,=
 because
> send() returned without an error. pfifo_fast will drop skbs, if the que=
ue
> length exceeds the maximum. But with this scheduler the skbs at the tai=
l are
> dropped, an error (-ENOBUFS) is propagated to user space. So that the u=
ser
> space can slow down the package generation.
>=20
> On distributions, where fq_codel is made default via CONFIG_DEFAULT_NET=
_SCH
> during compile time, or set default during runtime with sysctl
> net.core.default_qdisc (see [1]), we get a bad user experience. In my t=
est case
> with pfifo_fast, I can transfer thousands of million CAN frames without=
 a frame
> drop. On the other hand with fq_codel there is more then one lost CAN f=
rame per
> thousand frames.
>=20
> As pointed out fq_codel is not suited for CAN hardware, so this patch c=
hanges
> attach_one_default_qdisc() to use pfifo_fast for "ARPHRD_CAN" network d=
evices.
>=20
> During transition of a netdev from down to up state the default queuing=

> discipline is attached by attach_default_qdiscs() with the help of
> attach_one_default_qdisc(). This patch modifies attach_one_default_qdis=
c() to
> attach the pfifo_fast (pfifo_fast_ops) if the network device type is
> "ARPHRD_CAN".
> -------->8-------->8-------->8-------->8-------->8-------->8-------->8-=
-------

Doh, also include the footnote:

-------->8-------->8-------->8-------->8-------->8-------->8-------->8---=
-----
[1] https://github.com/systemd/systemd/issues/9194
-------->8-------->8-------->8-------->8-------->8-------->8-------->8---=
-----

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Op2BsBVqswp7K1qzXiYA7tDcsxKi4wePu--

--PMtC1ri3OfM9u9f3SFy99Oy3vmyGD5O2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2vGF4ACgkQWsYho5Hk
nSDabQf+OWsRLkD2sUS3VJ5YvEcDiOKdrFLucnVSCPyOaNazVlcwWhxmSR7N/VCU
b+SItuo1CrLI51n/MDR1unZpGkyUF4Ih+xFt4W738t0FvCerqwII8R5XkCuacwWq
eOd4OJIBnfOa/AIbhCIkVvbbC6XzSN950w315cQKsX2H1N7X0jvToitl9yVswDuk
kksPSIOHYVtqSeCLm2J48J06RoYPmrtc+w4v189MK4eWGMFB8yvaOxOx1mW9vTXD
oxDCqA6+8Qs7D/j5VhbNC2IrVVFlgvu6r46R1wZUaZm1nB/p9EROsIGIKzWQymMP
8BGhZ7LeMu9T/J0GilU1JxYNdjVJDQ==
=jUcQ
-----END PGP SIGNATURE-----

--PMtC1ri3OfM9u9f3SFy99Oy3vmyGD5O2C--
