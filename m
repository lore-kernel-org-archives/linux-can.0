From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Fri, 13 Jan 2017 15:25:17 +0100
Message-ID: <b08748c4-ff55-2d7f-ae60-2534e4ac1c0c@pengutronix.de>
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <1180cb22-d2e2-19a4-d0d7-d534dcec6274@hartkopp.net>
 <2a721fb7-38a3-a535-191a-0623742f3645@peak-system.com>
 <a7ca612b-2c62-2a15-7ff0-8791db422647@hartkopp.net>
 <50f5c95a-9978-9b08-8c82-4d3731a6601e@peak-system.com>
 <db248428-c8e8-17ea-20fe-4b8a6548a120@pengutronix.de>
 <bb5c202b-2b8e-8f58-78e0-0027d127b0c1@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="B2S6kG3fmI0iOE4T4KehGB9DSUB58T2LD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51329 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751670AbdAMOZY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2017 09:25:24 -0500
In-Reply-To: <bb5c202b-2b8e-8f58-78e0-0027d127b0c1@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B2S6kG3fmI0iOE4T4KehGB9DSUB58T2LD
Content-Type: multipart/mixed; boundary="1kw5q1rEJTtm768cO6xQ21C8qcfeRk5Le";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <b08748c4-ff55-2d7f-ae60-2534e4ac1c0c@pengutronix.de>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <1180cb22-d2e2-19a4-d0d7-d534dcec6274@hartkopp.net>
 <2a721fb7-38a3-a535-191a-0623742f3645@peak-system.com>
 <a7ca612b-2c62-2a15-7ff0-8791db422647@hartkopp.net>
 <50f5c95a-9978-9b08-8c82-4d3731a6601e@peak-system.com>
 <db248428-c8e8-17ea-20fe-4b8a6548a120@pengutronix.de>
 <bb5c202b-2b8e-8f58-78e0-0027d127b0c1@peak-system.com>
In-Reply-To: <bb5c202b-2b8e-8f58-78e0-0027d127b0c1@peak-system.com>

--1kw5q1rEJTtm768cO6xQ21C8qcfeRk5Le
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2017 03:08 PM, Stephane Grosjean wrote:
> Le 13/01/2017 =C3=A0 14:15, Marc Kleine-Budde a =C3=A9crit :
>> On 01/13/2017 12:45 PM, Stephane Grosjean wrote:
>>> Le 12/01/2017 =C3=A0 17:30, Oliver Hartkopp a =C3=A9crit :
>>>> On 01/12/2017 12:40 PM, Stephane Grosjean wrote:
>>>>
>>>>> There's one potential fix by setting something like an "ECHO" bit t=
o any
>>>>> transmitted frame; The driver rx path will be able to distinguish
>>>>> between these "echoed" frames and the - application - "looped back"=

>>>>> frames, so that the rx stats will be ok.
>>>> That would be cool!
>>>> I remember discussing about a good echo functionality with Philipp.
>>>> Can you also pass some extra data along with the CAN frame down to t=
he
>>>> controller (e.g. to carry an index into the echo skb table?).
>>>>
>>>> Because even when you know that the received frame was echoed, you
>>>> need to got through your saved echo skb list to pick the oldest skb
>>>> for this interface/CAN-ID/mtu combination. This stored skb has to be=

>>>> sent back into the system.
>>>>
>>>> Do not create a new skb for echo'ed skbs! See echo skb handling in d=
ev.c
>>>>
>>> We all agree that the echo skbs array should not be a limitation in t=
he
>>> tx flow, so this should be large enough to save the maximum number of=

>>> CAN frames written, before being obliged to stop the network tx queue=
,
>>> right?
>>>
>>> In the case of this IP core, I'm able to write ~205 (0 data byte) CAN=

>>> frames in the Tx DMA area. Do you see any problem to allocate such a
>>> large array in the can device context?
>> You probably want to limit the on-the-fly TX frames to a sensible
>> number, as it may introduce latencies.
>=20
> I first certainly want to set some correct and acceptable value! ;-)
>=20
> IMHO, the question is "how many frames can be written before getting th=
e=20
> Rx interrupt corresponding to the 1st echoed frame". And since this is =

> cpu dependent, I haven't got any other indication for this number than =

> the above (and too large) estimated maximum value. Any suggestion would=
=20
> be welcome...

Something between like 16 or 32? That's what SoC typically have.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1kw5q1rEJTtm768cO6xQ21C8qcfeRk5Le--

--B2S6kG3fmI0iOE4T4KehGB9DSUB58T2LD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlh4400ACgkQPTuqJayp
JWrvXwf/TX6FSomqMlkh+HkJzB7HP28uK/9vSRKMjAfMH76wxsV5SNJ3B65xpa3b
LUM3BgK3CnWMTO9Pu2Q6Fo3Pl/ODuPeX/JHHqXkUFJF7xqVS9Dqd5x8wAic2fwGH
nIbOF7aXkfYpxUhTWl0uYdFZJfZ1v1EYm7PWoADGw/rIOKiPJYzXqA3tC/ibgFSf
ESWNWiF6lzUi378JZxMLu4OpF720/FcSU9Tr603jOrnT7wD3qComgfWWD49S4ngk
NCXc/LfvAn7RvIFmDpYDUAe6Am17/95yfBY/MD8bs1dygN4ySZlgX6xa0Lii0WDA
IDtUAg9xQpuTh/BW4c+siFlhd9FvKQ==
=jMK6
-----END PGP SIGNATURE-----

--B2S6kG3fmI0iOE4T4KehGB9DSUB58T2LD--
