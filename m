From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5/5 v2] can: xilinx_can: fix TX FIFO accounting getting
 out of sync
Date: Wed, 22 Feb 2017 10:11:01 +0100
Message-ID: <2ec7f957-a3e8-ee87-4be6-15816d072e0e@pengutronix.de>
References: <0f108f45-396f-f12f-128a-aa44f61fe547@bitwise.fi>
 <20170213153937.1945-1-anssi.hannula@bitwise.fi>
 <49191a70-f9d3-6082-0e9a-975ca15fa2d9@pengutronix.de>
 <6bc632d8-1654-6e95-08ce-76ac6754cb9d@bitwise.fi>
 <6b7343be-f1ec-86bc-ef0b-2082e8f5c85d@bitwise.fi>
 <3738402f-0cb9-ae02-ecae-41b2dbc9119f@pengutronix.de>
 <67c62965-39d1-c7ac-8b1d-47b52d99c706@bitwise.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Q6LkWM2SRRHMF5aaQeuk30ieHfOlv4vtv"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <67c62965-39d1-c7ac-8b1d-47b52d99c706@bitwise.fi>
Sender: stable-owner@vger.kernel.org
To: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q6LkWM2SRRHMF5aaQeuk30ieHfOlv4vtv
Content-Type: multipart/mixed; boundary="scLwILsdf9AfNBCoGwCGFIpC76fiO2JqJ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>,
 stable@vger.kernel.org
Message-ID: <2ec7f957-a3e8-ee87-4be6-15816d072e0e@pengutronix.de>
Subject: Re: [PATCH 5/5 v2] can: xilinx_can: fix TX FIFO accounting getting
 out of sync
References: <0f108f45-396f-f12f-128a-aa44f61fe547@bitwise.fi>
 <20170213153937.1945-1-anssi.hannula@bitwise.fi>
 <49191a70-f9d3-6082-0e9a-975ca15fa2d9@pengutronix.de>
 <6bc632d8-1654-6e95-08ce-76ac6754cb9d@bitwise.fi>
 <6b7343be-f1ec-86bc-ef0b-2082e8f5c85d@bitwise.fi>
 <3738402f-0cb9-ae02-ecae-41b2dbc9119f@pengutronix.de>
 <67c62965-39d1-c7ac-8b1d-47b52d99c706@bitwise.fi>
In-Reply-To: <67c62965-39d1-c7ac-8b1d-47b52d99c706@bitwise.fi>

--scLwILsdf9AfNBCoGwCGFIpC76fiO2JqJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 05:07 PM, Anssi Hannula wrote:
> On 21.2.2017 17:14, Marc Kleine-Budde wrote:
>> On 02/21/2017 03:57 PM, Anssi Hannula wrote:
>>> On 20.2.2017 12:27, Anssi Hannula wrote:
>>>> On 20.2.2017 11:42, Marc Kleine-Budde wrote:
>>>>> On 02/13/2017 04:39 PM, Anssi Hannula wrote:
>>>>>> The xilinx_can driver assumes that the TXOK interrupt only clears =
after
>>>>>> it has been acknowledged as many times as there have been successf=
ully
>>>>>> sent frames.
>>>>>>
>>>>>> However, the documentation does not mention such behavior, instead=

>>>>>> saying just that the interrupt is cleared when the clear bit is se=
t.
>>>>>>
>>>>>> Similarly, testing seems to also suggest that it is immediately cl=
eared
>>>>>> regardless of the amount of frames having been sent. Performing so=
me
>>>>>> heavy TX load and then going back to idle has the tx_head drifting=

>>>>>> further away from tx_tail over time, steadily reducing the amount =
of
>>>>>> frames the driver keeps in the TX FIFO (but not to zero, as the TX=
OK
>>>>>> interrupt always frees up space for 1 frame from the driver's
>>>>>> perspective, so frames continue to be sent) and delaying the local=
 echo
