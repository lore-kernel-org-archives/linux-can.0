From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] net: sch_generic: add flag IFF_FIFO_QUEUE to use
 pfifo_fast as default scheduler
Date: Wed, 27 Mar 2019 20:27:51 +0100
Message-ID: <a3deee8b-f1de-a9f2-339f-523022c502e6@pengutronix.de>
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <20190327165632.10711-2-mkl@pengutronix.de>
 <20190327185332.s3cq6ttscyk7234v@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2w8mUSPIHG1MHRq714Bgq4jmpYYNj8uvE"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190327185332.s3cq6ttscyk7234v@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Dave Taht <dave.taht@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, kernel@pengutronix.de, Cong Wang <xiyou.wangcong@gmail.com>, linux-can@vger.kernel.org, davem@davemloft.net
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2w8mUSPIHG1MHRq714Bgq4jmpYYNj8uvE
Content-Type: multipart/mixed; boundary="rSQWSJ8Rfmi2EJ3IM04ej2BiTmPuc87Cc";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Dave Taht <dave.taht@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 kernel@pengutronix.de, Cong Wang <xiyou.wangcong@gmail.com>,
 linux-can@vger.kernel.org, davem@davemloft.net
Message-ID: <a3deee8b-f1de-a9f2-339f-523022c502e6@pengutronix.de>
Subject: Re: [PATCH 1/2] net: sch_generic: add flag IFF_FIFO_QUEUE to use
 pfifo_fast as default scheduler
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <20190327165632.10711-2-mkl@pengutronix.de>
 <20190327185332.s3cq6ttscyk7234v@pengutronix.de>
In-Reply-To: <20190327185332.s3cq6ttscyk7234v@pengutronix.de>

--rSQWSJ8Rfmi2EJ3IM04ej2BiTmPuc87Cc
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 3/27/19 7:53 PM, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Mar 27, 2019 at 05:56:31PM +0100, Marc Kleine-Budde wrote:
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
>=20
> s/package/packet/ here and in a few more locations in this commit log.

Thanks, fixed.

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
>>
>> [1] https://github.com/systemd/systemd/issues/9194
>>
>> Cc: Dave Taht <dave.taht@gmail.com>
>> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
>> Cc: Cong Wang <xiyou.wangcong@gmail.com>
>> Cc: Jiri Pirko <jiri@resnulli.us>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  include/linux/netdevice.h | 3 +++
>>  net/sched/sch_generic.c   | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 166fdc0a78b4..1867e27e3369 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -1498,6 +1498,7 @@ struct net_device_ops {
>>   * @IFF_FAILOVER: device is a failover master device
>>   * @IFF_FAILOVER_SLAVE: device is lower dev of a failover master devi=
ce
>>   * @IFF_L3MDEV_RX_HANDLER: only invoke the rx handler of L3 master de=
vice
>> + * @IFF_FIFO_QUEUE: device must run with FIFO qdisc attached. skb dro=
p without NET_XMIT_DROP is fatal
>=20
> Do you need the FIFO property or only that the qdisc doesn't silently
> drop packets? I don't know which other qdiscs are around, but depending=

> on the answer to this question other than pfifo_fast might be suitable?=


No silent dropping is mandatory. No reordering of outgoing packets (if
not configured to do so) is mandatory.

Maybe there are other qdiscs that work on CAN, but pfifo_fast is a sane
default.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rSQWSJ8Rfmi2EJ3IM04ej2BiTmPuc87Cc--

--2w8mUSPIHG1MHRq714Bgq4jmpYYNj8uvE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlybzrcACgkQWsYho5Hk
nSDBcgf/YFGrVj1sbkkBHg9BRRsrwtXpULbxPfyIKnowudDefwjSpoIUaVuSuHAZ
z1F+ZVapUor2ODsjmVWvUJ5hLpHw6hhojDxlHOwZl9l6jfIdnTdpfQykUpKixZQM
lCLBekR3MYUeSLq65yxcyyflyF47UO//+501GQw9Dd2vIpSKtFzDTy8tK1D3sVaJ
/Un2ta36y+ltR/F0iwCWIl69ZV+BgrkHcSpA1KVZ1DVf4XDxfNlXqWNgwKjStEHs
RA1I4HbaHcXZbkCQ/yQutnK/PpFM1GVPCELPoh/7VbRNqg5yf5Y87odovkEX6eVQ
BmNHQM5mHUTw9qXrq+xy+iNb8fpkyA==
=YPiT
-----END PGP SIGNATURE-----

--2w8mUSPIHG1MHRq714Bgq4jmpYYNj8uvE--
