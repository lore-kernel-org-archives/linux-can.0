From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp based
 irq offloading
Date: Tue, 5 Jul 2016 09:21:14 +0200
Message-ID: <7bb62b19-9bce-8f0d-76b5-81927c05feef@pengutronix.de>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
 <3035212.Yo4Bos9bxC@ws-stein>
 <9e7e6562-3ed5-6807-a178-aa19595191a8@pengutronix.de>
 <20160705083109.1c8d44a8@erd980>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VPOg9xdCaJIkcadnrglOmwrLuwwxNvvg4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51022 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751354AbcGEHVX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 Jul 2016 03:21:23 -0400
In-Reply-To: <20160705083109.1c8d44a8@erd980>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VPOg9xdCaJIkcadnrglOmwrLuwwxNvvg4
Content-Type: multipart/mixed; boundary="0r0GcgL00a4F3oggqr98sWv3OUHgf5q5v"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Jander <david@protonic.nl>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>,
 linux-can@vger.kernel.org
Message-ID: <7bb62b19-9bce-8f0d-76b5-81927c05feef@pengutronix.de>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp based
 irq offloading
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
 <3035212.Yo4Bos9bxC@ws-stein>
 <9e7e6562-3ed5-6807-a178-aa19595191a8@pengutronix.de>
 <20160705083109.1c8d44a8@erd980>
In-Reply-To: <20160705083109.1c8d44a8@erd980>

--0r0GcgL00a4F3oggqr98sWv3OUHgf5q5v
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2016 08:31 AM, David Jander wrote:
> On Tue, 5 Jul 2016 08:19:31 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 07/05/2016 07:46 AM, Alexander Stein wrote:
>>> On Monday 04 July 2016 20:32:07, Marc Kleine-Budde wrote: =20
>>>> Some CAN controllers don't implement a FIFO in hardware, but fill th=
eir
>>>> mailboxes in a particular order (from lowest to highest or highest t=
o
>>>> lowest). This makes problems to read the frames in the correct order=
 from
>>>> the hardware, as new frames might be filled into just read (low) mai=
lboxes.
>>>> This gets worse, when following new frames are received into not rea=
d
>>>> (higher) mailboxes.
>>>>
>>>> On the bright side some these CAN controllers put a timestamp on eac=
h
>>>> received CAN frame. This patch adds support to offload CAN frames in=

>>>> interrupt context, order them by timestamp and then transmitted in a=
 NAPI
>>>> context.
>>>>
>>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de> =20
>>>
>>> How is this supposed to work with CAN controllers without tmestamps, =
e.g.=20
>>> CCAN/DCAN? Do you need to set the timestamp manually using ktime_get(=
) or=20
>>> similar when reading each mailbox? IMHO especially those controllers =
are prone=20
>>> to ordering issues under heavy load as the hardware doesn't ensure or=
dering by=20
>>> itself and there is no hardware based timestamp. =20
>>
>> The algorithm added in this patch only supports controllers that add
>> timestamps to the mailbox on reception in hardware (like flexcan, at91=

>> and hecc). However the other algorithm we implemented didn't make use =
of
>> timestamps and targeted controllers that fill mailboxes in a particula=
r
>> order. It can be ported to the current framework and the c_can/d_can
>> driver to it.
>=20
> I originally wrote order-based FIFO simulation for the flexcan, that di=
dn't
> use the timestamps. It turned out that flexcan has some hardware issues=
 that
> prevented this implementation from working reliably on the flexcan cont=
roller.
> In fact, the whole ordered reception mechanism is useless on flexcan wi=
thout
> timestamps.
> Marc: did you throw away the original implementation for good, or are y=
ou
> planning to add it again, in order to use it for CCAN/DCAN and similar
> controllers?

My focus was on flexcan for now, but the old order-based FIFO simulation
can be ported to the new infrastructure and probably to the c_can/d_can
driver.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0r0GcgL00a4F3oggqr98sWv3OUHgf5q5v--

--VPOg9xdCaJIkcadnrglOmwrLuwwxNvvg4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXe1/qAAoJED07qiWsqSVqa04H/iDWQnjE3pa+B+dDbR037KI9
5yD3vtnBnzmFMu2NlyeWzNo85GJjTtI1xz45gRjtK+UMT5fCRZhOcLobU7HNVVol
Og25pCOpPsGewhJeoe3DjI9qaXn8obSOu5EC/6ugXbsFP9ZrV+a++n+j6kGVaOup
la1IlOnMnHqup1E66tgRJevkhBy/Qiq3BSGl805q0smZat74d8BwuGjJYNCTfDmn
1V9wTXhdApLHFlBbaD5bPoSLol9yoCnjdZAoMT4Kh60d8uNW3U9bIeQcNzkl8s4S
BnrE2GvjHQ5OPgYA65w8hQO8Tw/xJb/JdI0rfj5269a+yUIboL/EJpYU3/np970=
=HXq5
-----END PGP SIGNATURE-----

--VPOg9xdCaJIkcadnrglOmwrLuwwxNvvg4--
