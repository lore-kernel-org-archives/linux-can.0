From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5/5 v2] can: xilinx_can: fix TX FIFO accounting getting
 out of sync
Date: Tue, 21 Feb 2017 16:14:15 +0100
Message-ID: <3738402f-0cb9-ae02-ecae-41b2dbc9119f@pengutronix.de>
References: <0f108f45-396f-f12f-128a-aa44f61fe547@bitwise.fi>
 <20170213153937.1945-1-anssi.hannula@bitwise.fi>
 <49191a70-f9d3-6082-0e9a-975ca15fa2d9@pengutronix.de>
 <6bc632d8-1654-6e95-08ce-76ac6754cb9d@bitwise.fi>
 <6b7343be-f1ec-86bc-ef0b-2082e8f5c85d@bitwise.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jR4KMwS8Dfdrl4Hp7ur1AqHVmncDul6I0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54707 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750951AbdBUPOY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Feb 2017 10:14:24 -0500
In-Reply-To: <6b7343be-f1ec-86bc-ef0b-2082e8f5c85d@bitwise.fi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>, stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jR4KMwS8Dfdrl4Hp7ur1AqHVmncDul6I0
Content-Type: multipart/mixed; boundary="SGax6K9kB3M8KrSwepnpEx9vEt2EMAGQF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>,
 stable@vger.kernel.org
Message-ID: <3738402f-0cb9-ae02-ecae-41b2dbc9119f@pengutronix.de>
Subject: Re: [PATCH 5/5 v2] can: xilinx_can: fix TX FIFO accounting getting
 out of sync
References: <0f108f45-396f-f12f-128a-aa44f61fe547@bitwise.fi>
 <20170213153937.1945-1-anssi.hannula@bitwise.fi>
 <49191a70-f9d3-6082-0e9a-975ca15fa2d9@pengutronix.de>
 <6bc632d8-1654-6e95-08ce-76ac6754cb9d@bitwise.fi>
 <6b7343be-f1ec-86bc-ef0b-2082e8f5c85d@bitwise.fi>
In-Reply-To: <6b7343be-f1ec-86bc-ef0b-2082e8f5c85d@bitwise.fi>

--SGax6K9kB3M8KrSwepnpEx9vEt2EMAGQF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 03:57 PM, Anssi Hannula wrote:
> On 20.2.2017 12:27, Anssi Hannula wrote:
>> On 20.2.2017 11:42, Marc Kleine-Budde wrote:
>>> On 02/13/2017 04:39 PM, Anssi Hannula wrote:
>>>> The xilinx_can driver assumes that the TXOK interrupt only clears af=
ter
>>>> it has been acknowledged as many times as there have been successful=
ly
>>>> sent frames.
>>>>
>>>> However, the documentation does not mention such behavior, instead
>>>> saying just that the interrupt is cleared when the clear bit is set.=

>>>>
>>>> Similarly, testing seems to also suggest that it is immediately clea=
red
>>>> regardless of the amount of frames having been sent. Performing some=

>>>> heavy TX load and then going back to idle has the tx_head drifting
>>>> further away from tx_tail over time, steadily reducing the amount of=

>>>> frames the driver keeps in the TX FIFO (but not to zero, as the TXOK=

>>>> interrupt always frees up space for 1 frame from the driver's
>>>> perspective, so frames continue to be sent) and delaying the local e=
cho
>>>> frames.
>>>>
>>>> The TX FIFO tracking is also otherwise buggy as it does not account =
for
>>>> TX FIFO being cleared after software resets, causing
>>>>   BUG!, TX FIFO full when queue awake!
>>>> messages to be output.
>>>>
>>>> Since there does not seem to be any way to accurately track the stat=
e of
>>>> the TX FIFO, drop the code trying to do that and perform
>>>> netif_stop_queue() based on whether the HW reports the FIFO being fu=
ll.
>>>> Driver-side local echo support is also removed as it is not possible=
 to
>>>> do accurately (relying instead on the CAN core fallback support).
>>>>
>>>> Tested with the integrated CAN on Zynq-7000 SoC.
>>>>
>>>> v2: Add FIFO space check before TX queue wake with locking to
>>>> synchronize with queue stop. This avoids waking the queue when xmit(=
)
>>>> had just filled it.
>>> Removing the echo on TX-complete should be avoided if possible. Is th=
ere
>>> a way to get a indication that an individual package has been send?
>> Looking at the reference manual [1, chapter 18 and appendix B.5] I can=
't
>> see any. The TX FIFO interrupts and status registers available are TXO=
K
>> (1 or more messages sent), FIFO empty, FIFO full, FIFO under watermark=

>> (watermark not programmable while on-bus). There is no FIFO free space=

>> counter that I can see.
>>
>> One way would be to only put a single frame into the FIFO at a time, o=
f
>> course, but at least to me that seems worse than losing echo-on-TX-com=
plete.
>=20
> A correction to my last statement above, we could probably put up to 3
> frames in TX FIFO at a time and still keep track of them using the TX
> FIFO watermark, allowing echo-on-TX-complete to still be supported, wit=
h
> something like this:
> if (tx fifo empty)
>    all frames sent;
> else if (tx fifo under watermark 2)
>    all except 1 frame sent;
> else if (txok)
>   1 frame sent; (all except 2)
>=20
> Though 3 is still much less than 64, the current TX FIFO max size.

Sounds good, can you work on a patch?

> I'd myself prefer keeping full FIFO over keeping echo-on-TX-complete,
> but not sure what is the general opinion.

Big FIFOs have the drawback of bigger latencies, as you cannot reorder
high priority packages inside the kernel.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SGax6K9kB3M8KrSwepnpEx9vEt2EMAGQF--

--jR4KMwS8Dfdrl4Hp7ur1AqHVmncDul6I0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlisWUcACgkQHv7KIOw4
HPaLCQgAzcgC2Kh34AJdJQlpyXyG3EErSrl5KWgGmjEUAKslyHFzuVeirOoQtebd
R2qDx7xmJ3DWi9RbWISwBaIJ0A6v/MqnPYi6VA9DVGr732Qk4kTDkCK8s35uf/aY
pFSTetRAMg0CX680uCzzKoGzDuZqD8RpLGveR8odNQgZm62cXKly2+BLWHfyhcAY
Uz9zvqn1sk4ZdE6VaHMRBpYPziBjAg5tpXpUegzOH9QiYzUmEkJTfd6yY2iZAlIf
5E1QWlfzKVf06pnkJpH+QF12XbeUn0FoLR/ffBbbSPJKM/R6y+9BZX59xUpMrsba
5Mqw3SfecFu3DRu08+mKhX3l1QbvVw==
=Irug
-----END PGP SIGNATURE-----

--jR4KMwS8Dfdrl4Hp7ur1AqHVmncDul6I0--
