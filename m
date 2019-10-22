From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] net: sch_generic: Use pfifo_fast as fallback
 scheduler for CAN hardware
Date: Tue, 22 Oct 2019 09:42:54 -0700
Message-ID: <20191022094254.489fd6a4@hermes.lan>
References: <20190327165632.10711-1-mkl@pengutronix.de>
        <1571750597-14030-1-git-send-email-vincent.prince.fr@gmail.com>
        <84b8ce24-fe5d-ead0-0d1d-03ea24b36f71@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cSZTQjfWRzwB_dzkMRe0vsm"; protocol="application/pgp-signature"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <84b8ce24-fe5d-ead0-0d1d-03ea24b36f71@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Prince <vincent.prince.fr@gmail.com>, jiri@resnulli.us, jhs@mojatatu.com, netdev@vger.kernel.org, dave.taht@gmail.com, linux-can@vger.kernel.org, kernel@pengutronix.de, xiyou.wangcong@gmail.com, davem@davemloft.net
List-Id: linux-can.vger.kernel.org

--Sig_/cSZTQjfWRzwB_dzkMRe0vsm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Oct 2019 16:53:44 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 10/22/19 3:23 PM, Vincent Prince wrote:
> > Signed-off-by: Vincent Prince <vincent.prince.fr@gmail.com> =20
>=20
> please include a patch description. I.e. this one:
>=20
> -------->8-------->8-------->8-------->8-------->8-------->8-------->8---=
----- =20
> There is networking hardware that isn't based on Ethernet for layers 1 an=
d 2.
>=20
> For example CAN.
>=20
> CAN is a multi-master serial bus standard for connecting Electronic Contr=
ol
> Units [ECUs] also known as nodes. A frame on the CAN bus carries up to 8 =
bytes
> of payload. Frame corruption is detected by a CRC. However frame loss due=
 to
> corruption is possible, but a quite unusual phenomenon.
>=20
> While fq_codel works great for TCP/IP, it doesn't for CAN. There are a lo=
t of
> legacy protocols on top of CAN, which are not build with flow control or =
high
> CAN frame drop rates in mind.
>=20
> When using fq_codel, as soon as the queue reaches a certain delay based l=
ength,
> skbs from the head of the queue are silently dropped. Silently meaning th=
at the
> user space using a send() or similar syscall doesn't get an error. However
> TCP's flow control algorithm will detect dropped packages and adjust the
> bandwidth accordingly.
>=20
> When using fq_codel and sending raw frames over CAN, which is the common =
use
> case, the user space thinks the package has been sent without problems, b=
ecause
> send() returned without an error. pfifo_fast will drop skbs, if the queue
> length exceeds the maximum. But with this scheduler the skbs at the tail =
are
> dropped, an error (-ENOBUFS) is propagated to user space. So that the user
> space can slow down the package generation.
>=20
> On distributions, where fq_codel is made default via CONFIG_DEFAULT_NET_S=
CH
> during compile time, or set default during runtime with sysctl
> net.core.default_qdisc (see [1]), we get a bad user experience. In my tes=
t case
> with pfifo_fast, I can transfer thousands of million CAN frames without a=
 frame
> drop. On the other hand with fq_codel there is more then one lost CAN fra=
me per
> thousand frames.
>=20
> As pointed out fq_codel is not suited for CAN hardware, so this patch cha=
nges
> attach_one_default_qdisc() to use pfifo_fast for "ARPHRD_CAN" network dev=
ices.
>=20
> During transition of a netdev from down to up state the default queuing
> discipline is attached by attach_default_qdiscs() with the help of
> attach_one_default_qdisc(). This patch modifies attach_one_default_qdisc(=
) to
> attach the pfifo_fast (pfifo_fast_ops) if the network device type is
> "ARPHRD_CAN".
> -------->8-------->8-------->8-------->8-------->8-------->8-------->8---=
----- =20
>=20
> Marc
>=20

Why not fix fq_codel to return the same errors as other qdisc?

--Sig_/cSZTQjfWRzwB_dzkMRe0vsm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn2/DRbBb5+dmuDyPgKd/YJXN5H4FAl2vMY4ACgkQgKd/YJXN
5H4DEw/6A5WQx5UEkUNdYv9o0hUoXG/XuoK79mLiT+ztPHyshcfn4YnWisakhEIZ
pZrNt9Q5fUWbCZImw4T850QMctZv+hQg5SPne/Zm0NbHKJgxXPcTp78qxLbjw5FT
ehavDlrAsJTTXd+F9E8RQegKPi/PcsBWzdEmT/hq6RhAhhjQQtkm3lVuIfvvLMwb
qf8WU2+iKcAMJGc7pdTDwZNUpfVHZ7bsYVmoE8EGCeaBmB5TrqkObDQhZ9iQ/75B
NWHbU0wcoR1F7IuAHyQm6+vCyDKQqx1tf13izA8ojnl1ZZk782R2iv+3dYgBqlc1
jePIM2I5QfyUhGbzm0Fa/YeYlSC6t51fcuXN8/vl+Gw2+tqfo3QibrGA26mqClHO
RIhrUw0Za8ZMxzvUvbT5wp+HWp8fAAFdxvcElzb2bj60vcxunh/gulg7au7ekE2x
xaXirU3EfHGSU/QxqbiQ+wcraNR7TdnS4IGiRwmIPbhRtWRO/Dn7/saXlm41WmEC
9Xh0DGj2DCptVFZbSpO05m2fIDNex3FzHHh44BfQ6HysHRcbrn8TqPckmmsPGSOw
kWiHwAXf7UMMgI7LmJ6BH015/pItRwAKOTg2iQbWnToA/maDXxMynG0HZUOqNHv+
xzF/1p0YeZy8dI12oQTbArQQwTkWTA70yNBk/iKdppemDcgXa/c=
=8aNr
-----END PGP SIGNATURE-----

--Sig_/cSZTQjfWRzwB_dzkMRe0vsm--
