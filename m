From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] net: sch_generic: add flag IFF_FIFO_QUEUE to use
 pfifo_fast as default scheduler
Date: Wed, 27 Mar 2019 21:11:02 +0100
Message-ID: <7a25d800-aed1-bec6-0ff8-38c06c3b8fb5@pengutronix.de>
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <20190327165632.10711-2-mkl@pengutronix.de>
 <CAM_iQpWVOeJ7JNnFyrnvVVimfO=nn4z2FsCGHcDxgeDYQKoYgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="q6VZhPsvsIxZNhfozWL3PZh8kaOmYrAFm"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAM_iQpWVOeJ7JNnFyrnvVVimfO=nn4z2FsCGHcDxgeDYQKoYgQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Linux Kernel Network Developers <netdev@vger.kernel.org>, Dave Taht <dave.taht@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, kernel@pengutronix.de, linux-can@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q6VZhPsvsIxZNhfozWL3PZh8kaOmYrAFm
Content-Type: multipart/mixed; boundary="xjg0BCi14C39uMYDPAuKvLMIbuCUp2G4y";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Dave Taht <dave.taht@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 kernel@pengutronix.de, linux-can@vger.kernel.org,
 David Miller <davem@davemloft.net>
Message-ID: <7a25d800-aed1-bec6-0ff8-38c06c3b8fb5@pengutronix.de>
Subject: Re: [PATCH 1/2] net: sch_generic: add flag IFF_FIFO_QUEUE to use
 pfifo_fast as default scheduler
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <20190327165632.10711-2-mkl@pengutronix.de>
 <CAM_iQpWVOeJ7JNnFyrnvVVimfO=nn4z2FsCGHcDxgeDYQKoYgQ@mail.gmail.com>
In-Reply-To: <CAM_iQpWVOeJ7JNnFyrnvVVimfO=nn4z2FsCGHcDxgeDYQKoYgQ@mail.gmail.com>

--xjg0BCi14C39uMYDPAuKvLMIbuCUp2G4y
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 3/27/19 6:14 PM, Cong Wang wrote:
> On Wed, Mar 27, 2019 at 9:56 AM Marc Kleine-Budde <mkl@pengutronix.de> =
wrote:
>>
>> There is networking hardware that isn't based on Ethernet for layers 1=
 and 2.
>>
>> For example CAN.
>>
>> CAN is a multi-master serial bus standard for connecting Electronic Co=
ntrol
>> Units [ECUs] also known as nodes. A frame on the CAN bus carries up to=
 8 bytes
>> of payload. Frame corruption is detected by a CRC. However frame loss =
due to
>> corruption is possible, but a quite unusual phenomenon.
>>
>> While fq_codel works great for TCP/IP, it doesn't for CAN. There are a=
 lot of
>> legacy protocols on top of CAN, which are not build with flow control =
or high
>> CAN frame drop rates in mind.
>>
>> When using fq_codel, as soon as the queue reaches a certain delay base=
d length,
>> skbs from the head of the queue are silently dropped. Silently meaning=
 that the
>> user space using a send() or similar syscall doesn't get an error. How=
ever
>> TCP's flow control algorithm will detect dropped packages and adjust t=
he
>> bandwidth accordingly.
>>
>> When using fq_codel and sending raw frames over CAN, which is the comm=
on use
>> case, the user space thinks the package has been sent without problems=
, because
>> send() returned without an error. pfifo_fast will drop skbs, if the qu=
eue
>> length exceeds the maximum. But with this scheduler the skbs at the ta=
il are
>> dropped, an error (-ENOBUFS) is propagated to user space. So that the =
user
>> space can slow down the package generation.
>>
>> On distributions, where fq_codel is made default via CONFIG_DEFAULT_NE=
T_SCH
>> during compile time, or set default during runtime with sysctl
>> net.core.default_qdisc (see [1]), we get a bad user experience. In my =
test case
>> with pfifo_fast, I can transfer thousands of million CAN frames withou=
t a frame
>> drop. On the other hand with fq_codel there is more then one lost CAN =
frame per
>> thousand frames.
>>
>> As pointed out fq_codel is not suited for CAN hardware, so this patch
>> introduces a new netdev_priv_flag called "IFF_FIFO_QUEUE" (in contrast=
 to the
>> existing "IFF_NO_QUEUE").
>>
>> During transition of a netdev from down to up state the default queuin=
g
>> discipline is attached by attach_default_qdiscs() with the help of
>> attach_one_default_qdisc(). This patch modifies attach_one_default_qdi=
sc() to
>> attach the pfifo_fast (pfifo_fast_ops) if the "IFF_FIFO_QUEUE" flag is=
 set.
>=20
> I wonder if we just need to allow arbitrary default qdisc per netdevice=

> while you are on it. A private flag is simply a boolean, perhaps in the=

> future other type of devices wants other default qdiscs, so that could
> make it more flexible.

=46rom my point of view there is networking hardware that use protocols
that work with (i.e. benefit from) fq_codel (hash flow/queue/head drop).

The silent head drop is the most prominent reason why it doesn't work on
CAN. I haven't dug deep enough into the code to see if skb->hash is used
or what the flow dissector will do on CAN frames. So reordering of CAN
frames (if something else than skb->priority is used) might be a
problem, too.

=46rom my point of view, if your networking hardware and the protocols on=

top don't like re-ordering or silent head drop, than pfifo_fast is
probably a good default choice.

I discussed the problem a bit at netdev 0x13 and one point someone
mentioned is that if there is a generic set this qdisc function people
might start to add this to network drivers to "optimize" them for their
special workflow or test case.

Doubts aside, how should an arbitrary default qdisc per netdevice look
like? Add a string "default_qdisc" to the netdev? Lookup qdisc by string
during DOWN->UP transition? What do if that qdisc is not compiled into
the kernel? Or rather use an array of qdiscs with one of sch_generic
defaults?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xjg0BCi14C39uMYDPAuKvLMIbuCUp2G4y--

--q6VZhPsvsIxZNhfozWL3PZh8kaOmYrAFm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlyb2NYACgkQWsYho5Hk
nSDTkgf+O47Vm/J3p0yXQFYRp6m1TBBbJw0pMa+52ShLZU1nxP1nA+l/ZhfzMmlw
ZteO6PHpDf37VpCSrAG739v417xxIincVwULGa7aRMMxP/HPqEP7WEaKyRXOAboN
lWfACxOCzAWLcXj/FpOS0OLRA0jN5GI0FY5P6IJIhnXMpGPwniEugO+H+lMcC5bR
Dd9Of0w3WF3nzQrkkjEj+MS/1NBGWiiKvs4xP2ykPGc0piaRO4hk6PL1/i1Rsuen
TvNqG3etEqGecri65W5yPVQ0cBdp8TlM9108hLbpSMlrtLMYTu0bON6vwlnx8nOo
2dDC4hQi4q6RcT+vhIHjxhLwAZlAJg==
=uGS2
-----END PGP SIGNATURE-----

--q6VZhPsvsIxZNhfozWL3PZh8kaOmYrAFm--
