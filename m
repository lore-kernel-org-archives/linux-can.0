From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] net: sch_generic: Use pfifo_fast as fallback scheduler
 for CAN hardware
Date: Tue, 22 Oct 2019 18:48:56 +0200
Message-ID: <d0d865bd-7bc7-abb5-2b54-2c100c4b9a09@pengutronix.de>
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <1571750597-14030-1-git-send-email-vincent.prince.fr@gmail.com>
 <84b8ce24-fe5d-ead0-0d1d-03ea24b36f71@pengutronix.de>
 <20191022094254.489fd6a4@hermes.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ZGX4thhKU5ySb8F1SQIYPsBtz9A5sBeYZ"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191022094254.489fd6a4@hermes.lan>
Sender: netdev-owner@vger.kernel.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Vincent Prince <vincent.prince.fr@gmail.com>, jiri@resnulli.us, jhs@mojatatu.com, netdev@vger.kernel.org, dave.taht@gmail.com, linux-can@vger.kernel.org, kernel@pengutronix.de, xiyou.wangcong@gmail.com, davem@davemloft.net
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZGX4thhKU5ySb8F1SQIYPsBtz9A5sBeYZ
Content-Type: multipart/mixed; boundary="cJsv4zNEKbGVh1R1bCCefmlaO90Kd3gsf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Vincent Prince <vincent.prince.fr@gmail.com>, jiri@resnulli.us,
 jhs@mojatatu.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 linux-can@vger.kernel.org, kernel@pengutronix.de, xiyou.wangcong@gmail.com,
 davem@davemloft.net
Message-ID: <d0d865bd-7bc7-abb5-2b54-2c100c4b9a09@pengutronix.de>
Subject: Re: [PATCH v2] net: sch_generic: Use pfifo_fast as fallback scheduler
 for CAN hardware
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <1571750597-14030-1-git-send-email-vincent.prince.fr@gmail.com>
 <84b8ce24-fe5d-ead0-0d1d-03ea24b36f71@pengutronix.de>
 <20191022094254.489fd6a4@hermes.lan>
In-Reply-To: <20191022094254.489fd6a4@hermes.lan>

--cJsv4zNEKbGVh1R1bCCefmlaO90Kd3gsf
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 10/22/19 6:42 PM, Stephen Hemminger wrote:
> On Tue, 22 Oct 2019 16:53:44 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 10/22/19 3:23 PM, Vincent Prince wrote:
>>> Signed-off-by: Vincent Prince <vincent.prince.fr@gmail.com> =20
>>
>> please include a patch description. I.e. this one:
>>
>> -------->8-------->8-------->8-------->8-------->8-------->8-------->8=
-------- =20
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
                 ^^^^^^^^^^^^^^^^^
>> user space using a send() or similar syscall doesn't get an error. How=
ever
>> TCP's flow control algorithm will detect dropped packages and adjust t=
he
>> bandwidth accordingly.

> Why not fix fq_codel to return the same errors as other qdisc?

The head drop is the problem. After a send() system call returned to
user space, one would not expect that a later send() will knock an
earlier from the queue.

It's too late to throttle the package generation, as one frame is lost
already.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--cJsv4zNEKbGVh1R1bCCefmlaO90Kd3gsf--

--ZGX4thhKU5ySb8F1SQIYPsBtz9A5sBeYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2vMvgACgkQWsYho5Hk
nSAzwggApHPLYwEg78qvJeyYoQ7Q6601g0Yulhyz3CLoAwyTMppHNesegAYMpfFZ
D+8kMjLi9x2BhRMBujQYNOP9A82JirEYdiPBoTheqWWF1juEU01Z9UrKKRuKHn9A
F1hVrh1EcobK5ymr4+wrsl+XSnmz3V8+ytp+skFVQcjofv0qsTzmK57fTlHe/Hfo
UFhzRsfOw3dksOCQ0vrKy7a491tE68ecLJz6VxmTIZI3CcJeb2UhZqqvTGVSw7fQ
MqyvNgym2Evqvis8Tf2ih298KOvx8GCw/twgcMD9qCc3RaWgdWlZu2mOIJuhxUph
gj6IiYRYHCGVcgLX/hhtf85HMAbhxA==
=DERk
-----END PGP SIGNATURE-----

--ZGX4thhKU5ySb8F1SQIYPsBtz9A5sBeYZ--
