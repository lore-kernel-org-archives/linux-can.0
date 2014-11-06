From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 11/15] can: rx-fifo: Add support for can state tracking
 and error polling
Date: Thu, 06 Nov 2014 11:20:23 +0100
Message-ID: <545B4B67.80300@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>	<1412956020-21489-12-git-send-email-david@protonic.nl>	<545765D8.7090906@pengutronix.de>	<20141103135135.10fd4c6f@archvile>	<54577C03.7010609@pengutronix.de>	<20141103140921.4ffd55e7@archvile>	<5457822B.5090200@pengutronix.de> <20141105181612.569be441@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TgaTeN0O9GVNRJ9QiPAT7exSvWxTFwx3x"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38521 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbaKFKsW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 05:48:22 -0500
In-Reply-To: <20141105181612.569be441@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TgaTeN0O9GVNRJ9QiPAT7exSvWxTFwx3x
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/05/2014 06:16 PM, David Jander wrote:
> On Mon, 03 Nov 2014 14:24:59 +0100
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 11/03/2014 02:09 PM, David Jander wrote:
>>> On Mon, 03 Nov 2014 13:58:43 +0100
>>> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>
>>>> On 11/03/2014 01:51 PM, David Jander wrote:
>>>>>> On 10/10/2014 05:46 PM, David Jander wrote:
>>>>>>> The interrupt handler should store the error flags if needed and =
call
>>>>>>> can_rx_fifo_irq_error() if there was an error flag set. This will=

>>>>>>> trigger a napi-poll that will call poll_can_state() and
>>>>>>> poll_bus_error() callbacks. Those should handle can state machine=
 and
>>>>>>> send error frames as needed.
>>>>>>>
>>>>>>> Signed-off-by: David Jander <david@protonic.nl>
>>>>>>> ---
>>>>>>>  drivers/net/can/dev.c   | 23 ++++++++++++++++++++---
>>>>>>>  include/linux/can/dev.h |  9 +++++++++
>>>>>>>  2 files changed, 29 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>>>>>>> index fc35d28..dac7579 100644
>>>>>>> --- a/drivers/net/can/dev.c
>>>>>>> +++ b/drivers/net/can/dev.c
>>>>>>> @@ -352,6 +352,9 @@ static int can_rx_fifo_napi_poll(struct napi_=
struct
>>>>>>> *napi, int quota) unsigned int tail;
>>>>>>> =20
>>>>>>>  restart_poll:
>>>>>>> +	if (work_done < quota)
>>>>>>> +		work_done +=3D fifo->poll_can_state(fifo);
>>>>>>> +
>>>>>>
>>>>>> Do we need two callbacks in the poll-loop? I think one should be e=
nough.
>>>>>> The driver can call as many non-rx related functions as needed the=
n.
>>>>>> E.g. state change, bus error handling, tx-completion handling, etc=
=2E..
>>>>>
>>>>> Ok. I split it into two handlers, because I saw most drivers doing =
first
>>>>> state-handling then message reception and last error handling... in=
 this
>>>>> particular order. If that order is not important, we can use one po=
ll()
>>>>> function for both state- and error-handling.
>>>>> In that case... should the poll() handler be called _before_ or _af=
ter_
>>>>> handling the mailboxes?
>>>>
>>>> Following the general rule zero-one-infinity ("Allow none of foo, on=
e of
>>>> foo, or any number of foo" [1]) one callback should be fine. As we a=
re
>>>> optimizing for not loosing RX CAN frames I tend to say it should com=
e
>>>> after rx.
>>>
>>> Hahaha, ok, I got it :)
>>> Any idea on how to call this function? Just "poll" seems a little bit=

>>> under-documented...
>>
>> Yes, what about extra_poll, poll_extra?
>=20
> Oops. I just realized this isn't so easy... nor is this really a
> zero-one-infinity case. On top of that the solution will get quite ugly=
 too:
>=20
> poll_can_state() and poll_bus_error() have two distinct functions and _=
both_
> can generate a (error-) CAN frame. If I consolidate this into just one
> handler, that handler could potentially generate 0, 1 or 2 CAN frames, =
so I'd
> be forced to introduce an extra parameter to keep track of NAPI quota i=
nside
> the driver callback! This seems quite ugly to me, don't you think?

What about:
    work_done +=3D fifo->poll_error(fifo, quota - work_done);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--TgaTeN0O9GVNRJ9QiPAT7exSvWxTFwx3x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUW0tuAAoJECte4hHFiupUTikP/R7U89/ygtJikH/aniEqWvPw
IBu1GfVuXUILKH4trexblAza7Lzg3uY3VBU75s62s+1CpEns0PZkUW+rdmloXMcD
V9fdIWyYsEiHuN3kMlAo42bNd7+6yjn09BRkzQ8QhWNkOw2gs99HDQu9BQ69IBvW
GvmPMZOvz1TXcVIx7vNbSFXW+bceyuMoZkJAyhNIYNn1ab0z+UdDUAGe50VJJnWh
cjbKswj89WSP0JYA+Qq0tADJMXj+lCoUDZ0Xy4VFrc+z1IV+m0L7yKsCCoHaeNU4
D7j9KyQBgQp9a8oeLOQYIhkWyRlJyab2iPzAxtICg9aaqPqyyZL8wnAJLx5+b5r8
I0e1+bqXQvmdhyiKJ/uQ/MEDIG71nLXqimZ1IyuT1gj4CN3td3N2N+N3WiizHIfz
MBqNAzZ/0XRRqZ/qlQNYrNUYYO6985z5FQOmepqTqEplDohEDBZR1PLBs6HNf3qV
I4eL47kRC1cXkxlJb0ZGGxzGYkLU9YVmGlRIh0xLOn5gbKf3QrilDOXw3bHcjZAk
MXc3ylqOypEr/2xzcNFqI+/kU9lYQdJ38OUA1CV0bWTjg0oV3Q7XO19a6HZ4qGcE
aNcuYAWjqv7ob8UVRwDiP/tufCSIVCAcDvqmX2fZtNbiqoTaF1I33IJk4rNWuUyQ
WO0lVbJjPvi/wiIKytOH
=af+L
-----END PGP SIGNATURE-----

--TgaTeN0O9GVNRJ9QiPAT7exSvWxTFwx3x--