>>>>>> frames.
>>>>>>
>>>>>> The TX FIFO tracking is also otherwise buggy as it does not accoun=
t for
>>>>>> TX FIFO being cleared after software resets, causing
>>>>>>   BUG!, TX FIFO full when queue awake!
>>>>>> messages to be output.
>>>>>>
>>>>>> Since there does not seem to be any way to accurately track the st=
ate of
>>>>>> the TX FIFO, drop the code trying to do that and perform
>>>>>> netif_stop_queue() based on whether the HW reports the FIFO being =
full.
>>>>>> Driver-side local echo support is also removed as it is not possib=
le to
>>>>>> do accurately (relying instead on the CAN core fallback support).
>>>>>>
>>>>>> Tested with the integrated CAN on Zynq-7000 SoC.
>>>>>>
>>>>>> v2: Add FIFO space check before TX queue wake with locking to
>>>>>> synchronize with queue stop. This avoids waking the queue when xmi=
t()
>>>>>> had just filled it.
>>>>> Removing the echo on TX-complete should be avoided if possible. Is =
there
>>>>> a way to get a indication that an individual package has been send?=

>>>> Looking at the reference manual [1, chapter 18 and appendix B.5] I c=
an't
>>>> see any. The TX FIFO interrupts and status registers available are T=
XOK
>>>> (1 or more messages sent), FIFO empty, FIFO full, FIFO under waterma=
rk
>>>> (watermark not programmable while on-bus). There is no FIFO free spa=
ce
>>>> counter that I can see.
>>>>
>>>> One way would be to only put a single frame into the FIFO at a time,=
 of
>>>> course, but at least to me that seems worse than losing echo-on-TX-c=
omplete.
>>> A correction to my last statement above, we could probably put up to =
3
>>> frames in TX FIFO at a time and still keep track of them using the TX=

>>> FIFO watermark, allowing echo-on-TX-complete to still be supported, w=
ith
>>> something like this:
>>> if (tx fifo empty)
>>>    all frames sent;
>>> else if (tx fifo under watermark 2)
>>>    all except 1 frame sent;
>>> else if (txok)
>>>   1 frame sent; (all except 2)
>>>
>>> Though 3 is still much less than 64, the current TX FIFO max size.
>> Sounds good, can you work on a patch?
>=20
> Unfortunately I've just noticed that the soft-IP version of the
> controller (compatible-string "xlnx,axi-can-1.00.a" instead of
> "xlnx,zynq-can-1.0" found on Zynq SoCs) does not have the TX FIFO empty=

> bit nor the watermark programming feature:
> https://www.xilinx.com/support/documentation/ip_documentation/can/v5_0/=
pg096-can.pdf
>=20
> So the above idea for tracking more than 1 frame in FIFO would not work=

> on those.
>=20
> What do you think should be done here?

Depending on the compatible string we know that max usable FIFO size.
You can upgrade the driver to cope with this.

The xmit function doesn't change at all:

> 	/* Check if the TX buffer is full */
> 	if ((priv->tx_head - priv->tx_tail) =3D=3D priv->tx_max)
> 		netif_stop_queue(ndev);

Just the calculation of priv->tx_max changes depending on the compatible.=


The loop in xcan_tx_interrupt() get more complicated.

If this works, we can discuss on a property (maybe DT) to switch the
driver into "non"-IFF_ECHO mode, as you proposed in your original patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--scLwILsdf9AfNBCoGwCGFIpC76fiO2JqJ--

--Q6LkWM2SRRHMF5aaQeuk30ieHfOlv4vtv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlitVaUACgkQHv7KIOw4
HPZXtgf/csDfZMA350RJGIiUwNNvQur36a7ntCka7PSYdZclzKCKOSCF8s/pfLUl
yFt9oV5j2mQWANQi6G/am9C4wj0huEfSAMVvG0d/0X1oxX923/qrZjbHX32iUCW/
GWwOp56tV7nDWr6T0Q4xKCqMylYpOepesJvC60iY/YNjVB5PUz5jUJnN7xSTjIIa
1KwJDUr04ZnL3ijprA3fEaSxTQsLXYRGEoAP192+uzMLkPyrz9/Pq2joEK808qH4
P+y0wuInpLBZZOf1vL3mMwi/rr1GmHxkhiVJbDFya1z+VR/lGdcTBO74TvL/gnnE
bcvaOlND6+KI46aacsFAvFsV3huTmA==
=uXF6
-----END PGP SIGNATURE-----

--Q6LkWM2SRRHMF5aaQeuk30ieHfOlv4vtv--
