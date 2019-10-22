From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] net: sch_generic: Use pfifo_fast as fallback scheduler
 for CAN hardware
Date: Tue, 22 Oct 2019 16:53:44 +0200
Message-ID: <84b8ce24-fe5d-ead0-0d1d-03ea24b36f71@pengutronix.de>
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <1571750597-14030-1-git-send-email-vincent.prince.fr@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zsdubcn26iXCvlyTNyB5qRMGbtp1jgx74"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1571750597-14030-1-git-send-email-vincent.prince.fr@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Vincent Prince <vincent.prince.fr@gmail.com>
Cc: jiri@resnulli.us, jhs@mojatatu.com, netdev@vger.kernel.org, dave.taht@gmail.com, linux-can@vger.kernel.org, kernel@pengutronix.de, xiyou.wangcong@gmail.com, davem@davemloft.net
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zsdubcn26iXCvlyTNyB5qRMGbtp1jgx74
Content-Type: multipart/mixed; boundary="Edn5yA9Yie6iVjLu0MWeeLlGcHPppl7aV";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Prince <vincent.prince.fr@gmail.com>
Cc: jiri@resnulli.us, jhs@mojatatu.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, linux-can@vger.kernel.org, kernel@pengutronix.de,
 xiyou.wangcong@gmail.com, davem@davemloft.net
Message-ID: <84b8ce24-fe5d-ead0-0d1d-03ea24b36f71@pengutronix.de>
Subject: Re: [PATCH v2] net: sch_generic: Use pfifo_fast as fallback scheduler
 for CAN hardware
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <1571750597-14030-1-git-send-email-vincent.prince.fr@gmail.com>
In-Reply-To: <1571750597-14030-1-git-send-email-vincent.prince.fr@gmail.com>

--Edn5yA9Yie6iVjLu0MWeeLlGcHPppl7aV
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 10/22/19 3:23 PM, Vincent Prince wrote:
> Signed-off-by: Vincent Prince <vincent.prince.fr@gmail.com>

please include a patch description. I.e. this one:

-------->8-------->8-------->8-------->8-------->8-------->8-------->8---=
-----
There is networking hardware that isn't based on Ethernet for layers 1 an=
d 2.

For example CAN.

CAN is a multi-master serial bus standard for connecting Electronic Contr=
ol
Units [ECUs] also known as nodes. A frame on the CAN bus carries up to 8 =
bytes
of payload. Frame corruption is detected by a CRC. However frame loss due=
 to
corruption is possible, but a quite unusual phenomenon.

While fq_codel works great for TCP/IP, it doesn't for CAN. There are a lo=
t of
legacy protocols on top of CAN, which are not build with flow control or =
high
CAN frame drop rates in mind.

When using fq_codel, as soon as the queue reaches a certain delay based l=
ength,
skbs from the head of the queue are silently dropped. Silently meaning th=
at the
user space using a send() or similar syscall doesn't get an error. Howeve=
r
TCP's flow control algorithm will detect dropped packages and adjust the
bandwidth accordingly.

When using fq_codel and sending raw frames over CAN, which is the common =
use
case, the user space thinks the package has been sent without problems, b=
ecause
send() returned without an error. pfifo_fast will drop skbs, if the queue=

length exceeds the maximum. But with this scheduler the skbs at the tail =
are
dropped, an error (-ENOBUFS) is propagated to user space. So that the use=
r
space can slow down the package generation.

On distributions, where fq_codel is made default via CONFIG_DEFAULT_NET_S=
CH
during compile time, or set default during runtime with sysctl
net.core.default_qdisc (see [1]), we get a bad user experience. In my tes=
t case
with pfifo_fast, I can transfer thousands of million CAN frames without a=
 frame
drop. On the other hand with fq_codel there is more then one lost CAN fra=
me per
thousand frames.

As pointed out fq_codel is not suited for CAN hardware, so this patch cha=
nges
attach_one_default_qdisc() to use pfifo_fast for "ARPHRD_CAN" network dev=
ices.

During transition of a netdev from down to up state the default queuing
discipline is attached by attach_default_qdiscs() with the help of
attach_one_default_qdisc(). This patch modifies attach_one_default_qdisc(=
) to
attach the pfifo_fast (pfifo_fast_ops) if the network device type is
"ARPHRD_CAN".
-------->8-------->8-------->8-------->8-------->8-------->8-------->8---=
-----

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Edn5yA9Yie6iVjLu0MWeeLlGcHPppl7aV--

--zsdubcn26iXCvlyTNyB5qRMGbtp1jgx74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2vF/gACgkQWsYho5Hk
nSDInQgAhPBoaT5/gW5yo1b+h7hjTZfw1hsbXp9s527FYOBvinI78dP9HiMa/FTV
eYdP4bnnCLFN7+YIM4ZaNYEur+GDpCnQsQSUJjfNZ78F/j11AYI5+O/OwRzdQtxj
DRuavT0zNE1E0kw/lW/Kfl/Iryv3q42TkMzByy9n7sy9mH+jJ/+MdNL9l8OBJjOI
bdYtCfFkQduc1SxqB9Q4QzwalGfuUDRQ2J3bqU3AhRiIOcEIcuhvdrW78QG9mLv0
fVCnJAMo2vXM0TnnyEn9mT7xh2uJtieDkKLi6GEgZUyH3+aZyQr4vc709yetryaU
5x+FTLKlK4bWZUAao/52goo+s67J9g==
=vr+P
-----END PGP SIGNATURE-----

--zsdubcn26iXCvlyTNyB5qRMGbtp1jgx74--
